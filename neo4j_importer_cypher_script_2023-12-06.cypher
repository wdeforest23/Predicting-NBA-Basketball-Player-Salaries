:param {
  // Define the file path root and the individual file names required for loading.
  // https://neo4j.com/docs/operations-manual/current/configuration/file-locations/
  file_path_root: 'file:///', // Change this to the folder your script can access the files at.
  file_0: 'prepared_data_player.csv',
  file_1: 'prepared_data_stats.csv',
  file_2: 'prepared_data_demographic.csv',
  file_3: 'prepared_data_salary.csv',
  file_4: 'prepared_data_financial.csv'
};

// CONSTRAINT creation
// -------------------
//
// Create node uniqueness constraints, ensuring no duplicates for the given node label and ID property exist in the database. This also ensures no duplicates are introduced in future.
//
// NOTE: If your database version is below (not including) 4.4.0, please use the constraint creation syntax below:
// CREATE CONSTRAINT `imp_uniq_player_team_PLAYER_ID` IF NOT EXISTS
// ON (n: `player_team`)
// ASSERT n.`PLAYER_ID` IS UNIQUE;
// CREATE CONSTRAINT `imp_uniq_player_data_stats_PLAYER_ID` IF NOT EXISTS
// ON (n: `player_data_stats`)
// ASSERT n.`PLAYER_ID` IS UNIQUE;
// CREATE CONSTRAINT `imp_uniq_player_PLAYER_ID` IF NOT EXISTS
// ON (n: `player`)
// ASSERT n.`PLAYER_ID` IS UNIQUE;
// CREATE CONSTRAINT `imp_uniq_salary_PLAYER_ID` IF NOT EXISTS
// ON (n: `salary`)
// ASSERT n.`PLAYER_ID` IS UNIQUE;
// CREATE CONSTRAINT `imp_uniq_team_finantial_TEAM_ID` IF NOT EXISTS
// ON (n: `team_finantial`)
// ASSERT n.`TEAM_ID` IS UNIQUE;
//
// NOTE: The following constraint creation syntax is generated based on the current connected database version 5.14-aura.
CREATE CONSTRAINT `imp_uniq_player_team_PLAYER_ID` IF NOT EXISTS
FOR (n: `player_team`)
REQUIRE (n.`PLAYER_ID`) IS UNIQUE;
CREATE CONSTRAINT `imp_uniq_player_data_stats_PLAYER_ID` IF NOT EXISTS
FOR (n: `player_data_stats`)
REQUIRE (n.`PLAYER_ID`) IS UNIQUE;
CREATE CONSTRAINT `imp_uniq_player_PLAYER_ID` IF NOT EXISTS
FOR (n: `player`)
REQUIRE (n.`PLAYER_ID`) IS UNIQUE;
CREATE CONSTRAINT `imp_uniq_salary_PLAYER_ID` IF NOT EXISTS
FOR (n: `salary`)
REQUIRE (n.`PLAYER_ID`) IS UNIQUE;
CREATE CONSTRAINT `imp_uniq_team_finantial_TEAM_ID` IF NOT EXISTS
FOR (n: `team_finantial`)
REQUIRE (n.`TEAM_ID`) IS UNIQUE;

:param {
  idsToSkip: []
};

// NODE load
// ---------
//
// Load nodes in batches, one node label at a time. Nodes will be created using a MERGE statement to ensure a node with the same label and ID property remains unique. Pre-existing nodes found by a MERGE statement will have their other properties set to the latest values encountered in a load file.
//
// NOTE: Any nodes with IDs in the 'idsToSkip' list parameter will not be loaded.
LOAD CSV WITH HEADERS FROM ($file_path_root + $file_0) AS row
WITH row
WHERE NOT row.`PLAYER_ID` IN $idsToSkip AND NOT toInteger(trim(row.`PLAYER_ID`)) IS NULL
CALL {
  WITH row
  MERGE (n: `player_team` { `PLAYER_ID`: toInteger(trim(row.`PLAYER_ID`)) })
  SET n.`PLAYER_ID` = toInteger(trim(row.`PLAYER_ID`))
  SET n.`FULL_NAME` = row.`FULL_NAME`
  SET n.`FIRST_NAME` = row.`FIRST_NAME`
  SET n.`LAST_NAME` = row.`LAST_NAME`
  SET n.`IS_ACTIVE` = toLower(trim(row.`IS_ACTIVE`)) IN ['1','true','yes']
  SET n.`TEAM_ID` = toInteger(trim(row.`TEAM_ID`))
} IN TRANSACTIONS OF 10000 ROWS;

