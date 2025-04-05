# Layoffs SQL Project – Part 1: Data Cleaning

This project focuses on cleaning and preparing a dataset containing global layoff events across industries and time. The aim of this stage is to ensure the data is reliable and ready for analysis.

---

## Overview

Before drawing any insights, the raw data needed significant preparation. In this part of the project, I focused on:
- Removing duplicates
- Standardizing inconsistent entries
- Converting date formats
- Addressing missing values

All steps were performed using SQL, and a separate staging table was used throughout to keep the original data intact.

---

## Key Steps

### 1. Created Staging Tables
To avoid altering the raw data, a copy was created and used as a working table (`layoff_staging` → `layoffs_staging2`).

### 2. Identified and Removed Duplicates
Used `ROW_NUMBER()` with a window function across multiple columns to flag and delete duplicate records.

### 3. Standardized Text Fields
- Trimmed white spaces from company and industry names  
- Corrected inconsistent entries (e.g., "CryptoCurrency" standardized to "Crypto")  
- Cleaned up country and location names, including encoding errors (e.g., "DÃ¼sseldorf" → "Dusseldorf")

### 4. Converted Date Formats
Transformed `date` from string to SQL `DATE` format using `STR_TO_DATE()` and updated the table accordingly.

### 5. Handled Missing and Blank Values
- Replaced blank strings with NULL  
- Inferred missing values where possible using existing company data  
- Removed rows with no layoff-related data (i.e. both `total_laid_off` and `percentage_laid_off` were null)

### 6. Final Cleanup
Removed the helper column `row_num` used for deduplication.

---

# Layoffs SQL Project – Part 2: Exploratory Data Analysis

After cleaning the data, the next step was to explore it and look for trends in layoffs across companies, industries, and countries over time.

---

## Overview

Using SQL, I answered key questions such as:

- Which companies had the highest number of layoffs?
- What were the trends over time by year and by month?
- Which countries and industries were most affected?
- How many companies laid off their entire workforce?
- Who were the top 5 companies with the most layoffs each year?

---

## What I Looked At

### 1. Biggest Layoffs
- Found the highest total layoffs and companies that laid off 100% of their staff
- Listed companies with the most layoffs overall

### 2. Trends Over Time
- Checked layoffs by year and by month
- Created a rolling total to see how layoffs built up over time

### 3. Industry and Country Insights
- Looked at total layoffs by industry
- Found which countries had the most layoffs

### 4. Company Trends by Year
- Broke down layoffs by company and year
- Used window functions to rank the top companies each year

---

## Sample Insights

- Companies like Meta, Amazon, and Google reported the highest total layoffs.
- The retail and consumer industry experienced the most significant impact during the analyzed period.
- Layoffs peaked in late 2022 and early 2023.
- The U.S. saw the largest share of total layoffs across all countries.

