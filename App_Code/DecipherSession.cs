using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for DecipherSession
/// </summary>
public class DecipherSession
{
	public DecipherSession(string inputvalue)
	{
        string[] incomingIDS = new string[3];
        char[] splitchar = { ',' };
        incomingIDS = inputvalue.Split(splitchar);
        if (incomingIDS.Length == 3)
        {
            SetAcctID = incomingIDS[0].ToString();
            SetCollID = incomingIDS[1].ToString();
            SetFiscalYear = incomingIDS[2].ToString();
        }
        else
        {
            SetAcctID = "-1";
            SetCollID = "-1";
            SetFiscalYear = "-1";
        }
	}

    private string m_AcctID;
    public string AcctID
    {
        get
        {
            return m_AcctID;
        }
       
    }
    private string SetAcctID
    {
        set
        {
            m_AcctID = value;
        }
    }



    private string m_CollID;
    public string CollID
    {
        get
        {
            return m_CollID;
        }

    }
    private string SetCollID
    {
        set
        {
            m_CollID = value;
        }
    }

    private string m_FiscalYear;
    public string FiscalYear
    {
        get
        {
            return m_FiscalYear;
        }

    }
    private string SetFiscalYear
    {
        set
        {
            m_FiscalYear = value;
        }
    }


}
