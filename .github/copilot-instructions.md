# LaTeX 本科升学指南项目开发指南

## 项目概述

这是一份针对吉林大学生命科学学院学生的**本科升学路径指南**，使用 LaTeX 排版。包含保研和考研两大主题，涵盖政策解读、流程分析和学长学姐经验分享。

**核心特点**：
- 编译引擎：**XeLaTeX**（支持 UTF-8 和中文）
- 源文件：`本科升学指南0.5.tex`（2000+ 行）
- 媒体资源：`media/` 目录（24个图片文件，包括logo和二维码）
- 结构化内容：章-节-小节多层级组织，包含封面、目录、正文、页眉页脚等

## 关键开发模式

### 1. 文件结构规范

**核心编译单位**：
```
本科升学指南0.5.tex        # 唯一源文件，包含全部内容
media/                     # 图片资源（必须相对路径引用）
├── image1.png - image24.png
├── 葫芦娃logo.jpg          # 页眉logo（26mm高）
└── ...
```

**生成文件自动忽略**（`.gitignore` 已配置）：
- 中间文件：`.aux`, `.log`, `.out`, `.toc`, `.fls`, `.fdb_latexmk`, `.synctex.gz`
- 输出文件：`.pdf`, `.dvi`, `.docx`

### 2. 模块化注释系统

所有代码使用 `% region 模块X：描述` 和 `% endregion` 包裹逻辑模块：

```tex
% region 模块A：页面与引擎基础设置
\usepackage[a4paper,...]{geometry}
% endregion 模块A：页面与引擎基础设置
```

**已有模块**（按出现顺序）：
- **A**：页面与引擎基础设置（纸张、XeLaTeX检测、UTF-8）
- **B**：核心功能宏包（图形、ctex中文、超链接）
- **C**：排版增强宏包（行距、列表、表格、页眉）
- **D**：颜色系统（定义8个主题色，支持RGB值）
- **E**：全局排版预设（行距1.2、段间距、列表缩进、标题分层）
- **F**：图片容错机制（缺图显示占位框，不中断编译）
- **G-I**：文档正文部分（全局颜色、封面、页眉页脚）

**添加新内容时**：保持模块化，使用未占用模块号（J起）。

### 3. 排版约定

#### 颜色系统 (模块D)
- 定义后直接引用，无需重复定义
- 链接颜色已离散化，支持黑白打印
- 标题按章-节-小节逐级加深（`title-chapter` → `title-subsubsection`）

#### 间距调整 (模块E)
- 行距固定 1.2
- 段落不缩进（`\parindent=0em`），靠段间距分段（0.45em）
- 列表缩进梯级：一级2.2em，二级1.8em
- 改动任何间距参数前，检查现有效果，避免破坏对齐

#### 图片处理 (模块F)
- 所有 `\includegraphics` 已包装废弃错误处理
- 图片路径**必须相对路径**：`media/filename.png`
- 缺图不会中断编译，只显示红框提示
- 页眉logo固定高度 24mm（与 `headheight=26mm` 匹配）

#### 标题语法
- 章：`\chapter{\label{ref-XXX}标题名}`（标签编号递增）
- 节：`\section{\label{ref-XXX}标题名}`
- 小节：`\subsection{\label{ref-XXX}标题名}`
- 更小层级：`\subsubsection` 或 `\textbf{标题}:`

### 4. 特殊编译需求

**必须条件**：
```bash
# 使用 XeLaTeX 编译（支持中文和UTF-8）
xelatex 本科升学指南0.5.tex
```

**编译步骤**（生成完整PDF含目录）：
1. 第一次编译：生成 `.toc` 目录文件
2. 第二次编译：识别目录并生成正确的页码

**常见编译失败原因**：
- 使用 pdfLaTeX 而非 XeLaTeX → 中文乱码
- 图片路径错误或相对路径计算不当 → 显示占位框（可接受）
- ctex宏包版本过旧 → CJK字体问题

### 5. 内容维护约定

**文档类型**：
- 官方政策部分：需版本标注和更新日期
- 经验分享部分：保留原作者身份、适用届别（如"2018级"）
- 流程说明：用结构化列表+详细步骤

**更新入口**：
- GitHub：`https://github.com/knight-zmz/Liferguide`
- 反馈问卷：腾讯问卷链接（文档中已置入）

**保留元素**（勿删除）：
- 前言章节（`\chapter{\label{ref-001}前言｜阅读说明与使用边界}`）
- 微信公众号QR码（`media/image1.png` 和 `image2.jpeg`）
- 葫芦娃logo和页眉设置

## 常见操作速查

| 操作 | 文件位置 | 方式 |
|------|--------|------|
| 修改正文内容 | 行 134+ (mainmatter后) | 直接编辑tex代码 |
| 添加新章节 | 行末 | `\chapter{\label{ref-NNN}...}` |
| 更改颜色 | 行 54-63 (模块D) | 修改RGB值，重新编译 |
| 调整行距/缩进 | 行 80-97 (模块E) | 修改参数，检查全文效果 |
| 替换图片 | `media/` 目录 | 保持文件名，或更新.tex中的引用 |
| 修复编译警告 | `.log` 文件 | 检查underfull/overfull box，可能需调整内容分页 |

