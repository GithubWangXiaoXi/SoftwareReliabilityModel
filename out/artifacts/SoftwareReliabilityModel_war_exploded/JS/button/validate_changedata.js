function validate_changedata(form,number)	//��ȷ���滻����ǰ���Ե�ǰ����������֤
{	
	if(confirm("ע�⣡����滻���ݣ��Ա����ݼ�¼����գ�ȷ��Ҫ�滻��"))
	{
		//parent.document.getElementById("loader_container").style.display="block";
		//��ִ�еȴ���������
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
                    alert("�������쳣��");
                }
            });
		
	}
		return false;
}
function validate_changedata2(form,number)	//��ȷ���滻����ǰ���Ե�ǰ����������֤
{	
	if(confirm("ע�⣡����滻���ݣ��Ա����ݼ�¼����գ�ȷ��Ҫ�滻��"))
	{
		//parent.document.getElementById("loader_container").style.display="block";
		//��ִ�еȴ���������
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
                    alert("�������쳣��");
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