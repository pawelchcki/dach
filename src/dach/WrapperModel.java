/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package dach;

import java.util.Collection;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.AbstractListModel;
import ws.chojnacki.timetable.mapping.Line;
import ws.chojnacki.timetable.mapping.Stop;
import ws.chojnacki.timetable.rxmldata.EntityFactory;
import ws.chojnacki.timetable.rxmldata.IdentifiedEntity;

/**
 *
 * @author Pawel
 */
public class WrapperModel extends AbstractListModel {
    private List<IdentifiedEntity> cie;
    private EntityFactory ef;
    private Class aClass;
    @Deprecated
    public WrapperModel(List<IdentifiedEntity> cie) {
        this.cie = cie;
    }

    WrapperModel(EntityFactory ef, Class aClass) {
        this.ef = ef;
        this.aClass = aClass;
        this.cie = ef.getAllEntitiesList(aClass);
    }

    public int getSize() {
        return cie.size();
    }

    public Object getElementAt(int index) {
        return cie.get(index);
    }
    public void removeElementAt(int index){
        IdentifiedEntity ie = cie.get(index);
        try {
            ef.remove(ie);
        } catch (Exception ex) {
            Logger.getLogger(WrapperModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        cie.remove(index);
        fireIntervalRemoved(this, index, index);
    }

    public void addElementAtTheEnd(IdentifiedEntity ie) {
        cie.add(ie);
        try {
            ef.persist(ie);
        } catch (Exception ex) {
            Logger.getLogger(WrapperModel.class.getName()).log(Level.SEVERE, null, ex);
        }
        fireIntervalAdded(this, cie.lastIndexOf(ie), cie.lastIndexOf(ie));
    }

    public void change(IdentifiedEntity ie) {
        fireContentsChanged(this, cie.lastIndexOf(ie), cie.lastIndexOf(ie));
    }
    
    public void reload(){
        this.cie = ef.getAllEntitiesList(aClass);
        fireContentsChanged(this, 0, cie.size()-1);
        
    }

    public List<IdentifiedEntity> getCie() {
        return cie;
    }
    



}
