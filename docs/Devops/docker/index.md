# docker

## 保存镜像到tar文件

```bash
sudo docker save -o <path for generated tar file> <image name>

docker save -o c:/myfile.tar centos:16
```

## 从文件导入成镜像

```bash
sudo docker load -i <path to image tar file>
```

## 机器互拷文件

```bash
scp -r source target

# 远程拷本地
sudo scp -r root@192.168.1.100:/data/ /home/myfile/


# 本地拷远程
sudo scp -r /home/myfile/ root@192.168.1.100:/data/
```

## docker 调试

```bash
# 退出后结束运行
docker run -p 80:80 -v /data:/data nginx:latest

docker run -p 80:80 -v $PWD/data:/data nginx:latest

# 后台运行
docker run -p 80:80 -v /data:/data -d nginx:latest
```

## docker ps 为什么看不到端口

