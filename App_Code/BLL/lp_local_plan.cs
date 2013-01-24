using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Collections;

namespace BLL
{
    public class lp_local_plan
    {
        private DataTable dataTable = new DataTable();
        private DataRow currentRow = null;
        private IEnumerator enumerator = null;

        public string ConnectionString = "";

        public lp_local_plan()
        {
            ConnectionString = DataAccess.getConnStr();
        }

        /*
        '=================================================================
        '  public Overridable Sub AddNew()
        '=================================================================
        '  Adds a new record to our DataTable, if we haven't loaded any data yet the table has no
        '  structure, so, we do a little trick to get the column by doing a SELECT against the 
        '  table using "WHERE 1=0" which will bring back no data but our DataColumns and 
        '  other information are filled out for us.
        '=================================================================
        */
        public virtual void AddNew()
        {
            if (dataTable.Rows.Count == 0)
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = new SqlConnection(this.ConnectionString);
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "SELECT * FROM [lp_local_plan] WHERE 1=0";

                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                dataAdapter.SelectCommand = cmd;
                dataAdapter.Fill(dataTable);
            }

            currentRow = dataTable.NewRow();
            dataTable.Rows.Add(currentRow);
        }

        /*
        '=================================================================
        '  public virtual bool LoadAll()
        '=================================================================
        '  Loads all of the records in the database, and sets the currentRow to the first row
        '=================================================================
        */
        public virtual bool LoadAll()
        {
            bool loaded = false;

            SqlDataAdapter dataAdapter = new SqlDataAdapter("[pr_lp_local_plan_LoadAll]", this.ConnectionString);
            dataAdapter.Fill(dataTable);

            if (dataTable.Rows.Count > 0)
            {
                currentRow = dataTable.Rows[0];
                loaded = true;
            }

            return loaded;
        }

        /*
        '=================================================================
        ' public virtual bool LoadByPrimaryKey()
        '=================================================================
        '  Loads a single row of via the primary key
        '=================================================================
        */
        public virtual bool LoadByPrimaryKey(int Key_local_plan_id)
        {
            bool loaded = false;

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = new SqlConnection(this.ConnectionString);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "[pr_lp_local_plan_get_by_id]";

            SqlParameter p;

            p = Parameters.Key_local_plan_id;
            p.Value = Key_local_plan_id;
            cmd.Parameters.Add(p);

            SqlDataAdapter dataAdapter = new SqlDataAdapter();
            dataAdapter.SelectCommand = cmd;
            dataAdapter.Fill(dataTable);

            if (dataTable.Rows.Count > 0)
            {
                currentRow = dataTable.Rows[0];
                loaded = true;
            }

            return loaded;
        }

        /*
        '=================================================================
        '  public Overridable Sub Save()
        '=================================================================
        '  Saves all changes, including Inserts, Deletes, and Updates. All Computed Columns and
        '  AutoKeys are updated and ready for access immediately after your call to Save()
        '=================================================================
        */
        public virtual void Save()
        {
            bool inserts = false;
            bool updates = false;
            bool deletes = false;

            if (dataTable.Rows.Count > 0)
            {
                // Do we have any data to save
                foreach (DataRow row in dataTable.Rows)
                {
                    switch (row.RowState)
                    {
                        case DataRowState.Added:
                            inserts = true;
                            break;
                        case DataRowState.Modified:
                            updates = true;
                            break;
                        case DataRowState.Deleted:
                            deletes = true;
                            break;
                    }
                }
            }

            SqlDataAdapter dataAdapter = new SqlDataAdapter();
            if (inserts)
            {
                dataAdapter.InsertCommand = this.CreateInsertCommand();
                dataAdapter.InsertCommand.Connection = new SqlConnection(this.ConnectionString);
            }

            if (updates)
            {
                dataAdapter.UpdateCommand = this.CreateUpdateCommand();
                dataAdapter.UpdateCommand.Connection = new SqlConnection(this.ConnectionString);
            }

            if (deletes)
            {
                dataAdapter.DeleteCommand = this.CreateDeleteCommand();
                dataAdapter.DeleteCommand.Connection = new SqlConnection(this.ConnectionString);
            }

            dataAdapter.Update(dataTable);
        }

