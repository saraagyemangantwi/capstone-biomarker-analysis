# capstone-biomarker-analysis
Reproducible R-based analysis of cytokine and chemokine concentrations, including data cleaning, descriptive statistics, distributional assessment, and correlation analysis.
# Cytokine and Chemokine Profiling: Exploratory Statistical Analysis

# Overview

This repository contains the R code, data-processing workflow, statistical analyses, and visualisations developed for a capstone project examining the distribution and relationships among cytokine and chemokine biomarkers.

The analysis uses a publicly available laboratory dataset containing measurements of 13 cytokines and chemokines across 1,768 samples. The primary objective of the analysis is to characterise the biomarker distributions and investigate patterns of association among the measured inflammatory and immune mediators.

The project places particular emphasis on appropriate statistical handling of highly skewed biomarker concentration data.

# Biomarkers

The dataset contains measurements for the following biomarkers:

- Eotaxin
- Fractalkine
- Interferon alpha-2
- Interferon-gamma
- Interleukin-12
- Interleukin-1 RA
- Interleukin-5
- Interferon gamma IP-10
- Monocyte Chemoattractant Protein-1 (MCP-1)
- TNF-alpha
- Interleukin-1β
- Interleukin-6
- Interleukin-10
- Interleukin-4

> Note: The dataset contains a column named `SAMPLEID`. This is an identifier, it was therefore excluded from statistical analyses.

# Research Questions

The analysis addresses the following exploratory questions:

1. What are the distributions of the measured cytokine and chemokine concentrations?
2. What are the central tendency and dispersion characteristics of the biomarkers?
3. To what extent are the biomarker concentrations skewed?
4. Are there correlations among the measured cytokines and chemokines?
5. Which biomarker associations remain statistically significant after correction for multiple comparisons?

# Data

The analysis dataset contains 1,768 observations and 14 biomarkers.
During data cleaning, three duplicated sample identifiers were identified. The records were retained because they contained different laboratory measurements. Unique suffixes were assigned to the affected records to facilitate record-level identification while maintaining traceability to the original identifiers.

The original dataset is retained separately from the cleaned analytical dataset.

# Data Cleaning

The following data preparation steps were undertaken:

- Inspection of variable names and data types
- Identification of duplicated sample identifiers
- Assignment of unique identifiers to duplicated records
- Assessment of missing observations
- Examination of minimum and maximum values
- Assessment of biomarker distributions
- Evaluation of skewness and kurtosis
- Exclusion of `SAMPLEID` from statistical analyses

No observations were removed solely because they were statistically extreme. Potential extreme values are considered in the context of the laboratory assay and biological variability.

# Statistical Analysis

# Descriptive statistics

Descriptive statistics include:

- Sample size (N)
- Mean
- Standard deviation (SD)
- Median
- First quartile (Q1)
- Third quartile (Q3)
- Interquartile range (IQR)
- Minimum
- Maximum
- Skewness

Because the biomarker concentrations demonstrate substantial positive skewness, median and IQR are emphasised as measures of central tendency and dispersion.

# Distributional assessment

Histograms and boxplots are used to assess the distributions of individual biomarkers.

Because several biomarkers exhibit substantial right-skewness and extreme upper-tail values, log10-scaled visualisations are used to improve visualisation of the concentration distributions.

The log transformation is used for visualisation and selected downstream analyses where appropriate. The original concentration values are retained for descriptive reporting.

# Correlation analysis

Spearman's rank correlation is used to assess monotonic associations between biomarkers.

Spearman correlation was selected because the biomarker concentrations are substantially non-normal and highly skewed.

The analysis uses pairwise complete observations where appropriate.

Because 14 biomarkers generate 78 unique pairwise comparisons, p-values are adjusted using the Benjamini-Hochberg procedure to control the false discovery rate.

# Correlation heatmap

A correlation heatmap is used to visualise the direction and magnitude of associations among biomarkers.

Correlation coefficients range from:

- `-1`: perfect negative association
- `0`: no monotonic association
- `+1`: perfect positive association

The final heatmap distinguishes statistically significant from non-significant associations using Benjamini-Hochberg-adjusted p-values.

# Visualisations

The project includes:

- Individual biomarker histograms
- Log10-scaled distribution plots
- Biomarker boxplots
- Spearman correlation heatmap

# Key Preliminary Findings

Preliminary analysis indicates substantial heterogeneity in biomarker concentrations.

Most biomarkers demonstrate marked positive skewness, with mean concentrations exceeding their corresponding medians. Several biomarkers also demonstrate substantial upper-tail variability.

The correlation analysis identified several moderate to strong positive associations among biomarkers. Examples include:

Interleukin-10 and Interleutin-4 (0.708, p<0.001)  
Eotaxin and Monocyte Chemoattractant Protein-1 (0.617, p<0.001) 
Fractalkine and Interleukin-12 (0.579, p<0.001) 

These associations are exploratory and should not be interpreted as evidence of causality.
