## Dockerfile 简介

Dockerfile 是由一系列命令和参数构成的脚本，这些命令应用于基础镜像并最终创建一个新的镜像。它们简化了从头到尾的流程并极大的简化了部署工作。Dockerfile 从 FROM 命令开始，紧接着跟随者各种方法，命令和参数。其产出为一个新的可以用于创建容器的镜像。

## 语法规则

Dockerfile 包含创建镜像所需要的全部指令。基于在 Dockerfile 中的指令，我们可以使用 Docker build  命令来创建镜像。通过减少镜像和容器的创建过程来简化部署。
Dockerfile 支持支持的语法命令如下：
```dockerfile 
INSTRUCTION argument 
```
指令不区分大小写。但是，命名约定为全部大写。
所有 Dockerfile 都必须以 FROM 命令开始。FROM 命令会指定镜像基于哪个基础镜像创建，接下来的命令也会基于这个基础镜像（注：CentOS 和 Ubuntu 有些命令可是不一样的）。FROM 命令可以多次使用，表示会创建多个镜像。具体语法如下：
```dockerfile
FROM <image name> 
```
例如：
```dockerfile
FROM ubuntu 
```
上面的指定告诉我们，新的镜像将基于 Ubuntu 的镜像来构建。

继 FROM 命令，DockefFile 还提供了一些其它的命令以实现自动化。在文本文件或 Dockerfile 文件中这些命令的顺序就是它们被执行的顺序。

* MAINTAINER：设置该镜像的作者。语法如下：
```dockerfile
MAINTAINER <author name> 
```

* RUN：在 shell 或者 exec 的环境下执行的命令。RUN指令会在新创建的镜像上添加新的层面，接下来提交的结果用在Dockerfile的下一条指令中。语法如下：
```dockerfile
RUN <command> 
```

* ADD：复制文件指令。它有两个参数 source 和 destination。destination 是容器内的路径。source 可以是 URL 或者是启动配置上下文中的一个文件。语法如下：
```dockerfile
ADD <source> <destination> 
```

* CMD：提供了容器默认的执行命令。 Dockerfile 只允许使用一次 CMD 指令。 使用多个 CMD 会抵消之前所有的指令，只有最后一个指令生效。 CMD 有三种形式：
```dockerfile
CMD ["executable","param1","param2"]
CMD ["param1","param2"]
CMD command param1 param2 
```

* EXPOSE：指定容器在运行时监听的端口。语法如下：
```docekrfile
EXPOSE <port>; 
```

* ENTRYPOINT：配置给容器一个可执行的命令，这意味着在每次使用镜像创建容器时一个特定的应用程序可以被设置为默认程序。同时也意味着该镜像每次被调用时仅能运行指定的应用。类似于CMD，Docker只允许一个ENTRYPOINT，多个ENTRYPOINT会抵消之前所有的指令，只执行最后的ENTRYPOINT指令。语法如下：
```dockerfile
ENTRYPOINT ["executable", "param1","param2"]
ENTRYPOINT command param1 param2 
```

* WORKDIR：指定RUN、CMD与ENTRYPOINT 命令的工作目录。语法如下：
```dockerfile
WORKDIR /path/to/workdir 
```

* ENV：设置环境变量。它们使用键值对，增加运行程序的灵活性。语法如下：
```docekrfile
ENV <key> <value>
```

* USER：镜像正在运行时设置一个 UID。语法如下：
```docekrfile
USER <uid> 
```

* VOLUME：授权访问从容器内到主机上的目录。语法如下：
```docekrfile
VOLUME ["/data"] 
```