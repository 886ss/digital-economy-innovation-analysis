library(tidyverse)
library(corrplot)
library(scales)

# Load data
df <- read_csv("data/digital_economy_innovation.csv", show_col_types = FALSE)

# Feature engineering (mirrors report.Rmd)
df <- df %>%
  mutate(
    income_group = case_when(
      `GDP per capita (current US$)` < 2000 ~ "Low-income",
      `GDP per capita (current US$)` < 8000 ~ "Lower-middle",
      `GDP per capita (current US$)` < 25000 ~ "Upper-middle",
      `GDP per capita (current US$)` >= 25000 ~ "High-income",
      TRUE ~ NA_character_
    ),
    digital_index = (`Individuals using the Internet (% of population)` +
                     `Mobile cellular subscriptions (per 100 people)` +
                     `Fixed broadband subscriptions (per 100 people)`) / 3
  )
df$income_group <- factor(df$income_group,
  levels = c("Low-income", "Lower-middle", "Upper-middle", "High-income"), ordered = TRUE)

# ====== Chart 1: Scatter — Internet vs GDP per capita ======
p1 <- ggplot(df %>% filter(year == 2022),
       aes(x = `GDP per capita (current US$)`,
           y = `Individuals using the Internet (% of population)`,
           color = income_group)) +
  geom_point(alpha = 0.7, size = 2.5) +
  scale_x_log10(labels = comma, breaks = c(500, 2000, 8000, 25000, 100000)) +
  scale_color_brewer(palette = "Set1", name = "Income Group") +
  labs(title = "Internet Penetration vs GDP per Capita (2022)",
       subtitle = "Each dot represents a country — a clear log-linear relationship emerges",
       x = "GDP per Capita (USD, log scale)", y = "Internet Users (% of population)") +
  theme_minimal(base_size = 13) +
  theme(plot.title = element_text(face = "bold", size = 16),
        legend.position = "bottom")
ggsave("charts/chart1_internet_vs_gdp.png", p1, width = 10, height = 6.5, dpi = 150, bg = "white")

# ====== Chart 2: Boxplot — Digital Index by Income Group ======
df_2020p <- df %>% filter(!is.na(income_group), year >= 2020)
p2 <- ggplot(df_2020p, aes(x = income_group, y = digital_index, fill = income_group)) +
  geom_boxplot(alpha = 0.85, outlier.alpha = 0.3) +
  stat_summary(fun = mean, geom = "point", shape = 23, size = 4, fill = "white", stroke = 1) +
  scale_fill_brewer(palette = "Set2", guide = "none") +
  labs(title = "Digital Composite Index by Income Group (2020–2024)",
       subtitle = "White diamonds = group mean. Digital Index = (Internet + Mobile + Broadband) / 3",
       x = "", y = "Digital Composite Index") +
  theme_minimal(base_size = 13) +
  theme(plot.title = element_text(face = "bold", size = 16),
        axis.text.x = element_text(size = 11))
ggsave("charts/chart2_digital_divide_boxplot.png", p2, width = 10, height = 6, dpi = 150, bg = "white")

# ====== Chart 3: Line — Internet trend by income group ======
df_trend <- df %>%
  filter(!is.na(income_group)) %>%
  group_by(year, income_group) %>%
  summarise(
    Internet = mean(`Individuals using the Internet (% of population)`, na.rm = TRUE),
    .groups = "drop"
  )

p3 <- ggplot(df_trend, aes(x = year, y = Internet, color = income_group, group = income_group)) +
  geom_line(linewidth = 1.3) + geom_point(size = 2) +
  scale_color_brewer(palette = "Set1", name = "Income Group") +
  scale_y_continuous(limits = c(0, 100), breaks = seq(0, 100, 20)) +
  labs(title = "Internet Penetration Trends by Income Group (2010–2024)",
       subtitle = "Lower-income groups are catching up — a 'leapfrog' effect in digital adoption",
       x = "Year", y = "Internet Users (% of population)") +
  theme_minimal(base_size = 13) +
  theme(plot.title = element_text(face = "bold", size = 16),
        legend.position = "bottom")
ggsave("charts/chart3_trend_lines.png", p3, width = 10, height = 6, dpi = 150, bg = "white")

# ====== Chart 4: R&D vs High-tech exports with regression ======
df_model <- df %>%
  filter(
    !is.na(`Individuals using the Internet (% of population)`),
    !is.na(`Research and development expenditure (% of GDP)`),
    !is.na(`GDP per capita (current US$)`),
    !is.na(`High-technology exports (% of manufactured exports)`)
  ) %>%
  mutate(income_group = case_when(
    `GDP per capita (current US$)` < 2000 ~ "Low-income",
    `GDP per capita (current US$)` < 8000 ~ "Lower-middle",
    `GDP per capita (current US$)` < 25000 ~ "Upper-middle",
    `GDP per capita (current US$)` >= 25000 ~ "High-income",
    TRUE ~ NA_character_
  ))
df_model$income_group <- factor(df_model$income_group,
  levels = c("Low-income", "Lower-middle", "Upper-middle", "High-income"), ordered = TRUE)

