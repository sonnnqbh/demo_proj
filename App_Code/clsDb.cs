using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System;

/// <summary>
/// Summary description for clsDb
/// </summary>
public class clsDb
{
	public string cnstr = ConfigurationManager.ConnectionStrings["CONNECTION_VN"].ConnectionString;
	public SqlConnection conn;
	public clsDb()
	{
		//
		// TODO: Add constructor logic here
		//
	}
	public void getConnection()
	{
		conn = new SqlConnection(cnstr);
		conn.Open();
	}
	public void closeConnection()
	{
		conn.Close();
		conn.Dispose();
	}
	public string DbCommand(string sql)
	{
		getConnection();
		try
		{
			SqlCommand cmd = new SqlCommand(sql, conn);
			cmd.ExecuteNonQuery();
			closeConnection();
			return "0";
		}
		catch (Exception ex)
		{
			return "1";
			throw ex;
		}
		
		
	}

	public DataSet GetCommand(string sql)
	{
		SqlDataAdapter da = new SqlDataAdapter(sql, cnstr);
		DataSet ds = new DataSet();
		da.Fill(ds);
		return ds;
	}
}