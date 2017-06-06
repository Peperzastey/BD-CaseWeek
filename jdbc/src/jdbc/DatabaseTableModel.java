package jdbc;

import com.sun.rowset.CachedRowSetImpl;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import javax.sql.rowset.CachedRowSet;
import javax.swing.event.TableModelListener;
import javax.swing.table.TableModel;

public class DatabaseTableModel implements TableModel {
    
    CachedRowSet cachedRowSet;
    ResultSetMetaData metadata;
    int numColumns;
    int numRows;
    
    public DatabaseTableModel(CachedRowSet rowSet) throws SQLException {
        this.cachedRowSet = rowSet;
        this.metadata = this.cachedRowSet.getMetaData();
        numColumns = metadata.getColumnCount();

        // get the numRows
        this.cachedRowSet.beforeFirst();
        this.numRows = 0;
        while (this.cachedRowSet.next()) {
          ++this.numRows;
        }
        this.cachedRowSet.beforeFirst();
    }
    
    public static CachedRowSet getDBTableRowSet(String tableName) throws SQLException {
        CachedRowSet crs = null;

        //connection = settings.getConnection();
        crs = new CachedRowSetImpl();
        crs.setType(ResultSet.TYPE_SCROLL_INSENSITIVE);
        crs.setConcurrency(ResultSet.CONCUR_UPDATABLE);
        crs.setUsername("caseweek");
        crs.setPassword("caseweek");    
        crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");

        crs.setCommand("select * from " + tableName);
        crs.execute();
        return crs;
    }
    
    public static DatabaseTableModel createTableModelForDBTable(String tableName) throws SQLException {
        try {
            CachedRowSet crs = getDBTableRowSet(tableName);
            return new DatabaseTableModel(crs);
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw ex;
            //return null;
        }
    }

    @Override
    public int getRowCount() {
        return numRows;
    }

    @Override
    public int getColumnCount() {
        return numColumns;
    }

    @Override
    public String getColumnName(int columnIndex) {
        try {
            return this.metadata.getColumnLabel(columnIndex + 1);
        } catch (SQLException e) {
            return e.toString();
        }
    }

    @Override
    public Class<?> getColumnClass(int columnIndex) {
        // all values in the table are converted to String values
        return String.class;
    }

    @Override
    public boolean isCellEditable(int rowIndex, int columnIndex) {
        return false;
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {
        try {
            this.cachedRowSet.absolute(rowIndex + 1);
            Object o = this.cachedRowSet.getObject(columnIndex + 1);
            if (o == null) {
                return null;
            } else {
                return o.toString();
            }
        } catch (SQLException e) {
            return e.toString();
        }
    }

    @Override
    public void setValueAt(Object aValue, int rowIndex, int columnIndex) {
        //throw new UnsupportedOperationException("Table modification not supported.");
        System.out.println("Called setValueAt.");
    }

    @Override
    public void addTableModelListener(TableModelListener l) {
        //throw new UnsupportedOperationException("Table modification not supported.");
        System.out.println("Called addTableModelListener.");
    }

    @Override
    public void removeTableModelListener(TableModelListener l) {
        //throw new UnsupportedOperationException("Table modification not supported.");
        System.out.println("Called removeTableModelListener.");
    }
}
