# nodejs常用命令

Node.js 常用命令有很多，以下是一些最常见的 Node.js 命令和操作：

## 1. **`node`**

   运行 Node.js 脚本或进入 Node.js 交互式环境：

- **`node <filename.js>`**：运行指定的 JavaScript 文件。
- **`node`**：不带参数时，进入 Node.js 交互式 REPL（Read-Eval-Print Loop）。

## 2. **`npm`（Node Package Manager）**

   管理项目的依赖包：

- **`npm init`**：初始化一个新的 `package.json` 文件，记录项目的依赖。
- **`npm install <package-name>`**：安装指定的 npm 包到项目中，默认会安装到 `node_modules` 目录中。
- **`npm install -g <package-name>`**：全局安装指定包。
- **`npm uninstall <package-name>`**：卸载指定的包。
- **`npm update`**：更新项目的所有依赖。
- **`npm run <script-name>`**：运行 `package.json` 中定义的脚本（如：`npm run start`）。
- **`npm list`**：列出当前安装的所有包和版本信息。

## 3. **`npx`**

   运行 npm 包，而不需要全局安装它：

- **`npx <package-name>`**：直接运行包中的可执行文件。
- 例如：**`npx create-react-app my-app`** 创建一个 React 项目。

## 4. **`nodemon`**

   实时监控代码变化并自动重启 Node.js 应用（需要安装 `nodemon` 包）：

- **`nodemon <filename.js>`**：自动监视文件的更改，并重启应用程序。

## 5. **`npm outdated`**

   检查项目依赖包是否有新版本。

## 6. **`npm audit`**

   查找并修复项目中的安全漏洞：

- **`npm audit`**：显示安全问题报告。
- **`npm audit fix`**：自动修复安全漏洞（如果有可能）。

## 7. **`npm cache clean --force`**

   清除 npm 缓存，解决依赖安装异常或问题。

## 8. **`npm ci`**

   使用 `package-lock.json` 文件来快速安装项目依赖，通常用于 CI 环境。

## 9. **`node -v` 或 `node --version`**

   检查 Node.js 的版本。

## 10. **`npm -v` 或 `npm --version`**

   检查 npm 的版本。

## 11. **`node --inspect`**

   启动 Node.js 应用时开启调试模式：

- **`node --inspect <filename.js>`**：开启调试并可通过 Chrome DevTools 进行调试。

## 12. **`node --max-old-space-size=<size>`**

   调整 Node.js 的内存限制（默认大约 1.4 GB）。适用于处理大内存需求的场景。

## 13. **`npm run-script`**

   运行 `package.json` 中定义的脚本。例如：

- **`npm start`**：通常用于启动应用程序。
- **`npm test`**：运行测试。

## 14. **`npm link`**

   本地开发时，将包链接到全局环境中，方便测试全局可执行文件。

## 15. **`npm rebuild`**

   重新编译项目中包含的所有本机依赖包。
