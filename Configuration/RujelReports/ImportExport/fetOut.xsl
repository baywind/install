<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" />

<xsl:variable name="options" select="document('options.xml')/options"/>
<xsl:key name="grByGrade" match="eduGroups/eduGroup" use="@grade"/>

<xsl:template match="/">
<fet version="5.13.0">

<Institution_Name><xsl:value-of select="ejdata/school/@title"/></Institution_Name>

<Comments><xsl:value-of select="$options/info/eduYear"/></Comments>

<Hours_List>
	<Number>8</Number>
	<Name>1</Name>
	<Name>2</Name>
	<Name>3</Name>
	<Name>4</Name>
	<Name>5</Name>
	<Name>6</Name>
	<Name>7</Name>
	<Name>8</Name>
</Hours_List>

<Days_List>
	<Number>6</Number>
	<Name>Пн</Name>
	<Name>Вт</Name>
	<Name>Ср</Name>
	<Name>Чт</Name>
	<Name>Пт</Name>
	<Name>Сб</Name>
</Days_List>

<xsl:apply-templates/>

<Space_Constraints_List>
<ConstraintBasicCompulsorySpace>
	<Weight_Percentage>100</Weight_Percentage>
</ConstraintBasicCompulsorySpace>
</Space_Constraints_List>

</fet>
</xsl:template>

<xsl:template match="ejdata">
<Students_List>
	<xsl:apply-templates 
		select="eduGroups/eduGroup[generate-id(.) = generate-id(key('grByGrade',@grade))]"/>
</Students_List>

<Teachers_List>
	<xsl:for-each
		select="courses/course[not(preceding-sibling::course/teacher = teacher)]/teacher">
		<xsl:sort/>
		<xsl:call-template name="teacher"></xsl:call-template>
	</xsl:for-each>
</Teachers_List>

<Subjects_List>
	<xsl:apply-templates select="eduPlan" mode="subjects"/>
</Subjects_List>

<Activity_Tags_List>
</Activity_Tags_List>

<Activities_List>
	<xsl:apply-templates select="courses/course[1]" mode="printCrs"/>
</Activities_List>

<Buildings_List>
</Buildings_List>

<Rooms_List>
</Rooms_List>

<Time_Constraints_List>
<ConstraintBasicCompulsoryTime>
	<Weight_Percentage>100</Weight_Percentage>
</ConstraintBasicCompulsoryTime>
	<xsl:apply-templates select="courses/course[1]" mode="constraint"/>
</Time_Constraints_List>

</xsl:template>

<xsl:template match="eduGroup">
<Year>
<Name><xsl:value-of select="@grade"></xsl:value-of></Name>
<Number_of_Students>0</Number_of_Students>
<xsl:apply-templates mode="next" select="key('grByGrade',@grade)"/>
<xsl:if test="//eduGroup[@grade = current()/@grade and @type='mixed']">
	<Group>
	<Name><xsl:value-of select="@grade"/> ???</Name>
	<Number_of_Students>0</Number_of_Students>
	</Group>
</xsl:if>
</Year>
</xsl:template>

<xsl:template match="eduGroup" mode="next">
	<Group>
	<Name><xsl:value-of select="@name"/></Name>
	<Number_of_Students>0</Number_of_Students>
	<xsl:if test="//eduGroup[@id = current()/@id and @type='sub']">
			<Subgroup>
		<Name><xsl:value-of select="@name"/> ??</Name>
		<Number_of_Students>0</Number_of_Students>
		</Subgroup>
	</xsl:if>
	</Group>
</xsl:template>

<xsl:template name="teacher">
<Teacher>
	<Name><xsl:value-of select="."></xsl:value-of></Name>
</Teacher>
</xsl:template>

<xsl:template match="subject" mode="subjects">
<Subject>
	<Name><xsl:value-of select="@title"/></Name>
</Subject>
</xsl:template>

