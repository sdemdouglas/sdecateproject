
/*

 ============= Adding a Record =================

	Employees newObj = new Employees();
	newObj.ConnectionString = "Server=localhost;Database=Northwind;UID=sa;PWD=;";
	newObj.AddNew();
	
	// Your Properties will be different here
	newObj.FirstName = "Joe";
	newObj.LastName = "Plank Plank";
	
	newObj.Save();

 ============= Updating A Record  =================

	Employees obj = new Employees();
	obj.ConnectionString = "Server=localhost;Database=Northwind;UID=sa;PWD=;";
	
	if(obj.LoadByPrimaryKey(9))
	{
		// Your Properties will be different here
		obj.LastName = "Plank";
		obj.Save();
	}

 ============= Interating through Records  =================

	Employees obj = new Employees();
	obj.ConnectionString = "Server=localhost;Database=Northwind;UID=sa;PWD=;";
	if(obj.LoadAll())
	{
		obj.Rewind();
		while(obj.MoveNext())
		{
			// Your Properties will be different here
			Console.WriteLine(obj.FirstName);
		}
	}

===============================================================================
*/
using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections;

namespace Perkins.BLL
{
	public class scs_category
	{
		private DataTable dataTable = new DataTable();
		private DataRow currentRow = null;
		private IEnumerator enumerator = null;
	
		public string ConnectionString = "";
	
