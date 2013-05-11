package dach;

import org.eclipse.jetty.server.handler.ContextHandler;
import org.eclipse.jetty.server.handler.HandlerList;
import org.eclipse.jetty.server.handler.ResourceHandler;

public class FileServer extends org.eclipse.jetty.server.Server {
    ResourceHandler _resourceHandler;
    ResourceHandler _fileHandler;
    ContextHandler _bindHandler;
    HandlerList _handlerList;
	
	FileServer(){
        super(4000);
        // Used for serving static content from jar file
        String serverResourcesRoot = ClassLoader.getSystemResource("dach/resources/web/")
                .toExternalForm();
        String serverFilesRoot = "./";
        _resourceHandler = new ResourceHandler();
        _resourceHandler.setDirectoriesListed(true);
        _resourceHandler.setResourceBase(serverResourcesRoot);
        // Used for serving content from CWD
        _fileHandler = new ResourceHandler();
        _fileHandler.setResourceBase(serverFilesRoot);
        _fileHandler.setDirectoriesListed(true);

        _bindHandler = new ContextHandler();
        _bindHandler.setContextPath("/root");
        _bindHandler.setHandler(_fileHandler);
        

        _handlerList = new HandlerList();
        _handlerList.addHandler(_bindHandler);
        _handlerList.addHandler(_resourceHandler);

        this.setHandler(_handlerList);
	}
}
