package jdbc;

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

	public static void main(String[] args) {

		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException exp) {
			System.err.println("No JDBC driver found");
			return;
		}

		java.sql.Connection conn = null;
		java.sql.Statement state = null;
		java.sql.ResultSet rs1 = null;
		String myQuery = "";
		
		try {
			conn = java.sql.DriverManager.getConnection("jdbc:oracle:thin:@ora3.elka.pw.edu.pl:1521:ora3inf", "---", "---");
			state = conn.createStatement();
		} catch (java.sql.SQLException exp) {
			System.err.println("Error while connecting to database.");
		}

//		myQuery = "SELECT * FROM cities";		
//		printQuery(state, myQuery);
		simpleQuery(state);
		
		try{
			conn.close();
		} catch (java.sql.SQLException exp) {
			System.err.println("Error while closing database.");
		}
		
		
		System.out.println("Finished");
	}

	public static void printQuery(Statement state, String query) {
		try {
			java.sql.ResultSet rs = null;
			rs = state.executeQuery(query);
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
	
	
	public static void simpleQuery(Statement state) {
		Scanner keyboard = new Scanner(System.in);
		System.out.println("What do you want to select? ");
		String toSelect = keyboard.next();
		System.out.println("From which table? ");
		String toFrom = keyboard.next();
		printQuery(state, "SELECT " + toSelect + " FROM " + toFrom);
		keyboard.close();
		
	}
	
}
