package com.yirendai.oss.environment.configserver;

import static com.google.common.collect.Lists.newArrayList;
import static com.google.common.collect.Maps.newLinkedHashMap;
import static org.apache.commons.lang3.ArrayUtils.contains;
import static org.apache.commons.lang3.ArrayUtils.remove;
import static org.junit.Assert.assertTrue;

import com.google.common.collect.ImmutableMap;

import net.sf.json.JSONObject;

import org.junit.Before;
import org.junit.Test;
import org.springframework.boot.test.util.EnvironmentTestUtils;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.http.HttpHeaders;
import org.springframework.util.MultiValueMap;

import java.util.Map;

/**
 * Created by zhanghaolun on 16/11/3.
 */
public class GitlabpathPropertyPathNotificationExtractorTest {
  private AnnotationConfigApplicationContext context;

  private GitlabpathPropertyPathNotificationExtractor extractor;

  @Before
  public void setUp() {
    this.context = new AnnotationConfigApplicationContext();
    this.context.register(GitlabpathPropertyPathNotificationExtractor.class);
  }

  @Test
  public void testGitPath() {
    EnvironmentTestUtils.addEnvironment(this.context, "spring.cloud.config.server.common-config.application:common");
    this.context.refresh();
    this.extractor = this.context.getBean(GitlabpathPropertyPathNotificationExtractor.class);


    final MultiValueMap<String, String> headers = new HttpHeaders();
    headers.put("X-Gitlab-Event", newArrayList("Push Hook"));

    assertTrue(contains( //
        this.extractor.extract(headers, payload("yrd-todomvc-app-config")).getPaths(), //
        "yrd-todomvc-app" //
    ));
    assertTrue(contains( //
        this.extractor.extract(headers, payload("common-config")).getPaths(), //
        "application" //
    ));
  }

  @Test
  public void testCommonProductConfigPath() {
    EnvironmentTestUtils.addEnvironment(this.context, "spring.cloud.config.server.common-config.application:common-production");
    this.context.refresh();
    extractor = this.context.getBean(GitlabpathPropertyPathNotificationExtractor.class);

    final MultiValueMap<String, String> headers = new HttpHeaders();
    headers.put("X-Gitlab-Event", newArrayList("Push Hook"));

    System.setProperty("spring.cloud.config.server.common-config.application", "common-production");
    assertTrue(contains( //
        this.extractor.extract(headers, payload("common-production-config")).getPaths(), //
        "application" //
    ));
  }

  private Map<String, Object> payload(final String repository) {
    final Map<String, Object> payload = newLinkedHashMap();
    payload.put("commits", newArrayList( //
        ImmutableMap.of( //
            "url", //
            "http://gitlab.yixinonline.org/configserver/" //
                + repository //
                + "/commit/929f67f2b38a6269e7ad63f606c9d89a7d8eb79f" //
        )
    ));
    return payload;
  }
}
