//alert('common.js');

/*
var baselang = window.location.pathname.split('/');
baselang = baselang[baselang.length - 1];
baselang = baselang.substring (0, baselang.length - 5);
baselang = baselang + '.en';
*/
function rnd(){ return String((new Date()).getTime()).replace(/\D/gi,'') };
$(document).ready( function() {
  $('a.HowToIconGroup').click( function() {
    link = $(this).attr('href');
    re = new RegExp("w=(.+?)(&|$)");
    width = re.exec(link);
    hre = new RegExp("h=(.+?)(&|$)");
    height = hre.exec(link);
    window.open( link, 'popup' + rnd(), 'width=' + width[1] + ',height=' + height[1] +
      ',scrollbars=no,resizable=no,toolbar=no,directories=no,location=no,menubar=no,status=no' );
    return false;
  });
});

function cons_input (i) {
  id_out = i + '_out';
  id_in = i + '_in';
  el_out = document.getElementById (id_out);
  el_in = document.getElementById (id_in);
    if (el_in.firstChild.nodeType == 1) {
      el_in = el_in.firstChild;
    }
    var innertxt = el_in.innerHTML.replace(/(\r|\n)+/g, '\n');
    rows = innertxt.split('\n').length + 1;
    var url = '';
    for (ch = el_out.firstChild; ch; ch = ch.nextSibling) {
      if (ch.className == 'IFU') {
        url = strValue (ch);
      }
    }
    /* We use .innerHTML when we want &lt; and .firstChild.nodeValue when we want < */
    div = '<div name="' +id_in+ '" id="' +id_in+ '" class="IFF">'
        + '<div><textarea rows="' +rows+ '">' + innertxt + '</textarea><br />'
        + '<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td><div class="mailText"><a class="mailLink" href="'
        + 'mailto:?Subject=Wolfram%20Mathematica%20Example&amp;Body='
        + url + '%0d%0a%0d%0a%0d%0a' 
        + escape(el_in.firstChild.nodeValue)+ '"><img src="/mathematicaImages/mail.gif" width="39" height="22" border="0"/></a></td><td align="right">'
    if (url) { div += '<span class="IFU">' + url + '</span>' }
        + '</td></tr></table></div>'
    div += '<a href="javascript:hideLayer(' +"'" +id_in+ "'"+ ')">x</a></div>';
    el_out.innerHTML = div;
    showLayer(id_in);
}

/*  showInputForm */
function input(i) {
  id_out = i + '_out';
  id_in = i + '_in';
  el_out = document.getElementById (id_out);
  el_in = document.getElementById (id_in);
  if (!el_in) {
    el_url = "Files/" + baselang + "/" + i + ".txt";
    req_func = function (str) {
      el_out.innerHTML = str;
      cons_input (i);
    }
    makeRequest (el_url, req_func);
  }
  else if (el_in.className == 'InputFormText' || el_in.className == 'IFT') {
    cons_input (i);
  }
  else {
    return el_in.style.display == 'block' ? hideLayer(id_in) : showLayer(id_in);
  }
}

function strValue (el) {
  s = '';
  if (el.nodeType == 3) {
    s = s + el.nodeValue;;
  } else {
    for (var i = el.firstChild; i; i = i.nextSibling) {
      s = s + strValue(i);
    }
  }
  return s;
}

