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
using Telerik.Web.UI;
using System.Web.Configuration;
using System.Data.SqlClient;

public partial class AppMaster : System.Web.UI.MasterPage
{
    static Boolean gotochildpage = false;

    protected void Page_unLoad(object sender, EventArgs e)
    {
        //if (Page.PreviousPage != null)
        //    Response.Write(Page.PreviousPage.ToString());
        //try
        //{
        //    Response.Write(Request.UrlReferrer.ToString());
        //    Response.Write(HttpContext.Current.Request.UrlReferrer.ToString());
        //}
        //catch
        //{
        //}
    }
     
    protected void MainMenu_MenuItemDataBound(Object sender, MenuEventArgs e)
	{
		if (mainmenu.SelectedItem == null)
		{				
			if (IsNodeAncestor((SiteMapNode)e.Item.DataItem, SiteMap.CurrentNode))
				e.Item.Selected = true;
		}
	}

 



    protected override void OnPreRender(EventArgs e)
    { 
        
      
       if (Session[Session.SessionID + "CollegeDD"] != null)
       {
           Session.Remove(Session.SessionID + "CollegeDD");
       }
       Session.Add(Session.SessionID + "CollegeDD", DropDownList1.SelectedIndex);

       if (Session[Session.SessionID + "FiscalDD"] != null && Session[Session.SessionID + "FiscalDD"].ToString() != "-1")
       {
           Session.Remove(Session.SessionID + "FiscalDD");
       }
       Session.Add(Session.SessionID + "FiscalDD", DropDownList2.SelectedIndex);

       if (Session[Session.SessionID + "PlanID"] != null)
       {
           Session.Remove(Session.SessionID + "PlanID");
       }

       DataView DV = (DataView)this.SQLDS_RGet_PLANID_INFO.Select(DataSourceSelectArguments.Empty);
       if (DV.Table.Rows.Count > 0)
       {
           int returnval = (int)DV.Table.Rows[0][0];

           if (returnval > 0)
           {
               Session.Add(Session.SessionID + "PlanID", returnval);
           }
           LockMenu(true);
       }
       else
       {
           LockMenu(false);
       }
       SetupSessionValues();

    
          





     
       try
       {
           lblSelectedCollege.Text = DropDownList1.SelectedItem.Text;
       }
       catch
       {
       }

        //9-14-2009 RL patched in to handle New IE role, 
        //intial coding was only meant for basically 2 roles controlling           //tabs (admin or not admin)
        //hence this patch
       if (Session[Session.SessionID + "roleid"].ToString() == "105")
       {
           DropDownList1.Enabled = false;
           if (!IsPostBack)
           {
               Telerik.Web.UI.RadTab tab105 = (Telerik.Web.UI.RadTab)Rad_tabNavigation.Tabs[2];
               Rad_tabNavigation.SelectedIndex = 2;
CreateChildren(tab105, Rad_tabNavigation.SelectedTab.Value.ToString());
               if(Session[Session.SessionID + "ParentTabIndex"].ToString() == "-1")
               Rad_tabNavigation_TabClick(Rad_tabNavigation, new Telerik.Web.UI.RadTabStripEventArgs(Rad_tabNavigation.SelectedTab));
              
         

          
           }
           foreach(RadTab atab in Rad_tabNavigation.Tabs)
           {
               if (atab.Text != "Accountability")
               {
                   atab.Visible = false;
               }
           }
       }

       base.OnPreRender(e);

    }
    
    
	/// <summary>
	/// Determines if a <see cref="System.Web.SiteMapNode"/> is the ancestor of a second one.
	/// </summary>
	/// <param name="ancestor">The <see cref="System.Web.SiteMapNode"/> in question.</param>
	/// <param name="child">A <see cref="System.Web.SiteMapNode"/> which may or may not be 
	/// the <paramref name="ancestor"/>'s child.</param>
	/// <returns><c>true</c>, if the two nodes are related, <c>false</c> otherwise.</returns>
	private bool IsNodeAncestor(SiteMapNode ancestor, SiteMapNode child)
	{
		bool result = false;

		if (ancestor.ChildNodes != null && ancestor.ChildNodes.Contains(child))
			return true;
		else
		{
           
                if (child.ParentNode != null && ancestor != child.RootNode)
                {
                    return IsNodeAncestor(ancestor, child.ParentNode);
                }
             
		}

		return result;
	}


