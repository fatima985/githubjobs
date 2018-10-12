@searchJobService
Feature: Search for Github Jobs

  @priority-critical @smoke
  Scenario Outline: Verify search jobs by title
    Given the GitHub Jobs api url is set
    When I call jobs search api with "title" "<title>"
    Then Verify all results should have "<title>" in their "title" field
    And response status code is "<response_status>"

    Examples:
      | title                     | response_status|
      | Software Testing Engineer | 200 |
      | Backend software engineer | 200 |
      | Web Developer             | 200 |

  @priority-critical @smoke
  Scenario Outline: Verify search with non existing position title will return no results found
    Given the GitHub Jobs api url is set
    When I call jobs search api with "title" "<title>"
    Then verify the response is No Result Found
    And response status code is "<response_status>"

    Examples:
      | title      | response_status |
      | kikikiki88 | 200             |
      | test1      | 200             |
      | fatima     | 200             |
      | محامي      | 200             |

  @priority-low
  Scenario Outline: Verify bad request on search with position title.
    Given the GitHub Jobs api url is set
    When I call jobs search api with "title" "<title>"
    Then response status code is "<response_status>"

    Examples:
      | title | response_status |
      |       | 400             |
      | ffffffffffffffffffffffffffffffffaffffffffffffffffffffffffffffffffasdfghjkjhgfdsdfghjhgfdssdfghjhgfdsdfghjkjhgfdsdfghjhgfdsdfghjhgfdsdfghjjhgfdssdfghjkjhgfdsdfghjhgfdssdfghjhgfdsdfghjkjhgfdsdfghjhgfdsdfghjhgfdsdfghjjhgfds | 400 |

  @priority-critical @smoke
  Scenario Outline:Verify search with description
    Given the GitHub Jobs api url is set
    When  I call jobs search api with "description" "<description>"
    Then Verify all results should have "<description>" in their "description" field
    And response status code is "<response_status>"

    @stage
    Examples: stage environment
      | description |response_status|
      | test1       | 200           |
      | test2       | 200           |
      | test3       | 200           |

    @production
    Examples: production environment
      | description |response_status|
      | python      | 200           |
      | java        | 200           |
      | PHP         | 200           |

  @priority-critical @smoke @stage
  Scenario Outline: Verify search with non existing description
    Given the GitHub Jobs api url is set
    When I call jobs search api with "description" "<description>"
    Then verify the response is No Result Found
    And response status code is "<response_status>"

    Examples:
      | description | response_status |
      |  kikikiki88 | 404             |
      | test1       | 404             |
      | fatima      | 404             |
      | محامي       | 404             |

  @priority-critical @smoke @production
  Scenario Outline: Verify search with description & Location
    Given the GitHub Jobs api url is set
    When I call jobs search api with "<parameter>" "<parameter_value>" and "location" "<location>"
    Then Verify all results should have "<parameter_value>" in their "description" field and "<location>" in "location" field

    Examples:
      | parameter   | parameter_value | location |
      | description | PHP             | Chicago  |
      | description | java            | Switzerland|
      | search      | ruby            | Chantilly,VA |
      | search      | java            | Remote   |

  @priority-critical @production
  Scenario Outline: Verify search with Country Code
    Given the GitHub Jobs api url is set
    When I call jobs search api with "description" "<description>" and "location" "<location>"
    Then Verify all results should have "<description>" in their "description" field and "<location>" in "location" field

    Examples:
      | description | location |
      | python      | sf       |
      | PHP         | uae      |
      | python      | ca       |

  @priority-critical @stage
  Scenario Outline: Verify search with description & lat,long
    Given the GitHub Jobs api url is set
    When I call jobs search api with "description" "<description>" and "lat" "<lat>" and "long" "<long>"
    Then Verify all results should have "<description>" in their "description" field and "<location>" in "location" field
    And response status code is "<response_status>"

    Examples:
      | description | lat        | long          | location | response_status |
      | python      | 25.2048    | 55.2708       |     CA   | 200             |
      | python      | 37.3229978 | -122.0321823  |     SF   | 200             |
      | python      | 23.6345    | 102.5528      |     SF   | 200             |

  @priority-critical @stage
  Scenario Outline: Verify search with location & (lat, long) returns results matching (lat, long) only
    Given the GitHub Jobs api url is set
    When I call jobs search api with "location" "<location>" and "lat" "<lat>" and "long" "<long>"
    Then response status code is "<response_status>"
    And results "location" match "<lat>" & "<long>" only

    Examples:
      | location  | lat        | long         | response_status |
      | australia | 37.3229978 | -122.0321823 | 200 |

  @priority-critical @smoke @staging
  Scenario Outline: Verify search by full time parameter
    Given the GitHub Jobs api url is set
    When I call jobs search api with "fulltime" "<full_time>"
    Then Verify all results should have "<job_type>" in their "type" field

    Examples:
      | full_time  | job_type  |
      |  true      | Full Time |
      |  false     | Part Time |

  @priority-critical @smoke @production
  Scenario Outline: Verify search with pagination
    Given the GitHub Jobs api url is set
    When I call jobs search api with "page" "<Number>"
    Then Verify I should receive a max results count of "50"

    Examples:
      | Number |
      | 0      |
      | 1      |
      | 2      |

  @priority-critical @smoke @production
  Scenario Outline: Verify search with page limit
    Given the GitHub Jobs api url is set
    When I call jobs search api with "limit" "<limit>"
    Then Verify I should receive a max results count of "<results_count>"

    Examples:
      | limit  | results_count |
      | 10     | 10            |
      | fatima | 50            |


  @priority-critical @production
  Scenario Outline: Verify search with page limit and page number
    Given the GitHub Jobs api url is set
    When I call jobs search api with "limit" "<limit>" and "page" "<page>"
    Then Verify I should receive a max results count of "<results_count>"

    Examples:
      | limit  | page | results_count |
      | 10     | 0    | 10            |
      | fatima | 1    | 50            |

  @priority-critical @production
  Scenario Outline: Verify search with negative page number
    Given the GitHub Jobs api url is set
    When I call jobs search api with "page" "<page>"
    Then response status code is "<response_status>"

    Examples:
      | page      | response_status |
      | -1        | 400             |


