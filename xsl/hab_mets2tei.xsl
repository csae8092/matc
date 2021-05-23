<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:mods="http://www.loc.gov/mods/v3"
    xmlns:mets="http://www.loc.gov/METS/"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output indent="yes"/>
    <xsl:param name="ms_id"/>
    <xsl:variable name="base_url">
        <xsl:value-of select="concat('http://diglib.hab.de/mss/', $ms_id, '/')"/>
    </xsl:variable>
    <xsl:template match="/">
        <TEI xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="//tei:teiHeader"/>
            <text>
                <body>
                    <div>
                    <xsl:for-each select="//mets:structMap[@TYPE='PHYSICAL']/mets:div/mets:div">
                        <xsl:variable name="pb_name">
                            <xsl:value-of select="data(@ORDERLABEL)"/>
                        </xsl:variable>
                        <xsl:variable name="cur_nr">
                            <xsl:value-of select="substring-after(data(@ID), '_')"/>
                        </xsl:variable>
                        <pb n="{$pb_name}" xml:id="{concat('page__', $cur_nr)}" facs="{concat('#facs__', $cur_nr)}"/>
                    </xsl:for-each>
                    </div>
                </body>
            </text>
            <facsimile>
                <xsl:for-each select="//mets:structMap[@TYPE='PHYSICAL']/mets:div/mets:div">
                    <xsl:variable name="pb_name">
                        <xsl:value-of select="data(@ORDERLABEL)"/>
                    </xsl:variable>
                    <xsl:variable name="cur_nr">
                        <xsl:value-of select="substring-after(data(@ID), '_')"/>
                    </xsl:variable>
                    <surface xml:id="{concat('facs__', $cur_nr)}"  n="{$pb_name}">
                        <graphic url="{concat($base_url, $cur_nr, '.jpg')}"/>
                    </surface>
                </xsl:for-each>
            </facsimile>
        </TEI>
    </xsl:template>
    
</xsl:stylesheet>