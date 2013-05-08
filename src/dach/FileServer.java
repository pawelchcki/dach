package dach;

import org.eclipse.jetty.server.handler.ResourceHandler;

public class FileServer extends org.eclipse.jetty.server.Server {
	private ResourceHandler resourceHandler;
	
	FileServer(String filePath){
		super(4000);
		if (filePath == ""){
			filePath=".";
		}
		resourceHandler = new ResourceHandler();
		resourceHandler.setDirectoriesListed(true);
		resourceHandler.setWelcomeFiles(new String[]{"index.html"});
		resourceHandler.setResourceBase(filePath);
		this.setHandler(resourceHandler);
	}

}