<xsl:template match="course" mode="printCrs">
	<xsl:param name="actGroup" select="1"/>
	<xsl:variable name="hours" select="//cycle[@id = current()/@cycle]/hours"/>
	<xsl:choose><xsl:when test="$hours">
		<xsl:call-template name="activity">
			<xsl:with-param name="actGroup" select="$actGroup"/>
			<xsl:with-param name="hours" select="$hours"/>
			<xsl:with-param name="num" select="0"/>
		</xsl:call-template>
		<xsl:apply-templates select="following-sibling::course[1]"  mode="printCrs">
			<xsl:with-param name="actGroup" select="$actGroup + $hours"/>
		</xsl:apply-templates>
	</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="following-sibling::course[1]"  mode="printCrs">
				<xsl:with-param name="actGroup" select="$actGroup"/>
			</xsl:apply-templates>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="activity">
	<xsl:param name="actGroup"/>
	<xsl:param name="hours"/>
	<xsl:param name="num"/>
<Activity>
	<xsl:if test="teacher">
	<Teacher><xsl:value-of select="teacher"/></Teacher>
	</xsl:if>
	<Subject><xsl:value-of select="@subject"/></Subject>
	<Duration>1</Duration>
	<Total_Duration><xsl:value-of select="$hours"/></Total_Duration>
	<Id><xsl:value-of select="$actGroup + $num"/></Id>
	<Activity_Group_Id><xsl:choose>
		<xsl:when test="$hours &gt; 1"><xsl:value-of select="$actGroup"/></xsl:when>
		<xsl:otherwise>0</xsl:otherwise>
	</xsl:choose></Activity_Group_Id>
	<Active>true</Active>
	<xsl:apply-templates mode = "crsGrp"/>
</Activity>
	<xsl:if test="$num + 1 &lt; $hours">
		<xsl:call-template name="activity">
			<xsl:with-param name="actGroup" select="$actGroup"/>
			<xsl:with-param name="hours" select="$hours"/>
			<xsl:with-param name="num" select="$num + 1"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template match="eduGroup" mode = "crsGrp">
	<Students><xsl:choose>
		<xsl:when test="@type = 'full'"><xsl:value-of select="@name"/></xsl:when>
		<xsl:when test="@type = 'sub'"><xsl:value-of select="@name"/> ??</xsl:when>
		<xsl:otherwise><xsl:value-of select="@grade"/> ???</xsl:otherwise>
	</xsl:choose></Students>
</xsl:template>

<xsl:template match="text()" mode="crsGrp"/>

<xsl:template match="course" mode="constraint">
	<xsl:param name="actGroup" select="1"/>
	<xsl:variable name="hours" select="//cycle[@id = current()/@cycle]/hours"/>
	<xsl:choose><xsl:when test="$hours">
	<xsl:if test="$hours &gt; 1">
<ConstraintMinDaysBetweenActivities>
	<Weight_Percentage>95</Weight_Percentage>
	<Consecutive_If_Same_Day>true</Consecutive_If_Same_Day>
	<Number_of_Activities><xsl:value-of select="$hours"/></Number_of_Activities>
	<xsl:call-template name="constraint">
		<xsl:with-param name="actGroup" select="$actGroup"/>
		<xsl:with-param name="hours" select="$hours"/>
		<xsl:with-param name="num" select="0"/>
	</xsl:call-template>
	<MinDays>1</MinDays>
</ConstraintMinDaysBetweenActivities>	
	</xsl:if>
	<xsl:apply-templates select="following-sibling::course[1]"  mode="constraint">
		<xsl:with-param name="actGroup" select="$actGroup + $hours"/>
	</xsl:apply-templates>
	</xsl:when>
	<xsl:otherwise>
		<xsl:apply-templates select="following-sibling::course[1]"  mode="constraint">
			<xsl:with-param name="actGroup" select="$actGroup"/>
		</xsl:apply-templates>
	</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="constraint">
	<xsl:param name="actGroup"/>
	<xsl:param name="hours"/>
	<xsl:param name="num"/>
	<Activity_Id><xsl:value-of select="$actGroup + $num"/></Activity_Id>
	<xsl:if test="$num + 1 &lt; $hours">
		<xsl:call-template name="constraint">
			<xsl:with-param name="actGroup" select="$actGroup"/>
			<xsl:with-param name="hours" select="$hours"/>
			<xsl:with-param name="num" select="$num + 1"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template match="text()" mode="constraint"/>


</xsl:stylesheet>