## 协作工作流

1. **本地编辑**：修改 `.tex` 文件，定期编译验证
2. **版本控制**：仅提交 `.tex` 文件和 `media/` 目录
3. **PR检查**：编译测试无错误，内容逻辑清晰
4. **发布**：编译最终 `.pdf`，但不提交到仓库（`.gitignore` 已排除）

## 持续发布流水线（CI/CD）

### 1. 工作流概览

项目已配置 GitHub Actions 自动化构建：
```
本地修改 lifeguide.tex 
    ↓
执行 git push 到主分支
    ↓
GitHub Actions 触发编译任务
    ↓
自动编译 PDF + 转换 HTML
    ↓
推送成品到 gh-pages 分支
    ↓
GitHub Pages 自动发布网站
```

### 2. 工作流文件位置

**主配置**：[`.github/workflows/build.yml`](.github/workflows/build.yml)

**关键步骤**：
1. **签出代码**：Checkout 最新源文件
2. **安装 TeX Live**：包含 XeLaTeX、ctex 等全套宏包
3. **编译 PDF**：两次 xelatex 编译（第一次生成`.toc`目录，第二次生成正确页码）
4. **转换 HTML**：make4ht + tex4ht（可选，失败不中断流程）
5. **生成主页**：创建友好的在线首页（index.html）
6. **部署到 Pages**：自动推送至 `gh-pages` 分支

### 3. 本地编译脚本

#### Linux/macOS：使用 `build.sh`
```bash
chmod +x build.sh              # 首次需要赋予执行权限
./build.sh all                 # 编译 PDF + HTML
./build.sh pdf                 # 仅编译 PDF
./build.sh clean               # 清理临时文件
./build.sh help                # 查看完整帮助
```

#### Windows：使用 `build.ps1`
```powershell
# PowerShell 需要允许脚本执行（管理员模式）：
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# 然后运行：
.\build.ps1 -Command all       # 编译 PDF + HTML
.\build.ps1 -Command pdf       # 仅编译 PDF
.\build.ps1 -Command clean     # 清理临时文件
```

**脚本特点**：
- 自动检测 XeLaTeX 与 tex4ht 是否可用
- 两次 LaTeX 编译确保目录页码准确
- HTML 转换失败时仍生成 PDF（非阻塞）
- 临时文件自动清理

### 4. 触发工作流的条件

工作流在以下条件自动触发（`.github/workflows/build.yml` 中配置）：
- **分支**：`main` 或 `master`
- **文件变动**：
  - `lifeguide.tex` 文件修改
  - `media/` 目录下任何文件修改
  - `.github/workflows/build.yml` 本身修改

### 5. 发布目录结构

编译完成后，`gh-pages` 分支中的内容：
```
build/
├── index.html              # 主页（在线入口）
├── lifeguide.pdf           # PDF 成品
└── html/
    └── lifeguide.html      # HTML 版本（可选）
```

**网站配置**：Settings → Pages → 选择 `gh-pages` 分支作为发布源

### 6. 常见操作与故障排查

| 场景 | 处理方法 |
|------|--------|
| `XeLaTeX` 找不到 | 本地：安装 TeX Live；Actions：自动处理 |
| PDF 编译失败但需要调试 | 检查 `.log` 文件，或在本地运行 `./build.sh pdf 2>&1 \| tee build.log` |
| HTML 转换失败 | tex4ht 非必选，PDF 仍会生成；可选择不转换 |
| GitHub Pages 不更新 | 检查：Settings → Pages 发布源是否选择 `gh-pages` 分支 |
| 中文显示乱码 | 确保源文件 UTF-8 编码，XeLaTeX + ctex 已安装 |

### 7. 后续维护建议

对于持续维护者（AI 或人类）：

**发布流程**：
1. 修改 `lifeguide.tex` 内容
2. 执行 `git add lifeguide.tex && git commit -m "描述变更"` 
3. 执行 `git push origin main` 或 `master`
4. 自动触发 GitHub Actions 编译
5. 访问 GitHub Pages 网站验证成果

**版本管理建议**：
- 每年重大更新时考虑打 Git tag（如 `v2024.1`）
- `.gitignore` 已排除中间文件和 PDF，仅提交源问件
- 使用有意义的 commit 信息便于追踪变更历史

**备选方案**（如 GitHub Actions 受限）：
- 本地编译后手动提交 PDF 到 gh-pages 分支
- 使用其他 CI 平台（GitLab CI、Gitea、Drone 等）

## 参考资源

- **XeLaTeX 文档**：https://tug.org/xetex/
- **CTeX 包**：用于中文支持和字体管理
- **KOMA-Script**：使用的文档类 `scrbook`
- **GitHub Actions 官方文档**：https://docs.github.com/en/actions
- **GitHub Pages 官方文档**：https://pages.github.com/
- **tex4ht 官方网站**：https://www.tug.org/tex4ht/
