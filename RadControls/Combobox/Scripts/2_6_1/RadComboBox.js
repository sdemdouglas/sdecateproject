if (typeof(window.RadControlsNamespace)=="\x75\x6edefined"){window.RadControlsNamespace=new Object(); } ; RadControlsNamespace.AppendStyleSheet= function (O,o,I){if (!I){return; }if (!O){document.write("\x3c"+"lin\x6b"+" r\x65\x6c=\047styles\x68\x65et\x27\040\x74\x79pe\x3d\x27te\x78\164\x2fcss\x27\x20hr\x65\146=\x27"+I+"\047\x20\x2f>"); }else {var A=document.createElement("\x4cIN\x4b"); A.rel="stylesheet"; A.type="t\x65\x78t/css"; A.href=I; document.getElementById(o+"Styl\x65\x53heetHo\x6c\x64er").appendChild(A); }} ; function RadComboItem(){ this.ComboBox=null; this.ClientID=null; this.Highlighted= false; this.Index=0; this.Enabled=1; this.Selected=0; this.Text=""; this.Value=null; this.U=new Array(); } ; RadComboItem.prototype.Initialize= function (Z){for (var z in Z){ this[z]=Z[z]; }} ; RadComboItem.prototype.W= function (){var w=0; var V=document.getElementById(this.ComboBox.ClientID+"\x5fDropDown"); if (V.offsetWidth!=V.scrollWidth+16){w=16; }if (this.ComboBox.Items.length>0){var totalHeight=0; for (var i=0; i<=this.Index; i++){var v=document.getElementById(this.ComboBox.Items[i].ClientID); if (v){totalHeight+=v.offsetHeight; }}V.scrollTop=totalHeight-V.offsetHeight+w; }} ; RadComboItem.prototype.T= function (){if (this.ComboBox.Items.length>0){var totalHeight=0; for (var i=0; i<this.Index; i++){var v=document.getElementById(this.ComboBox.Items[i].ClientID); if (v){totalHeight+=v.offsetHeight; }}var scrollTop=document.getElementById(this.ComboBox.ClientID+"_\x44ropDo\x77\x6e").scrollTop; if (scrollTop>totalHeight){document.getElementById(this.ComboBox.ClientID+"_\x44\x72opDown").scrollTop=totalHeight; }}} ; RadComboItem.prototype.Highlight= function (){if (!this.Highlighted && this.Enabled){ this.ComboBox.UnHighlightAll(); if (!this.ComboBox.IsTemplated || this.ComboBox.HighlightTemplatedItems){var t=document.getElementById(this.ClientID); if (t){if (!this.ComboBox.HighlightedItem){if (t.className!=this.ComboBox.ItemCssClassHover){ this.S=t.className; }else { this.S=this.ComboBox.ItemCssClass; }}t.className=this.ComboBox.ItemCssClassHover; }} this.Highlighted= true; this.ComboBox.HighlightedItem=this ; }} ; RadComboItem.prototype.UnHighlight= function (){if (this.Highlighted && this.Enabled && document.getElementById(this.ClientID)){document.getElementById(this.ClientID).className=this.S; this.Highlighted= false; this.ComboBox.HighlightedItem=null; }} ; RadComboItem.prototype.Select= function (){ this.ComboBox.SelectedItem=this ; this.ComboBox.R(this ); this.ComboBox.HideDropDown(); this.ComboBox.r= true; this.ComboBox.Q(); } ; function RadComboBox(P,N){var n=window[N]; if (n!=null && !n.tagName){n.Dispose(); }if (window.tlrkComboBoxes==null){window.tlrkComboBoxes=new Array(); }tlrkComboBoxes[tlrkComboBoxes.length]=this ; this.Items=new Array(); this.M= false; this.ID=P; this.ClientID=N; this.m=N; this.DropDownID=N+"\137DropD\x6f\x77n"; this.InputID=N+"\x5f\x49nput"; this.ImageID=N+"\x5fImage"; this.DropDownPlaceholderID=N+"_\x44\x72opDown\x50\x6caceh\x6f\154d\x65\162"; this.MoreResultsBoxID=N+"\x5fMoreResults\x42\x6fx"; this.MoreResultsBoxImageID=N+"\x5fMoreR\x65\x73ults\x42\x6fxIm\x61\147e"; this.MoreResultsBoxMessageID=N+"_MoreR\x65\x73ultsB\x6f\x78Mes\x73\141g\x65"; this.L=N+"_H\x65\x61der"; this.l=document.getElementById(this.InputID); this.K=document.getElementById(this.ImageID); this.k=document.getElementById(this.DropDownPlaceholderID); this.J=document.getElementById(this.ClientID+"_t\x65\x78t"); this.H=document.getElementById(this.ClientID+"_value"); this.h=document.getElementById(this.ClientID+"_index"); this.Enabled= true; this.DropDownVisible= false; this.LoadOnDemandUrl=null; this.PollTimeOut=0; this.HighlightedItem=null; this.SelectedItem=null; this.ItemRequestTimeout=300; this.EnableLoadOnDemand= false; this.AutoPostBack= false; this.ShowMoreResultsBox= false; this.OpenDropDownOnLoad= false; this.G= false; this.MarkFirstMatch= false; this.IsCaseSensitive= false; this.SelectOnTab= true; this.PostBackReference=null; this.LoadingMessage="Loa\x64\x69ng..."; this.ScrollDownImage=null; this.ScrollDownImageDisabled=null; this.g=null; this.RadComboBoxImagePosition="\x52ight"; this.ItemCssClass=null; this.ItemCssClassHover=null; this.ItemCssClassDisabled=null; this.ImageCssClass=null; this.ImageCssClassHover=null; this.InputCssClass=null; this.InputCssClassHover=null; this.LoadingMessageCssClass="\x43omboBoxLoad\x69\x6egMe\x73\x73age"; this.AutoCompleteSeparator=null; this.ExternalCallBackPage=null; this.OnClientSelectedIndexChanging=null; this.OnClientDropDownOpening=null; this.OnClientDropDownClosing=null; this.OnClientItemsRequesting=null; this.OnClientSelectedIndexChanged=null; this.OnClientItemsRequested=null; this.OnClientKeyPressing=null; this.Skin="\x43\x6cassic"; this.HideTimeoutID=0; this.F=0; this.f= false; this.D=null; this.AllowCustomText= false; this.ExpandEffectString=null; this.HighlightTemplatedItems= false; this.CausesValidation= false; this.ClientDataString=null; this.r= false; this.d=-1; this.IsTemplated= false; this.C=null; this.OffsetX=0; this.OffsetY=0; var comboInstance=this ; this.B(); this.o0= function (){comboInstance.HideOnClick(); } ; if (document.attachEvent){document.attachEvent("onclick",this.o0); }else {document.addEventListener("\x63lick",this.o0, false); } this.O0= function (e){comboInstance.l0(e || event); } ; if (document.attachEvent){document.getElementById(this.InputID).attachEvent("onblur",this.O0); }else {document.getElementById(this.InputID).addEventListener("blur",this.O0, false); } this.i0= function (){comboInstance.I0(); } ; if (document.attachEvent){document.getElementById(this.InputID).attachEvent("\x6f\x6efocus",this.i0); }else {document.getElementById(this.InputID).addEventListener("focus",this.i0, false); }document.getElementById(this.InputID).setAttribute("autoco\x6d\x70lete","off"); document.getElementById(this.DropDownPlaceholderID).onselectstart= function (){return false; } ; if (typeof(RadCallbackNamespace)!="undefi\x6e\x65d"){window.setTimeout( function (){comboInstance.o1(document.getElementById(comboInstance.InputID));} ,100); }else {var O1= false; if (window.addEventListener){ this.o1(document.getElementById(this.InputID));}else {if (document.getElementById(this.ClientID).offsetWidth==0){window.attachEvent("\x6fnload", function (){comboInstance.o1(document.getElementById(comboInstance.InputID)); } ); }else if (!O1){ this.o1(document.getElementById(this.InputID)); }}}if (window.attachEvent){window.attachEvent("\x6fnunlo\x61\x64", function (){comboInstance.Dispose(); } ); }else {window.addEventListener("\165\x6e\x6coad", function (){comboInstance.Dispose(); } , false); }} ; RadComboBox.prototype.ClearItems= function (){ this.Items=[]; document.getElementById(this.DropDownID).innerHTML=""; } ; RadComboBox.prototype.GetViewPortSize= function (){var width=0; var height=0; var l1=document.body; if (window.innerWidth){width=window.innerWidth; height=window.innerHeight; }else {if (document.compatMode && document.compatMode=="\x43S\x53\x31Compa\x74"){l1=document.documentElement; }width=l1.clientWidth; height=l1.clientHeight; }width+=l1.scrollLeft; height+=l1.scrollTop; return {width:width-6,height:height-6 } ; } ; RadComboBox.prototype.i1= function (el){var parent=null; var I1= {x: 0,y: 0 } ; var box; if (el.getBoundingClientRect){box=el.getBoundingClientRect(); var scrollTop=document.documentElement.scrollTop || document.body.scrollTop; var scrollLeft=document.documentElement.scrollLeft || document.body.scrollLeft; I1.x=box.left+scrollLeft-2; I1.y=box.top+scrollTop-2; return I1; }else if (document.getBoxObjectFor){box=document.getBoxObjectFor(el); I1.x=box.x-2; I1.y=box.y-2; }else {I1.x=el.offsetLeft; I1.y=el.offsetTop; parent=el.offsetParent; if (parent!=el){while (parent){I1.x+=parent.offsetLeft; I1.y+=parent.offsetTop; parent=parent.offsetParent; }}}if (window.opera){parent=el.offsetParent; while (parent && parent.tagName!="\102ODY" && parent.tagName!="\x48TML"){I1.x-=parent.scrollLeft; I1.y-=parent.scrollTop; parent=parent.offsetParent; }}else {parent=el.parentNode; while (parent && parent.tagName!="BODY" && parent.tagName!="HTML"){I1.x-=parent.scrollLeft; I1.y-=parent.scrollTop; parent=parent.parentNode; }}return I1; } ; RadComboBox.prototype.Dispose= function (){try {tlrkComboBoxes[this.ID]=null; this.Items=null; this.l=null; this.K=null; this.k=null; this.J=null; this.H=null; this.h=null; this.g=null; this.OnClientSelectedIndexChanging=null; this.OnClientDropDownOpening=null; this.OnClientDropDownClosing=null; this.OnClientItemsRequesting=null; this.OnClientSelectedIndexChanged=null; this.OnClientItemsRequested=null; this.OnClientKeyPressing=null; var comboInstance=this ; if (document.detachEvent){document.detachEvent("o\x6eclick",this.o0); }else {document.removeEventListener("c\x6c\x69ck",this.o0, false); }if (document.detachEvent){document.getElementById(this.InputID).detachEvent("onblur",this.O0); }else {document.getElementById(this.InputID).removeEventListener("blur",this.O0, false); }if (document.detachEvent){document.getElementById(this.InputID).detachEvent("o\x6e\x66ocus",this.i0); }else {document.getElementById(this.InputID).removeEventListener("\x66ocus",this.i0, false); }if (window.removeEventListener){window.removeEventListener("l\x6f\x61d", function (){comboInstance.o1(document.getElementById(comboInstance.InputID)); } , false); }var input=document.getElementById(this.InputID); if (input!=null)input.onblur=null; input=null; var o2=document.getElementById(this.DropDownPlaceholderID); if (o2!=null){o2.onselectstart=null; }o2=null; }catch (e){}} ; RadComboBox.prototype.Initialize= function (O2,Z){ this.l2(O2); this.i2(Z); this.I2(); this.o3(); } ; RadComboBox.prototype.l2= function (O2){for (var z in O2){ this[z]=O2[z]; }} ; RadComboBox.prototype.I2= function (){ this.ItemCssClass="\x43omboBoxI\x74\x65m_"+this.Skin; this.ItemCssClassHover="ComboBox\x49\x74emHo\x76\x65r_"+this.Skin; this.ItemCssClassDisabled="\x43omboBoxItemD\x69\x73abl\x65\x64_"+this.Skin; this.ImageCssClass="\x43omboBoxI\x6d\x61ge_"+this.Skin; this.ImageCssClassHover="\x43\x6fmboBox\x49\x6dageH\x6f\x76er_"+this.Skin; this.InputCssClass="ComboBoxInpu\x74\137"+this.Skin; this.InputCssClassHover="\x43omboB\x6f\x78Input\x48\x6fver\x5f"+this.Skin; this.LoadingMessageCssClass="C\x6f\x6dboBoxL\x6f\x61ding\x4d\x65ss\x61\x67e_"+this.Skin; } ; RadComboBox.prototype.R= function (item){if (item!=null){ this.O3(item.Text); this.SetValue(item.Value); this.l3(item.Index); }else { this.SetText(""); this.SetValue(""); this.l3("\x2d1"); }} ; RadComboBox.prototype.Q= function (){if (this.AutoPostBack){if (this.CausesValidation){if (typeof(WebForm_DoPostBackWithOptions)!="function" && !(typeof(Page_ClientValidate)!="fun\x63\x74ion" || Page_ClientValidate())){return; }}eval(this.PostBackReference); }} ; RadComboBox.prototype.l0= function (e){var i3=this.SelectedItem; var I3=this.HighlightedItem; if (i3!=null && I3!=null && i3!=I3){if (this.o4(this.OnClientSelectedIndexChanging,I3,e)== false){return; } this.R(I3); this.O4(); }var l4=this.C; var i4=this.GetText(); if (l4!=i4 && this.AllowCustomText){ this.SetText(this.GetText()); if (!this.r){if (I3!=null || l4!=i4){if (this.o4(this.OnClientSelectedIndexChanging,I3,e)== false){return; }if (I3!=null && I3.Text!=this.GetText()){ this.SetText(I3.Text); this.SetValue(I3.Value); } this.Q(); }}else { this.r= false; }}} ; RadComboBox.prototype.I0= function (e){ this.C=this.GetText(); this.I4(); };RadComboBox.prototype.o5= function (){var O5=document.getElementById(this.m); while (O5.tagName!="F\x4fRM"){O5=O5.parentNode; }return O5; } ; RadComboBox.prototype.l5= function (){var o2=document.getElementById(this.DropDownPlaceholderID); var i5=o2.getElementsByTagName("\x69nput"); return i5.length>0; };RadComboBox.prototype.I5= function (){if ((!document.readyState || document.readyState=="\x63\157\x6d\x70lete") && (!this.f)){var parentElement=document.body; if (this.l5()){parentElement=this.o5(); }var o2=document.getElementById(this.m).getElementsByTagName("\x64iv")[0]; o2.parentNode.removeChild(o2); o2.style.marginLeft="\x30"; var o6=document.getElementById(this.DropDownPlaceholderID); if (o6){o6.parentNode.removeChild(o6); }if (parentElement.firstChild){parentElement.insertBefore(o2,parentElement.firstChild); }else {parentElement.appendChild(o2); } this.f= true; this.k=document.getElementById(this.DropDownPlaceholderID); }} ; RadComboBox.prototype.HideOnClick= function (){var comboInstance=this ; this.HideTimeoutID=window.setTimeout( function (){comboInstance.DoHideOnClick(); } ,5); } ; RadComboBox.prototype.DoHideOnClick= function (){if (this.HideTimeoutID){ this.HideDropDown(); }} ; RadComboBox.prototype.ClearHideTimeout= function (){ this.HideTimeoutID=0; } ; RadComboBox.prototype.O6= function (text){var lastIndex=-1; for (var i=0; i<this.AutoCompleteSeparator.length; i++){var l6=this.AutoCompleteSeparator.charAt(i); var i6=text.lastIndexOf(l6); if (i6>lastIndex){lastIndex=i6; }}return lastIndex; } ; RadComboBox.prototype.O3= function (I6){var o7=-1; var O7=this.GetText(); if (this.AutoCompleteSeparator!=null){o7=this.O6(O7); }var i4=O7.substring(0,o7+1)+I6; this.SetText(i4); } ; RadComboBox.prototype.ClearSelection= function (){ this.R(null); this.SelectedItem=null; this.l7=null; } ; RadComboBox.prototype.i2= function (Z){for (var i=0; i<Z.length; i++){var item=new RadComboItem(); item.ComboBox=this ; item.Index=this.Items.length; item.Initialize(Z[i]); this.Items[this.Items.length]=item; if (item.Selected && !this.AllowCustomText){ this.SetText(item.Text); this.SetValue(item.Value); }}} ; RadComboBox.prototype.o3= function (){if (this.SelectedItem!=null){ this.SelectedItem.Highlight(); }else {var i7; var I7=this.GetValue(); i7=this.FindItemByValue(I7); if (i7==null){var O7=this.GetText(); i7=this.FindItemByText(O7); }if (i7!=null){ this.SelectedItem=i7; this.SelectedItem.Highlight(); }} this.M= true; if (this.SelectedItem==null && this.d==-1 && this.Items.length>0){ this.SelectedItem=this.Items[0]; this.Items[0].Selected= true; this.SelectedItem.Highlight(); }var comboInstance=this ; if (this.OpenDropDownOnLoad){if (window.attachEvent){window.attachEvent("o\x6e\x6c\x6fad", function (){comboInstance.ShowDropDown(); } ); }else {window.addEventListener("loa\x64", function (){comboInstance.ShowDropDown(); } , false); }}} ; RadComboBox.prototype.o8= function (Z,O8){if (!O8){ this.Items.length=0; } this.HighlightedItem=null; this.SelectedItem=null; this.M= false; if (this.Items.length>0){if (this.Items[0].Text==document.getElementById(this.InputID).value){ this.SetValue(this.Items[0].Value); }else { this.SetValue(""); } this.D=this.GetText(); } this.i2(Z); } ; RadComboBox.prototype.SetText= function (I6){document.getElementById(this.InputID).value=I6; this.J.value=I6; } ; RadComboBox.prototype.GetText= function (){return document.getElementById(this.InputID).value; } ; RadComboBox.prototype.SetValue= function (value){if (value || value==""){ this.H.value=value; }} ; RadComboBox.prototype.GetValue= function (){return this.H.value; } ; RadComboBox.prototype.l3= function (index){ this.h.value=index; } ; RadComboBox.prototype.l8= function (el){var parent=null; var I1=[]; var box; if (el.getBoundingClientRect){box=el.getBoundingClientRect(); var scrollTop=document.documentElement.scrollTop || document.body.scrollTop; var scrollLeft=document.documentElement.scrollLeft || document.body.scrollLeft; var x=box.left+scrollLeft-2; var y=box.top+scrollTop-2; return [x,y]; }else if (document.getBoxObjectFor){box=document.getBoxObjectFor(el); I1=[box.x-1,box.y-1]; }else {I1=[el.offsetLeft,el.offsetTop]; parent=el.offsetParent; if (parent!=el){while (parent){I1[0]+=parent.offsetLeft; I1[1]+=parent.offsetTop; parent=parent.offsetParent; }}}if (window.opera){parent=el.offsetParent; while (parent && parent.tagName.toUpperCase()!="\x42\x4fDY" && parent.tagName.toUpperCase()!="HTML"){I1[0]-=parent.scrollLeft; I1[1]-=parent.scrollTop; parent=parent.offsetParent; }}else {parent=el.parentNode; while (parent && parent.tagName.toUpperCase()!="BODY" && parent.tagName.toUpperCase()!="\x48TML"){I1[0]-=parent.scrollLeft; I1[1]-=parent.scrollTop; parent=parent.parentNode; }}return I1; } ; RadComboBox.prototype.i8= function (x,y){if (document.readyState && document.readyState!="complete"){return; }var I8=(navigator.userAgent.toLowerCase().indexOf("sa\x66ari")!=-1); var o9=window.opera; if (I8 || o9 || (!document.all)){return; }if (this.g==null){ this.g=document.createElement("IFRAM\x45"); this.g.src="\x6aavascr\x69\x70t:\047\047"; this.g.id=this.ClientID+"_Ove\x72\x6cay"; this.g.frameBorder=0; this.g.style.position="\x61bsolute"; this.g.style.display="none"; this.I5(); this.k.parentNode.insertBefore(this.g,this.k); this.g.style.zIndex=this.k.style.zIndex-1; } this.g.style.left=x; this.g.style.top=y; var O9=this.k.offsetWidth; var l9=this.k.offsetHeight; this.g.style.width=O9+"px"; this.g.style.height=l9+"px"; this.g.style.display=""; } ; RadComboBox.prototype.i9= function (){var I8=(navigator.userAgent.toLowerCase().indexOf("s\x61fari")!=-1); var o9=window.opera; if (I8 || o9 || (!document.all)){return; }if (this.g!=null){ this.g.style.display="none"; }} ; RadComboBox.prototype.I9= function (){for (var i=0; i<tlrkComboBoxes.length; i++){if (tlrkComboBoxes[i].ClientID!=this.ClientID){tlrkComboBoxes[i].HideDropDown(); }}} ; RadComboBox.prototype.B= function (){var el=document.getElementById(this.ClientID+"_w\x72apper"); while (el.tagName.toLowerCase()!="h\x74\x6dl"){if (el.dir){ this.oa=(el.dir.toLowerCase()=="rtl"); return; }el=el.parentNode; } this.oa= false; };RadComboBox.prototype.ShowDropDown= function (){if (this.o4(this.OnClientDropDownOpening,this )== false){return; } this.I9(); this.I5(); var Oa; (this.RadComboBoxImagePosition=="\x52\151gh\x74" && !this.oa)?Oa=this.l:Oa=document.getElementById(this.ImageID); var position=this.l8(Oa); var x=position[0]+this.OffsetX; var y=position[1]+Oa.offsetHeight+this.OffsetY; var la=document.getElementById(this.m); ia=la.offsetWidth; if (this.ExpandEffectString!=null && document.all){try { this.k.style.filter=this.ExpandEffectString; this.k.filters[0].Apply(); this.k.filters[0].Play(); }catch (e){}}if (this.oa){ this.k.dir="\x72tl"; }var Ia=this.GetViewPortSize(); this.k.style.position="ab\x73\x6flute"; if (window.netscape || window.opera){ia-=2; } this.k.style.width=ia+"px"; this.k.style.display="\x62\154ock"; if (this.ob(Ia,this.k,Oa)){var Ob=y-this.k.offsetHeight-Oa.offsetHeight; if (Ob>0){y=Ob; }} this.k.style.left=x+"p\x78"; this.k.style.top=y+"\x70x"; this.i8(x+"px",y+"px"); if (this.HighlightedItem!=null){ this.HighlightedItem.W(); }if (this.SelectedItem!=null){ this.SelectedItem.W(); } this.ClearHideTimeout(); this.DropDownVisible= true; try {document.getElementById(this.InputID).focus(); }catch (e){} ; if ((this.EnableLoadOnDemand) && (this.Items.length==0)){ this.lb( true ,null); }if (this.SelectedItem!=null){ this.SelectedItem.Highlighted= false; this.SelectedItem.Highlight(); this.SelectedItem.T(); }} ; RadComboBox.prototype.ob= function (Ia,t,Oa){var ib=this.i1(Oa).y+t.offsetHeight; return ib>Ia.height; } ; RadComboBox.prototype.FindItemByText= function (I6){for (var i=0; i<this.Items.length; i++){if (this.Items[i].Text==I6){return this.Items[i]; }}return null; } ; RadComboBox.prototype.FindItemByValue= function (Ib){for (var i=0; i<this.Items.length; i++){if (this.Items[i].Value==Ib){return this.Items[i]; }}return null; } ; RadComboBox.prototype.HideDropDown= function (){if (this.DropDownVisible){if (this.o4(this.OnClientDropDownClosing,this )== false){return; }document.getElementById(this.DropDownPlaceholderID).style.display="n\x6fne"; this.i9(); this.DropDownVisible= false; this.oc(); }} ; RadComboBox.prototype.oc= function (){ this.o4(this.OnClientBlur,this );};RadComboBox.prototype.I4= function (){ this.o4(this.OnClientFocus,this );};function trace(Oc){document.body.appendChild(document.createTextNode(Oc)); document.body.appendChild(document.createElement("HR")); }RadComboBox.prototype.ToggleDropDown= function (){ (this.DropDownVisible)?this.HideDropDown(): this.ShowDropDown(); } ; RadComboBox.prototype.lc= function (ic){if (ic){while (ic!=null){if (ic.id && this.Ic(ic.id)){return ic; }ic=ic.parentNode; }}return null; } ; RadComboBox.prototype.Ic= function (od){for (var i=0; i<this.Items.length; i++){if (this.Items[i].ClientID==od){return true; }}return false; } ; RadComboBox.prototype.Od= function (item){for (var i=0; i<this.Items.length; i++){if (this.Items[i].ClientID==item.id){return this.Items[i]; }}return null; } ; RadComboBox.prototype.ld= function (oe){oe.Highlight(); } ; RadComboBox.prototype.Oe= function (oe){oe.UnHighlight(); } ; RadComboBox.prototype.O4= function (eventArgs){var le=this.HighlightedItem; if (le!=null){if (this.o4(this.OnClientSelectedIndexChanging,le,eventArgs)== false){return; }le.Select(); this.o4(this.OnClientSelectedIndexChanged,le,eventArgs); } this.HideDropDown(); } ; RadComboBox.prototype.HandleClick= function (eventArgs){ this.O4(eventArgs); } ; RadComboBox.prototype.ie= function (index){var i=index; var Ie= false; while (i<this.Items.length-1){i=i+1; if (this.Items[i].Enabled){Ie= true; break; }}if (Ie)return i; return index; } ; RadComboBox.prototype.of= function (index){var i=index; var Ie= false; while (i>0){i=i-1; if (this.Items[i].Enabled){Ie= true; break; }}if (Ie)return i; return index; } ; RadComboBox.prototype.Of= function (comboInstance,eventArgs){ this.o4(this.OnClientKeyPressing,this,eventArgs); var keyCode=eventArgs.keyCode; if (keyCode==46 && !this.EnableLoadOnDemand && !this.AllowCustomText){ this.If(eventArgs); }if (keyCode==40){if (eventArgs.altKey && (!this.DropDownVisible)){ this.ShowDropDown(); return; }var index=0; if (this.HighlightedItem!=null){index=this.ie(this.HighlightedItem.Index); }if (index>=0 && this.Items.length>0){if (this.o4(this.OnClientSelectedIndexChanging,this.Items[index],eventArgs)== false){return; } this.Items[index].Highlight(); this.Items[index].W(); this.R(this.Items[index]); this.If(eventArgs); }return; }if (keyCode==27 && this.DropDownVisible){ this.HideDropDown(); return; }if (keyCode==38){if (eventArgs.altKey && this.DropDownVisible){ this.HideDropDown(); return; }var index=-1; if (this.HighlightedItem!=null){index=this.of(this.HighlightedItem.Index); }if (index>=0){if (this.o4(this.OnClientSelectedIndexChanging,this.Items[index],eventArgs)== false){return; } this.Items[index].T(); this.Items[index].Highlight(); this.R(this.Items[index]); this.If(eventArgs); }return; }if ((keyCode==13 || keyCode==9) && this.DropDownVisible){if (keyCode==13){ this.If(eventArgs); }if (!this.SelectOnTab && keyCode==9){if (this.AutoPostBack){ this.Q(); } this.HideDropDown(); return; } this.O4(); return; }if (keyCode==9 && !this.DropDownVisible){ this.oc(); return; }if (keyCode==35 || keyCode==36 || keyCode==37 || keyCode==39){return; }if (this.EnableLoadOnDemand && (!eventArgs.altKey) && (!eventArgs.ctrlKey) && (!(keyCode==16))){if (!this.DropDownVisible){ this.ShowDropDown(); } this.og( false ,keyCode); return; }if ((keyCode<32 && keyCode!=8) || (keyCode>=33 && keyCode<=46) || (keyCode>=112 && keyCode<=123) || (eventArgs.altKey== true)){return; }var Og=this ; window.setTimeout( function (){Og.HighlightMatches();} ,20); } ; RadComboBox.prototype.lg= function (eventArgs){if (eventArgs.preventDefault){if (eventArgs.keyCode==13 || (eventArgs.keyCode==32 && (!this.EnableLoadOnDemand))){eventArgs.preventDefault(); }}} ; RadComboBox.prototype.ig= function (s){if (typeof(encodeURIComponent)!="u\x6edefi\x6e\x65d"){return encodeURIComponent(this.Ig(s)); }if (escape){return escape(this.Ig(s)); }} ; RadComboBox.prototype.Ig= function (text){if (typeof(text)!="\x6eumber"){return text.replace(/\x27/g,"\x26\x73quote"); }} ; RadComboBox.prototype.oh= function (){if (typeof(XMLHttpRequest)!="\x75ndefined"){return new XMLHttpRequest(); }if (typeof(ActiveXObject)!="\x75\x6edefined"){return new ActiveXObject("\x4d\x69crosoft\x2e\x58MLH\x54\x54P"); }} ; RadComboBox.prototype.Oh= function (lh,ih,Ih,oi){lh=lh.replace(/\x27/g,"&\x73\x71uote"); var url=window.unescape(this.LoadOnDemandUrl)+"\x26\164\x65\x78t="+this.ig(lh); url=url+"&comb\x6f\x54ext="+this.ig(ih); url=url+"\x26comboVa\x6c\x75e="+this.ig(Ih); url=url+"\x26skin="+this.ig(this.Skin); if (oi){url=url+"&\x69\x74emCount\x3d"+this.Items.length; }if (this.ExternalCallBackPage!=null){url=url+"&external=\x74\x72ue"; }if (this.ClientDataString!=null){url+="&\x63\x6cientDat\x61\x53tri\x6e\x67="+this.ig(this.ClientDataString); }url=url+"&timeStamp="+encodeURIComponent((new Date()).getTime()); return url; } ; RadComboBox.prototype.Oi= function (oi,text,keyCode){if (!this.G){ this.G= true; var ih=this.GetText(); var Ih=this.GetValue(); var lh=(text)?text:ih; var ii=this.Oh(lh,ih,Ih,oi); var Ii=this ; var xmlRequest=this.oh(); xmlRequest.onreadystatechange= function (){if (xmlRequest.readyState!=4)return; Ii.oj(xmlRequest.responseText,oi,lh,keyCode,xmlRequest.status,ii); } ; xmlRequest.open("GET",ii, true); xmlRequest.send(""); }} ; RadComboBox.prototype.oj= function (Oj,oi,lh,keyCode,status,url){if (status==500){alert("r.a.d.comb\x6fbox: S\x65\x72ver\x20\145\x72ror in \x74\150e\x20Ite\x6d\x73Re\x71\165e\x73ted e\x76\x65nt\x20handl\x65r, p\x72\145\x73s o\x6b to \x76iew \x74he r\x65sult\x2e"); document.body.innerHTML=Oj; return; }if (status==404){alert("\x72.a.d.comb\x6f\x62ox: \x4c\x6fad \x4f\x6e De\x6d\x61nd\x20\x50ag\x65\040\x6eot fo\x75\156d\x3a "+url); var lj="r\x2e\x61.d.comb\x6f\x62ox:\x20\x4coad\x20\x4fn D\x65\x6dan\x64\x20Pa\x67\145 \x6e\157t\x20found\x3a\040"+url+"<br\x2f\x3e"; lj+="Please, try \x75\x73ing\x20\x45xte\x72\x6ealC\x61\x6clBa\x63kPage \x74\157 \x6d\141p\x20to th\x65\x20ex\x61ct lo\x63atio\x6e\040\x6ff t\x68e ca\x6c\154\x62ackp\x61ge y\x6fu a\x72e us\x69ng.";document.body.innerHTML=lj; return; }try {eval("var callBa\x63\x6bDat\x61\x20= "+Oj+";"); }catch (e){alert("r.\x61\x2ed.comb\x6f\x62ox: \x6c\x6fad \x6f\x6e de\x6d\x61nd\x20\143\x61\x6clb\x61\143k\x20\145r\x72or. P\x72\145\x73\163 \x45nte\x72 for \x6dore\x20\151\x6eform\x61tion"); var lj="If r.a.d.com\x62\157bo\x78\x20is \x6e\x6ft i\x6e\x69tia\x6c\x6cy \x76\151s\x69\142l\x65\040\x6f\156 \x79our A\x53PX pa\x67e, yo\x75 ma\x79 nee\x64 to \x75se s\x74ream\x65rs (\x74he \x45xte\x72nal\x6cCal\x6cBac\x6bPag\x65 pr\x6fpe\x72ty)"; lj+="<br/\x3e\x50lease,\x20\x72ead \x6f\165r\x20\x6fnli\x6e\x65 d\x6f\143u\x6d\145n\x74\141t\x69\157n\x20on th\x69\163 \x70robl\x65\155\x20for \x64etai\x6cs"; lj+="\x3c\x62r/><a \x68\x72ef=\x27\x68ttp\x3a\x2f/ww\x77\x2ete\x6c\x65ri\x6b\056\x63\157m\x2f\150e\x6cp/rad\x63\157\x6d\142o\x62ox/v\x32%5FN\x45T2/?\x63ombo\x5fexte\x72nal\x63allb\x61ckp\x61ge.\x68tml\x27>htt\x70:/\x2fwww\x2etel\x65rik\x2eco\x6d/h\x65lp/\x72ad\x63om\x62o\x62ox\x2fv2\x255F\x4eET\x32/c\x6fmb\x6f_\x65xt\x65rn\x61l\x63al\x6cb\x61ck\x70a\x67e\x2eht\x6dl\x3c/\x61>";document.body.innerHTML=lj; return; }if (this.GetText()!=callBackData.Text){ this.G= false; this.og( false ,null); return; }if (this.ShowMoreResultsBox){document.getElementById(this.MoreResultsBoxMessageID).innerHTML=callBackData.Message; }var ij=this.Items.length; this.o8(callBackData.Items,oi); if (oi){document.getElementById(this.DropDownID).removeChild(document.getElementById(this.ClientID+"\x5fLoadingDiv")); document.getElementById(this.DropDownID).innerHTML+=callBackData.DropDownHtml; if (this.Items[ij+1]!=null){ this.Items[ij+1].W(); }}else {document.getElementById(this.DropDownID).innerHTML=callBackData.DropDownHtml; } this.i8(this.k.style.left,this.k.style.top); this.o4(this.OnClientItemsRequested,this,lh,oi); this.G= false; var Ij=this.FindItemByText(this.GetText()); if (Ij!=null){Ij.Highlight(); Ij.W(); }if (!keyCode)return; if (keyCode<32 || (keyCode>=33 && keyCode<=46) || (keyCode>=112 && keyCode<=123) && keyCode!=8){return; } this.HighlightMatches(); };RadComboBox.prototype.ok= function (O7){var o7=-1; if (this.AutoCompleteSeparator!=null){o7=this.O6(O7); }var Ok=O7.substring(o7+1,O7.length); return Ok; } ; RadComboBox.prototype.lk= function (ik,Ik){if (!this.IsCaseSensitive){return (ik.toLowerCase()==Ik.toLowerCase()); }else {return (ik==Ik); }} ; RadComboBox.prototype.HighlightMatches= function (){if (!this.MarkFirstMatch)return; var O7=this.GetText(); var Ok=this.ok(O7); if (Ok.length==0){return; }for (var i=0; i<this.Items.length; i++){var ll=this.Items[i].Text; if (ll.length>=Ok.length){var il=ll.substring(0,Ok.length); if (this.lk(il,Ok)){var o7=-1; if (this.AutoCompleteSeparator!=null){o7=this.O6(O7); }var i4=O7.substring(0,o7+1)+ll; this.SetText(i4); this.SetValue(this.Items[i].Value); this.l3(this.Items[i].Index); if (this.o4(this.OnClientSelectedIndexChanging,this.Items[i],null)== false){return; } this.Items[i].Highlight(); this.Items[i].W(); var Il=o7+Ok.length+1; var om=i4.length-Il; if (document.all){var Om=document.getElementById(this.InputID).createTextRange(); Om.moveStart("\x63\x68\x61racte\x72",Il); Om.moveEnd("chara\x63\x74er",om); Om.select(); }else {document.getElementById(this.InputID).setSelectionRange(Il,Il+om); }return; }else { this.SetValue(""); this.l3(-1); if (this.HighlightedItem!=null){ this.HighlightedItem.UnHighlight(); }}}} this.SetValue(""); this.l3("\x2d1"); if (!this.AllowCustomText){var Im=O7.substring(0,O7.length-1); if (this.D!=null){ this.SetText(this.D); return; } this.SetText(Im); this.HighlightMatches(); }} ; RadComboBox.prototype.og= function (O8,keyCode){if (!this.G){var comboInstance=this ; if (this.F){window.clearTimeout(this.F); this.F=0; } this.F=window.setTimeout( function (){comboInstance.lb(O8,keyCode);} ,this.ItemRequestTimeout); }} ; RadComboBox.prototype.lb= function (O8,keyCode){var lh=document.getElementById(this.InputID).value; if (lh=="")lh= false; if (this.o4(this.OnClientItemsRequesting,this,lh,O8)== false){return; }if (!this.G){if (!document.getElementById(this.ClientID+"_\x4coadi\x6e\x67Div")){document.getElementById(this.DropDownID).innerHTML="<div id=\x27"+this.ClientID+"\x5f\x4coading\x44\x69v\047"+"\x20\x63lass=\047"+this.LoadingMessageCssClass+" \047\x3e"+this.LoadingMessage+"</div>"+document.getElementById(this.DropDownID).innerHTML; }}var comboInstance=this ; window.setTimeout( function (){comboInstance.Oi(O8,lh,keyCode);} ,20); } ; RadComboBox.prototype.RequestItems= function (text,O8){ this.Oi(O8,text,null); } ; RadComboBox.prototype.UnHighlightAll= function (){for (var i=0; i<this.Items.length; i++){if (this.Items[i].Highlighted){ this.Items[i].UnHighlight(); }}} ; RadComboBox.prototype.On= function (){document.getElementById(this.InputID).className=this.InputCssClass; var In=document.getElementById(this.ImageID); if (In){In.className=this.ImageCssClass; }} ; RadComboBox.prototype.oo= function (){document.getElementById(this.InputID).className=this.InputCssClassHover; var In=document.getElementById(this.ImageID); if (In){In.className=this.ImageCssClassHover; }} ; RadComboBox.prototype.Oo= function (){document.getElementById(this.MoreResultsBoxImageID).style.cursor="d\x65f\x61\x75lt"; document.getElementById(this.MoreResultsBoxImageID).src=this.ScrollDownImageDisabled; } ; RadComboBox.prototype.Io= function (){document.getElementById(this.MoreResultsBoxImageID).style.cursor="\x68\141\x6e\x64"; document.getElementById(this.MoreResultsBoxImageID).src=this.ScrollDownImage; } ; RadComboBox.prototype.op= function (){ this.UnHighlightAll(); this.og( true ,null); document.getElementById(this.InputID).focus(); } ; RadComboBox.prototype.Op= function (eventArgs){if (eventArgs.stopPropagation){eventArgs.stopPropagation(); }else {eventArgs.cancelBubble= true; }} ; RadComboBox.prototype.If= function (eventArgs){if (eventArgs.preventDefault){eventArgs.preventDefault(); }else {eventArgs.returnValue= false; }} ; RadComboBox.prototype.o4= function (lp,a,b,ip){if (!lp)return true; RadComboBoxGlobalFirstParam=a; RadComboBoxGlobalSecondParam=b; RadComboBoxGlobalThirdParam=ip; var s=lp; s=s+"(RadCo\x6dboBoxGlo\x62\x61lFi\x72stParam"; s=s+"\x2c\x52adCom\x62\x6fBox\x47\x6coba\x6cSecondP\x61\x72am"; s=s+",RadComboBo\x78\x47loba\x6c\x54hi\x72\x64Par\x61\155"; s=s+");"; return eval(s); } ; RadComboBox.prototype.HandleEvent= function (eventName,eventArgs){var oe; var srcElement=(document.all)?eventArgs.srcElement:eventArgs.target; var item=this.lc(srcElement); if (item!=null){oe=this.Od(item); }if (!this.Enabled){return; }switch (eventName){case "showd\x72opdown": this.Op(eventArgs); this.ShowDropDown(); break; case "hide\x64\x72opdow\x6e": this.Op(eventArgs); this.HideDropDown(); break; case "\x74oggledropdo\x77\x6e": this.Op(eventArgs); this.ToggleDropDown(); break; case "\x6d\157us\x65\x6fver":if (oe!=null)this.ld(oe); break; case "\x6douseout":if (oe!=null)this.Oe(oe); break; case "\x6bey\x70\x72ess": this.Of(this,eventArgs); break; case "ke\x79\x64own": this.lg(eventArgs); break; case "\x63lick": this.HandleClick(eventArgs); break; case "\x69\x6eputclic\x6b": this.Op(eventArgs); document.getElementById(this.InputID).select(); this.ShowDropDown(); break; case "in\x70\x75timage\x6f\x75t": this.On(); break; case "in\x70\x75timageh\x6f\x76er": this.oo(); break; case "mor\x65\x72esults\x69\x6dagec\x6cick": this.Op(eventArgs); this.op(); break; case "m\x6f\x72eresul\x74\x73imag\x65\x68ov\x65\x72": this.Io(); break; case "\x6dorere\x73\x75ltsim\x61\x67eou\x74": this.Oo(); break; }} ; RadComboBox.prototype.Enable= function (){document.getElementById(this.InputID).disabled= false; this.Enabled= true; } ; RadComboBox.prototype.Disable= function (){document.getElementById(this.InputID).disabled="\x64isable\x64"; this.Enabled= false; this.J.value=this.GetText(); } ; RadComboBox.prototype.o1= function (Ip){{var computedStyle=null; if (Ip.currentStyle){computedStyle=Ip.currentStyle; }else if (document.defaultView && document.defaultView.getComputedStyle){computedStyle=document.defaultView.getComputedStyle(Ip,null); }else {return; }var height=parseInt(computedStyle.height); var width=parseInt(Ip.offsetWidth); var paddingTop=parseInt(computedStyle.paddingTop); var paddingBottom=parseInt(computedStyle.paddingBottom); var paddingLeft=parseInt(computedStyle.paddingLeft); var paddingRight=parseInt(computedStyle.paddingRight); var borderTop=parseInt(computedStyle.borderTopWidth); if (isNaN(borderTop)){borderTop=0; }var borderBottom=parseInt(computedStyle.borderBottomWidth); if (isNaN(borderBottom)){borderBottom=0; }var borderLeft=parseInt(computedStyle.borderLeftWidth); if (isNaN(borderLeft)){borderLeft=0; }var borderRight=parseInt(computedStyle.borderRightWidth); if (isNaN(borderRight)){borderRight=0; }if (document.compatMode && document.compatMode=="\x43\x53\x531Comp\x61\x74"){if (!isNaN(height)){Ip.style.height=height-paddingTop-paddingBottom-borderTop-borderBottom+"\x70\x78"; }}if (!isNaN(width) && width){var oq=0; var In=Ip.parentNode.getElementsByTagName("\x69mg")[0]; if (In){oq=In.offsetWidth; }if (document.compatMode && document.compatMode=="\x43\x53S1Comp\x61\x74"){Ip.style.width=width-oq-paddingLeft-paddingRight-borderLeft-borderRight+"p\x78"; if (parseInt(Ip.style.width)!=Ip.offsetWidth){Ip.style.width=parseInt(Ip.style.width)+parseInt(Ip.style.width)-Ip.offsetWidth+"\x70x"; }}else {Ip.style.width=width-oq; }}}} ; function rcbDispatcher(N,eventName,eventArgs){var comboInstance=null; try {comboInstance=window[N]; }catch (e){}if (typeof(comboInstance)=="undefin\x65\x64" || comboInstance==null){return; }if (typeof(comboInstance.HandleEvent)!="und\x65\x66ined"){comboInstance.HandleEvent(eventName,eventArgs); }} ; function rcbAppendStyleSheet(o,I){var Oq=(navigator.appName=="Mic\x72\x6fsoft I\x6e\x74ern\x65t Explo\x72er") && ((navigator.userAgent.toLowerCase().indexOf("\x6dac")!=-1) || (navigator.appVersion.toLowerCase().indexOf("\x6dac")!=-1)); var I8=(navigator.userAgent.toLowerCase().indexOf("safari")!=-1); if (Oq || I8){document.write("\x3c"+"\x6c\x69nk"+"\x20rel=\047styles\x68\x65et\047 type=\x27\x74ext\x2f\143s\x73\047\x20href\x3d\047"+I+"\047>"); }else {var A=document.createElement("\x4cINK"); A.rel="\x73tylesheet"; A.type="text/css"; A.href=I; document.getElementById(o+"StyleShee\x74\x48olde\x72").appendChild(A); }} ;
if (typeof(Sys) != "undefined"){if (Sys.Application != null && Sys.Application.notifyScriptLoaded != null){Sys.Application.notifyScriptLoaded();}}