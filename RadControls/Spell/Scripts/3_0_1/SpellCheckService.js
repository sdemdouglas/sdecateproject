if (typeof(RadSpellNamespace)=="\x75\x6edefined")RadSpellNamespace= {} ; function GetSpellCheckService(o){return window[o]; } ; RadSpellNamespace.SpellCheckService= function (t){ this.Initialized= false; this.Id=t[0]; this.l6=t[1]; this.DictionaryLanguage=t[2]; this.Configuration=t[3]; this.i6= false; this.I6=null; this.o7=null; this.O7=null; RadControlsNamespace.DomEventsMixin.Initialize(this ); };RadSpellNamespace.SpellCheckService.prototype= {SpellCheck:function (text,l7,onError){var i7=this.SetupXmlHttpRequest(l7,onError); if (i7){ this.SendXmlHttpRequest(this.GetSpellCheckPostArguments(text)); }return i7; } ,AddCustomWord:function (I7,l7,onError){var i7=this.SetupXmlHttpRequest(l7,onError); if (i7){ this.SendXmlHttpRequest(this.GetAddCustomPostArguments(I7)); }return i7; } ,SetupXmlHttpRequest:function (l7,onError){if (!this.i6){ this.i6= true; this.o7=RadControlsNamespace.EventMixin.ResolveFunction(l7); this.O7=onError?RadControlsNamespace.EventMixin.ResolveFunction(onError): this.SpellErrorHandler; return true; }return false; } ,SendXmlHttpRequest:function (o8){if (typeof(XMLHttpRequest)!="\x75nde\x66\x69ned"){ this.I6=new XMLHttpRequest(); }else if (typeof(ActiveXObject)!="\x75ndefined"){ this.I6=new ActiveXObject("Mic\x72\x6fsoft.X\x4d\x4cHTT\x50"); }else return; this.I6.onreadystatechange=this.CreateEventHandler("\x48andleCallba\x63\x6b"); this.I6.open("\x50OST",this.GetTimeStampedCallbackUrl(), true); this.I6.setRequestHeader("Content-\x54\x79pe","applicatio\x6e\x2fx-ww\x77\x2dfor\x6d\055\x75rlenc\x6f\x64ed"); this.I6.send(o8); } ,GetTimeStampedCallbackUrl:function (){var m=this.l6.indexOf("?")<0?"?": "&"; return this.l6+m+"R\x61\x64Upload\x54\x69meSt\x61\x6dp="+new Date().getTime(); } ,HandleCallback:function (){if (this.I6.readyState!=4)return; this.i6= false; this.ProcessCallbackResponse(); this.Cleanup(); } ,ProcessCallbackResponse:function (){if (this.ErrorOccured()){ this.RaiseErrorEvent(); return; }var responseText=this.I6.responseText; if (responseText){var O8=null; try {eval(responseText); O8=SpellCheckResult; }catch (ex){ this.RaiseErrorEvent( { "\x45rrorCode": 500,"\x45rrorT\x65\x78t":ex.message,"\x4dessage":ex.message,"\x54\x65xt":responseText,"Xml": this.I6.l8 } ); return; } this.o7(this,O8); }} ,ErrorOccured:function (){if (!document.all)return false; if (this.I6.status==0 || this.I6.status==200){return false; }return true; } ,SpellErrorHandler:function (i3,I3){var message=""; if (I3.ErrorCode==404){message="\x72.a.d.spell \x65\x72ror\x2e\x20Sp\x65\154\x6c\x43hec\x6b\110\x61ndle\x72 was n\x6ft fou\x6e\144:\x20\015\x0a\015\x0a"+"Pl\x65\x61se, s\x65\x65 th\x65\x20he\x6c\x70 f\x6f\x72 m\x6f\x72e \x64etail\x73\072 \x52adSpe\x6c\154\x20\063.\x30 - C\x6fnfig\x75rat\x69on \x2d Sp\x65llCh\x65ckHa\x6edle\x72.\015\x0a\015\012"+this.l6+"\015\x0a\015\x0a\x44id \x79\x6fu \x72\x65gis\x74\145r\x20\x74he\x20Spell\x43\150e\x63kHand\x6c\145r\x20in w\x65\142\x2e\143\x6fnfig\x3f"; }else if (I3.ErrorCode>0 && I3.ErrorCode!=200){message="r.a.d.spell \x65\162r\x6f\x72. \x53\145rv\x65\162 r\x65\164u\x72ned er\x72\157r\x3a\040"+I3.ErrorCode+" \015\x0a\x0d\012"+"Please, see\x20\x74he \x68\x65lp\x20\x66or \x6d\157r\x65\x20de\x74ails: \x52adSpe\x6c\154 \x33.0 - \x43onfig\x75ratio\x6e - S\x70ell\x43heck\x48andl\x65r.\015\x0a\x0d\012"+this.l6+"\015\012\x0d\012"+I3.ErrorText+"\015\x0a\015\012"+I3.Text+"\015\x0a\x0d\012"; }alert(message); } ,RaiseErrorEvent:function (I3){if (!I3){I3= { "Erro\x72\x43ode": this.I6.status,"\x45rrorText": this.I6.i8,"Message": this.I6.i8,"Text": this.I6.responseText,"\x58ml": this.I6.l8 };} ; this.O7(this,I3); } ,Cleanup:function (){ this.o7=null; this.O7=null; this.I6.onreadystatechange= function (){} ; } ,GetSpellCheckPostArguments:function (text){return "DictionaryLa\x6e\147u\x61\x67e="+this.I8(this.DictionaryLanguage)+"&Configu\x72\x61tion\x3d"+this.I8(this.Configuration)+"&Comma\x6e\x64Argu\x6d\x65nt="+this.I8(text)+"&Co\x6d\x6dandNam\x65\x3dSpe\x6c\154C\x68\x65ck"; } ,I8:function (value){return (encodeURIComponent)?encodeURIComponent(value):escape(value); } ,GetAddCustomPostArguments:function (I7){return "Dict\x69\x6fnaryLa\x6e\x67uag\x65="+this.I8(this.DictionaryLanguage)+"&Confi\x67\x75ratio\x6e\x3d"+this.I8(this.Configuration)+"\x26Comman\x64\x41rgume\x6e\x74="+this.I8(I7)+"&Command\x4e\x61me=A\x64\x64Cust\x6fm"; }};
if (typeof(Sys) != "undefined"){if (Sys.Application != null && Sys.Application.notifyScriptLoaded != null){Sys.Application.notifyScriptLoaded();}}