LOAD CSV WITH HEADERS FROM ($file_path_root + $file_1) AS row
WITH row
WHERE NOT row.`PLAYER_ID` IN $idsToSkip AND NOT toInteger(trim(row.`PLAYER_ID`)) IS NULL
CALL {
  WITH row
  MERGE (n: `player_data_stats` { `PLAYER_ID`: toInteger(trim(row.`PLAYER_ID`)) })
  SET n.`PLAYER_ID` = toInteger(trim(row.`PLAYER_ID`))
  SET n.`STATS_ID` = toInteger(trim(row.`STATS_ID`))
  SET n.`LEAGUE_ID` = toLower(trim(row.`LEAGUE_ID`)) IN ['1','true','yes']
  SET n.`TEAM_ID` = toInteger(trim(row.`TEAM_ID`))
  SET n.`TEAM_ABBREVIATION` = row.`TEAM_ABBREVIATION`
  SET n.`PLAYER_AGE` = toInteger(trim(row.`PLAYER_AGE`))
  SET n.`GP` = toInteger(trim(row.`GP`))
  SET n.`GS` = toFloat(trim(row.`GS`))
  SET n.`MIN` = toFloat(trim(row.`MIN`))
  SET n.`FGM` = toInteger(trim(row.`FGM`))
  SET n.`FGA` = toInteger(trim(row.`FGA`))
  SET n.`FG_PCT` = toFloat(trim(row.`FG_PCT`))
  SET n.`FG3M` = toFloat(trim(row.`FG3M`))
  SET n.`FG3A` = toFloat(trim(row.`FG3A`))
  SET n.`FG3_PCT` = toFloat(trim(row.`FG3_PCT`))
  SET n.`FTM` = toInteger(trim(row.`FTM`))
  SET n.`FTA` = toInteger(trim(row.`FTA`))
  SET n.`FT_PCT` = toFloat(trim(row.`FT_PCT`))
  SET n.`OREB` = toFloat(trim(row.`OREB`))
  SET n.`DREB` = toFloat(trim(row.`DREB`))
  SET n.`REB` = toFloat(trim(row.`REB`))
  SET n.`AST` = toInteger(trim(row.`AST`))
  SET n.`STL` = toFloat(trim(row.`STL`))
  SET n.`BLK` = toFloat(trim(row.`BLK`))
  SET n.`TOV` = toFloat(trim(row.`TOV`))
  SET n.`PF` = toInteger(trim(row.`PF`))
  SET n.`PTS` = toInteger(trim(row.`PTS`))
  SET n.`SEASON` = toInteger(trim(row.`SEASON`))
} IN TRANSACTIONS OF 10000 ROWS;

