# django 集成 celery
[[django]]
[[migrate]]

配置
CELERYBEAT_SCHEDULER = 'djcelery.schedulers.DatabaseScheduler' 

python manage.py migrate

| celery_taskmeta            |
| celery_tasksetmeta         |
| djcelery_crontabschedule   |
| djcelery_intervalschedule  |
| djcelery_periodictask      |
| djcelery_periodictasks     |
| djcelery_taskstate         |
| djcelery_workerstate       |

