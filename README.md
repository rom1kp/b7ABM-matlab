# b7ABM-matlab

**b7ABM-matlab** is a MATLAB-based urban simulation model that provides a comprehensive set of functions for creating and distributing urban data for the city of Beer Sheva. The repository contains routines for generating households, agents, workplaces, and building and asset databases (data allocation). The main urban simulation model includes all the necessary functions for both the economic and contagion submodels.

## Overview

The repository is organized into two main parts:

1. **Data Preparation Functions:**  
   A collection of MATLAB functions that handle tasks such as:
   - Creating workplaces in non-residential buildings and assigning jobs.
   - Creating synthetic assets, households, and agents, and distributing them across real-world buildings.
   - Establishing building usage and setting weights for probability distributions.

2. **Urban Simulation Functions:**  
   A set of functions dedicated to running a full-scale simulation that includes:
   - Calculating building values and asset prices.
   - Assigning building scores and household counts.
   - Simulating contagion events and assessing their impact on agents and households.
   - Managing migration, workplace assignments, and updating agents' routines.

The main simulation script (`run_model`) ties together the functions to run a complete urban simulation, while the main allocation script (`main_alloc`) integrates the initial data preparation functions.

## Features

- **Modular Function Design:**  
  Each function focuses on a specific aspect of the simulation, making the model easy to understand and extend.

- **Comprehensive Data Handling:**  
  Functions cover a wide range of urban metrics, including building usage, floorspace, household income distribution, and statistical area service ratios.

- **Event Simulation:**  
  Includes routines for simulating the contagion process and assessing its impact on urban dynamics.

- **Customization and Scalability:**  
  Input parameters such as mean values, standard deviations, weights, and scaling factors allow users to customize the model for different urban settings.

---
