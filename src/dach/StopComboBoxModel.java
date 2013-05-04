/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package dach;

import javax.swing.ComboBoxModel;
import javax.swing.DefaultComboBoxModel;
import javax.swing.event.ListDataListener;
import ws.chojnacki.timetable.rxmldata.EntityFactory;

/**
 *
 * @author Pawel
 */
public class StopComboBoxModel extends WrapperModel implements ComboBoxModel {
    private Class aClass;
    private EntityFactory eff;
    private Object selectedObject;

    public StopComboBoxModel(EntityFactory ef, Class aClass) {
        super(ef, aClass);
        this.eff = ef;
        this.aClass = aClass;

    }

    public void setSelectedItem(Object anObject) {
        if ((selectedObject != null && !selectedObject.equals( anObject )) ||
	    selectedObject == null && anObject != null) {
	    selectedObject = anObject;
	    fireContentsChanged(this, -1, -1);
        }
    }

    public Object getSelectedItem() {
        return this.selectedObject;
    }


}
