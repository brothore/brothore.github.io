# 部署核查

上游版本：saicaca/fuwari 6d39b0d。

上次使用 main / root 发布手工构建结果，已成功部署。现在改为 GitHub Actions，仅发布 site/dist，避免源码与历史构建产物混用。

已核对首页、文章页、归档、关于页、搜索与导航链接。新会话中主页链接指向 / 并显示 Fuwari。没有取得用户浏览器日志，旧首页的具体缓存原因尚未确认。

## 与上游的差异

- astro.config.mjs：只改域名。
- src/config.ts：白杨、中文、简介、移除演示社交链接，关闭未选择的授权声明。
- 内容：开站文章与关于页，移除演示文章。
- Layout.astro 与 theme.css：统一加载原有主题样式，修正 Tailwind 构建问题。
- ArchivePanel.svelte 与 LightDarkSwitch.svelte：修正属性类型与默认值。

文章路由、首页路由、导航、回到顶部按钮和文章前后导航未修改。
官方演示包含多篇长文章、标题目录、封面与版权区；当前只有一篇短文，所以相关区域不出现。

## 验证

本地构建和 Astro 类型检查通过。发布时检查 Actions 的 deploy 成功后，再验证线上页面。
