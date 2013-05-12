<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:func="http://chojnacki.ws/functions" exclude-result-prefixes="xs func">
<xsl:output method="xhtml" omit-xml-declaration="yes" />
<xsl:variable name="loc" select="'../../../..'"/>
<!-- <xsl:variable name="loc" select="'/root'"/> -->

<xsl:variable name="stops_d" select="doc(concat($loc, '/stops.xml'))" as="document-node()"/>
<xsl:variable name="dist_d" select="doc(concat($loc, '/distances.xml'))" as="document-node()"/>
<xsl:key name="stops_key"  match="stops/stop" use="@id"/>
<xsl:key name="dist_key" match="distance" use="@comp_id"/>

<xsl:variable name="dist">
    <xsl:for-each select="$dist_d//distances/distance">
        <distance>
            <id><xsl:value-of select="string-join((@from-stop, @to-stop), ':')"/></id>
            <high><xsl:value-of select="@high-traffic"/></high>
            <low><xsl:value-of select="@low-traffic"/></low>           
        </distance>
    </xsl:for-each>
</xsl:variable>

<!-- <xsl:function name="func:to_minutes" as="xs:integer"> -->
<!--     <xsl:variable name="dupa" select="'123'"/>     -->
<!-- </xsl:function> -->
<xsl:template match="/">
<!--   <a> -->
<!--     <xsl:value-of select="$dist/distance"/> -->
<!--   </a> -->
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
             <xsl:variable name="stop_id" select="@id"/>
             <stop><xsl:value-of select="key('stops_key',@id, $stops_d)/@name"/></stop>

         </xsl:for-each>
         
         
         
         </xsl:variable>
         <stops><xsl:copy-of select="$something"></xsl:copy-of></stops>
         <desc><xsl:value-of select="string-join(($something/stop), ' -> ')"/></desc>
    </xsl:for-each>
    </line>
    </xsl:variable>
    <xsl:text>
    
    
    </xsl:text>
   
    
    <xsl:value-of select="hours-from-time(xs:time('11:21:00'))"/>
<!--     <xsl:for-each select="$stops_d/stops/stop"> -->
<!--         <h2><xsl:value-of select="@name"/></h2> -->
        
<!--     </xsl:for-each> -->
  </body>

</xsl:template>


</xsl:stylesheet>