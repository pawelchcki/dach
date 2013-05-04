/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package dach;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;
import javax.swing.table.TableColumnModel;
import javax.swing.table.TableModel;
import ws.chojnacki.timetable.mapping.Departure;
import ws.chojnacki.timetable.rxmldata.EntityFactory;

/**
 *
 * @author Pawel
 */
public class DeparturesTableModel implements TableModel{
    Collection<TableModelListener> tmListeners = new ArrayList<TableModelListener>();
    private String[] colNames = {"Week", "Saturday", "Holiday"};
    private Class[] colClasses = {Departure.class, Departure.class, Departure.class};
    private EntityFactory ef;
    private List<Departure> week;
    private List<Departure> saturday;
    private List<Departure> holiday;
    //private List<Departure>[] colVals = {week, saturday, holiday};

    public DeparturesTableModel() {
        
    }
    public void fill(Collection<Departure> week, Collection<Departure> saturday, Collection<Departure> holiday){
        this.week = new ArrayList<Departure>(week);
        this.saturday = new ArrayList<Departure>(saturday);
        this.holiday = new ArrayList<Departure>(holiday);
        for (TableModelListener tml : tmListeners) {
            tml.tableChanged(new TableModelEvent(this));
        }
    }



    private int maxCount(int... vals){
        int max=0;
        for (int i : vals) {
            if (i>max)
                max = i;
        }
        return max;

    }

    public int getRowCount() {
        return maxCount(week.size(), saturday.size(), holiday.size());
    }

    public int getColumnCount() {
        return colNames.length;
    }

    public String getColumnName(int columnIndex) {
        return colNames[columnIndex];
    }

    public Class<?> getColumnClass(int columnIndex) {
        return colClasses[columnIndex];
    }

    public boolean isCellEditable(int rowIndex, int columnIndex) {
        return true;
    }

    public Object getValueAt(int rowIndex, int columnIndex) {
        Departure dept = null;
        switch (columnIndex){
            case 0: dept = week.get(rowIndex); break;
            case 1: dept = saturday.get(rowIndex); break;
            case 2: dept = holiday.get(rowIndex); break;
        }
        return dept;
    }

    public void setValueAt(Object aValue, int rowIndex, int columnIndex) {
        Departure dept = null;
        try {
            dept = (Departure) aValue;
        } catch (Exception e) {
        }
        switch (columnIndex){
            case 0: week.set(rowIndex, dept); break;
            case 1: saturday.set(rowIndex, dept); break;
            case 2: holiday.set(rowIndex, dept); break;
        }
        for (TableModelListener tml : tmListeners) {
            tml.tableChanged(new TableModelEvent(this,rowIndex, rowIndex));
        }
    }

    public void addTableModelListener(TableModelListener l) {
        if (!tmListeners.contains(l))
            tmListeners.add(l);
    }

    public void removeTableModelListener(TableModelListener l) {
        tmListeners.remove(l);
    }

}
