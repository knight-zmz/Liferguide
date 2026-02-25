# CI/CD 部署完成清单 ✓

**部署日期**：2026年2月25日  
**部署状态**：✅ 完成  
**下一步**：按照本文档指导在 GitHub 上完成配置

---

## 已完成的工作

### 1. ✅ 文件重命名与结构化
- [x] 主源文件改名：`本科升学指南0.5.tex` → `lifeguide.tex`
- [x] 创建新版本 `lifeguide.tex` 包含完整内容
- [x] 保持 `media/` 目录和所有图片资源

### 2. ✅ 自动化编译脚本
- [x] **Linux/macOS**：`build.sh` （包含 PDF、HTML、清理命令）
- [x] **Windows**：`build.ps1` （PowerShell 版本）
- [x] 脚本包含完整的错误检查和帮助信息

### 3. ✅ GitHub Actions 工作流
- [x] **文件**：`.github/workflows/build.yml`
- [x] **功能**：
  - 自动检测 `lifeguide.tex` 和 `media/` 变化
  - 两次 XeLaTeX 编译（确保目录和页码）
  - 可选 HTML 转换（tex4ht）
  - 自动部署到 `gh-pages` 分支
  - 生成友好的首页 `index.html`

### 4. ✅ 文档与指南
- [x] **项目主文档**：`README.md` （完整的使用指南）
- [x] **开发者指南**：`.github/copilot-instructions.md` （AI 维护指南）
- [x] **快速开始部分**：包含编译命令和相关链接

### 5. ✅ 其他配置
- [x] `.gitignore` 已配置（排除 PDF 和编译中间文件）
- [x] 工作流触发条件已配置
- [x] 部署目标为 `gh-pages` 分支

---

## 📋 GitHub 配置清单（需手动完成）

### 第1步：在 GitHub 上启用 GitHub Pages

1. 打开仓库：https://github.com/knight-zmz/Liferguide
2. 进入 **Settings** → **Pages**
3. **Source** 设置为 `gh-pages` 分支
4. 点击 **Save**

```
✓ 预期结果：网站将在 https://knight-zmz.github.io/Liferguide 发布
```

### 第2步：验证工作流权限

1. **Settings** → **Actions** → **General**
2. **Workflow permissions** 选择：
   - ☑ Read and write permissions
   - ☑ Allow GitHub Actions to create and approve pull requests
3. 点击 **Save**

```
✓ 预期结果：GitHub Actions 可以自动推送到 gh-pages 分支
```

### 第3步：（可选）添加自定义域

如果你有自定义域 `liferguide.com`，可在 Settings → Pages 配置  
如果没有，保持默认的 `knight-zmz.github.io/Liferguide` 即可

---

## 🧪 测试流程（部署后验证）

### 本地测试

```bash
# 1. 克隆仓库
git clone https://github.com/knight-zmz/Liferguide.git
cd Liferguide

# 2. 本地编译 PDF
./build.sh pdf      # Linux/macOS
.\build.ps1 -Command pdf  # Windows

# 3. 验证输出
ls -lh lifeguide.pdf
# 输出示例：-rw-r--r-- 1 user group 15M lifeguide.pdf
```

### 自动化测试

```bash
# 1. 修改 lifeguide.tex（任意小改动测试）
echo "% test" >> lifeguide.tex

# 2. 提交并推送
git add lifeguide.tex
git commit -m "test: trigger CI/CD"
git push origin main

# 3. 观察 GitHub Actions
进入 https://github.com/knight-zmz/Liferguide/actions
等待工作流完成（约 5-10 分钟）

# 4. 验证发布
访问 https://knight-zmz.github.io/Liferguide
- 检查首页是否显示
- 检查 PDF 下载链接是否有效
```

---

## 📊 现有文件对应表

