package github.jobs;

import cucumber.api.PendingException;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import com.jayway.restassured.RestAssured;
import com.jayway.restassured.response.Response;
import junit.framework.AssertionFailedError;
import org.json.JSONArray;
import org.json.JSONException;
import org.junit.Assert;


public class GithubSearchJobsStepdefs {

    RestAssured client = new RestAssured();
    Response response;

    @Given("^the GitHub Jobs api url is set$")
    public void theGitHubJobsApiUrlIsSet() throws Throwable {
        client.baseURI = "https://jobs.github.com";
    }

    @When("^I call jobs search api with \"([^\"]*)\" \"([^\"]*)\"$")
    public void iCallJobsSearchApiWithParam(String parameter, String value) throws Throwable {
        response = client.given()
                .get("/positions.json?" + parameter + "=" + value).then().extract().response();
    }

    @And("^response status code is \"([^\"]*)\"$")
    public void resposeStatusCodeIs(String status_code) throws Throwable {
        if (response != null) {
            System.out.println(status_code);
            Assert.assertEquals(response.getStatusCode(), Integer.parseInt(status_code));
        } else {
            throw new AssertionFailedError("response is null!");
        }
    }

    @Then("^Verify all results should have \"([^\"]*)\" in their \"([^\"]*)\" field$")
    public void verifyAllResultsShouldHaveInTheirField(String value, String fieldName) throws Throwable {
        try {
            JSONArray jsonResponse = new JSONArray(response.body().asString());
            for (int i=0; i < jsonResponse.length(); i++) {
                Assert.assertTrue(jsonResponse.getJSONObject(i).getString(fieldName).contains(value));
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    @Then("^verify the response is No Result Found$")
    public void verifyTheResponseIsNoResultFound() throws Throwable {
        try {
            JSONArray jsonResponse = new JSONArray(response.body().asString());
            Assert.assertEquals(jsonResponse.length(), 0);
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    @When("^I call jobs search api with \"([^\"]*)\" \"([^\"]*)\" and \"([^\"]*)\" \"([^\"]*)\"$")
    public void iCallJobsSearchApiWithAnd(String parameter1, String value1, String parameter2, String value2) throws Throwable {
        response = client.given()
                .get(String.format("/positions.json?%s=%s&%s=%s", parameter1, value1, parameter2, value2)).then().extract().response();
    }

    @Then("^Verify all results should have \"([^\"]*)\" in their \"([^\"]*)\" field and \"([^\"]*)\" in \"([^\"]*)\" field$")
    public void verifyAllResultsShouldHaveInTheirFieldAndInField(String value1, String fieldName1, String value2, String fieldName2) throws Throwable {
        try {
            JSONArray jsonResponse = new JSONArray(response.body().asString());
            for (int i=0; i < jsonResponse.length(); i++) {
                Assert.assertTrue(jsonResponse.getJSONObject(i).getString(fieldName1).contains(value1));
                Assert.assertTrue(jsonResponse.getJSONObject(i).getString(fieldName2).contains(value2));
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    @When("^I call jobs search api with \"([^\"]*)\" \"([^\"]*)\" and \"([^\"]*)\" \"([^\"]*)\" and \"([^\"]*)\" \"([^\"]*)\"$")
    public void iCallJobsSearchApiWithAndAnd(String parameter1, String value1, String parameter2, String value2, String parameter3, String value3) throws Throwable {
        response = client.given()
                .get(String.format("/positions.json?%s=%s&%s=%s&%s=%s", parameter1, value1, parameter2, value2, parameter3, value3)).then().extract().response();
    }

    @And("^results \"([^\"]*)\" match \"([^\"]*)\" & \"([^\"]*)\" only$")
    public void resultsMatchOnly(String arg0, String arg1, String arg2) throws Throwable {
        // TODO Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @Then("^Verify I should receive a max results count of \"([^\"]*)\"$")
    public void verifyIShouldReceiveAMaxResultsCountOf(String count) throws Throwable {
        JSONArray jsonResponse = new JSONArray(response.body().asString());
        Assert.assertTrue(jsonResponse.length() <= Integer.parseInt(count));
    }


}
