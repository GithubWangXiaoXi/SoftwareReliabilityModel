function validate_changedata(form,number)	//在确认替换数据前，对当前条件进行验证
{	
	if(confirm("注意！如果替换数据，对比数据记录将清空，确定要替换吗？"))
	{
		//parent.document.getElementById("loader_container").style.display="block";
		//把执行等待滚动条打开
		$.ajax({
           
                type: "POST",
              
                url: "./showhistorydata.jsp" ,
                data: $('#changeform').serialize(),
                success: function (result) {
                    // console.log(result);
                    if (result.resultCode == 200) {
                       
                    	//var src=$('#targetframe').attr('src');
                    	//console.log(src);
                    	//$('#targetframe').attr('src', '');
                    	//$('#targetframe').attr('src', src);
                    	$('#targetframe')[0].contentWindow.location.reload(true);
                       
                       //$('#targetframe')[0].innerHTML=result;
                    }
                    ;
                },
                error : function() {
                    alert("服务器异常！");
                }
            });
		
	}
		return false;
}
function validate_changedata2(form,number)	//在确认替换数据前，对当前条件进行验证
{	
	if(confirm("注意！如果替换数据，对比数据记录将清空，确定要替换吗？"))
	{
		//parent.document.getElementById("loader_container").style.display="block";
		//把执行等待滚动条打开
		$.ajax({
           
                type: "POST",
                dataType: "json",
                url: "./showhistorydata2.jsp" ,
                data: $('#changeform').serialize(),
                success: function (result) {
                    console.log(result);
                    if (result.resultCode == 200) {
                        $('#targetframe')[0].contentWindow.location.reload(true);
                        //$('#targetframe').attr('src', $('#iframe').attr('src'));
                    }
                    ;
                },
                error : function() {
                    alert("服务器异常！");
                }
            });
		
	}
		return false;
}
function setchangenumber(n,number,current)
{	
	setTab("showhistorydata",n,number);
	document.getElementById("currentdata").style.display="none";
	if(n == current) document.getElementById("currentdata").style.display="block";
	document.getElementById("changenumber").value = n;
}