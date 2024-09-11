/*
The dataset consists of two tables. 
*/

---COVIDDEATHS Table
SELECT *
FROM AKOPortfolioProject.dbo.CovidDeaths
ORDER BY 3,4


--- COVIDVACCINATIONS Table
SELECT *
FROM AKOPortfolioProject.dbo.CovidVaccinations
ORDER BY 3,4


--- A quick view of 5 of the columns in the COVIDDAETHS TABLE

SELECT location, date, total_cases,new_cases,total_deaths, population
FROM AKOPortfolioProject.dbo.CovidDeaths
ORDER BY 1,2

--- A quick look at the Total cases vs Total Deaths
---The probability of dying if contracted Covid-19 in my Country of residence (UK)
---This can be used to view TOTAL CASES vs TOTAL DEATHS in all COUNTRIES by commenting the 'where location'

SELECT location, date, total_cases, total_deaths, (CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0))*100 as DeathPercentage
FROM AKOPortfolioProject.dbo.CovidDeaths
--WHERE location LIKE '%Kingdom%'
ORDER BY 1,2


---A quick look at Total cases vs Population
-- What percent of the population caught Covid-19 in my country of residence (UK)
--- This can be used to view TOTAL CASES vs TOTAL POPULATON in all COUNTRIES by commenting the 'where location
SELECT location, date, total_cases, population, (CONVERT(float, total_cases) / NULLIF(CONVERT(float, population), 0))*100 as CasesPercentage
FROM AKOPortfolioProject.dbo.CovidDeaths
--WHERE location LIKE '%Kingdom%'
ORDER BY 1,2


-- Countries with highest infection rates compared to population
--- **** Table 3.1
SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((CONVERT(float, total_cases) / NULLIF(CONVERT(float, population), 0)))*100 as InfectedPopulationPercentage
FROM AKOPortfolioProject.dbo.CovidDeaths
--WHERE location LIKE '%Kingdom%'
GROUP BY location, population
ORDER BY InfectedPopulationPercentage DESC

--- Countries with highest infection rates compared to population with TIMESERIES
-- ****** Table 4.1
SELECT location, date, population, MAX(total_cases) AS HighestInfectionCount, MAX((CONVERT(float, total_cases) / NULLIF(CONVERT(float, population), 0)))*100 as InfectedPopulationPercentage
FROM AKOPortfolioProject.dbo.CovidDeaths
--WHERE location LIKE '%Kingdom%'
GROUP BY location, date, population
ORDER BY InfectedPopulationPercentage DESC


-- Countries with highest death counts per population
---Continents Total deaths counts can be extracted too
---****Table 5.1
SELECT location, MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM AKOPortfolioProject.dbo.CovidDeaths
--WHERE location LIKE '%Kingdom%'
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC



---LETS inravel the data in terms of continent breakdown
--- In terms of continent and income level around the world
---THIS IS ONE OF THE CODES TO USE
SELECT location, MAX(CAST(total_deaths AS int)) AS ContinentTotalDeathCount
FROM AKOPortfolioProject.dbo.CovidDeaths
--WHERE location LIKE '%Kingdom%'
WHERE continent IS NULL
GROUP BY location 
ORDER BY ContinentTotalDeathCount DESC


---TOTAL DEATHS vs CONTINENT
---Table 2.1
SELECT location, MAX(CAST(total_deaths AS int)) AS ContinentTotalDeathCount
FROM AKOPortfolioProject.dbo.CovidDeaths
--WHERE location LIKE '%Kingdom%'
WHERE continent IS NULL
AND location NOT IN ('World', 'European Union', 'High income', 'Upper middle income', 'Lower middle income', 'Low income')
GROUP BY location 
ORDER BY ContinentTotalDeathCount DESC


---TOTAL DEATHS vs INCOME LEVEL AROUND THE WORLD
---Table 6.1
SELECT location, MAX(CAST(total_deaths AS int)) AS ContinentTotalDeathCount
FROM AKOPortfolioProject.dbo.CovidDeaths
--WHERE location LIKE '%Kingdom%'
WHERE continent IS NULL
AND location NOT IN ('World', 'Europe', 'Asia', 'North America', 'South America', 'Africa', 'Oceania', 'European Union')
GROUP BY location 
ORDER BY ContinentTotalDeathCount DESC


---Another code to use---DISCARD THIS!!!
SELECT continent, MAX(CAST(total_deaths AS int)) AS ContinentTotalDeathCount
FROM AKOPortfolioProject.dbo.CovidDeaths
--WHERE location LIKE '%Kingdom%'
WHERE continent IS NOT NULL
GROUP BY continent 
ORDER BY ContinentTotalDeathCount DESC