        /*
        '=================================================================
        '  public virtual void DeleteCurrentRow()
        '=================================================================
        '  NOTE: The most important thing to remember about this method is that it only marks
        '  the record for deletion, you must still call Save() to actually delete it.
        '=================================================================
        */
        public virtual void DeleteCurrentRow()
        {
            if (currentRow != null)
            {
                currentRow.Delete();
            }
        }

        /*
        '=================================================================
        '  public Function RowState() As DataRowState
        '=================================================================
        '  This will return the actual DataRowState such as Added, Deleted, Modified
        '=================================================================
        */
        public DataRowState RowState()
        {
            if (dataTable != null && currentRow != null)
            {
                return currentRow.RowState;
            }
            else
            {
                return DataRowState.Detached;
            }
        }

        /*
        '=================================================================
        '  public int RowCount()
        '=================================================================
        '  The number of rows in the object
        '=================================================================
        */
        public int RowCount
        {
            get
            {
                int count = 0;
                if (dataTable != null)
                {
                    count = dataTable.DefaultView.Count;
                }
                return count;
            }
        }

        /*
        '=================================================================
        '  public voic Rewind()
        '=================================================================
        '  This resets the iteraton, you should call this before you call MoveNext().
        '=================================================================
        */
        public void Rewind()
        {
            currentRow = null;
            enumerator = null;

            if (dataTable != null)
            {
                if (dataTable.DefaultView.Count > 0)
                {
                    enumerator = dataTable.DefaultView.GetEnumerator();
                    enumerator.MoveNext();
                    DataRowView rowView = enumerator.Current as DataRowView;
                    currentRow = rowView.Row;
                }
            }
        }

        /*
        '=================================================================
        '  public bool MoveNext()
        '=================================================================
        '  This Moves the current row pointer to the next row and returns false if it has reached the
        '  end
        '=================================================================
        */
        public bool MoveNext()
        {
            bool moved = false;

            if (enumerator != null && enumerator.MoveNext())
            {
                DataRowView rowView = enumerator.Current as DataRowView;
                currentRow = rowView.Row;
                moved = true;
            }

            return moved;
        }

        #region Parameters
        protected class Parameters
        {

            public static SqlParameter Key_local_plan_id
            {
                get
                {
                    return new SqlParameter("@Key_local_plan_id", SqlDbType.Int, 0);
                }
            }

            public static SqlParameter Key_college_id
            {
                get
                {
                    return new SqlParameter("@Key_college_id", SqlDbType.Int, 0);
                }
            }

            public static SqlParameter Nbr_fiscal_year
            {
                get
                {
                    return new SqlParameter("@Nbr_fiscal_year", SqlDbType.Int, 0);
                }
            }

            public static SqlParameter Key_local_plan_level_id
            {
                get
                {
                    return new SqlParameter("@Key_local_plan_level_id", SqlDbType.Int, 0);
                }
            }

            public static SqlParameter Flg_accepted_assurances
            {
                get
                {
                    return new SqlParameter("@Flg_accepted_assurances", SqlDbType.Bit, 0);
                }
            }

            public static SqlParameter Nbr_yearly_appropiation
            {
                get
                {
                    return new SqlParameter("@Nbr_yearly_appropiation", SqlDbType.Money, 0);
                }
            }

            public static SqlParameter nbr_total_activities
            {
                get
                {
                    return new SqlParameter("@nbr_total_activities", SqlDbType.Money, 0);
                }
            }

            public static SqlParameter nbr_balance
            {
                get
                {
                    return new SqlParameter("@nbr_balance", SqlDbType.Money, 0);
                }
            }

            public static SqlParameter nbr_reimbursements
            {
                get
                {
                    return new SqlParameter("@nbr_reimbursements", SqlDbType.Money, 0);
                }
            }






