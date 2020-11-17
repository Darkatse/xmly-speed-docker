## 特别声明: 
* 本仓库中的xmly-speed-docker项目仅仅是将Zero-S1/xmly_speed项目容器化而成，原项目中涉及的任何解锁和解密分析脚本均与darkatse无关。本项目仅用于测试和学习研究，禁止用于商业用途，不能保证其合法性，准确性，完整性和有效性，请根据情况自行判断.

* 本项目内所有资源文件，禁止任何公众号、自媒体进行任何形式的转载、发布。

* darkatse对任何脚本问题概不负责，包括但不限于由任何脚本错误导致的任何损失或损害.

* 间接使用本项目的任何用户，包括但不限于建立VPS或在某些行为违反国家/地区法律或相关法规的情况下进行传播, darkatse 对于由此引起的任何隐私泄漏或其他后果概不负责.

* 请勿将xmly-speed-docker项目的任何内容用于商业或非法目的，否则后果自负.

* 如果任何单位或个人认为该项目的脚本可能涉嫌侵犯其权利，则应及时通知并提供身份证明，所有权证明，我们将在收到认证文件后删除相关脚本.

* 任何以任何方式查看此项目的人或直接或间接使用该xmly-speed-docker项目的任何脚本的使用者都应仔细阅读此声明。darkatse 保留随时更改或补充此免责声明的权利。一旦使用并复制了任何相关脚本或xmly-speed-docker项目的规则，则视为您已接受此免责声明.

 **您必须在下载后的24小时内从计算机或手机中完全删除以上内容.**  </br>
> ***您使用或者复制了本仓库且本人制作的任何脚本，则视为`已接受`此声明，请仔细阅读*** 
  
  
## xmly-speed-docker
docker运行喜马拉雅极速版签到脚本  
>  **本项目参考了chinnkarahoi的[jd-scripts-docker](https://github.com/chinnkarahoi/jd-scripts-docker)项目，在此特别感谢！**

### 安装依赖
git docker docker-compose
### 下载
```sh
git clone https://github.com/Darkatse/xmly-speed-docker
cd xmly-speed-docker
```
### 获取cookie
参考[原项目](https://github.com/Zero-S1/xmly_speed/blob/master/xmly_speed.md)
可配置Server酱和Bark推送服务

### 启动
```sh
docker-compose up --build --force-recreate -d xmly1
```
### 测试正确性
签到测试
```sh
docker exec xmly1 bash -c 'set -o allexport; source /all; source /env;  cd /xmly_speed; python3 xmly_speed.py'
```
确认可以签到等操作后，即可每天定时执行脚本。

### 多账号
使用多容器的方式，好处：
1. 脚本并行
2. 每个账号可以有不同的配置，比如配置微信推送
#### 配置
添加第二个账号：以上所有操作中的`1`替换成`2`, 然后重复之前所有操作。  
超过五个账号需要手动创建./env/env6，修改./docker-compose.yml文件
#### 配置文件说明
所有账号共享的参数需要配置./env/all, 每个账号独立参数需要配置./env/env*，  
每个账号配置的参数会覆盖共享参数，每个账号未配置参数的继承共享的参数

### 其他
- 查看log
```sh
docker-compose logs
```
- 停止
```sh
docker-compose down
```