--Checking for Cases where continent is null
--THIS GIVES THE TOTAL Death counts for the world???
SELECT continent, MAX(CAST(total_deaths AS int)) AS ContinentTotalDeathCount
FROM AKOPortfolioProject.dbo.CovidDeaths
--WHERE location LIKE '%Kingdom%'
WHERE continent IS NULL
GROUP BY continent 



-- GLOBAL BREAKDOWN OF NUMBERS
-- GLOBAL BREAKDOWN OF NUMBERS
SELECT date, SUM(new_cases) AS total_Cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/ NULLIF (SUM(new_cases),0)*100 AS DeathPercentage
FROM AKOPortfolioProject.dbo.CovidDeaths
--WHERE location LIKE '%Kingdom%'
WHERE continent IS NOT NULL 
GROUP BY date
ORDER BY 1

--- Key Indicators/Paramaters
---Table 1.1 
SELECT SUM(new_cases) AS total_Cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/ NULLIF (SUM(new_cases),0)*100 AS DeathPercentage
FROM AKOPortfolioProject.dbo.CovidDeaths
--WHERE location LIKE '%Kingdom%'
WHERE continent IS NOT NULL 
ORDER BY 1

--- People Vaccinated in each continent
--- Table 7.1
SELECT location, MAX(CAST(people_vaccinated AS float)) AS ContinentTotalPeopleVaccinated
FROM AKOPortfolioProject.dbo.CovidVaccinations
--WHERE location LIKE '%Kingdom%'
WHERE continent IS NULL
AND location NOT IN ('World', 'European Union', 'High income', 'Upper middle income', 'Lower middle income', 'Low income')
GROUP BY location 
ORDER BY ContinentTotalPeopleVaccinated DESC


--- People Vaccinated in each continent based on income level
--- Table 8.1
SELECT location, MAX(CAST(people_vaccinated AS float)) AS WorldTotalPeopleVaccinated
FROM AKOPortfolioProject.dbo.CovidVaccinations
--WHERE location LIKE '%Kingdom%'
WHERE continent IS NULL
AND location NOT IN ('World', 'European Union', 'Asia', 'Africa', 'Europe', 'North America', 'South America', 'Oceania')
GROUP BY location 
ORDER BY WorldTotalPeopleVaccinated DESC

---Performs JOIN of the two tables 
--- JOINNIG THE TWO TABLES TO FIND population vs Vaccinations
---COVIDDEATHS joined with COVIDVACCINATIONS on date and location
SELECT*
FROM AKOPortfolioProject..CovidDeaths AS de
JOIN AKOPortfolioProject..CovidVaccinations AS vac
      ON  de.location = vac.location
	  AND de.date = vac.date


---Total People vaccinated for each country
SELECT de.continent, de.location, de.date, de.population, vac.people_vaccinated, 
      SUM(CONVERT(float,vac.people_vaccinated)) OVER (PARTITION BY de.location ORDER BY de.location, de.date) AS TotalPeopleVaccinated
FROM AKOPortfolioProject..CovidDeaths AS de
JOIN AKOPortfolioProject..CovidVaccinations AS vac
      ON  de.location = vac.location
	  AND de.date = vac.date
WHERE de.continent IS NOT NULL
GROUP BY de.continent, de.location, de.date, de.population, vac.people_vaccinated
ORDER BY 2,3

---Create A Common Table Expression here
---Create A Common Table Expression here
WITH VaccPop (Continent, Location, Date, Population, people_vaccinated, TotalPeopleVaccinated)
AS 
(
SELECT de.continent, de.location, de.date, de.population, vac.people_vaccinated, 
      SUM(CONVERT(float,vac.people_vaccinated)) OVER (PARTITION BY de.location ORDER BY de.location, de.date) AS TotalPeopleVaccinated
FROM AKOPortfolioProject..CovidDeaths AS de
JOIN AKOPortfolioProject..CovidVaccinations AS vac
      ON  de.location = vac.location
	  AND de.date = vac.date
WHERE de.continent IS NOT NULL
GROUP BY de.continent, de.location, de.date, de.population, vac.people_vaccinated
--ORDER BY 2,3
)
SELECT *, (TotalPeopleVaccinated/Population)*100 AS TotalPeople_VaccinatedPercent
FROM VaccPop




-- New vaccinations on Rolling bases
SELECT de.continent, de.location, de.date, de.population, vac.new_vaccinations, 
      SUM(CONVERT(float,vac.new_vaccinations)) OVER (PARTITION BY de.location ORDER BY de.location, de.date) AS RollingVaccinationPeople
FROM AKOPortfolioProject..CovidDeaths AS de
JOIN AKOPortfolioProject..CovidVaccinations AS vac
      ON  de.location = vac.location
	  AND de.date = vac.date
WHERE de.continent IS NOT NULL
GROUP BY de.continent, de.location, de.date, de.population, vac.new_vaccinations
ORDER BY 2,3

--CREATING A COMMON TABLE EXPRESSION








