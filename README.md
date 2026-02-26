# 本科升学路径指南（Liferguide）

[![Build and Deploy](https://github.com/knight-zmz/Liferguide/actions/workflows/build.yml/badge.svg)](https://github.com/knight-zmz/Liferguide/actions/workflows/build.yml)
[![LICENSE](https://img.shields.io/badge/license-Internal%20Use-brightgreen)](LICENSE)

> 吉林大学生命科学学院本科生升学全流程指南  
> 涵盖保研、考研路线与 20+ 位学长学姐经验分享

---

## 📖 项目简介

本指南专为 **吉林大学生命科学学院** 本科学生打造，提供：

- **保研路线**：资格认定、流程分析、导师选择完整框架
- **考研路线**：招生政策、院校选择等内容（持续更新）
- **真实经验**：18-22 级毕业生的升学经历与建议

**技术特色**：
- 📝 **高质量排版**：XeLaTeX 引擎，专业中文排版
- 🔄 **自动化发布**：修改源文件 → 自动编译 → 即时更新
- 🌐 **多端阅读**：PDF 下载 + 在线 HTML 阅读

---

## 🚀 快速开始

### 📚 在线阅读
- **主页导航**：[https://knight-zmz.github.io/Liferguide/](https://knight-zmz.github.io/Liferguide/)
- **PDF 下载**：[lifeguide.pdf](https://knight-zmz.github.io/Liferguide/lifeguide.pdf)
- **HTML 在线版**：[在线阅读](https://knight-zmz.github.io/Liferguide/html/lifeguide.html)

### 💻 本地编译

**前置要求**：安装 TeX Live（包含 XeLaTeX）  
- Linux/macOS：`sudo apt-get install texlive-xetex texlive-fonts-recommended` 或 `brew install texlive`
- Windows：[TeX Live 官网](https://tug.org/texlive/) 或 `choco install texlive`

**编译命令**：
```bash
# Linux/macOS
./build.sh pdf        # 编译 PDF
./build.sh all        # 编译 PDF + HTML
./build.sh clean      # 清理临时文件

# Windows PowerShell
.\build.ps1 -Command pdf
.\build.ps1 -Command all
.\build.ps1 -Command clean
```

---

## 📁 项目结构

```
Liferguide/
├── lifeguide.tex           # 主文档源文件（2000+ 行）
├── media/                  # 图片资源（logo、配图等）
├── web/                    # 在线阅读样式与脚本
│   ├── lifeguide.css      # 自定义样式
│   └── postprocess_html.py # HTML 后处理
├── .github/workflows/
│   └── build.yml          # CI/CD 自动化配置
├── build.sh / build.ps1   # 跨平台编译脚本
└── README.md              # 本文件
```

---

## 🤝 贡献指南

我们欢迎各种形式的贡献！

### 💡 如何参与
- **分享经验**：提交 PR 增加你的升学故事
- **报告问题**：通过 [Issues](https://github.com/knight-zmz/Liferguide/issues) 反馈错误或排版问题
- **完善内容**：更新政策、补充流程细节

### 标准流程
```bash
# 1. Fork 并克隆仓库
git clone https://github.com/你的用户名/Liferguide.git
cd Liferguide

# 2. 编辑源文件
vim lifeguide.tex

# 3. 本地编译验证
./build.sh pdf

# 4. 提交更改
git add lifeguide.tex
git commit -m "docs: 补充2026年保研政策更新"
git push origin main

# 5. 在 GitHub 上创建 Pull Request
```

详细开发规范请参考 [.github/copilot-instructions.md](.github/copilot-instructions.md)

---

## 🔄 自动化发布

本项目已配置 GitHub Actions，实现全自动发布流程：

```
修改 lifeguide.tex → git push → GitHub Actions 自动编译 → 发布到 GitHub Pages
```

**触发条件**：
- 推送到 `main` 或 `master` 分支
- 修改 `lifeguide.tex`、`media/` 或 `web/` 目录

**查看构建状态**：[Actions 页面](https://github.com/knight-zmz/Liferguide/actions)

---

## 🛠️ 技术栈

| 组件 | 说明 |
|------|------|
| **LaTeX 引擎** | XeLaTeX（UTF-8 + 中文支持） |
| **文档类** | KOMA-Script `scrbook` |
| **中文支持** | CTeX 宏包 |
| **CI/CD** | GitHub Actions |
| **在线阅读** | tocbot（可折叠目录）+ 自定义 CSS |
| **发布平台** | GitHub Pages |

---

## 📄 使用许可

```
本资料为吉林大学生命科学学院内部交流材料
仅供学院内学习使用，不用于商业用途，不外传
```

**允许**：✅ 学院内个人学习与经验参考  
**禁止**：❌ 公开发表或商业利用（需获得授权）

---

## 📞 联系我们

- **GitHub Issues**：[报告问题](https://github.com/knight-zmz/Liferguide/issues)
- **微信公众号**：学生物的葫芦娃救爷爷
- **项目地址**：[knight-zmz/Liferguide](https://github.com/knight-zmz/Liferguide)

---

## 🙏 致谢

感谢所有分享经验的学长学姐（18-22 级）与贡献者，  
感谢 LaTeX 开源社区与 GitHub 平台的技术支持。

**维护团队**：学生物的葫芦娃（社团）| 真知棒 & 学长学姐团队  
**最后更新**：2026 年 2 月 26 日

## 🔗 友情链接

- **现代科研指北s**：(https://github.com/yufree/sciguide)
