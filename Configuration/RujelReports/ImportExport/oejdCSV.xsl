<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" indent="no" omit-xml-declaration="yes"
		media-type="text/csv" encoding="windows-1251"/>
<xsl:strip-space elements="*"/>

<xsl:variable name="persdata" select="document('persdata.xml')/persdata"/>
<xsl:variable name="options" select="document('options.xml')/options"/>
<xsl:variable name="schoolGUID"><xsl:text>{</xsl:text>
	<xsl:value-of select="$options/info/extraData/schoolGUID"/><xsl:text>};</xsl:text>
</xsl:variable>
<xsl:variable name="schoolData"><xsl:value-of select="$schoolGUID"/>
	<xsl:value-of select="$options/info/extraData/title"/><xsl:text>;</xsl:text>
	<xsl:value-of select="$options/info/extraData/fullTitle"/><xsl:text>;</xsl:text>
	<xsl:value-of select="$options/info/extraData/district"/><xsl:text>;</xsl:text></xsl:variable>
<xsl:variable name="base" select="/ejdata/@base"/>
<xsl:variable name="tutors" select="/ejdata/eduGroups/eduGroup/teacher/@id"/>


<xsl:template match="text()"/>

<xsl:template match="/">
<xsl:if test="$options/byContact/sendAll"><xsl:value-of select="$options/byContact/sendAll"/></xsl:if>
<xsl:text>GUID [guid] школы;Название [nvarchar(100)];Полное название (опционально) [nvarchar(500)];</xsl:text>
<xsl:text>Округ города (nvarchar(300));GUID [guid] класса;GUID [guid] школы;Литера [nvarchar(1)];</xsl:text>
<xsl:text>Параллель [tinyint];Учебный год [int];Группа отчетных периодов [nvarchar(50)];</xsl:text>
<xsl:text>Описание  (опционально) [nvarchar(200)];GUID [guid] персоны;Имя [nvarchar(50)];</xsl:text>
<xsl:text>Фамилия [nvarchar(50)];Отчество (опционально) [nvarchar(50)];Дата рождения [date];</xsl:text>
<xsl:text>Пол [nvarchar(10)];E-mail (опционально)  [nvarchar(200)];GUID [guid] персоны;</xsl:text>
<xsl:text>GUID [guid] школы;GUID [guid] класса;Роль [nvarchar(20)];GUID родителя [guid];GUID [guid] персоны;</xsl:text>
<xsl:text>&#xd;&#xa;</xsl:text>
	<xsl:apply-templates select="ejdata/eduGroups"/>
	<xsl:for-each select="$persdata/person[@type = 'teacher']">
		<xsl:if test="not (@id = $tutors)">
			<xsl:value-of select="$schoolData"/><xsl:text>;;;;;;;</xsl:text>
			<xsl:call-template name="person">
				<xsl:with-param name="pers" select="current()"/>
			</xsl:call-template>
			<xsl:text>;Учитель;;&#xd;&#xa;</xsl:text>
		</xsl:if>
	</xsl:for-each>
</xsl:template>

<xsl:template match="eduGroup">
	<xsl:apply-templates>
		<xsl:with-param name="groupData">
			<xsl:call-template name="guid"/>
			<xsl:value-of select="$schoolGUID"/>
			<xsl:value-of select="@title"/><xsl:text>;</xsl:text>
			<xsl:value-of select="@grade"/><xsl:text>;</xsl:text>
			<xsl:value-of select="/ejdata/@eduYear"/><xsl:text>;</xsl:text>
			<xsl:value-of select="syncdata/param[@key='itogList']"/>
			<xsl:text>;;</xsl:text>
		</xsl:with-param>
	</xsl:apply-templates>
</xsl:template>

