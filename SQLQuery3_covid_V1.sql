SELECT *
FROM AKOPortfolioProject.dbo.CovidDeaths
ORDER BY 3,4

--SELECT *
--FROM AKOPortfolioProject.dbo.CovidVaccinations
--ORDER BY 3,4


-- AKO will need this later

SELECT location, date, total_cases,new_cases,total_deaths, population
FROM AKOPortfolioProject.dbo.CovidDeaths
ORDER BY 1,2

-- A quick look at the total cases vs Total Deaths
-- The probability of dying if contracted Covid-19 in your Country

SELECT location, date, total_cases, total_deaths, (CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0))*100 as DeathPercentage
FROM AKOPortfolioProject.dbo.CovidDeaths
WHERE location LIKE '%Kingdom%'
ORDER BY 1,2


--A quick look at Total cases vs Population
-- What percent of the population caught Covid-19
SELECT location, date, total_cases, population, (CONVERT(float, total_cases) / NULLIF(CONVERT(float, population), 0))*100 as CasesPercentage
FROM AKOPortfolioProject.dbo.CovidDeaths
WHERE location LIKE '%Kingdom%'
ORDER BY 1,2


-- Countries with highest infection rates compared to population
SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((CONVERT(float, total_cases) / NULLIF(CONVERT(float, population), 0)))*100 as InfectedPopulationPercentage
FROM AKOPortfolioProject.dbo.CovidDeaths
--WHERE location LIKE '%Kingdom%'
GROUP BY location, population
ORDER BY InfectedPopulationPercentage DESC



-- Countries with highest death counts per population
-- Continents Total detah counts can be extracted too
SELECT location, MAX(CAST(total_deaths AS int)) AS TotalDeathCount
FROM AKOPortfolioProject.dbo.CovidDeaths
--WHERE location LIKE '%Kingdom%'
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC


-- LETS inravel the data in terms of continent breakdown
---THIS IS ONE OF THE CODES TO USE
---THIS IS ONE OF THE CODES TO USE
---THIS IS ONE OF THE CODES TO USE
---THIS IS ONE OF THE CODES TO USE
SELECT location, MAX(CAST(total_deaths AS int)) AS ContinentTotalDeathCount
FROM AKOPortfolioProject.dbo.CovidDeaths
--WHERE location LIKE '%Kingdom%'
WHERE continent IS NULL
GROUP BY location 
ORDER BY ContinentTotalDeathCount DESC

--Checking for Cases where continent is null
--THIS GIVES THE TOTAL Death counts for the world
SELECT continent, MAX(CAST(total_deaths AS int)) AS ContinentTotalDeathCount
FROM AKOPortfolioProject.dbo.CovidDeaths
--WHERE location LIKE '%Kingdom%'
WHERE continent IS NULL
GROUP BY continent 

SELECT continent, MAX(CAST(total_deaths AS int)) AS ContinentTotalDeathCount
FROM AKOPortfolioProject.dbo.CovidDeaths
--WHERE location LIKE '%Kingdom%'
WHERE continent IS NOT NULL
GROUP BY continent 
ORDER BY ContinentTotalDeathCount DESC




-- GLOBAL BREAKDOWN OF NUMBERS


SELECT date, SUM(new_cases) AS total_Cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/ NULLIF (SUM(new_cases),0)*100 AS DeathPercentage
FROM AKOPortfolioProject.dbo.CovidDeaths
--WHERE location LIKE '%Kingdom%'
WHERE continent IS NOT NULL 
GROUP BY date
ORDER BY 1


-- Remove date and see how it goes
--THIS IS ANOTHER CODE TO USE
--THIS IS ANOTHER CODE TO USE
--THIS IS ANOTHER CODE TO USE
--THIS IS ANOTHER CODE TO USE

SELECT SUM(new_cases) AS total_Cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/ NULLIF (SUM(new_cases),0)*100 AS DeathPercentage
FROM AKOPortfolioProject.dbo.CovidDeaths
--WHERE location LIKE '%Kingdom%'
WHERE continent IS NOT NULL 
ORDER BY 1


--- JOINNIG THE TWO TABLES TO FIND population vs Vaccinations
SELECT*
FROM AKOPortfolioProject..CovidDeaths AS de
JOIN AKOPortfolioProject..CovidVaccinations AS vac
      ON  de.location = vac.location
	  AND de.date = vac.date

-- edit this later if possibe
-- edit this later if possibe
-- edit this later if possibe
SELECT de.continent, de.location, de.date, de.population, vac.new_vaccinations, 
      SUM(CONVERT(int,vac.new_vaccinations)) OVER (PARTITION BY de.location ORDER BY de.location, de.date) AS RollingVaccinationPeople
FROM AKOPortfolioProject..CovidDeaths AS de
JOIN AKOPortfolioProject..CovidVaccinations AS vac
      ON  de.location = vac.location
	  AND de.date = vac.date
WHERE de.continent IS NOT NULL
ORDER BY 2,3




--- TABLEAU VISUALISATION FORMATION

