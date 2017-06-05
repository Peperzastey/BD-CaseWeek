package jdbc;

import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.Scanner;

/**
 * CaseWeek database project for BD classes at WUT.  
 * 
 * @author Maciej Kêdzielski / maciej.kedzielski@gmail.com
 * @author Przemys³aw Poljañski / 
 * @version 1.0
 */


public class CaseWeekJDBC {
	
	static java.sql.Connection conn = null;

	public static void main(String[] args) {

		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException exp) {
			System.err.println("No JDBC driver found");
			return;
		}

		
		java.sql.ResultSet rs1 = null;
		String myQuery = "";
		
		try {
			conn = java.sql.DriverManager.getConnection("jdbc:oracle:thin:@ora3.elka.pw.edu.pl:1521:ora3inf", "mkedzie4", "mkedzie4");
		} catch (java.sql.SQLException exp) {
			System.err.println("Error while connecting to database.");
		}

		myQuery = "SELECT * FROM cities";		
		simpleQuery();
		//simpleInsert();
		
		try{
			conn.close();
		} catch (java.sql.SQLException exp) {
			System.err.println("Error while closing database.");
		}
		
		
		System.out.println("Finished");
	}

	public static void printQuery(String query) {
		try {
			ResultSet rs = null;
			PreparedStatement state = conn.prepareStatement(query);
			rs = state.executeQuery();
			ResultSetMetaData rm = rs.getMetaData();
			int colNum = rm.getColumnCount();
			String colValues = "";
			for (int i=1; i <= colNum; i++) {
				colValues = colValues.concat(rm.getColumnName(i) + "\t");
			}
			System.out.println(colValues);
			while (rs.next()) {
				colValues = "";
				for (int i=1; i <= colNum; i++) {
					if (i>1) colValues = colValues.concat("\t");
					colValues = colValues.concat(rs.getString(i));
				}
				System.out.println(colValues);
			}
			
		} catch (java.sql.SQLException exp) {
			System.err.println("Error - wrong query.");
		}
	}
	
	
	public static void simpleQuery() {
		Scanner keyboard = new Scanner(System.in);
		System.out.println("What do you want to select? ");
		String toSelect = keyboard.next();
		System.out.println("From which table? ");
		String toFrom = keyboard.next();
		printQuery("SELECT " + toSelect + " FROM " + toFrom);
		keyboard.close();		
	}
	
	/* s³abo to dziala */
	public static void simpleInsert() {
		Scanner keyboard = new Scanner(System.in);
		System.out.println("To which table do you want to insert a row? ");
		String tableName = keyboard.next();

		try {
			PreparedStatement state = conn.prepareStatement("SELECT * from " + tableName + " WHERE ROWNUM = 1");
			ResultSet rs = state.executeQuery();
			System.out.println(rs.next());
			ResultSetMetaData rm = rs.getMetaData();
			int colNum = rm.getColumnCount();
			String columnSet = "";
			String dataSet = "";
			for (int i=1; i <= colNum; i++) {
				System.out.println("Type data for column " + rm.getColumnName(i));
				String colVal = keyboard.next();
				if (i>1) {
					columnSet = columnSet.concat(", ");
					dataSet = dataSet.concat(", ");
				}
				columnSet = columnSet.concat(rm.getColumnName(i));
				dataSet = dataSet.concat(colVal);				
			}
			System.out.println("INSERT INTO " + tableName + " (" + columnSet + ") VALUES (" + dataSet + ");");
//			state.executeUpdate("INSERT INTO " + tableName + " (" + columnSet + ") VALUES (" + dataSet + ");");
		} catch (java.sql.SQLException exp) {
			System.err.println("Error while getting metadata");
			exp.printStackTrace();
		}
//		
//		int colNum = rm.getColumnCount();
//		String colValues = "";
//		for (int i=1; i <= colNum; i++) {
//			colValues = colValues.concat(rm.getColumnName(i) + "\t");
//		}
		
		keyboard.close();		
	}
	
}
