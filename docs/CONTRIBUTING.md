# 贡献指南（Contributing Guide）

欢迎为本科升学路径指南贡献内容！本文档将帮助你了解如何参与项目。

---

## 📝 贡献方式

### 1. 分享升学经验

如果你已经完成保研或考研，欢迎分享你的经历：

**内容要求**：
- 个人背景（年级、绩点、科研经历等）
- 院校选择思路与决策过程
- 申请/备考时间线
- 经验教训与建议

**提交方式**：
- 在 [Issues](https://github.com/knight-zmz/Liferguide/issues) 中新建「经验分享」
- 或直接编辑 `lifeguide.tex` 提交 PR

### 2. 更新政策信息

政策每年都有变化，欢迎更新：
- 保研资格条件
- 各高校招生简章
- 夏令营/预推免时间表

**编辑位置**：对应章节的政策部分，标注年份

### 3. 修复错误

发现内容错误、排版问题或过时信息？
- 通过 [Issues](https://github.com/knight-zmz/Liferguide/issues) 报告
- 或直接提交 PR 修复

### 4. 改进排版与样式

如果你熟悉 LaTeX 或 Web 前端：
- 优化 LaTeX 排版（`lifeguide.tex`）
- 改进在线阅读样式（`web/lifeguide.css`）
- 增强交互功能（`web/postprocess_html.py`）

---

## 🔧 技术贡献流程

### 步骤 1：Fork 并克隆仓库

```bash
# 在 GitHub 上点击"Fork"按钮，然后克隆你的 fork
git clone https://github.com/你的用户名/Liferguide.git
cd Liferguide
```

### 步骤 2：创建分支

```bash
# 创建一个描述性的分支名
git checkout -b feature/add-2026-policy
# 或
git checkout -b fix/typo-in-chapter2
```

### 步骤 3：编辑源文件

**编辑 LaTeX 内容**：
```bash
# 使用你喜欢的编辑器
vim lifeguide.tex
# 或 VS Code（推荐安装 LaTeX Workshop 扩展）
code lifeguide.tex
```

**LaTeX 编辑规范**：
- 保持模块化注释系统（`% region` / `% endregion`）
- 使用 `\blocktitle{}` 宏统一子标题格式
- 图片引用使用相对路径：`media/filename.png`
- 新章节使用递增的 label：`\chapter{\label{ref-XXX}标题}`

### 步骤 4：本地编译测试

```bash
# Linux/macOS
./build.sh pdf

# Windows PowerShell
.\build.ps1 -Command pdf
```

**检查要点**：
- PDF 生成成功
- 目录页码正确
- 图片显示正常
- 中文排版无乱码

### 步骤 5：提交更改

```bash
git add lifeguide.tex   # 或其他修改的文件
git commit -m "docs: 补充2026年保研政策更新"
```

**Commit 消息规范**：
- `docs:` - 文档内容更新
- `style:` - 排版样式调整
- `fix:` - 修复错误
- `feat:` - 新功能（如新章节模块）
- `chore:` - 构建或配置改动

### 步骤 6：推送并创建 Pull Request

```bash
git push origin feature/add-2026-policy
```

然后在 GitHub 上创建 Pull Request：
1. 打开你的 fork 仓库
2. 点击「Compare & pull request」
3. 填写 PR 描述（说明你做了什么改动）
4. 提交 PR 等待审核

---

## 📋 内容编辑指南

### 章节结构规范

```latex
\chapter{\label{ref-XXX}章标题}

\section{\label{ref-XXX}节标题}

\subsection{\label{ref-XXX}小节标题}

\blocktitle{块标题}  % 用于子标题，不生成目录条目

正文内容...

\begin{itemize}
  \item 列表项 1
  \item 列表项 2
\end{itemize}
```

### 图片插入

```latex
\begin{figure}[H]
  \centering
  \includegraphics[width=0.8\textwidth]{media/filename.png}
  \caption{图片标题}
  \label{fig:xxx}
\end{figure}
```

### 表格示例

```latex
\begin{table}[H]
  \centering
  \begin{tabular}{|l|c|r|}
    \hline
    列1 & 列2 & 列3 \\
    \hline
    内容1 & 内容2 & 内容3 \\
    \hline
  \end{tabular}
  \caption{表格标题}
  \label{tab:xxx}
\end{table}
```

### 颜色使用

已定义颜色（见 `lifeguide.tex` 模块 D）：
- `title-chapter` - 章标题
- `title-section` - 节标题
- `title-subsection` - 小节标题
- `link-blue` - 超链接
- `text-gray` - 辅助文字

使用方式：
```latex
\textcolor{title-section}{强调文字}
```

---

## ✅ PR 审核标准

你的 PR 需要满足以下条件才会被合并：

### 内容要求
- [ ] 内容准确无误，来源可靠
- [ ] 语言表达清晰，无明显语法错误
- [ ] 适合目标读者（本科生）的理解水平

### 技术要求
- [ ] LaTeX 编译无错误
- [ ] 本地测试 PDF 生成正常
- [ ] 图片链接有效（如有新增图片）
- [ ] 遵循项目代码规范

### 格式要求
- [ ] 使用项目既有的排版风格
- [ ] 标题层级合理，不过深不过浅
- [ ] 图表编号连续，无重复 label

---

## 🎯 常见贡献场景

### 场景 1：添加经验分享

**位置**：对应章节的「经验分享」小节  
**模板**：
```latex
\blocktitle{学长/学姐姓名（XX级，去向院校）}

\textbf{个人背景}：绩点 X.XX，科研经历...

\textbf{申请过程}：时间线、院校选择...

\textbf{经验建议}：...
```

### 场景 2：更新政策信息

**位置**：对应章节的政策解读部分  
**注意事项**：
- 标注政策适用年份（如「2026年最新政策」）
- 提供官方文件链接（如有）
- 与旧政策对比说明变化点

### 场景 3：改进 Web 样式

**文件**：`web/lifeguide.css`  
**测试方式**：
```bash
./build.sh all  # 生成 HTML
# 在浏览器中打开 build/html/lifeguide.html 查看效果
```

---

## 🆘 获取帮助

遇到问题？
- 查看 [.github/copilot-instructions.md](.github/copilot-instructions.md) 技术文档
- 在 [Issues](https://github.com/knight-zmz/Liferguide/issues) 提问
- 微信公众号：学生物的葫芦娃救爷爷

---

## 📜 许可与署名

- 提交内容视为同意项目许可条款（院内交流使用）
- 经验分享将标注贡献者身份（年级、去向等）
- 保留作者署名权，但授权项目使用与修改

---

**感谢你的贡献！** 🎉  
每一份经验分享和内容改进都让这份指南更有价值。
