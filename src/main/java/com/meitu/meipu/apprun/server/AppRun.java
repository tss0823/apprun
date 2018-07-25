//import com.meitu.meipu.darwin.web.controller.ServerRun;
package com.meitu.meipu.apprun.server;
import org.apache.catalina.Context;
import org.apache.catalina.LifecycleException;
import org.apache.catalina.WebResourceRoot;
import org.apache.catalina.startup.Tomcat;
import org.apache.catalina.webresources.DirResourceSet;
import org.apache.catalina.webresources.StandardRoot;
import org.apache.tomcat.util.http.fileupload.FileUtils;

import javax.servlet.ServletException;
import java.io.File;

/**
 * @author: shengshan.tang
 * @date: 上午11:25
 */
public class AppRun {

    public static void main(String[] args) throws ServletException, LifecycleException {

//        ServerRun.main(new String[]{});
        String projectName = args[0];
        int port = Integer.valueOf(args[1]);
        execute(projectName,port);
//        exeOld();
    }

    public static void exeOld() throws ServletException, LifecycleException {
        Tomcat tomcat = new Tomcat();
        tomcat.setPort(8080);
        tomcat.setBaseDir("target/tomcat");
        String userDir = System.getProperty("user.dir");

        Context ctx = tomcat.addWebapp("/", new File(userDir + "/darwin-web").getAbsolutePath());

//

        WebResourceRoot resources = new StandardRoot(ctx);


        File additionWebInfClasses = new File("target/classes");
        resources.addPreResources(new DirResourceSet(resources, "/WEB-INF/classes",
                additionWebInfClasses.getAbsolutePath(), "/"));
        ctx.setResources(resources);

        tomcat.start();
        tomcat.getServer().await();
    }

    public static void execute(String projectName,int port) throws ServletException, LifecycleException {
        Tomcat tomcat = new Tomcat();
        tomcat.setPort(port);
        tomcat.setBaseDir("target/tomcat");
        String userDir = System.getProperty("user.dir");
//        userDir = "/Users/pro/workspace/darwin";
        System.out.printf("userDir="+userDir);
        tomcat.addWebapp("/", new File(userDir+"/"+projectName+"-web/target/ROOT").getAbsolutePath());

        tomcat.start();
        tomcat.getServer().await();
    }
}
