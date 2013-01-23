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
    public class act_activity_reimbursement
    {
        private DataTable dataTable = new DataTable();
        private DataRow currentRow = null;
        private IEnumerator enumerator = null;

        public string ConnectionString = DataAccess.getConnStr();

        public act_activity_reimbursement()
        {

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
                cmd.CommandText = "SELECT * FROM [act_activity_reimbursement] WHERE 1=0";

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

            SqlDataAdapter dataAdapter = new SqlDataAdapter("[pr_act_activity_reimbursement_LoadAll]", this.ConnectionString);
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
        public virtual bool LoadByPrimaryKey(int Key_reimbursement_id)
        {
            bool loaded = false;

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = new SqlConnection(this.ConnectionString);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "[pr_act_activity_reimbursement_sel]";

            SqlParameter p;

            p = Parameters.Key_reimbursement_id;
            p.Value = Key_reimbursement_id;
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
            try
            {
                dataAdapter.Update(dataTable);
            }
            catch (Exception ex)
            {
 
            }
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

            public static SqlParameter Key_reimbursement_id
            {
                get
                {
                    return new SqlParameter("@Key_reimbursement_id", SqlDbType.Int, 0);
                }
            }

            public static SqlParameter Key_fiscal_year_quarter_id
            {
                get
                {
                    return new SqlParameter("@Key_fiscal_year_quarter_id", SqlDbType.Int, 0);
                }
            }

            public static SqlParameter Key_activity_line_item_id
            {
                get
                {
                    return new SqlParameter("@Key_activity_line_item_id", SqlDbType.Int, 0);
                }
            }

            public static SqlParameter Nbr_amount
            {
                get
                {
                    return new SqlParameter("@Nbr_amount", SqlDbType.Money, 0);
                }
            }

            public static SqlParameter Dte_date_created
            {
                get
                {
                    return new SqlParameter("@Dte_date_created", SqlDbType.SmallDateTime, 0);
                }
            }

            public static SqlParameter Txt_created_user
            {
                get
                {
                    return new SqlParameter("@Txt_created_user", SqlDbType.VarChar, 50);
                }
            }

        }
        #endregion

        #region ColumnNames
        public class ColumnNames
        {
            public const string Key_reimbursement_id = "Key_reimbursement_id";
            public const string Key_fiscal_year_quarter_id = "Key_fiscal_year_quarter_id";
            public const string Key_activity_line_item_id = "Key_activity_line_item_id";
            public const string Nbr_amount = "Nbr_amount";
            public const string Dte_date_created = "Dte_date_created";
            public const string Txt_created_user = "Txt_created_user";

        }
        #endregion


        //=================================================================
        //  Properties Generated from the Table                        
        //=================================================================

        public virtual int Key_reimbursement_id
        {
            get
            {
                return (int)currentRow[ColumnNames.Key_reimbursement_id];
            }

        }

        public virtual int Key_fiscal_year_quarter_id
        {
            get
            {
                return (int)currentRow[ColumnNames.Key_fiscal_year_quarter_id];
            }

            set
            {
                currentRow[ColumnNames.Key_fiscal_year_quarter_id] = value;
            }
        }

        public virtual int Key_activity_line_item_id
        {
            get
            {
                return (int)currentRow[ColumnNames.Key_activity_line_item_id];
            }

            set
            {
                currentRow[ColumnNames.Key_activity_line_item_id] = value;
            }
        }

        public virtual decimal Nbr_amount
        {
            get
            {
                return (decimal)currentRow[ColumnNames.Nbr_amount];
            }

            set
            {
                currentRow[ColumnNames.Nbr_amount] = value;
            }
        }

        public virtual DateTime Dte_date_created
        {
            get
            {
                return (DateTime)currentRow[ColumnNames.Dte_date_created];
            }

            set
            {
                currentRow[ColumnNames.Dte_date_created] = value;
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


        protected SqlCommand CreateInsertCommand()
        {

            SqlCommand cmd = CreateParameters();
            cmd.CommandText = "[pr_act_activity_reimbursement_ins]";


            cmd.Parameters["@Key_reimbursement_id"].Direction = ParameterDirection.Output;

            return cmd;
        }

        protected SqlCommand CreateUpdateCommand()
        {

            SqlCommand cmd = CreateParameters();
            cmd.CommandText = "[pr_act_activity_reimbursement_upd]";



            return cmd;
        }

        protected SqlCommand CreateDeleteCommand()
        {

            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "[pr_act_activity_reimbursement_Delete]";

            SqlParameter p;

            p = cmd.Parameters.Add(Parameters.Key_reimbursement_id);
            p.SourceColumn = "Key_reimbursement_id";
            p.SourceVersion = DataRowVersion.Current;


            return cmd;
        }

        protected SqlCommand CreateParameters()
        {
            SqlParameter p;

            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            // Add params

            p = cmd.Parameters.Add(Parameters.Key_reimbursement_id);
            p.SourceColumn = "Key_reimbursement_id";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Key_fiscal_year_quarter_id);
            p.SourceColumn = "Key_fiscal_year_quarter_id";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Key_activity_line_item_id);
            p.SourceColumn = "Key_activity_line_item_id";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Nbr_amount);
            p.SourceColumn = "Nbr_amount";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Dte_date_created);
            p.SourceColumn = "Dte_date_created";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Txt_created_user);
            p.SourceColumn = "Txt_created_user";
            p.SourceVersion = DataRowVersion.Current;


            return cmd;
        }

        public SqlDataReader get_Line_Item_Info(int li_id)
        {           
            SqlConnection myconn = new SqlConnection(DataAccess.getConnStr());

            if (myconn.State != ConnectionState.Open)
            {
                myconn.Open();
            }

            SqlCommand mycom = new SqlCommand("pr_act_activity_line_item_sel", myconn);
            mycom.CommandType = CommandType.StoredProcedure;
            
            mycom.Parameters.Add("@key_activity_line_item_id", SqlDbType.Int).Value = li_id;

            SqlDataReader mydr = mycom.ExecuteReader(CommandBehavior.CloseConnection);

            return mydr;   
        }
    }
}