function showMenu (id) {
  var el = document.getElementById (id);
  for (var div = el.firstChild; div; div = div.nextSibling) {
    if (div.nodeType == 1) { break; }
  }
  if (div.className == 'ExamplesRaw' ||
	  div.className == 'FunctionsRaw' ||
      div.className == 'TutorialsRaw' ||
      div.className == 'SeeAlsoRaw' ||
      div.className == 'MoreAboutRaw' || 
      div.className == 'PDFRaw' || 
      div.className == 'ShowChangesRaw') {
    var ndiv = '';
    var width = 0;
    for (var li = div.firstChild; li; li = li.nextSibling) {
      if (li.nodeType == 1) {
        ndiv += '<div><a href="' + li.getAttribute ('href') + '">';
        ndiv += li.innerHTML + '</a></div>';
        width = Math.max (width, strValue(li).length);
      }
    }
    ndiv = '<div class="' + div.className.slice(0, -3) + 'MenuItems">' + ndiv + '</div>';
    /*  alert(ndiv);  */
    el.innerHTML = ndiv;
    el.style.cssText = el.style.cssText + ';width:' + (0.6*width+2) + 'em;';
  }
  var hel = document.getElementById ('head_'+id.slice(6));
  if (hel) {
    for (var ha = hel.firstChild; ha; ha = ha.nextSibling) {
      if (ha.nodeType == 1) { break; }
    }
    hel.style.backgroundColor = '#dd802c';
    ha.style.color = '#ffffff';
  }
 /* var lnk = document.getElementById ('parent_'+id.slice(6));
  var left = get_offsetLeft (lnk);
  el.style.left = left + '0px'; */
  showLayer (id);
}
function hideMenu (id) {
  var hel = document.getElementById ('head_'+id.slice(6));
  if (hel) {
    for (var ha = hel.firstChild; ha; ha = ha.nextSibling) {
      if (ha.nodeType == 1) { break; }
    }
    hel.style.backgroundColor = '';
    ha.style.color = '';
  }
  hide2 (id);
}
/* function get_offsetLeft (el) {
  left = 0;
  do {
    left += el.offsetLeft;
  } while (el = el.offsetParent);
  return left;
} */

function openESS (id) {
  el = document.getElementById (id);
  openSection(el);
  setcookie_exco (el, '+');
  subs = el.getElementsByTagName ('div');
  for (var i = 0; i < subs.length; i++) {
    sub = subs[i];
    if (sub.className == 'ESS_Co') {
      openSection(sub);
      setcookie_exco (sub, '+');
    }
  }
}
function closeESS (id) {
  el = document.getElementById (id);
  setcookie_exco (el, '-');
  subs = el.getElementsByTagName ('div');
  for (var i = 0; i < subs.length; i++) {
    sub = subs[i];
    if (sub.className == 'ESS_Ex') {
      closeSection(sub);
      setcookie_exco (sub, '-');
    }
  }
}

function toggle (id) {
  el = document.getElementById (id);
  cls = el.className;
  action = 0;
  if (cls.lastIndexOf ('_Co') == cls.length - 3) {
    openSection(el);
    setcookie_exco (el, '+');
  }
  else if (cls.lastIndexOf ('_Ex') == cls.length - 3) {
    closeSection(el);
    setcookie_exco (el, '-');
  }
}

function open_all () {
  open_ES ();
  var clss = ["ELMS", "EXTS", "IES", "MAS", "NIS", "NS", "OS", "PES", "RDS", "RLS", "RTS", "SAS", "TMAS", "TOC", "TRLS", "TS", "TCS"];
  for (var i = 0; i < clss.length; i++) {
    var cls = clss[i];
    var el = document.getElementById (cls);
    if (el) {
      openSection(el);
      setcookie_exco (el, '+');
    }
  }
}

function open_ES () {
  var el = document.getElementById ('PES');
  openSection(el);
  setcookie_exco (el, '+');
  open_ESn (1);
/*
  var i = 1;
  var el = document.getElementById ('ES_' + i);
  while (el) {
    i++;
    var el2 = document.getElementById ('ES_' + i);
    if (el2) {
      openSection(el);
    } else {
      openSection(el, open_ESS);
    }
    setcookie_exco (el, '+');
    el = el2;
  }
*/
}
function open_ESn (n) {
  var el = document.getElementById ('ES_' + n);
  if (el) {
    openSection(el, open_ESn, n + 1);
  } else {
    open_ESS ()
  }
}