            public static SqlParameter Flg_locked
            {
                get
                {
                    return new SqlParameter("@Flg_locked", SqlDbType.Bit, 0);
                }
            }

            public static SqlParameter Dte_created_date
            {
                get
                {
                    return new SqlParameter("@Dte_created_date", SqlDbType.DateTime, 0);
                }
            }

            public static SqlParameter Txt_created_user
            {
                get
                {
                    return new SqlParameter("@Txt_created_user", SqlDbType.VarChar, 50);
                }
            }
            //Add New Field
            public static SqlParameter Txt_college_name
            {
                get
                {
                    return new SqlParameter("@Txt_college_name", SqlDbType.VarChar, 50);
                }
            }

            public static SqlParameter Txt_system_office_notes
            {
                get
                {
                    return new SqlParameter("@Txt_system_office_notes", SqlDbType.Text, 12434567 );
                }
            }

            public static SqlParameter Flg_lock_amendment_period
            {
                get
                {
                    return new SqlParameter("@Flg_lock_amendment_period", SqlDbType.Bit, 0);
                }
            }
        }
        #endregion

        #region ColumnNames
        public class ColumnNames
        {
            public const string Key_local_plan_id = "Key_local_plan_id";
            public const string Key_college_id = "Key_college_id";
            public const string Nbr_fiscal_year = "Nbr_fiscal_year";
            public const string Key_local_plan_level_id = "Key_local_plan_level_id";
            public const string Flg_accepted_assurances = "Flg_accepted_assurances";
            public const string Nbr_yearly_appropiation = "Nbr_yearly_appropiation";
            public const string nbr_total_activities = "nbr_total_activities";
            public const string nbr_balance = "nbr_balance";
            public const string nbr_reimbursements = "nbr_reimbursements";
            public const string Flg_locked = "Flg_locked";
            public const string Dte_created_date = "Dte_created_date";
            public const string Txt_created_user = "Txt_created_user";

            //Add New Field
            public const string Txt_college_name = "Txt_college_name";
            public const string Txt_system_office_notes = "Txt_system_office_notes";
            public const string Flg_lock_amendment_period = "Flg_lock_amendment_period";
            
        }
        #endregion


        //=================================================================
        //  Properties Generated from the Table                        
        //=================================================================

        public virtual int Key_local_plan_id
        {
            get
            {
                return (int)currentRow[ColumnNames.Key_local_plan_id];
            }

        }

        public virtual int Key_college_id
        {
            get
            {
                return (int)currentRow[ColumnNames.Key_college_id];
            }

            set
            {
                currentRow[ColumnNames.Key_college_id] = value;
            }
        }

        public virtual int Nbr_fiscal_year
        {
            get
            {
                return (int)currentRow[ColumnNames.Nbr_fiscal_year];
            }

            set
            {
                currentRow[ColumnNames.Nbr_fiscal_year] = value;
            }
        }

        public virtual int Key_local_plan_level_id
        {
            get
            {
                return (int)currentRow[ColumnNames.Key_local_plan_level_id];
            }

            set
            {
                currentRow[ColumnNames.Key_local_plan_level_id] = value;
            }
        }

        public virtual bool Flg_accepted_assurances
        {
            get
            {
                return (bool)currentRow[ColumnNames.Flg_accepted_assurances];
            }

            set
            {
                currentRow[ColumnNames.Flg_accepted_assurances] = value;
            }
        }

        public virtual decimal Nbr_yearly_appropiation
        {
            get
            {
                return (decimal)currentRow[ColumnNames.Nbr_yearly_appropiation];
            }

            set
            {
                currentRow[ColumnNames.Nbr_yearly_appropiation] = value;
            }
        }

        public virtual decimal nbr_total_activities
        {
            get
            {
                return (decimal)currentRow[ColumnNames.nbr_total_activities];
            }

            set
            {
                currentRow[ColumnNames.nbr_total_activities] = value;
            }
        }


        public virtual decimal nbr_balance
        {
            get
            {
                return (decimal)currentRow[ColumnNames.nbr_balance];
            }

            set
            {
                currentRow[ColumnNames.nbr_balance] = value;
            }
        }

