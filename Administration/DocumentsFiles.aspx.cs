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
using System.Data.SqlClient;
using System.IO;
using System.Text;
using Telerik.WebControls;
using System.Web.Configuration;

public partial class Administration_DocumentsFiles : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

       
    }

   

    protected void RADG_DocumentList_InsertCommand(object source, Telerik.WebControls.GridCommandEventArgs e)
    {

try
                    {

        string connectionstring = WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ConnectionString;
        FileUpload UploadedFile = e.Item.FindControl("UPF_uploadedFile") as FileUpload;
        DropDownList mydd = e.Item.FindControl("DD_categoryList") as DropDownList;
        HiddenField myhf = e.Item.FindControl("HF_catid") as HiddenField;
        TextBox TXT_DocTitle = e.Item.FindControl("TXT_DocTitle") as TextBox;
        
        if (UploadedFile != null && UploadedFile.HasFile)
          
            if (UploadedFile.PostedFile != null)
                if (UploadedFile.PostedFile.ContentLength != 0)
                {
                    
                        string extension = Path.GetExtension(UploadedFile.PostedFile.FileName).ToLower();
                        string MIMEType = "";
                        switch (extension)
                        {

                            case ".docx":
                                MIMEType = "application/msword";// "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
                                break;
                        }

                             using (SqlConnection myConnection = new SqlConnection(connectionstring))
                        {
                            SQLDS_DocumetFile_list.InsertParameters.Clear();
                            SqlCommand myCommand = new SqlCommand("INSERT INTO [scs_document_file_storage] ([txt_File_Title], [txt_file_mimetype], [bin_binaryFile_data],[key_document_category_id],[txt_file_name], dte_file_timestamp) VALUES (@Title, @MIMEType, @filedata,@key_document_category_id,@txt_file_name,getdate())", myConnection);
                            myCommand.Parameters.AddWithValue("@Title", TXT_DocTitle.Text);
                            myCommand.Parameters.AddWithValue("@MIMEType", MIMEType);
                            myCommand.Parameters.AddWithValue("@key_document_category_id", mydd.SelectedValue);
                            myCommand.Parameters.AddWithValue("@txt_file_name", UploadedFile.FileName.ToString());

                                 

                            Byte[] filebytes = new Byte[UploadedFile.PostedFile.ContentLength];//InputStream.Length];
                            UploadedFile.PostedFile.InputStream.Read(filebytes, 0, filebytes.Length);
                            myCommand.Parameters.AddWithValue("@fileData", filebytes);

                            myConnection.Open();
                            myCommand.ExecuteNonQuery();
                            myConnection.Close();

                            RADG_DocumentList.Rebind();
                            RADG_DocumentList.EditIndexes.Clear();
                           
                        }
                     //   RADG_DocumentList.MasterTableView.IsItemInserted = false;
                        

                    }
                   
                }
 catch
                    { }



  }



  
    protected void RADG_DocumentList_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            DropDownList mydd = e.Item.FindControl("DD_categoryList") as DropDownList;
            HiddenField myhf = e.Item.FindControl("HF_catid") as HiddenField;
            if (myhf != null && myhf.Value != string.Empty)
                mydd.SelectedIndex = mydd.Items.IndexOf(mydd.Items.FindByValue(myhf.Value));

            if (e.Item.IsInEditMode && RADG_DocumentList.MasterTableView.IsItemInserted == false)
            {
                FileUpload UploadedFile = e.Item.FindControl("UPF_uploadedFile") as FileUpload;
                UploadedFile.Visible = false;

                RequiredFieldValidator rv = e.Item.FindControl("RequiredFieldValidator2") as RequiredFieldValidator;
                if (rv != null)
                    rv.Enabled = false;

                Label lblLocation = e.Item.FindControl("lblLocation") as Label;
                if (lblLocation != null)
                    lblLocation.Visible = false;
            }


            if (e.Item is GridDataItem && e.Item.IsInEditMode == false)
            {
                GridDataItem gridDataItem = e.Item as GridDataItem;
                StringBuilder stb = new StringBuilder();
              //  stb.Append(@"<a href=javascript:window.open('http://www.google.com');>hello</a>");
               stb.Append(@"<a href=javascript:void(window.open('../renderfile.aspx?intid=");
              stb.Append(gridDataItem["key_doc_file_storage_id"].Text);
             stb.Append("'));>" + gridDataItem["txt_file_title"].Text + "</a>");
                gridDataItem["txt_file_title"].Text = stb.ToString();
            }

    
        }
        catch
        {
        }
    }
    protected void RADG_DocumentList_DeleteCommand(object source, GridCommandEventArgs e)
    {
        string connectionstring = WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ConnectionString;
     
        using (SqlConnection myConnection = new SqlConnection(connectionstring))
        {
            SQLDS_DocumetFile_list.DeleteParameters.Clear();
            SqlCommand myCommand = new SqlCommand(SQLDS_DocumetFile_list.DeleteCommand.ToString(), myConnection);
            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.Parameters.AddWithValue("@key_doc_file_storage_id", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["key_doc_file_storage_id"].ToString());



            myConnection.Open();
            myCommand.ExecuteNonQuery();
            myConnection.Close();

            RADG_DocumentList.Rebind();
            RADG_DocumentList.EditIndexes.Clear();
        }
    }
   
    protected void RADG_DocumentList_UpdateCommand(object source, GridCommandEventArgs e)
    {
try
        {

            string connectionstring = WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ConnectionString;

            DropDownList mydd = e.Item.FindControl("DD_categoryList") as DropDownList;
            HiddenField myhf = e.Item.FindControl("HF_catid") as HiddenField;
            TextBox TXT_DocTitle = e.Item.FindControl("TXT_DocTitle") as TextBox;



            using (SqlConnection myConnection = new SqlConnection(connectionstring))
            {
                SQLDS_DocumetFile_list.InsertParameters.Clear();
                SqlCommand myCommand = new SqlCommand("update [scs_document_file_storage] set [txt_File_Title]=@Title, [key_document_category_id]=@key_document_category_id where key_doc_file_storage_id = @key_doc_file_storage_id", myConnection);
                myCommand.Parameters.AddWithValue("@Title", TXT_DocTitle.Text);

                myCommand.Parameters.AddWithValue("@key_document_category_id", mydd.SelectedValue);
                myCommand.Parameters.AddWithValue("@key_doc_file_storage_id", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["key_doc_file_storage_id"].ToString());
                
                myConnection.Open();
                myCommand.ExecuteNonQuery();
                myConnection.Close();

                RADG_DocumentList.Rebind();
                RADG_DocumentList.EditIndexes.Clear();
            }
        }
        catch
        {
        }
    }

    protected void RADG_DocumentList_ItemCommand(object source, GridCommandEventArgs e)
    {
      
    }
    protected void RADG_DocumentList_EditCommand(object source, GridCommandEventArgs e)
    {
                
    }

    protected void DDL_Category_SelectedIndexChanged(object sender, EventArgs e)
    {
        SQLDS_DocumetFile_list.SelectParameters.Clear();
        SQLDS_DocumetFile_list.SelectParameters.Add("key_document_category_id", DDL_Category.SelectedValue);
        SQLDS_DocumetFile_list.Select(DataSourceSelectArguments.Empty);
        RADG_DocumentList.Rebind();
    
    }
    protected void DDL_Category_DataBound(object sender, EventArgs e)
    {
        ListItem DumbItem = new ListItem("Select Category", "-1");
        DDL_Category.Items.Insert(0, DumbItem);
    }
}