<xsl:template name="person">
	<xsl:param name="pers"/>
	<xsl:call-template name="guid">
		<xsl:with-param name="syncdata" select="$pers/syncdata"/>
	</xsl:call-template>
	<xsl:choose>
	<xsl:when test="not($options/byContact) or $options/byContact=0 or $pers/@type='teacher' or $pers/syncdata/param[@key='contactFlags']">
	<xsl:value-of select="$pers/name[@type='first']"/><xsl:text>;</xsl:text>
	<xsl:value-of select="$pers/name[@type='last']"/><xsl:text>;</xsl:text>
	<xsl:value-of select="$pers/name[@type='second']"/><xsl:text>;</xsl:text>
	<xsl:call-template name="formatDate">
		<xsl:with-param name="date" select="$pers/date[@type='birth']"/>
	</xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
	<xsl:variable name="guid" select="translate($pers/syncdata/extid[@product='GUID' and @base=$base],
		'0123456789abcdef','иклмнопрстабвгде')"/>
	<xsl:value-of select="substring($guid,1,8)"/><xsl:text>;</xsl:text>
	<xsl:value-of select="substring($guid,10,4)"/><xsl:value-of select="substring($guid,15,4)"/>
	<xsl:value-of select="substring($guid,20,4)"/><xsl:text>;</xsl:text>
	<xsl:value-of select="substring($guid,25,12)"/><xsl:text>;</xsl:text>
	</xsl:otherwise>
	</xsl:choose>
	<xsl:text>;</xsl:text>
	<xsl:choose>
		<xsl:when test="$pers/@sex='male'"><xsl:text>м</xsl:text></xsl:when>
		<xsl:when test="$pers/@sex='female'"><xsl:text>ж</xsl:text></xsl:when>
	</xsl:choose>
	<xsl:text>;;</xsl:text>
	<xsl:call-template name="guid">
		<xsl:with-param name="syncdata" select="$pers/syncdata"/>
	</xsl:call-template>
	<xsl:value-of select="$schoolGUID"/>
</xsl:template>

<xsl:template match="student">
	<xsl:param name="groupData"/>
	<xsl:variable name="pers"  select="$persdata/person[@id=current()/@id and @type='student']"/>
	<xsl:if test="not($options/byContact) or $options/byContact=0 or $options/byContact=2 or $pers/syncdata/param[@key='contactFlags']">
	<xsl:value-of select="$schoolData"/><xsl:value-of select="$groupData"/>
	<xsl:call-template name="person">
		<xsl:with-param name="pers" select="$pers"/>
	</xsl:call-template>
	<xsl:call-template name="guid">
		<xsl:with-param name="syncdata" select="../syncdata"/>
	</xsl:call-template>
	<xsl:text>Ученик;;&#xd;&#xa;</xsl:text></xsl:if>
</xsl:template>

<xsl:template match="teacher">
	<xsl:param name="groupData"/>
	<xsl:value-of select="$schoolData"/><xsl:value-of select="$groupData"/>
	<xsl:call-template name="person">
		<xsl:with-param name="pers" select="$persdata/person[@id=current()/@id and @type='teacher']"/>
	</xsl:call-template>
	<xsl:call-template name="guid">
		<xsl:with-param name="syncdata" select="../syncdata"/>
	</xsl:call-template>
	<xsl:text>Учитель;;&#xd;&#xa;</xsl:text>
</xsl:template>

<xsl:template name="guid">
	<xsl:param name="syncdata" select="syncdata"/>
	<xsl:text>{</xsl:text>
	<xsl:value-of select="translate($syncdata/extid[@product='GUID' and @base=$base],
		'abcdef','ABCDEF')"/>
	<xsl:text>};</xsl:text>
</xsl:template>

<xsl:template name="formatDate">
	<xsl:param name="date"/>
	<xsl:if test="$date">
		<xsl:value-of select="substring($date, 9)"/><xsl:text>.</xsl:text>
		<xsl:value-of select="substring($date, 6, 2)"/><xsl:text>.</xsl:text>
		<xsl:value-of select="substring($date, 0, 5)"/>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>