function open_ESS () {
  var es = 'ESS';
  while (true) {
    el = document.getElementById (es + '_1');
    if (!el) break;
    openSection(el);
    setcookie_exco (el, '+');
    var i = 2;
    while (true) {
      el = document.getElementById (es + '_' + i);
      if (!el) break;
      openSection(el);
      setcookie_exco (el, '+');
      i++;
    }
    es = es + 'S';
  }
}

function close_ES () {
  var es = 'ES';
  while (true) {
    var el = document.getElementById (es + '_1');
    if (!el) break;
    closeSection(el);
    setcookie_exco (el, '-');
    i = 2;
    while (true) {
      el = document.getElementById (es + '_' + i);
      if (!el) break;
      closeSection(el);
      setcookie_exco (el, '-');
      i++;
    }
    es = es + 'S';
  }
}

function set_oclink () {
  var i = 1;
  es = document.getElementById ('ES_' + i);
  closeall = true;
  while (es) {
    if (es.className == 'ES_Co') {
      closeall = false;
      break;
    }
    i++;
    es = document.getElementById ('ES_' + i);
  }
  var oclink = document.getElementById ('oclink');
  if (oclink) {
    if (closeall) {
      if (baselang.substr (baselang.length - 2) == 'ja') {
        oclink.firstChild.nodeValue = '\u3059\u3079\u3066\u9589\u3058\u308b';
      } 
      else if (baselang.substr (baselang.length - 2) == 'zh') {
        oclink.firstChild.nodeValue = '\u5173\u95ed\u6240\u6709\u5355\u5143';
      }
      else {
        oclink.firstChild.nodeValue = 'CLOSE ALL';
      }
      oclink.setAttribute ('href', 'javascript:close_ES()');
    } else {
      if (baselang.substr (baselang.length - 2) == 'ja') {
        oclink.firstChild.nodeValue = '\u3059\u3079\u3066\u958b\u304f';
      } 
      else if (baselang.substr (baselang.length - 2) == 'zh') {
        oclink.firstChild.nodeValue = '\u6253\u5f00\u6240\u6709\u5355\u5143';
      }
      else {
        oclink.firstChild.nodeValue = 'OPEN ALL';
      }
      oclink.setAttribute ('href', 'javascript:open_ES()');
    }
  }
}

function openSection (el, func, userdata) {
  var cls = el.className;
  var clsPre = cls.substring (0, cls.length - 3);
  if (clsPre == 'ES') {
    var el_cnt;
    for (el_cnt = el.firstChild; el_cnt; el_cnt = el_cnt.nextSibling) {
      if (el_cnt.nodeType == 1 && el_cnt.className == clsPre) {
        break;
      }
    }
    var intxt = el_cnt.innerHTML;
    intxt = intxt.replace(/^\s+/g, '').replace(/\s+$/g, '');
    if (intxt == '') {
      el_url = "Files/" + baselang + "/" + el.id + ".txt";
      req_func = function (str) {
        el_cnt.innerHTML = str;
        if (func) {
          func (userdata);
        }
      }
      makeRequest (el_url, req_func);
    } else {
      if (func) {
        func (userdata);
      }
    }
  }

  el.className = clsPre + '_Ex';
  var img = document.getElementById (el.id + '_');
  img.src = img.src.replace ('closed', 'open');
  set_oclink ();
}
function closeSection (el) {
  var cls = el.className;
  var clsPre = cls.substring (0, cls.length - 3);
  el.className = clsPre + '_Co';
  var img = document.getElementById (el.id + '_');
  img.src = img.src.replace ('open', 'closed');
  set_oclink ();
}
function setcookie_exco (el, exco) {
  var loc = window.location.toString();
  var begin;
  var end;
  for (var i=0; i<3; i++) {
    loc = loc.substring (loc.indexOf ('/') + 1);
  }
  loc = '/' + loc;
  begin = loc.indexOf ('?');
  if (begin != -1)
    loc = loc.substring (0, begin);

  var cookie = document.cookie;
  var prefix = 'exco' + loc + '=';
  begin = cookie.indexOf ('; ' + prefix);
  if (begin == -1) {
    begin = cookie.indexOf (prefix);
    if (begin != 0) begin = -1;
  } else {
    begin += 2;
  }
  if (begin != -1) {
    end = cookie.indexOf (';', begin);
    if (end == -1) end = cookie.length
    cookie = cookie.substring (begin, end);
  } else {
    cookie = prefix;
  }
  var cdata = cookie.substring (prefix.length);
  if (cdata.length == 0 || (cdata.substring (0, 1) != '+' && cdata.substring (0, 1) != '-')) {
    cdata = '';
  }
  else {
    begin = cdata.indexOf ('+' + el.id);
    if (begin == -1)
      begin = cdata.indexOf ('-' + el.id);
    if (begin != -1) {
      var end1 = cdata.indexOf ('+', begin + 1);
      var end2 = cdata.indexOf ('-', begin + 1);
      if (end1 == -1)
        end = end2;
      else if (end2 == -1)
        end = end1;
      else
        end = Math.min (end1, end2);
      var cnew = cdata.substring (0, begin);
      if (end != -1)
        cnew += cdata.substring (begin + end)
      cdata = cnew;
    }
  }
  cdata += exco + el.id;

  cookie = prefix + cdata;
  document.cookie = cookie;
}

