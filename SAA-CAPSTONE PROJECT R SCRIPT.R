install.packages('dplyr')
library(tidyverse)
install.packages(c(
  "cachem",
  "fastmap",
  "memoise",
  "htmltools",
  "bslib"
))
install.packages(c(
  "tidyverse",
  "learnr",
  "shiny",
  "rmarkdown",
  "knitr",
  "readxl",
  "openxlsx",
  "janitor",
  "gtsummary",
  "gt",
  "flextable",
  "survival",
  "lme4",
  "broom",
  "emmeans",
  "ggpubr"
))

install.packages("readxl")
library(readxl)

setwd("E:/WORKSHOPS, TRAININGS, MENTORSHIP, GRANT/R/")
getwd()
list.files()


capstone_data <- read_excel("Capstone project data.xlsx")
View(capstone_data)
glimpse(capstone_data)
is.na(capstone_data)
sum(is.na(capstone_data)) ## 4 missing values detected ##
colSums(is.na(capstone_data)) ## missing values in IL1b, IL6, IL10 AND IL4 ##

capstone_data %>% 
  select(everything()) %>% 
  filter(!complete.cases(.)) %>%  
  View() ##showed only one ID has all the four missing values

## therefore that row will be deleted because these are unique measures## 
## to delete the row with the missing values
capstone_data1<-na.omit(capstone_data)
View(capstone_data1)


#Renaming

capstone_data1 <- capstone_data1 %>%
  rename('Interferon alpha-2' = IFNa2)
         
capstone_data1 <- capstone_data1 %>%
  rename('Interferon-gamma' = IFNg, 'Interleukin-12' = IL12p70, 'Interleukin-1 RA' = IL1RA, 'Interleukin-5' = IL5, 
         'Interferon gamma IP-10' = IP10, 'Monocyte Chemoattractant P1' = MCP1, 'TNF-alpha' = TNFa, 
         'Interleukin-1b' = IL1b, 'Interleukin-6' = IL6, 'Interleukin-10' = IL10, 
         'Interleukin-4' = IL4)

View(capstone_data1)

#data analysis and visualization
install.packages("ggplot2")
library(ggplot2)

install.packages("psych")
library(psych)

describe(capstone_data1)
results1<-describe(capstone_data1)
View(results1)

install.packages('writexl')
library(writexl)

write_xlsx(results1, "descriptive_statistics_capstonedata1.xlsx")

write_xlsx(capstone_data1, "data_for_analysis_capstonedata1.xlsx")

setwd("E:/WORKSHOPS, TRAININGS, MENTORSHIP, GRANT/R/")
getwd()
list.files()

capstonedata1 <- read_excel("data_for_analysis_capstonedata1.xlsx")
View(capstonedata1)
results1 <- read_excel("descriptive_statistics_capstonedata1.xlsx")
View(results1)

names(capstonedata1)
summary(capstonedata1)

library(ggplot2)
cytokineslong <-capstonedata1 %>%
  pivot_longer(
    cols = -SAMPLEID,
    names_to = 'Biomarker',
    values_to = 'Concentration'
  )
View(cytokineslong)

##Examining distribution and outliers
ggplot(cytokineslong, aes(x = Biomarker, y = Concentration)) +
  geom_boxplot(fill = 'steelblue') +
  scale_y_log10() +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1)
  ) +
  labs(
    x = 'Biomarker',
    y = 'Concentration (log10 scale)'
  )

jointboxplot <- ggplot(cytokineslong, aes(x = Biomarker, y = Concentration)) +
  geom_boxplot(fill = 'steelblue') +
  scale_y_log10() +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1)
  ) +
  labs(
    x = 'Biomarker',
    y = 'Concentration (log10 scale)'
  )

install.packages("plot_ly")
library(plotly)
ggplotly(jointboxplot)


##summary histogram
ggplot(cytokineslong, aes(x = Concentration)) +
  geom_histogram(bins = 30) +
  scale_x_log10() +
  facet_wrap(~ Biomarker, scales = 'free') +
  theme_minimal() +
  labs(
    title = 'Distribution of Cytokines',
    x = 'Concentration(log10 scale)',
    y = 'Frequency'
  )

#individual histograms
ggplot(capstonedata1, aes(x = Eotaxin))+
  geom_histogram(
    fill = 'forestgreen', 
    bins = 30, 
    color = 'white')+
  labs(
    title = 'Distribution of Eotaxin',
    x = 'Eotaxin',
    y = 'Distribution'
  )+
  scale_x_log10() +
  theme_classic()

ggplot(capstonedata1, aes(x = Fractalkine))+
  geom_histogram(fill = 'forestgreen', bins = 30, color = 'white')+
  labs(
    title = 'Distribution of Fractalkine',
    x = 'Fractalkine',
    y = 'Distribution'
  )+
  scale_x_log10() +
