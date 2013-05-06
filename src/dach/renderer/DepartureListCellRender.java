/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dach.renderer;

import java.awt.Color;
import java.awt.Component;
import java.text.SimpleDateFormat;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.ListCellRenderer;
import ws.chojnacki.timetable.mapping.Departure;
import ws.chojnacki.timetable.mapping.Distance;
import ws.chojnacki.timetable.mapping.Line;
import ws.chojnacki.timetable.mapping.Stop;

/**
 *
 * @author Pawel
 */
public class DepartureListCellRender extends JLabel implements ListCellRenderer {

    public DepartureListCellRender() {
        setOpaque(true);
    }

    public Component getListCellRendererComponent(JList list, Object value, int index, boolean isSelected, boolean cellHasFocus) {
        if (value.getClass().isAssignableFrom(String.class)) {
            setText(value.toString());
        } else {
            Departure dept = (Departure) value;
            SimpleDateFormat df = new SimpleDateFormat("HH:mm");
            setText(df.format(dept.getTime()) + dept.getLegend());
        }
        if (isSelected) {
            setBackground(Color.RED);
            setForeground(Color.WHITE);

        // unselected, and not the DnD drop location
        } else {
            setBackground(Color.WHITE);
            setForeground(Color.BLACK);
        }
//        /this.setSize(50, 10);


        return this;
    }
}
