/* Make sure $ is the right thing, because we also load prototype */
$ = jQuery;

var navigator = {
  navpanewidth: 249,

  navmap_browser: '115,0, 195,0, 210,15, 125,15, 115,5',
  navmap_book: '0,0, 110,0, 114,4, 114,15, 0,15',

  pending_browser: [],
  pending_book: [],

  make_navpane: function (tab) {
    img = new Image ();
    img.src = '/mathematicaImages/navhead-browser.png';
    img = new Image ();
    img.src = '/mathematicaImages/navhead-book.png';

    this.linktrail = $('div.LinkTrailHolder');
    this.maintabs = $('div.FlShdBar, div.guideTable, div.MainRoot');
    this.flt = this.maintabs.find ('div.Flt');

    this.linktrail_margin = parseInt (this.linktrail.css ('margin-left'));
    this.flt_left = parseInt (this.flt.css ('left'));
    this.maintabs_margin = this.maintabs.css ('margin-left');
    if (this.maintabs_margin == 'auto')
      this.maintabs_margin = 0;
    else
      this.maintabs_margin = parseInt (this.maintabs_margin);

    this.slide_right ();

    var navpane = $('<div id="NavigatorPane"></div>');
    navpane.hide()
    $('body').append(navpane);
    this.navpane = $('#NavigatorPane');
    this.navpane.html (
      '<div id="TabBar"></div>' +
      '<map name="navmap_browser">' +
      '<area shape="poly" coords="' + this.navmap_browser + '"' +
      ' href="javascript:navigator.open(\'book\')" alt="Virtual Book">' +
      '</map>' +
      '<map name="navmap_book">' +
      '<area shape="poly" coords="' + this.navmap_book + '"' +
      ' href="javascript:navigator.open(\'browser\')" alt="Function Browser">' +
      '</map>' +
      '<div id="NavigatorOuter"><div id="NavigatorInner">' +
      '<div id="NavigatorScroll"></div></div></div>');
    this.navpane.css ({
      top: this.maintabs.eq(0).offset().top - 16,
      width: this.navpanewidth - 1
    });
    this.navscroll = $('#NavigatorScroll');
    this.navscroll.css('height', 500);

    for (var j = 0; j < 2; j++) {
      if (j == 0) {
        divname = 'BrowserDiv';
        tabname = 'browser';
        data = FunctionBrowserData;
      } else {
        divname = 'BookDiv';
        tabname = 'book';
        data = VirtualBookData;
      }

      var innerdiv = $('<div></div>');
      innerdiv.attr ('id', divname);
      var childids = data[0].children;
      for (var i = 0; i < childids.length; i++) {
        var childid = childids[i];
        var childdata = data[childid];
        var childdiv = navigator.assemble_link (tabname, childid, 'Level1', childdata);
        if (tabname == 'browser')
          $.ajax({
            url: '/mathematica/FunctionBrowser' + childid + '.js',
            dataType: 'json',
            success: function (cdata) {
              FunctionBrowserData = $.extend (FunctionBrowserData, cdata);
              var pen = 0;
              while (pen < navigator.pending_browser.length) {
                var penid = navigator.pending_browser[pen]
                if (FunctionBrowserData[penid] != undefined) {
                  navigator.pending_browser.splice (pen, 1);
                  navigator.open_section ('browser', penid, true, true);
                } else {
                  pen++;
                }
              }
          } });
        else
          $.ajax({
            url: '/mathematica/VirtualBook' + childid + '.js',
            dataType: 'json',
            success: function (cdata) {
              VirtualBookData = $.extend (VirtualBookData, cdata);
              var pen = 0;
              while (pen < navigator.pending_book.length) {
                var penid = navigator.pending_book[pen]
                if (VirtualBookData[penid] != undefined) {
                  navigator.pending_book.splice (pen, 1);
                  navigator.open_section ('book', penid, true, true);
                } else {
                  pen++;
                }
              }
          } });
        innerdiv.append(childdiv);
      }
      if (tab != tabname)
        innerdiv.hide ();
      this.navscroll.append (innerdiv);
    }

    this.set_tab (tab);
    if ($('#GuideContentTable').length > 0)
      $('#NavigatorOuter').css('border-top', '4px solid #df6600');
    else if ($('#TutorialContentTable, #TutorialOverviewTable').length > 0)
      $('#NavigatorOuter').css('border-top', '4px solid #b23600');
    else
      $('#NavigatorOuter').css('border-top', '4px solid #7B84D3');
    this.navpane.show ();
    navigator.scroll_init();
  },

  set_tab: function (tab) {
    tabbar = $('#TabBar');
    tabbar.empty ();
    if (tab == 'browser')
      tabbar.html (
        '<img src="/mathematicaImages/navhead-browser.png" width="248" height="18" usemap="#navmap_browser">');
    else
      tabbar.html (
        '<img src="/mathematicaImages/navhead-book.png" width="248" height="18" usemap="#navmap_book">');
  },

  scroll_init: function () {
    this.navscroll.jScrollPane ({
      scrollbarWidth: 8,
      showArrows: true,
      arrowSize: 10,
      wheelSpeed: 30
    });
  },

  slide_right: function () {
    this.linktrail.css({ marginLeft: this.linktrail_margin + this.navpanewidth + 10 });
    this.flt.css({ left: this.flt_left + this.navpanewidth + 10 });
    this.maintabs.css({ marginLeft: this.maintabs_margin + this.navpanewidth + 10 });
  },

  slide_left: function () {
    this.linktrail.css({ marginLeft: this.linktrail_margin });
    this.flt.css({ left: this.flt_left });
    this.maintabs.css({ marginLeft: this.maintabs_margin });
  },

  open: function (tab, id) {
    if (!this.navpane)
      this.make_navpane (tab);
    else
      this.set_tab (tab);
    this.active = tab;
    var browserdiv = $('#BrowserDiv');
    var bookdiv = $('#BookDiv');
    if (tab == 'browser') {
      browserdiv.show ();
      bookdiv.hide ();
      this.scroll_init ();
      var thisdiv = browserdiv;
    } else {
      browserdiv.hide();
      bookdiv.show();
      this.scroll_init ();
      var thisdiv = bookdiv;
    }

    $('a').click(function () {
      var href = $(this).attr('href');
      if (navigator.active && href.substring(0, 1) == '/') {
        href = href + '?' + navigator.active + '=0';
        window.location = href;
        return false;
      } else {
        return true;
      }
    });

    if (id)
      navigator.open_section (tab, id, true, true);
    navigator.slide_right ();
    navigator.navpane.show();
  },

  close: function () {
    this.active = undefined;
    this.slide_left ();
    this.navpane.hide ();
  },

  toggle: function (tab, id) {
    if (this.active == tab) {
      this.close ();
    } else {
      this.open (tab, id);
    }
  },

  toggle_section: function (tab, id) {
    var node = $('#' + tab + 'node' + id);
    var content = node.children ('div.Content');
    if (content.length == 0 || content.is (':hidden')) {
      navigator.open_section (tab, id, false, false);
    } else {
      content.slideUp (20, function () { navigator.scroll_init(); });
    }
  },

  open_section: function (tab, id, parents, scroll) {
    if (tab == 'browser') {
      var data = FunctionBrowserData;
      if (data[id] == undefined) {
        navigator.pending_browser.push (id);
        return;
      }
    } else {
      var data = VirtualBookData;
      if (data[id] == undefined) {
        navigator.pending_book.push (id);
        return;
      }
    }

    if (parents) {
      var parid = data[id].parent;
      if (parid != 0)
        navigator.open_section (tab, parid, true, false);
    }
    var node = $('#' + tab + 'node' + id);
    if (node.length == 0)
      return;
    if (data[id].type == 'node') {
      var content = node.children('div.Content');
      if (content.length == 0) {
        var level = node.attr('class');
        var newlevel = (parseInt (level.replace (/^Level/, '')) + 1);
        var childids = data[id].children;
        content = $('<div class="Content"></div>');
        for (var i = 0; i < childids.length; i++) {
          var childid = childids[i];
          if (childid == 0) {
            var childdiv = $('<div class="Delimiter"></div>');
            childdiv.append ($('<hr class="Delimiter">'));
          } else {
            var childdata = data[childid];
            if (childdata.type == 'node')
              var childlevel = 'Level' + newlevel;
            else
              var childlevel = 'Leaf' + newlevel;
            var childdiv = navigator.assemble_link (tab, childid, childlevel, childdata);
          }
          content.append (childdiv);
        }
        content.hide();
        node.append (content);
      }
      content.slideDown (20, function () { navigator.scroll_init(); });
    }
    if (scroll) {
      setTimeout(function () { nav_scroll(node); }, 60);
    }
  },

  assemble_link: function (tab, id, cls, data) {
    var nodediv = $('<div></div>')
    nodediv.attr('class', cls);
    nodediv.attr('id', tab + 'node' + id);
    var headdiv = $('<div></div>')
    headdiv.attr('class', 'Head');
    nodediv.append(headdiv);

    var dingbat = $('<span></span>');
    dingbat.attr('class', 'Dingbat');
    if (data.type == 'node') {
      var dingbat_a = $('<a></a>');
      dingbat_a.attr('href',
        'javascript:navigator.toggle_section ("' + tab + '","' + id + '")');
      var dingbat_img = $('<img>');
      dingbat_img.attr ('src', '../images/mathematicaImages/closedGroup.gif');
      dingbat_a.append (dingbat_img);
      dingbat.append (dingbat_a);
      var nodelink = $('<a></a>');
      nodelink.attr ('class', 'NavigatorNodeLink');
      nodelink.attr ('href',
        'javascript:navigator.toggle_section ("' + tab + '","' + id + '")');
      headdiv.append (dingbat);
      headdiv.append (' ');
      nodelink.append (data.title);
      headdiv.append (nodelink);
      if (data.href != undefined) {
        var pagelink = $('<a></a>');
        pagelink.attr ('class', 'NavigatorPageLink');
        pagelink.attr ('href',
          'javascript:nav_open("/mathematica/' + data.href + '.html?' + tab + '=' + id + '")');
        pagelink.html ('***');
        headdiv.hover (
          function () {
            $(this).find ('.NavigatorPageLink').show ();
          },
          function () {
            $(this).find ('.NavigatorPageLink').hide ();
          });
        headdiv.append (' ');
        headdiv.append (pagelink);
      }
    } else {
      dingbat.append ('&bull;');
      var nodelink = $('<a></a>');
      nodelink.attr ('class', 'NavigatorLink');
      nodelink.attr ('href',
        'javascript:nav_open("/mathematica/' + data.href + '.html?' + tab + '=' + id + '")');
      headdiv.append (dingbat);
      headdiv.append (' ');
      nodelink.append (data.title);
      headdiv.append (nodelink);
    }

    return nodediv;
  }
}