theme_classic()

ggplot(capstonedata1, aes(x = `Interferon alpha-2`))+
  geom_histogram(fill = 'forestgreen', bins = 30, color = 'white')+
  labs(
    title = 'Distribution of Interferon alpha-2',
    x = 'Interferon alpha-2',
    y = 'Distribution'
  )+
  scale_x_log10() +
  theme_classic()

ggplot(capstonedata1, aes(x = `Interferon-gamma`))+
  geom_histogram(fill = 'forestgreen', bins = 30, color = 'white')+
  labs(
    title = 'Distribution of Interferon-gamma',
    x = 'Interferon-gamma',
    y = 'Distribution'
  )+
  scale_x_log10() +
  theme_classic()

ggplot(capstonedata1, aes(x = `Interleukin-12`))+
  geom_histogram(fill = 'forestgreen', bins = 30, color = 'white')+
  labs(
    title = 'Distribution of Interleukin-12',
    x = 'Interleukin-12',
    y = 'Distribution'
  )+
  scale_x_log10() +
  theme_classic()

ggplot(capstonedata1, aes(x = `Interleukin-1 RA`))+
  geom_histogram(fill = 'forestgreen', bins = 30, color = 'white')+
  labs(
    title = 'Distribution of Interleukin-1 RA',
    x = 'Interleukin-1 RA',
    y = 'Distribution'
  )+
  scale_x_log10() +
  theme_classic()

ggplot(capstonedata1, aes(x = `Interleukin-5`))+
  geom_histogram(fill = 'forestgreen', bins = 30, color = 'white')+
  labs(
    title = 'Distribution of Interleukin-5',
    x = 'Interleukin-5',
    y = 'Distribution'
  )+
  scale_x_log10() +
  theme_classic()

ggplot(capstonedata1, aes(x = `Interferon gamma IP-10`))+
  geom_histogram(fill = 'forestgreen', bins = 30, color = 'white')+
  labs(
    title = 'Distribution of Interferon gamma IP-10',
    x = 'Interferon gamma IP-10',
    y = 'Distribution'
  )+
  scale_x_log10() +
  theme_classic()

ggplot(capstonedata1, aes(x = `Monocyte Chemoattractant P1`))+
  geom_histogram(fill = 'forestgreen', bins = 30, color = 'white')+
  labs(
    title = 'Distribution of Monocyte Chemoattractant P1',
    x = 'Monocyte Chemoattractant P1',
    y = 'Distribution'
  )+
  scale_x_log10() +
  theme_classic()

ggplot(capstonedata1, aes(x = `TNF-alpha`))+
  geom_histogram(fill = 'forestgreen', bins = 30, color = 'white')+
  labs(
    title = 'Distribution of TNF-alpha',
    x = 'TNF-alpha',
    y = 'Distribution'
  )+
  scale_x_log10() +
  theme_classic()

ggplot(capstonedata1, aes(x = `Interleukin-1b`))+
  geom_histogram(fill = 'forestgreen', bins = 30, color = 'white')+
  labs(
    title = 'Distribution of Interleukin-1b',
    x = 'Interleukin-1b',
    y = 'Distribution'
  )+
  scale_x_log10() +
  theme_classic()

ggplot(capstonedata1, aes(x = `Interleukin-6`))+
  geom_histogram(fill = 'forestgreen', bins = 30, color = 'white')+
  labs(
    title = 'Distribution of Interleukin-6',
    x = 'Interleukin-6',
    y = 'Distribution'
  )+
  scale_x_log10() +
  theme_classic()

ggplot(capstonedata1, aes(x = `Interleukin-10`))+
  geom_histogram(fill = 'forestgreen', bins = 30, color = 'white')+
  labs(
    title = 'Distribution of Interleukin-10',
    x = 'Interleukin-10',
    y = 'Distribution'
  )+
  scale_x_log10() +
  theme_classic()

ggplot(capstonedata1, aes(x = `Interleukin-4`))+
  geom_histogram(fill = 'forestgreen', bins = 30, color = 'white')+
  labs(
    title = 'Distribution of Interleukin-4',
    x = 'Interleukin-4',
    y = 'Distribution'
  )+
  scale_x_log10() +
  theme_classic()

install.packages('janitor')
library(janitor)
install.packages('skimr')
library(skimr) 
install.packages('GGally')
library(GGally) 
install.packages('corrplot')
library(corrplot) 


##Before Correlation between the biomarkers
capstonedata1 %>%
  count(SAMPLEID) %>%
  filter(n > 1)

capstonedata1 %>%
  filter(SAMPLEID %in% c("A313592", "A438522", "A652628")) %>%
  arrange(SAMPLEID)

