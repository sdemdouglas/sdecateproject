function GetRadUpload(K){return window[K]; } ; if (typeof(RadUploadNameSpace)=="u\x6e\x64efined")RadUploadNameSpace= {} ; RadUploadNameSpace.RadUpload= function (J){ this.i9= false; RadControlsNamespace.EventMixin.Initialize(this ); RadControlsNamespace.DomEventsMixin.Initialize(this ); this.Id=J[0]; this.I9(document.getElementById(J[1])); this.oa=J[2]; this.Oa=J[3]; this.Enabled=J[4]; this.la=J[5]; this.ia=J[6]; this.EnableFileInputSkinning=J[7]; if (RadControlsNamespace.Browser.IsSafari || (RadControlsNamespace.Browser.IsOpera && !RadControlsNamespace.Browser.IsOpera9)){ this.EnableFileInputSkinning= false; } this.ReadOnlyFileInputs=J[8]; this.AllowedFileExtensions=J[9]; this.Ia=J[10]&1; this.ob=J[10]&2; this.Ob=J[10]&4; this.OnClientAdded=J[11]; this.OnClientAdding=J[12]; this.OnClientDeleting=J[13]; this.OnClientClearing=J[14]; this.OnClientFileSelected=J[15]; this.OnClientDeletingSelected=J[16]; this.CurrentIndex=0; this.lb=document.getElementById(this.Id+"\x42utto\x6e\x41rea"); this.ListContainer=document.getElementById(this.Id+"\x4cistContai\x6e\x65r"); if (!document.readyState || document.readyState=="complete"){ this.InnerConstructor(); }else { this.AttachDomEvent(window,"l\x6f\x61d","\x49\x6enerCon\x73\x74ruc\x74\x6fr"); }} ; RadUploadNameSpace.RadUpload.prototype= {InnerConstructor:function (N){ this.ib(); this.AddButton=this.InitButton(document.getElementById(this.Id+"A\x64\144\x42\x75tton"),"\x41dd","\x41ddFileInpu\x74"); this.DeleteButton=this.InitButton(document.getElementById(this.Id+"DeleteButto\x6e"),"D\x65\x6cete","Delet\x65\x53electe\x64\x46ile\x49nputs"); this.Ib=this.oc(); var Oc=this.la==0?this.ia:Math.min(this.ia,this.la); for (var i=0; i<Oc; i++){ this.AddFileInput(); } this.lc(); this.i9= true; } ,AddFileInput:function (N){var l3=this.AddFileInputAt(this.ListContainer.rows.length); if (this.i9){try {l3.focus(); }catch (ex){}}} ,AddFileInputAt:function (index){if (typeof(index)=="\165\x6edefined" || index>this.ListContainer.rows.length){index=this.ListContainer.rows.length; }if (this.la>0 && index>=this.la)return; if (this.i9){var ic=this.RaiseEvent("\x4fnCl\x69\x65ntAdd\x69\x6eg",new RadUploadNameSpace.RadUploadEventArgs(null)); if (ic== false){return; }} this.Ic(index); } ,Ic:function (index){var od=this.ListContainer.insertRow(index); this.AttachDomEvent(od,"click","Ro\x77\x43licked"); var Od; if (this.Ia){Od=od.insertCell(od.cells.length); this.ld(Od); }Od=od.insertCell(od.cells.length); this.oe(Od); if (this.Ob){Od=od.insertCell(od.cells.length); this.Oe(Od); }if (this.ob){Od=od.insertCell(od.cells.length); this.le(Od); } this.lc(); this.RaiseEvent("O\x6e\x43lientA\x64\x64ed", {Row:od } ); this.CurrentIndex++; return od; } ,ld:function (container){var ie=document.createElement("input"); ie.type="\143he\x63\x6bbox"; ie.id=this.Id+"c\x68\x65ckbox"+this.CurrentIndex; container.appendChild(ie); ie.className="\x52adUploadFil\x65\x53ele\x63\x74or"; ie.disabled=!this.Enabled; return ie; } ,Oe:function (container){var button=document.createElement("input"); button.type="button"; button.id=this.Id+"clear"+this.CurrentIndex; container.appendChild(button); this.InitButton(button,"\x43lear"); button.className="\x52adUploadC\x6c\x65arB\x75\x74ton"; button.name="Cl\x65\x61rInput"; button.disabled=!this.Enabled; return button; } ,le:function (container){var button=document.createElement("\x69nput"); button.type="button"; button.id=this.Id+"\162em\x6f\x76e"+this.CurrentIndex; container.appendChild(button); button.value=RadUploadNameSpace.Localization[this.oa]["Remove"]; button.className="\x52adUploadRem\x6f\x76eBut\x74\157\x6e"; button.name="RemoveRo\x77"; button.disabled=!this.Enabled; return button; } ,oe:function (container){var l3=this.Ie(); this.AttachDomEvent(l3,"c\x68\x61nge","\x46\x69leSel\x65\x63ted"); if (this.EnableFileInputSkinning){l3.className="RealFileIn\x70\x75t"; var div=document.createElement("d\x69\166"); container.appendChild(div); div.style.position="relative"; div.appendChild(this.Ib.cloneNode( true)); div.appendChild(l3); if (!this.ReadOnlyFileInputs){ this.AttachDomEvent(l3,"\x6b\145yup","Syn\x63\x46ileInp\x75\x74Cont\x65nt"); }else { this.AttachDomEvent(l3,"\x6beydo\x77\x6e","Ca\x6e\x63elEvent"); }return div; }else {container.appendChild(l3); l3.className="\x4eoSkinn\x65\x64FileU\x6e\x70ut"; if (this.ReadOnlyFileInputs){ this.AttachDomEvent(l3,"keyd\x6f\x77n","Cance\x6c\x45vent"); }return l3; }} ,CancelEvent:function (N){if (!N)N=window.event; if (!N)return false; N.returnValue= false; N.cancelBubble= true; if (N.stopPropagation){N.stopPropagation(); }if (N.preventDefault){N.preventDefault(); }return false; } ,ClearFileInputAt:function (index){var od=this.ListContainer.rows[index]; if (od){var ic=this.RaiseEvent("\117\x6e\103lie\x6e\x74Cle\x61\x72in\x67",new RadUploadNameSpace.RadUploadEventArgs(this.GetFileInputFrom(od))); if (ic== false){return false; } this.DeleteFileInputAt(index, true); this.Ic(index, true); }} ,oc:function (){var of=document.createElement("div"); of.style.position="absol\x75te"; of.style.top=0; of.style.left=0; of.style.zIndex=1; var Of=document.createElement("\x69nput"); Of.type="\x74ext"; Of.className="RadUplo\x61\x64Input\x46\x69eld"; of.appendChild(Of); var If=document.createElement("\151n\x70\x75t"); If.type="button"; of.appendChild(If); this.InitButton(If,"S\x65\x6cect"); If.disabled=!this.Enabled; If.className="RadUpl\x6f\x61dSele\x63\x74But\x74\157n"; return of; } ,Ie:function (){var l3=document.createElement("i\x6e\x70ut"); l3.type="f\x69\x6ce"; l3.name=this.GetID("\x66ile"); l3.id=this.GetID("file"); l3.disabled=!this.Enabled; return l3; } ,DeleteFileInputAt:function (index,og){var od=this.ListContainer.rows[index]; if (od){if (!og){var ic=this.RaiseEvent("\x4fnCli\x65\x6etDele\x74\x69ng",new RadUploadNameSpace.RadUploadEventArgs(this.GetFileInputFrom(od))); if (ic== false){return false; }}od.parentNode.removeChild(od); this.lc(); }} ,DeleteSelectedFileInputs:function (N){var Og=[]; var lg=[]; for (var i=this.ListContainer.rows.length-1; i>=0; i--){var Ig=this.ListContainer.rows[i]; var oh=Ig.cells[0].childNodes[0]; if (oh.checked){lg[lg.length]=i; Og[Og.length]=this.GetFileInputFrom(Ig); }}var ic=this.RaiseEvent("\x4fnClie\x6e\x74Dele\x74\x69ngS\x65lected",new RadUploadNameSpace.RadUploadDeleteSelectedEventArgs(Og)); if (ic== false){return; }for (var i=0; i<lg.length; i++){ this.DeleteFileInputAt(lg[i], true); }} ,ib:function (){var Oh=this.ListContainer.rows[0]; Oh.parentNode.removeChild(Oh); } ,FileSelected:function (e){if (this.EnableFileInputSkinning){ this.SyncFileInputContent(e); } this.RaiseEvent("O\x6e\103lie\x6e\x74File\x53\x65le\x63ted",new RadUploadNameSpace.RadUploadEventArgs(e.srcElement?e.srcElement:e.target)); } ,GetFileInputFrom:function (od){var lh=od.getElementsByTagName("input"); for (var i=0; i<lh.length; i++){if (lh[i].type=="file"){return lh[i]; }}return null; } ,GetFileInputs:function (){var O3=[]; for (var i=0; i<this.ListContainer.rows.length; i++){O3[O3.length]=this.GetFileInputFrom(this.ListContainer.rows[i]); }return O3; } ,GetID:function (F){return this.Id+F+this.CurrentIndex; } ,ih:function (l){if (l){if (l.tagName.toLowerCase()=="\164\x72"){return l; }else {return this.ih(l.parentNode); }}return null; } ,InitButton:function (button,Ih,oi){if (button){button.value=RadUploadNameSpace.Localization[this.oa][Ih]; if (this.Enabled){if (oi)this.AttachDomEvent(button,"\x63lick",oi); }else {button.disabled= true; }}return button; } ,IsExtensionValid:function (Oi){if (Oi=="")return true; for (var i=0; i<this.AllowedFileExtensions.length; i++){var ii=this.AllowedFileExtensions[i].substring(2); var Ii=new RegExp("\x2e"+ii+"\x24","\x69g"); if (Oi.match(Ii)){return true; }}return false; } ,RowClicked:function (e){var srcElement=e.srcElement?e.srcElement:e.target; var oj=this.ih(srcElement); if (srcElement.name=="Rem\x6f\x76eRow"){ this.DeleteFileInputAt(oj.rowIndex); }else if (srcElement.name=="ClearInpu\x74"){ this.ClearFileInputAt(oj.rowIndex); }} ,lc:function (){ this.Oj(this.DeleteButton,this.ListContainer.rows.length>0); this.Oj(this.AddButton,(this.la<=0) || (this.ListContainer.rows.length<this.la)); } ,Oj:function (button,lj){if (button){button.className=lj?"\x52adUploadButt\x6f\156": "RadUploadBut\x74\x6fnDi\x73\x61bl\x65d"; }} ,SyncFileInputContent:function (e){var l3=e.srcElement?e.srcElement:e.target; var ij=l3.parentNode.childNodes[0].childNodes[0]; if (l3 !== ij){ij.value=l3.value; ij.title=l3.value; ij.disabled= true; }} ,I9:function (form){if (!form)form=document.forms[0]; form.enctype=form.encoding="multipart\x2f\x66orm-\x64\x61ta"; } ,ValidateExtensions:function (){for (var i=0; i<this.ListContainer.rows.length; i++){var Ij=this.GetFileInputFrom(this.ListContainer.rows[i]).value; if (!this.IsExtensionValid(Ij)){return false; }}return true; }} ;;if (typeof window.RadControlsNamespace=="\165nd\x65\x66ined"){window.RadControlsNamespace= {} ; }if (typeof(window.RadControlsNamespace.Browser)=="\x75ndefin\x65\x64" || typeof(window.RadControlsNamespace.Browser.Version)==null || window.RadControlsNamespace.Browser.Version<1){window.RadControlsNamespace.Browser= {Version: 1 } ; window.RadControlsNamespace.Browser.ParseBrowserInfo= function (){ this.IsMacIE=(navigator.appName=="Micr\x6f\x73oft I\x6e\x74ern\x65t Explo\x72\x65r") && ((navigator.userAgent.toLowerCase().indexOf("\x6dac")!=-1) || (navigator.appVersion.toLowerCase().indexOf("mac")!=-1)); this.IsSafari=(navigator.userAgent.toLowerCase().indexOf("safari")!=-1); this.IsMozilla=window.netscape && !window.opera; this.IsNetscape=/\x4e\x65\x74\x73\x63\x61\x70\x65/.test(navigator.userAgent); this.IsOpera=window.opera; this.IsOpera9=window.opera && (parseInt(window.opera.version())>8); this.IsIE=!this.IsMacIE && !this.IsMozilla && !this.IsOpera && !this.IsSafari; this.IsIE7=/\x4d\x53\x49\x45\x20\x37/.test(navigator.appVersion); this.StandardsMode=this.IsSafari || this.IsOpera9 || this.IsMozilla || document.compatMode=="\x43SS1C\x6f\x6dpat"; this.IsMac=/\x4d\x61\x63/.test(navigator.userAgent); };RadControlsNamespace.Browser.ParseBrowserInfo(); };if (typeof window.RadControlsNamespace=="\165nd\x65\x66ined"){window.RadControlsNamespace= {} ; }RadControlsNamespace.DomEventsMixin= function (){} ; RadControlsNamespace.DomEventsMixin.Initialize= function (O){O.AttachDomEvent=this.AttachDomEvent; O.DetachDomEvent=this.DetachDomEvent; O.DisposeDomEvents=this.DisposeDomEvents; O.ClearEventPointers=this.ClearEventPointers; O.RegisterForAutomaticDisposal=this.RegisterForAutomaticDisposal; O.o=this.o; O.CreateEventHandler=this.CreateEventHandler; O.I=this.I; O.ClearEventPointers(); } ; RadControlsNamespace.DomEventsMixin.CreateEventHandler= function (A){var U=this ; return function (e){if (!e)e=window.event; return U[A](e); };} ; RadControlsNamespace.DomEventsMixin.AttachDomEvent= function (Z,z,W){var w=this.CreateEventHandler(W); this.V[this.V.length]=[Z,z,w]; this.I(Z,z,w); } ; RadControlsNamespace.DomEventsMixin.I= function (Z,z,w){if (Z.attachEvent){Z.attachEvent("o\x6e"+z,w); }else if (Z.addEventListener){Z.addEventListener(z,w, false); }} ; RadControlsNamespace.DomEventsMixin.DetachDomEvent= function (Z,z,w){if (Z.detachEvent){Z.detachEvent("\x6fn"+z,w); }} ; RadControlsNamespace.DomEventsMixin.DisposeDomEvents= function (){for (var i=0; i<this.V.length; i++){ this.DetachDomEvent(this.V[i][0],this.V[i][1],this.V[i][2]); } this.ClearEventPointers(); } ; RadControlsNamespace.DomEventsMixin.RegisterForAutomaticDisposal= function (v){var T=this ; var t=this.CreateEventHandler(v); var S= function (){t(); T.DisposeDomEvents(); T=null; } ; this.I(window,"\165\x6eload",S); } ; RadControlsNamespace.DomEventsMixin.ClearEventPointers= function (){ this.V=[]; } ;;if (typeof window.RadControlsNamespace=="\165n\x64\x65fined"){window.RadControlsNamespace= {} ; }if (typeof(window.RadControlsNamespace.EventMixin)=="undefined" || typeof(window.RadControlsNamespace.EventMixin.Version)==null || window.RadControlsNamespace.EventMixin.Version<1){RadControlsNamespace.EventMixin= {Version: 1,Initialize:function (O){O._listeners= {} ; O._eventsEnabled= true; O.AttachEvent=this.AttachEvent; O.DetachEvent=this.DetachEvent; O.RaiseEvent=this.RaiseEvent; O.EnableEvents=this.EnableEvents; O.DisableEvents=this.DisableEvents; } ,DisableEvents:function (){ this._eventsEnabled= false; } ,EnableEvents:function (){ this._eventsEnabled= true; } ,AttachEvent:function (z,R){if (!this._listeners[z]){ this._listeners[z]=[]; } this._listeners[z][this._listeners[z].length]=(RadControlsNamespace.EventMixin.ResolveFunction(R)); } ,DetachEvent:function (z,R){var r=this._listeners[z]; if (!r){return false; }var Q=RadControlsNamespace.EventMixin.ResolveFunction(R); for (var i=0; i<r.length; i++){if (Q==r[i]){r.splice(i,1); return true; }}return false; } ,ResolveFunction:function (P){if (typeof(P)=="\x66\x75\x6ection"){return P; }else if (typeof(window[P])=="func\x74\x69on"){return window[P]; }else {return new Function("var Sen\x64\x65r = a\x72\147u\x6dents[0]\x3b\040\x76ar Argu\x6dents\x20= argu\x6d\145n\x74s[1];"+P); }} ,RaiseEvent:function (z,N){if (!this._eventsEnabled){return true; }var n= true; if (this[z]){var M=RadControlsNamespace.EventMixin.ResolveFunction(this[z])(this,N); if (typeof(M)=="\x75ndefi\x6e\x65d"){M= true; }n=n && M; }if (!this._listeners[z])return n; for (var i=0; i<this._listeners[z].length; i++){var R=this._listeners[z][i]; var M=R(this,N); if (typeof(M)=="\x75ndefined"){M= true; }n=n && M; }return n; }};};if (typeof(RadUploadNameSpace)=="undefine\x64")RadUploadNameSpace= {} ; if (typeof(RadUploadNameSpace.Localization)=="un\x64\x65fined")RadUploadNameSpace.Localization=[]; RadUploadNameSpace.Localization.ProcessRawArray= function (m){var L=m[0]; if (typeof(RadUploadNameSpace.Localization[L])=="undefined"){RadUploadNameSpace.Localization[L]=[]; }for (var i=1; i<m.length; i+=2){RadUploadNameSpace.Localization[L][m[i]]=m[i+1]; }} ;;if (typeof window.RadControlsNamespace=="\x75\x6edefined"){window.RadControlsNamespace= {} ; }if (typeof(window.RadControlsNamespace.Overlay)=="u\x6e\x64efined" || typeof(window.RadControlsNamespace.Overlay.Version)==null || window.RadControlsNamespace.Overlay.Version<.11e1){window.RadControlsNamespace.Overlay= function (l){if (!this.SupportsOverlay()){return; } this.Element=l; this.Shim=document.createElement("IFRAME"); this.Shim.src="\x6aavas\x63\x72ipt:\x27\x27;"; this.Element.parentNode.insertBefore(this.Shim,this.Element); if (l.style.zIndex>0){ this.Shim.style.zIndex=l.style.zIndex-1; } this.Shim.style.position="a\x62\x73olute"; this.Shim.style.border="0p\x78"; this.Shim.frameBorder=0; this.Shim.style.filter="\x70\x72ogid:DX\x49\x6dage\x54\162\x61nsf\x6f\x72m.M\x69\143r\x6fsoft\x2eAlpha(\x73\164y\x6ce=0,o\x70\141c\x69ty=0)"; this.Shim.disabled="\x64isabled"; };window.RadControlsNamespace.Overlay.Version=.11e1; RadControlsNamespace.Overlay.prototype.SupportsOverlay= function (){return RadControlsNamespace.Browser.IsIE || (RadControlsNamespace.Browser.IsMozilla && RadControlsNamespace.Browser.IsMac); };RadControlsNamespace.Overlay.prototype.Update= function (){if (!this.SupportsOverlay()){return; } this.Shim.style.top=this.ToUnit(this.Element.style.top); this.Shim.style.left=this.ToUnit(this.Element.style.left); this.Shim.style.width=this.Element.offsetWidth+"px"; this.Shim.style.height=this.Element.offsetHeight+"px"; };RadControlsNamespace.Overlay.prototype.ToUnit= function (value){if (!value)return "\x30px"; return parseInt(value)+"px"; };RadControlsNamespace.Overlay.prototype.Dispose= function (){if (!this.SupportsOverlay()){return; }if (this.Shim.parentNode){ this.Shim.parentNode.removeChild(this.Shim); } this.Element=null; this.Shim=null; };};function GetRadProgressArea(K){return window[K]; } ; if (typeof(RadUploadNameSpace)=="undefi\x6e\x65\144")RadUploadNameSpace= {} ; RadUploadNameSpace.k="Panel"; RadUploadNameSpace.RadProgressArea= function (J){ this.Id=J[0]; this.OnClientProgressUpdating=J[1]; this.OnClientProgressBarUpdating=J[2]; this.H=J[3]; if (!this.H){alert("Could not \x66\151n\x64\x20an \x69nstanc\x65\040\x6ff RadP\x72\157\x67ress\x4d\141n\x61\147e\x72 on t\x68\145\x20\160a\x67e. A\x72e \x79ou m\x69ssin\x67 the\x20cont\x72ol \x64ecla\x72ati\x6fn?"); }RadControlsNamespace.EventMixin.Initialize(this ); RadControlsNamespace.DomEventsMixin.Initialize(this ); this.Element=document.getElementById(this.Id); this.PrimaryProgressBarElement=this.FindElement("\x50rimaryProg\x72\x65ssBa\x72"); this.PrimaryTotalElement=this.FindElement("\x50\x72imary\x54\x6ftal"); this.PrimaryValueElement=this.FindElement("\x50\162ima\x72\x79Valu\x65"); this.PrimaryPercentElement=this.FindElement("\x50rimaryPer\x63\x65nt"); this.SecondaryProgressBarElement=this.FindElement("Second\x61\x72yProg\x72\x65ssB\x61\162"); this.SecondaryTotalElement=this.FindElement("Secondary\x54\x6ftal"); this.SecondaryValueElement=this.FindElement("Second\x61\x72yValu\x65"); this.SecondaryPercentElement=this.FindElement("\x53econd\x61\x72yPerc\x65\x6et"); this.h=this.FindElement("CurrentOpe\x72\x61tion"); this.TimeElapsedElement=this.FindElement("\x54imeE\x6c\x61psed"); this.TimeEstimatedElement=this.FindElement("\124im\x65\x45stimat\x65\x64"); this.SpeedElement=this.FindElement("Speed"); this.CancelButtonElement=this.FindElement("\x43\x61ncelBu\x74\x74on"); this.CancelClicked= false; if (this.CancelButtonElement){ this.AttachDomEvent(this.CancelButtonElement,"\x63lick","Ca\x6e\x63elReque\x73\x74"); }if (typeof(RadUploadNameSpace.ProgressAreas)=="u\x6e\x64efined"){RadUploadNameSpace.ProgressAreas=[]; } this.RegisterForAutomaticDisposal("\x48ide"); RadUploadNameSpace.ProgressAreas[RadUploadNameSpace.ProgressAreas.length]=this ; } ; RadUploadNameSpace.RadProgressArea.prototype= {Update:function (G){if (this.RaiseEvent("O\x6eClientProgr\x65ssUpdati\x6eg", {ProgressData:G } )== false)return; this.Show(); if (this.RaiseEvent("\x4fnClie\x6e\x74Prog\x72\x65ssB\x61\x72Upd\x61\164i\x6e\147", {ProgressValue:G.PrimaryPercent,ProgressBarElementName: "\x50rimaryP\x72\x6fgres\x73\x42ar",ProgressBarElement: this.PrimaryProgressBarElement } )!= false){ this.UpdateHorizontalProgressBar(this.PrimaryProgressBarElement,G.PrimaryPercent); }if (this.RaiseEvent("OnClient\x50\x72ogre\x73\x73Bar\x55\160d\x61\x74in\x67", {ProgressValue:G.SecondaryPercent,ProgressBarElementName: "S\x65\x63ondary\x50\x72ogre\x73\x73Ba\x72",ProgressBarElement: this.SecondaryProgressBarElement } )!= false){ this.UpdateHorizontalProgressBar(this.SecondaryProgressBarElement,G.SecondaryPercent); } this.UpdateTextIndicator(this.PrimaryTotalElement,G.PrimaryTotal); this.UpdateTextIndicator(this.PrimaryValueElement,G.PrimaryValue); this.UpdateTextIndicator(this.PrimaryPercentElement,G.PrimaryPercent); this.UpdateTextIndicator(this.SecondaryTotalElement,G.SecondaryTotal); this.UpdateTextIndicator(this.SecondaryValueElement,G.SecondaryValue); this.UpdateTextIndicator(this.SecondaryPercentElement,G.SecondaryPercent); this.UpdateTextIndicator(this.h,G.CurrentOperationText); this.UpdateTextIndicator(this.TimeElapsedElement,G.TimeElapsed); this.UpdateTextIndicator(this.TimeEstimatedElement,G.TimeEstimated); this.UpdateTextIndicator(this.SpeedElement,G.Speed); } ,Show:function (){ this.Element.style.display=""; if (this.Element.style.position=="ab\x73olute"){if (typeof(this.Overlay)=="\165nd\x65\x66ined"){ this.Overlay=new RadControlsNamespace.Overlay(this.Element); } this.Overlay.Update(); }} ,Hide:function (){ this.Element.style.display="none"; if (this.Overlay){ this.Overlay.Dispose(); this.Overlay=null; }} ,UpdateHorizontalProgressBar:function (l,g){if (l && typeof(g)!="und\x65\x66ined")l.style.width=g+"%"; } ,UpdateVerticalProgressBar:function (l,g){if (l && typeof(g)!="undef\x69\x6eed")l.style.height=g+"\x25"; } ,UpdateTextIndicator:function (l,text){if (l && typeof(text)!="\x75ndefin\x65\x64"){if (typeof(l.value)=="string")l.value=text; else if (typeof(l.innerHTML)=="s\x74\x72ing")l.innerHTML=text; }} ,CancelRequest:function (){ this.CancelClicked= true; } ,FindElement:function (F){var f=this.Id+"_"+RadUploadNameSpace.k+"\x5f"+F; return document.getElementById(f); }};;function GetRadProgressManager(K){return window[K]; } ; if (typeof(RadUploadNameSpace)=="undefined")RadUploadNameSpace= {} ; RadUploadNameSpace.RadProgressManager= function (J){RadControlsNamespace.EventMixin.Initialize(this ); RadControlsNamespace.DomEventsMixin.Initialize(this ); this.D=Math.max(J[0],50); var d=J[1]; this.EnableMemoryOptimizationIdentifier=J[2]; this.UniqueRequestIdentifier=J[3]; this.C=J[4]; this.OnClientProgressStarted=J[5]; this.OnClientProgressUpdating=J[6]; this.FormId=J[7]; this.c=J[8]; this.EnableMemoryOptimization=J[9]; this.SuppressMissingHttpModuleError=J[10]; this.OnClientSubmitting=J[11]; this.TimeFormat="%HOU\x52\x53\x25:%M\x49\x4eUTES\x25:%SECON\x44\x53%s"; var form=document.getElementById(this.FormId); if (!form){form=document.forms[0]; } this.B(form); if (this.c== true){ this.RegisterForSubmit(form); } this.o0=this.O0(d); this.l0= false; if (typeof(RadUploadNameSpace.ProgressAreas)=="undefine\x64"){RadUploadNameSpace.ProgressAreas=[]; }} ; RadUploadNameSpace.RadProgressManager.prototype= {ClientSubmitHandler:function (N){if (this.RaiseEvent("\x4fnClientSu\x62\x6ditti\x6e\x67")== false){ this.CancelEvent(N); return false; } this.StartProgressPolling(); } ,StartProgressPolling:function (){ this.InitSelectedFilesCount(); this.RaiseEvent("On\x43\154\x69\x65ntPr\x6f\x67res\x73\x53tar\x74\x65d"); this.i0=new Date(); this.MakeCallback(); } ,MakeCallback:function (){if (!this.l0){ this.l0= true; this.I0(); }} ,HandleCallback:function (){if (this.o1.readyState!=4)return; this.l0= false; if (this.ErrorOccured())return; var responseText=this.o1.responseText; if (responseText){try {eval(responseText); }catch (ex){ this.O1(); return; }if (rawProgressData){if (this.EnableMemoryOptimization== true && !this.SuppressMissingHttpModuleError && rawProgressData.ProgressError){alert(rawProgressData.ProgressError); return; }if (rawProgressData.InProgress){if (this.l1>0 || rawProgressData.RadProgressContextCustomCounters){ this.ModifyProgressData(rawProgressData); if (!this.UpdateProgressAreas(rawProgressData)){window.location.href=window.location.href; return; }}}}}window.setTimeout(this.CreateEventHandler("\x4da\x6b\x65Callba\x63\x6b"),this.D); } ,ErrorOccured:function (){if (!document.all)return false; if (this.o1.status==404){ this.i1(); }else if (this.o1.status>0 && this.o1.status!=200){ this.I1(); }else return false; return true; } ,i1:function (){alert("r.a.d.up\x6coad Ajax\x20\x63allb\x61\143k\x20\x65rro\x72\056\x20Sou\x72ce url\x20\167a\x73 not \x66\157u\x6ed: \012\x0d\012\x0d"+this.o0+"\012\015\x0a\015\x44\151d\x20\x79ou\x20\x72egi\x73\164e\x72\x20th\x65 RadU\x70\154o\x61dProg\x72\145\x73\163H\x61ndle\x72 in \x77eb.c\x6fnfi\x67?"+"\015\x0a\015\012\x50leas\x65\x2c s\x65\x65 th\x65\x20he\x6c\x70 f\x6fr mor\x65\040d\x65\164a\x69ls: R\x61dUpl\x6f\141d\x202.0 \x2d Usi\x6eg r\x2ea.d.\x75ploa\x64 - \x43onfi\x67ura\x74ion\x20- R\x61dUp\x6coad\x50ro\x67res\x73Ha\x6edle\x72."); } ,I1:function (){alert("r.a.\x64\x2euploa\x64\x20Ajax\x20\143a\x6c\x6cba\x63\x6b er\x72\157\x72\056\x20\x53ou\x72\143e\x20url r\x65turne\x64 erro\x72: "+this.o1.status+"\x20\012\x0d\x0a\015"+this.o1.o2+" \012\x0d\012\x0d"+this.o0+"\012\x0d\012\015\x44id y\x6f\x75 r\x65\x67ist\x65\x72 t\x68\x65 R\x61dUplo\x61\x64Pr\x6fgress\x48\141n\x64ler \x69\156\x20\167\x65b.co\x6efig?"+"\x0d\012\x0d\x0aPleas\x65\x2c se\x65\x20the\x20\x68el\x70\x20for\x20more \x64\145t\x61\151\x6c\163:\x20RadUp\x6coad \x32\056\x30 - U\x73ing \x72.a.d\x2eupl\x6fad -\x20Con\x66igur\x61tio\x6e - \x52adU\x70loa\x64Pr\x6fgre\x73sH\x61ndl\x65r."); } ,O1:function (){alert("\x72.a.d.uplo\x61\x64 Aja\x78\x20ca\x6c\x6cbac\x6b\x20err\x6f\162\x2e\040S\x6furce u\x72l retu\x72ned i\x6e\166\x61\154i\x64 con\x74ent:\x20\012\x0d\012\x0d"+this.o1.responseText+"\x0a\015\x0a\x0d"+this.o0+"\x0a\015\012\x0dDid yo\x75\x20re\x67\x69ste\x72\x20th\x65\x20Ra\x64\125p\x6c\157a\x64Progr\x65\163s\x48andle\x72 in \x77\145\x62.con\x66ig?"+"\x0d\012\x0d\x0aPleas\x65\x2c se\x65\x20the\x20\150e\x6c\x70 f\x6f\162 \x6d\157r\x65 deta\x69\154s\x3a RadU\x70load \x32.0 -\x20Usin\x67 r.a\x2ed.u\x70\154\x6fad -\x20Con\x66igu\x72ati\x6fn -\x20Rad\x55plo\x61dPr\x6fgre\x73sH\x61ndl\x65r."); } ,UpdateProgressAreas:function (rawProgressData){ this.RaiseEvent("\x4fnClientPr\x6f\x67ress\x55\x70da\x74\x69ng", {ProgressData:rawProgressData } ); for (var i=0; i<RadUploadNameSpace.ProgressAreas.length; i++){var O2=RadUploadNameSpace.ProgressAreas[i]; if (O2.CancelClicked){return false; }O2.Update(rawProgressData); }return true; } ,ModifyProgressData:function (rawProgressData){var l2=new Date()-this.i0; if (typeof(rawProgressData.TimeElapsed)=="un\x64\x65fined")rawProgressData.TimeElapsed=this.GetFormattedTime(this.ToSeconds(l2)); if (rawProgressData.RadUpload){var i2=rawProgressData.RadUpload.RequestSize; var I2=rawProgressData.RadUpload.Bytes; if (typeof(rawProgressData.PrimaryTotal)=="unde\x66\x69ned")rawProgressData.PrimaryTotal=this.FormatBytes(i2); if (typeof(rawProgressData.PrimaryValue)=="undefined")rawProgressData.PrimaryValue=this.FormatBytes(I2); if (typeof(rawProgressData.PrimaryPercent)=="u\x6e\x64efined")rawProgressData.PrimaryPercent=Math.round(100*I2/i2); if (typeof(rawProgressData.SecondaryTotal)=="undefi\x6e\x65d")rawProgressData.SecondaryTotal=this.l1; if (typeof(rawProgressData.SecondaryValue)=="undefined")rawProgressData.SecondaryValue=rawProgressData.RadUpload.FilesCount; if (typeof(rawProgressData.SecondaryPercent)=="und\x65\x66ined")rawProgressData.SecondaryPercent=Math.round(100*rawProgressData.RadUpload.FilesCount/(this.l1!=0?this.l1: 1)); if (typeof(rawProgressData.CurrentOperationText)=="undefined")rawProgressData.CurrentOperationText=rawProgressData.RadUpload.CurrentFileName; if (typeof(rawProgressData.Speed)=="\x75\156def\x69\x6eed"){if (this.ToSeconds(l2)==0){rawProgressData.Speed=this.FormatBytes(0)+"\x2fs"; }else {rawProgressData.Speed=this.FormatBytes(rawProgressData.RadUpload.Bytes/this.ToSeconds(l2))+"\x2fs"; }}}if (typeof(rawProgressData.TimeEstimated)=="u\x6e\x64efined" && typeof(rawProgressData.PrimaryPercent)=="number"){if (rawProgressData.PrimaryPercent==0){rawProgressData.TimeEstimated=this.GetFormattedTime(this.ToSeconds(359999000)); }else {rawProgressData.TimeEstimated=this.GetFormattedTime(this.ToSeconds(l2*(100/rawProgressData.PrimaryPercent-1))); }}} ,ToSeconds:function (o3){return Math.round(o3/1000); } ,InitSelectedFilesCount:function (){ this.l1=0; var O3=document.getElementsByTagName("input"); for (var i=0; i<O3.length; i++){var l3=O3[i]; if (l3.type=="\146\x69\x6ce" && l3.value!=""){ this.l1++; }}} ,CancelEvent:function (N){if (!N)N=window.event; if (!N)return false; N.returnValue= false; N.cancelBubble= true; if (N.stopPropagation){N.stopPropagation(); }if (N.preventDefault){N.preventDefault(); }return false; } ,I0:function (){if (typeof(XMLHttpRequest)!="unde\x66ined"){ this.o1=new XMLHttpRequest(); }else if (typeof(ActiveXObject)!="\x75\156def\x69\x6eed"){ this.o1=new ActiveXObject("\x4dicros\x6f\x66t.XM\x4c\x48TTP"); }else return; this.o1.onreadystatechange=this.CreateEventHandler("\x48\x61ndleCa\x6c\x6cback"); this.o1.open("GET",this.i3(), true); this.o1.send(""); } ,I3:function (U,method){return function (){method.apply(U,arguments); } ; } ,O0:function (d){var o4=d.indexOf("?")<0?"\x3f": "\x26"; return d+o4+this.UniqueRequestIdentifier+"\x3d"+this.C; } ,i3:function (){return this.o0+"&RadUploadT\x69\x6deSt\x61\x6dp="+new Date().getTime(); } ,RegisterForSubmit:function (form){ this.O4(form); this.l4(form); } ,O4:function (form){var i4=this.CreateEventHandler("ClientSubmi\x74\x48and\x6c\x65r"); var I4=form.submit; try {form.submit= function (){if (i4()== false)return; form.submit=I4; form.submit(); };}catch (exception){try {var o5=__doPostBack; __doPostBack= function (eventTarget,eventArgument){var O5= true; if (typeof(Page_ClientValidate)=="function"){O5=Page_ClientValidate(); }if (O5){if (i4()== false)return; o5(eventTarget,eventArgument); }} ; }catch (exception){}}} ,l4:function (form){ this.AttachDomEvent(form,"submit","\x43lientS\x75\x62mitH\x61\x6edle\x72"); } ,B:function (form){if (typeof(form.action)=="\x75\x6edefine\x64")form.action=""; if (form.action.match(/\x3f/)){form.action=this.l5(form.action,this.UniqueRequestIdentifier); form.action=this.l5(form.action,this.EnableMemoryOptimizationIdentifier); if (form.action.substring(form.action.length-1)!="?"){form.action+="&"; }}else {form.action+="?";}form.action+=this.UniqueRequestIdentifier+"\x3d"+this.C; if (this.EnableMemoryOptimization){form.enctype=form.encoding="\x6dultipart/fo\x72\x6d-da\x74\x61"; }else {form.action+="\x26"+this.EnableMemoryOptimizationIdentifier+"=fa\x6c\x73e"; }} ,l5:function (i5,I5){var o6=new RegExp("\x26?"+I5+"\x3d[^&]\x2a"); if (i5.match(o6)){return i5.replace(o6,""); }return i5; } ,FormatBytes:function (O6){var l6=O6/1024; var i6=l6/1024; if (i6>.8){return ""+Math.round(i6*100)/100+"\x4dB"; }if (l6>.8){return ""+Math.round(l6*100)/100+"kB"; }return ""+O6+" byt\x65\x73"; } ,GetFormattedTime:function (I6){var o7=this.NormalizeTime(I6); return this.TimeFormat.replace(/\x25\x48\x4f\x55\x52\x53\x25/,o7.O7).replace(/\x25\x4d\x49\x4e\x55\x54\x45\x53\x25/,o7.l7).replace(/\x25\x53\x45\x43\x4f\x4e\x44\x53\x25/,o7.i7); } ,NormalizeTime:function (I7){var I6=I7%60; var o8=Math.floor(I7/60); var O8=o8%60; var l8=Math.floor(o8/60); return {O7:l8,l7:O8,i7:I6 };}} ;;RadUploadNameSpace.RadUploadEventArgs= function (i8){ this.FileInputField=i8; } ; RadUploadNameSpace.RadUploadDeleteSelectedEventArgs= function (I8){ this.FileInputFields=I8; } ;;if (typeof(window.RadControlsNamespace)=="\x75\156\x64\x65fine\x64"){window.RadControlsNamespace=new Object(); } ; RadControlsNamespace.AppendStyleSheet= function (o9,K,O9){if (!O9){return; }if (!o9){document.write("\x3c"+"\x6c\x69nk"+"\x20\x72el=\047\x73ty\x6c\x65she\x65t\047\x20type=\x27\x74ex\x74/css\x27 href\x3d\047"+O9+"\047\x20\057>"); }else {var l9=document.createElement("\x4cINK"); l9.rel="\x73tylesh\x65\x65t"; l9.type="text/css"; l9.href=O9; document.getElementById(K+"Style\x53\x68eetHo\x6c\x64er").appendChild(l9); }} ;;if (typeof(Sys) != "undefined"){if (Sys.Application != null && Sys.Application.notifyScriptLoaded != null){Sys.Application.notifyScriptLoaded();}}