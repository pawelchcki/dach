package dach;
import org.eclipse.jetty.server.handler.ResourceHandler;

public class FileServer extends org.eclipse.jetty.server.Server {
	private ResourceHandler resourceHandler;
	
	FileServer(){
		super(4000);	
		String serverRoot = ClassLoader.getSystemResource("dach/resources").toExternalForm();

		resourceHandler = new ResourceHandler();
		resourceHandler.setDirectoriesListed(true);
		resourceHandler.setResourceBase(serverRoot);
		
		this.setHandler(resourceHandler);
	}
}
