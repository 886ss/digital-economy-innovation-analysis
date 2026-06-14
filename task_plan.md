# Task Plan: 《R语言编程基础》期末项目考核

## Goal
基于 Kaggle 真实数据集，完成从数据导入、清洗、可视化到统计分析的完整 R 语言数据分析流程，生成一份可完全复现的 R Markdown HTML/PDF 报告，满足课程期末考核全部硬性指标要求。

## ⚠️ 核心策略
> **老师明确声明：选题越新颖越高分。** 避开 iris/mtcars/titanic/房价/信用卡欺诈等烂大街话题，优先寻找冷门但有趣的数据集，在"数据获取与理解"维度争取满分10分。

## Current Phase
Phase 1

## Phases

### Phase 1: 选题搜索与环境准备
- [x] **在 Kaggle 搜索新颖数据集**
- [x] 筛选验证6个候选数据集（全部Kaggle真实来源）
- [x] **✅ 确定选题：世界银行全球发展指标 (1960至今)**
  - Kaggle: `georgejdinicola/world-bank-indicators`
  - 800+指标 × 268国家 × 60年
  - 聚焦子主题：数字经济/数字基础设施相关指标
- [ ] 检查本地 R/RStudio 环境
- [ ] 安装缺失 R 包（tidyverse, rmarkdown, knitr, corrplot, car）
- [ ] 从 Kaggle 下载数据集
- [ ] 初始化项目目录结构
- **Status:** complete ✅

### Phase 2: 数据导入与预处理
- [ ] 使用 `read_csv()` 导入数据，设置相对路径 `data/`
- [ ] 创建变量字典（每个变量含义和类型）
- [ ] 缺失值检测与处理
- [ ] 异常值检测与处理
- [ ] 使用 ≥5 种 dplyr/tidyr 函数完成清洗
- [ ] 变量重编码与新变量创建
- **Status:** pending

### Phase 3: 探索性数据分析 (EDA)
- [ ] 输出 ≥2 个分组汇总表（均值、中位数、标准差等）
- [ ] ggplot2 绘制 ≥5 张图形（类型 ≥3 种）
- [ ] 每张图包含标题、轴标签 + 文字解读
- **Status:** pending

### Phase 4: 统计推断与建模
- [ ] 统计检验/建模 ≥2 项
- [ ] 明确写出原假设、检验统计量、p值解释、业务结论
- [ ] 若做回归：附模型诊断图
- **Status:** pending

### Phase 5: 撰写 R Markdown 报告
- [ ] 按七段结构组织：引言→数据说明→预处理→EDA→深入分析→结论→附录
- [ ] 引言突出选题新颖性和研究价值
- [ ] 代码块带注释，确保 Knit 无错误
- [ ] 图文对应，每图有解读
- [ ] 结论与反思
- [ ] Knit → HTML 验证
- **Status:** pending

### Phase 6: 打包与交付
- [ ] 组织 ZIP：report.Rmd + report.html + data/ + 分工与互评.pdf + README.md
- [ ] 小组报告 PPT
- [ ] 对照评分标准自检（重点确认新颖性加分项）
- [ ] 打包提交
- **Status:** pending

## Key Questions
1. ~~选题方向？~~ → **新颖冷门 > 熟悉热门**（老师明确标准）
2. 是否按小组（需分工表），还是个人独立完成？
3. 统计方法选哪2项最适配所选数据？
4. 最终报告输出 HTML 还是 PDF？

## Decisions Made
| Decision | Rationale |
|----------|-----------|
| 选题策略：冷门新颖优先 | 老师明确"选题越新颖越高分" |
| R Markdown → HTML | 考核列为首选项，支持交互图 |
| tidyverse 全家桶 | 考核明确要求 dplyr/tidyr/ggplot2 |

## Errors Encountered
| Error | Attempt | Resolution |
|-------|---------|------------|
|       | 1       |            |

## Notes
- ⏰ 截止：17周周四 23:59
- 📊 评分：数据获取(10) + 清洗(20) + 可视化(20) + 统计(20) + 报告(20) + 分工(10)
- 🚫 严禁抄袭，迟交一周扣10分
- 💡 选题是区分度最大的维度——老师已明确表态
