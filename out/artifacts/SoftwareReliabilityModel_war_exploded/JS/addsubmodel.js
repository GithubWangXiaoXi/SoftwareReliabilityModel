function addmodel()	//增加模型
{
	var number = document.getElementById("number").value;	//提取现有模型数
	if(number>=11)
	{
		alert("所组合的模型不超过11个！");		//模型最多为6个
	}
	else
	{
		number++;
		document.getElementById("model"+number).style.display="block";
	}
	document.getElementById("number").value=number;
}
function submodel()	//减少模型
{
	var number = document.getElementById("number").value;	//提取现有模型数
	if(number<=2)
	{
		alert("所组合的模型不少于2个！");		//模型最少为2个
	}
	else
	{
		document.getElementById("model"+number).style.display="none";
		number--;
	}
	document.getElementById("number").value=number;
}