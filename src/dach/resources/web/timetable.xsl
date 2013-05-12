<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
<xsl:variable name="stops_d" select="doc('root/stops.xml')" as="document-node()"/>

<xsl:key name="stops_key"  match="stops/stop" use="@id"/>
<xsl:template match="/">
  
  <body>
    <xsl:for-each select="$stops_d/stops/stop">
<!-- dummy empty for each to laod nodesets for $stops_d variable  -->
      </xsl:for-each>
  
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
   
    <xsl:for-each select="timetable/line">
        <h2><xsl:value-of select="@name"/></h2>
<!--         <xsl:variable name="something"> -->
        
<!--          <xsl:for-each select="route/stop"> -->
<!--              <xsl:variable name="stop_id" select="@id"/> -->
             
<!-- <!--              <xsl:value-of select="$stops_d/stops/stop[@id = $stop_id]/@name"/> --> -->
<!--              <item><xsl:value-of select="$stops_d/stops/stop[0]/@name"/></item> -->

<!-- <!--              <items><xsl:text>|</xsl:text></items> --> -->
<!--          </xsl:for-each> -->
<!--          </xsl:variable> -->
<!--          <xsl:value-of select="$something/items[0]"/> -->
         <xsl:value-of select="count($stops_d//stops)"/> 
         
    </xsl:for-each>
    <xsl:for-each select="$stops_d/stops/stop">
        <h2><xsl:value-of select="@name"/></h2>
        </xsl:for-each>

  </body>

</xsl:template>


</xsl:stylesheet>