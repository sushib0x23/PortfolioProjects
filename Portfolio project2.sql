select * 
from covid_deaths$
where continent is not null
order by 3,4

--select *
--from covid_vaccinations$
--order by 3,4

select location, date, total_cases, new_cases, total_deaths, population
from covid_deaths$
order by 1,2 

--Total cases vs total deaths
-- shows likelihood of dying if you contract covid in your country
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathsPercentage
from covid_deaths$
where location like '%states%'
order by 1,2 

--Total cases vs population
-- shows what percentage of population got covid
select location, date, population, total_cases, (total_cases/population)*100 as DeathsPercentage
from covid_deaths$
where location like '%states%'
order by 1,2 


--looking at countries with highest infection rate compared to population

select location, population, max(total_cases) as HighestInfectionCount, max((total_cases/population))*100 as PercentPopulationInfected
from covid_deaths$
group by location, population
order by PercentPopulationInfected desc

-- Showing countries with highest death count per population

select location, max(cast(total_deaths as int)) as TotalDeathCount
from covid_deaths$
where continent is not null
group by location
order by TotalDeathCount desc

--breaking down by continent
-- continents with the highest death count per population

select location, max(cast(total_deaths as int)) as TotalDeathCount
from covid_deaths$
where continent is null
group by location
order by TotalDeathCount desc

--looking at total population vs vaccination

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from covid_deaths$ dea
join covid_vaccinations$ vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3


