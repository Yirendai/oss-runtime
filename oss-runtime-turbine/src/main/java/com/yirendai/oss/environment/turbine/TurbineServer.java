package com.yirendai.oss.environment.turbine;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.cloud.netflix.turbine.EnableTurbine;

/**
 * Created by zhanghaolun on 16/9/27.
 */
@SpringBootApplication
@EnableTurbine
public class TurbineServer {

  public static void main(String[] args) {
    new SpringApplicationBuilder(TurbineServer.class).web(true).run(args);
  }
}
