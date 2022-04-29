<%@ page contentType="text/html; charset=Big5" %>
<HTML>
<HEAD>
<TITLE>cal-110816032</TITLE>
<!--
	姓名:謝妤婕
    學號:110816032
    操作說明:
        1. 當成一般按鍵式計算機使用輸入數字(第一個運算元)
        2. 若數字為0 按下減號會作為負號
        3. 按下運算子
        4. 輸入第二個運算元
        5. 按下最下方的等號(如果這時候按下運算子，第二個運算元將取代第一個運算元)
        6. 感謝您的使用(小數點後四捨五入取到第6位)
   自評分數:
        按評分標準100分啦
        支援負號、小數點運算
        有做歷史紀錄 跟 不用特別按清除就可以做下一輪運算
        拜託加分加爆啦QuQQQQQ
-->
</HEAD>
<BODY style="background-color:#FFECF5;">


<!--宣告變數函式-->
<%!
	boolean hasUsed = false;//上一輪結果是否存在
	double Lastresult = 0;//上一輪的答案
	String LastCal = "";//上一輪的算式本體
	String LastOpr = "";//上一輪的運算子
	
	double Number1 = 0;//運算元1
	double Number2 = 0;//運算元2
	int funct = 0;  //運算子(1(add)、2(subtract)、3(multiply)、4(divide))
	
	boolean floatUsed = false;//是否用到小數點
	int floatCount = 1;//小數點後第幾位
	
	boolean neNum = false;//是否用到負號
	
	double result = 0;  //格子上的數字(顯示區)
	//紀錄當前數字變化 //String btnState 是 request.getParameter("btn")
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

<!--計算(原為JAVA事件監聽)-->
<%
	if(request.getParameter("btn") != null){
	//不寫會報錯OAO
	//NullPointerException
	
		if(hasUsed) {//清除上一輪
			switch(funct){
				case 1:LastOpr = " + "; break;
	            case 2:LastOpr = " - "; break;
	            case 3:LastOpr = " * "; break;
	            case 4:LastOpr = " / "; break;
	            default:LastOpr = "   ";
			}
			LastCal = Double.toString(Number1)+LastOpr+Double.toString(Number2)+" = ";
			Lastresult = result; result = 0;
			Number1 = Number2 = 0; funct = 0;
			floatUsed = false; floatCount = 1;
			hasUsed = false; neNum = false;
	    }
		
		try{
			
			//清除資料
			if(request.getParameter("btn").equals("C")){
				Number1 = Number2 = funct = result = 0; neNum = false;
				floatUsed = false; floatCount = 1;
			}
			
			//運算子按鈕->存第一個數字及運算元
			else if(request.getParameter("btn").equals("+")){
				Number1 = (result); neNum = false;
				result = 0; floatUsed = false; floatCount = 1;
				funct = 1;
			}
			else if(request.getParameter("btn").equals("-")){
				//負號
				if(result == 0){
					neNum = true;
					result = StrictMath.signum(-0.0f);
				}
				//減號
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
			
			//等號按鈕->存第二個數字並計算//四捨五入至小數點後6位
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
		            default: /*啥都不做*/
				}
				hasUsed = true;
			}
			
			//數字處理
			else{
		        if(floatUsed){
		        	if(request.getParameter("btn").equals(".")){/*啥都不做*/}
		            else printFloat(request.getParameter("btn"));
		        }
		        else {
		        	//第一次按下小數點
		        	if(request.getParameter("btn").equals("."))floatUsed = true;
		            else printMath(request.getParameter("btn"));
		        }
			}
		}
		//捕捉例外並歸零
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

<!--主頁面設計-->
<br><br>
<div style= "text-align:center;">
	<font text-align:center; size="16" color="FFAAD5" style="text-shadow:3px 3px 3px #cccccc;" face="monospace">
		Calculator
		<br>
		JSP Homework
	</font>
</div>
<br>
<!--輸出算式-->
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
		            default: /*啥都不做*/
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
		<td><!--計算機設計-->
			<table align="center" bgcolor="FFECEC" border="3">
			   <tr><!--顯示當前數字-->
				 <td align='right' valign="middle" colspan="4" style= "height:40px">
				 	<font  size="6" color="555555" face="monospace">
				 		<%= result %>
				 	</font>
				 </td>
			   </tr>
			   <tr><!--按鍵區域789+-->
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
			   <tr><!--按鍵區域456--->
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
			   <tr><!--按鍵區域123*-->
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
			   <tr><!--按鍵區域C0./-->
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
		<td><!--上一輪紀錄-->
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
