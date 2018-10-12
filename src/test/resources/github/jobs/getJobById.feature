@searchJobService
Feature: Get Job by ID

@priority-critical @smoke
Scenario Outline: Verify get by Job ID
  Given the GitHub get job by id api url is set
  When call get job by id "<job_id>"
  Then response status code is "<response_status>"
  And assert the job body for job "<job_id>"

  @stage
  Examples:
  | job_id                                | response_status |
  | a30b539e-c695-11e8-8c27-628b85f138da  | 200             |
  | e628c0dc-260c-11e8-8f45-0ad0cf84f7bf  | 200             |
  | 397f74a0-baa6-11e8-8187-7c96a363dbc4  | 200             |

  @production
  Examples:
  | job_id                                | response_status |
  | b2417f72-99a0-11e8-9e2b-c53fb90d38df  | 200             |
  | 168a07c0-cc8b-11e8-9940-23de69f82b63  | 200             |

@priority-critical
Scenario Outline:: Verify search with non existing Job ID
  Given the GitHub get job by id api url is set
  When call get job by id "<job_id>"
  Then response status code is "<response_status>"
  And assert the empty response

  @stage
  Examples:
  | job_id                          | response_status |
  | a30b539e-c695-11e8-628b85f138da | 404             |
  | e628c0dc-260c-11e8-8f45-0ad0cf  | 404             |
  | 397f74a0-baa6-8187-7c96a363dbc4 | 404             |

@priority-critical @stage
Scenario Outline: Verify get job by id with markdown parameter
  Given the GitHub get job by id api url is set
  When call get job by id "<job_id>" and markdown "<markdown>"
  Then assert the job body for job "<job_id>" and markdown "<markdown>"

  Examples:
  | job_id                               | markdown |
  | b2417f72-99a0-11e8-9e2b-c53fb90d38df |  true    |
  | b2417f72-99a0-11e8-9e2b-c53fb90d38df |  false   |