function expandCookie () {
  var loc = window.location.toString();
  var begin;
  var end;
  for (var i=0; i<3; i++) {
    loc = loc.substring (loc.indexOf ('/') + 1);
  }
  loc = '/' + loc;
  begin = loc.indexOf ('?');
  if (begin != -1)
    loc = loc.substring (0, begin);

  var cookie = document.cookie;
  var prefix = 'exco' + loc + '=';
  begin = cookie.indexOf ('; ' + prefix);
  if (begin == -1) {
    begin = cookie.indexOf (prefix);
    if (begin != 0) begin = -1;
  } else {
    begin += 2;
  }
  if (begin != -1) {
    end = cookie.indexOf (';', begin);
    if (end == -1) end = cookie.length
    cookie = cookie.substring (begin, end);
  } else {
    cookie = prefix;
  }
  var cdata = cookie.substring (prefix.length);

  while (cdata.length != 0) {
    var end1 = cdata.indexOf ('+', 1);
    var end2 = cdata.indexOf ('-', 1);
    if (end1 == -1) end = end2;
    else if (end2 == -1) end = end1;
    else end = Math.min (end1, end2);
    if (end == -1) end = cdata.length;
    var id = cdata.substring (1, end);
    var el = document.getElementById (id);
    if (el) {
      if (cdata.substring (0, 1) == '+')
        openSection(el);
      else if (cdata.substring (0, 1) == '-')
        closeSection(el);
    }
    cdata = cdata.substring (end);
  }
}

function toggleExampleSubsection(idn) {
  divElement = document.getElementById('ESS_'+idn);
  imgElement = document.getElementById('ESSA_'+idn);
  triangleElement = document.getElementsByName('ESST_'+idn);
   for(i=0; i<triangleElement.length; i++) {
   if (triangleElement[i].className == 'offTriangle') {
      triangleElement[i].className = 'onTriangle';
    } else {
      triangleElement[i].className = 'offTriangle';
    }
  }
  if (divElement.className == 'ESSC') {
    divElement.className = 'ESSE';
    imgElement.src = '/mathematicaImages/openGroup.gif'
  } else {
    divElement.className = 'ESSC';
    imgElement.src = '/mathematicaImages/closedGroup.gif'
  }
}


