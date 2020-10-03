function setTab(name,cursel,n)	//tab页点击脚本
{ 
	for(i=1;i<=n;i++)
	{ 
		var menu=document.getElementById(name+"_tab"+i); //提取tab页名
		var con=document.getElementById(name+"_con"+i); 	//提取内容名
		//alert(menu);
		//alert('INPUT_tab2');
		menu.className=i==cursel?"hover":""; 	//把当前点击的tab页class改为"hover",其他的消除
		con.style.display=i==cursel?"block":"none"; //把当前点击的内容显示，其他的消除
	} 
} 
 