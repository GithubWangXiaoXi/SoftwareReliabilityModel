//执行等待滚动条脚本
var t_id = setInterval(animate,20);	//每隔固定时间久执行animate一次
var pos=0;
var dir=2;
var len=0;
var count=0;
function animate()
{
	//if(count>20) clearInterval(t_id);
	//console.log(count);
	var elem = document.getElementById('progress');
	//count++;
	if(elem != null)
	{
		if (pos==0) len += dir;
		if (len>32 || pos>168) pos += dir;
		if (pos>168) len -= dir;
		if (pos>168 && len==0) pos = 0;
		elem.style.left = pos;
		elem.style.width = len;
	}
}