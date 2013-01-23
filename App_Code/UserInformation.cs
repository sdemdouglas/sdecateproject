using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections;
using System.Runtime.Serialization;
//using System.Runtime.Serialization.Formatters.Binary;

/// <summary>
/// Summary description for UserInformation
/// </summary>

    /// <summary>
    /// Summary description for PhoneNumber.
    /// </summary>
[Serializable]
[System.Xml.Serialization.XmlInclude(typeof(Employee))]
public class Employee 
    {    
       
		
      
        private string m_PhoneNumber = "";
        private string m_EmployeeName = "";
        private string m_department = "";       
        private string m_objectguid = "";
        private string m_mail = "";
        private string m_company = "";
        private string m_mailnickname = "";
        private string m_samaccountname = "";
        private string m_title = "";
    public Employee()
    { }
        public Employee(string employeename, string phoneNumber,string department,string objectguid,string mail,string company,string mailnickname,string samacoutname,string title)
        {
            m_PhoneNumber = phoneNumber;
            m_EmployeeName = employeename;
            m_department = department;
            m_objectguid = objectguid;
            m_mail = mail;
            m_company = company;
            m_mailnickname = mailnickname;
            m_samaccountname = samaccountname;
            m_title = title;
        }

        public string Number
        {
            get { return m_PhoneNumber; }
            set { m_PhoneNumber = value; }
        }

        public string EmpName
        {
            get { return m_EmployeeName; }
            set { m_EmployeeName = value; }
        }



        public string Department
        {
            get { return m_department; }
            set { m_department = value; }
        }

        public string objectguid
        {
            get { return m_objectguid; }
            set { m_objectguid = value; }
        }
        public string mail
        {
            get { return m_mail; }
            set { m_mail = value; }
        }
        public string company
        {
            get { return m_company; }
            set { m_company = value; }
        }

        public string mailnickname
        {
            get { return m_mailnickname; }
            set { m_mailnickname = value; }
        }
     
        public string samaccountname
        {
            get { return m_samaccountname; }
            set { m_samaccountname = value; }
        }
        public string title
        {
            get { return m_title; }
            set { m_title = value; }
        }


    }
[Serializable]
[System.Xml.Serialization.XmlInclude(typeof(Employee))]
public class UserInformation 
{
    [Serializable]
    [System.Xml.Serialization.XmlInclude(typeof(Employee))]

    public class EmployeeCollection : CollectionBase
    {

        public Employee this[int index]
        {
            get
            {
                //BinaryFormatter formatter = new BinaryFormatter();
               // formatter.Serialize((Employee)this.List[index], UserInformation);
                return (Employee)this.List[index];
            }
            set
            {

                this.List[index] = value;
            }
        }


        public void Add(Employee employee)
        {
            this.List.Add(employee);
        }

        public int Count()
        {
            return this.List.Count;
        }


       
      

    }

    public class EmployeeDictionary : DictionaryBase
    {
        public Employee this[string key]
        {
            get
            {
                
                return (Employee)this.Dictionary[key];
            }
            set
            {
                this.Dictionary[key] = value;
            }
        }

        public void Add(string key, Employee employee)
        {
            this.Dictionary.Add(key, employee);
        }

        public bool Contains(string key)
        {
            return this.Dictionary.Contains(key);
        }

        public int Count()
        {

            return this.Dictionary.Count;
        }

        public ICollection Keys
        {
            get { return this.Dictionary.Keys; }
        }
    }
  
}