$(document).ready(function () {
  $('head').append($('<link rel="stylesheet" type="text/css" href="../css/Navigator.css">'));
  $('head').append($('<link rel="stylesheet" type="text/css" href="../css/jScrollPane.css">'));
  var tab = $('table.siteNavigationTable');
  if (tab.length > 0) {
    var div = $('<div class="NavigatorStubs"></div>');

    var link = $('<a></a>');
    link.attr('href', "javascript:nav_make('ref/Fold')");
    link.text('NavigatorWindow');
    div.append(link);

    div.append('&nbsp;&nbsp;&nbsp;');

    var link = $('<a></a>');
    link.attr('href', "javascript:navigator.toggle('book')");
    link.text('Virtual Book');
    div.append(link);

    div.append('&nbsp;&nbsp;&nbsp;');

    var link = $('<a></a>');
    link.attr('href', "javascript:navigator.toggle('browser')");
    link.text('Function Browser');
    div.append(link);

    tab.after(div);
  }
  if ($.query.has('browser')) {
    navigator.make_navpane ('browser');
    navigator.open('browser', $.query.get('browser'));
  }
  else if ($.query.has('book')) {
    navigator.make_navpane ('book');
    navigator.open('book', $.query.get('book'));
  }
});

function nav_make (id) {
  if (window.name) {
  } else {
    d = new Date();
    window.name = d.getTime().toString();
  }
  window.open(
    '/mathematica/DocumentationNavigator.html#' + id,
    'n' + window.name,
    'width=400,height=600,menubar=no,toolbar=no,status=no,location=no,scrollbars=yes');
}


