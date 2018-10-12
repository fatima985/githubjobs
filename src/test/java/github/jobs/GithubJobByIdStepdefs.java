package github.jobs;

import com.jayway.restassured.RestAssured;
import com.jayway.restassured.response.Response;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.json.JSONObject;
import org.skyscreamer.jsonassert.JSONAssert;
import org.skyscreamer.jsonassert.JSONCompareMode;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.Optional;


public class GithubJobByIdStepdefs {

    RestAssured client = new RestAssured();
    Response response;

    private static JSONObject getJobJson(String id, Optional<String> markdown) {
        JSONObject json = new JSONObject();
        BufferedReader reader;
        try {
            if (markdown.isPresent()) {
                reader = new BufferedReader(new FileReader(String.format("src/test/resources/testdata/%s_%s.json", id, markdown.get())));
            } else {
                reader = new BufferedReader(new FileReader(String.format("src/test/resources/testdata/%s_false.json", id)));
            }

            StringBuilder stringBuilder = new StringBuilder();
            String line = null;
            while ((line = reader.readLine()) != null) {
                stringBuilder.append(line);
            }
            reader.close();

            json = new JSONObject(stringBuilder.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    @Given("^the GitHub get job by id api url is set$")
    public void theGitHubGetJobByIdApiUrlIsSet() throws Throwable {
        client.baseURI = "https://jobs.github.com";
    }

    @When("^call get job by id \"([^\"]*)\"$")
    public void callGetJobById(String id) throws Throwable {
        response = client.given()
                .get(String.format("/positions/%s.json", id)).then().extract().response();
    }

    @And("^assert the job body for job \"([^\"]*)\"$")
    public void assertTheJobBody(String id) throws Throwable {
        JSONAssert.assertEquals(getJobJson(id, Optional.empty()), new JSONObject(response.asString()), JSONCompareMode.LENIENT);
    }

    @And("^assert the empty response$")
    public void assertTheEmptyResponse() throws Throwable {
        JSONAssert.assertEquals(new JSONObject(), new JSONObject(response.asString()), JSONCompareMode.STRICT);
    }

    @When("^call get job by id \"([^\"]*)\" and markdown \"([^\"]*)\"$")
    public void callGetJobByIdAndMarkdown(String id, String markdown) throws Throwable {
        response = client.given()
                .get(String.format("/positions/%s.json?markdown=%s", id, markdown)).then().extract().response();
    }

    @Then("^assert the job body for job \"([^\"]*)\" and markdown \"([^\"]*)\"$")
    public void assertTheJobBodyForJobAndMarkdown(String id, String markdown) throws Throwable {
        JSONAssert.assertEquals(getJobJson(id, Optional.of(markdown)), new JSONObject(response.asString()), JSONCompareMode.LENIENT);
    }
}
