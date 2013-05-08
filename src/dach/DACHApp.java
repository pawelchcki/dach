/*
 * DACHApp.java
 */

package dach;

import org.jdesktop.application.Application;
import org.jdesktop.application.SingleFrameApplication;

/**
 * The main class of the application.
 */
public class DACHApp extends SingleFrameApplication {

    /**
     * At startup create and show the main frame of the application.
     */
    @Override protected void startup() {
        show(new DACHView(this));
    }

    /**
     * This method is to initialize the specified window by injecting resources.
     * Windows shown in our application come fully initialized from the GUI
     * builder, so this additional configuration is not needed.
     */
    @Override protected void configureWindow(java.awt.Window root) {
    }

    /**
     * A convenient static getter for the application instance.
     * @return the instance of DACHApp
     */
    public static DACHApp getApplication() {
        return Application.getInstance(DACHApp.class);
    }

    /**
     * Main method launching the application.
     * @throws Exception 
     */
    public static void main(String[] args) throws Exception {
    	FileServer fs = new FileServer("./");
    	fs.start();
        launch(DACHApp.class, args);
        fs.join();
    }
}
