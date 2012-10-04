<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes"/>

<xsl:variable name="persdata" select="document('persdata.xml')/persdata"/>
<xsl:variable name="options" select="document('options.xml')/options"/>

<xsl:template match="/">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ru" lang="ru">
    <head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="generator" content="Rujel XSLT" />
        <title>Текущая успеваемость
        	<xsl:if test="$options/info/period"> : 
        	 <xsl:value-of select="$options/info/period"/></xsl:if></title>
	<style type="text/css">
	.student {
		font-size:large;
		font-weight:bold;
		padding-left:2em;
	}
	
	.dates {
		padding-left:3em;
		font-style:italic;
		white-space:nowrap;
	}

	.sup {
		vertical-align: baseline;
		position: relative;
		top: -1em;
		font-size:60%;
	}
	
	.subject {
		font-size: 120%;
		font-weight: bold;
		text-decoration: underline;
		text-align: left;
	}
	</style>

</head>
<body>
	<xsl:choose>
		<xsl:when test="$options/studentID">
			<xsl:call-template name="print_student">
				<xsl:with-param name="curr-student" select="$options/studentID"/>
				<xsl:with-param name="curr-group" select="ejdata/eduGroups/eduGroup/@id"/>
			</xsl:call-template>
		</xsl:when><xsl:otherwise>
			<xsl:for-each select="ejdata/eduGroups/eduGroup/student">
				<xsl:call-template name="print_student">
					<xsl:with-param name="curr-student" select="@id"/>
					<xsl:with-param name="curr-group" select="../@id"/>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:otherwise>
	</xsl:choose>
</body></html>
</xsl:template>

<xsl:template name="print_student">
	<xsl:param name="curr-student"/>
	<xsl:param name="curr-group"/>
	<div class="studentContainer">
	<xsl:if test="$options/info/eduYear">
	<div style="float:right;font-size:large;"><xsl:value-of select="$options/info/eduYear"/></div>
	</xsl:if>
	<h1>Текущая успеваемость
        	<xsl:if test="$options/info/period"> : 
        	 <xsl:value-of select="$options/info/period"/></xsl:if></h1>
	<xsl:variable name="student" select="$persdata/person[@type='student' and @id=$curr-student]"/>
	<div class="student">Ученик : 
		<xsl:value-of select="$student/name[@type='last']"/><xsl:text> </xsl:text>
		<xsl:value-of select="$student/name[@type='first']"/><!-- xsl:text> </xsl:text>
		<xsl:value-of select="$student/name[@type='second']"/ --><xsl:text> , </xsl:text>
		<xsl:value-of select="/ejdata/eduGroups/eduGroup[@id=$curr-group]/@name"/></div>
	<xsl:if test="$options/info/dates">
	<div class = "dates"><xsl:value-of select="$options/info/dates"/></div>
	</xsl:if>
	<table style="margin-top: 1em; width: 100%;" border="0">
		<xsl:for-each 
select="/ejdata/courses/course[eduGroup[@type='full' and @id=$curr-group] or eduGroup/student[@id=$curr-student] or containers/descendant::mark[@student=$curr-student]]">
			<xsl:call-template name="print_course">
				<xsl:with-param name="stid" select="$curr-student"/>
			</xsl:call-template>
			<tr height="5"></tr>
		</xsl:for-each>
	</table>
	<br clear = "all" />
	<table border="0" width="100%" style="margin:2ex 0;">
	<tr><td align="left" width="50%">
		Подпись классного руководителя:
	</td><td align="left" width="50%">
		Подпись родителя
	</td></tr></table>
	</div>
</xsl:template>

<xsl:template match="course" name = "print_course">
	<xsl:param name="stid"/>
	<xsl:variable name="teacher" 
			select="$persdata/person[@type='teacher' and @id=current()/teacher/@id]"/>
	<tr><td class = "subject">
	<xsl:if test="/eduPlan/subject[cycle[@id=current()/@cycle]]/content">
		<xsl:attribute name="title">
			<xsl:value-of select="/eduPlan/subject[cycle[@id=current()/@cycle]]/content"/>
		</xsl:attribute>
	</xsl:if>
		<xsl:value-of select="@subject"/></td>
		<td align = "left" style="font-style: italic;">
			<xsl:value-of select="comment"/>
		</td>
		<td align= "right">
		<xsl:value-of select="$teacher/name[@type='last']"/><xsl:text> </xsl:text>
		<xsl:value-of select="$teacher/name[@type='first']"/><xsl:text> </xsl:text>
		<xsl:value-of select="$teacher/name[@type='second']"/></td>
	</tr>
		<xsl:if test="$options/autoitog/active = 'true'">
			<xsl:for-each select="containers[@type = 'prognosis']">
				<xsl:call-template name="prognosis">
					<xsl:with-param name="stid" select="$stid"/>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:if>
		<xsl:for-each select="containers">
			<xsl:if test="@type = 'work' and $options/marks/active = 'true'">
				<xsl:call-template name="works">
					<xsl:with-param name="stid" select="$stid"/>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="@type = 'lesson' and $options/lessons/active = 'true'">
				<xsl:call-template name="lessons">
					<xsl:with-param name="stid" select="$stid"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:for-each>
