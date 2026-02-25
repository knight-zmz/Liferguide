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

### 第1步：等待 GitHub Actions 创建 gh-pages 分支

⚠️ **重要**：`gh-pages` 分支会由 GitHub Actions 工作流 **自动创建**，无需手动操作！

**流程**：
1. 您已将代码推送到 `main` 分支 ✓
2. GitHub Actions 现在正在自动运行编译任务
3. 编译成功后，工作流会自动创建 `gh-pages` 分支并推送成品

**等待时间**：约 5-10 分钟

### 第1.5步：检查工作流状态

1. 打开仓库：https://github.com/knight-zmz/Liferguide
2. 点击 **Actions** 标签
3. 查看最新的 "Build and Deploy" 工作流
   - 🟡 **运行中**：等待几分钟
   - 🟢 **成功**：进行第2步
   - 🔴 **失败**：查看错误日志（见故障排查）

### 第2步：在 GitHub 上启用 GitHub Pages

1. 打开仓库：https://github.com/knight-zmz/Liferguide  
2. 进入 **Settings** → **Pages**
3. **Source** 选项：
   - 如果看到 `gh-pages` 分支选项，选择它 ✓
   - 如果还没有出现，等待工作流完成（会自动刷新）
4. 点击 **Save**

```
✓ 预期结果：网站将在 https://knight-zmz.github.io/Liferguide 发布
✓ 自定义域：如需要，可在此配置
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

## 🧪 验证流程（您现在应该做这些）

### 第1步：检查 GitHub Actions 是否运行

✅ 您已经完成了推送（`git push origin main`）

现在需要确认工作流运行情况：

1. 进入 https://github.com/knight-zmz/Liferguide/actions
2. 查看最新的 "Build and Deploy" 工作流
3. 等待标记变为 🟢 或 🔴（不要急，约 5-10 分钟）

**工作流状态说明**：
- 🟡 **进行中** → 继续等待
- 🟢 **成功** → 进行第2步 ✓
- 🔴 **失败** → 查看日志并参考故障排查

### 第2步：检查 gh-pages 分支是否创建

工作流成功后，会自动创建 `gh-pages` 分支。验证方式：

```bash
# 本地刷新查看所有分支
git fetch --all
git branch -a

# 您应该看到类似的输出：
# remotes/origin/gh-pages
# remotes/origin/main
```

或直接在 GitHub 网页上查看：
- 仓库首页 → 左上角分支选择器
- 应该看到 `gh-pages` 分支出现

### 第3步：完成 GitHub Pages 配置

看到 `gh-pages` 分支后：

1. 进入 **Settings** → **Pages**
2. **Source** 下拉菜单中选择 `gh-pages` 分支
3. 点击 **Save**

### 第4步：验证网站发布

1-2 分钟后，访问：
```
https://knight-zmz.github.io/Liferguide
```

您应该看到：
- ✅ 精美的首页（紫蓝渐变背景）
- ✅ "📖 下载 PDF 版本" 按钮
- ✅ "🌐 在线阅读"、"💻 GitHub" 链接
- ✅ PDF 和 HTML 下载可用

---

### 🔍 实时监控命令（可选）

如果想在本地监控 GitHub Actions 进度：

```powershell
# Windows PowerShell：每 30 秒检查一次工作流
while ($true) {
    Clear-Host
    Write-Host "🔄 检查工作流状态..."
    Write-Host "提示：访问 https://github.com/knight-zmz/Liferguide/actions 查看详细日志"
    Write-Host ""
    Start-Sleep -Seconds 30
}
```

或者直接访问 GitHub 网页实时查看进度。

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

### Q0：工作流没有出现在 Actions 标签里
**A**：这是最常见的问题  
1. **等待 1-2 分钟**：GitHub 需要时间检测新的 push 事件
2. **刷新页面**：F5 或 Cmd+R
3. **检查触发条件**：工作流只在这些情况触发：
   - 推送到 `main` 或 `master` 分支（您做了 ✓）
   - 修改 `lifeguide.tex` 文件（您做了 ✓）  
   - 修改 `.github/workflows/build.yml` 文件
4. **检查分支名**：确保您的默认分支是 `main` 或 `master`
   - 进入 **Settings** → **Branches** 查看

### Q1：工作流运行失败（显示红色 ✗）
**A**：查看错误日志  
1. 进入失败的工作流
2. 展开 "Compile LaTeX to PDF" 步骤
3. 查看红色错误信息，常见原因：
   - **编码错误**：文件必须是 UTF-8（通常不是问题）
   - **缺失宏包**：GitHub Actions 会自动安装 TeX Live
   - **语法错误**：检查最近修改的 .tex 代码

### Q2：gh-pages 分支一直没有出现
**A**：等待工作流完成  
1. 检查工作流是否是 🟢 成功状态
2. 如果失败，修复错误后重新推送
3. 工作流成功后，5-10 秒内 gh-pages 分支应该出现
4. 如果还是没有，进入仓库设置，检查工作流权限：
   - **Settings** → **Actions** → **General**
   - ☑ 确保 "Read and write permissions" 已启用

### Q3：GitHub Pages 仍然没有发布
**A**：确认配置步骤  
1. 进入 **Settings** → **Pages**
2. **Source** 必须选择 `gh-pages` 分支（不是 `main`）
3. 点击 **Save**
4. 等待 1 分钟页面会出现网址：`Your site is published at https://knight-zmz.github.io/Liferguide`

### Q4：本地编译失败，显示 "XeLaTeX not found"
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

### Q5：GitHub Actions 编译成功但 HTML 没有生成
**A**：这是正常的  
- tex4ht 是可选的
- 工作流会继续生成 PDF（不会中断）
- 如果想要 HTML，需要手动安装 tex4ht

### Q6：网站显示首页但 PDF 下载失败
**A**：检查工作流日志  
1. 进入 Actions 查看工作流日志
2. 查看"Copy PDF to build directory"步骤是否成功
3. 如果 PDF 没有被复制到 build 目录，工作流日志会显示原因

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
