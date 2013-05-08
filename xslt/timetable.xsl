<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:key name="stop" match="@id" use="@name"/>
<xsl:variable name="stops_d" select="document('stops.xml')" />

<xsl:template match="/">
  
  <html>
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
    
    <xsl:for-each select="timetable/line">
        <h2><xsl:value-of select="@name"/></h2>
         <xsl:for-each select="route/stop">
             <xsl:variable name="stop_id" select="@id"/>
             <xsl:value-of select="$stops_d//stops/stop[@id = $stop_id]/@name"/>

             <xsl:text> -> </xsl:text>
         </xsl:for-each>   
    </xsl:for-each>
    <xsl:for-each select="$stops_d/stops/stop">
        <!--<h2><xsl:value-of select="@name"/></h2>-->
    </xsl:for-each>

  </body>
  </html>
</xsl:template>

</xsl:stylesheet>