</xsl:template>

<xsl:template match="containers[@type='work']" name = "works">
	<xsl:param name="stid"/>
	<xsl:variable name="lvl" select="$options/marks/level"/>
	<xsl:variable name="list"
select="container[$lvl > 2 or calc/@compulsory = 'true' or ($lvl = 2 and marks) or ($lvl = 1 and marks/mark[@student = $stid])]"/>
	<xsl:if test="$list">
	<tr><td colspan="3">
 <strong style="font-size:110%;">Работы: </strong>
	<xsl:for-each select="$list">
		<xsl:call-template name="work">
			<xsl:with-param name="stid" select="$stid"/>
		</xsl:call-template>
		<xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if>
	</xsl:for-each>
	</td></tr></xsl:if>
</xsl:template>

<xsl:template match="container" name = "work">
	<xsl:param name="stid"/>
	<xsl:variable name="criteria" select="criteria/criterion"/>
	<xsl:variable name="mark" select="marks/mark[@student=$stid]"/>
	<xsl:variable name="brace" select="$criteria[@idx > 0] or 
	(($criteria or $mark/@value) and ($mark/comment or $mark/weblink))"/>
	<span style="font-family: serif;" class="withWeight">
		<xsl:attribute name="title">
			<xsl:value-of select="content"/><xsl:if test="calc/@weight and calc/@weight != 1">
&lt;вес : <xsl:value-of select="calc/@weight"/>&gt;</xsl:if> (<xsl:value-of select="@type"/>)</xsl:attribute>
		<xsl:attribute name="style">
			font-family:<xsl:if test="calc/@compulsory = 'true'">sans-</xsl:if>serif;
			<xsl:choose>
				<xsl:when test="task">cursor:pointer;color:blue;</xsl:when>
				<xsl:when test="not(calc/@weight)">color:#666666;</xsl:when>
			</xsl:choose>
		</xsl:attribute>
		<xsl:if test="task"><xsl:attribute name="onclick">
			window.open('<xsl:value-of select="task"/>','_blank');
		</xsl:attribute></xsl:if>
	<xsl:if test="$brace">[</xsl:if>
	<xsl:choose>
		<xsl:when test="$criteria"><xsl:for-each select="$criteria">
		<xsl:if test="current()/@idx > 0"><xsl:value-of select="@title"/>:</xsl:if><xsl:choose>
					<xsl:when test="$mark/crmark[@criter=current()/@idx]">
						<xsl:value-of select="$mark/crmark[@criter=current()/@idx]/@value"/>
						<xsl:if test="$options/marks/hideMax != 'true'">
						<sub style = "font-size:60%;color:#999999">
						<xsl:value-of select="@max"/></sub></xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text disable-output-escaping="yes">&amp;oslash;</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="position() != last() or $mark/comment or $mark/weblink">
					<xsl:text disable-output-escaping="yes">,&amp;nbsp;</xsl:text></xsl:if>
			</xsl:for-each>
				<xsl:value-of select="$mark/comment"/>
				<xsl:if test="$mark/weblink"><a target = "_blank">
					<xsl:attribute name="href"><xsl:value-of select="$mark/weblink"/></xsl:attribute>
					<xsl:text disable-output-escaping="yes">&amp;gt;&amp;gt;</xsl:text>
				</a></xsl:if>
		</xsl:when>
		<xsl:when test="$mark/@value or $mark/comment or $mark/weblink">
			<xsl:value-of select="$mark/@value"/>
			<xsl:if test="$mark/@value and $mark/comment">
				<xsl:text disable-output-escaping="yes">,&amp;nbsp;</xsl:text>
			</xsl:if>
			<xsl:value-of select="$mark/comment"/>
			<xsl:if test="$mark/weblink"><a target = "_blank">
				<xsl:attribute name="href"><xsl:value-of select="$mark/weblink"/></xsl:attribute>
				<xsl:text disable-output-escaping="yes">&amp;gt;&amp;gt;</xsl:text>
			</a></xsl:if>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text disable-output-escaping="yes">&amp;oslash;</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
	<xsl:if test="$brace">]</xsl:if>
	</span>