		public scs_category()
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
			if(dataTable.Rows.Count == 0)
			{
				SqlCommand cmd = new SqlCommand();
				cmd.Connection = new SqlConnection(this.ConnectionString);
				cmd.CommandType = CommandType.Text;
				cmd.CommandText = "SELECT * FROM [scs_category] WHERE 1=0";
	
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
	
			SqlDataAdapter dataAdapter = new SqlDataAdapter("[proc_scs_categoryLoadAll]", this.ConnectionString);
			dataAdapter.Fill(dataTable);
	
			if(dataTable.Rows.Count > 0)
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
		public virtual bool LoadByPrimaryKey(int Key_category_id)

		{
			bool loaded = false;
	
			SqlCommand cmd = new SqlCommand();
			cmd.Connection = new SqlConnection(this.ConnectionString);
			cmd.CommandType = CommandType.StoredProcedure;
			cmd.CommandText = "[proc_scs_categoryLoadByPrimaryKey]"; 
	
			SqlParameter p;

			p = Parameters.Key_category_id;
			p.Value = Key_category_id;
			cmd.Parameters.Add(p);

			SqlDataAdapter dataAdapter = new SqlDataAdapter();
			dataAdapter.SelectCommand = cmd;
			dataAdapter.Fill(dataTable);
	
			if(dataTable.Rows.Count > 0)
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
	
			if(dataTable.Rows.Count > 0)
			{
				// Do we have any data to save
				foreach(DataRow row in dataTable.Rows)
				{
					switch(row.RowState)
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
			if(inserts)
			{
				dataAdapter.InsertCommand = this.CreateInsertCommand();
				dataAdapter.InsertCommand.Connection = new SqlConnection(this.ConnectionString);
			}
	
			if(updates)
			{
				dataAdapter.UpdateCommand = this.CreateUpdateCommand();
				dataAdapter.UpdateCommand.Connection = new SqlConnection(this.ConnectionString);
			}
	
			if(deletes)
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
			if(currentRow != null)
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
			if(dataTable != null && currentRow != null)
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
				if(dataTable != null)
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
			
			if(dataTable != null)
			{
				if(dataTable.DefaultView.Count > 0)
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
			
			if(enumerator != null && enumerator.MoveNext())
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
			
			public static SqlParameter Key_category_id
			{
				get
				{
					return new SqlParameter("@Key_category_id", SqlDbType.Int, 0);
				}
			}
			
			public static SqlParameter Txt_category_code
			{
				get
				{
					return new SqlParameter("@Txt_category_code", SqlDbType.VarChar, 50);
				}
			}
			
			public static SqlParameter Txt_category_title
			{
				get
				{
					return new SqlParameter("@Txt_category_title", SqlDbType.VarChar, 100);
				}
			}
			
			public static SqlParameter Txt_category_desc
			{
				get
				{
					return new SqlParameter("@Txt_category_desc", SqlDbType.VarChar, 2000);
				}
			}
			
			public static SqlParameter Key_category_type_id
			{
				get
				{
					return new SqlParameter("@Key_category_type_id", SqlDbType.Int, 0);
				}
			}
			
			public static SqlParameter Flg_inactive
			{
				get
				{
					return new SqlParameter("@Flg_inactive", SqlDbType.Bit, 0);
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
			
			public static SqlParameter Dte_updated_date
			{
				get
				{
					return new SqlParameter("@Dte_updated_date", SqlDbType.DateTime, 0);
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
            public const string Key_category_id = "Key_category_id";
            public const string Txt_category_code = "Txt_category_code";
            public const string Txt_category_title = "Txt_category_title";
            public const string Txt_category_desc = "Txt_category_desc";
            public const string Key_category_type_id = "Key_category_type_id";
            public const string Flg_inactive = "Flg_inactive";
            public const string Dte_created_date = "Dte_created_date";
            public const string Txt_created_user = "Txt_created_user";
            public const string Dte_updated_date = "Dte_updated_date";
            public const string Txt_updated_user = "Txt_updated_user";

		}
		#endregion
	
	
		//=================================================================
		//  Properties Generated from the Table                        
		//=================================================================
		
		public virtual int Key_category_id
		{
			get
			{
				return (int)currentRow[ColumnNames.Key_category_id];
			}
			
		}
		
		public virtual string Txt_category_code
		{
			get
			{
				return (string)currentRow[ColumnNames.Txt_category_code];
			}
			
			set
			{
				currentRow[ColumnNames.Txt_category_code] = value;
			}	
		}
		
		public virtual string Txt_category_title
		{
			get
			{
				return (string)currentRow[ColumnNames.Txt_category_title];
			}
			
			set
			{
				currentRow[ColumnNames.Txt_category_title] = value;
			}	
		}
		
		public virtual string Txt_category_desc
		{
			get
			{
				return (string)currentRow[ColumnNames.Txt_category_desc];
			}
			
			set
			{
				currentRow[ColumnNames.Txt_category_desc] = value;
			}	
		}
		
		public virtual int Key_category_type_id
		{
			get
			{
				return (int)currentRow[ColumnNames.Key_category_type_id];
			}
			
			set
			{
				currentRow[ColumnNames.Key_category_type_id] = value;
			}	
		}
		
		public virtual bool Flg_inactive
		{
			get
			{
				return (bool)currentRow[ColumnNames.Flg_inactive];
			}
			
			set
			{
				currentRow[ColumnNames.Flg_inactive] = value;
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
		
			SqlCommand cmd  = CreateParameters();
			cmd.CommandText = "[proc_scs_categoryInsert]";
	
		
			cmd.Parameters["@Key_category_id"].Direction = ParameterDirection.Output;

			return cmd;
		}
	
		protected SqlCommand CreateUpdateCommand()
		{
		
			SqlCommand cmd = CreateParameters();
			cmd.CommandText = "[proc_scs_categoryUpdate]";
	
		

			return cmd;
		}
	
		protected SqlCommand CreateDeleteCommand()
		{
		
			SqlCommand cmd = new SqlCommand();
			cmd.CommandType = CommandType.StoredProcedure;
			cmd.CommandText = "[proc_scs_categoryDelete]";
	
			SqlParameter p;
		
			p = cmd.Parameters.Add(Parameters.Key_category_id);
			p.SourceColumn = "Key_category_id";
			p.SourceVersion = DataRowVersion.Current;


			return cmd;
		}
	
		protected SqlCommand CreateParameters()
		{
			SqlParameter p;
	
			SqlCommand cmd = new SqlCommand();
			cmd.CommandType = CommandType.StoredProcedure;
	
			// Add params
		
			p = cmd.Parameters.Add(Parameters.Key_category_id);
			p.SourceColumn = "Key_category_id";
			p.SourceVersion = DataRowVersion.Current;

			p = cmd.Parameters.Add(Parameters.Txt_category_code);
			p.SourceColumn = "Txt_category_code";
			p.SourceVersion = DataRowVersion.Current;

			p = cmd.Parameters.Add(Parameters.Txt_category_title);
			p.SourceColumn = "Txt_category_title";
			p.SourceVersion = DataRowVersion.Current;

			p = cmd.Parameters.Add(Parameters.Txt_category_desc);
			p.SourceColumn = "Txt_category_desc";
			p.SourceVersion = DataRowVersion.Current;

			p = cmd.Parameters.Add(Parameters.Key_category_type_id);
			p.SourceColumn = "Key_category_type_id";
			p.SourceVersion = DataRowVersion.Current;

			p = cmd.Parameters.Add(Parameters.Flg_inactive);
			p.SourceColumn = "Flg_inactive";
			p.SourceVersion = DataRowVersion.Current;

			p = cmd.Parameters.Add(Parameters.Dte_created_date);
			p.SourceColumn = "Dte_created_date";
			p.SourceVersion = DataRowVersion.Current;

			p = cmd.Parameters.Add(Parameters.Txt_created_user);
			p.SourceColumn = "Txt_created_user";
			p.SourceVersion = DataRowVersion.Current;

			p = cmd.Parameters.Add(Parameters.Dte_updated_date);
			p.SourceColumn = "Dte_updated_date";
			p.SourceVersion = DataRowVersion.Current;

			p = cmd.Parameters.Add(Parameters.Txt_updated_user);
			p.SourceColumn = "Txt_updated_user";
			p.SourceVersion = DataRowVersion.Current;


			return cmd;
		}
	}
}