    public void CleanUP_UnFinished_activities(string keyactivity)
    {


        SQLDS_DeleteUnfinishedActivities.DeleteParameters.Clear();
        SQLDS_DeleteUnfinishedActivities.DeleteParameters.Add("p_key_activity_id", keyactivity);
        SQLDS_DeleteUnfinishedActivities.Delete();
        // string mystring = "";
        //  Response.Write("hello world");
        //pr_at_amendment_incomplete_amd_del @p_key_activity_id int

    }
    
    protected void Page_Load(object sender, EventArgs e)
    {        
        if (!Page.IsPostBack)
        {
            try
            {
                if (Session[Session.SessionID + "finishstat"] != null && Session[Session.SessionID + "finishstat"].ToString() == "false")
                    CleanUP_UnFinished_activities(Session[Session.SessionID + "keyactiveID"].ToString());
            }
            catch
            {
            }
        }

        if (!Page.IsPostBack)
        {
          //  PerkinsTab_DV("-1", "-1");
        }


        Rad_tabNavigation.Align = Telerik.Web.UI.TabStripAlign.Left; 
      //  Session[Session.SessionID + "ChildTabIndex"]

        if (!Page.IsPostBack)
            CreateRootTab(Convert.ToInt16(Session[Session.SessionID + "ParentTabIndex"].ToString()), Session[Session.SessionID + "ParentTabValue"].ToString());


        if (this.ContentPlaceHolder1.Page.ToString() == "ASP.administration_collegeusers_aspx")
        {
            this.lblCollege.Visible = false;
            this.Label2.Visible = false;
            this.DropDownList1.Visible = false;
            this.DropDownList2.Visible = false;
            
        }
        else
        {
            this.lblCollege.Visible = true;
            this.Label2.Visible = true;
            this.DropDownList1.Visible = true;
            this.DropDownList2.Visible = true;
        }
        if (!IsPostBack)
        {
            
            
            if (Session[Session.SessionID + "roleid"].ToString() != "101")
            {

                //RL added for new tab control
               // Telerik.WebControls.Tab AdminTab = RAD_tabNav_Parent_Strip.Tabs[RAD_tabNav_Parent_Strip.Tabs.IndexOf(RAD_tabNav_Parent_Strip.FindTabByText("Administration"))];
               // AdminTab.Enabled = false;
                //
                try
                {
                    Telerik.WebControls.RadPanelItem adminitem = RadPanelbar1.Items[RadPanelbar1.Items.IndexOf(RadPanelbar1.Items.FindItemByText("Administration"))];
                    adminitem.Enabled = false;
                    adminitem.Expanded = false;
                }
                catch
                {
                }
            }

            if (Session[Session.SessionID + "roleid"].ToString() == "103" || Session[Session.SessionID + "roleid"].ToString() == "102" || Session[Session.SessionID + "roleid"].ToString() == "104")
            {
                DropDownList1.Enabled = false;

        

            }

            try
            {
                DropDownList1.DataSource = this.SqlDsCollege;
                DropDownList1.DataTextField = "txt_college_short_name";
                DropDownList1.DataValueField = "key_college_id";
                DropDownList1.DataBind();


                DropDownList2.DataSource = SqlDS_fisYear;
                DropDownList2.DataTextField = "nbr_fiscal_year";
                DropDownList2.DataValueField = "nbr_fiscal_year";
                DropDownList2.DataBind();
            }
            catch (Exception ex)
            {
                
            }




            GK3_Driver mydrive = new GK3_Driver();
            DataSet myds = new DataSet();
            myds = mydrive.AllUserINFO(HttpContext.Current.User.Identity.Name.ToString());


            try
            {
                string teststring = myds.Tables[0].Rows[0][0].ToString();

                if (Session[Session.SessionID + "USERID"] != null)
                {
                    Session.Remove(Session.SessionID + "USERID");
                }
                Session.Add(Session.SessionID + "USERID", myds.Tables[0].Rows[0]["key_user_id"].ToString());
                //////////////////////
                if (Session[Session.SessionID + "email"] != null)
                {
                    Session.Remove(Session.SessionID + "email");
                }
                Session.Add(Session.SessionID + "email", myds.Tables[0].Rows[0]["txt_email"].ToString());
                //////////////////////
                if (Session[Session.SessionID + "diplayname"] != null)
                {
                    Session.Remove(Session.SessionID + "displayname");
                }
                Session.Add(Session.SessionID + "displayname", myds.Tables[0].Rows[0]["txt_display_name"].ToString());
                ////////////////////////

                if (Session[Session.SessionID + "roleid"] != null)
                {
                    Session.Remove(Session.SessionID + "roleid");
                }
                Session.Add(Session.SessionID + "roleid", myds.Tables[0].Rows[0]["key_role_id"].ToString());
              
      

              

            }
            catch
            {
            }

        }






    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Session[Session.SessionID + "CollegeDD"] != null)
        {
            Session.Remove(Session.SessionID + "CollegeDD");
        }
        Session.Add(Session.SessionID + "CollegeDD", DropDownList1.SelectedIndex);

