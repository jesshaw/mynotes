# JSON Web Token (JWT)

## 定义

**JSON Web Token (JWT)** 是一种开放标准（RFC 7519），定义了一种紧凑且自包含的方式，以 JSON 对象格式在各方之间安全地传输信息。这些信息是可以验证和信任的，因为它通过使用密钥（HMAC 算法）或公私钥对（RSA 或 ECDSA）进行数字签名。

## 结构

JWT 分为三个部分：

1. **Header（头部）**：
   - 包含关于令牌的元数据，通常包括令牌类型（JWT）和使用的签名算法（如 HMAC、SHA256 或 RSA 等）。

2. **Payload（负载）**：
   - 负载部分包含声明（claims），也就是实际传输的信息。这些信息可以包括用户的身份、权限或其他元数据。声明有三种类型：
     - **Registered Claims**（注册声明）：预定义的一些标准声明，如 `iss`（签发者）、`exp`（过期时间）、`sub`（主题）和 `aud`（受众）。
     - **Public Claims**（公共声明）：可以自定义的声明，但需要避免与标准声明发生冲突。
     - **Private Claims**（私有声明）：在双方之间自定义的声明。

3. **Signature（签名）**：
   - 签名用于验证令牌没有被篡改。签名通过编码后的头部和负载，使用密钥与签名算法生成。常见的签名算法有 HMAC SHA256 和 RSA。

## JWT 的工作流程

1. 用户登录时，服务器认证成功后生成 JWT。
2. 服务器将 JWT 发送给客户端。
3. 客户端在每次请求时都将 JWT 放入 HTTP 请求的 `Authorization` 头中。
4. 服务器验证 JWT 的有效性（如检查签名、过期时间等），然后处理请求。

## 优点

- **紧凑性**：JWT 的结构紧凑，适合通过 URL、POST 请求、HTTP Headers 等方式传输。
- **自包含性**：JWT 包含了所有必要的信息，无需依赖服务器端的会话存储。
- **可扩展性**：可以根据需求自定义负载部分，灵活传递各种信息。

## 使用场景

- **身份验证**：JWT 常用于身份验证流程中，用户登录后会获得 JWT，后续的每次请求都携带该令牌，服务器通过验证 JWT 来判断用户的身份。
- **信息交换**：JWT 也可用于安全地传输信息，各方通过签名机制确保信息的完整性和可信性。

## 引用

[JSON Web Token (JWT) 定义 RFC 7519](https://datatracker.ietf.org/doc/html/rfc7519)

[JSON Web Token 入门教程](http://www.ruanyifeng.com/blog/2018/07/json_web_token-tutorial.html)
