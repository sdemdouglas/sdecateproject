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
    public class scs_local_plan_level
    {
        private DataTable dataTable = new DataTable();
        private DataRow currentRow = null;
        private IEnumerator enumerator = null;

        public string ConnectionString = DataAccess.getConnStr();

        public scs_local_plan_level()
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
                cmd.CommandText = "SELECT * FROM [scs_local_plan_level] WHERE 1=0";

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

            SqlDataAdapter dataAdapter = new SqlDataAdapter("[pr_scs_local_plan_level_LoadAll]", this.ConnectionString);
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
        public virtual bool LoadByPrimaryKey(int Key_local_plan_level_id)
        {
            bool loaded = false;

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = new SqlConnection(this.ConnectionString);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "[pr_scs_local_plan_level_Sel]";

            SqlParameter p;

            p = Parameters.Key_local_plan_level_id;
            p.Value = Key_local_plan_level_id;
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

            public static SqlParameter Key_local_plan_level_id
            {
                get
                {
                    return new SqlParameter("@Key_local_plan_level_id", SqlDbType.Int, 0);
                }
            }

            public static SqlParameter Nbr_local_plan_level
            {
                get
                {
                    return new SqlParameter("@Nbr_local_plan_level", SqlDbType.Int, 0);
                }
            }

            public static SqlParameter Txt_local_plan_level_status
            {
                get
                {
                    return new SqlParameter("@Txt_local_plan_level_status", SqlDbType.VarChar, 50);
                }
            }

            public static SqlParameter Txt_local_plan_level_status_desc
            {
                get
                {
                    return new SqlParameter("@Txt_local_plan_level_status_desc", SqlDbType.VarChar, 100);
                }
            }

            public static SqlParameter Txt_next_plan_level_text
            {
                get
                {
                    return new SqlParameter("@Txt_next_plan_level_text", SqlDbType.VarChar, 100);
                }
            }

        }
        #endregion

        #region ColumnNames
        public class ColumnNames
        {
            public const string Key_local_plan_level_id = "Key_local_plan_level_id";
            public const string Nbr_local_plan_level = "Nbr_local_plan_level";
            public const string Txt_local_plan_level_status = "Txt_local_plan_level_status";
            public const string Txt_local_plan_level_status_desc = "Txt_local_plan_level_status_desc";
            public const string Txt_next_plan_level_text = "Txt_next_plan_level_text";

        }
        #endregion


        //=================================================================
        //  Properties Generated from the Table                        
        //=================================================================

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

        public virtual int Nbr_local_plan_level
        {
            get
            {
                return (int)currentRow[ColumnNames.Nbr_local_plan_level];
            }

            set
            {
                currentRow[ColumnNames.Nbr_local_plan_level] = value;
            }
        }

        public virtual string Txt_local_plan_level_status
        {
            get
            {
                return (string)currentRow[ColumnNames.Txt_local_plan_level_status];
            }

            set
            {
                currentRow[ColumnNames.Txt_local_plan_level_status] = value;
            }
        }

        public virtual string Txt_local_plan_level_status_desc
        {
            get
            {
                return (string)currentRow[ColumnNames.Txt_local_plan_level_status_desc];
            }

            set
            {
                currentRow[ColumnNames.Txt_local_plan_level_status_desc] = value;
            }
        }

        public virtual string Txt_next_plan_level_text
        {
            get
            {
                return (string)currentRow[ColumnNames.Txt_next_plan_level_text];
            }

            set
            {
                currentRow[ColumnNames.Txt_next_plan_level_text] = value;
            }
        }


        protected SqlCommand CreateInsertCommand()
        {

            SqlCommand cmd = CreateParameters();
            cmd.CommandText = "[pr_scs_local_plan_level_Insert]";



            return cmd;
        }

        protected SqlCommand CreateUpdateCommand()
        {

            SqlCommand cmd = CreateParameters();
            cmd.CommandText = "[pr_scs_local_plan_level_Update]";



            return cmd;
        }

        protected SqlCommand CreateDeleteCommand()
        {

            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "[pr_scs_local_plan_level_Delete]";

            SqlParameter p;


            return cmd;
        }

        protected SqlCommand CreateParameters()
        {
            SqlParameter p;

            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;

            // Add params

            p = cmd.Parameters.Add(Parameters.Key_local_plan_level_id);
            p.SourceColumn = "Key_local_plan_level_id";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Nbr_local_plan_level);
            p.SourceColumn = "Nbr_local_plan_level";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Txt_local_plan_level_status);
            p.SourceColumn = "Txt_local_plan_level_status";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Txt_local_plan_level_status_desc);
            p.SourceColumn = "Txt_local_plan_level_status_desc";
            p.SourceVersion = DataRowVersion.Current;

            p = cmd.Parameters.Add(Parameters.Txt_next_plan_level_text);
            p.SourceColumn = "Txt_next_plan_level_text";
            p.SourceVersion = DataRowVersion.Current;


            return cmd;
        }
    }
}
