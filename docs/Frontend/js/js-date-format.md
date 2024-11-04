# js日期格式化

在JavaScript中，日期格式化常用的方式包括内置的`Date`方法、`Intl.DateTimeFormat`、以及常用库如`moment.js`、`date-fns`等。以下是一些常见的格式化方式：

## 1. **使用原生 `Date` 对象**

JavaScript的`Date`对象没有直接的格式化方法，但可以组合日期部分来格式化。

```javascript
const date = new Date();

// 年月日格式
const formattedDate = `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}`;

// 输出示例: "2024-11-04"
```

## 2. **使用 `Intl.DateTimeFormat`**

`Intl.DateTimeFormat`是现代浏览器支持的国际化格式化方法，可以很方便地格式化日期。

```javascript
const date = new Date();
const formatter = new Intl.DateTimeFormat('en-GB', {
  year: 'numeric',
  month: '2-digit',
  day: '2-digit',
});
console.log(formatter.format(date));  // 输出示例: "04/11/2024"
```

## 3. **使用 `toLocaleDateString`**

`toLocaleDateString`方法可按指定的区域设置来格式化日期。

```javascript
const date = new Date();
console.log(date.toLocaleDateString('zh-CN', { year: 'numeric', month: '2-digit', day: '2-digit' }));
// 输出示例: "2024-11-04"
```

## 4. **使用第三方库：`date-fns`**

`date-fns`是轻量级日期处理库，支持各种日期格式化功能。

```javascript
import { format } from 'date-fns';

const date = new Date();
const formattedDate = format(date, 'yyyy-MM-dd');
console.log(formattedDate);  // 输出示例: "2024-11-04"
```

## 5. **使用第三方库：`moment.js`**

`moment.js`功能强大，格式化日期十分简单，但库较大。

```javascript
import moment from 'moment';

const date = moment().format('YYYY-MM-DD');
console.log(date);  // 输出示例: "2024-11-04"
```

## 常见格式化符号

| 符号   | 含义       | 示例 |
|--------|-----------|------|
| `YYYY` | 年         | 2024 |
| `MM`   | 月（补零）   | 11   |
| `DD`   | 日（补零）   | 04   |
| `HH`   | 时（24小时） | 15   |
| `mm`   | 分（补零）   | 09   |
| `ss`   | 秒（补零）   | 05   |

根据项目需求和环境，选择合适的方法进行日期格式化。
