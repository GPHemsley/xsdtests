<xsl:stylesheet 
   version="2.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:ts="http://www.w3.org/XML/2004/xml-schema-test-suite/"
   xmlns:xlink="http://www.w3.org/1999/xlink">

<!-- This stylesheet takes as input the suite.xml document acting as the master
     catalogue of the test suite. It produces as output an XML .testSet document
     which, when executed as part of the test suite, validates that all the .testSet
     documents (including itself) are valid against the schema for the test metadata
     
     Since the output of this stylesheet is also one of the inputs, the output must
     be sent to a temporary location and then copied to common/introspection.testSet
-->

<xsl:output indent="yes"/>

<xsl:template match="ts:testSuite">
  <ts:testSet name="introspection"
              contributor="auto-generated">
     <ts:annotation>
       <ts:documentation>
         <p>This test catalogue was generated automatically using the stylesheet
            generate-introspection-testset.xsl.
            
            DO NOT EDIT THIS FILE!
         </p>
       </ts:documentation>
     </ts:annotation>
     
     <ts:testGroup name="introspection">
       <ts:schemaTest name="introspect-testSet-schema">
         <ts:schemaDocument xlink:href="xsts.xsd"/>
         <ts:expected validity="valid"/>
       </ts:schemaTest> 
       <xsl:for-each select="ts:testSetRef/@xlink:href">
         <xsl:variable name="ts" select="document(.)"/>
         <ts:instanceTest name="introspect-testSet-{$ts/ts:testSet/@name}-{position()}">
            <ts:instanceDocument xlink:href="../{.}"/>
            <ts:expected validity="valid"/>
         </ts:instanceTest>
       </xsl:for-each>
     </ts:testGroup>
   </ts:testSet>
</xsl:template>

</xsl:stylesheet>           
         