        public virtual decimal nbr_reimbursements
        {
            get
            {
                return (decimal)currentRow[ColumnNames.nbr_reimbursements];
            }

            set
            {
                currentRow[ColumnNames.nbr_reimbursements] = value;
            }
        }








        public virtual bool Flg_locked
        {
            get
            {
                return (bool)currentRow[ColumnNames.Flg_locked];
            }

            set
            {
                currentRow[ColumnNames.Flg_locked] = value;
            }
        }

        public virtual DateTime Dte_created_date
        {
            get
            {
                return (DateTime)currentRow[ColumnNames.Dte_created_date];
            }

            set
            {
                currentRow[ColumnNames.Dte_created_date] = value;
            }
        }

        public virtual string Txt_created_user
        {
            get
            {
                return (string)currentRow[ColumnNames.Txt_created_user];
            }

            set
            {
                currentRow[ColumnNames.Txt_created_user] = value;
            }
        }

        // Add New Field
        public virtual string Txt_college_name
        {
            get
            {
                return (string)currentRow[ColumnNames.Txt_college_name];
            }

            set
            {
                currentRow[ColumnNames.Txt_college_name] = value;
            }
        }

        public virtual string Txt_system_office_notes
        {
            get
            {
                return (string)currentRow[ColumnNames.Txt_system_office_notes];
            }

            set
            {
                currentRow[ColumnNames.Txt_system_office_notes] = value;
            }
        }

        public virtual bool Flg_lock_amendment_period
        {
            get
            {
                return (bool)currentRow[ColumnNames.Flg_lock_amendment_period];
            }

            set
            {
                currentRow[ColumnNames.Flg_lock_amendment_period] = value;
            }
        }

        

        protected SqlCommand CreateInsertCommand()
        {

            SqlCommand cmd = CreateParameters();
            cmd.CommandText = "[pr_lp_local_plan_Insert]";


            cmd.Parameters["@Key_local_plan_id"].Direction = ParameterDirection.Output;

            return cmd;
        }

        protected SqlCommand CreateUpdateCommand()
        {

            SqlCommand cmd = CreateParameters();
            cmd.CommandText = "[pr_lp_local_plan_upd_Accepted]";

            return cmd;
        }

        protected SqlCommand CreateDeleteCommand()
        {

            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "[pr_lp_local_plan_Delete]";

            SqlParameter p;

            p = cmd.Parameters.Add(Parameters.Key_local_plan_id);
            p.SourceColumn = "Key_local_plan_id";
            p.SourceVersion = DataRowVersion.Current;


            return cmd;
        }

        protected SqlCommand CreateParameters()
        {
            SqlParameter p;

            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            // Add params

            p = cmd.Parameters.Add(Parameters.Key_local_plan_id);
            p.SourceColumn = "Key_local_plan_id";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Key_college_id);
            p.SourceColumn = "Key_college_id";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Nbr_fiscal_year);
            p.SourceColumn = "Nbr_fiscal_year";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Key_local_plan_level_id);
            p.SourceColumn = "Key_local_plan_level_id";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Flg_accepted_assurances);
            p.SourceColumn = "Flg_accepted_assurances";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Nbr_yearly_appropiation);
            p.SourceColumn = "Nbr_yearly_appropiation";
            p.SourceVersion = DataRowVersion.Current;


            p = cmd.Parameters.Add(Parameters.nbr_total_activities);
            p.SourceColumn = "nbr_total_activities";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Flg_locked);
            p.SourceColumn = "Flg_locked";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Dte_created_date);
            p.SourceColumn = "Dte_created_date";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Txt_created_user);
            p.SourceColumn = "Txt_created_user";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Txt_college_name);
            p.SourceColumn = "Txt_college_name";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Txt_system_office_notes);
            p.SourceColumn = "Txt_system_office_notes";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Flg_lock_amendment_period);
            p.SourceColumn = "Flg_lock_amendment_period";
            p.SourceVersion = DataRowVersion.Current;


            return cmd;
        }
    }
}
