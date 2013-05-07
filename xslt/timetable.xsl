<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <xsl:variable name="stops_d" select="document(sample/stop.xml)" />
  <html>
  <body>
    <h2>Rozklad jazdy</h2>
    <h2><xsl:copy-of select="document(stops.xml)/stops/stop"/></h2>
    <xsl:for-each select="document(stops.xml)/stops/stop">
        <h2><xsl:value-of select="@name"/></h2>
    </xsl:for-each>
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
  </body>
  </html>
</xsl:template>

</xsl:stylesheet>

