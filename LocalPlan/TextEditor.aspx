<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TextEditor.aspx.cs" Inherits="TextEditor" %>

<%@ Register Assembly="RadEditor.Net2" Namespace="Telerik.WebControls" TagPrefix="radE" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Text Editor</title>

</head>
<body style="background-color: white;">
    <form id="form1" runat="server">
    <script type="text/javascript">  
            function CloseAndRebind()  
            {  
                GetRadWindow().BrowserWindow.refreshPage(); 
                GetRadWindow().Close();                                                                 
            }  
              
            function GetRadWindow()  
            {  
                var oWindow = null;  
                if (window.radWindow) oWindow = window.radWindow; //Will work in Moz in all cases, including clasic dialog  
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;//IE (and Moz az well)  
                      
                return oWindow;  
            }  
  
            function CancelEdit()  
            {  
                GetRadWindow().Close();       
            }  
           
            </script>  
        <script type="text/javascript" language="javascript">
            if ("undefined" == typeof(RadEditorToolInitializer))
            {
               var RadEditorToolInitializer = {};
            }
            var oHolder;
            RadEditorToolInitializer["CustomRenderedTool"] = function (toolArgs)
            {
                function CustomRenderedTool(toolArgs)
                {
                    this.GetController = toolArgs.GetController;
                    this.Name = toolArgs.Name;
                }

                CustomRenderedTool.prototype.Create = function()
                {
                    var controller = this.GetController();
                    oHolder = document.createElement ("DIV");
                    oHolder.className = "CustomRenderedTool";
                    oHolder.Id = "Holder";
                    oHolder.style.width = "120px";
                    oHolder.style.height = "20px";
                    //oHolder.style.border = "1px solid red";
                    
                    return oHolder;
                };

                var tool = new CustomRenderedTool (toolArgs);
                return tool;
            };

            function OnClientLoad(editor)
            {
                editor.AttachEventHandler ("onkeydown", function (e)
                {
                    var content = editor.GetHtml();                   
                    var textContent = editor.GetText();
                                       
                    var words = 0;
                    var chars = 0;
                    if (content)
                    {
                        if (textContent)
                        {                           
                            //textContent.replace(/&nbsp;/ig,"a");
                            //alert(textContent);
                            chars = textContent.length;
                        }
                        else
                            chars = 0;
                      
                        
                        punctRegX = /[!\.?;,:&_\-\-\{\}\[\]\(\)~#'"]/g;
                        content = content.replace(punctRegX, "");
                        trimRegX = /(^\s+)|(\s+$)/g;
                        content = content.replace(trimRegX, "");
                        if (content)
                        {
                            splitRegX = /\s+/;
                            var array = content.split(splitRegX);
                            words = array.length;                            
                        }
                    }
                    oHolder.innerHTML = "<span style='line-height:22px'>" + "Character(s)" + " " + chars + "&nbsp;</span>";
                    }
                );
            }
            </script>

        
        <br />
        <br /> 
        
            <rade:radeditor OnClientLoad="OnClientLoad" 
            id="RadEditor1" 
            runat="server" 
            BackColor="White" 
            ConvertTagsToLower="True" 
            ConvertToXhtml="False" 
            DocumentsFilters="*.*" 
            EnableClientSerialize="True" 
            EnableContextMenus="False" 
            EnableDocking="True" 
            EnableEnhancedEdit="True" 
            EnableHtmlIndentation="True" 
            EnableServerSideRendering="True" 
            EnableTab="True" 
            ImagesFilters="*.gif,*.xbm,*.xpm,*.png,*.ief,*.jpg,*.jpe,*.jpeg,*.tiff,*.tif,*.rgb,*.g3f,*.xwd,*.pict,*.ppm,*.pgm,*.pbm,*.pnm,*.bmp,*.ras,*.pcd,*.cgm,*.mil,*.cal,*.fif,*.dsf,*.cmx,*.wi,*.dwg,*.dxf,*.svf" 
            MediaFilters="*.asf,*.asx,*.wm,*.wmx,*.wmp,*.wma,*.wax,*.wmv,*.wvx,*.avi,*.wav,*.mpeg,*.mpg,*.mpe,*.mov,*.m1v,*.mp2,*.mpv2,*.mp2v,*.mpa,*.mp3,*.m3u,*.mid,*.midi,*.rm,*.rma,*.rmi,*.rmv,*.aif,*.aifc,*.aiff,*.au,*.snd"
            OnClientCommandExecuted=""
             OnClientCommandExecuting="" 
             OnClientInit="" 
             OnClientModeChange=""
              OnClientSubmit=""
               PassSessionData="True" 
               RenderAsTextArea="False" 
               Skin="Telerik" 
               SpellEditDistance="1"
                TemplateFilters="*.html,*.htm"
                 ToolbarMode="Default"
                  ToolsWidth="" 
                  OnSubmitClicked="RadEditor1_SubmitClicked"
                   OnCancelClicked="RadEditor1_CancelClicked" 
                   Width="740px"
                    ToolsFile="~/Editor/SpellcheckerTypes/AjaxSpell.xml"
              Font-Names="Trebuchet MS" Font-Size="9pt" 
              ShowHtmlMode="False" 
              ShowPreviewMode="False" 
              SpellDictionaryPath="~\RadControls\spell\TDF\" CssFiles="~/RadControls/Editor/Skins/Telerik" >
                
            </rade:radeditor>
            <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label><br />
       
        <asp:Label ID="InjectScript" runat="server"></asp:Label>&nbsp;
    </form>
</body>
</html>
