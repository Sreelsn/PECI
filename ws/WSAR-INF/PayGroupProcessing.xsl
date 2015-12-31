<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:is="java:com.workday.esb.intsys.xpath.ParsedIntegrationSystemFunctions"
    xmlns:xdiff="urn:com.workday/esb/xdiff" 
    xmlns:wd="urn:com.workday/bsvc"
    xmlns:env="http://schemas.xmlsoap.org/soap/envelope/">
    
    <xsl:param name="paygroupIn"/>
    
    <!--Process integration events-->
    <xsl:template match="/">
        <wd:PECI_IntegrationEvents xmlns:wd="urn:com.workday/bsvc">
            <xsl:apply-templates></xsl:apply-templates>
        </wd:PECI_IntegrationEvents>
    </xsl:template>
    
    <!--Completed Events-->	    
    <xsl:template match="/wd:Get_Integration_Events_Response[1]/wd:Response_Data[1]/wd:Integration_Event[wd:Integration_Event_Data/wd:Integration_Runtime_Parameter_Data/wd:Instance_Set_Reference/wd:ID[@wd:type='Organization_Reference_ID'] = $paygroupIn]">
        <wd:Integration_Event>
            <wd:PayGroup>
                <xsl:value-of select="$paygroupIn"/>
            </wd:PayGroup>
            <xsl:copy-of select="wd:Integration_Event_Reference"></xsl:copy-of>
            <xsl:copy-of select="wd:Background_Process_Instance_Data/wd:Background_Process_Instance_Status_Reference/wd:ID[@wd:type='Background_Process_Instance_Status_ID']"></xsl:copy-of>
            <xsl:copy-of select="wd:Background_Process_Instance_Data/wd:Output_Document_Data[wd:Integration_Repository_Document_Data/wd:Document_Tag_Reference/wd:ID= 'Deliverable']"></xsl:copy-of>
            
        </wd:Integration_Event>
    </xsl:template>
    
    <xsl:template match="text()|@*">
        <xsl:apply-templates></xsl:apply-templates>
    </xsl:template>
    
</xsl:stylesheet>