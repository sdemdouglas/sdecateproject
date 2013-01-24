using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Telerik.WebControls;
using System.IO;
using System.Text;

public partial class DocumentLibrary_DocumentView : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected override void OnPreRenderComplete(EventArgs e)
    {
      
        Master.FindControl("level1").Visible = false;
       
    }
  
    protected void gDoc_ItemCreated(object sender, Telerik.WebControls.GridItemEventArgs e)
    {
        
            //FileUpload fu = e.Item.FindControl("fuPath") as FileUpload;
            //HiddenField hf = e.Item.FindControl("hfPath") as HiddenField;

            //if (fu != null)
            //{
            //    fu.Attributes.Add("onchange", "GetPathValue()");
            //    gDoc.Controls.Add(new LiteralControl("<script type='text/javascript'>window['fuPath'] ='" + fu.ClientID + "';</script>"));
            //}

            //if (hf != null)
            //{
            //    gDoc.Controls.Add(new LiteralControl("<script type='text/javascript'>window['hfPath'] ='" + hf.ClientID + "';</script>"));
         
            //}
    }
    protected void gDoc_InsertCommand(object source, GridCommandEventArgs e)
    {
        //FileUpload fu = e.Item.FindControl("fuPath") as FileUpload;
        //HiddenField hf = e.Item.FindControl("hfPath") as HiddenField;

        //if (fu != null && fu.HasFile)
          
        //    if (fu.PostedFile != null)
        //        if (fu.PostedFile.ContentLength != 0)
        //        {
        //            try
        //            {
        //                String destDir = Server.MapPath("Docs");
        //                String fileName = Path.GetFileName(fu.PostedFile.FileName).Replace(' ', '_');
        //                String destPath = Path.Combine(destDir, fileName);
        //                hf.Value = fileName;
        //                fu.PostedFile.SaveAs(destPath);
                        
        //            }
        //            catch (Exception err)
        //            {

        //            }
        //        }        
    }

    protected void gDoc_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem gridDataItem = e.Item as GridDataItem;
                StringBuilder stb = new StringBuilder();

                stb.Append(@"<a href=javascript:void(window.open('../renderfile.aspx?intid=");
                stb.Append(gridDataItem["key_doc_file_storage_id"].Text);
                stb.Append("'));>" + gridDataItem["txt_file_title"].Text + "</a>");
                gridDataItem["txt_file_title"].Text = stb.ToString();
            }
        }
        catch (Exception ex)
        {
        }
     
    }
    protected void gDoc_ItemCommand(object source, GridCommandEventArgs e)
    {
        //FileUpload fu = e.Item.FindControl("fuPath") as FileUpload;
        //HiddenField hf = e.Item.FindControl("hfPath") as HiddenField;

        //if (fu != null && fu.HasFile)

        //    if (fu.PostedFile != null)
        //        if (fu.PostedFile.ContentLength != 0)
        //        {
        //            try
        //            {
        //                String destDir = Server.MapPath("Docs");
        //                String fileName = Path.GetFileName(fu.PostedFile.FileName).Replace(' ', '_');
        //                String destPath = Path.Combine(destDir, fileName);
        //                hf.Value = fileName;
        //                fu.PostedFile.SaveAs(destPath);

        //            }
        //            catch (Exception err)
        //            {

        //            }
        //        }
    }
    protected void DDL_Category_SelectedIndexChanged(object sender, EventArgs e)
    {
        SQLDS_DocumetFile_list.SelectParameters.Clear();
        SQLDS_DocumetFile_list.SelectParameters.Add("key_document_category_id", DDL_Category.SelectedValue);
        SQLDS_DocumetFile_list.Select(DataSourceSelectArguments.Empty);
        gDoc.Rebind();

    }
    protected void DDL_Category_DataBound(object sender, EventArgs e)
    {
        ListItem DumbItem = new ListItem("Select Category", "-1");
        DDL_Category.Items.Insert(0, DumbItem);
    }
}
