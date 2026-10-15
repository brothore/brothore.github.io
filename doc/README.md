# 白杨博客使用说明

维护日期：2026-10-15。

## 目录与发布规则

正式仓库：`D:/blog/baiyang.github.io`。

网站：https://brothore.github.io/

| 内容 | 本地位置（相对仓库根目录） |
| --- | --- |
| 文章 | `site/src/content/posts/` |
| 关于页 | `site/src/content/spec/about.md` |
| 名称、简介、头像、主题色和导航 | `site/src/config.ts` |
| 页面组件 | `site/src/components/` |
| 页面布局 | `site/src/layouts/` |
| 自动发布流程 | `.github/workflows/deploy.yml` |
| 待办与已选方案 | `PENDING-CHANGES.md` |

`D:/blog/fuwari-toolbar-preview` 是独立的本地设计预览，不是正式文章目录。已选定的新工具栏位置与导航卡方案尚未合入正式源码，也未部署。

推送正式仓库的 `main` 分支会触发发布。只保存本地文件不会发布。本站只发布 Actions 生成的 `site/dist`，不发布整个仓库。

## 推荐工具

- VS Code：编辑 Markdown、配置与代码。
- GitHub Desktop：同步、检查变更、提交和推送，无需记忆 Git 命令。
- 浏览器：本地预览与线上检查。

## 一次性准备

本地推荐与自动构建一致：Node.js 22、pnpm 9.14.4。

PowerShell 中执行：

```powershell
npm install -g pnpm@9.14.4
Set-Location -LiteralPath 'D:/blog/baiyang.github.io/site'
pnpm install --frozen-lockfile
```

已安装好依赖的电脑不必每次重新安装。更换电脑或依赖发生变化时再安装。

GitHub Desktop 登录 GitHub，通过 File → Add local repository 添加 `D:/blog/baiyang.github.io`。这是已有仓库，不必创建新仓库。

## 新建文章与 Markdown 格式

在 `site/src/content/posts/` 新建 `rag-notes.md`，使用 UTF-8 编码：

````markdown
---
title: "一次 RAG 分块实验"
published: 2026-10-15
description: "比较两种分块方式，记录结果和思考。"
tags: [大模型, RAG, 技术笔记]
category: 技术实践
draft: false
---

这里写开头。

## 遇到的问题

这里描述问题。

## 实验过程

- 第一种方法
- 第二种方法

```python
print("Hello, blog!")
```

## 我的结论

这里写结果和判断。
````

两条 `---` 之间是 YAML 文章信息，下方是 Markdown 正文。日期不加引号，标题与摘要建议加双引号。YAML 缩进使用空格。

| 字段 | 含义 |
| --- | --- |
| `title` | 文章标题 |
| `published` | 发布日期，格式 YYYY-MM-DD |
| `updated` | 可选，最后更新日期，格式同上 |
| `description` | 首页卡片摘要 |
| `tags` | 多个并列标签，例如 `[大模型, RAG]` |
| `category` | 一个分类 |
| `draft` | `true` 不展示，`false` 发布 |
| `image` | 可选封面图片路径 |

长文和短文都支持；目前使用同一种文章布局，尚无专门的短记时间流。

文件名建议用简短英文，以保持链接稳定。`rag-notes.md` 通常对应 `/posts/rag-notes/`。文章发布后修改标题不必修改文件名；改文件名可能使旧链接失效。

也可以在 `site/` 运行 `pnpm new-post rag-notes` 创建文章骨架。

草稿虽然不在网站展示，推送至公开仓库后，其 Markdown 源码仍可被他人查看。不要把私人内容当作公开仓库里的草稿保存。

## 图片

建议把文章和图片放进同一个文件夹：

```text
site/src/content/posts/rag-notes/
├── index.md
└── result.png
```

正文引用：`![实验结果](./result.png)`。

封面可在文章信息中填写 `image: ./result.png`。不要引用自己电脑上的 D 盘或临时文件路径。

## 本地预览与检查

```powershell
Set-Location -LiteralPath 'D:/blog/baiyang.github.io/site'
pnpm dev
```

打开终端提示的本地网址，通常为 `http://localhost:4321/`；端口被占用时以终端实际输出为准。保存内容后预览会自动更新。结束预览按 Ctrl+C。

正式构建与搜索预览：

```powershell
pnpm check
pnpm build
pnpm preview
```

开发预览中的搜索可能不可用；构建后预览才能完整验证 Pagefind 搜索。

仓库根目录还有 `./publish.ps1`，用于本地检查、构建和生成搜索索引；名称虽叫 publish，但不会自动推送或部署。

## 日常发布：GitHub Desktop

1. 写作前点击 Fetch origin；有远程更新时点击 Pull origin。
2. 编辑正式文章目录中的 Markdown，保存并本地预览。
3. 在 Desktop 的 Changes 中检查变更，勾选本次需要提交的文件。
4. 填写 Summary，例如“新增 RAG 实验笔记”。
5. 点击 Commit to main：保存至本地版本历史。
6. 点击 Push origin：上传至 GitHub 并触发网站发布。
7. 在仓库 Actions 查看最新的 Deploy Fuwari to GitHub Pages。
8. 等待 build 和 deploy 均成功后检查网站；必要时 Ctrl+F5 刷新。

Actions：https://github.com/brothore/brothore.github.io/actions

构建失败时先看失败步骤的日志，修正后重新推送；不要通过手工复制 HTML 或 dist 来绕开自动流程。

## 命令行发布（可选）

```powershell
Set-Location -LiteralPath 'D:/blog/baiyang.github.io'
git status
git diff
git add -- site/src/content/posts/rag-notes.md
git commit -m "Add RAG experiment notes"
git push origin main
```

示例只提交指定文章；有图片时也需添加图片。优先检查并明确选择文件，避免提交尚未确认的其他改动。

## 修改、删除与回退

- 修改文章：编辑原文件，需要时更新 `updated`，再按正常流程提交推送。
- 删除文章：删除对应 Markdown 后提交推送；有外部链接时应考虑保留说明或配置重定向。
- 撤回发布：优先在 GitHub Desktop 的 History 对相应提交使用 Revert，并再次推送；不要随意强推历史。
- 不提交 `node_modules`、`site/dist`、本地临时文件或敏感内容。
- 主题和依赖升级与写文章分开进行，先在本地检查再发布。

## 私有仓库与公开网站

可以做到，但取决于方案：

| 方案 | 源码仓库 | 网站 | 条件 |
| --- | --- | --- | --- |
| 当前 GitHub Free + Pages | 公开 | 公开 | 免费 |
| GitHub Pro + Pages | 可私有 | 可公开 | 个人账号需要相应付费权益 |
| 私有源码仓库 + 公开 Pages 发布仓库 | 私有 | 公开 | 需要单独配置跨仓库构建与发布；公开仓库只放构建产物 |

私有源码可隐藏 Markdown、维护文档和版本历史；公开网站的正文、图片、HTML、CSS、JS 仍可被访问者获取。

尚未确认账户权益和迁移方案前，不要直接将现有仓库改为 Private，以免失去 Pages 服务。本次没有调整仓库可见性。

官方说明：https://docs.github.com/en/pages/getting-started-with-github-pages/what-is-github-pages

GitHub Desktop 官方说明：

- https://docs.github.com/en/desktop/adding-and-cloning-repositories/adding-a-repository-from-your-local-computer-to-github-desktop
- https://docs.github.com/en/desktop/making-changes-in-a-branch/committing-and-reviewing-changes-to-your-project-in-github-desktop
