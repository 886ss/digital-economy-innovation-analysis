# Findings & Decisions — 《R语言编程基础》期末考核

## 考核要求摘要（源文件: R语言期末考核.html）

### 数据源要求
- **来源**: Kaggle 平台公开数据集（报告需提供原始链接）
- **规模**: 记录数 ≥ 500 条，变量数 ≥ 5 个
- **变量类型**: 至少包含 1 个数值型变量 + 1 个分类型变量
- **禁止**: 不建议选择太简单的玩具数据（如 iris、mtcars）
- **加分**: 选题新颖性（鼓励结合兴趣背景）

### 技术硬性指标
| 技能模块 | 具体要求 | 数量要求 |
|----------|----------|----------|
| 数据导入 | `read_csv()` 或 `read.csv()`，相对路径 | — |
| 数据清洗 | dplyr + tidyr 包函数 | ≥5 种不同函数 |
| 描述性统计 | 分组汇总表（均值、中位数、标准差等） | ≥2 个 |
| 可视化 | ggplot2 绘制有意义的图形 | ≥5 张，类型 ≥3 种 |
| 统计推断/建模 | t检验/卡方/ANOVA/相关性/线性或逻辑回归 | ≥2 项 |
| 可复现报告 | R Markdown → HTML 或 PDF，一键 Knit | 1 份 |

### ggplot2 图形类型要求
- ≥3 种不同类型：散点图、箱线图、柱状图、直方图、折线图等
- 每张图必须包含：标题 + 轴标签 + 简单文字解读

### 报告结构（7部分）
1. **引言** — 研究背景、探究问题、数据集来源与下载链接
2. **数据说明** — 变量字典、数据维度、简要预览
3. **数据预处理** — 缺失值/异常值处理、变量重编码、新变量创建（保留关键代码+文字说明）
4. **探索性数据分析 (EDA)** — 描述性统计量 + 分组汇总表 + ≥5张ggplot2图（每图有解读）
5. **深入分析** — 统计检验/建模、方法选择原因、假设检查、结果解读、模型诊断图
6. **结论与反思** — 总结发现、局限、改进方向
7. **附录** — 团队分工表（必须列出每位成员具体任务贡献）

### 提交清单
```
第X组_期末项目/
├── report.Rmd          # R Markdown 源文件
├── report.html         # 生成的报告（或PDF）
├── data/               # 所用数据集
│   └── dataset.csv
├── README.md           # 运行说明（可选）
└── 分工与互评.pdf      # 团队分工表及互评分数
小组报告PPT
```

### 评分标准（100分）
| 维度 | 分值 |
|------|------|
| 数据获取与理解 | 10 |
| 数据清洗与整理 | 20 |
| 可视化与分析 | 20 |
| 统计推断/建模 | 20 |
| 报告撰写与可复现性 | 20 |
| 团队协作与分工 | 10 |

### 时间节点
- 组队与选题确认：第15周周五前
- **期末报告提交截止：17周周四 23:59**
- 补交/修改：原则上不接受

## Research Findings

### R 包依赖清单
- `tidyverse` (含 dplyr, tidyr, ggplot2, readr 等)
- `rmarkdown` / `knitr`
- `corrplot` (相关性可视化，可选)
- `car` (方差分析/回归诊断，可选)
- `Hmisc` (描述统计，可选)

### Kaggle 候选数据集（2026-06-12 验证，全部为真实数据集）

| # | 数据集 | Kaggle 链接 | 规模 | Kaggle验证 |
|---|--------|-------------|------|:--:|
| 🥇 | 世界银行全球发展指标 (1960至今) | https://www.kaggle.com/datasets/georgejdinicola/world-bank-indicators | 800+指标 × 268国家 × 60年，18个专题CSV | ✅ 已确认 |
| 🥈 | IUCN 全球物种灭绝与威胁评估 | https://www.kaggle.com/datasets/sarcasmos/world-species-extinction-and-threat-assessment-iucn | 14列 × 数万条，20MB | ✅ 已确认 |
| 🥉 | 电商客户流失分析与预测 | https://www.kaggle.com/datasets/ankitverma2010/ecommerce-customer-churn-analysis-and-prediction | 20列 × 5630条，555kB | ✅ 已确认 |
| 4 | 电商客户行为数据集 (50K) | https://www.kaggle.com/datasets/dhairyajeetsingh/ecommerce-customer-behavior-dataset | 25列 × 50,000条，6MB | ✅ 已确认 |
| 5 | 森林健康与生态多样性 | https://www.kaggle.com/datasets/ziya07/forest-health-and-ecological-diversity | 9列 × 1000条，321kB | ✅ 已确认 |
| 6 | 美国国家公园生物多样性 | https://www.kaggle.com/datasets/nationalparkservice/park-biodiversity | parks.csv + species.csv，19列 | ✅ 已确认 |

## Technical Decisions
| Decision | Rationale |
|----------|-----------|
| 题目待选 | Phase 1 确定 |
| R 4.x + RStudio | 课程标配环境 |
| tidyverse 全家桶 | dplyr/tidyr/ggplot2/readr 一站式 |
| 输出 HTML | 课程首选格式，支持交互式图形 |

## Issues Encountered
| Issue | Resolution |
|-------|------------|
|       |            |

## Resources
- 课程考核文件: `d:\R语言\R语言期末考核.html`
- Kaggle: https://www.kaggle.com/
- 组队与提交链接：由教师另行通知
- tidyverse 文档: https://www.tidyverse.org/
- R Markdown 指南: https://rmarkdown.rstudio.com/

## Visual/Browser Findings
- 考核文件为 R Markdown 渲染的独立 HTML（含 MathJax），第448-656行为考核要求
- 无其他教学示例或代码片段嵌入该文件
- 文件体积 629KB，主要成分为 MathJax JS 库（行内嵌入）

---
*Update this file after every 2 view/browser/search operations*
*This prevents visual information from being lost*
