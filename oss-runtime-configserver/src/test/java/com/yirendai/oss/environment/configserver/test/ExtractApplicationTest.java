package com.yirendai.oss.environment.configserver.test;

import static com.yirendai.oss.environment.configserver.UsernameModifyFilter.extractConfigCoords;
import static org.junit.Assert.assertEquals;

import lombok.extern.slf4j.Slf4j;

import org.junit.Test;

/**
 * Created by zhanghaolun on 16/10/11.
 */
@Slf4j
public class ExtractApplicationTest {

  @Test
  public void testExtractApplication() {
    assertEquals("yrd-todomvc-thymeleaf",
        extractConfigCoords("/yrd-todomvc-thymeleaf-development.env.yml").getApplication());
    assertEquals("yrd-todomvc-thymeleaf",
        extractConfigCoords("/label/yrd-todomvc-thymeleaf-development.env.yml").getApplication());
    assertEquals("yrd-todomvc-thymeleaf",
        extractConfigCoords("/yrd-todomvc-thymeleaf-development.env.properties").getApplication());
    assertEquals("yrd-todomvc-thymeleaf",
        extractConfigCoords("/label/yrd-todomvc-thymeleaf-development.env.properties").getApplication());

    assertEquals("yrd-todomvc-thymeleaf",
        extractConfigCoords("/yrd-todomvc-thymeleaf/development.env").getApplication());
    assertEquals("yrd-todomvc-thymeleaf",
        extractConfigCoords("/yrd-todomvc-thymeleaf/development.env/label").getApplication());
    assertEquals("yrd-todomvc-thymeleaf",
        extractConfigCoords("/yrd-todomvc-thymeleaf/development.env/").getApplication());
  }
}
