# jsDelivr 官网

> https://www.jsdelivr.com

# 先决条件

必须要创建一个 GitHub 仓库, 并且存放你需要加速的文件.

# 创建版本号(Releases)

进入仓库并创建 Releases:

![1](https://github.com/user-attachments/assets/d035adc5-9486-4288-9f9c-caf9163d90ba)

名称建议规范一点.

![2](https://github.com/user-attachments/assets/6ca6a2e3-edf4-49b9-afe8-6d8b0d54a34b)

# 创建标签(Tags)

创建 Tags 和 Releases 步骤一样.

# 使用方法

例如:

`https://cdn.jsdelivr.net/gh/[GitHub用户名]/[仓库名]@[版本号或者标签]/[文件路径]`

https://cdn.jsdelivr.net/gh/gjken/gjken.github.io/static/primer.min.css

| Key | Value
| - | -
| [GitHub 用户名] | 写你的 GitHub 用户名.
| [仓库名]  | 写你的 GitHub 仓库名称.
| [标签或分支] | 例如 `https://cdn.jsdelivr.net/gh/jquery/jquery@3.2.1/dist/jquery.min.js`<br>都不写默认访问最新版本.</br>
| [文件路径] | 写你的 GitHub 仓库文件路径.

> [!Important]
> 省略版本号, 直接访问最新的资源, 不推荐在生产环境中使用.
> 如果源文件更新, cdn 加速后的文件内容不会更新那么快, 一般有12小时的延迟, ~~大概?~~

# 其它替代地址

Jsdelivr 国内的 CDN 服务被 DNS 污染了, 被指向了Google, Twitter 和 Facebook 的 IP 地址, 导致使用 CDN 服务加速的链接访问失败.

```css
fastly.jsdelivr.net
gcore.jsdelivr.net
testingcf.jsdelivr.net
test1.jsdelivr.net
```