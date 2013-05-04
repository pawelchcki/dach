/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dach.renderer;

import java.awt.Color;
import java.awt.Component;
import java.util.Calendar;
import javax.swing.JLabel;
import javax.swing.JTable;
import javax.swing.table.TableCellRenderer;
import ws.chojnacki.timetable.mapping.Departure;

/**
 *
 * @author Pawel
 */
public class DeptTableCellRenderer extends JLabel implements TableCellRenderer {

    public DeptTableCellRenderer() {
        setOpaque(true);
    }

    public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {

        Departure dept = (Departure) value;
        setText(dept.getTime().getHours() + ":" + dept.getTime().getMinutes() + dept.getLegend());

        if (isSelected) {
            setBackground(Color.RED);
            setForeground(Color.WHITE);

        // unselected, and not the DnD drop location
        } else {
            setBackground(Color.WHITE);
            setForeground(Color.BLACK);
        }


        return this;

    }
}

