# git常用命令

## 推送之前检查

显示含有project或Print字符的文件并显示行号

```bash
git grep -n -e 'project' -e 'Print'
```

## 指定用户密码拉取http的仓库

```bash
git clone http://username:password@hostname/path/repository.git
```

特殊字符处理

```bash
!   #   $    &   '   (   )   *   +   ,   /   :   ;   =   ?   @   [   ]
%21 %23 %24 %26 %27 %28 %29 %2A %2B %2C %2F %3A %3B %3D %3F %40 %5B %5D
```

[参考](https://stackoverflow.com/questions/6172719/escape-character-in-git-proxy-password)

## 镜像方式克隆github

把github.com替换成github.com.cnpmjs.org

```bash
git clone https://github.com.cnpmjs.org/jesshaw/javasample
```

## 推送到指定仓库

```bash
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/jesshaw/reservation_room_app.git
git push -u origin master 
```

## 打标签并推送到远程

```bash
# 基于当前节点打tag

git tag -a v0.9.0.RELEASE -m '接手之前的版本'

# 指琮前节点打tag

git tag -a v0.9.0.RELEASE -m '接手之前的版本' 033133b

# 显示tag内容
git show v0.9.0.RELEASE

# 推送tag到远程
git push origin v0.9.0.RELEASE
```

## 回滚远程提交

```bash
# 保留修改历史记录的回滚
git revert <commit> ...

# 不保留修改历史记录的回滚
git reset --hard HEAD~n 
git push -f 
```

## git clone查定分支和目录

```bash

git clone url

# 镜像方法快速clone

git clone https://github.com.cnpmjs.org/repsitory


# 查看tag分支

git tag -l 

# 切换到批定tag分支

git checkout tags/<tag_name>

# 基于指定tag分支创建分支

git checkout tags/<tag_name> -b <branch_name>
```

## 查看远程地址

查看全名

```bash
git remote -v
```

## 创建分支

```bash
git checkout -b dev20170803
```

## 删除分支或远程分支

```bash
# 删除本地分支
git branch -d localBranchName
# 删除远程分支
git push origin -d remoteBranchName
```

## 切换分支或tag

```bash
git checkout branch_name
git checkout tag_name
```

## git bash连接linux

1. linux上执行，ssh-keygen 生成公私钥对

    ```bash
    ssh-keygen
    # 据提示输入文件名称，如id_rsa.trainmall
    ```

2. 公钥添加到authorized_keys

    ```bash
    cat id_rsa.pub >> ~/.ssh/authorized_keys
    ```

3. 修改配置文件允许使用秘钥登录

    ```bash
    vim /etc/ssh/sshd_config
    ```

    PubkeyAuthentication yes
    AuthorizedKeysFile      .ssh/authorized_keys
    PasswordAuthentication yes

4. 重启ssh服务

    ```bash
    systemctl restart sshd
    ```

5. 复制linux服务器上的私钥到本地机

    scp root@192.168.1.168:/root/.ssh/id_rsa ~/.ssh

6. 需要本地配置多个ssh，则要进行config配置

    ```bash
    vim config

    # 增加以下配置
    # trainmall
    Host trainmall
        Hostname 47.96.102.25
        PreferredAuthentications publickey
        IdentityFile ~/.ssh/id_rsa.trainmall
        User jesshaw@126.com
    ```

7. 测试是否成功

    ```bash
    ssh root@trainmall
    ```

## git多仓库帐号配置

1. 生成公私钥对

    ```bash
    $ cd ~/.ssh/
    # -t 加密类型 -C 备注
    $ ssh-keygen -t rsa -C "jeshaw@lexiangmiao.com"
    # 根据提示输入文件名称，如id_rsa.lexiangmiao
    ```

2. 添加公钥到需要上传的代码网站

    ```bash
    cat id_rsa.lexiangmiao.pub
    ```

3. 配置config

    ```bash
    vim config

    # github
    Host mygithub github.com
        Hostname github.com
        PreferredAuthentications publickey
        IdentityFile ~/.ssh/id_rsa.github
        User jesshaw@lexiangmiao.com

    # lexiangmiao
    Host code.lexiangmiao.com
        Hostname code.lexiangmiao.com
        PreferredAuthentications publickey
        IdentityFile ~/.ssh/id_rsa.lexiangmiao
        User jesshaw@lexiangmiao.com
    ```

4. 添加私钥到本地

    ```bash
    # 先要启动ssh-agent才能添加
    eval $(ssh-agent -s)

    ssh-add ~/.ssh/id_rsa.lexiangmiao

    # 删除私钥 hostname配置在config中
    ssh-keygen -R hostname
    ```

5. 测试是否成功

    ```bash
    ssh -T git@github.com

    #调试方式查看是否成功
    ssh -vT git@code.lexiangmiao.com
    ```

6. 配置当前库的用户和邮箱

    ```bash
    git config user.name "Firstname Lastname"
    git config user.email "your_email@example.com"
    git config --local -l
    # 查看全局配置
    git config --global -l
    ```

7. 配置新的url

    git remote set-url origin git@github.com-worker_user1:worker_user1/repo_name.git

## 拉不到代码，原因是因为不是以管理方式运行的git bash

git@github.com-worker_user1: Permission denied (ssh key error).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

## 改用https方式作为库地址时，保留输入用户名和密码

git config --global credential.helper store

## 箭头键不能工作

经常碰到在bash中执行命名后需要使用上下箭头键来完成选择，但是偏偏在win7中不能使用。(当然换到cmd中是可以的，不使用此方式的原因你懂的)

实际上我们是实现选择的工作，虽然体验上是差了一些，但以下方法是行的

即使用输入"数字+回车"实现选择的功能，如下示例

```bash
yo generate
what would you like to do? (Use arrow keys)
Run a generator
Bootstrap
Loopback
exit
## 输入2+回车即选择了Bootstrap
```

## 设置提交的用户名和邮箱

### 列出所有配置

```bash
git config [--local|--global|--system] -l
```

### 设置某个配置项的值

```bash
git config [--local|--global|--system] section.key value

git config --local user.name "lexiangmiao"
```

### 查看某项的当前值

```bash
git config name

git config user.name
```

## 以ssh方式复制项目（不需要输入帐户）

```sh
git clone git@github.com:jesshaw/node-sample-project.git
```

## git日志输出更友好

```bash
git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
git config --global alias.lg "log --color --graph --pretty=format:'%C(bold cyan)%h%C(reset) -%C(yellow)%d%C(reset) %s %C(green)(%cr) %C(bold magenta)<%an>%C(reset)' --abbrev-commit"
git config --global alias.lgl "log --color --graph --pretty=format:'%C(bold cyan)%h%C(reset) -%C(yellow)%d%C(reset) %s %C(green)(%ci) %C(bold magenta)<%an>%Creset' --abbrev-commit"
git config --global --unset alias.lg
git config --global --unset alias.lgl
```

## 怎样移除远程的提交日志

示例数据如下

```bash
git lg -5
* 728e3ed - (HEAD -> master, origin/master, origin/HEAD) test4 (26 minutes ago) <ximing>
* c8f834f - (mywork) test3 (19 hours ago) <ximing>
* 3992e9c - test2 (19 hours ago) <ximing>
* abbe339 - test1 (19 hours ago) <ximing>
* 2936159 - add bookmark (21 hours ago) <ximing>
```

**方法1：**

移除c8f834f之后的提交历史

```bash
git reset --hard 3992e9c
git push origin -f  master
```

**方法2：**

1. 仅移除abbe339的提交，其他保留

    ```bash
    git rebase -i 2936159
    error: could not apply 3992e9c... test2

    When you have resolved this problem, run "git rebase --continue".
    If you prefer to skip this patch, run "git rebase --skip" instead.
    To check out the original branch and stop rebasing, run "git rebase --abort".
    Could not apply 3992e9c9ac3a6e6bb64e0876dace165980990b45... test2
    ```

2. 此时应当解决冲突，然后多次执行以下命令直至没有error: could not apply 3992e9c... test2此类错误为止

    ```bash
    git status
    git add -A 
    git rebase --continue
    ```

3. 提交到远程

    ```bash
    git push origin +master
    ```

## 清除远程上某个文件的所有提交日志

```bash
cd current directory
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch 文件名' --prune-empty --tag-name-filter cat -- --all
git push origin master --force
rm -rf .git/refs/original/
git reflog expire --expire=now --all
git gc --prune=now
git gc --aggressive --prune=now
```

## 提交所有更改的文件

``` bash
git commit -a -m "提交备注"
```

## 取消远程某次或某几次提交(远程日志保留)

``` bash
git revert --no-commit b49eb8e 1d8b062
git revert -n b49eb8e 1d8b062
## 解决冲突后提交
git commit -a -m "Revert commits b49eb8e and 1d8b062"
```

## 取消本地文件修改

``` bash
git checkout file1.js file2.js
```

## 选择某个（dev1）分支上指定的提交合并到其他（bugfix）分支

``` bash
git checkout dev1
git rebase -i bugfix #基于bugfix，列出提交的记录，选择需要的提交执行。有时需要解决冲突
git checkout bugfix
git merge dev1 
```
