function setTab(name,cursel,n)	//tabҳ����ű�
{ 
	for(i=1;i<=n;i++)
	{ 
		var menu=document.getElementById(name+"_tab"+i); //��ȡtabҳ��
		var con=document.getElementById(name+"_con"+i); 	//��ȡ������
		//alert(menu);
		//alert('INPUT_tab2');
		menu.className=i==cursel?"hover":""; 	//�ѵ�ǰ�����tabҳclass��Ϊ"hover",����������
		con.style.display=i==cursel?"block":"none"; //�ѵ�ǰ�����������ʾ������������
	} 
} 
 