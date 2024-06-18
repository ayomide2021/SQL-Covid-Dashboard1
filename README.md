# Introduction
For my inaugural project utilizing Microsoft SQL Server Management Studio to engage with a relational database, I have intentionally selected a subject of great significance. The Covid-19 pandemic has undeniably left an indelible mark on the world, ushering in an era of unprecedented changes. From widespread lockdowns to the rise of remote and hybrid working, the pandemic has reshaped the way we live and work. This project serves as an opportunity for me to delve deeper into the data, seeking to gain valuable insights into the global impact of Covid-19, particularly with regard to the reported cases and fatalities.Limk to the project https://public.tableau.com/app/profile/kazeem.odunlami/viz/DataandInsightsonCovid-19/DataandinsightsonCOVID-19 

# Skills
•	Data cleaning and transformation with SQL
•	Data retrieval, querying and sub-querying with SQL
•	Data aggregation and summarization with SQL
•	Dashboard design, visualization, and storytelling with data using Tableau
•	Joins and Relational Database Management

# Problem Statement
1.	What per cent of the population is infected?
2.	What is the percentage of deaths among the total infected cases worldwide?
3.	How does income level impact the total number of Covid-19 deaths worldwide?
4.	Which continent has the highest number of Covid-19 deaths?
5.	In which continent have people received the most vaccinations?
6.	At what income level have people received the highest number of vaccinations?
   
# Data sourcing
The dataset used in this project was obtained from an online source (Coronavirus (COVID-19) Deaths - Our World in Data). After downloading the dataset in CSV format, I proceeded to import it into Microsoft SQL Server Management Studio. The initial dataset consisted of 327,861 rows and 67 columns in its unprocessed state. This initial phase of data acquisition and preparation serves as the crucial groundwork upon which the subsequent phases of data querying, analysis, and visualization within the project are built.

# Data Preparation, Transformation and Cleaning

Data preparation, cleaning, and transformation were carried out using SQL. To guarantee the dataset's integrity, a comprehensive examination of the columns was performed to identify and rectify any empty cells, errors, or null values. There were significant number of empty columns or null values in the dataset. All these null values were addressed through data manipulation, including data type conversions. These meticulous data cleaning and transformation steps were instrumental in preparing the dataset for subsequent querying and sub-querying, thereby enhancing data quality and reliability for further analysis.

# Data Modelling
Two subsets of the dataset were created to minimise the search and querying process. Subsequently, these two subsets were merged using inner joins. This approach leveraged various SQL concepts to structure the data for subsequent analysis and visualization in Tableau.
•	SELECT clause
•	FROM
•	LIMIT
•	WHERE
•	GROUP BY
•	ORDER BY
•	COUNT (DISTINCT())
•	AVG(), SUM
•	Subqueries,
Once the data had been structured and prepared, it was saved and subsequently imported into Tableau for data visualization and storytelling.

# Analysis, Findings and Visualisation
Upon importing the data into Tableau Public, a variety of charts and graphs were harnessed to extract valuable insights from the dataset. These visualizations, found on different sheets, were then utilized to build the Covid dashboard.

 

Based on the problem statements, here are the answers to the questions
1. With a global population of 8 billion, the percentage of individuals infected by COVID-19 is less than 1% of the total world population.
2. The Covid-19 death rate is estimated to be approximately 0.92%.
3. The data suggests that individuals with higher income levels experienced higher death rates from Covid-19 compared to those with lower incomes. This observation may be attributed to the underreporting of deaths among lower-income individuals, who are more likely to have less access to healthcare and official documentation, as opposed to the more affluent population.
4. Europe has recorded the highest number of COVID-19 deaths, with approximately eight times the number of deaths as Africa. In contrast, Oceania has the lowest death count, with around 29,000 fatalities.
5. Asia has administered vaccinations to about seven times the number of people compared to Europe. The number of vaccinations administered is generally proportional to the population of each continent.
6. Lower-middle-income individuals have received the highest number of vaccinations, followed by upper-middle-income individuals, while low-income individuals have the lowest number of vaccinations. This distribution is likely due to the fact that lower and upper-middle-income individuals often work in environments where Covid-19 vaccinations are more strongly encouraged or mandated.

![image](https://github.com/ayomide2021/SQL-Covid-Dashboard1/assets/83126882/6501b083-52ad-4c83-ab4a-6d8d5cb383e1)


# Conclusions

•	Based on a global population of 8 billion, the percentage of individuals infected with COVID-19 is less than 1% of the total world population. The Covid-19 death rate is approximately 0.92%.

•	High-income earners experienced a higher death rate from Covid-19 compared to individuals with other income levels.

•	Europe has recorded the highest number of Covid-19 deaths, with approximately eight times the number of deaths compared to Africa. The number of people vaccinated is proportional to the population of each continent.

•	Lower-middle-income earners have received the highest number of COVID-19 vaccinations, followed by upper-middle-income earners, while low-income individuals have the lowest vaccination rates.

