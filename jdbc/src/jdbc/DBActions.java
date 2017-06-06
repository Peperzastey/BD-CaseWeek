package jdbc;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import javax.swing.table.TableModel;

public class DBActions {

    DatabaseGUI guiObject;
    Connection conn;

    boolean connectedToDB = false;

    boolean workshopsTableInitialized = false;

    public DBActions(DatabaseGUI guiObject) {
        this.guiObject = guiObject;
        tryConnectToDB();
    }

    public boolean tryConnectToDB() {
        if (!connectedToDB) {
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                conn = java.sql.DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "caseweek", "caseweek");
                // jdbc:oracle:thin:@//localhost:1521/xe
            } catch (ClassNotFoundException ex) {
                ex.printStackTrace();
                guiObject.setErrorMessage("workshops", "No JDBC driver found.");
                return false;
            } catch (java.sql.SQLException ex) {
                ex.printStackTrace();
                guiObject.setErrorMessage("workshops", "Error while connecting to database.");
                return false;
            }
            connectedToDB = true;
        }
        return true;
    }

    public void addWorkshop(String name, String date, String groupQty, String roomSetting, String organizer, String roomType) throws SQLException {
        if (!tryConnectToDB())
            return;
        PreparedStatement stmt = null;
        try {
            stmt = conn.prepareStatement("INSERT INTO WORKSHOPS (WS_name, WS_date, WS_group_qty, WS_room_setting, WS_organizer, WS_room_type)" + 
                "VALUES (?, ?, ?, ?, ?, ?)");
  
            // TO_DATE('21-03-17', 'DD-MM-YY')            
            stmt.setString(1, name);
            stmt.setDate(2, java.sql.Date.valueOf(date)); //format: yyyy-[m]m-[d]d ; else IllegalArgumentException 
            stmt.setInt(3, Integer.parseInt(groupQty));
            //...
            stmt.setString(6, roomType);
            stmt.executeUpdate();
        } finally {
            if (stmt != null) {
                stmt.close();
            }
        }
    }
    
    private void fetchRoomSettings(Map<String, Integer> roomSettings) throws SQLException {
        if (!tryConnectToDB())
            return;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery("select * from ROOM_SETTINGS");
            roomSettings = new HashMap<>();
            while (rs.next()) {
                roomSettings.put(rs.getString(2), rs.getInt(1));
            }
        } finally {
            if (stmt != null) {
                stmt.close();
            }
        }
    }

    // tab in the TabbedPane changed
    /*@Override
    public void stateChanged(ChangeEvent e) {
        System.out.println("StateChanged: " + e.toString());
        // if workshops Table !!
        if (!workshopsTableInitialized) {
            try {
                TableModel workshopsTableModel = DatabaseTableModel.createTableModelForDBTable("workshops");
                guiObject.setTableModel("workshops", workshopsTableModel);
                //workshopsTableInitialized = true;
            } catch (SQLException ex) {
                guiObject.setErrorMessage("workshops", ex.getLocalizedMessage());
            }
            workshopsTableInitialized = true;
        }
    }*/
 /*public TableModel fetchTableModel(String tableName) throws SQLException {
        //if (!workshopsTableInitialized) {
            TableModel workshopsTableModel = DatabaseTableModel.createTableModelForDBTable(tableName);
            
            // only if an exception is not thrown
            workshopsTableInitialized = true;
            return workshopsTableModel;
        //}
    }*/
    public class AddWorkshopActionListener implements ActionListener {

        @Override
        public void actionPerformed(ActionEvent evt) {

        }
    }

}
