<%@ page contentType="text/html; charset=Big5" %>
<HTML>
<HEAD>
<TITLE>cal-110816032</TITLE>
<!--
	�m�W:�§���
    �Ǹ�:110816032
    �ާ@����:
        1. ���@����䦡�p����ϥο�J�Ʀr(�Ĥ@�ӹB�⤸)
        2. �Y�Ʀr��0 ���U��|�@���t��
        3. ���U�B��l
        4. ��J�ĤG�ӹB�⤸
        5. ���U�̤U�誺����(�p�G�o�ɭԫ��U�B��l�A�ĤG�ӹB�⤸�N���N�Ĥ@�ӹB�⤸)
        6. �P�±z���ϥ�(�p���I��|�ˤ��J�����6��)
   �۵�����:
        �������з�100����
        �䴩�t���B�p���I�B��
        �������v���� �� ���ίS�O���M���N�i�H���U�@���B��
        ���U�[���[�z��QuQQQQQ
-->
</HEAD>
<BODY style="background-color:#FFECF5;">


<!--�ŧi�ܼƨ禡-->
<%!
	boolean hasUsed = false;//�W�@�����G�O�_�s�b
	double Lastresult = 0;//�W�@��������
	String LastCal = "";//�W�@�����⦡����
	String LastOpr = "";//�W�@�����B��l
	
	double Number1 = 0;//�B�⤸1
	double Number2 = 0;//�B�⤸2
	int funct = 0;  //�B��l(1(add)�B2(subtract)�B3(multiply)�B4(divide))
	
	boolean floatUsed = false;//�O�_�Ψ�p���I
	int floatCount = 1;//�p���I��ĴX��
	
	boolean neNum = false;//�O�_�Ψ�t��
	
	double result = 0;  //��l�W���Ʀr(��ܰ�)
	//������e�Ʀr�ܤ� //String btnState �O request.getParameter("btn")
	private void printMath(String btnState){
		double IntNum = Double.parseDouble(btnState);
		if(neNum)IntNum = -IntNum;
        if(result==0) result = IntNum;
        else result = result*10 + IntNum;
    }
    private void printFloat(String btnState){
        double floatNum = Double.parseDouble(btnState);
        if(neNum)floatNum = -floatNum;
        for (int i=0; i<floatCount; i++)floatNum = floatNum*0.1;
        floatCount++;
        result = Math.round((result + floatNum) * 1000000.0) / 1000000.0;
    }
%>

<!--�p��(�쬰JAVA�ƥ��ť)-->
<%
	if(request.getParameter("btn") != null){
	//���g�|����OAO
	//NullPointerException
	
		if(hasUsed) {//�M���W�@��
			switch(funct){
				case 1:LastOpr = " + "; break;
	            case 2:LastOpr = " - "; break;
	            case 3:LastOpr = " * "; break;
	            case 4:LastOpr = " / "; break;
	            default:LastOpr = "   ";
			}
			LastCal = Double.toString(Number1)+LastOpr+Double.toString(Number2)+" = ";
			Lastresult = result; result = 0;
			Number1 = Number2 = funct = 0;
			floatUsed = false; floatCount = 1;
			hasUsed = false; neNum = false;
	    }
		
		try{
			
			//�M�����
			if(request.getParameter("btn").equals("C")){
				Number1 = Number2 = funct = result = 0; neNum = false;
				floatUsed = false; floatCount = 1;
			}
			
			//�B��l���s->�s�Ĥ@�ӼƦr�ιB�⤸
			else if(request.getParameter("btn").equals("+")){
				Number1 = (result); neNum = false;
				result = 0; floatUsed = false; floatCount = 1;
				funct = 1;
			}
			else if(request.getParameter("btn").equals("-")){
				//�t��
				if(result == 0){
					neNum = true;
					result = StrictMath.signum(-0.0f);
				}
				//�
				else{
					Number1 = (result);
					result = 0; floatUsed = false; floatCount = 1;
					funct = 2; neNum = false;
				}
			}
			else if(request.getParameter("btn").equals("*")){
				Number1 = (result); neNum = false;
				result = 0; floatUsed = false; floatCount = 1;
				funct = 3;
			}
			else if(request.getParameter("btn").equals("/")){
				Number1 = (result); neNum = false;
				result = 0; floatUsed = false; floatCount = 1;
				funct = 4;
			}
			
			//�������s->�s�ĤG�ӼƦr�íp��//�|�ˤ��J�ܤp���I��6��
			else if(request.getParameter("btn").equals("=")){
				Number2 = (result);
				switch(funct){
					case 1: 
						result = Math.round((Number1 + Number2) * 1000000.0) / 1000000.0;
						break;
		            case 2: 
		            	result = Math.round((Number1 - Number2) * 1000000.0) / 1000000.0;
		            	break;
		            case 3: 
		            	result = Math.round((Number1 * Number2) * 1000000.0) / 1000000.0;
		            	break;
		            case 4: 
		            	result = Math.round((Number1 / Number2) * 1000000.0) / 1000000.0;
		            	break;
		            default: /*ԣ������*/
				}
				hasUsed = true;
			}
			
			//�Ʀr�B�z
			else{
		        if(floatUsed){
		        	if(request.getParameter("btn").equals(".")){/*ԣ������*/}
		            else printFloat(request.getParameter("btn"));
		        }
		        else {
		        	//�Ĥ@�����U�p���I
		        	if(request.getParameter("btn").equals("."))floatUsed = true;
		            else printMath(request.getParameter("btn"));
		        }
			}
		}
		//�����ҥ~���k�s
		catch(NumberFormatException OAO){
	        result = 0;
			Number1 = Number2 = funct = 0;
			floatUsed = false; floatCount = 1;
			hasUsed = false;
			System.out.println(OAO);
    	}
	    catch(ArithmeticException OHO){
	        result = 0; 
			Number1 = Number2 = funct = 0;
			floatUsed = false; floatCount = 1;
			hasUsed = false; neNum = false;
			System.out.println(OHO);
	    }
	}
%>

<!--�D�����]�p-->
<br><br>
<div style= "text-align:center;">
	<font text-align:center; size="16" color="FFAAD5" style="text-shadow:3px 3px 3px #cccccc;" face="monospace">
		Calculator
		<br>
		JSP Homework
	</font>
</div>
<br>
<!--��X�⦡-->
<center>
	<font  size="4" color="555555" face="monospace">
		<%
			if(Number1!=0)out.print(Number1); 
			out.print(" "); 
			if(funct!=0){
				switch(funct){
					case 1:out.print("+");break;
		            case 2:out.print("-");break;
		            case 3:out.print("*");break;
		            case 4:out.print("/");break;
		            default: /*ԣ������*/
				}
			}
			out.print(" "); 
			if(Number2!=0)out.print(Number2); 
		%>
	</font>
</center>
<br>
<form action="cal-110816032.jsp" method="post" name="form1">
<table align="center" bgcolor="FFECEC" border="3">
	<tr>
		<td><!--�p����]�p-->
			<table align="center" bgcolor="FFECEC" border="3">
			   <tr><!--��ܷ�e�Ʀr-->
				 <td align='right' valign="middle" colspan="4" style= "height:40px">
				 	<font  size="6" color="555555" face="monospace">
				 		<%= result %>
				 	</font>
				 </td>
			   </tr>
			   <tr><!--����ϰ�789+-->
			     <td align='center' valign="middle">
			     	<input style= "background-color:#FFECF5;height:50px;width:50px;"
				 		   type="submit" name="btn" value="7" >
			     </td>
			     <td align='center' valign="middle">
			     	<input style= "background-color:#FFECF5;height:50px;width:50px;"
				 		   type="submit" name="btn" value="8" >
			     </td>
			     <td align='center' valign="middle">
			     	<input style= "background-color:#FFECF5;height:50px;width:50px;"
				 		   type="submit" name="btn" value="9" >
			     </td>
			     <td align='center' valign="middle">
			     	<input style= "background-color:#FFFCEC;height:50px;width:50px;"
				 		   type="submit" name="btn" value="+" >
			     </td>
			   </tr>
			   <tr><!--����ϰ�456--->
			     <td align='center' valign="middle">
			     	<input style= "background-color:#FFD9EC;height:50px;width:50px;"
				 		   type="submit" name="btn" value="4" >
			     </td>
			     <td align='center' valign="middle">
			     	<input style= "background-color:#FFD9EC;height:50px;width:50px;"
				 		   type="submit" name="btn" value="5" >
			     </td>
			     <td align='center' valign="middle">
			     	<input style= "background-color:#FFD9EC;height:50px;width:50px;"
				 		   type="submit" name="btn" value="6" >
			     </td>
			     <td align='center' valign="middle">
			     	<input style= "background-color:#FFF8D7;height:50px;width:50px;"
				 		   type="submit" name="btn" value="-" >
			     </td>
			   </tr>
			   <tr><!--����ϰ�123*-->
			     <td align='center' valign="middle">
			     	<input style= "background-color:#FFC1E0;height:50px;width:50px;"
				 		   type="submit" name="btn" value="1" >
			     </td>
			     <td align='center' valign="middle">
			     	<input style= "background-color:#FFC1E0;height:50px;width:50px;"
				 		   type="submit" name="btn" value="2" >
			     </td>
			     <td align='center' valign="middle">
			     	<input style= "background-color:#FFC1E0;height:50px;width:50px;"
				 		   type="submit" name="btn" value="3" >
			     </td>
			     <td align='center' valign="middle">
			     	<input style= "background-color:#FFF4C1;height:50px;width:50px;"
				 		   type="submit" name="btn" value="*" >
			     </td>
			   </tr>
			   <tr><!--����ϰ�C0./-->
			     <td align='center' valign="middle">
			     	<input style= "background-color:#FFAAD5;height:50px;width:50px;"
				 		   type="submit" name="btn" value="C" >
			     </td>
			     <td align='center' valign="middle">
			     	<input style= "background-color:#FFAAD5;height:50px;width:50px;"
				 		   type="submit" name="btn" value="0" >
			     </td>
			     <td align='center' valign="middle">
			     	<input style= "background-color:#FFAAD5;height:50px;width:50px;"
				 		   type="submit" name="btn" value="." >
			     </td>
			     <td align='center' valign="middle">
			     	<input style= "background-color:#FFF0AC;height:50px;width:50px;"
				 		   type="submit" name="btn" value="/" >
			     </td>
			   </tr>
			   <tr>
				 <td align='center' valign="middle" colspan="4">
				 	<input style= "background-color:#FFE4CA;height:50px;width:220px;"
				 		   type="submit" name="btn" value="=" >
				 </td>
			   </tr>
			</table>
		</td>
		<td><!--�W�@������-->
			<table bgcolor="FFECEC" border="3">
			   <tr>
				 <td align='center' valign="middle" style= "height:40px;width:220px;">
				 	<font  size="6" color="AAAAAA" face="monospace">
				 		History
				 	</font>
				 </td>
			   </tr>
			   <tr>
				 <td align='center' valign="middle" style= "height:278px;">
				 	<font  size="4" color="555555" face="monospace">
				 		<% out.println(LastCal); %>
				 	</font>
				 	<br>
				 	<font  size="6" color="555555" face="monospace">
				 		<% out.println(Lastresult); %>
				 	</font>
				 </td>
			   </tr>
			</table>
		</td>
	</tr>
</table>
</form>
</BODY>
</HTML>