function toggleExampleSection(idn) {
  divElement = document.getElementById('ES_'+idn);
  imgElement = document.getElementById('ESA_'+idn);
  triangleElement = document.getElementsByName('EST_'+idn);
   for(i=0; i<triangleElement.length; i++) {
    if (triangleElement[i].className == 'offTriangle') {
     triangleElement[i].className = 'onTriangle';
    } else {
     triangleElement[i].className = 'offTriangle';
    }
  }
  if (divElement.className == 'ESC') {
    divElement.className = 'ESE';
    imgElement.src = '/mathematicaImages/openGroup.gif'
  } else {
    divElement.className = 'ESC';
    imgElement.src = '/mathematicaImages/closedGroup.gif'
  }
}

function toggleSection(idn) {
  divElement = document.getElementById(idn);
  imgElement = document.getElementById(idn+'_Icon');
  if (divElement.className == idn+'C') {
    divElement.className = idn+'E';
    imgElement.src = '/mathematicaImages/openSectionGroup.gif'
  } else {
    divElement.className = idn+'C'; 
    imgElement.src = '/mathematicaImages/closedSectionGroup.gif' } 
} 

function fetchToId (idn, esn) {
  var el = document.getElementsByName (idn);
  var esel = document.getElementById ('ES_' + esn);
  if (el.length > 0) {
    expandToId (idn);
  }
  else if (esel) {
    var el_cnt;
    for (el_cnt = esel.firstChild; el_cnt; el_cnt = el_cnt.nextSibling) {
      if (el_cnt.nodeType == 1 && el_cnt.className == 'ES') {
        break;
      }
    }
    if (el_cnt.innerHTML == '') {
      el_url = "Files/" + baselang + "/" + esel.id + ".txt";
      req_func = function (str) {
        el_cnt.innerHTML = str;
        fetchToId (idn, esn + 1);
      }
      makeRequest (el_url, req_func);
    } else {
      fetchToId (idn, esn + 1);
    }
  }
}
function expandToId (idn) {
  el = document.getElementsByName (idn);
  if (el.length == 0) {
    fetchToId (idn, 1);
  } else {
    el = el[0];
    for (var p = el.parentNode; p != document; p = p.parentNode) {
      if (p.className && p.className.length > 2 &&
          p.className.lastIndexOf ('_Co') == p.className.length - 3) {
        if (p.id) {
          toggle (p.id);
        }
      }
    }
    y = 0;
    while (el) {
      y += el.offsetTop;
      el = el.offsetParent;
    }
    window.scrollTo (0, y);
  }
}
function expandToHash () {
  if (location.hash) {
    expandToId (location.hash.substring (1));
  }
}
function expandOnLoad () {
  var do_all = false;
  var qs = window.location.search.substring(1);
  var kvs = qs.split('&');
  for (var i=0; i < kvs.length; i++) {
    var kv = kvs[i].split('=');
    if (kv[0] == 'expand') {
      do_all = true;
      break;
    }
  }
  if (do_all) {
    open_all ();
  } else {
    expandCookie ();
    expandToHash ();
  }
}
if (window.addEventListener) {
  window.addEventListener ('load', expandOnLoad, true);
  window.addEventListener ("DOMContentLoaded", expandOnLoad, true);
}
else if (window.attachEvent) {
  window.attachEvent ('onload', expandOnLoad);
}

function toggleNewIn(id) {
  var lang = baselang.substr (baselang.length - 2); 
  var divElement = document.getElementsByName('newInVersionLink');
  for(i=0; i<divElement.length; i++) {
    if (divElement[i].className == 'newInVersionLink') { 
      divElement[i].className = 'newInVersionLinkHighlight'; 
    } else if (divElement[i].className == 'newInVersionLinkHighlight') {
      divElement[i].className = 'newInVersionLink'; 
    }
  }
  img = document.getElementById('UpdatedIn6Graphic'); 
  if (img.src.indexOf('UpdatedIn6.') > 0) {
    img.src = img.src.replace ('UpdatedIn6.'+lang, 'UpdatedIn6-hide.'+lang);
  } else {
    img.src = img.src.replace ('UpdatedIn6-hide.'+lang, 'UpdatedIn6.'+lang);
  }
}

