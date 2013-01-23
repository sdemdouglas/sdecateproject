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
    public class act_activity
    {
        private DataTable dataTable = new DataTable();
        private DataRow currentRow = null;
        private IEnumerator enumerator = null;

        public string ConnectionString = DataAccess.getConnStr();

        public act_activity()
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
                cmd.CommandText = "SELECT * FROM [act_activity] WHERE 1=0";

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

            SqlDataAdapter dataAdapter = new SqlDataAdapter("[pr_act_activity_LoadAll]", this.ConnectionString);
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
        public virtual bool LoadByPrimaryKey(int Key_activity_id)
        {
            bool loaded = false;

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = new SqlConnection(this.ConnectionString);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "[pr_act_activity_get]";

            SqlParameter p;

            p = Parameters.Key_activity_id;
            p.Value = Key_activity_id;
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

            public static SqlParameter Key_activity_id
            {
                get
                {
                    return new SqlParameter("@Key_activity_id", SqlDbType.Int, 0);
                }
            }

            public static SqlParameter Key_local_plan_id
            {
                get
                {
                    return new SqlParameter("@Key_local_plan_id", SqlDbType.Int, 0);
                }
            }

            public static SqlParameter Txt_activity_name
            {
                get
                {
                    return new SqlParameter("@Txt_activity_name", SqlDbType.VarChar, 500);
                }
            }

            public static SqlParameter Txt_activity_desc
            {
                get
                {
                    return new SqlParameter("@Txt_activity_desc", SqlDbType.VarChar, 2000);
                }
            }

            public static SqlParameter Key_activity_type_id
            {
                get
                {
                    return new SqlParameter("@Key_activity_type_id", SqlDbType.Int, 0);
                }
            }

            public static SqlParameter Key_fa_activity_type_id
            {
                get
                {
                    return new SqlParameter("@Key_fa_activity_type_id", SqlDbType.Int, 0);
                }
            }

            public static SqlParameter Key_level_id
            {
                get
                {
                    return new SqlParameter("@Key_level_id", SqlDbType.Int, 0);
                }
            }

            public static SqlParameter Key_fund_source_id
            {
                get
                {
                    return new SqlParameter("@Key_fund_source_id", SqlDbType.Int, 0);
                }
            }

            public static SqlParameter Txt_activity_core_indicator_desc
            {
                get
                {
                    return new SqlParameter("@Txt_activity_core_indicator_desc", SqlDbType.VarChar, 2000);
                }
            }

            public static SqlParameter Txt_funds_reduction_impact_desc
            {
                get
                {
                    return new SqlParameter("@Txt_funds_reduction_impact_desc", SqlDbType.VarChar, 500);
                }
            }

            public static SqlParameter Key_category_id
            {
                get
                {
                    return new SqlParameter("@Key_category_id", SqlDbType.Int, 0);
                }
            }

            public static SqlParameter Flg_locked
            {
                get
                {
                    return new SqlParameter("@Flg_locked", SqlDbType.Bit, 0);
                }
            }

            public static SqlParameter Flg_approved
            {
                get
                {
                    return new SqlParameter("@Flg_approved", SqlDbType.Bit, 0);
                }
            }

            public static SqlParameter Flg_is_amendment
            {
                get
                {
                    return new SqlParameter("@Flg_is_amendment", SqlDbType.Bit, 0);
                }
            }

            public static SqlParameter Key_amendment_reason_id
            {
                get
                {
                    return new SqlParameter("@Key_amendment_reason_id", SqlDbType.Int, 0);
                }
            }

            public static SqlParameter Dte_created_date
            {
                get
                {
                    return new SqlParameter("@Dte_created_date", SqlDbType.DateTime, 0);
                }
            }

            public static SqlParameter Dte_updated_date
            {
                get
                {
                    return new SqlParameter("@Dte_updated_date", SqlDbType.DateTime, 0);
                }
            }

            public static SqlParameter Key_function_code_id
            {
                get
                {
                    return new SqlParameter("@Key_function_code_id", SqlDbType.Int, 0);
                }
            }

            public static SqlParameter Txt_system_office_notes
            {
                get
                {
                    return new SqlParameter("@Txt_system_office_notes", SqlDbType.Text, 2147483647);
                }
            }

            public static SqlParameter Txt_created_user
            {
                get
                {
                    return new SqlParameter("@Txt_created_user", SqlDbType.VarChar, 50);
                }
            }

            public static SqlParameter Txt_updated_user
            {
                get
                {
                    return new SqlParameter("@Txt_updated_user", SqlDbType.VarChar, 50);
                }
            }

        }
        #endregion

        #region ColumnNames
        public class ColumnNames
        {
            public const string Key_activity_id = "Key_activity_id";
            public const string Key_local_plan_id = "Key_local_plan_id";
            public const string Txt_activity_name = "Txt_activity_name";
            public const string Txt_activity_desc = "Txt_activity_desc";
            public const string Key_activity_type_id = "Key_activity_type_id";
            public const string Key_fa_activity_type_id = "Key_fa_activity_type_id";
            public const string Key_level_id = "Key_level_id";
            public const string Key_fund_source_id = "Key_fund_source_id";
            public const string Txt_activity_core_indicator_desc = "Txt_activity_core_indicator_desc";
            public const string Txt_funds_reduction_impact_desc = "Txt_funds_reduction_impact_desc";
            public const string Key_category_id = "Key_category_id";
            public const string Flg_locked = "Flg_locked";
            public const string Flg_approved = "Flg_approved";
            public const string Flg_is_amendment = "Flg_is_amendment";
            public const string Key_amendment_reason_id = "Key_amendment_reason_id";
            public const string Dte_created_date = "Dte_created_date";
            public const string Dte_updated_date = "Dte_updated_date";
            public const string Key_function_code_id = "Key_function_code_id";
            public const string Txt_system_office_notes = "Txt_system_office_notes";
            public const string Txt_created_user = "Txt_created_user";
            public const string Txt_updated_user = "Txt_updated_user";

        }
        #endregion


        //=================================================================
        //  Properties Generated from the Table                        
        //=================================================================

        public virtual int Key_activity_id
        {
            get
            {
                return (int)currentRow[ColumnNames.Key_activity_id];
            }

        }

        public virtual int Key_local_plan_id
        {
            get
            {
                return (int)currentRow[ColumnNames.Key_local_plan_id];
            }

            set
            {
                currentRow[ColumnNames.Key_local_plan_id] = value;
            }
        }

        public virtual string Txt_activity_name
        {
            get
            {
                return (string)currentRow[ColumnNames.Txt_activity_name];
            }

            set
            {
                currentRow[ColumnNames.Txt_activity_name] = value;
            }
        }

        public virtual string Txt_activity_desc
        {
            get
            {
                return (string)currentRow[ColumnNames.Txt_activity_desc];
            }

            set
            {
                currentRow[ColumnNames.Txt_activity_desc] = value;
            }
        }

        public virtual int Key_activity_type_id
        {
            get
            {
                return (int)currentRow[ColumnNames.Key_activity_type_id];
            }

            set
            {
                currentRow[ColumnNames.Key_activity_type_id] = value;
            }
        }

        public virtual int Key_fa_activity_type_id
        {
            get
            {
                return (int)currentRow[ColumnNames.Key_fa_activity_type_id];
            }

            set
            {
                currentRow[ColumnNames.Key_fa_activity_type_id] = value;
            }
        }

        public virtual int Key_level_id
        {
            get
            {
                return (int)currentRow[ColumnNames.Key_level_id];
            }

            set
            {
                currentRow[ColumnNames.Key_level_id] = value;
            }
        }

        public virtual int Key_fund_source_id
        {
            get
            {
                return (int)currentRow[ColumnNames.Key_fund_source_id];
            }

            set
            {
                currentRow[ColumnNames.Key_fund_source_id] = value;
            }
        }

        public virtual string Txt_activity_core_indicator_desc
        {
            get
            {
                return (string)currentRow[ColumnNames.Txt_activity_core_indicator_desc];
            }

            set
            {
                currentRow[ColumnNames.Txt_activity_core_indicator_desc] = value;
            }
        }

        public virtual string Txt_funds_reduction_impact_desc
        {
            get
            {
                return (string)currentRow[ColumnNames.Txt_funds_reduction_impact_desc];
            }

            set
            {
                currentRow[ColumnNames.Txt_funds_reduction_impact_desc] = value;
            }
        }

        public virtual int Key_category_id
        {
            get
            {
                return (int)currentRow[ColumnNames.Key_category_id];
            }

            set
            {
                currentRow[ColumnNames.Key_category_id] = value;
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

        public virtual bool Flg_approved
        {
            get
            {
                return (bool)currentRow[ColumnNames.Flg_approved];
            }

            set
            {
                currentRow[ColumnNames.Flg_approved] = value;
            }
        }

        public virtual bool Flg_is_amendment
        {
            get
            {
                return (bool)currentRow[ColumnNames.Flg_is_amendment];
            }

            set
            {
                currentRow[ColumnNames.Flg_is_amendment] = value;
            }
        }

        public virtual int Key_amendment_reason_id
        {
            get
            {
                return (int)currentRow[ColumnNames.Key_amendment_reason_id];
            }

            set
            {
                currentRow[ColumnNames.Key_amendment_reason_id] = value;
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

        public virtual DateTime Dte_updated_date
        {
            get
            {
                return (DateTime)currentRow[ColumnNames.Dte_updated_date];
            }

            set
            {
                currentRow[ColumnNames.Dte_updated_date] = value;
            }
        }

        public virtual int Key_function_code_id
        {
            get
            {
                return (int)currentRow[ColumnNames.Key_function_code_id];
            }

            set
            {
                currentRow[ColumnNames.Key_function_code_id] = value;
            }
        }

        public virtual string Txt_system_office_notes
        {
            get
            {
                //Rick added quickly just to not get errors should be handled better
                if (currentRow[ColumnNames.Txt_system_office_notes] != System.DBNull.Value)
                    return (string)currentRow[ColumnNames.Txt_system_office_notes];
                else
                    return ("");
            }

            set
            {
                currentRow[ColumnNames.Txt_system_office_notes] = value;
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

        public virtual string Txt_updated_user
        {
            get
            {
                return (string)currentRow[ColumnNames.Txt_updated_user];
            }

            set
            {
                currentRow[ColumnNames.Txt_updated_user] = value;
            }
        }


        protected SqlCommand CreateInsertCommand()
        {

            SqlCommand cmd = CreateParameters();
            cmd.CommandText = "[pr_act_activity_Insert]";


            cmd.Parameters["@Key_activity_id"].Direction = ParameterDirection.Output;

            return cmd;
        }

        protected SqlCommand CreateUpdateCommand()
        {

            SqlCommand cmd = CreateParameters();
            cmd.CommandText = "[pr_act_activity_upd]";



            return cmd;
        }

        protected SqlCommand CreateDeleteCommand()
        {

            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "[pr_act_activity_del]";

            SqlParameter p;

            p = cmd.Parameters.Add(Parameters.Key_activity_id);
            p.SourceColumn = "Key_activity_id";
            p.SourceVersion = DataRowVersion.Current;


            return cmd;
        }

        protected SqlCommand CreateParameters()
        {
            SqlParameter p;

            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            // Add params

            p = cmd.Parameters.Add(Parameters.Key_activity_id);
            p.SourceColumn = "Key_activity_id";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Key_local_plan_id);
            p.SourceColumn = "Key_local_plan_id";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Txt_activity_name);
            p.SourceColumn = "Txt_activity_name";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Txt_activity_desc);
            p.SourceColumn = "Txt_activity_desc";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Key_activity_type_id);
            p.SourceColumn = "Key_activity_type_id";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Key_fa_activity_type_id);
            p.SourceColumn = "Key_fa_activity_type_id";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Key_level_id);
            p.SourceColumn = "Key_level_id";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Key_fund_source_id);
            p.SourceColumn = "Key_fund_source_id";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Txt_activity_core_indicator_desc);
            p.SourceColumn = "Txt_activity_core_indicator_desc";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Txt_funds_reduction_impact_desc);
            p.SourceColumn = "Txt_funds_reduction_impact_desc";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Key_category_id);
            p.SourceColumn = "Key_category_id";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Flg_locked);
            p.SourceColumn = "Flg_locked";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Flg_approved);
            p.SourceColumn = "Flg_approved";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Flg_is_amendment);
            p.SourceColumn = "Flg_is_amendment";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Key_amendment_reason_id);
            p.SourceColumn = "Key_amendment_reason_id";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Dte_created_date);
            p.SourceColumn = "Dte_created_date";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Dte_updated_date);
            p.SourceColumn = "Dte_updated_date";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Key_function_code_id);
            p.SourceColumn = "Key_function_code_id";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Txt_system_office_notes);
            p.SourceColumn = "Txt_system_office_notes";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Txt_created_user);
            p.SourceColumn = "Txt_created_user";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Txt_updated_user);
            p.SourceColumn = "Txt_updated_user";
            p.SourceVersion = DataRowVersion.Current;


            return cmd;
        }
    }
}