library(dplyr)

capstonedata1 <- capstonedata1 %>%
  group_by(SAMPLEID) %>%
  mutate(
    SAMPLEID = ifelse(
      n() > 1,
      paste0(SAMPLEID, "-", row_number()),
      SAMPLEID
    )
  ) %>%
  ungroup()

capstonedata1 %>%
  count(SAMPLEID) %>%
  filter(n > 1)

capstonedata1 %>%
  group_by(SAMPLEID) %>%
  mutate(
    SAMPLEID = if (n() > 1) {
      paste0(SAMPLEID, "-", row_number())
    } else {
      SAMPLEID
    }
  ) %>%
  ungroup()

capstonedata1 %>%
  count(SAMPLEID) %>%
  filter(n > 1)

unique(capstonedata1$SAMPLEID)
View(unique(capstonedata1$SAMPLEID))
View(capstonedata1)


capstonedata1$SAMPLEID[450] <- "A313592-2"
capstonedata1$SAMPLEID[1486] <- "A438522-2"
capstonedata1$SAMPLEID[1588] <- "A652628-2"

capstonedata1 %>%
  count(SAMPLEID) %>%
  filter(n > 1)

write_xlsx(capstonedata1, "data_for_analysis_capstonedata1.xlsx")
write_xlsx(cytokineslong, "transformeddata_cytokineslong.xlsx")

library(dplyr)
library(corrplot)

cor_matrix <- capstonedata1 %>%
  select(-SAMPLEID) %>%
  cor(
    method = "spearman",
    use = "pairwise.complete.obs"
  ) 

library(corrplot)

corrplot(
  cor_matrix,
  method = "color",
  type = "upper",
  addCoef.col = "royalblue",
  number.cex = 0.7,
  tl.col = "royalblue",
  tl.srt = 45
)

round(cor_matrix, 2)

library(psych)

cor_results <- corr.test(
  capstonedata1 %>% select(-SAMPLEID),
  method = "spearman",
  use = "pairwise",
  adjust = "BH"
)

cor_results$p
cor_results$r
round(cor_results$p, 4) ##to 4 decimal places

cor_table <- data.frame()

for (i in 1:(ncol(cor_results$r) - 1)) {
  for (j in (i + 1):ncol(cor_results$r)) {
    
    cor_table <- rbind(
      cor_table,
      data.frame(
        Biomarker_1 = colnames(cor_results$r)[i],
        Biomarker_2 = colnames(cor_results$r)[j],
        Spearman_rho = cor_results$r[i, j],
        Adjusted_p = cor_results$p[i, j]
      )
    )
  }
}

cor_table <- cor_table %>%
  mutate(
    Spearman_rho = round(Spearman_rho, 3),
    Adjusted_p = round(Adjusted_p, 4)
  ) %>%
  arrange(Adjusted_p)

View(cor_table)

significant_correlations <- cor_table %>%
  filter(Adjusted_p < 0.05) %>%
  arrange(desc(abs(Spearman_rho)))

View(significant_correlations)
write_xlsx(cor_table, "GeneralCorrelationTable_capstone.xlsx")
write_xlsx(significant_correlations, "Significantcorrelations_capstone.xlsx")

#final correlation heatmap
corrplot(
  cor_results$r,
  method = "color",
  type = "upper",
  addCoef.col = "royalblue",
  number.cex = 0.7,
  tl.col = "royalblue",
  tl.srt = 45,
  p.mat = cor_results$p,
  sig.level = 0.05,
  insig = "blank"
)

install.packages('GGally')
library(GGally)
library(dplyr)
GGally::ggpairs(
  capstonedata1 %>%
    select(-SAMPLEID)
)

##Another way to go about the GGally ##to make it look neater
capstone_log <- capstonedata1 %>%
  select(-SAMPLEID) %>%
  mutate(across(everything(), log10))
GGally::ggpairs(capstone_log)

install.packages("dplyr")
library(dplyr)
library(psych)
library(tidyverse)

descriptive_table <- capstonedata1 %>%
  select(-SAMPLEID) %>%
  summarise(
    across(
      everything(),
      list(
        N = ~ sum(!is.na(.x)),
        Mean = ~ mean(.x, na.rm = TRUE),
        SD = ~ sd(.x, na.rm = TRUE),
        Median = ~ median(.x, na.rm = TRUE),
        Q1 = ~ quantile(.x, 0.25, na.rm = TRUE),
        Q3 = ~ quantile(.x, 0.75, na.rm = TRUE),
        Min = ~ min(.x, na.rm = TRUE),
        Max = ~ max(.x, na.rm = TRUE)
      )))
View(descriptive_table)

library(writexl)
write_xlsx(descriptive_table, "FinaldescriptiveTable_capstone.xlsx")