function showModChanges(ModInfo_3) {
  var div3Element = document.getElementsByName('ModInfo_3');
  var div4Element = document.getElementsByName('ModInfo_4');
  var div5Element = document.getElementsByName('ModInfo_5');
  var div6Element = document.getElementsByName('ModInfo_6');
  var lang = baselang.substr (baselang.length - 2); 
  var doDetails = 0;
  for(i=0; i<div3Element.length; i++) {
    if (div3Element[i].className == 'Notes') { 
      div3Element[i].className = 'Notes_ModInfo_3'; 
/*      div4Element[i].className = 'Notes'; 
      div5Element[i].className = 'Notes'; 
      div6Element[i].className = 'Notes'; */
    } else if (div3Element[i].className == 'Notes_ModInfo_3') {
      div3Element[i].className = 'Notes'; 
      div4Element[i].className = 'Notes'; 
      div5Element[i].className = 'Notes'; 
      div6Element[i].className = 'Notes'; 
      doDetails = -1;
    }
} 
}


function toggleModInfo(id) {
  var divElement = document.getElementsByName(id);
  var div3Element = document.getElementsByName('ModInfo_3');
  var div4Element = document.getElementsByName('ModInfo_4');
  var div5Element = document.getElementsByName('ModInfo_5');
  var div6Element = document.getElementsByName('ModInfo_6');
  var lang = baselang.substr (baselang.length - 2); 
  var doDetails = 0;
  for(i=0; i<divElement.length; i++) {
    if (divElement[i].className == 'Notes') { 
      divElement[i].className = 'Notes_ModInfo_6'; 
      doDetails = 1;
    } else if (divElement[i].className == 'Notes_ModInfo_6') {
      divElement[i].className = 'Notes'; 
      doDetails = -1;
    } else if (divElement[i].className == 'NSH_ModInfo_6') {
      divElement[i].className = 'NSH'; 
      doDetails = -1;
    } else if (divElement[i].className == 'NSH') {
      divElement[i].className = 'NSH_ModInfo_6'; 
      doDetails = -1;
    } else if (divElement[i].className == 'TRI') { 
      divElement[i].className = 'TRIO'; 
      doDetails = 1;
    } else if (divElement[i].className == 'TRIO') { 
      divElement[i].className = 'TRI'; 
      doDetails = -1;
    } else if (divElement[i].className == 'CRI') { 
      divElement[i].className = 'CRIO'; 
    } else if (divElement[i].className == 'CRIO') { 
      divElement[i].className = 'CRI'; 
    } else if (divElement[i].className == 'UM_ModInfo_6') { 
      divElement[i].className = 'UM'; 
    } else if (divElement[i].className == 'UM') { 
      divElement[i].className = 'UM_ModInfo_6'; 
    } else if (divElement[i].className == 'ModInfo') { 
      divElement[i].className = 'ModInfoOn'; 
    } else if (divElement[i].className == 'ModInfoOn') { 
      divElement[i].className = 'ModInfo'; 
    } else if (divElement[i].className == 'ModInfoLegend') { 
      divElement[i].className = 'ModInfoLegendOn'; 
    } else if (divElement[i].className == 'ModInfoLegendOn') { 
      divElement[i].className = 'ModInfoLegend'; 
    } else if (divElement[i].className == 'newInVersionLink') {
      divElement[i].className = 'newInVersionLinkHighlight';
    } else if (divElement[i].className == 'newInVersionLinkHighlight') {
      divElement[i].className = 'newInVersionLink';

  } }
  if (doDetails != 0) {
    var nshEl = document.getElementsByName ('NotesSection');
    if (nshEl) {
      for (nshEl = nshEl[0].firstChild; nshEl; nshEl = nshEl.nextSibling) {
        if (doDetails == 1 && nshEl.className == 'NSH') {
          nshEl.className = 'NSH_MI6';
          break;
        } else if (doDetails == -1 && nshEl.className == 'NSH_MI6') {
          nshEl.className = 'NSH';
          break;
        }
      }
    }
  }
  
  img = document.getElementById('UpdatedIn7Graphic'); 
  if (img.src.indexOf('UpdatedIn7.') > 0) {
    img.src = img.src.replace ('UpdatedIn7.', 'UpdatedIn7-hide.');
  } else {
    img.src = img.src.replace ('UpdatedIn7-hide.', 'UpdatedIn7.');
  }
  img = document.getElementById('UpdatedIn6Graphic'); 
  if (img.src.indexOf('UpdatedIn6.') > 0) {
    img.src = img.src.replace ('UpdatedIn6.', 'UpdatedIn6-hide.');
  } else {
    img.src = img.src.replace ('UpdatedIn6-hide.', 'UpdatedIn6.');
  }
} 

