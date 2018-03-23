# deploy-ansible-service-demo
>注:小白初试


In This Guide
===

* [Dependencies](#dependencies)
* [环境搭建](#environment)
* [配置ansible服务器hosts](#ansible-server)
* [配置ansible主机组](#host-and-hosts)
* [节点服务器配置](#node-4)
* [执行demo](#action-demo)
* [结果检验](#check-result)

---

## Dependencies

* ansible服务器
    * Ubuntu 16.04 LTS
    * ansible 2.3.1.0
* 节点服务器
    * Ubuntu 16.04 LTS
    * nginx/1.10.3 (Ubuntu)

---

<span id="environment">1.在服务器上搭建环境</span>
=======================
```
please RTFM and STFW.

```

<span id="2ansible-server">2.配置节点服务器在`/etc/hosts`中</span>
================
```
$ sudo vi /etc/hosts

---

#testNodeServer

47.100.45.168 NodeServer1

```

<span id="host-and-hosts">3.配置ansible主机组`/etc/ansible/hosts`</span>
===============
```
$ sudo vi /etc/ansible/hosts


---

#全局变量 即如果不指定 则默认为此变量
[all:vars]
ansible_connection=ssh
ansible_ssh_user=deploy
ansible_ssh_pass=*******
ansible_ssh_port=22

#主机组 已经在/etc/hosts中配置IP.方便管理
[NodeServer]
NodeServer1 ansible_ssh_user=deploy
#NodeServer2 ansible_ssh_user=deploy



```
>注:使用此demo,则指定的`ansible_ssh_user`需要具有sudo免密权限

>*希望哪位大神能指教,如何能让指定用户不使用sudo就可以执行`name:Ensure vhost config path extis` 感激不尽*


<span id="node">4.在节点服务器上配置本服务器公钥,然后在ansible服务器上执行以下命令测试是否联通成功.</span>
======
```
ansible NodeServer -m ping

```

成功则显示如下:

```
NodeServer1 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}
```

<span id="action-demo">5.使用此代码 进入`deploy-ansible-service`目录执行以下命令</span>
===

>后面的变量 为`/etc/ansible/hosts`中配置的主机名或主机组名
```
$shell/test/nginx-config.sh NodeServer

```
<span id="check-result">6.出现以下提示 即为成功</span>
======

```
 [WARNING]: Found variable using reserved name: action


PLAY [update nginx config] **************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************
ok: [NodeServer1]

TASK [service-register : include] *******************************************************************************************************************************************************************************
included: /home/sunsj/deploy-ansible-service/roles/service-register/tasks/service-register-action.yml for NodeServer1

TASK [service-register : Ensure vhost config path extis] ********************************************************************************************************************************************************
ok: [NodeServer1]

TASK [service-register : check origin file exist] ***************************************************************************************************************************************************************
ok: [NodeServer1]

TASK [service-register : Backups /home/deploy/nginx/sites-available/testnodeserver.feawin.com.conf] *************************************************************************************************************
skipping: [NodeServer1]

TASK [service-register : Ensure cache  config path exists,create cache directory] *******************************************************************************************************************************
ok: [NodeServer1]

TASK [service-register : Delete nginx default config file] ******************************************************************************************************************************************************
ok: [NodeServer1]

TASK [service-register : Generate env test vhost config file] ***************************************************************************************************************************************************
changed: [NodeServer1]

TASK [service-register : test nginx conf is correct] ************************************************************************************************************************************************************
 [WARNING]: Consider using 'become', 'become_method', and 'become_user' rather than running sudo

changed: [NodeServer1]

TASK [service-register : nginx reload] **************************************************************************************************************************************************************************
changed: [NodeServer1]

PLAY RECAP ******************************************************************************************************************************************************************************************************
NodeServer1                : ok=9    changed=3    unreachable=0    failed=0 

```


------

>Author's QQ : 825658839
