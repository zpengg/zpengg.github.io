# 💻🔨😡 zpengg
温故而知新

<div id="main">
<h2>近三天</h2>
<ul>
  <li v-for="i in [3,2,1]">
    <div>
       <a :href = "'#/dailyLog/'+getDay(i-3)">{{getDay(i-3)}}</a>
    </div>
  </li>
  </ul>
<h2>七天前</h2>
       <a :href = "'#/dailyLog/'+getDay(-7)">{{getDay(-7)}}</a>
<h2>一个月前</h2>
       <a :href = "'#/dailyLog/'+getDay(-30)">{{getDay(-30)}}</a>
       
<h2>周报</h2>
    <a :href = "'#/weeklyLog/'+getYearWeek(getDay(0))">本周</a>
    <br/>
    <a :href = "'#/weeklyLog/'+getYearWeek(getDay(-7))">上周</a>

<h2>统计</h2>
<div>
    <figure><embed src="https://wakatime.com/share/@4c63d2f9-59cd-4435-8077-f0932505d115/002cd766-d8ab-44e8-a345-60546b4c5662.svg"></embed></figure>
</div>
</div>


<script>
  new Vue({
    el: '#main',
    data: {
         msg: 'Vue',
         days: []
          },
    methods:{
        add: function(){
            //在methods内部访问data中的数据：this.属性名
            console.log(this.msg);  // 'todo'
            return this;
        },
        getDay: function (day){
            var today = new Date();
            var targetday_milliseconds=today.getTime() + 1000*60*60*24*day;
            today.setTime(targetday_milliseconds); //注意，这行是关键代码
            var tYear = today.getFullYear();
            var tMonth = today.getMonth();
            var tDate = today.getDate();
            tMonth = this.doHandleMonth(tMonth + 1);
            tDate = this.doHandleMonth(tDate);
            return tYear+"-"+tMonth+"-"+tDate;
        },
        doHandleMonth:function(month){
            var m = month;
            if(month.toString().length == 1){
            m = "0" + month;
            }
            return m;
        },
       getYearWeek: function (dateString){
            var da =dateString;//日期格式2015-12-30
            //当前日期
            var date1 = new Date(da.substring(0,4), parseInt(da.substring(5,7)) - 1, da.substring(8,10));
            //1月1号
            var date2 = new Date(da.substring(0,4), 0, 1);
            //获取1月1号星期（以周一为第一天，0周一~6周日）
            var dateWeekNum=date2.getDay()-1;
            if(dateWeekNum<0){dateWeekNum=6;}
            if(dateWeekNum<4){
                //前移日期
                date2.setDate(date2.getDate()-dateWeekNum);
            }else{
                //后移日期
                date2.setDate(date2.getDate()+7-dateWeekNum);
            }
            var d = Math.round((date1.valueOf() - date2.valueOf()) / 86400000);
            if(d<0){
                var date3 = (date1.getFullYear()-1)+"-12-31";
                return getYearWeek(date3);
            }else{
                //得到年数周数
                var year=date1.getFullYear();
                var week=Math.ceil((d+1 )/ 7);
                return year+"-W"+week;
            }
        }
    },
    created: function(){
        console.log('created')
        this.add('hjahha')
    }
  })
</script>
