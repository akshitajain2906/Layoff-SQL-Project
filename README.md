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

---

## Next Steps

In Part 2 of the project, I explore the cleaned data to uncover trends and patterns across companies, industries, countries, and time.

