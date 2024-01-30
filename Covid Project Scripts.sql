SELECT location, date, total_cases, new_cases, total_deaths
FROM `animated-scope-408514.PortfolioProject.CovidDeaths`
ORDER BY 1,2

-- Looking at Total Cases vs Total Deaths
SELECT location, date, total_cases, total_deaths, ROUND((total_deaths/total_cases)*100,2) AS DeathPercentage
FROM `animated-scope-408514.PortfolioProject.CovidDeaths`
WHERE location LIKE 'Turkey'
WHERE continent IS NOT NULL
ORDER BY DeathPercentage DESC

-- Looking at Total Cases vs Population
-- Shows what percentage of population got Covid
SELECT location, date,  population, total_cases, ROUND((total_cases/population)*100,2) AS InfectionPercentage
FROM `animated-scope-408514.PortfolioProject.CovidDeaths`
--WHERE location like 'Turkey'
ORDER BY 1,2

-- Looking at countries with highest infection rate compared to population
SELECT location, population, MAX(total_cases) AS HighestInfectionCount, ROUND(MAX(total_cases/population)*100,2) AS InfectionPercentage
FROM `animated-scope-408514.PortfolioProject.CovidDeaths`
GROUP BY location, population
--WHERE location like 'Turkey'
ORDER BY 4 DESC


--Showing countries with highest death count per population

SELECT location, MAX (total_deaths)
FROM `animated-scope-408514.PortfolioProject.CovidDeaths`
WHERE continent IS NOT NULL
GROUP BY location
--WHERE location like 'Turkey'
ORDER BY 2 DESC


-- LET'S Break this down to the continent 

-- Showing continent with hightst death count 
SELECT continent, MAX (total_deaths)
FROM `animated-scope-408514.PortfolioProject.CovidDeaths`
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY 2 DESC


--GLOBAL NUMBERS

SELECT  SUM(new_cases) AS total_case, SUM(new_deaths) AS total_deaths, ROUND(SUM(new_deaths)/SUM(new_cases)*100,2) AS DeathsPercentage --total_deaths, ROUND((total_deaths/total_cases)*100,2) AS DeathPercentage
FROM `animated-scope-408514.PortfolioProject.CovidDeaths`
--WHERE location LIKE 'Turkey'
WHERE continent IS NOT NULL
--GROUP BY date
ORDER BY 1,2

--Looking at Total Population vs Vaccinations
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(new_vaccinations) OVER (PARTITION BY dea.location,dea.date) AS RollingPeopleVaccinated
FROM `animated-scope-408514.PortfolioProject.CovidDeaths` dea
JOIN `animated-scope-408514.PortfolioProject.CovidVaccination` vac 
  ON dea.location = vac.location
  AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3


--Creating View to store data for later visualization

CREATE VIEW PercentPopulationVaccinated as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(new_vaccinations) OVER (PARTITION BY dea.location,dea.date) AS RollingPeopleVaccinated
FROM `animated-scope-408514.PortfolioProject.CovidDeaths` dea
JOIN `animated-scope-408514.PortfolioProject.CovidVaccination` vac 
  ON dea.location = vac.location
  AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3
