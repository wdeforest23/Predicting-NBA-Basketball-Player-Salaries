# Predicting NBA Basketball Player Salaries - Data Engineering Platforms Final Project

### Team Members

Yilin Gong, Songyao Hou, Yulin Li and William DeForest

### Project Description

The primary objective of this project is to predict NBA players' salaries using physical attributes and game statistics. This project also affords us the opportunity to apply the knowledge and skills we built during this course such as understanding data collection (APIs and web scraping), storing data in relational or non-relational databases (SQL and Neo4j), SQL queries and data analysis and visualization.

### Business Use Case

- Assist NBA front offices in player valuation to optimize payroll management and team composition.
- Assist coaches in determining the most suitable position or role for a player.
- Drive fan engagement by making them more informed
- Help NBA players better understand their worth and negotiate a higher salary

### Data Sources

- NBA API (GitHub): For player characteristics and in-game data.
- Hoopshype.com (NBA Salaries 1990-2023): For salary information.
- Runrepeat.com (Team Financials): For NBA team revenue, ticket sales, and operating income

### Methodology

- Data collection via API and web scraping using Python Requests and Beautifulsoup libraries.
- Data cleaning in Python using Pandas library.
- Data integration using SQL and Google Cloud Platform
- Analysis with Python Pandas library.
- Visualization with Tableau

### Findings

- The correlation between a player's salary and observable performance metrics, such as points scored, along with physical characteristics like height and weight, is weak. This indicates that historical NBA player salaries have been largely determined by other actors not considered in this study. For example, unobservable/unquantifiable qualities such as a player’s personality or performance under pressure may be important factors in determining a player’s value. Overall, these findings are surprising because we would expect that higher player performance would have a stronger influence on that player’s salary
This is because higher player performance means higher team performance which should theoretically be the ultimate goal of an NBA front office

### References

Curcic, Dimitrije. “NBA Revenue Statistics (2001-2022).” RunRepeat, 1 Nov. 2023, runrepeat.com/nba-revenue-statistics. 

Keane, Sean. “The Worst NBA Contracts of All Time.” Yardbarker, 5 Dec. 2023, www.yardbarker.com/nba/articles/the_worst_nba_contracts_of_all_time_120123/s1__29861057. 

Patel, Swar. “Swar/NBA_API: An API Client Package to Access the Apis for Nba.Com.” GitHub, 2023, github.com/swar/nba_api/tree/master.

“These Are the Salaries of All NBA Players.” HoopsHype, HoopsHype, 2023, hoopshype.com/salaries/players/. 

“Total NBA League Revenue 2023.” Statista, Statista Research Department, 28 Nov. 2023, www.statista.com/statistics/193467/total-league-revenue-of-the-nba-since-2005/#:~:text=Total%20revenue%20of%20the%20National%20Basketball%20Association%202001%2D2023&text=During%20the%202022%2F23%20season,dollars%20from%20the%20previous%20year. 