LOAD CSV WITH HEADERS FROM ($file_path_root + $file_2) AS row
WITH row
WHERE NOT row.`PLAYER_ID` IN $idsToSkip AND NOT toInteger(trim(row.`PLAYER_ID`)) IS NULL
CALL {
  WITH row
  MERGE (n: `player` { `PLAYER_ID`: toInteger(trim(row.`PLAYER_ID`)) })
  SET n.`PLAYER_ID` = toInteger(trim(row.`PLAYER_ID`))
  // Your script contains the datetime datatype. Our app attempts to convert dates to ISO 8601 date format before passing them to the Cypher function.
  // This conversion cannot be done in a Cypher script load. Please ensure that your CSV file columns are in ISO 8601 date format to ensure equivalent loads.
  SET n.`BIRTHDATE` = datetime(row.`BIRTHDATE`)
  SET n.`SCHOOL` = row.`SCHOOL`
  SET n.`COUNTRY` = row.`COUNTRY`
  SET n.`LAST_AFFILIATION` = row.`LAST_AFFILIATION`
  SET n.`HEIGHT` = row.`HEIGHT`
  SET n.`WEIGHT` = toInteger(trim(row.`WEIGHT`))
  SET n.`SEASON_EXP` = toInteger(trim(row.`SEASON_EXP`))
  SET n.`POSITION` = row.`POSITION`
  SET n.`ROSTERSTATUS` = row.`ROSTERSTATUS`
  SET n.`GAMES_PLAYED_CURRENT_SEASON_FLAG` = row.`GAMES_PLAYED_CURRENT_SEASON_FLAG`
  SET n.`TEAM_ID` = toInteger(trim(row.`TEAM_ID`))
  SET n.`TEAM_NAME` = row.`TEAM_NAME`
  SET n.`TEAM_ABBREVIATION` = row.`TEAM_ABBREVIATION`
  SET n.`TEAM_CODE` = row.`TEAM_CODE`
  SET n.`TEAM_CITY` = row.`TEAM_CITY`
  SET n.`PLAYERCODE` = row.`PLAYERCODE`
  SET n.`FROM_YEAR` = toInteger(trim(row.`FROM_YEAR`))
  SET n.`TO_YEAR` = toInteger(trim(row.`TO_YEAR`))
  SET n.`DLEAGUE_FLAG` = row.`DLEAGUE_FLAG`
  SET n.`NBA_FLAG` = row.`NBA_FLAG`
  SET n.`GAMES_PLAYED_FLAG` = row.`GAMES_PLAYED_FLAG`
  SET n.`DRAFT_YEAR` = toInteger(trim(row.`DRAFT_YEAR`))
  SET n.`DRAFT_ROUND` = toInteger(trim(row.`DRAFT_ROUND`))
  SET n.`DRAFT_NUMBER` = toInteger(trim(row.`DRAFT_NUMBER`))
  SET n.`GREATEST_75_FLAG` = row.`GREATEST_75_FLAG`
  SET n.`DEMOGRAPHIC_ID` = toInteger(trim(row.`DEMOGRAPHIC_ID`))
} IN TRANSACTIONS OF 10000 ROWS;

LOAD CSV WITH HEADERS FROM ($file_path_root + $file_3) AS row
WITH row
WHERE NOT row.`PLAYER_ID` IN $idsToSkip AND NOT toInteger(trim(row.`PLAYER_ID`)) IS NULL
CALL {
  WITH row
  MERGE (n: `salary` { `PLAYER_ID`: toInteger(trim(row.`PLAYER_ID`)) })
  SET n.`PLAYER_ID` = toInteger(trim(row.`PLAYER_ID`))
  SET n.`SALARY_ID` = toInteger(trim(row.`SALARY_ID`))
  SET n.`Name` = row.`Name`
  SET n.`Season` = toInteger(trim(row.`Season`))
  SET n.`Current_Season_Salary` = toInteger(trim(row.`Current_Season_Salary`))
  SET n.`Inflation_Adj_Salary` = toInteger(trim(row.`Inflation_Adj_Salary`))
} IN TRANSACTIONS OF 10000 ROWS;

LOAD CSV WITH HEADERS FROM ($file_path_root + $file_4) AS row
WITH row
WHERE NOT row.`TEAM_ID` IN $idsToSkip AND NOT toInteger(trim(row.`TEAM_ID`)) IS NULL
CALL {
  WITH row
  MERGE (n: `team_finantial` { `TEAM_ID`: toInteger(trim(row.`TEAM_ID`)) })
  SET n.`TEAM_ID` = toInteger(trim(row.`TEAM_ID`))
  SET n.`SEASON` = toInteger(trim(row.`SEASON`))
  SET n.`TEAM_REVENUE` = toInteger(trim(row.`TEAM_REVENUE`))
  SET n.`TEAM_TICKET_REVENUE` = toFloat(trim(row.`TEAM_TICKET_REVENUE`))
  SET n.`TEAM_OPERATING_INCOME` = toInteger(trim(row.`TEAM_OPERATING_INCOME`))
  SET n.`FINANCIAL_ID` = toInteger(trim(row.`FINANCIAL_ID`))
} IN TRANSACTIONS OF 10000 ROWS;


