<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/1999/html"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all" >   
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <!-- root template creates the HTML structure -->
    <xsl:template match="/">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
                <title>Versoris Mss</title>
                <style>
                   .msDesc {margin:20px 0px} 
                   .msDescID {margin-bottom:5px}
                   .fieldname {text-decoration:underline}
                   .summary {margin-bottom:1em}
                   .ref-work {font-style:italic}
                </style>
            </head>
            <body>
                <h1>Bibliotheca Manuscripta Versoriana</h1>
                
                <div>
                    <h2>Table of contents</h2>
                    <ul>
                        <xsl:for-each select="//msDesc">
                            <li>
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:text>#</xsl:text>
                                        <xsl:value-of select="@xml:id"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="@xml:id"/>
                                </a>
                            </li>
                        </xsl:for-each>
                    </ul>
                </div>
                
                <hr/>
                
                <xsl:apply-templates/>
                
            </body>
        </html>
    </xsl:template>
    
    <!--  do not render the teiHeader -->
    <xsl:template match="teiHeader"/>
    
    
    <xsl:template match="msDesc">
        <div class="msDesc">
            <h2 class="msDescID">
                <xsl:attribute name="id">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
                <xsl:value-of select="@xml:id"/>
            </h2>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="msIdentifier">
        <div class="msIdentifier">
            <span class="fieldname">Identifier</span>
            <xsl:text>: </xsl:text>
            <xsl:value-of select="./settlement"/>,
            <xsl:value-of select="./repository"/>,
            <xsl:if test="collection">
                <xsl:value-of select="./collection"/>,
            </xsl:if>
            <xsl:value-of select="./idno"/>            
        </div>
    </xsl:template>
    
    <xsl:template match="summary">
        <div class="summary">
            <span class="fieldname">Manuscript attribution</span>
            <xsl:text>: </xsl:text>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="msContents">
        <div>
            <span class="fieldname">Content</span>
            <ul>
                <xsl:apply-templates/>
            </ul>
        </div>
    </xsl:template>
    
    <xsl:template match="msItem[not(@class)]">
        <li class="msPart">
            <!-- locus -->
            <xsl:choose>                
                <xsl:when test="locus/@from and locus/@to">
                    <div class="locus">
                        <xsl:value-of select="locus/@from"/>
                        <xsl:text>–</xsl:text>
                        <xsl:value-of select="locus/@to"/>
                    </div>
                </xsl:when>
                <xsl:when test="locus/@from">
                    <div class="locus">
                        <xsl:value-of select="locus/@from"/>
                    </div>
                </xsl:when>
                <xsl:when test="locus">
                    <div class="locus">
                        <xsl:value-of select="locus"/>
                    </div>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <!-- title -->
            <xsl:if test="title">
                <span class="title">
                    <i>
                        <xsl:value-of select="title"/>
                    </i>
                </span>
                <br/>
            </xsl:if>
            
            <!-- note -->
            <xsl:if test="note">
                <xsl:apply-templates select="note"/>
            </xsl:if>
            
            <!-- questions -->
            <xsl:if test="msItem[@class='question']">
                <ul>
                    <xsl:apply-templates select="msItem[@class='question']"/>
                </ul>
            </xsl:if>
        </li>   
        <br/>
    </xsl:template>
    
    <xsl:template match="note">
        <xsl:choose>
            <xsl:when test="./@type = 'msRelationship'">
                <div class="note">
                    <span>Mss relationships: </span>
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="./@type = 'attribution'">
                <div class="note">
                    <span>Attribution: </span>
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="./@type = 'content'">
                <div class="note">
                    <span>Note: </span>
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="./@type = 'desc'">
                <div class="note">
                    <span>Description: </span>
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="./@type = 'paleo'">
                <div class="note">
                    <span>Paleographical note: </span>
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    
    <xsl:template match="msItem[@class='question']">
        <li class="question">
            <!-- locus -->
            <xsl:choose>                
                <xsl:when test="locus/@from and locus/@to">
                    <div class="locus">
                        <xsl:value-of select="locus/@from"/>
                        <xsl:text>–</xsl:text>
                        <xsl:value-of select="locus/@to"/>
                    </div>
                </xsl:when>
                <xsl:when test="locus/@from">
                    <div class="locus">
                        <xsl:value-of select="locus/@from"/>
                    </div>
                </xsl:when>
                <xsl:when test="locus">
                    <div class="locus">
                        <xsl:value-of select="locus"/>
                    </div>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
            
            <!-- title -->
            <xsl:if test="./title">
                <span class="title">
                    <i>
                        <xsl:value-of select="title"/>
                    </i>
                </span>
                <br/>
            </xsl:if>
            
            <!-- note -->
            <xsl:if test="./note">
                <xsl:apply-templates select="note"/>
            </xsl:if>
        </li>
    </xsl:template>
    
    <xsl:template match="history">
        <div class="history">
            <div class="fieldname">History</div>
            <xsl:if test="origin/origDate">
                <div>
                    <span>Date of origin</span>: <xsl:value-of select="./origin/origDate"/>
                </div>    
            </xsl:if>
            <xsl:if test="origin/origPlace">
                <div>
                    <span>Place of origin</span>:
                    <a>
                        <xsl:attribute name="href">
                            <!--<xsl:value-of select="origin/origPlace/@ref"/>-->
                        </xsl:attribute>
                        <xsl:value-of select="./origin/origPlace"/>
                    </a>
                </div>   
            </xsl:if>
            <xsl:if test="origin/p">
                <div>
                    <xsl:apply-templates select="./origin/p"/>
                </div>    
            </xsl:if>
        </div>
    </xsl:template>
    
    <xsl:template match="additional">
        <xsl:if test="./listBibl">
            <div class="bibl">
                <div class="fieldname">Bibliography</div>
                <ul>
                    <xsl:apply-templates select="listBibl/bibl"></xsl:apply-templates>
                </ul>
            </div>    
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="listBibl/bibl">
        <li>
            <xsl:value-of select="."/>
        </li>
    </xsl:template>
    
    
    
    <!-- INLINE ELEMENTS -->
    
    <!-- quotations -->
    <xsl:template match="q">
        <xsl:text>"</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>"</xsl:text>
    </xsl:template>
    
    <!-- references -->
    <xsl:template match="ref">
        <a>
            <xsl:attribute name="href">
                <!--<xsl:value-of select="@target"/>-->
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test=".[@type='work']">
                    <span class="ref-work">
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates></xsl:apply-templates>
                </xsl:otherwise>
            </xsl:choose>
        </a>
    </xsl:template>
    
    
    
    
    
    
</xsl:stylesheet>
    
