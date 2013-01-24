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
    public class act_change
    {
        private DataTable dataTable = new DataTable();
        private DataRow currentRow = null;
        private IEnumerator enumerator = null;

        public string ConnectionString = DataAccess.getConnStr();

        public act_change()
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
                cmd.CommandText = "SELECT * FROM [act_change] WHERE 1=0";

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

            SqlDataAdapter dataAdapter = new SqlDataAdapter("[pr_act_change_LoadAll]", this.ConnectionString);
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
        public virtual bool LoadByPrimaryKey(int Key_act_change_id)
        {
            bool loaded = false;

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = new SqlConnection(this.ConnectionString);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "[pr_act_change_request_get]";

            SqlParameter p;

            p = Parameters.Key_act_change_id;
            p.Value = Key_act_change_id;
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

            public static SqlParameter Key_act_change_id
            {
                get
                {
                    return new SqlParameter("@Key_act_change_id", SqlDbType.Int, 0);
                }
            }

            public static SqlParameter Key_activity_id
            {
                get
                {
                    return new SqlParameter("@Key_activity_id", SqlDbType.Int, 0);
                }
            }

            public static SqlParameter Txt_activity_name_old
            {
                get
                {
                    return new SqlParameter("@Txt_activity_name_old", SqlDbType.VarChar, 100);
                }
            }

            public static SqlParameter Txt_activity_name_new
            {
                get
                {
                    return new SqlParameter("@Txt_activity_name_new", SqlDbType.VarChar, 100);
                }
            }

            public static SqlParameter Txt_activity_desc_old
            {
                get
                {
                    return new SqlParameter("@Txt_activity_desc_old", SqlDbType.VarChar, 2000);
                }
            }

            public static SqlParameter Txt_activity_desc_new
            {
                get
                {
                    return new SqlParameter("@Txt_activity_desc_new", SqlDbType.VarChar, 2000);
                }
            }

            public static SqlParameter Txt_activity_core_indicator_desc_old
            {
                get
                {
                    return new SqlParameter("@Txt_activity_core_indicator_desc_old", SqlDbType.VarChar, 2000);
                }
            }

            public static SqlParameter Txt_activity_core_indicator_desc_new
            {
                get
                {
                    return new SqlParameter("@Txt_activity_core_indicator_desc_new", SqlDbType.VarChar, 2000);
                }
            }

            public static SqlParameter Flg_approved
            {
                get
                {
                    return new SqlParameter("@Flg_approved", SqlDbType.Bit, 0);
                }
            }

            public static SqlParameter Dte_create_date
            {
                get
                {
                    return new SqlParameter("@Dte_create_date", SqlDbType.DateTime, 0);
                }
            }

            public static SqlParameter Txt_user_name
            {
                get
                {
                    return new SqlParameter("@Txt_user_name", SqlDbType.VarChar, 50);
                }
            }

            public static SqlParameter Dte_update_date
            {
                get
                {
                    return new SqlParameter("@Dte_update_date", SqlDbType.DateTime, 0);
                }
            }

            public static SqlParameter Txt_update_user
            {
                get
                {
                    return new SqlParameter("@Txt_update_user", SqlDbType.VarChar, 50);
                }
            }

        }
        #endregion

        #region ColumnNames
        public class ColumnNames
        {
            public const string Key_act_change_id = "Key_act_change_id";
            public const string Key_activity_id = "Key_activity_id";
            public const string Txt_activity_name_old = "Txt_activity_name_old";
            public const string Txt_activity_name_new = "Txt_activity_name_new";
            public const string Txt_activity_desc_old = "Txt_activity_desc_old";
            public const string Txt_activity_desc_new = "Txt_activity_desc_new";
            public const string Txt_activity_core_indicator_desc_old = "Txt_activity_core_indicator_desc_old";
            public const string Txt_activity_core_indicator_desc_new = "Txt_activity_core_indicator_desc_new";
            public const string Flg_approved = "Flg_approved";
            public const string Dte_create_date = "Dte_create_date";
            public const string Txt_user_name = "Txt_user_name";
            public const string Dte_update_date = "Dte_update_date";
            public const string Txt_update_user = "Txt_update_user";

        }
        #endregion


        //=================================================================
        //  Properties Generated from the Table                        
        //=================================================================

        public virtual int Key_act_change_id
        {
            get
            {
                return (int)currentRow[ColumnNames.Key_act_change_id];
            }

        }

        public virtual int Key_activity_id
        {
            get
            {
                return (int)currentRow[ColumnNames.Key_activity_id];
            }

            set
            {
                currentRow[ColumnNames.Key_activity_id] = value;
            }
        }

        public virtual string Txt_activity_name_old
        {
            get
            {
                return (string)currentRow[ColumnNames.Txt_activity_name_old];
            }

            set
            {
                currentRow[ColumnNames.Txt_activity_name_old] = value;
            }
        }

        public virtual string Txt_activity_name_new
        {
            get
            {
                return (string)currentRow[ColumnNames.Txt_activity_name_new];
            }

            set
            {
                currentRow[ColumnNames.Txt_activity_name_new] = value;
            }
        }

        public virtual string Txt_activity_desc_old
        {
            get
            {
                return (string)currentRow[ColumnNames.Txt_activity_desc_old];
            }

            set
            {
                currentRow[ColumnNames.Txt_activity_desc_old] = value;
            }
        }

        public virtual string Txt_activity_desc_new
        {
            get
            {
                return (string)currentRow[ColumnNames.Txt_activity_desc_new];
            }

            set
            {
                currentRow[ColumnNames.Txt_activity_desc_new] = value;
            }
        }

        public virtual string Txt_activity_core_indicator_desc_old
        {
            get
            {
                return (string)currentRow[ColumnNames.Txt_activity_core_indicator_desc_old];
            }

            set
            {
                currentRow[ColumnNames.Txt_activity_core_indicator_desc_old] = value;
            }
        }

        public virtual string Txt_activity_core_indicator_desc_new
        {
            get
            {
                return (string)currentRow[ColumnNames.Txt_activity_core_indicator_desc_new];
            }

            set
            {
                currentRow[ColumnNames.Txt_activity_core_indicator_desc_new] = value;
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

        public virtual DateTime Dte_create_date
        {
            get
            {
                return (DateTime)currentRow[ColumnNames.Dte_create_date];
            }

            set
            {
                currentRow[ColumnNames.Dte_create_date] = value;
            }
        }

        public virtual string Txt_user_name
        {
            get
            {
                return (string)currentRow[ColumnNames.Txt_user_name];
            }

            set
            {
                currentRow[ColumnNames.Txt_user_name] = value;
            }
        }

        public virtual DateTime Dte_update_date
        {
            get
            {
                return (DateTime)currentRow[ColumnNames.Dte_update_date];
            }

            set
            {
                currentRow[ColumnNames.Dte_update_date] = value;
            }
        }

        public virtual string Txt_update_user
        {
            get
            {
                return (string)currentRow[ColumnNames.Txt_update_user];
            }

            set
            {
                currentRow[ColumnNames.Txt_update_user] = value;
            }
        }


        protected SqlCommand CreateInsertCommand()
        {

            SqlCommand cmd = CreateParameters();
            cmd.CommandText = "[pr_act_change_Insert]";


            cmd.Parameters["@Key_act_change_id"].Direction = ParameterDirection.Output;

            return cmd;
        }

        protected SqlCommand CreateUpdateCommand()
        {

            SqlCommand cmd = CreateParameters();
            cmd.CommandText = "[pr_act_change_Update]";



            return cmd;
        }

        protected SqlCommand CreateDeleteCommand()
        {

            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "[pr_act_change_del]";

            SqlParameter p;

            p = cmd.Parameters.Add(Parameters.Key_act_change_id);
            p.SourceColumn = "Key_act_change_id";
            p.SourceVersion = DataRowVersion.Current;


            return cmd;
        }

        protected SqlCommand CreateParameters()
        {
            SqlParameter p;

            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            // Add params

            p = cmd.Parameters.Add(Parameters.Key_act_change_id);
            p.SourceColumn = "Key_act_change_id";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Key_activity_id);
            p.SourceColumn = "Key_activity_id";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Txt_activity_name_old);
            p.SourceColumn = "Txt_activity_name_old";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Txt_activity_name_new);
            p.SourceColumn = "Txt_activity_name_new";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Txt_activity_desc_old);
            p.SourceColumn = "Txt_activity_desc_old";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Txt_activity_desc_new);
            p.SourceColumn = "Txt_activity_desc_new";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Txt_activity_core_indicator_desc_old);
            p.SourceColumn = "Txt_activity_core_indicator_desc_old";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Txt_activity_core_indicator_desc_new);
            p.SourceColumn = "Txt_activity_core_indicator_desc_new";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Flg_approved);
            p.SourceColumn = "Flg_approved";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Dte_create_date);
            p.SourceColumn = "Dte_create_date";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Txt_user_name);
            p.SourceColumn = "Txt_user_name";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Dte_update_date);
            p.SourceColumn = "Dte_update_date";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Txt_update_user);
            p.SourceColumn = "Txt_update_user";
            p.SourceVersion = DataRowVersion.Current;


            return cmd;
        }
    }
}