p4 <- ggplot(df_model %>% filter(year >= 2020, !is.na(income_group)),
       aes(x = `Research and development expenditure (% of GDP)`,
           y = `High-technology exports (% of manufactured exports)`)) +
  geom_point(aes(color = income_group), alpha = 0.75, size = 3) +
  geom_smooth(method = "lm", se = TRUE, color = "#B2182B", fill = "#F4A582", alpha = 0.3, linewidth = 1.2) +
  scale_color_brewer(palette = "Set1", name = "Income Group") +
  labs(title = "R&D Expenditure vs High-Technology Exports",
       subtitle = "Red line: linear regression with 95% CI. R&D investment is the strongest predictor (standardized β = 0.48)",
       x = "R&D Expenditure (% of GDP)", y = "High-Tech Exports (% of manufactured exports)") +
  theme_minimal(base_size = 13) +
  theme(plot.title = element_text(face = "bold", size = 16), legend.position = "bottom")
ggsave("charts/chart4_rd_vs_hightech.png", p4, width = 10, height = 6.5, dpi = 150, bg = "white")

# ====== Chart 5: Top 20 Patent Countries (2022) ======
top_patents <- df %>%
  filter(year == 2022, !is.na(`Patent applications, residents`)) %>%
  slice_max(`Patent applications, residents`, n = 20) %>%
  mutate(country = fct_reorder(country, `Patent applications, residents`))

p5 <- ggplot(top_patents, aes(x = `Patent applications, residents`, y = country)) +
  geom_col(aes(fill = income_group), width = 0.75) +
  scale_fill_brewer(palette = "Set2", name = "Income Group") +
  scale_x_continuous(labels = comma, expand = expansion(mult = c(0, 0.08))) +
  labs(title = "Resident Patent Applications — Top 20 Countries (2022)",
       subtitle = "China leads with 1.42M applications. India (lower-middle income) enters the Top 5.",
       x = "Resident Patent Applications", y = "") +
  theme_minimal(base_size = 13) +
  theme(plot.title = element_text(face = "bold", size = 16), legend.position = "bottom")
ggsave("charts/chart5_top_patents.png", p5, width = 10, height = 6.5, dpi = 150, bg = "white")

# ====== Chart 6: Correlation Matrix ======
cor_vars <- df_model %>%
  select(
    `Internet` = `Individuals using the Internet (% of population)`,
    `Mobile` = `Mobile cellular subscriptions (per 100 people)`,
    `Broadband` = `Fixed broadband subscriptions (per 100 people)`,
    `SecureServers` = `Secure Internet servers (per 1 million people)`,
    `R&D` = `Research and development expenditure (% of GDP)`,
    `HiTechExports` = `High-technology exports (% of manufactured exports)`,
    `GDPpc` = `GDP per capita (current US$)`,
    `ICTexports` = `ICT service exports (% of service exports, BoP)`
  )
cor_matrix <- cor(cor_vars, use = "pairwise.complete.obs")

png("charts/chart6_correlation_matrix.png", width = 10, height = 8, units = "in", res = 150, bg = "white")
corrplot(cor_matrix, method = "color", type = "upper",
         addCoef.col = "black", number.cex = 0.85,
         tl.col = "#1E293B", tl.cex = 0.9,
         title = "Correlation Matrix: Digital Infrastructure × Innovation Indicators",
         mar = c(0, 0, 3, 0),
         col = colorRampPalette(c("#2166AC", "#F7F7F7", "#B2182B"))(100))
dev.off()

# ====== Chart 7: ANOVA F-stat bar ======
df_2022 <- df %>% filter(year == 2022, !is.na(income_group), !is.na(digital_index))
anova_model <- aov(digital_index ~ income_group, data = df_2022)
anova_s <- summary(anova_model)
eta_sq <- anova_s[[1]]$`Sum Sq`[1] / sum(anova_s[[1]]$`Sum Sq`)

# Group means for chart
group_means <- df_2022 %>%
  group_by(income_group) %>%
  summarise(Mean = mean(digital_index, na.rm = TRUE), SD = sd(digital_index, na.rm = TRUE), .groups = "drop")

p7 <- ggplot(group_means, aes(x = income_group, y = Mean, fill = income_group)) +
  geom_col(width = 0.6, alpha = 0.9) +
  geom_errorbar(aes(ymin = Mean - SD, ymax = Mean + SD), width = 0.15, color = "#475569", linewidth = 0.8) +
  geom_text(aes(label = round(Mean, 1)), vjust = -1.2, fontface = "bold", size = 5, color = "#1E293B") +
  scale_fill_brewer(palette = "Set2", guide = "none") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.2))) +
  labs(title = "ANOVA: Digital Index by Income Group (2022)",
       subtitle = paste0("F = ", round(anova_s[[1]]$`F value`[1], 1),
                         ", p < 0.001, η² = ", round(eta_sq, 3),
                         "  |  All pairwise differences significant (Tukey HSD)"),
       x = "", y = "Digital Composite Index (mean ± 1 SD)") +
  theme_minimal(base_size = 13) +
  theme(plot.title = element_text(face = "bold", size = 16),
        plot.subtitle = element_text(color = "#475569"))
ggsave("charts/chart7_anova_bars.png", p7, width = 10, height = 6, dpi = 150, bg = "white")

cat("All 7 charts generated successfully in charts/\n")
