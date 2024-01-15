CREATE SCHEMA IF NOT EXISTS `depa_final_proj_nba` DEFAULT CHARACTER SET latin1 ;
USE `depa_final_proj_nba` ;

-- -----------------------------------------------------
-- Table `depa_final_proj_nba`.`team`
-- -----------------------------------------------------
CREATE TABLE team (
    TEAM_ID BIGINT PRIMARY KEY,
    TEAM_NAME VARCHAR(50) NOT NULL,
    ABR VARCHAR(6),
    NICKNAME VARCHAR(50),
    CITY VARCHAR(50),
    STATE VARCHAR(50),
    YEAR_FOUNDED INT
);

-- -----------------------------------------------------
-- Table `depa_final_proj_nba`.`financials`
-- -----------------------------------------------------
CREATE TABLE financials (
    SEASON INT,
    TEAM_REVENUE INT,
    TICKET_REVENUE DECIMAL(3, 1),
    OPERATING_INCOME INT,
    FINANCIAL_ID INT PRIMARY KEY,
    TEAM_ID BIGINT,
    FOREIGN KEY (TEAM_ID) REFERENCES team(TEAM_ID),
    CONSTRAINT uc_SEASON UNIQUE (TEAM_ID, SEASON)
);

-- -----------------------------------------------------
-- Table `depa_final_proj_nba`.`player`
-- -----------------------------------------------------
CREATE TABLE player (
    PLAYER_ID INT PRIMARY KEY,
    FULL_NAME VARCHAR(50),
    FIRST_NAME VARCHAR(50),
    LAST_NAME VARCHAR(50),
    IS_ACTIVE VARCHAR(12),
    TEAM_ID BIGINT NULL,
    FOREIGN KEY (TEAM_ID) REFERENCES team(TEAM_ID)
);

-- -----------------------------------------------------
-- Table `depa_final_proj_nba`.`stats`
-- -----------------------------------------------------
CREATE TABLE stats (
    STATS_ID INT PRIMARY KEY,
    PLAYER_ID INT,
    LEAGUE_ID TINYINT,
    TEAM_ID BIGINT,
    TEAM_ABR VARCHAR(6),
    PLAYER_AGE INT,
    GP INT,
    GS INT,
    MIN INT,
    FGM INT,
    FGA INT,
    FG_PCT DECIMAL(4,3),
    FG3M INT,
    FG3A INT,
    FG3_PCT DECIMAL(4,3),
    FTM INT,
    FTA INT,
    FT_PCT DECIMAL(4,3),
    OREB INT,
    DREB INT,
    REB INT,
    AST INT,
    STL INT,
    BLK INT,
    TOV INT,
    PF INT,
    PTS INT,
    SEASON INT,
    FOREIGN KEY (PLAYER_ID) REFERENCES player(PLAYER_ID),
    CONSTRAINT uc_SEASON UNIQUE (PLAYER_ID, SEASON)
);

-- -----------------------------------------------------
-- Table `depa_final_proj_nba`.`demographics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS demographics (
    PLAYER_ID INT,
    BIRTHDATE DATETIME,
    SCHOOL VARCHAR(50),
    COUNTRY VARCHAR(50),
    LAST_AFFILIATION VARCHAR(50),
    HEIGHT VARCHAR(10),
    WEIGHT INT,
    SEASON_EXP TINYINT,
    POSITION VARCHAR(50),
    ROSTERSTATUS VARCHAR(50),
    GAMES_PLAYED_CURRENT_SEASON_FLAG VARCHAR(6),
    TEAM_ID BIGINT,
    TEAM_NAME VARCHAR(50),
    TEAM_ABR VARCHAR(6),
    TEAM_CODE VARCHAR(50),
    TEAM_CITY VARCHAR(50),
    PLAYER_CODE VARCHAR(50),
    FROM_YEAR INT,
    TO_YEAR INT,
    DLEAGUE_FLAG VARCHAR(6),
    NBA_FLAG VARCHAR(6),
    GAMES_PLAYED_FLAG VARCHAR(6),
    DRAFT_YEAR INT NULL,
    DRAFT_ROUND INT NULL,
    DRAFT_NUMBER INT NULL,
    GREATEST_75_FLAG VARCHAR(5),
    DEMOGRAPHIC_ID INT PRIMARY KEY,
    FOREIGN KEY (PLAYER_ID) REFERENCES player(PLAYER_ID)
);

-- -----------------------------------------------------
-- Table `depa_final_proj_nba`.`salary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS salary (
    SALARY_ID INT PRIMARY KEY,
    NAME VARCHAR(50),
    SEASON INT,
    CURRENT_SEASON_SALARY BIGINT,
    INFLATION_ADJ_SALARY BIGINT,
    PLAYER_ID INT,
    FOREIGN KEY (PLAYER_ID) REFERENCES player(PLAYER_ID),
    CONSTRAINT uc_SALARY UNIQUE (PLAYER_ID, SEASON)
);