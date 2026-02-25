# 本科升学路径指南（Liferguide）

[![Build and Deploy](https://github.com/knight-zmz/Liferguide/actions/workflows/build.yml/badge.svg)](https://github.com/knight-zmz/Liferguide/actions/workflows/build.yml)
[![LICENSE](https://img.shields.io/badge/license-Internal%20Use-brightgreen)](LICENSE)

## 📖 项目简介

这是一份针对 **吉林大学生命科学学院** 本科学生的升学路径指南，涵盖：

- **保研（推荐免试）路线**：从资格认定、流程分析、导师选择一整套完整框架
- **考研路线**：招生政策、院校选择等内容持续更新中
- **学长学姐经验**：20+ 位毕业生的真实经历与建议分享

**核心特点**：
- 📝 使用 **XeLaTeX** 排版，支持中文与精细排版
- 🔄 **自动化发布流水线**：一键编译→发布，无需手动干预
- 🌐 **在线阅读**：GitHub Pages 实时展示最新版本
- 📦 **版本控制**：完整的历史记录与变更追踪

---

## 🚀 快速开始

### 在线阅读
- **首页**：[本科升学路径指南总导航栏](https://knight-zmz.github.io/Liferguide/)
- **PDF 下载**：[最新版 PDF](https://knight-zmz.github.io/Liferguide/lifeguide.pdf)

### 本地编译

#### 前置要求
- Linux/macOS：`texlive-xetex` + `texlive-fonts-recommended` 等
- Windows：[TeX Live](https://tug.org/texlive/) 或 Chocolatey (`choco install texlive`)
- 可选：`tex4ht`（HTML 转换）

#### 编译命令

**Linux/macOS：**
```bash
chmod +x build.sh
./build.sh all        # 编译 PDF + HTML
./build.sh pdf        # 仅编译 PDF
./build.sh clean      # 清理临时文件
```

**Windows PowerShell：**
```powershell
.\build.ps1 -Command all
.\build.ps1 -Command pdf
.\build.ps1 -Command clean
```

---

## 📁 项目结构

```
Liferguide/
├── lifeguide.tex                   # 主源文件（2000+ 行）
├── media/                          # 媒体资源目录
│   ├── image1.png - image24.png   # 配图
│   └── 葫芦娃logo.jpg              # 页眉 logo
├── .github/
│   ├── workflows/
│   │   └── build.yml              # GitHub Actions 自动化配置
│   └── copilot-instructions.md    # AI 开发指南
├── build.sh                        # Linux/macOS 编译脚本
├── build.ps1                       # Windows 编译脚本
├── .gitignore                      # Git 忽略规则
├── README.md                       # 本文件
└── LICENSE                         # 许可证
```

---

## 🔄 自动发布流程

```
修改源文件 lifeguide.tex
    ↓
git push 到 main/master 分支
    ↓
GitHub Actions 自动触发（见 .github/workflows/build.yml）
    ↓
编译 XeLaTeX → PDF
    ↓
转换为 HTML（可选）
    ↓
部署到 gh-pages 分支
    ↓
GitHub Pages 自动发布
    ↓
读者访问最新版本
```

### 工作流细节

**自动化任务**（`build.yml`）：
1. **两次 XeLaTeX 编译**：确保目录与页码正确
2. **中文支持**：ctex 宏包自动处理中文排版
3. **HTML 转换**：tex4ht 可选转换（失败不阻塞 PDF 生成）
4. **GitHub Pages 部署**：自动推送至 `gh-pages` 分支

**触发条件**：
- 推送到 `main` / `master` 分支
- 修改 `lifeguide.tex` 或 `media/` 目录
- 修改 `.github/workflows/build.yml` 本身

---

## ✏️ 编辑与维护

### 对于编辑者

1. **克隆仓库**
   ```bash
   git clone https://github.com/knight-zmz/Liferguide.git
   cd Liferguide
   ```

2. **编辑源文件**
   ```bash
   # 编辑 lifeguide.tex（文本编辑器或 VS Code + LaTeX Workshop 扩展）
   vim lifeguide.tex
   ```

3. **本地验证**
   ```bash
   ./build.sh pdf    # 编译检查
   ```

4. **提交并发布**
   ```bash
   git add lifeguide.tex
   git commit -m "chore: 更新内容描述"
   git push origin main
   # → 自动触发 GitHub Actions，完毕！
   ```

### 模块化编辑规范

源文件已使用模块化注释系统：
```tex
% region 模块X：模块名称
\usepackage{...} 
% endregion 模块X：模块名称
```

**已有模块（A-I）**：
- **A**：页面与引擎基础设置
- **B**：核心功能宏包
- **C**：排版增强宏包
- **D**：颜色系统
- **E**：全局排版预设
- **F**：图片容错机制
- **G-I**：正文部分

**添加新内容**：保持模块化，使用未占用模块号（J 起）

### 常见编辑任务

| 任务 | 位置 | 工具 |
|------|------|------|
| 修改标题颜色 | 模块 D（54-63 行） | RGB 值 |
| 调整行距 | 模块 E（80-97 行） | `\setstretch{值}` |
| 添加章节 | 文件末尾 | `\chapter{\label{ref-XXX}...}` |
| 替换图片 | `media/` 目录 | 保持文件名或更新引用 |
| 修改页眉 logo | 模块 I（灵活配置） | 更改高度、文件路径 |

---

## 📊 项目统计

| 指标 | 数值 |
|------|------|
| 源文件行数 | 2000+ |
| 章节数量 | 55+ |
| 图片数量 | 24 |
| 编译引擎 | XeLaTeX |
| 发布平台 | GitHub Pages |

---

## 📢 更新与反馈

本指南是一份 **持续更新的资料**，欢迎：

- 📝 **提交经验**：PR 或邮件分享你的经历
- 🐛 **报告问题**：Issue 反馈内容错误或排版问题
- 💡 **建议改进**：讨论板块功能需求
- 📸 **补充资料**：新的图表、表格或经验分享

### 反馈渠道
- **GitHub Issues**：[报告问题](https://github.com/knight-zmz/Liferguide/issues)
- **Pull Requests**：[提交改进](https://github.com/knight-zmz/Liferguide/pulls)
- **微信公众号**：「学生物的葫芦娃」（扫描封面二维码）

---

## 📄 许可证与使用条款

```
本资料为吉林大学生命科学学院学生内部交流材料，
仅供学院内交流使用，不用于商业用途，不外借、不外传。
```

**对于使用者**：
- ✅ 学院内个人学习、经验参考
- ✅ 在指导下推荐给同学
- ❌ 公开发表或商业利用（需获得原作者同意）

**对于贡献者**：
- 提交内容视为同意上述许可安排
- 将标记贡献者身份（如年级、所在班级等）

---

## 🛠️ 技术栈

| 组件 | 版本/说明 |
|------|---------|
| **LaTeX 引擎** | XeLaTeX（UTF-8 + 中文支持） |
| **文档类** | KOMA-Script `scrbook` |
| **中文支持** | CTeX 宏包 |
| **CI/CD** | GitHub Actions |
| **发布平台** | GitHub Pages |
| **HTML 转换**（可选） | tex4ht + make4ht |

---

## 📚 相关资源

- [XeLaTeX 官方](https://tug.org/xetex/)
- [CTeX 项目](https://www.ctan.org/pkg/ctex)
- [GitHub Actions 文档](https://docs.github.com/actions)
- [GitHub Pages 指南](https://pages.github.com/)

---

## 👥 核心维护者

- **发起**：「学生物的葫芦娃」团队（2018 级吉大生科）
- **整理**：真知棒 & 学长学姐团队
- **技术**：CI/CD 自动化部署

---

## 🙏 致谢

感谢所有曾参与経验分享、反馈建议的吉大生科人。你们的支持让这本指南能够持续生长。

**特别感谢**：
- 所有提供经验分享的毕业生（18-22 级）
- LaTeX 排版与自动化工具的开发者社区
- GitHub 平台与开源生态

---

## 📞 联系方式

- **邮件**：[GitHub Issues 区留言](https://github.com/knight-zmz/Liferguide/issues)
- **微信公众号**：学生物的葫芦娃救爷爷
- **GitHub**：[knight-zmz/Liferguide](https://github.com/knight-zmz/Liferguide)

---

**最后更新**：2026 年 2 月 25 日  
**当前版本**：1.1（持续更新中）