function nav_open (url) {
  if ($('table.siteNavigationTable').length > 0) {
    window.location = url;
  }
  else {
    window.opener.location.href = url;
  }
}

function nav_scroll (div, pad) {
  var navpane = $('#NavigatorPane');
  navpane[0].scrollTop = div[0].scrollHeight + navpane.offset().top;
  var bot = div.offset().top + div.height();
  if (!pad)
    var pad = 20;
  if (bot > window.innerHeight) {
    var newy;
    if (div.height() > window.innerHeight)
      newy = div.offset().top;
    else
      newy = bot - window.innerHeight + pad;
    if (newy > window.pageYOffset)
      for (var i = window.pageYOffset; i <= newy; i += 2)
        window.scrollTo(0, i);
  }
  div.children('.Head').css({backgroundColor: '#FFFEE4'});
}

function nav_toggle (id) {
  var el = $('#' + id);
  var cont = el.children('div.Content');
  if (cont.length == 0) {
    $.get('/mathematica/HTMLFiles/' + id + '.txt', {}, function (data) {
      el.append(data);
      nav_toggle(id);
    });
  } else {
    cont = el.children('div.Content');
    cont.slideToggle(20, function () {
      img = el.find('img:first')[0];
      if (img.src.indexOf('closed') >= 0) {
        img.src = img.src.replace('closed', 'open');
      } else {
        img.src = img.src.replace('open', 'closed');
      }
    });
  }
}
