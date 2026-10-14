# 白杨的博客

网站：https://brothore.github.io/

基于 [Fuwari](https://github.com/saicaca/fuwari)，上游版本 6d39b0d。
保留模板的布局与功能，仅配置中文、网名、简介和初始文章。

## 维护

- `site/`：Astro 源码。
- `site/src/config.ts`：基本信息与配色。
- `site/src/content/posts/`：Markdown 文章。
- `site/src/content/spec/about.md`：关于页。
- 根目录网页：构建结果，供 GitHub Pages 的 main / root 发布。

依赖安装：在 `site/` 运行 `pnpm install --frozen-lockfile`。
更新文章后，在仓库根目录运行 `./publish.ps1`，再提交并推送。

## 模板兼容修正

补充上游样式的统一加载入口，并修正两个 Svelte 组件的属性类型与默认值。
没有添加短记功能、项目页或改变主题布局。

Fuwari 的 MIT 许可证保留在 `site/LICENSE`。