| 文件/目录 | 作用 | 说明 |
|---------|------|------|
| `lifeguide.tex` | 主源文件 | 完整的 2000+ 行 LaTeX 文档 |
| `.github/workflows/build.yml` | CI/CD 配置 | GitHub Actions 自动化脚本 |
| `build.sh` + `build.ps1` | 本地编译 | 跨平台编译脚本 |
| `README.md` | 项目说明 | 用户端完整指南 |
| `.github/copilot-instructions.md` | 开发指南 | AI 维护者快速上手手册 |
| `media/` | 资源目录 | 24 个图片文件 |
| `.gitignore` | Git 配置 | 忽略编译生成文件 |

---

## 🚀 每次更新的标准流程

```bash
# 1. 编辑源文件
vim lifeguide.tex

# 2. 本地验证（可选但推荐）
./build.sh pdf

# 3. 提交更改
git add lifeguide.tex
git commit -m "chore: 更新内容说明"

# 4. 推送到 GitHub
git push origin main

# 5. (自动) GitHub Actions 编译并发布
# → 无需手动干预！

# 6. 验证网站
# 访问 https://knight-zmz.github.io/Liferguide
```

---

## ⚠️ 常见问题与解决

### Q1：本地编译失败，显示 "XeLaTeX not found"
**A**：缺少 TeX Live  
```bash
# Linux
sudo apt-get install texlive-xetex texlive-fonts-recommended texlive-latex-extra

# macOS
brew install texlive

# Windows
# 访问 https://tug.org/texlive/ 下载安装
# 或使用 Chocolatey: choco install texlive
```

### Q2：GitHub Actions 编译失败
**A**：检查日志  
1. 进入 Actions 标签
2. 点击失败的工作流
3. 展开 "Compile LaTeX to PDF" 步骤
4. 查看错误信息（通常是编码或路径问题）

### Q3：GitHub Pages 没有更新
**A**：检查设置  
1. Settings → Pages
2. 确保 Source 为 `gh-pages` 分支
3. 检查工作流是否成功完成（Actions 标签）

### Q4：如何修改编译配置（如纸张大小、颜色等）？
**A**：修改 `lifeguide.tex` 中的对应模块  
参见 `.github/copilot-instructions.md` 第 3 节"排版约定"

---

## 📞 支持与反馈

- **问题报告**：GitHub Issues
- **改进建议**：GitHub Discussions（如有）
- **微信反馈**：学生物的葫芦娃公众号

---

## ✨ 特别说明

### 为什么使用 `lifeguide.tex` 而不是 `本科升学指南.tex`？
- ASCII 字母便于命令行操作（无需编码转换）
- GitHub Actions 和 CI/CD 更兼容
- 国际化友好
- 文件引用时更简洁

### 为什么要两次编译？
- 第一次：生成 `.toc` 目录文件
- 第二次：LaTeX 根据目录文件生成最终的正确页码
- 这是 LaTeX 文档（尤其包含目录）的标准做法

### 为什么 PDF 从 git 中排除？
- 避免仓库体积膨胀（PDF 通常 10-20 MB）
- 版本控制 PDF 没有意义（二进制文件）
- GitHub Actions 自动生成，无需提交
- 用户从网站或 Releases 下载即可

---

## 🎯 后续计划建议

| 优先级 | 任务 | 时间估计 |
|-------|------|----------|
| 🔴 高 | 验证 GitHub Pages 配置是否成功 | 5 分钟 |
| 🔴 高 | 进行一次完整的 push 测试 | 10 分钟 |
| 🟡 中 | 考虑添加 GitHub Releases（自动生成） | 15 分钟 |
| 🟡 中 | 配置 branch protection rules | 10 分钟 |
| 🟢 低 | 添加其他高级功能（如评论系统） | 可选 |

---

## 📝 版本记录

| 版本 | 日期 | 内容 |
|------|------|------|
| **0.5** | 2026-02-25 | 完成 CI/CD 自动化部署 |
| 0.4 | - | 文档整理与模块化 |
| 0.3 | - | 经验分享汇总 |
| ...  | - | - |

---

**部署完成！🎉**

所有技术配置已就绪，接下来只需在 GitHub 上完成 Pages 设置，  
然后便可享受全自动的"修改源文件 → 自动编译 → 网站更新"的工作流！

如有问题，参考本文档或 `.github/copilot-instructions.md`。