function ShowStatus(msg) { window.status = msg; return true; }


function swap(obj, theWidth, theHeight, fileName, divId){
var flash1='<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0" width="'+ theWidth + '" height="'+ theHeight + '" id="benefits" align="middle"><param name="allowScriptAccess" value="sameDomain" /><param name="movie" value="'+ fileName + '" /><param name="loop" value="false" /><param name="menu" value="false" /><param name="quality" value="high" /><param name="bgcolor" value="#ffffff" /><embed src="'+ fileName + '" loop="false" menu="false" quality="high" bgcolor="#ffffff" width="'+ theWidth + '" height="'+ theHeight + '" name="benefits" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" /></object>';

	document.getElementById(divId).innerHTML = flash1;
}


function makeRequest(url, func) {

 var http_request = false;

 if (window.XMLHttpRequest) // Mozilla, Safari,...
 {
   http_request = new XMLHttpRequest();
   if (http_request.overrideMimeType)
   {
     http_request.overrideMimeType('text/plain');
   }
 }
 else if (window.ActiveXObject) // IE
 {
   try {
     http_request = new ActiveXObject("Msxml2.XMLHTTP");
   } catch (e) {
     try {
       http_request = new ActiveXObject("Microsoft.XMLHTTP");
     } catch (e) {}
   }
 }

 if (!http_request)
 {
   alert('This feature requires an AJAX capable browser,\r such as Microsoft Internet Explorer version 5.0 and above,\rany version of Mozilla or Firefox, Netscape\rversion 7.1 and above, Apple Safari version 1.2\rand above, or Opera version 8.0 and above.');
   return false;
 }

 http_request.onreadystatechange = function()
  {   
    if (http_request.readyState == 4)
    {
      if (http_request.status == 200)
      {
        func (http_request.responseText);
      }
    } 
  };
 http_request.open('GET', url, true);
 http_request.send(null);

}

/* logURL("http://reference.devel.wolfram.com/mathematica/guide/Mathematica.html?logloglog"); */

function logURL(url) {

 var http_request = false;

 if (window.XMLHttpRequest) // Mozilla, Safari,...
 {
   http_request = new XMLHttpRequest();
 }
 else if (window.ActiveXObject) // IE
 {
   try {
     http_request = new ActiveXObject("Msxml2.XMLHTTP");
   } catch (e) {
     try {
       http_request = new ActiveXObject("Microsoft.XMLHTTP");
     } catch (e) {}
   }
 }

 if (!http_request)
 {
   return false;
 }

 http_request.onreadystatechange = function() {}
 http_request.open('HEAD', url, true);
 http_request.send(null);
}

/* define soundEmbed */
var soundEmbed = null;

function playSound(url) {
soundStop();
soundEmbed = document.createElement("embed");
soundEmbed.setAttribute("src", url);
soundEmbed.setAttribute("hidden", true);
soundEmbed.setAttribute("autostart", true);
document.body.appendChild(soundEmbed);
}

function soundStop() {
if ( soundEmbed ) document.body.removeChild(soundEmbed);
soundEmbed = null;
}
//alert('common.js');