        if (Session[Session.SessionID + "FiscalDD"] != null && Session[Session.SessionID + "FiscalDD"].ToString() != "-1")
        {
            Session.Remove(Session.SessionID + "FiscalDD");
        }
        Session.Add(Session.SessionID + "FiscalDD", DropDownList2.SelectedIndex);

        if (Session[Session.SessionID + "PlanID"] != null)
        {
            Session.Remove(Session.SessionID + "PlanID");
        }

        DataView DV = (DataView)this.SQLDS_RGet_PLANID_INFO.Select(DataSourceSelectArguments.Empty);
        if (DV.Table.Rows.Count >0)
        {
            int returnval = (int)DV.Table.Rows[0][0];

            if (returnval > 0)
            {
                Session.Add(Session.SessionID + "PlanID", returnval);
            }
            LockMenu(true);

        }

        else
        {
            LockMenu(false);
        }
        SetupSessionValues();
        try
        {
            lblSelectedCollege.Text = DropDownList1.SelectedItem.Text;
        }
        catch
        {
        }
     

    }
    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (Session[Session.SessionID + "FiscalDD"] != null || Session[Session.SessionID + "FiscalDD"].ToString() != "-1")
            {
                Session.Remove(Session.SessionID + "FiscalDD");
            }
            Session.Add(Session.SessionID + "FiscalDD", DropDownList2.SelectedIndex);

            if (Session[Session.SessionID + "CollegeDD"] != null)
            {
                Session.Remove(Session.SessionID + "CollegeDD");
            }
            Session.Add(Session.SessionID + "CollegeDD", DropDownList1.SelectedIndex);

            if (Session[Session.SessionID + "PlanID"] != null)
            {
                Session.Remove(Session.SessionID + "PlanID");
            }

            DataView DV = (DataView)this.SQLDS_RGet_PLANID_INFO.Select(DataSourceSelectArguments.Empty);
            if (DV.Table.Rows.Count > 0)
            {
                int returnval = (int)DV.Table.Rows[0][0];

                if (returnval > 0)
                {
                    Session.Add(Session.SessionID + "PlanID", returnval);
                }
                LockMenu(true);





            }
            else
            {
                LockMenu(false);
            }
            SetupSessionValues();
        }
        catch
        {
        }
      
    }

    private void LockMenu(Boolean tolock)
    {
      //  Telerik.WebControls.Tab AdminTab = RAD_tabNav_Parent_Strip.Tabs[RAD_tabNav_Parent_Strip.Tabs.IndexOf(RAD_tabNav_Parent_Strip.FindTabByText("Local Plan"))];
       //  Telerik.WebControls.RadPanelItem panitem =
//RadPanelbar1.Items[RadPanelbar1.Items.IndexOf(RadPanelbar1.Items.FindItemByText("Local Plan"))];
        //panitem.Items[panitem.Items.IndexOf(panitem.Items.FindItemByText("Status"))].Enabled = tolock;
        //panitem.Items[panitem.Items.IndexOf(panitem.Items.FindItemByText("Assurances"))].Enabled = tolock;
       //panitem.Items[panitem.Items.IndexOf(panitem.Items.FindItemByText("Narratives"))].Enabled = tolock;
       //panitem.Items[panitem.Items.IndexOf(panitem.Items.FindItemByText("Activities"))].Enabled = tolock;
        //panitem.Items[panitem.Items.IndexOf(panitem.Items.FindItemByText("Amendments"))].Enabled = tolock;
       
    }



    private void SetupSessionValues()
    {
        try
        {
            if (Session[Session.SessionID + "FiscalDDvalue"] != null && Session[Session.SessionID + "FiscalDDValue"].ToString() != "-1")
            {
                Session.Remove(Session.SessionID + "FiscalDDvalue");
            }
            if (Session[Session.SessionID + "CollegeDDvalue"] != null)
            {
                Session.Remove(Session.SessionID + "CollegeDDvalue");

            }
            if (Session[Session.SessionID + "FiscalDD"] != null && Session[Session.SessionID + "FiscalDD"].ToString() != "-1")
            {
                Session.Remove(Session.SessionID + "FiscalDD");
            }
            Session.Add(Session.SessionID + "CollegeDDvalue", DropDownList1.SelectedValue.ToString());
            Session.Add(Session.SessionID + "FiscalDDvalue", DropDownList2.SelectedValue.ToString());
            Session.Add(Session.SessionID + "FiscalDD", DropDownList2.SelectedIndex.ToString());

        }
        catch
        {
        }
    }
    protected void DropDownList1_DataBound(object sender, EventArgs e)
    {
        if (Session[Session.SessionID + "CollegeDDvalue"] != null)
          //  DropDownList1.SelectedIndex = Convert.ToInt32(Session[Session.SessionID + "CollegeDD"].ToString());

      
      DropDownList1.SelectedIndex = DropDownList1.Items.IndexOf(DropDownList1.Items.FindByValue(Session[Session.SessionID + "CollegeDDvalue"].ToString()));

 
    }
   
  
    protected void DropDownList2_DataBound(object sender, EventArgs e)
    {
        ListItem myitem = new ListItem("Select Year", "-1");
        DropDownList2.Items.Insert(0, myitem);
        if (Session[Session.SessionID + "FiscalDD"] == null || Session[Session.SessionID + "FiscalDD"].ToString() != "-1")
        {
            DropDownList2.SelectedIndex = 0;
        }
   

        if (Session[Session.SessionID + "FiscalDDvalue"] != null && Session[Session.SessionID + "FiscalDDValue"].ToString() != "-1")
        
            DropDownList2.SelectedIndex = DropDownList2.Items.IndexOf(DropDownList2.Items.FindByValue(Session[Session.SessionID + "FiscalDDvalue"].ToString()));
    }
    protected void SQLDS_RGet_PLANID_INFO_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("~/default.aspx");
    }








 //   protected void Rad_tabNavigation_TabClick(object sender, TabStripEventArgs e)
 //   {
 //       int childindex = -1;
 //       Session[Session.SessionID + "ParentTabIndex"] = e.Tab.Index.ToString();
 //       Session[Session.SessionID + "ChildTabValue"] = "-1";
 //       foreach (Tab tab in Rad_tabNavigation.Tabs)
 //       {
 //           if (tab.Selected && e.Tab.Value.ToString() != string.Empty)
 //           {
 //              Session[Session.SessionID + "ParentTabValue"] = e.Tab.Value.ToString();
 //              Session[Session.SessionID + "ChildTabIndex"] = "-1";
 //              Session[Session.SessionID + "ChildTabValue"] = "-1";
              
 //           }


 //           foreach (Tab childTab in tab.Tabs)
 //           {
 //               if (childTab.Selected)
 //               {
 //                   Session[Session.SessionID + "ChildTabIndex"] = childTab.Index;
 //                   Session[Session.SessionID + "ChildTabValue"] = childTab.Text;
 //                   childindex = childTab.Index;
 //               }
 //           }
 //       }

 //       CreateRootTab(Convert.ToInt16(Session[Session.SessionID + "ParentTabIndex"].ToString()), Session[Session.SessionID + "ParentTabValue"].ToString());

 //       //CreateChildren(e.Tab, Session[Session.SessionID + "ChildTabValue"].ToString());
 //if (gotochildpage)
 //       {
 //    gotochildpage = false;
 //           Response.Redirect(Session[Session.SessionID + "ChildURLValue"].ToString());
            
 //       }
 //       string theforwardurl = GET_Tab_URL(e.Tab.Text.ToString());
 //       if (theforwardurl != string.Empty)
 //           Response.Redirect(theforwardurl);

       
 //   }

    private string GET_Tab_URL(string in_key)
    {
        string myurl = "";
 SqlConnection myconn = new SqlConnection(WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ConnectionString.ToString());
        SqlCommand mycomm = new SqlCommand("pr_sec_tab_control_url_get",myconn);
        mycomm.CommandType = CommandType.StoredProcedure;
        mycomm.Parameters.Add("@p_txt_tab_name", SqlDbType.NVarChar, 50).Value = in_key;
     
        if(myconn.State != ConnectionState.Open)
            myconn.Open();


        myurl = mycomm.ExecuteScalar().ToString();
        myconn.Close();
        myconn.Dispose();

       



        return myurl;
    }

    private void CreateRootTab(int index,string text)
    {


        try
        {


            string userSecurityid = Session[Session.SessionID + "roleid"].ToString();

            SQLDS_parentTab_Data.SelectParameters.Clear();
            SQLDS_parentTab_Data.SelectParameters.Add("p_parentid", "self");
            SQLDS_parentTab_Data.SelectParameters.Add("p_sec_level", userSecurityid);
            SQLDS_parentTab_Data.Select(DataSourceSelectArguments.Empty);

            Rad_tabNavigation.DataSource = SQLDS_parentTab_Data;//PerkinsTab_DV("self", "-1"); // 
            Rad_tabNavigation.DataTextField = "txt_tab_name";
            Rad_tabNavigation.DataValueField = "txt_tab_value";
            //    Rad_tabNavigation.DataNavigateUrlField = "txt_url_link";
            Rad_tabNavigation.DataBind();

            Rad_tabNavigation.SelectedIndex = index;
            try
            {
                int mecount = Rad_tabNavigation.Tabs.Count;
                if (Session[Session.SessionID + "ParentTabValue"].ToString() != "-1")
                {
                    Rad_tabNavigation.FindTabByValue(text).Selected = true;
                    // Rad_tabNavigation.TabIndex = Convert.ToInt16(index);
                }
                CreateChildren(Rad_tabNavigation.SelectedTab, Session[Session.SessionID + "ParentTabValue"].ToString());
            }
            catch { }

            //   Tab tab = new Tab();
            //   tab.Text = string.Format("Tab {0}", index);
            // Rad_tabNavigation.Tabs.Add(tab);
            //   return tab;
        }
        catch
        {
        }
    }

    private void CreateChildren(RadTab parent,string text)
    {
        string userSecurityid = Session[Session.SessionID + "roleid"].ToString();
        Boolean selectFirstChildTab = true;
        try
        {
            SQLDS_childTab_Data.SelectParameters.Clear();
            SQLDS_childTab_Data.SelectParameters.Add("p_parentid", parent.Value);//RAD_tabNav_Parent_Strip.SelectedTab.Value.ToString());
            SQLDS_childTab_Data.SelectParameters.Add("p_sec_level", userSecurityid);
            DataView my_DV = (DataView)SQLDS_childTab_Data.Select(DataSourceSelectArguments.Empty);// PerkinsTab_DV(parent.Value, "-1");
            parent.Tabs.Clear();

            Telerik.Web.UI.RadTab rtab = new RadTab();

            foreach (DataRow dr in my_DV.Table.Rows)
            {

                RadTab child = new RadTab();
                child.Text = dr["txt_tab_name"].ToString();
                child.Value = dr["txt_tab_value"].ToString();
           //     child.NavigateUrl = dr["txt_url_link"].ToString();

                parent.Tabs.Add(child);
               
                if (Session[Session.SessionID + "ChildTabValue"] == "-1"  && selectFirstChildTab)
                {
                   Session[Session.SessionID + "ChildTabValue"] = child.Text;
                   Session[Session.SessionID + "ChildURLValue"] = GET_Tab_URL(child.Text);
                   gotochildpage = true;
                   selectFirstChildTab = false;
                }
            }

            if (Session[Session.SessionID + "ChildTabValue"] != "-1")
            {
                Rad_tabNavigation.FindTabByText(Session[Session.SessionID + "ChildTabValue"].ToString()).Selected = true;

            }
            else
            {
               
            }
      
        }
        catch
        {
        }
        //for (int i = 0; i < 4; i++)
        //{
        //    Tab child = new Tab();
        //    child.Text = string.Format("{0}.{1}", parent.Text, i);
        //    parent.Tabs.Add(child);
        //}
    }

    protected void Rad_tabNavigation_TabClick(object sender, RadTabStripEventArgs e)
    {
        int childindex = -1;
        Session[Session.SessionID + "ParentTabIndex"] = e.Tab.Index.ToString();
        Session[Session.SessionID + "ChildTabValue"] = "-1";
        foreach (RadTab tab in Rad_tabNavigation.Tabs)
        {
            if (tab.Selected && e.Tab.Value.ToString() != string.Empty)
            {
                Session[Session.SessionID + "ParentTabValue"] = e.Tab.Value.ToString();
                Session[Session.SessionID + "ChildTabIndex"] = "-1";
                Session[Session.SessionID + "ChildTabValue"] = "-1";

            }


            foreach (RadTab childTab in tab.Tabs)
            {
                if (childTab.Selected)
                {
                    Session[Session.SessionID + "ChildTabIndex"] = childTab.Index;
                    Session[Session.SessionID + "ChildTabValue"] = childTab.Text;
                    childindex = childTab.Index;
                }
            }
        }

        CreateRootTab(Convert.ToInt16(Session[Session.SessionID + "ParentTabIndex"].ToString()), Session[Session.SessionID + "ParentTabValue"].ToString());

        CreateChildren(e.Tab, Session[Session.SessionID + "ChildTabValue"].ToString());
        if (gotochildpage)
        {
            gotochildpage = false;
            Response.Redirect(Session[Session.SessionID + "ChildURLValue"].ToString());

        }
        string theforwardurl = GET_Tab_URL(e.Tab.Text.ToString());
        if (theforwardurl != string.Empty)
            Response.Redirect(theforwardurl);



        if (e.Tab.Text.ToLower() == "local plan")
        {
            Response.Redirect("~/LocalPlan/LocalPlan.aspx");
            
        }
    }





    public DataView PerkinsTab_DV(string tabid, string secid)
    {
        DataView dv=null;

        if (Session["TabDataView"] == null)
        {

            string connectionstring = WebConfigurationManager.ConnectionStrings["sctcs_perkinsConnectionString"].ConnectionString.ToString();
            SqlConnection myconn = new SqlConnection(connectionstring);
            SqlCommand mycom = new SqlCommand("pr_sec_tabs_get", myconn);
            mycom.CommandType = CommandType.StoredProcedure;
            mycom.Parameters.AddWithValue("p_parentid", "-1");
            mycom.Parameters.AddWithValue("p_sec_level", "-1");
            SqlDataAdapter adapter = new SqlDataAdapter(mycom);
            myconn.Open();
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            dv = dt.DefaultView;
            Session.Add("TabDataView", dv);
        }
       
        dv = (DataView)Session["TabDataView"];
        dv.RowFilter =string.Format("txt_tab_parent = '{0}'" ,tabid);
        return  dv;
    }

    protected void lb_logout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("~/Login.aspx");
    }
}
