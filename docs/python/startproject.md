# startproject
1. 创建一个项目目录
`mkdir [projectname]`
1. 进入项目目录，安装虚拟环境
`python -m venv [虚拟环境目录名]`
1. 激活虚拟环境
`source [虚拟环境目录名/bin/activate]`
1. 安装Django包
`pip install Django`
1. 创建项目
`django-admin.py startproject [项目名称]`
1. 创建数据库
`python manage.py migrate`
1. 运行项目'
`python manage.py runserver`
1. 创建应用程序
`python manage.py startapp [app名称]`
1. 定义模型，在应用目录中的models.py文件中定义数据模型
1. 模型定义完成后，激活模型，及创建数据库表。执行
`python manage.py makemigrations [app名称]`及 `python manage.py migrate`
1. 创建超级用户
`python manage.py createsuperuser`。根据提示输入用户名和密码。
1. 向管理网站注册模型，在应用程序目录下的admin.py中添加模型，如admin.site.register(class_name)
