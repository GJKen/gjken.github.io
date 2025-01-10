# 注册 Serv00

注册没什么好说的, gmail+干净一点的ip基本上都可以成功, 这里不多做展开.
收不到邮件信息的估计是邮箱问题. 比如:https://mail.proton.me

# 准备工作

进入 Additional services 选项卡中找到 Run your own applications 项目,
如下图所示, 必须要设置成如图所示的 Enabled.

![](https://github.com/user-attachments/assets/f1035178-d821-4704-85ce-0728cb44869a)

如果不开启这一项, 自己的用户目录下的所有文件都无法添加可执行权限.

# 部署记录

## Alist

### 创建端口

每个账户只能创建3个端口.
其中一个用来反代本地搭建 Alist 的端口, 这里我用 26666 端口.

![](https://github.com/user-attachments/assets/0d7b8337-b3b6-4d36-a257-6fb414bc06c6)

### 创建网站

> Serv00 账号创建好之后默认就有一个网站, 一般是`USERNAME.serv00.net`, 可以随意删除.

下图我写的是自己的域名.

![](https://github.com/user-attachments/assets/6cd71d0d-a0b9-4870-94dc-c43614d621a7)

其中 26666 这个端口是 Alist 服务的端口.

### 网站添加 SSL 证书

站点创建完成后, 点击右边的 SSL 👉 WWW websites 👉 Manage.

![](https://github.com/user-attachments/assets/deb88a16-4e70-4a7d-aa8b-8cf6f37c6294)

点击 Add certificate, 确认好要创建证书的域名, 最后点击 Add 完成创建证书.

![](https://github.com/user-attachments/assets/81770332-00e0-4a12-9abe-b0a38978bbd3)

### 安装 Alist

> [!TIP]
> Alist 官方在 24年8月17日, 增加了 [beta](https://github.com/AlistGo/alist/releases/tag/beta) 版本, 支持 FreeBSD 系统下能够运行的 Alist 可执行文件🎉

Serv00 本身提供的网站托管在`~/domains`路径下, 所以我建议把 Alist 也部署到这个路径下的子目录.

一键创建目录并下载 Alist, 增加执行权限, 复制到终端粘贴使用.

```bash
mkdir -p ~/domains/alist && cd ~/domains/alist && curl -L -o alist.tar.gz https://github.com/AlistGo/alist/releases/download/beta/alist-freebsd-amd64.tar.gz && tar -xzf alist.tar.gz && chomd +x alist
```

### 第一次启动 Alist 生成配置文件

文件下载好后需要先启动一次 Alist, 让它生成配置文件, 此次一定会报错, 请不用在意~

```bash
./alist server
```

### 创建 Alist 所需数据库

回到 Panel 面板, 找到 MySQL 选项卡, 使用 Add database 功能新建一个数据库:

![](https://github.com/user-attachments/assets/1bb33d42-3023-4eaf-9110-9357ffd1adfe)

Database name 和 Username 字段为了方便好记就写 Alist 就行了.

> 密码要求含有大写字母, 小写字母和数字三种字符, 且长度必须超过6个字符.

### 修改配置文件

进入 Panel 面板, 找到 File manager 选项卡, 会如下图的进入文件管理器.

定位这个`config.json`文件, 双击编辑它:

![](https://github.com/user-attachments/assets/217ac434-f85c-4ca7-b649-a746e3d516a2)

我主要修改了`CDN` `database` `scheme`三个部分,

![](https://github.com/user-attachments/assets/ad8bafbc-f342-45b8-8e0f-944f06713078)

<table>
  <tr>
    <td><p>CDN</p></td>
    <td colspan="2">
      <p><span>可以在 <a href="https://alist.nn.ci/zh/config/configuration.html#cdn">Alist</a> 的官方文档找到, 请选择你本地网络连接速度最快的一个.</span></p>
    </td>
  </tr>
  <tr>
    <td rowspan="6">database</td>
    <td>type</td>
    <td>因为我们创建的数据库类型是 mysql, 就写<code class="notranslate">mysql</code>.</td>
  </tr>
  <tr>
    <td>host</td>
    <td>例如我的 serv00 是12, 就写<code class="notranslate">mysql12.serv00.com</code>, 自己看着写.</td>
  </tr>
  <tr>
    <td>port</td>
    <td>mysql 端口, 默认<code class="notranslate">3306</code>.</td>
  </tr>
  <tr>
    <td>user</td>
    <td>填写创建的数据库用户名</td>
  </tr>
  <tr>
    <td>passdowd</td>
    <td>填写创建的数据密码</td>
  </tr>
  <tr>
    <td>name</td>
    <td>填写创建的数据表名称</td>
  </tr>
  <tr>
    <td rowspan="2">scheme</td>
    <td>address</td>
    <td>0.0.0.0</td>
  </tr>
  <tr>
    <td>http_port</td>
    <td>填写创建的端口</td>
  </tr>
</table>

改完之后, 点击 save 保存.

### 再次启动 Alist

回到 SSH 窗口中进行操作.

```bash
./alist server
```

![](https://github.com/user-attachments/assets/fffb55cc-ce5b-4943-8e2c-30580d85edce)

运行正常, 显示的管理员账号的密码一定要记住. 接着使用 Ctrl+c 停止运行.

### 自定义域名绑定

我这边使用 [us.kg](https://nic.us.kg) 的免费域名进行访问 Alist.

因为 serv00 的域名基本上都会被墙, 没办法只能用~~Cloudflare减速器~~跨墙了, ~~CDN 回源加速不会弄.~~

我们进入 https://dash.cloudflare.com

点击添加域, 再输入自己的域名, 选择最底下的 free 计划一路创建.

然后复制 Cloudflare 给的 dns 名称服务器.

![](https://github.com/user-attachments/assets/18a37ecb-fcb1-4ac6-b326-357c9c464070)

然后转到你的域名提供服务商, 添加 dns 记录.

![](https://github.com/user-attachments/assets/73aad798-1830-4bbf-b281-cda074f40485)

如果没问题就可以通过自定义域名访问了.

### Alist 保活

> 因为 Serv00 会不定时杀进程😅, 所以诞生此方案.

我在 Alist 目录下创建了`runAlist.sh`脚本, 内容如下:

```bash
screen -ls | awk 'NR>=2&&NR<=20{print $1}' | awk '{print "screen -S "$1" -X quit"}' | sh
echo "Attempting to start screen session 'alist'"
screen -dmS alist bash -c 'cd ~/domains/alist && ./alist server'
#screen -ls
echo "$(date '+%Y-%m-%d %H:%M:%S')" > ~/domains/alist/logfile.txt
```

转到 panel 面板, 创建 Cron Jobs 定时任务.

我们需要创建一个每小时执行的任务进行保活, 如下图:

![](https://github.com/user-attachments/assets/d15aef00-9874-48ac-b5f4-0c4850b21bcb)

计划任务执行的是我的`runAlist.sh`脚本.

不出意外的话, 隔一段时间进入 Alist 网页需要重新登陆账号, 因为定时脚本会先杀原来的 Alist 进程再重启.

# Serv00+CT8 保活(可TG通知)

> 引用自 [Linux.do](https://linux.do/t/topic/180293)

## 先决条件

- [x] 假设你已经拥有了一个 telegram bot.

## 首先上代码

Worker 代码:

<details><summary>JavaScript Code</summary>

```JavaScript
addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
})

addEventListener('scheduled', event => {
  event.waitUntil(handleScheduled(event.scheduledTime))
})

async function handleRequest(request) {
  return new Response('Worker is running')
}

async function handleScheduled(scheduledTime) {
  const accounts = JSON.parse(ACCOUNTS_JSON)
  const results = await loginAccounts(accounts)
  await sendSummary(results)
}

async function loginAccounts(accounts) {
  const results = []
  for (const account of accounts) {
    const result = await loginAccount(account)
    results.push({ ...account, ...result })
    await delay(Math.floor(Math.random() * 8000) + 1000)
  }
  return results
}

function generateRandomUserAgent() {
  const browsers = ['Chrome', 'Firefox', 'Safari', 'Edge', 'Opera'];
  const browser = browsers[Math.floor(Math.random() * browsers.length)];
  const version = Math.floor(Math.random() * 100) + 1;
  const os = ['Windows NT 10.0', 'Macintosh', 'X11'];
  const selectedOS = os[Math.floor(Math.random() * os.length)];
  const osVersion = selectedOS === 'X11' ? 'Linux x86_64' : selectedOS === 'Macintosh' ? 'Intel Mac OS X 10_15_7' : 'Win64; x64';

  return `Mozilla/5.0 (${selectedOS}; ${osVersion}) AppleWebKit/537.36 (KHTML, like Gecko) ${browser}/${version}.0.0.0 Safari/537.36`;
}

async function loginAccount(account) {
  const { username, password, panelnum, type } = account
  let url = type === 'ct8' 
    ? 'https://panel.ct8.pl/login/?next=/' 
    : `https://panel${panelnum}.serv00.com/login/?next=/`

  const userAgent = generateRandomUserAgent();

  try {
    const response = await fetch(url, {
      method: 'GET',
      headers: {
        'User-Agent': userAgent,
      },
    })

    const pageContent = await response.text()
    const csrfMatch = pageContent.match(/name="csrfmiddlewaretoken" value="([^"]*)"/)
    const csrfToken = csrfMatch ? csrfMatch[1] : null

    if (!csrfToken) {
      throw new Error('CSRF token not found')
    }

    const initialCookies = response.headers.get('set-cookie') || ''

    const formData = new URLSearchParams({
      'username': username,
      'password': password,
      'csrfmiddlewaretoken': csrfToken,
      'next': '/'
    })

    const loginResponse = await fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Referer': url,
        'User-Agent': userAgent,
        'Cookie': initialCookies,
      },
      body: formData.toString(),
      redirect: 'manual'
    })

    console.log(`Login response status: ${loginResponse.status}`)
    console.log(`Login response headers: ${JSON.stringify(Object.fromEntries(loginResponse.headers))}`)

    const loginResponseBody = await loginResponse.text()
    console.log(`Login response body: ${loginResponseBody.substring(0, 200)}...`)

    if (loginResponse.status === 302 && loginResponse.headers.get('location') === '/') {
      const loginCookies = loginResponse.headers.get('set-cookie') || ''
      const allCookies = combineCookies(initialCookies, loginCookies)

      const dashboardResponse = await fetch(url.replace('/login/', '/'), {
        headers: {
          'Cookie': allCookies,
          'User-Agent': userAgent,
        }
      })
      const dashboardContent = await dashboardResponse.text()
      console.log(`Dashboard content: ${dashboardContent.substring(0, 200)}...`)

      if (dashboardContent.includes('href="/logout/"') || dashboardContent.includes('href="/wyloguj/"')) {
        const nowUtc = formatToISO(new Date())
        const nowBeijing = formatToISO(new Date(Date.now() + 8 * 60 * 60 * 1000))
        const message = `账号 ${username} (${type}) 于北京时间 ${nowBeijing}（UTC时间 ${nowUtc}）登录成功！`
        console.log(message)
        await sendTelegramMessage(message)
        return { success: true, message }
      } else {
        const message = `账号 ${username} (${type}) 登录后未找到登出链接，可能登录失败。`
        console.error(message)
        await sendTelegramMessage(message)
        return { success: false, message }
      }
    } else if (loginResponseBody.includes('Nieprawidłowy login lub hasło')) {
      const message = `账号 ${username} (${type}) 登录失败: 用户名或密码错误。`
      console.error(message)
      await sendTelegramMessage(message)
      return { success: false, message }
    } else {
      const message = `账号 ${username} (${type}) 登录失败，未知原因。请检查账号和密码是否正确。`
      console.error(message)
      await sendTelegramMessage(message)
      return { success: false, message }
    }
  } catch (error) {
    const message = `账号 ${username} (${type}) 登录时出现错误: ${error.message}`
    console.error(message)
    await sendTelegramMessage(message)
    return { success: false, message }
  }
}

function combineCookies(cookies1, cookies2) {
  const cookieMap = new Map()
  
  const parseCookies = (cookieString) => {
    cookieString.split(',').forEach(cookie => {
      const [fullCookie] = cookie.trim().split(';')
      const [name, value] = fullCookie.split('=')
      if (name && value) {
        cookieMap.set(name.trim(), value.trim())
      }
    })
  }

  parseCookies(cookies1)
  parseCookies(cookies2)

  return Array.from(cookieMap.entries()).map(([name, value]) => `${name}=${value}`).join('; ')
}

async function sendSummary(results) {
  const successfulLogins = results.filter(r => r.success)
  const failedLogins = results.filter(r => !r.success)

  let summaryMessage = '登录结果统计: \n'
  summaryMessage += `成功登录的账号: ${successfulLogins.length}\n`
  summaryMessage += `登录失败的账号: ${failedLogins.length}\n`

  if (failedLogins.length > 0) {
    summaryMessage += '\n登录失败的账号列表: \n'
    failedLogins.forEach(({ username, type, message }) => {
      summaryMessage += `- ${username} (${type}): ${message}\n`
    })
  }

  console.log(summaryMessage)
  await sendTelegramMessage(summaryMessage)
}

async function sendTelegramMessage(message) {
  const telegramConfig = JSON.parse(TELEGRAM_JSON)
  const { telegramBotToken, telegramBotUserId } = telegramConfig
  const url = `https://api.telegram.org/bot${telegramBotToken}/sendMessage`
  
  try {
    await fetch(url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        chat_id: telegramBotUserId,
        text: message
      })
    })
  } catch (error) {
    console.error('Error sending Telegram message:', error)
  }
}

function formatToISO(date) {
  return date.toISOString().replace('T', ' ').replace('Z', '').replace(/\.\d{3}Z/, '')
}

function delay(ms) {
  return new Promise(resolve => setTimeout(resolve, ms))
}
```

</details>

变量:

`ACCOUNTS_JSON`

<details><summary>Json</summary>

```json
[  
  { "username": "serv00user1", "password": "serv00password1", "panelnum": "0", "type": "serv00" },
  { "username": "serv00user2", "password": "serv00password2", "panelnum": "4", "type": "serv00" },
  { "username": "serv00user3", "password": "serv00password3", "panelnum": "7", "type": "serv00" },
  { "username": "ct8user1", "password": "ct8password1", "type": "ct8" },
  { "username": "ct8user2", "password": "ct8password2", "type": "ct8" }
]
```

</details>

`TELEGRAM_JSON`

<details><summary>Json</summary>

```json
{
  "telegramBotToken": "YOUR_BOT_TOKEN",
  "telegramBotUserId": "YOUR_USER_ID"
}
```

</details>

## 创建 Workers

进入 Cloudflare 面板, 创建 Workers

![](https://github.com/user-attachments/assets/2faedb72-470b-41fd-9f1d-8a37663d3f2c)

名字随意, 建议写`Serv00Keep`方便好记, 然后右下角点部署.

![](https://github.com/user-attachments/assets/3be5f144-2992-45aa-b46f-0a8a88515211)

部署完成后点击编辑代码.

![](https://github.com/user-attachments/assets/f53f84c0-5985-468d-9b6f-2204f3bbc0ca)

粘贴 JavaScript 代码之后再点击部署.

![](https://github.com/user-attachments/assets/f6ffccb3-f80e-4db6-9347-3264c693289a)

### 添加机密

返回到`Serv00Keep`的设置, 找到`变量和机密`

按照`Json`格式编辑好自己的 serv00 账号和密码, 创建`ACCOUNTS_JSON`变量.
按照`Json`格式编辑好自己的 telegram bot token, 创建`TELEGRAM_JSON`变量.

![](https://github.com/user-attachments/assets/22f0cb60-050a-4fd7-b264-08c590bc8362)

### 添加触发事件

![](https://github.com/user-attachments/assets/e3e2ddf8-45ff-4a39-8743-dd8eb75ed1bf)

## 手动部署

机密和触发事件填写完成之后, 我们手动部署一次.

![](https://github.com/user-attachments/assets/3e9b4d9d-b222-4629-8868-5fee615c6411)

## 手动执行验证效果

如下图, 进入编辑代码 → 设定时间 → 触发计划的事件, 即可手动触发.

同时可以看到正常运行没问题, 接下来就是定时执行不用再管它了.

![](https://github.com/user-attachments/assets/d6f0ff1d-2408-4fbd-9071-2d01fb5a7763)

# 文章引用

[Saika's Blog](https://saika.us.kg/2024/01/27/serv00_logs#Alist) | [知乎](https://zhuanlan.zhihu.com/p/680607217)