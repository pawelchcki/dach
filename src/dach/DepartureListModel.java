/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package dach;

import java.util.List;
import javax.swing.AbstractListModel;

/**
 *
 * @author Pawel
 */
public class DepartureListModel extends AbstractListModel{
    List list;

    public DepartureListModel(List list) {
        this.list = list;

    }

    public int getSize() {
        return list.size();
    }

    public Object getElementAt(int index) {
        return list.get(index);
    }

    public void addElementAt(int index, Object dept){
        list.add(index, dept);
        fireIntervalAdded(this, index, index);
    }
    public void addElement(Object dept){
        list.add(dept);
        fireIntervalAdded(this, list.lastIndexOf(dept), list.lastIndexOf(dept));
    }
    public void removeElementAt(int index){
        list.remove(index);
        fireIntervalRemoved(this, index, index);
    }
    public List getList() {
        return list;
    }

    

}