// RELATIONSHIP load
// -----------------
//
// Load relationships in batches, one relationship type at a time. Relationships are created using a MERGE statement, meaning only one relationship of a given type will ever be created between a pair of nodes.
LOAD CSV WITH HEADERS FROM ($file_path_root + $file_1) AS row
WITH row 
CALL {
  WITH row
  MATCH (source: `player_team` { `PLAYER_ID`: toInteger(trim(row.`PLAYER_ID`)) })
  MATCH (target: `player_data_stats` { `PLAYER_ID`: toInteger(trim(row.`PLAYER_ID`)) })
  MERGE (source)-[r: `has_stats`]->(target)
  SET r.`TEAM_ABBREVIATION` = row.`TEAM_ABBREVIATION`
  SET r.`PLAYER_AGE` = toInteger(trim(row.`PLAYER_AGE`))
  SET r.`GS` = toFloat(trim(row.`GS`))
  SET r.`MIN` = toFloat(trim(row.`MIN`))
  SET r.`FGM` = toInteger(trim(row.`FGM`))
  SET r.`FGA` = toInteger(trim(row.`FGA`))
  SET r.`FG_PCT` = toFloat(trim(row.`FG_PCT`))
  SET r.`DREB` = toFloat(trim(row.`DREB`))
  SET r.`AST` = toInteger(trim(row.`AST`))
  SET r.`STL` = toFloat(trim(row.`STL`))
  SET r.`BLK` = toFloat(trim(row.`BLK`))
  SET r.`PTS` = toInteger(trim(row.`PTS`))
  SET r.`SEASON` = toInteger(trim(row.`SEASON`))
} IN TRANSACTIONS OF 10000 ROWS;

LOAD CSV WITH HEADERS FROM ($file_path_root + $file_2) AS row
WITH row 
CALL {
  WITH row
  MATCH (source: `player_team` { `PLAYER_ID`: toInteger(trim(row.`PLAYER_ID`)) })
  MATCH (target: `player` { `PLAYER_ID`: toInteger(trim(row.`PLAYER_ID`)) })
  MERGE (source)-[r: `has_information`]->(target)
  SET r.`SCHOOL` = row.`SCHOOL`
  SET r.`COUNTRY` = row.`COUNTRY`
  SET r.`HEIGHT` = row.`HEIGHT`
  SET r.`WEIGHT` = toInteger(trim(row.`WEIGHT`))
} IN TRANSACTIONS OF 10000 ROWS;

LOAD CSV WITH HEADERS FROM ($file_path_root + $file_3) AS row
WITH row 
CALL {
  WITH row
  MATCH (source: `player` { `PLAYER_ID`: toInteger(trim(row.`PLAYER_ID`)) })
  MATCH (target: `salary` { `PLAYER_ID`: toInteger(trim(row.`PLAYER_ID`)) })
  MERGE (source)-[r: `has_salary`]->(target)
  SET r.`Current_Season_Salary` = toInteger(trim(row.`Current_Season_Salary`))
  SET r.`Inflation_Adj_Salary` = toInteger(trim(row.`Inflation_Adj_Salary`))
} IN TRANSACTIONS OF 10000 ROWS;

LOAD CSV WITH HEADERS FROM ($file_path_root + $file_4) AS row
WITH row 
CALL {
  WITH row
  MATCH (source: `player_team` { `PLAYER_ID`: toInteger(trim(row.`TEAM_ID`)) })
  MATCH (target: `team_finantial` { `TEAM_ID`: toInteger(trim(row.`TEAM_ID`)) })
  MERGE (source)-[r: `has_revenue`]->(target)
  SET r.`TEAM_REVENUE` = toInteger(trim(row.`TEAM_REVENUE`))
  SET r.`TEAM_TICKET_REVENUE` = toFloat(trim(row.`TEAM_TICKET_REVENUE`))
} IN TRANSACTIONS OF 10000 ROWS;