</xsl:template>

<xsl:template match="containers[@type='lesson']" name = "lessons">
	<xsl:param name="stid"/>	
	<xsl:variable name="lessons" select="container[marks/mark[@student=$stid]]"/>
	<xsl:if test="$lessons">
	<tr><td colspan="3">
 		<strong style="font-size:110%;">Уроки: </strong>
 		<xsl:for-each select="$lessons">
 			<xsl:variable name="pos" select="position()"/>
 			<xsl:if test="$pos = 1 or substring(@date,6,2) != substring($lessons[$pos -1]/@date,6,2)">
 			<xsl:call-template name="month">
 				<xsl:with-param name="num" select="substring(@date,6,2)"/>
 			</xsl:call-template>
 			</xsl:if>
 			<!-- <xsl:value-of select="@date"/> -->
 			<span><xsl:attribute name="title"><xsl:value-of select="content"/></xsl:attribute>
 			<span style="color:#666666;"><xsl:value-of select="substring(@date,9)"/>:</span>
  			<xsl:value-of select="marks/mark[@student=$stid]/@value"/></span>
  			<xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if>
 		</xsl:for-each> 
 	</td></tr>
	</xsl:if>
</xsl:template>

<xsl:template match="containers[@type='prognosis']" name = "prognosis">
	<xsl:param name="stid"/>
	<xsl:variable name="list" select="container[marks/mark[@student=$stid]]"/>
	<xsl:if test="$list">
	<tr><td colspan="3">
 	<xsl:for-each select="$list">
 		<xsl:if test="position() > 1"><br/></xsl:if>
 		<strong style="font-size:110%;">Прогноз: </strong>
 		<xsl:value-of select="@title"/> : 
 		<xsl:call-template name="progn">
 			<xsl:with-param name="mark" select="marks/mark[@student=$stid]"/>
 		</xsl:call-template>
 	</xsl:for-each>
 	</td></tr>
 	</xsl:if>
</xsl:template>

<xsl:template name="progn">
	<xsl:param name="mark"/>
	<strong style="font-size:120%;"><xsl:value-of select="$mark/@value"/></strong>
	<xsl:if test="$mark/param[@key='timeout']">
		<em> Отсрочка до
		<xsl:call-template name="formatDate">
			<xsl:with-param name="date" select="$mark/param[@key='timeout']"/>
		</xsl:call-template><xsl:text> </xsl:text>
		<xsl:if test="$mark/param[@key='timeoutReason']">
			<span style="color:#666666;"> 
			(<xsl:value-of select="$mark/param[@key='timeoutReason']"/>)</span>
		</xsl:if></em>
	</xsl:if>
</xsl:template>

<xsl:template name="month">
	<xsl:param name="num"/>
	<strong style="color:#666666;">
	<xsl:choose>
		<xsl:when test="$num = '01'">Январь</xsl:when>
		<xsl:when test="$num = '02'">Февраль</xsl:when>
		<xsl:when test="$num = '03'">Март</xsl:when>
		<xsl:when test="$num = '04'">Апрель</xsl:when>
		<xsl:when test="$num = '05'">Май</xsl:when>
		<xsl:when test="$num = '06'">Июнь</xsl:when>
		<xsl:when test="$num = '07'">Июль</xsl:when>
		<xsl:when test="$num = '08'">Август</xsl:when>
		<xsl:when test="$num = '09'">Сентябрь</xsl:when>
		<xsl:when test="$num = '10'">Октябрь</xsl:when>
		<xsl:when test="$num = '11'">Ноябрь</xsl:when>
		<xsl:when test="$num = '12'">Декабрь</xsl:when>
	</xsl:choose>
 	<xsl:text>: </xsl:text></strong>
</xsl:template>

<xsl:template name="formatDate">
	<xsl:param name="date"/>
	<xsl:value-of select="substring($date, 9)"/>.<xsl:value-of 
			select="substring($date, 6, 2)"/>.<xsl:value-of 
			select="substring($date, 0, 5)"/>
</xsl:template>

</xsl:stylesheet>