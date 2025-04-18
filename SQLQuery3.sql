--SELECT *
  --FROM portfolioProject..CovidDeaths
  --order by 3,4;

  -- Likehood of your dying if you contact covid in your country per day
select location, date, total_cases, total_deaths, 
(total_deaths/total_cases) * 100 as DeathPercentage 
from portfolioProject..CovidDeaths
where continent  is not null and location = 'Nigeria'
order by 1,2;

    -- we are looking at total cases vs population 

SELECT Location,Population, max(total_cases) as HighestInfected, 
  max((total_cases/Population)) * 100 as popluationInfectedPercent
  FROM portfolioProject..CovidDeaths
  where Continent is not null
  GROUP BY Location, Population
  order by popluationInfectedPercent desc;
 
  /*
	SELECT Location, MAX(total_cases) AS AF
	FROM portfolioProject..CovidDeaths
	WHERE Continent IS NOT NULL AND Location LIKE '%united%'
	GROUP BY Location;

	select location, total_cases
	from portfolioProject..CovidDeaths
	WHERE Continent IS NOT NULL AND Location LIKE '%united s%'; 

	*/

--Countries with highest death ratio count per population

SELECT Location,Population, max(total_deaths) as Fatality, 
  max((total_deaths/Population)) * 100 as FatilitybyPopulationPercent
  FROM portfolioProject..CovidDeaths
  where Continent is not null
  GROUP BY Location, Population
  order by FatilitybyPopulationPercent desc;

  -- countries with higest deaths

SELECT Location, max(cast(total_deaths as int)) as Total_death
  FROM portfolioProject..CovidDeaths
  where Continent is not null
  GROUP BY Location
  order by Total_death desc;

  -- continent with higest deaths 

SELECT Continent, max(cast(total_deaths as int)) as Total_death
  FROM portfolioProject..CovidDeaths
  where Continent is not null
  GROUP BY Continent
  order by Total_death desc;

  -- GBOBAL cases per day
select date, sum(new_cases) as  Daily_cases, sum(cast(new_deaths as int)) as Daily_deaths,
sum(cast(new_deaths as int))/sum(new_cases) * 100 as GbobaldeathPercent
from portfolioProject..CovidDeaths
where continent  is not null 
GROUP BY date
order by 1,2;

select sum(new_cases) as  Total_cases, sum(cast(new_deaths as int)) as Total_deaths,
sum(cast(new_deaths as int))/sum(new_cases) * 100 as GbobalToatalDeathPercent
from portfolioProject..CovidDeaths
where continent  is not null 
--GROUP BY date
;

-- Total population vs vaccinated
select dea.continent, dea.location, 
dea.date,dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int)) over (partition by dea.Location order by dea.location, dea.date) as Total_vaccination
from portfolioProject..CovidDeaths dea
join portfolioProject..CovidVaccinations vac
  on dea.location = vac.location
  and dea.date= vac.date
  where dea.continent  is not null
  order by 2,3;


