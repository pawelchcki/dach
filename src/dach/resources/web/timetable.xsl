<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:func="http://chojnacki.ws/functions" exclude-result-prefixes="xs func">
<xsl:output method="xhtml" omit-xml-declaration="yes" />
<xsl:variable name="loc" select="'../../../..'"/>
<!-- <xsl:variable name="loc" select="'/root'"/> -->

<xsl:variable name="stops_d" select="doc(concat($loc, '/stops.xml'))" as="document-node()"/>
<xsl:variable name="dist_d" select="doc(concat($loc, '/distances.xml'))" as="document-node()"/>
<xsl:key name="stops_key"  match="stops/stop" use="@id"/>
<xsl:key name="dist_key" match="distance" use="id"/>

<xsl:function name="func:repr_dist" as="element()*">
    <xsl:param name="id"/>
    <xsl:param name="high"/>
    <xsl:param name="low"/>
    <xsl:element name="distance">
        <id><xsl:value-of select="$id"/></id>
        <high><xsl:value-of select="$high"/></high>
        <low><xsl:value-of select="$low"/></low>
    </xsl:element>
</xsl:function>

<xsl:function name="func:create_id">
    <xsl:param name="from"/>
    <xsl:param name="to"/>
    <xsl:value-of select="concat($from, ':', $to)"/>
</xsl:function>

<xsl:variable name="_tmp_lookup">
    <xsl:for-each select="$dist_d//distances/distance">
        <xsl:copy-of select="func:repr_dist(func:create_id(@from-stop, @to-stop), @high-traffic, @low-traffic)"/>
    </xsl:for-each>
</xsl:variable>

<xsl:variable name="_distance_lookup">
    <xsl:for-each select="$stops_d//stops/stop"> 
      <!-- setup lookup for 'self' references :1 :2 :3 etc -->
        <xsl:copy-of select="func:repr_dist(func:create_id('', @id), 0, 0)"/>
        <xsl:variable name="iter" select='.'/>
        
<!--         create lookups for all id combinations... ugh I know, but it simplifies other calculations so bite my shiny metal ass  -->
        <xsl:for-each select="$stops_d//stops/stop">

            <xsl:variable name="_id" select='func:create_id($iter/@id, @id)'/>
            <xsl:choose>
<!--         copy lookups from input data -->
                <xsl:when test="exists(key('dist_key', $_id, $_tmp_lookup))">
                    <xsl:copy-of select="key('dist_key', $_id, $_tmp_lookup)"/>
                </xsl:when>
                <xsl:otherwise>
<!--                 make up lookups -->
                    <xsl:copy-of select="func:repr_dist(func:create_id($iter/@id, @id), -4, -2)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:for-each>
</xsl:variable>

<xsl:function name="func:recurse_distance">
    <xsl:param name="route" />
    <xsl:param name="pos" as="xs:numeric"/>
    <xsl:variable name="_res">
	    <xsl:choose>
	        <xsl:when test="$pos < 2">
	           <high>0</high>
	           <low>0</low>
	        </xsl:when>
	        <xsl:otherwise>
	           <xsl:copy-of select="func:recurse_distance($route, $pos -1 )"/>
	        </xsl:otherwise>
	    </xsl:choose>
	</xsl:variable>
	<xsl:variable name="_l_id" select="func:create_id($pos-1, $pos)"/>
	<high>
	   <xsl:value-of select="$_res/high + key('dest_key', $_l_id, $_distance_lookup)/high"/>
	</high>
	<low>
	   <xsl:value-of select="$_res/low + key('dest_key', $_l_id, $_distance_lookup)/low"/>
	</low>
</xsl:function>

<!-- <xsl:function name="func:to_minutes" as="xs:integer"> -->
<!--     <xsl:variable name="dupa" select="'123'"/>     -->
<!-- </xsl:function> -->
<xsl:template match="/">
  <a>
    <xsl:value-of select="string-join($_distance_lookup/distance, ' - ')"/>
  </a>
  <body>  
    <h2>Rozklad jazdy</h2> 
    <table>
      <tr>
        <th>Trasy</th>
        <th>Liczba przystanków</th>
      </tr>
      <xsl:for-each select="timetable/line">
        <tr>
          <td><xsl:value-of select="@name"/></td>
          <td><xsl:value-of select="count(route/stop)"/></td>
        </tr>
      </xsl:for-each>
    </table>
   
    <xsl:variable name="line-helper">
        <line>
            <xsl:for-each select="timetable/line">
                <name><xsl:value-of select="@name"/></name>
		        <xsl:variable name="something">
			         <xsl:for-each select="route/stop">
			             <stop><xsl:value-of select="key('stops_key',@id, $stops_d)/@name"/></stop>
			         </xsl:for-each>
		         </xsl:variable>
		         <xsl:variable name="_t_dist">
	                 <xsl:for-each select="route/stop">
	                    <xsl:if test="position() > 0">
	                        <xsl:variable name="_last" select="position() - 1"/>
	                        <xsl:variable name="_key" select="concat(../stop[$_last]/@id, ':', @id)"/>
	                        <xsl:value-of select="$_key"/>
	                    </xsl:if>
	                 </xsl:for-each>
	             </xsl:variable>
          <dupa><xsl:value-of select="$_t_dist"/></dupa>
	         
         <stops><xsl:copy-of select="$something"></xsl:copy-of></stops>
         <desc><xsl:value-of select="string-join(($something/stop), ' -> ')"/></desc>
            </xsl:for-each>
        </line>
    </xsl:variable>
    <xsl:text>
    
    
    </xsl:text>
   
    <xsl:value-of select="$line-helper/line[1]/dupa"/>
<!--     <xsl:value-of select="hours-from-time(xs:time('11:21:00'))"/> -->
<!--     <xsl:for-each select="$stops_d/stops/stop"> -->
<!--         <h2><xsl:value-of select="@name"/></h2> -->
        
<!--     </xsl:for-each> -->
  </body>

</xsl:template>


</xsl:stylesheet>