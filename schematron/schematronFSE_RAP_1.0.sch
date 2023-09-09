<?xml version="1.0" encoding="UTF-8"?>
<!-- schematron versione: 4.3 -->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" 
		xmlns:cda="urn:hl7-org:v3"
        xmlns:iso="http://purl.oclc.org/dsdl/schematron"
        xmlns:sch="http://www.ascc.net/xml/schematron"
        queryBinding="xslt2" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<title>Schematron Referto di Anatomia Patologica 1.0</title>
	<ns prefix="hl7" uri="urn:hl7-org:v3"/>
	<ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
	
	<pattern id="all">

	<!--________________________________ HEADER _____________________________________________________________-->
	
		<!-- ClinicalDocument -->
		<rule context="hl7:ClinicalDocument">

			<!--realmCode-->	
			<assert test="count(hl7:realmCode)>=1"
			>ERRORE-1| L'elemento <name/> deve contenere almeno un elemento 'realmCode'.</assert>

			<!--templateId-->
			<let name="num_tid" value="count(hl7:templateId)"/>
			<assert test="$num_tid >= 1"
			>ERRORE-2| L'elemento <name/> DEVE avere almeno un elemento di tipo 'templateId'</assert>
			<assert test="count(hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.8.1']) = 1 and  count(hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.8.1']/@extension)=1"
			>ERRORE-3| Almeno un elemento 'templateId' DEVE essere valorizzato attraverso l'attributo  @root='2.16.840.1.113883.2.9.10.1.8.1' (id del template nazionale)  associato all'attributo @extension che  indica la versione a cui il template fa riferimento.</assert>
			
			<!--code-->	
			<assert test="count(hl7:code[@code='11526-1'][@codeSystem='2.16.840.1.113883.6.1']) = 1"
			>ERRORE-4| L'elemento <name/>/code deve essere valorizzato con l'attributo @code='11526-1' e il @codeSystem='2.16.840.1.113883.6.1'</assert>			
			<report test="not(count(hl7:code[@codeSystemName='LOINC'])=1) or not(count(hl7:code[@displayName='PATHOLOGY STUDY'])=1 or
			count(hl7:code[@displayName='Pathology study'])=1)"
			>W001| Si raccomanda di valorizzare gli attributi dell'elemento <name/>/code nel seguente modo: @codeSystemName ='LOINC' e @displayName ='Pathology study'.--> </report>
			
			<!--confidentialityCode-->
			<assert test="(count(hl7:confidentialityCode[@code='N'][@codeSystem='2.16.840.1.113883.5.25'])= 1) or (count(hl7:confidentialityCode[@code='V'][@codeSystem='2.16.840.1.113883.5.25'])= 1)"
			>ERRORE-5| L'elemento 'confidentialityCode' di <name/> DEVE avere l'attributo @code  valorizzato con 'N' o 'V', e il @codeSystem  con '2.16.840.1.113883.5.25'</assert>
			
			<!--languageCode-->	
			<assert test="count(hl7:languageCode)=1"
			>ERRORE-6| L'elemento <name/> DEVE contenere un elemento 'languageCode'.</assert>
			
			<!-- Controllo incrociato tra setId-versionNumber-relatedDocument-->
			<let name="versionNumber" value="hl7:versionNumber/@value"/>
			<assert test="(string(number($versionNumber)) = 'NaN') or
					($versionNumber= '1' and count(hl7:setId)=0) or 
					($versionNumber= 1 and hl7:id/@root = hl7:setId/@root and hl7:id/@extension = hl7:setId/@extension) or
					($versionNumber!= '1' and hl7:id/@root = hl7:setId/@root and hl7:id/@extension != hl7:setId/@extension) or
					(hl7:id/@root != hl7:setId/@root)"
			>ERRORE-7| Se ClinicalDocument.id e ClinicalDocument.setId usano lo stesso dominio di identificazione (@root identico), allora l’attributo @extension del
			ClinicalDocument.id deve essere diverso da quello del ClinicalDocument.setId a meno che ClinicalDocument.versionNumber non sia uguale ad 1; cioè i valori del setId ed id per un documento clinico coincidono solo per la prima versione di un documento.</assert>
			
			<assert test="(string(number($versionNumber)) ='NaN') or
						  ($versionNumber=1)  or 
						  (($versionNumber &gt;1) and count(hl7:relatedDocument)&gt;=1 and count(hl7:relatedDocument)&lt;=2)"
			>ERRORE-8| Se l'attributo <name/>/versionNumber/@value è maggiore di  1, l'elemento <name/>  deve contenere al più due elementi di tipo 'relatedDocument'.</assert>
			
			<!--recordTarget-->
			<assert test="count(hl7:recordTarget)=1"
			>ERRORE-9| L'elemento <name/> DEVE contenere un solo elemento 'recordTarget' </assert>
				<!--Controllo recordTarget/patientRole/id-->
			<assert test="count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.7'])=1 or 
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.3'])=1 or 
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.18'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.17'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.15'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.10.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.20.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.30.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.41.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.42.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.50.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.60.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.70.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.80.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.90.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.100.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.110.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.120.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.130.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.140.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.150.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.160.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.170.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.180.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.190.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.200.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.10.4.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.20.4.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.30.4.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.41.4.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.42.4.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.50.4.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.60.4.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.70.4.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.80.4.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.90.4.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.100.4.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.110.4.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.120.4.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.130.4.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.140.4.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.150.4.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.160.4.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.170.4.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.180.4.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.190.4.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.200.4.1'])=1"
			>ERRORE-10| L'elemento <name/>/recordTarget/patientRole/id  deve avere l'attributo @root valorizzato tramite uno dei seguenti identificatori Nazionanli:
			CF 2.16.840.1.113883.2.9.4.3.2
			TEAM 2.16.840.1.113883.2.9.4.3.7 e 2.16.840.1.113883.2.9.4.3.3
			ENI 2.16.840.1.113883.2.9.4.3.18
			STP 2.16.840.1.113883.2.9.4.3.17 oppure un identificativo regionale 
			ANA 2.16.840.1.113883.2.9.4.3.15
			Oppure tramite gli identificatori regionali generati per rappresentare l'id del paziente.
			</assert>
			<assert test="
			( count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.7']) = 0 or
			  count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.3']) = 1 
			) and (count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.3']) = 0 or
			  count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.7']) = 1)"			
			>ERRORE-11| Nel caso di Soggetto assicurato da istituzioni estere, devono essere riportati almeno due elementi di tipo 'id' contenenti:
			- 2.16.840.1.113883.2.9.4.3.7: Il numero di identificazione della Tessera TEAM (Tessera Europea di Assicurazione Malattia),
			- 2.16.840.1.113883.2.9.4.3.3 Il numero di identificazione Personale TEAM
			</assert>			
			<assert test="(count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=0 and 
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.7'])=0 and 
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.3'])=0 and 
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.18'])=0 and
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.15'])=0) or 
			not(count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.10.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.20.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.30.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.41.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.42.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.50.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.60.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.70.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.80.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.90.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.100.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.110.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.120.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.130.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.140.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.150.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.160.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.170.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.180.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.190.4.1.1'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.2.200.4.1.1'])=1)"			
			>ERRORE-11a| Nel caso di Stranieri Temporaneamente Presenti, l'elemento <name/>/recordTarget/patientRole/id  deve avere l'attributo @root valorizzato tramite un identificativo STP.</assert>
				<!--Controllo recordTarget/patientRole/addr-->
			<let name="num_addr" value="count(hl7:recordTarget/hl7:patientRole/hl7:addr)"/>
			<assert test="$num_addr=0 or (count(hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:country)=$num_addr and 
			count(hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:city)=$num_addr and 
			count(hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:streetAddressLine)=$num_addr)"
			>ERRORE-12| L'elemento <name/>/recordTarget/patientRole/addr DEVE riportare i sotto-elementi 'country', 'city' e 'streetAddressLine' </assert>
			<assert test="$num_addr=0 or count(hl7:recordTarget/hl7:patientRole/hl7:addr[@use='HP' or @use='H' or @use='TMP'])=$num_addr"
			>ERRORE-13| Se presente, l'elemento <name/>/recordTarget/patientRole/addr DEVE riportare l'attributo @use, valorizzato in uno dei seguenti valori:
			- 'HP' (primary home);
			- 'H' (home);
			- 'TMP' (temporary address).</assert>			
				<!--Controllo recordTarget/patientRole/patient/name-->
			<let name="patient" value="hl7:recordTarget/hl7:patientRole/hl7:patient"/>
			<assert test="count($patient)=1"
			>ERRORE-14| L'elemento <name/>/recordTaget/patientRole DEVE contenere l'elemento patient</assert>
			<assert test="count($patient)=0 or count($patient/hl7:name)=1"
			>ERRORE-15| L'elemento <name/>/recordTaget/patientRole/patient DEVE contenere l'elemento 'name'</assert>
			<assert test="count($patient/hl7:name)=0 or (count($patient/hl7:name/hl7:given)=1 and count($patient/hl7:name/hl7:family)=1)"
			>ERRORE-16| L'elemento <name/>/recordTaget/patientRole/patient/name DEVE contenere gli elementi 'given' e 'family'</assert>
				<!--Controllo recordTarget/patientRole/patient/administrativeGenderCode-->
			<assert test="count($patient)=0 or count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:administrativeGenderCode[@code and @codeSystem='2.16.840.1.113883.5.1'])=1"
			>ERRORE-17| L'attributo <name/>/recordTarget/patientRole/patient DEVE contenere l'elemento administrativeGenderCode con l'attributo @code valorizzato secondo il sistema di codifica AdministrativeGender - codeSystem='2.16.840.1.113883.5.1'</assert>
			<assert test="count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthTime)=1"
			>ERRORE-18| L'elemento <name/>/recordTarget/patientRole/patient DEVE contenere un elemento birthTime.</assert>
				<!--Controllo recordTarget/patientRole/patient/birthplace/place/addr-->
			<assert test="count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthplace)=0 or 
			count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthplace/hl7:place/hl7:addr)=1"
			>ERRORE-19| L'elemento <name/>/recordTarget/patientRole/patient/birthplace DEVE contenere un elemento place/addr.</assert>				
			
			<!--dataEnterer-->
			<assert test="count(hl7:dataEnterer)=0 or count(hl7:dataEnterer/hl7:assignedEntity/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=1"
			>ERRORE-20| L'elemento <name/>/dataEnterer/assignedEntity DEVE avere almeno un elemento 'id' valorizzato tramite il Codice Fiscale - @root='2.16.840.1.113883.2.9.4.3.2'.</assert>
			<!--custodian-->
			<let name="num_addr_cust" value="count(hl7:custodian/hl7:assignedCustodian/hl7:representedCustodianOrganization/hl7:addr)"/>
			<let name="addr_cust" value="hl7:custodian/hl7:assignedCustodian/hl7:representedCustodianOrganization/hl7:addr"/>
			<assert test="$num_addr_cust=0 or (count($addr_cust/hl7:country)=$num_addr_cust and count($addr_cust/hl7:city)=$num_addr_cust and count($addr_cust/hl7:streetAddressLine)=$num_addr_cust)"
			>ERRORE-21| L'elemento <name/>/custodian/assignedCustodian/representedCustodianOrganization/addr DEVE riportare i sotto-elementi 'country', 'city' e 'streetAddressLine'.</assert>

			<!--legalAuthenticator -->
			<assert test = "count(hl7:legalAuthenticator)= 1"
			>ERRORE-22| L'elemento <name/>/legalAuthenticator è obbligatorio</assert>
			<assert test = "count(hl7:legalAuthenticator)= 0 or count(hl7:legalAuthenticator/hl7:signatureCode[@code='S'])= 1" 
			>ERRORE-23| L'elemento <name/>/legalAuthenticator/signatureCode deve contenere l'attributo @code valorizzato con il codice "S".</assert>
			
			
			<!--inFulfillmentOf-->
			<assert test="count(hl7:inFulfillmentOf)>=1"
			>ERRORE-24| L'elemento <name/> DEVE contenere almeno un elemento 'inFulfillmentOf'.</assert>
			
			<!--relatedDocument-->
			<assert test="(count(hl7:relatedDocument)&lt;2 or (count(hl7:relatedDocument[@typeCode='XFRM'])=1 and (count(hl7:relatedDocument[@typeCode='RPLC'])=1 or count(hl7:relatedDocument[@typeCode='APND'])=1)))"
			>ERRORE-25| Un documento CDA2 conforme può avere o un relatedDocument con @typeCode='APND' | 'RPLC' | 'XFRM'; oppure una combinazione di due relatedDocument con la seguente composizione:
			- @typeCode='XFRM' e @typeCode='RPLC'; 
			- @typeCode='XFRM' e @typeCode='APND'.</assert>
			
			<!--componentOf-->
			<assert test= "count(hl7:componentOf)= 1"
			>ERRORE-26| L'elemento <name/>/componentOf è obbligatorio.</assert>
			<assert test= "count(hl7:componentOf/hl7:encompassingEncounter/hl7:responsibleParty/hl7:assignedEntity/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=1"
			>ERRORE-27| L'elemento <name/>/componentOf/encompassingEncounter/responsibleParty/assignedEntity deve contenere almeno un elemento id valorizzato tramite il CF -  è obbligatorio @root='2.16.840.1.113883.2.9.4.3.2'.</assert>
		</rule>

		<!--informationRecipient -->
		<rule context="hl7:ClinicalDocument/hl7:informationRecipient">
			<assert test="count(hl7:intendedRecipient/hl7:informationRecipient/hl7:name)=0 or 
			(count(hl7:intendedRecipient/hl7:informationRecipient/hl7:name/hl7:given)=1 and count(hl7:intendedRecipient/hl7:informationRecipient/hl7:name/hl7:family)=1) "
			>ERRORE-28| L'elemento ClinicalDocument/<name/>/intendedRecipient/informationRecipient/name, se presente, deve contenere gli elementi 'given' e 'family'.</assert>
		</rule>
		
		<!--author -->	
		<rule context="hl7:ClinicalDocument/hl7:author">
			<assert test="count(hl7:assignedAuthor/hl7:id[@root= '2.16.840.1.113883.2.9.4.3.2'])= 1 "
			>ERRORE-29| L'elemento ClinicalDocument/<name/>/assignedAuthor DEVE contenere almeno un elemento id  valorizzato tramite il Codice Fiscale - @root='2.16.840.1.113883.2.9.4.3.2'.</assert>
			<assert test = "count(hl7:assignedAuthor/hl7:assignedAuthoringDevice/hl7:asMaintainedEntity)= 0 or 
			count(hl7:assignedAuthor/hl7:assignedAuthoringDevice/hl7:asMaintainedEntity/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.272'])=1" 
			>ERRORE-30| L'elemento ClinicalDocument/<name/>/assignedAuthor/assignedAuthoringDevice/asMaintainedEntity deve contenere un elemento 'templateId' valorizzato con @root='2.16.840.1.113883.3.1937.777.63.10.272'.</assert>
		
		</rule>
		<!--authenticator -->
		<rule context="hl7:ClinicalDocument/hl7:authenticator">
			<assert test ="count(hl7:signatureCode[@code='S'])=1"
			>ERRORE-31| L'elemento ClinicalDocument/<name/>/signatureCode deve contenere l'attributo @code valorizzato con il codice "S".</assert>
			<assert test ="count(hl7:assignedEntity/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=1"
			>ERRORE-32| L'elemento ClinicalDocument/<name/>/assignedEntity deve contenere almeno un elemento id valorizzato tramite il CF -  @root='2.16.840.1.113883.2.9.4.3.2'.</assert>
		</rule>
		
		<!--participant-->
		<rule context="hl7:ClinicalDocument/hl7:participant">			
			<assert test="count(hl7:associatedEntity/hl7:id)>=1"
			>ERRORE-33| L'elemento ClinicalDocument/<name/>/associatedEntity deve contenere almeno un elemento 'id'.</assert>
		</rule>
		
		<!--inFulfillmentOf-->
		<rule context="hl7:ClinicalDocument/hl7:inFulfillmentOf">
			<assert test="count(hl7:order/hl7:id)=1"
			>ERRORE-34| L'elemento ClinicalDocument/<name/>/inFulfillmentOf/order deve contenere un solo elemento 'id'.</assert>
		</rule>

		
		<!--________________________________CONTROLLI GENERICI_____________________________________________________________-->
		
		<!-- Controllo telecom -->
		<rule context="//hl7:telecom">
			<assert test="(count(@use)=1)"
			>ERRORE-35| L’elemento 'telecom' DEVE contenere l'attributo @use.</assert>
		</rule>
		<rule context="//*[contains(local-name(), 'Organization')][hl7:telecom]">
			<assert test="not(hl7:telecom/@use='H' or hl7:telecom/@use='HP' or hl7:telecom/@use='HV')"
			>ERRORE-36| L'elemento telecom di un'organizzazione non può essere di tipo Home, ovvero l'attributo @use deve essere diverso da: H | HP | HV.</assert>
		</rule>
		
		<!-- Controllo formato: -->
		<rule context="//hl7:id[@root='2.16.840.1.113883.2.9.4.3.2']">
			<let name="CF" value="@extension"/>
			<assert test="matches(@extension, '[A-Z0-9]{16}') and string-length($CF)=16"
			>ERRORE-37| Il codice fiscale '<value-of select="$CF"/>' del cittadino e/o operatore DEVE avere 16 cifre [A-Z0-9]{16}</assert>
		</rule>
		
		<!-- Controllo sotto elementi name-->
		<rule context="//hl7:name[contains(local-name(..), 'Organization') or (parent::hl7:location)]">
			<assert test="count(hl7:delimiter)=0 and count(hl7:prefix)=0 and count(hl7:suffix)=0"
			>ERRORE-38| L’elemento 'name' di un'organizzazione non deve contenere i sotto elementi 'delimiter', 'prefix', 'suffix'.</assert>
    	</rule>
		<rule context="//*[contains(local-name(), 'Person') and not(ancestor::hl7:section)]/hl7:name">
			<let name="errorPath">
				<xsl:for-each select="ancestor::*[not(self::hl7:ClinicalDocument)]">
					<xsl:value-of select="concat('/', name())"/>
				</xsl:for-each>
			</let>
			<assert test="count(hl7:delimiter)=0 and count(hl7:given)=1 and count(hl7:family)=1"
			>ERRORE-39| L’elemento 'name' di un soggetto deve contenere i tag 'given' e 'family' e non il tag 'delimiter'.
			Path: ClinicalDocument<value-of select="$errorPath"/>.</assert>
		</rule>
		
		<!-- Controllo effectiveTime: -->
		<rule context="//hl7:effectiveTime[hl7:low/@value]">
			<let name="effective_time_low" value="string(hl7:low/@value)"/>
			<let name="effective_time_high" value="string(hl7:high/@value)"/>
			<assert test="count(hl7:high/@value)=0 or ($effective_time_high >= $effective_time_low)"
			>ERRORE-40| Il valore dell'elemento effectiveTime/high : '<value-of select="$effective_time_high"/>' deve essere maggiore o uguale dell'effectiveTime/low : '<value-of select="$effective_time_low"/>'.</assert>
		</rule>
		<!-- Controllo address: -->
		<rule context="//*[contains(local-name(), 'Organization')]/hl7:addr[@use='H' or @use='HP' or @use='HV']">
			<assert test="false()"
			>ERRORE-41| L'indirizzo di un'organizzazione non può essere di tipo Home, ovvero l'attributo @use deve essere diverso da: H | HP | HV.
			</assert>
		</rule>
		
		<rule context="//hl7:originalText[hl7:reference]">
			<assert test="string(hl7:reference/@value)"
			>ERRORE-42| L'elemento originalText/reference/@value deve essere valorizzato.</assert>
		</rule>
		
		<rule context="//hl7:addr[not(parent::hl7:place)and not(parent::hl7:scopingOrganization)]">
			<assert test="count(@use)!=0"
			>ERRORE-43| L'elemento addr deve avere l'attributo @use valorizzato.</assert>
		</rule>
	
		<rule context="//hl7:code">
			<assert test="(count(@code)!=0 and count(@codeSystem)!=0) or (count(@nullFlavor)!=0)"
			>ERRORE-44| L'elemento 'code' deve avere gli attributi @code e @codeSystem valorizzati, altrimenti deve avere l'attributo @nullFlavor.</assert>
		</rule>
		
		<rule context="//hl7:id">
			<assert test="(count(@root)!=0 and count(@extension)!=0)"
			>ERRORE-45| L'elemento 'id' deve contenere gli attributi @root ed @extension valorizzati.</assert>
		</rule>
		
		<!--statusCode-->
		<rule context="//hl7:statusCode">
			<assert test="@code='aborted' or @code='active' or @code='completed' or @code='suspended'"
			>ERRORE-46| L'elemento 'statusCode' deve essere valorizzato con uno dei seguenti valori: aborted | active | completed | suspended.</assert>
		</rule>
		
		<!--author-->
		<rule context="//hl7:section/hl7:author">
			<let name="section_code" value="(parent::hl7:section/hl7:code/@code)"/>
			<let name="section_value" value="if ($section_code = '22636-5') then 'Sezione Notizie Cliniche' else if ($section_code = '42349-1') then 'Sotto-sezione Quesito Diagnostico' else if ($section_code = '48765-2') then 'Sotto-Sezione Allergie' 
			else if ($section_code = '67803-7') then 'Sotto-Sezione Precedenti Esami Eseguiti' else if ($section_code = '8677-7') then 'Sott- Sezione Terapia farmacologica pregressa' else if ($section_code = '10160-0') then 'Sotto-sezione Terapia Oncologica pregressa' else if 
			($section_code = '47519-4') then 'Sotto-sezione Precedenti trattamenti e procedure chirurgiche e diagnostiche pregresse' else if ($section_code = '55114-3') then 'Sotto-sezione Indagini radiologiche'
			else if ($section_code = '29300-1') then 'Sezione Procedura' else if ($section_code = '22634-0') then 'Sezione Osservazione Macroscopica' else if ($section_code = '22635-7') then 
			'Sezione Osservazione Microscopica' else if ($section_code = '33755-0') then 'Sezione Stato del margine' else if ($section_code = '22639-9') then 'Sezione Analisi Supplementari dei campioni'  else if ($section_code = '85691-4') then 'Sezione Epicrisi' else if 
			($section_code = '22637-3') then 'Sezione Diagnosi' else if ($section_code = '62385-0') then 'Sezione Ulteriori accertamenti diagnostici' else ''"/>			
			<assert test="count(hl7:assignedAuthor/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=1"
			>ERRORE-47| <value-of select="$section_value"/>: L'elemento author/assignedAuthor deve avere almeno un elemento 'id' valorizzato tramite il CF (@root='2.16.840.1.113883.2.9.4.3.2').</assert>
			<assert test="count(hl7:assignedAuthor/hl7:assignedAuthoringDevice/hl7:asMaintainedEntity)=0 or
			count(hl7:assignedAuthor/hl7:assignedAuthoringDevice/hl7:asMaintainedEntity/templateId[@root='2.16.840.1.113883.3.1937.777.63.10.272'])=1"
			>ERRORE-48| <value-of select="$section_value"/>: L'elemento author/assignedAuthor/assignedAuthoringDevice/asMaintainedEntity deve contenere un elemento templateId valorizzato con @root='2.16.840.1.113883.3.1937.777.63.10.272' .</assert>
		</rule>
		
		<!--section/entry/act - Note e commenti-->
		<rule context="//hl7:section[hl7:code[@code!='48765-2']]/hl7:entry[hl7:act]">
			<let name="section_code" value="(parent::hl7:section/hl7:code/@code)"/>
			<let name="section_value" value="if ($section_code = '22636-5') then 'Sezione Notizie Cliniche' else if ($section_code = '42349-1') then 'Sotto-sezione Quesito Diagnostico' else if ($section_code = '48765-2') then 'Sotto-Sezione Allergie' 
			else if ($section_code = '67803-7') then 'Sotto-Sezione Precedenti Esami Eseguiti' else if ($section_code = '8677-7') then 'Sott- Sezione Terapia farmacologica pregressa' else if ($section_code = '10160-0') then 'Sotto-sezione Terapia Oncologica pregressa' else if 
			($section_code = '47519-4') then 'Sotto-sezione Precedenti trattamenti e procedure chirurgiche e diagnostiche pregresse' else if ($section_code = '55114-3') then 'Sotto-sezione Indagini radiologiche'
			else if ($section_code = '29300-1') then 'Sezione Procedura' else if ($section_code = '22634-0') then 'Sezione Osservazione Macroscopica' else if ($section_code = '22635-7') then 
			'Sezione Osservazione Microscopica' else if ($section_code = '33755-0') then 'Sezione Stato del margine' else if ($section_code = '22639-9') then 'Sezione Analisi Supplementari dei campioni'  else if ($section_code = '85691-4') then 'Sezione Epicrisi' else if 
			($section_code = '22637-3') then 'Sezione Diagnosi' else if ($section_code = '62385-0') then 'Sezione Ulteriori accertamenti diagnostici' else ''"/>
			
			<assert test="count(hl7:act/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.279'])=1"
			>ERRORE-50| <value-of select="$section_value"/>: L'elemento entry/act di Note e commenti deve contenere un elemento templateId valorizzato con la @root='2.16.840.1.113883.3.1937.777.63.10.279'.</assert>
			<assert test="count(hl7:act/hl7:code[@code='48767-8' and @codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-51| <value-of select="$section_value"/>: L'elemento entry/act/code di Note e commenti deve avere l'attributo @code valorizzato con '48767-8' e @codeSystem con '2.16.840.1.113883.6.1'.</assert>
			<assert test="count(hl7:act/hl7:text)=1"
			>ERRORE-52| <value-of select="$section_value"/>: L'elemento entry/act/text di Note e commenti è obbligatorio.</assert>
		</rule>
		
		<!--entryRelationship/act - Commenti-->
		<rule context="//hl7:entryRelationship[hl7:act]">
			<let name="errorPathObs">
			  <xsl:for-each select="ancestor::*[not(self::hl7:ClinicalDocument)]">
				<xsl:value-of select="concat('/', name())"/>
			  </xsl:for-each>
			</let>
			<let name="section_code" value="(ancestor::hl7:section[1]/hl7:code/@code)"/>
			<let name="section_value" value="if ($section_code = '22636-5') then 'Sezione Notizie Cliniche' else if ($section_code = '42349-1') then 'Sotto-sezione Quesito Diagnostico' else if ($section_code = '48765-2') then 'Sotto-Sezione Allergie' 
			else if ($section_code = '67803-7') then 'Sotto-Sezione Precedenti Esami Eseguiti' else if ($section_code = '8677-7') then 'Sott- Sezione Terapia farmacologica pregressa' else if ($section_code = '10160-0') then 'Sotto-sezione Terapia Oncologica pregressa' else if 
			($section_code = '47519-4') then 'Sotto-swzione Precedenti trattamenti e procedure chirurgiche e diagnostiche pregresse' else if ($section_code = '55114-3') then 'Sotto-sezione Indagini radiologiche' 
			else if ($section_code = '29300-1') then 'Sezione Procedura' else if ($section_code = '22634-0') then 'Sezione Osservazione Macroscopica' else if ($section_code = '22635-7') then 
			'Sezione Osservazione Microscopica' else if ($section_code = '33755-0') then 'Sezione Stato del margine' else if ($section_code = '22639-9') then 'Sezione Analisi Supplementari dei campioni'  else if ($section_code = '85691-4') then 'Sezione Epicrisi' else if 
			($section_code = '22637-3') then 'Sezione Diagnosi' else if ($section_code = '62385-0') then 'Sezione Ulteriori accertamenti diagnostici' else ''"/>
			
			<assert test="count(hl7:act/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.166'])=1"
			>ERRORE-53| <value-of select="$section_value"/>: L'elemento entry<value-of select="substring-after($errorPathObs, '/entry')"/>/entryRelationship/act di Commenti, se presente, deve contenere un elemento templateId di Commenti valorizzato con la @root='2.16.840.1.113883.3.1937.777.63.10.166'.</assert>
			<assert test="count(hl7:act/hl7:code[@code='48767-8' and @codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-54| <value-of select="$section_value"/>: L'elemento entry<value-of select="substring-after($errorPathObs, '/entry')"/>/entryRelationship/act/code di Commenti, se presente, deve avere l'attributo @code valorizzato con '48767-8' e @codeSystem con '2.16.840.1.113883.6.1'.</assert>
			<assert test="count(hl7:act/hl7:text)=1"
			>ERRORE-55| <value-of select="$section_value"/>: L'elemento entry<value-of select="substring-after($errorPathObs, '/entry')"/>/entryRelationship/act di Commenti, se presente, deve contenere l'elemento text obbligatorio.</assert>
			<assert test="count(hl7:act/hl7:statusCode)=0 or count(hl7:act/hl7:statusCode[@code='completed'])=1"
			>ERRORE-56| <value-of select="$section_value"/>: L'elemento entry<value-of select="substring-after($errorPathObs, '/entry')"/>/entryRelationship/act/statusCode di Commenti, se presente deve avere l'attributo @code valorizzato con 'completed'.</assert>
		</rule>
		
		<!--AP-Observation-->
		<rule context="//hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.150']]">
			<let name="errorPathObs">
			  <xsl:for-each select="ancestor::*[not(self::hl7:ClinicalDocument)]">
				<xsl:value-of select="concat('/', name())"/>
			  </xsl:for-each>
			</let>

			<let name="section_code" value="(ancestor::hl7:section/hl7:code/@code)"/>
			<let name="section_value" value="if ($section_code = '29300-1') then 'Procedura' else if ($section_code = '22634-0') then 'Osservazione Macroscopica' else if ($section_code = '22635-7') then 'Osservazione Microscopica' 
			else if ($section_code = '22639-9') then 'Analisi Supplementari dei campioni'  else if ($section_code = '22637-3') then 'Diagnosi' else ''"/>
			
			<assert test="count(hl7:code[@codeSystem='2.16.840.1.113883.6.1']) = 1"
			>ERRORE-57| Sezione <value-of select="$section_value"/>: l'elemento entry<value-of select="substring-after($errorPathObs, '/entry')"/>/observation deve contenere l'elemento code valorizzato tramite @codeSystem='2.16.840.1.113883.6.1'.
			</assert>
			<assert test="count(hl7:targetSiteCode)=0 or count(hl7:targetSiteCode[@code and @codeSystem])=1"
			>ERRORE-58| Sezione <value-of select="$section_value"/>: l'elemento entry<value-of select="substring-after($errorPathObs, '/entry')"/>/observation/targetSiteCode, se presente, deve avere gli attributi @code e @codeSystem valorizzati.</assert>
			<!--specimen-->
			<assert test="count(hl7:specimen)=0 or count(hl7:specimen/hl7:specimenRole/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.174'])=1"
			>ERRORE-59| Sezione <value-of select="$section_value"/>: l'elemento entry<value-of select="substring-after($errorPathObs, '/entry')"/>/observation/specimen, se presente, deve avere l'elemento specimenRole/templateId valorizzato con @root='2.16.840.1.113883.3.1937.777.63.10.174'.</assert>
			<assert test="count(hl7:specimen)=0 or count(hl7:specimen/hl7:specimenRole/hl7:id)=1"
			>ERRORE-60| Sezione <value-of select="$section_value"/>: l'elemento entry<value-of select="substring-after($errorPathObs, '/entry')"/>/observation/specimen, se presente, deve avere l'elemento specimenRole/id.</assert>
			<!--oggetti correlati-->
			<assert test="count(hl7:entryRelationship[hl7:observationMedia])&lt;=1"
			>ERRORE-61| Sezione <value-of select="$section_value"/>: l'elemento entry<value-of select="substring-after($errorPathObs, '/entry')"/>/observation può contenere al più una entryRelationship di tipo observationMedia che riporta l'oggetto correlato.</assert>
			<assert test="count(hl7:entryRelationship[hl7:observationMedia])=0 or
				count(hl7:entryRelationship/hl7:observationMedia/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.209'])=1"
			>ERRORE-62| Sezione <value-of select="$section_value"/>: l'elemento entry<value-of select="substring-after($errorPathObs, '/entry')"/>/observation/entryRelationship/observationMedia, se presente, deve avere l'elemento templateId valorizzato con '2.16.840.1.113883.3.1937.777.63.10.209' .</assert>
			<assert test="count(hl7:entryRelationship[hl7:observationMedia])=0 or
				count(hl7:entryRelationship/hl7:observationMedia/hl7:value[@representation='B64' and @mediaType])=1"
			>ERRORE-63| Sezione <value-of select="$section_value"/>: l'elemento entry<value-of select="substring-after($errorPathObs, '/entry')"/>/observation/entryRelationship/observationMedia, se presente, deve avere l'elemento value valorizzato con gli attributi @representation='B64' e l'attributo @mediaType.</assert>
			<!--Commenti-->
			<assert test="count(hl7:entryRelationship[hl7:act])&lt;=1"
			>ERRORE-64| Sezione <value-of select="$section_value"/>: l'elemento entry<value-of select="substring-after($errorPathObs, '/entry')"/>/observation può contenere al più una entryRelationship di tipo act che riporta i Commenti.</assert>
		</rule>
		
		<!--Controllo sugli attributi di observation-->
		<rule context="//hl7:observation">
			<let name="moodCd" value="@moodCode"/>
			<assert test="count(@classCode)=0 or @classCode='OBS'"
			>ERRORE-65| L'attributo "@classCode" dell'elemento "observation" deve essere valorizzato con 'OBS'</assert>
			<assert test="$moodCd='EVN'"
			>ERRORE-66| L'attributo "@moodCode" dell'elemento "observation" deve essere valorizzato con "EVN".</assert>
		</rule>
	
		<rule context="//hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.150']]/hl7:entryRelationship">
			<let name="errorPathObs">
			  <xsl:for-each select="ancestor::*[not(self::hl7:ClinicalDocument)]">
				<xsl:value-of select="concat('/', name())"/>
			  </xsl:for-each>
			</let>

			<let name="section_code" value="(ancestor::hl7:section/hl7:code/@code)"/>
			<let name="section_value" value="if ($section_code = '29300-1') then 'Procedura' else if ($section_code = '22634-0') then 'Osservazione Macroscopica' else if ($section_code = '22635-7') then 'Osservazione Microscopica' 
			else if ($section_code = '22639-9') then 'Analisi Supplementari dei campioni'  else if ($section_code = '22637-3') then 'Diagnosi' else ''"/>
			
			<assert test="count(hl7:act)=1 or count(hl7:observationMedia)=1 or count(hl7:observation)=1"
				>ERRORE-67| Sezione <value-of select="$section_value"/>: l'elemento entry<value-of select="substring-after($errorPathObs, '/entry')"/>/observation può contenere entryRelationship di tipo:
				- 'observation' (AP-observation)
				- 'act' per Note e commenti
				- 'observationMedia' per Oggetti correlati.</assert>
		</rule>
	
	
	<!-- _____________________________________________ BODY______________________________________________________-->


		<!-- Controllo Sezioni obbligatorie e opzionali-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody">

			<!-- 1. NOTIZIE CLINICHE -->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22636-5']])=0 or count(hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.132'])=1"
			>ERRORE-b1| Sezione Notizie Cliniche: La sezione, se presente, deve contenere l'elemento templateId con l' attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.132'.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22636-5']])=0 or count(hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:text)=1"
			>ERRORE-b2| Sezione Notizie Cliniche: La sezione, se presente, deve contenere l'elemento text.</assert>

			<!-- 2. PROCEDURA -->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='29300-1']])=1"
			>ERRORE-b3| Sezione Procedura: La sezione Procedura deve essere presente.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='29300-1']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.142'])= 1"
			>ERRORE-b4| Sezione Procedura: La sezione deve contenere l'elemento templateId con l' attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.142'.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='29300-1']]/hl7:text)=1"
			>ERRORE-b5| Sezione Procedura: La sezione deve contenere l'elemento text.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='29300-1']]/hl7:entry[hl7:procedure])>=1"
			>ERRORE-b6| Sezione Procedura: La sezione deve contenere almeno una entry di tipo procedure che riporta la Procedura di raccolta del campione.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='29300-1']]/hl7:entry[hl7:act])&lt;=1"
			>ERRORE-b7| Sezione Procedura: La sezione può contenere al più una entry di tipo act che riporta Note e commenti.</assert>
						
			<!-- 3. OSSERVAZIONE MACROSCOPICA -->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22634-0']])=0 or count(hl7:component/hl7:section[hl7:code[@code='22634-0']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.149'])= 1"
			>ERRORE-b8| Sezione Osservazione Macroscopica: La sezione, se presente, deve contenere l'elemento templateId con l' attributo @root valorizzato con ' 2.16.840.1.113883.3.1937.777.63.10.149'.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22634-0']])=0 or count(hl7:component/hl7:section[hl7:code[@code='22634-0']]/hl7:text)=1"
			>ERRORE-b9| Sezione Osservazione Macroscopica: La sezione, se presente, deve contenere l'elemento text</assert>		
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22634-0']])=0 or count(hl7:component/hl7:section[hl7:code[@code='22634-0']]/hl7:entry[hl7:organizer[@classCode='BATTERY' and @moodCode='EVN']])=1"
			>ERRORE-b10| Sezione Osservazione Macroscopica: La sezione deve contenere una entry di tipo organizer il quale deve avere gli attributi @classCode='BATTERY' e @moodCode='EVN'. Tale organizer riporta il dettaglio dell'osservazione Macroscopica.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22634-0']])=0 or count(hl7:component/hl7:section[hl7:code[@code='22634-0']]/hl7:entry/hl7:organizer/hl7:component)>=1"
			>ERRORE-b11| Sezione Osservazione Macroscopica: L'elemento entry/organizer deve avere almeno una component.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22634-0']])=0 or count(hl7:component/hl7:section[hl7:code[@code='22634-0']]/hl7:entry[hl7:act])&lt;=1"
			>ERRORE-b12| Sezione Osservazione Macroscopica: La sezione può contenere al più una entry di tipo act che riporta Note e commenti.</assert>			
			
							
			<!-- 4. OSSERVAZIONE MICROSCOPICA -->				
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22635-7']])=0 or count(hl7:component/hl7:section[hl7:code[@code='22635-7']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.193'])= 1"
			>ERRORE-b13| Sezione Osservazione Microscopica: La sezione, se presente, deve contenere l'elemento templateId con l' attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.193'.</assert>			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22635-7']])=0 or count(hl7:component/hl7:section[hl7:code[@code='22635-7']]/hl7:text)=1"
			>ERRORE-b14| Sezione Osservazione Microscopica: La sezione DEVE contenere l'elemento text obbligatorio </assert>		
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22635-7']])=0 or 
			(count(hl7:component/hl7:section[hl7:code[@code='22635-7']]/hl7:entry[hl7:organizer])=1 and count(hl7:component/hl7:section[hl7:code[@code='22635-7']]/hl7:entry/hl7:organizer[@classCode='BATTERY' and @moodCode='EVN'])=1)"
			>ERRORE-b15| Sezione Osservazione Microscopica: La sezione DEVE contenere almeno un elemento 'entry' di tipo organizer il quale deve avere gli attributi @classCode='BATTERY' e @moodCode='EVN'. Tale organizer riporta il dettaglio dell'osservazione Microscopica.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22635-7']])=0 or count(hl7:component/hl7:section[hl7:code[@code='22635-7']]/hl7:entry/hl7:organizer/hl7:code[@code='102034-6' and @codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b16| Sezione Osservazione Microscopica: L'elemento entry/organizer deve contenere un almeno code valorizzato tramite gli attributi @code='102034-6' e @codeSystem='2.16.840.1.113883.6.1'.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22635-7']])=0 or count(hl7:component/hl7:section[hl7:code[@code='22635-7']]/hl7:entry/hl7:organizer/hl7:component)>=1"
			>ERRORE-b17| Sezione Osservazione Microscopica: L'elemento entry/organizer deve avere almeno una component.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22635-7']])=0 or count(hl7:component/hl7:section[hl7:code[@code='22635-7']]/hl7:entry[hl7:act])&lt;=1"
			>ERRORE-b18| Sezione Osservazione Microscopica: La sezione può contenere al più una entry di tipo act che riporta Note e commenti.</assert>		
			

			<!-- 5. STATO DEL MARGINE -->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='33755-0']])=0 or count(hl7:component/hl7:section[hl7:code[@code='33755-0']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.190'])= 1"
			>ERRORE-b19| Sezione Stato del Margine: La sezione, se presente, deve contenere l'elemento templateId con l' attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.190'.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='33755-0']])=0 or count(hl7:component/hl7:section[hl7:code[@code='33755-0']]/hl7:text)=1"
			>ERRORE-b20| Sezione Stato del Margine: La sezione DEVE contenere l'elemento text obbligatorio.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='33755-0']])=0 or count(hl7:component/hl7:section[hl7:code[@code='33755-0']]/hl7:entry[hl7:act])&lt;=1"
			>ERRORE-b21| Sezione Stato del Margine: La sezione può contenere al più una entry di tipo act che riporta Note e commenti.</assert>

			<!-- 6. ANALISI SUPPLEMENTARI DEI CAMPIONI -->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22639-9']])=0 or count(hl7:component/hl7:section[hl7:code[@code='22639-9']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.197'])=1"
			>ERRORE-b22| Sezione Analisi supplementari dei campioni: La sezione, se presente, deve contenere l'elemento templateId con l' attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.197'.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22639-9']])=0 or count(hl7:component/hl7:section[hl7:code[@code='22639-9']]/hl7:text)=1"
			>ERRORE-b23| Sezione Analisi supplementari dei campioni: La sezione DEVE contenere l'elemento text obbligatorio.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22639-9']])=0 or 
			(count(hl7:component/hl7:section[hl7:code[@code='22639-9']]/hl7:entry[hl7:organizer])=1 and count(hl7:component/hl7:section[hl7:code[@code='22639-9']]/hl7:entry/hl7:organizer[@classCode='BATTERY'])=1)"
			>ERRORE-b24| Sezione Analisi supplementari dei campioni: La sezione DEVE contenere una entry di tipo organizer con l'attributo @classCode valorizzato con 'BATTERY'.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22639-9']])=0 or count(hl7:component/hl7:section[hl7:code[@code='22639-9']]/hl7:entry/hl7:organizer/hl7:component)>=1"
			>ERRORE-b25| Sezione Analisi supplementari dei campioni: l'elemento entry/organizer deve contenere almeno un elemento component di tipo observation.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22639-9']])=0 or count(hl7:component/hl7:section[hl7:code[@code='22639-9']]/hl7:entry[hl7:act])&lt;=1"
			>ERRORE-b26| Sezione Analisi supplementari dei campioni: La sezione può contenere al più una entry di tipo act che riporta Note e commenti.</assert>


			<!-- 7. EPICRISI-->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='85691-4']])=0 or count(hl7:component/hl7:section[hl7:code[@code='85691-4']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.211'])= 1"
			>ERRORE-b27| Sezione Epicrisi: La sezione, se presente, deve contenere l'elemento templateId con l' attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.211'.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='85691-4']])=0 or count(hl7:component/hl7:section[hl7:code[@code='85691-4']]/hl7:text)= 1"
			>ERRORE-b28| Sezione Epicrisi: La sezione DEVE contenere l'elemento text obbligatorio.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='85691-4']])=0 or count(hl7:component/hl7:section[hl7:code[@code='85691-4']]/hl7:entry[hl7:act])&lt;=1"
			>ERRORE-b29| Sezione Epicrisi: La sezione può contenere al più una entry di tipo act che riporta Note e commenti.</assert>
			
			<!-- 8. DIAGNOSI-->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22637-3']])=1"
			>ERRORE-b30| Sezione Diagnosi: La sezione Diagnosi deve essere presente.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.176'])= 1"
			>ERRORE-b31| Sezione Diagnosi: La sezione deve contenere l'elemento templateId con l' attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.176'.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:text)=1"
			>ERRORE-b32| Sezione Diagnosi: La sezione deve contenere l'elemento text.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:entry[hl7:act])&lt;=1"
			>ERRORE-b33| Sezione Diagnosi: La sezione può contenere al più una entry di tipo act che riporta Note e commenti.</assert>

			<!-- entry Diagnosi Conclusiva-->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:entry/hl7:organizer[hl7:code[@code='29308-4' and @codeSystem='2.16.840.1.113883.6.1']])&lt;=1"
			>ERRORE-b34| Sezione Diagnosi: La sezione deve contenere al più una entry di tipo organizer che riporta la Diagnosi Conclusiva (organizer/code [@code='29308-4' and @codeSystem='2.16.840.1.113883.6.1'])</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:entry/hl7:organizer[hl7:code[@code='29308-4']])=0 or
						count(hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:entry/hl7:organizer[hl7:code[@code='29308-4']][@classCode='BATTERY' and @moodCode='EVN'])=1"
			>ERRORE-b35| Sezione Diagnosi: L'elemento entry/organizer (Diagnosi Conclusiva) deve avere gli attributi @classCode='BATTERY' e @moodCode='EVN'.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:entry/hl7:organizer[hl7:code[@code='29308-4']])=0 or
						count(hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:entry/hl7:organizer[hl7:code[@code='29308-4']]/hl7:component[hl7:observation])=1"
			>ERRORE-b36| Sezione Diagnosi: L'elemento entry/organizer (Diagnosi Conclusiva) deve contenere uno ed un solo elemento component di tipo observation.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:entry/hl7:organizer[hl7:code[@code='29308-4']])=0 or
						count(hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:entry/hl7:organizer[hl7:code[@code='29308-4']]/hl7:component/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.150'])=1"
			>ERRORE-b37| Sezione Diagnosi: L'elemento entry/organizer/component/observation (Diagnosi Conclusiva) deve contenere un elemento templateId valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.150'.</assert>

			<!-- entry Classificazione del Tumore-->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:entry/hl7:organizer[hl7:code[@code='22036-8' and @codeSystem='2.16.840.1.113883.6.1']])&lt;=1"
			>ERRORE-b38| Sezione Diagnosi: La sezione deve contenere al più una entry di tipo organizer che riporta la Classificazione del Tumore (organizer/code [@code='22036-8' and @codeSystem='2.16.840.1.113883.6.1']).</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:entry/hl7:organizer[hl7:code[@code='22036-8']])=0 or
						count(hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:entry/hl7:organizer[hl7:code[@code='22036-8']][@classCode='BATTERY' and @moodCode='EVN'])=1"
			>ERRORE-b39| Sezione Diagnosi: L'elemento entry/organizer (Classificazione del Tumore) deve avere gli attributi @classCode='BATTERY' e @moodCode='EVN'.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:entry/hl7:organizer[hl7:code[@code='22036-8']])=0 or
						count(hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:entry/hl7:organizer[hl7:code[@code='22036-8']]/hl7:component[hl7:observation])>=1"
			>ERRORE-b40| Sezione Diagnosi: L'elemento entry/organizer/component/observation (Classificazione del Tumore) deve contenere almeno un elemento component di tipo observation.</assert>
			<let name="num_APobs_CT" value="count(hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:entry/hl7:organizer[hl7:code[@code='22036-8']]/hl7:component[hl7:observation])"/>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:entry/hl7:organizer[hl7:code[@code='22036-8']])=0 or
						count(hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:entry/hl7:organizer[hl7:code[@code='22036-8']]/hl7:component/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.150'])=$num_APobs_CT"
			>ERRORE-b41| Sezione Diagnosi: L'elemento entry/organizer/component/observation (Classificazione del Tumore) deve contenere un elemento templateId valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.150'.</assert>

			<!-- entry Formula del Tumore-->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:entry/hl7:organizer[hl7:code[@code='22640-7' and @codeSystem='2.16.840.1.113883.6.1']])&lt;=1"
			>ERRORE-b42| Sezione Diagnosi: La sezione deve contenere al più una entry di tipo organizer che riporta la Formula del Tumore (organizer/code [@code='22640-7' and @codeSystem='2.16.840.1.113883.6.1']).</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:entry/hl7:organizer/hl7:code[@code='22640-7'])=0 or
						 count(hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:entry/hl7:organizer[hl7:code[@code='22640-7']][@classCode='BATTERY' and @moodCode='EVN'])=1"
			>ERRORE-b43| Sezione Diagnosi: L'elemento entry/organizer (Formula del Tumore) deve avere gli attributi @classCode='BATTERY' e @moodCode='EVN'.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:entry/hl7:organizer[hl7:code[@code='22640-7']]/hl7:component/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.217'])&lt;=1"
			>ERRORE-b44| Sezione Diagnosi: L'elemento entry/organizer (Formula del Tumore) può contenere al più un component/observation (Formula del Tumore TNM) con templateId @root='2.16.840.1.113883.3.1937.777.63.10.217'.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:entry/hl7:organizer[hl7:code[@code='22640-7']]/hl7:component/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.226'])&lt;=1"
			>ERRORE-b45| Sezione Diagnosi: L'elemento entry/organizer (Formula del Tumore) può contenere al più un component/observation (Linfonodi) con templateId @root='2.16.840.1.113883.3.1937.777.63.10.226'.</assert>

			

			<!-- 9. ULTERIORI ACCERTAMENTI DIAGNOSTICI-->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='62385-0']])=0 or count(hl7:component/hl7:section[hl7:code[@code='62385-0']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.220'])= 1"
			>ERRORE-b46| Sezione Ulteriori accertamenti diagnostici: La sezione, se presente, deve contenere l'elemento templateId con l' attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.220'.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='62385-0']])=0 or count(hl7:component/hl7:section[hl7:code[@code='62385-0']]/hl7:text)= 1"
			>ERRORE-b47| Sezione Ulteriori accertamenti diagnostici: La sezione DEVE contenere l'elemento text obbligatorio.</assert>
			
		</rule>
				
		<!--Controllo sui codici delle Section-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component">
			<let name="codice" value="hl7:section/hl7:code/@code"/>
			<assert test="count(hl7:section/hl7:code[@code='22636-5'][@codeSystem='2.16.840.1.113883.6.1'])= 1 or
				count(hl7:section/hl7:code[@code='29300-1'][@codeSystem='2.16.840.1.113883.6.1'])= 1 or
				count(hl7:section/hl7:code[@code='22634-0'][@codeSystem='2.16.840.1.113883.6.1'])= 1 or
				count(hl7:section/hl7:code[@code='22635-7'][@codeSystem='2.16.840.1.113883.6.1'])= 1 or
				count(hl7:section/hl7:code[@code='33755-0'][@codeSystem='2.16.840.1.113883.6.1'])= 1 or
				count(hl7:section/hl7:code[@code='22639-9'][@codeSystem='2.16.840.1.113883.6.1'])= 1 or
				count(hl7:section/hl7:code[@code='85691-4'][@codeSystem='2.16.840.1.113883.6.1'])= 1 or
				count(hl7:section/hl7:code[@code='22637-3'][@codeSystem='2.16.840.1.113883.6.1'])= 1 or
				count(hl7:section/hl7:code[@code='62385-0'][@codeSystem='2.16.840.1.113883.6.1'])= 1"
				>ERRORE-b48| Il codice '<value-of select="$codice"/>' non è corretto. L'elemento code della section DEVE essere valorizzato con uno dei seguenti codici LOINC individuati:
				22636-5 NOTIZIE CLINICHE
				29300-1 PROCEDURA
				22634-0 OSSERVAZIONE MACROSCOPICA
				22635-7	OSSERVAZIONE MICROSCOPICA
				33755-0 STATO DEL MARGINE
				22639-9 ANALISI SUPPLEMENTARI DEI CAMPIONI
				85691-4 EPICRISI
				22637-3 DIAGNOSI
				62385-0 ULTERIORI ACCERTAMENTI DIAGNOSTICI
			</assert>
		</rule>
		
		<!--Controllo sui codici delle sotto-section di 'Notizie Cliniche' **-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:component">
			<let name="codice" value="hl7:section/hl7:code/@code"/>
			<assert test="count(hl7:section/hl7:code[@code='11329-0'][@codeSystem='2.16.840.1.113883.6.1'])= 1 or
				count(hl7:section/hl7:code[@code='42349-1'][@codeSystem='2.16.840.1.113883.6.1'])= 1 or
				count(hl7:section/hl7:code[@code='48765-2'][@codeSystem='2.16.840.1.113883.6.1'])= 1 or
				count(hl7:section/hl7:code[@code='67803-7'][@codeSystem='2.16.840.1.113883.6.1'])= 1 or
				count(hl7:section/hl7:code[@code='8677-7'][@codeSystem='2.16.840.1.113883.6.1'])= 1 or
				count(hl7:section/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.175'])= 1 or
				count(hl7:section/hl7:code[@code='47519-4'][@codeSystem='2.16.840.1.113883.6.1'])= 1 or
				count(hl7:section/hl7:code[@code='55114-3'][@codeSystem='2.16.840.1.113883.6.1'])= 1"
				>ERRORE-b49| Il codice '<value-of select="$codice"/>' non è corretto. L'elemento code della section DEVE essere valorizzato con uno dei seguenti codici LOINC individuati:
				11329-0 ANAMNESI
				42349-1 QUESITO DIAGNOSTICO 
				48765-2 ALLERGIE
				67803-7	PRECEDENTI ESAMI ESEGUITI
				8677-7 TERAPIE FARMACOLOGICHE PREGRESSE
				2.16.840.1.113883.3.1937.777.63.10.175 TERAPIA ONCOLOGICA PREGRESSA
				47519-4 PRECEDENTI TRATTAMENTI E PROCEDURE CHIRURGICHE E DIAGNOSTICHE PREGRESSE
				55114-3 INDAGINI RADIOLOGICHE
			</assert>
		</rule>


		<!--1.1 ANAMNESI -->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:component/hl7:section[hl7:code[@code='11329-0']]">

			<assert test="count(hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.282'])=1"
			>ERRORE-b50| Sotto-sezione Anamnesi: L'elemento section/templateId DEVE avere l'attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.282'.</assert>
			<assert test="count(hl7:text)=1"
			>ERRORE-b51| Sotto-sezione Anamnesi: L'elemento section/text è Obbligatorio.</assert>
		</rule>
				
			<!--entry/observation - Anamnesi Fisiologica-Patologica  -->
			<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:component/hl7:section[hl7:code[@code='11329-0']]/hl7:entry[hl7:observation]">
				<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.135'])=1"
				>ERRORE-b52| Sotto-sezione Anamnesi (entry Fisiologica-Patologica): L'elemento entry/observation/templateId DEVE avere la @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.135'.</assert>
				<assert test="count(hl7:observation/hl7:code[@code='75326-9' and @codeSystem='2.16.840.1.113883.6.1'])=1"
				>ERRORE-b53| Sotto-sezione Anamnesi (entry Fisiologica-Patologica): L'elemento entry/observation/code DEVE avere gli attributi @code valorizzato con 75326-9 e @codeSystem valorizzato con 2.16.840.1.113883.6.1</assert>
				<assert test="count(hl7:observation/hl7:statusCode[@code='completed'])=1"
				>ERRORE-b54| Sotto-sezione Anamnesi (entry Fisiologica-Patologica): L'elemento observation/statusCode DEVE avere gli attributi @code valorizzato 'completed'</assert>
				<assert test="count(hl7:observation/hl7:effectiveTime)=1"
				>ERRORE-b55| Sotto-sezione Anamnesi (entry Fisiologica-Patologica): L'elemento entry/observation/effectiveTime è Obbligatorio.</assert>
				<assert test="count(hl7:observation/hl7:value[@xsi:type='CD'])=1"
				>ERRORE-b56| Sotto-sezione Anamnesi (entry Fisiologica-Patologica): L'elemento entry/observation/value è Obbligatorio e deve essere di tipo xsi:type='CD'.</assert>
				<assert test="count(hl7:observation/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.136'])&lt;=1"
				>ERRORE-b57| Sotto-sezione Anamnesi (entry Fisiologica-Patologica): L'elemento entry/observation può contenere al più una entryRelationship/observation "Cronicità" con templateId valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.136'</assert>
				<assert test="count(hl7:observation/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.137'])&lt;=1"
				>ERRORE-b58| Sotto-sezione Anamnesi (entry Fisiologica-Patologica): L'elemento entry/observation/entryRelationship/observation/templateId è Obbligatorio e l'attributo @root DEVE essere valorizzato con '2.16.840.1.113883.3.1937.777.63.10.137'</assert>
				

			</rule>
			
			<!--entryRelationship/observation - Cronicitò/Stato/-->
			<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:component/hl7:section[hl7:code[@code='11329-0']]/hl7:entry/hl7:observation/hl7:entryRelationship[hl7:observation]">
				<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.136' or @root='2.16.840.1.113883.3.1937.777.63.10.137'])=1"
				>ERRORE-b59| Sotto-sezione Anamnesi (entry Fisiologica-Patologica): L'elemento entry/observation può contenere al più una entryRelationship/observation di tipo:
				- "Cronicità" (@root='2.16.840.1.113883.3.1937.777.63.10.136')
				- "Stato" (@root='2.16.840.1.113883.3.1937.777.63.10.137').</assert>
							
				<!-- 1.1.1.1 Cronicità -->
				<assert test="count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.136']])=0 or 
				count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.136']]/hl7:code[@code='89261-2' and @codeSystem='2.16.840.1.113883.6.1'])=1"
				>ERRORE-b60| Sotto-sezione Anamnesi (entry Fisiologica-Patologica): L'elemento entry/observation/entryRelationship/observation/code è obbligatorio e deve avere l'attributo @code valorizzato con '89261-2' e @codeSystem='2.16.840.1.113883.6.1'.</assert>
				<assert test="count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.136']])=0 or 
				count(hl7:observation/hl7:value[(@code='LA18821-1' or @code='LA28752-6') and @codeSystem='2.16.840.1.113883.2.9.77.22.11.10'])=1"
				>ERRORE-b61| Sotto-sezione Anamnesi (entry Fisiologica-Patologica): L'elemento entry/observation/entryRelationship/observation/value è Obbligatorio e l'attributo @code DEVE essere valorizzato con 'LA18821-1' oppure con 'LA28752-6', mentre l'attributo @codeSystem='2.16.840.1.113883.2.9.77.22.11.10'.</assert>
				
				<!-- 1.1.1.2 Stato -->
				<assert test="count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.137']])= 0 or 
				count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.137']]/hl7:code[@code='33999-4' and @codeSystem='2.16.840.1.113883.6.1'])=1"
				>ERRORE-b62| Sotto-sezione Anamnesi (entry Fisiologica-Patologica): L'elemento entry/observation/entryRelationship/observation/code è obbligatorio e deve avere l'attributo @code valorizzato con '33999-4' e @codeSystem='2.16.840.1.113883.6.1'</assert>
				<assert test="count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.137']])= 0 or 
				count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.137']]/hl7:value[(@code='LA16666-2' or @code='LA18632-2') and @codeSystem='2.16.840.1.113883.2.9.77.22.11.7'])=1"
				>ERRORE-b63| Sotto-sezione Anamnesi (entry Fisiologica-Patologica): L'elemento entry/observation/entryRelationship/observation/value è Obbligatorio e l'attributo @code DEVE essere valorizzato con 'LA16666-2' oppure con 'LA18632-2', e l'attributo @codeSystem='2.16.840.1.113883.2.9.77.22.11.7'.</assert>
				
			</rule>
			
			<!--entry/organizer - Anamnesi Familiare -->
			<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:component/hl7:section[hl7:code[@code='11329-0']]/hl7:entry[hl7:organizer]">
				<assert test="count(hl7:organizer[@classCode='CLUSTER'])=1"
				>ERRORE-b64| Sotto-sezione Anamnesi (entry Anamnesi familiare): L'elemento entry/organizer deve contenere l'attributo @classCode valorizzato con 'CLUSTER'.</assert>
				<assert test="count(hl7:organizer/hl7:code[@code='10157-6' and @codeSystem='2.16.840.1.113883.6.1'])=1"
				>ERRORE-b65| Sotto-sezione Anamnesi (entry Anamnesi familiare): L'elemento entry/organizer deve contenere l'elemento code valorizzato con @code='10157-6' e @codeSystem='2.16.840.1.113883.6.1'.</assert>
				<assert test="count(hl7:organizer/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.138'])=1"
				>ERRORE-b66| Sotto-sezione Anamnesi (entry Anamnesi familiare): L'elemento entry/organizer/templateId è Obbligatorio e l'attributo @root DEVE essere valorizzato con '2.16.840.1.113883.3.1937.777.63.10.138'.</assert>
				<assert test="count(hl7:organizer/hl7:statusCode[@code='completed'])=1"
				>ERRORE-b67| Sotto-sezione Anamnesi (entry Anamnesi familiare): L'elemento entry/organizer/statusCode è obbligatorio e deve avere l'attributo @code valorizzato con 'completed'</assert>
				<assert test="count(hl7:organizer/hl7:subject/hl7:relatedSubject/@classCode)=0 or count(hl7:organizer/hl7:subject/hl7:relatedSubject[@classCode='PRS'])=1"
				>ERRORE-b68| Sotto-sezione Anamnesi (entry Anamnesi familiare): L'elemento entry/organizer/subject/relatedSubject può contenere l'attributo @classCode valorizzato con 'PRS'.</assert>
				<assert test="count(hl7:organizer/hl7:subject/hl7:relatedSubject/hl7:code)=1"
				>ERRORE-b69| Sotto-sezione Anamnesi (entry Anamnesi familiare): L'elemento entry/organizer/subject/relatedSubject deve contenere l'elemento code.</assert>
				<assert test="count(hl7:organizer/hl7:subject/hl7:relatedSubject/hl7:subject/hl7:administrativeGenderCode)=0 or 
				count(hl7:organizer/hl7:subject/hl7:relatedSubject/hl7:subject/hl7:administrativeGenderCode[@code and @codeSystem='2.16.840.1.113883.5.1'])=1"
				>ERRORE-b70| Sotto-sezione Anamnesi (entry Anamnesi familiare): L'elemento entry/organizer/subject/relatedSubject/subject può contenere l'elemento administrativeGenderCode valorizzato secondo il sistema di codifica '2.16.840.1.113883.5.1'.</assert>
				<assert test="count(hl7:organizer/hl7:component[hl7:observation])>=1"
				>ERRORE-b71| Sotto-sezione Anamnesi (entry Anamnesi familiare): L'elemento entry/organizer deve contenere almeno un elemento component di tipo observation.</assert>
			</rule>
			
				<!--entry/organizer/component/observation - Dettaglio Anamnesi Familiare-->
				<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:component/hl7:section[hl7:code[@code='11329-0']]/hl7:entry/hl7:organizer/hl7:component">
					<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.144'])=1"
					>ERRORE-b72| Sotto-sezione Anamnesi (entry Anamnesi familiare): L'elemento entry/organizer/component/observation/templateId deve avere l'attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.144'.</assert>
					<assert test="count(hl7:observation/hl7:text)=1"
					>ERRORE-b73| Sotto-sezione Anamnesi (entry Anamnesi familiare): L'elemento entry/organizer/component/observation/text è obbligatorio.</assert>
					<assert test="count(hl7:observation/hl7:statusCode[@code='completed'])=1"
					>ERRORE-b74| Sotto-sezione Anamnesi (entry Anamnesi familiare): L'elemento entry/organizer/component/observation/statusCode è obbligatorio e deve avere l'attributo @code valorizzato con 'completed'.</assert>
					<assert test="count(hl7:observation/hl7:effectiveTime[@value or @nullFlavor='UNK'])=1 "
					>ERRORE-b75| Sotto-sezione Anamnesi (entry Anamnesi familiare): L'elemento entry/organizer/component/observation deve avere l'elemento effectiveTime valorizzato. Nel caso non se ne conosca il valore, deve essere valorizzato con @nullFlavor='UNK'.</assert>
					<assert test="count(hl7:observation/hl7:value[@code and @codeSystem='2.16.840.1.113883.6.103'])=1 "
					>ERRORE-b76| Sotto-sezione Anamnesi (entry Anamnesi familiare): L'elemento entry/organizer/component/observation deve avere l'elemento value valorizzato secondo il sistema di codifica ICD-9-CM (2.16.840.1.113883.6.103).</assert>
			
					<!--Età insorgenza-->
					<assert test="count(hl7:observation/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.145'])&lt;=1"
					>ERRORE-b77| Sezione Anamnesi Familiare (entry Anamnesi familiare): entry/organizer/component/observation/entryRelationship Età insorgenza può essere presente al più una volta.</assert>
					
					<!--Età decesso-->
					<assert test="count(hl7:observation/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.152'])&lt;=1"
					>ERRORE-b78| Sezione Anamnesi Familiare (entry Anamnesi familiare): entry/organizer/component/observation/entryRelationship Età decesso può essere presente al più una volta.</assert>
					
				</rule>
					<!--Valeria -->
					<!--entry/organizer/component/observation/entryRelationship/observation - Età insorgenza -  Età decesso-->
					<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:component/hl7:section[hl7:code[@code='11329-0']]/hl7:entry/hl7:organizer/hl7:component/hl7:observation/hl7:entryRelationship">
					
						<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.145' or @root='2.16.840.1.113883.3.1937.777.63.10.152'])=1"
						>ERRORE-b79| Sotto-sezione Anamnesi (entry Anamnesi familiare): L'elemento entry/organizer/component/observation può contenere due entryRelationship di tipo:
						-Età insorgenza (observation/templateId='2.16.840.1.113883.3.1937.777.63.10.145')
						-Età decesso (observation/templateId='2.16.840.1.113883.3.1937.777.63.10.152').</assert>
						
						<!--Età insorgenza (component/observation/entryRelationship/observation)-->
						<assert test=" count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.145'])=0 or
						 count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.145']]/hl7:code[@code='35267-4' and @codeSystem='2.16.840.1.113883.6.1'])=1"
						>ERRORE-b80| Sezione Anamnesi Familiare (entry Anamnesi familiare): entry/organizer/component/observation/entryRelationship/observation (Età insorgenza) deve contenere un elemento code valorizzato @code='35267-4' e @codeSystem='2.16.840.1.113883.6.1'.</assert>
						<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.145'])=0 or 
						count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.145']]/hl7:value[@xsi:type='IVL_PQ'])=1"
						>ERRORE-b81| Sezione Anamnesi Familiare (entry Anamnesi familiare): entry/organizer/component/observation/entryRelationship/observation (Età insorgenza) DEVE contenere un elemento 'value' di tipo IVL_PQ.</assert>
						
						<!--Età decesso (component/observation/entryRelationship/observation)-->
						
						<assert test=" count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.152'])=0 or
						 count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.152']]/hl7:code[@code='39016-1'])=1"
						>ERRORE-b82| Sezione Anamnesi Familiare (entry Anamnesi familiare): entry/organizer/component/observation/entryRelationship/observation/code DEVE essere valorizzato secondo il value set "EtàInsorgenza" derivato da -@codeSystem='2.16.840.1.113883.6.1':
						- @code='39016-1': età di decesso</assert>
						<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.152'])=0 or 
						count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.152']]/hl7:value[@xsi:type='IVL_PQ'])=1"
						>ERRORE-b83| Sezione Anamnesi Familiare (entry Anamnesi familiare): entry/organizer/component/observation/entryRelationship/observation DEVE contenere un elemento 'value'</assert>						
					</rule>


		<!--1.2 QUESITO DIAGNOSTICO -->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:component/hl7:section[hl7:code[@code='42349-1']]">
			<assert test="count(hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.130'])=1"
			>ERRORE-b84| Sotto-sezione Quesito diagnostico: L'elemento section/templateId DEVE avere l'attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.130'.</assert>
			<assert test="count(hl7:text)=1"
			>ERRORE-b85| Sotto-sezione Quesito diagnostico: l'elemento text è obbligatorio.</assert>
			
			<assert test="count(hl7:entry[hl7:observation])&lt;=1"
			>ERRORE-b86| Sotto-sezione Quesito diagnostico: La sezione può contenere al più una entry di tipo observation che riporta la Diagnosi accertata o sospettata.</assert>
			<assert test="count(hl7:entry[hl7:act])&lt;=1"
			>ERRORE-b87| Sotto-sezione Quesito diagnostico: La sezione può contenere al più una entry di tipo act che riporta Note e commenti.</assert>
			<!--observation Quesito diagnostico-->
			<assert test="count(hl7:entry/hl7:observation)=0 or count(hl7:entry/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.131'])=1"
			>ERRORE-b88| Sotto-sezione Quesito diagnostico: L'elemento entry/observation/templateId è obbligatorio e DEVE avere l'attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.131'</assert>
			<assert test="count(hl7:entry/hl7:observation)=0 or count(hl7:entry/hl7:observation/hl7:code[@code='29308-4' and @codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b89| Sotto-sezione Quesito diagnostico: L'elemento entry/observation/code è obbligatorio e DEVE avere come attributi @code e codeSystem valorizzati con '29308-4' e '2.16.840.1.113883.6.1'</assert>
			<assert test="count(hl7:entry/hl7:observation)=0 or count(hl7:entry/hl7:observation/hl7:value)=1"
			>ERRORE-b90| Sotto-sezione Quesito diagnostico: L'elemento entry/observation/value è obbligatorio	</assert>
			
		</rule>


		<!-- 1.3 ALLERGIE -->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:component/hl7:section[hl7:code[@code='48765-2']]">
			<assert test="count(hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.155'])=1"
			>ERRORE-b91| Sotto-sezione Allergie: L'elemento templateId è Obbligatorio e deve avere l'attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.155'.</assert>
			<assert test="count(hl7:text)=1"
			>ERRORE-b92| Sotto-sezione Allergie: l'elemento text è obbligatorio.</assert>
			<!--act Note e commenti-->
			<assert test="count(hl7:entry[hl7:act/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.279']])&lt;=1"
			>ERRORE-b93| Sotto-sezione Allergie: La sezione può contenere al più una entry di tipo act che riporta Note e commenti.</assert>
			<assert test="count(hl7:entry/hl7:act/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.279'])=0 or 
			count(hl7:entry/hl7:act[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.279']]/hl7:code[@code='48767-8' and @codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b94| Sotto-sezione Allergie: L'elemento entry/act/code di Note e commenti è obbligatorio e deve avere l'attributo @code valorizzato con '48767-8' e @codeSystem con '2.16.840.1.113883.6.1'.</assert>
			<assert test="count(hl7:entry/hl7:act/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.279'])=0 or 
			count(hl7:entry/hl7:act[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.279']]/hl7:text)=1"
			>ERRORE-b95| Sotto-sezione Allergie: L'elemento entry/act/text di Note e commenti è obbligatorio.</assert>
			
		</rule>
			
			<!--entry/act - Allergie - ACT-->
			<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:component/hl7:section[hl7:code[@code='48765-2']]/hl7:entry[hl7:act/hl7:templateId[@root!='2.16.840.1.113883.3.1937.777.63.10.279']]">
				<assert test="count(hl7:act/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.156'])=1"
				>ERRORE-b96| Sotto-sezione Allergie: L'elemento entry/act deve contenere il tag templateId con l'attributo @root valorizzato con:
				- '2.16.840.1.113883.3.1937.777.63.10.156' - Dati Allergie (0..N)
				- '2.16.840.1.113883.3.1937.777.63.10.279' - Note e commenti (0..1).</assert> <!-- Chiedere -->
				<assert test="count(hl7:act/hl7:statusCode)=1"
				>ERRORE-b97| Sotto-sezione Allergie: l'elemento entry/act/statusCode è obbligatorio.</assert>
				<assert test="count(hl7:act/hl7:effectiveTime)=1"
				>ERRORE-b98| Sotto-sezione Allergie: l'elemento entry/act/effectiveTime è obbligatorio.</assert>
				<!--Dettaglio allergia o intolleranza ER/observation-->
				<assert test="count(hl7:act/hl7:entryRelationship[@typeCode='SUBJ']/hl7:observation[@moodCode='EVN'])=1"
				>ERRORE-b99| Sotto-sezione Allergie: l'elemento entry/act deve contenere una entryRelationship con @typeCode='SUBJ' e deve essere di tipo observation.</assert>
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.157'])=1"
				>ERRORE-b100| Sotto-sezione Allergie: l'elemento entry/act/entryRelationship/observation deve contenere elemento templateId con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.157'.</assert>
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:code[@code='52473-6' and @codeSystem='2.16.840.1.113883.6.1'])=1"
				>ERRORE-b101| Sotto-sezione Allergie: l'elemento entry/act/entryRelationship/observation/code è obbligatorio e deve avere gli attributi @code e @codeSystem valorizzati con '52473-6' '2.16.840.1.113883.6.1'.</assert>
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:statusCode[@code='completed'])=1"
				>ERRORE-b102| Sotto-sezione Allergie: l'elemento entry/act/entryRelationship/observation/statusCode è obbligatorio e deve avere l' attributo @code valorizzati con 'completed'.</assert>
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:effectiveTime)=1"
				>ERRORE-b103| SSotto-sezione Allergie: l'elemento entry/act/entryRelationship/observation/effectiveTime è obbligatorio.</assert>
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:value)=1"
				>ERRORE-b104| Sotto-sezione Allergie: l'elemento entry/act/entryRelationship/observation/value è obbligatorio.</assert>
				
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:participant)>=1"
				>ERRORE-b105| Sotto-sezione Allergie: l'elemento entry/act/entryRelationship/observation deve contenere almeno un participant che riporta la sostanza scatenante.</assert>
				
				<!--Descrizione Criticità-->
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='SUBJ'][hl7:observation])&lt;=1"
				>ERRORE-b106| Sotto-sezione Allergie: l'elemento entry/act/entryRelationship/observation può contenere al più una entryRelationship con @typeCode='SUBJ' che riporta la Descrizione Criticità.</assert>
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='SUBJ'][hl7:observation])=0 or 
				count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='SUBJ']/hl7:observation[@moodCode='EVN'])=1 "
				>ERRORE-b107| Sotto-sezione Allergie: la entryRelationship "Descrizione Criticità" deve contenere un elemento observation con l'attributo @moodCode='EVN'.</assert>
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='SUBJ'][hl7:observation])=0 or 
				count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='SUBJ']/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.164'])=1 "
				>ERRORE-b108| Sotto-sezione Allergie: la entryRelationship/observation "Descrizione Criticità" deve contenere un elemento templateId con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.164'.</assert>
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='SUBJ'][hl7:observation])=0 or 
				count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='SUBJ']/hl7:observation/hl7:code[@code='82606-5' and @codeSystem='2.16.840.1.113883.6.1'])=1 "
				>ERRORE-b109| Sotto-sezione Allergie: la entryRelationship/observation "Descrizione Criticità" deve contenere un elemento code valorizzato con @code='82606-5' e @codeSystem='2.16.840.1.113883.6.1'.</assert>
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='SUBJ']/hl7:observation/hl7:statusCode)=0 or 
				count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='SUBJ']/hl7:observation/hl7:statusCode[@code='completed'])=1 "
				>ERRORE-b109a| Sotto-sezione Allergie: la entryRelationship/observation "Descrizione Criticità" può contenere un elemento statusCode valorizzato con @code='completed'.</assert>
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='SUBJ'][hl7:observation])=0 or 
				count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='SUBJ']/hl7:observation/hl7:value[@code and @codeSystem])=1 "
				>ERRORE-b110| Sotto-sezione Allergie: la entryRelationship/observation "Descrizione Criticità" deve contenere un elemento value codificato.</assert>
				
				<!-- Stato dell'Allergia/Intolleranza-->
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='REFR'][hl7:observation])&lt;=1"
				>ERRORE-b111| Sotto-sezione Allergie: l'elemento entry/act/entryRelationship/observation può contenere al più una entryRelationship con @typeCode='REFR' che riporta lo Stato dell'Allergia.</assert>
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='REFR'])=0 or 
				count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='REFR']/hl7:observation[@moodCode='EVN'])=1 "
				>ERRORE-b112| Sotto-sezione Allergie: la entryRelationship "Stato dell'Allergia" deve contenere un elemento observation con l'attributo @moodCode='EVN'.</assert>
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='REFR'])=0 or 
				count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='REFR']/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.165'])=1 "
				>ERRORE-b113| Sotto-sezione Allergie: la entryRelationship/observation "Stato dell'Allergia" deve contenere un elemento templateId con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.165'.</assert>
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='REFR'])=0 or 
				count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='REFR']/hl7:observation/hl7:code[@code='33999-4' and @codeSystem='2.16.840.1.113883.6.1'])=1 "
				>ERRORE-b114| Sotto-sezione Allergie: la entryRelationship/observation "Stato dell'Allergia" deve contenere un elemento code valorizzato con @code='33999-4' e @codeSystem='2.16.840.1.113883.6.1'.</assert>
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='REFR']/hl7:observation/hl7:statusCode)=0 or 
				count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='REFR']/hl7:observation/hl7:statusCode[@code='completed'])=1 "
				>ERRORE-b114a| Sotto-sezione Allergie: la entryRelationship/observation "Stato dell'Allergia" può contenere un elemento statusCode valorizzato con @code='completed'.</assert>
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='REFR'])=0 or 
				count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='REFR']/hl7:observation/hl7:value[(@code='LA16666-2' or @code='LA18632-2') and @codeSystem='2.16.840.1.113883.2.9.77.22.11.7'])=1 "
				>ERRORE-b115| Sotto-sezione Allergie: la entryRelationship/observation "Stato dell'Allergia" deve contenere un elemento value con l'attributo @code valorizzato con 'LA16666-2' oppure con 'LA18632-2', e l'attributo @codeSystem='2.16.840.1.113883.2.9.77.22.11.7'.</assert>
				
				<!-- Commenti-->
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='SUBJ'][hl7:act])&lt;=1"
				>ERRORE-b116| Sotto-sezione Allergie: l'elemento entry/act/entryRelationship/observation può contenere al più una entryRelationship con @typeCode='SUBJ' che riporta i Commenti.</assert>
			</rule>
			
				<!--participant - Descrizione Agente-->
				<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:component/hl7:section[hl7:code[@code='48765-2']]/hl7:entry/hl7:act/hl7:entryRelationship/hl7:observation/hl7:participant">	
					<assert test="count(hl7:participantRole/hl7:playingEntity/hl7:code[@nullFlavor='UNK' and not(@code or @codeSystem or @codeSystemName or @displayName)])=1 or
						count(hl7:participantRole/hl7:playingEntity/hl7:code[@code and @codeSystem='2.16.840.1.113883.6.73' and not(@nullFlavor)])=1 or
						count(hl7:participantRole/hl7:playingEntity/hl7:code[@code and @codeSystem='2.16.840.1.113883.2.9.6.1.5' and not(@nullFlavor)])=1 or
						count(hl7:participantRole/hl7:playingEntity/hl7:code[@code and @codeSystem='2.16.840.1.113883.2.9.77.22.11.2' and not(@nullFlavor)])=1"
						>ERRORE-b117| Sotto sezione Allergie: L'elemento participant/participantRole/playingEntity deve avere l'attributo code valorizzato con @nullFlavor='UNK' nel caso in cui non è noto l'agente della reazione allergica altrimenti
						code/@codeSystem valorizzato come segue:
						- '2.16.840.1.113883.6.73' per la codifica "WHO ATC"
						- '2.16.840.1.113883.2.9.6.1.5' per la codifica "AIC"
						- '2.16.840.1.113883.2.9.77.22.11.2' per il value set "AllergenNoDrugs" (- per le allergie non a farmaci –)
					</assert>
					
				</rule>			
				
				<!--entryRelationship/observation - Descrizione reazioni-->
				<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:component/hl7:section[hl7:code[@code='48765-2']]/hl7:entry/hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='MFST']">
					<assert test="count(hl7:observation[@moodCode='EVN'])=1 "
					>ERRORE-b118| Sotto-sezione Allergie: la entryRelationship "Descrizione Reazioni" deve contenere un elemento observation con l'attributo @moodCode='EVN'.</assert>
					<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.163'])=1 "
					>ERRORE-b119| Sotto-sezione Allergie: la entryRelationship "Descrizione Reazioni" deve contenere un elemento templateId con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.163'.</assert>
					<assert test="count(hl7:observation/hl7:code[@code='75321-0' and @codeSystem='2.16.840.1.113883.6.1'])=1 "
					>ERRORE-b120| Sotto-sezione Allergie: la entryRelationship "Descrizione Reazioni" deve contenere un elemento code valorizzato con @code='75321-0' e @codeSystem='2.16.840.1.113883.6.1'.</assert>
					<assert test="count(hl7:observation/hl7:effectiveTime)=1 "
					>ERRORE-b121| Sotto-sezione Allergie: la entryRelationship "Descrizione Reazioni" deve contenere un elemento effectiveTime.</assert>
					<assert test="count(hl7:observation/hl7:value)=1 "
					>ERRORE-b122| Sotto-sezione Allergie: la entryRelationship "Descrizione Reazioni" deve contenere un elemento value.</assert>

				</rule>
		
	
		<!-- 1.4 PRECEDENTI ESAMI ESEGUITI -->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:component/hl7:section[hl7:code[@code='67803-7']]">
			<assert test="count(hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.167'])=1"
			>ERRORE-b123| Sotto-sezione Precedenti Esami eseguiti: la sezione deve avere l'elemento templateId con l'attributo @root valorizzato come '2.16.840.1.113883.3.1937.777.63.10.167'</assert>
			<assert test="count(hl7:text)=1"
			>ERRORE-b124| Sotto-sezione Precedenti Esami eseguiti: la sezione deve avere l'elemento text.</assert>
			
			<!--act Note e commenti-->
			<assert test="count(hl7:entry[hl7:act])&lt;=1"
			>ERRORE-b125| Sotto-sezione Precedenti Esami eseguiti: La sezione può contenere al più una entry di tipo act che riporta Note e commenti.</assert>

		</rule>
			
			<!--entry/observation - Precedenti Esami eseguiti-->
			<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:component/hl7:section[hl7:code[@code='67803-7']]/hl7:entry[hl7:observation]">
				<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.168'])=1"
				>ERRORE-b126| Sotto-sezione Precedenti Esami eseguiti: L'elemento entry/observation deve avere l'elemento templateId con l'attributo @root valorizzato con @root='2.16.840.1.113883.3.1937.777.63.10.168'</assert>
				<assert test="count(hl7:observation/hl7:value)=0 or
				(count(hl7:observation/hl7:value[@xsi:type='CD' and @code and @codeSystem])=1 or
				count(hl7:observation/hl7:value[@xsi:type='ST'])=1)"
				>ERRORE-b126a| Sotto-sezione Precedenti Esami eseguiti: L'elemento entry/observation/value, se presente, deve essere di tipo 'ST' oppure 'CD' </assert>
			</rule>
				
		
		<!--1.5 TERAPIE FARMACOLOGICHE PREGRESSE)-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:component/hl7:section[hl7:code[@code='8677-7']]">
			<assert test="count(hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.169'])=1"
			>ERRORE-b127| Sotto-sezione Terapie Farmacologiche Pregresse: la sezione deve avere l'elemento templateId con l'attributo @root valorizzato come @root='2.16.840.1.113883.3.1937.777.63.10.169'</assert>
			<assert test="count(hl7:text)=1"
			>ERRORE-b128| Sotto-sezione Terapie Farmacologiche Pregresse: la sezione deve avere l'elemento text.</assert>
			
			<!--act Note e commenti-->
			<assert test="count(hl7:entry[hl7:act])&lt;=1"
			>ERRORE-b129| Sotto-sezione Terapie Farmacologiche Pregresse: La sezione può contenere al più una entry di tipo act che riporta Note e commenti.</assert>

		</rule>
			
			<!--entry/substanceAdministration - Dettaglio farmaco-->
			<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:component/hl7:section[hl7:code[@code='8677-7']]/hl7:entry[hl7:substanceAdministration]">
				<assert test="count(hl7:substanceAdministration/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.170'])=1"
				>ERRORE-b130| Sotto-sezione Terapie Farmacologiche Pregresse: l'elemento entry/sunstanceAdministration deve avere l'elemento templateId con l'attributo @root valorizzato come @root='2.16.840.1.113883.3.1937.777.63.10.170'</assert>
				<assert test="count(hl7:substanceAdministration/hl7:consumable/@typeCode)=1"
				>ERRORE-b131| Sotto-sezione Terapie Farmacologiche Pregresse: l'elemento entry/sunstanceAdministration deve contenere l'elemento consumable con l'attributo @typeCode valorizzato come @typeCode='CSM'</assert>
				<assert test="count(hl7:substanceAdministration/hl7:consumable/hl7:manufacturedProduct/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.171'])=1"
				>ERRORE-b132| Sotto-sezione Terapie Farmacologiche Pregresse: l'elemento entry/substanceAdministration/manufacturedProduct deve avere un templateId valorizzato con @root='2.16.840.1.113883.3.1937.777.63.10.171'</assert>
				<assert test="count(hl7:substanceAdministration/hl7:consumable/hl7:manufacturedProduct/hl7:manufacturedMaterial/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.172'])=1"
				>ERRORE-b133| Sotto-sezione Terapie Farmacologiche Pregresse: l'elemento entry/substanceAdministration/manufacturedProduct/manufacturedMaterial deve contenere un templateId valorizzato come @root='2.16.840.1.113883.3.1937.777.63.10.172'</assert>
				<assert test="count(hl7:substanceAdministration/hl7:consumable/hl7:manufacturedProduct/hl7:manufacturedMaterial/hl7:code)=1"
				>ERRORE-b134| Sotto-sezione Terapie Farmacologiche Pregresse: l'elemento entry/substanceAdministration/manufacturedProduct/manufacturedMaterial deve contenere un elemento code.</assert>
			</rule>
	
	
		<!--1.6 TERAPIA ONCOLOGICA PREGRESSA-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.175']]">
			<assert test="count(hl7:code[@codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b135| Sotto-sezione Terapia Oncologica Pregressa: la sezione deve contenere un elemento code e il codeSystem valorizzato con '2.16.840.1.113883.6.1' .</assert>
			<assert test="count(hl7:text)=1"
			>ERRORE-b136| Sotto-sezione Terapia Oncologica Pregressa: la sezione deve avere l'elemento text.</assert>
			<!--act Note e commenti-->
			<assert test="count(hl7:entry[hl7:act])&lt;=1"
			>ERRORE-b137| Sotto-sezione Terapia Oncologica Pregressa: La sezione può contenere al più una entry di tipo act che riporta Note e commenti.</assert>

		</rule>
			
			<!--entry/substanceAdministration - Dettaglio farmaco-->
			<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.175']]/hl7:entry[hl7:substanceAdministration]">
				<assert test="count(hl7:substanceAdministration/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.170'])=1"
				>ERRORE-b138| Sotto-sezione Terapia Oncologica Pregressa: l'elemento entry/substanceAdministration deve avere l'elemento templateId con l'attributo @root valorizzato come @root='2.16.840.1.113883.3.1937.777.63.10.170'</assert>
				<assert test="count(hl7:substanceAdministration/hl7:consumable/@typeCode)=1"
				>ERRORE-b139| Sotto-sezione Terapia Oncologica Pregressa: l'elemento entry/substanceAdministration deve contenere l'elemento consumable con l'attributo @typeCode valorizzato come @typeCode='CSM'</assert>
				<assert test="count(hl7:substanceAdministration/hl7:consumable/hl7:manufacturedProduct/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.171'])=1"
				>ERRORE-b140| Sotto-sezione Terapia Oncologica Pregressa: l'elemento entry/substanceAdministration/manufacturedProduct deve avere un templateId valorizzato con @root='2.16.840.1.113883.3.1937.777.63.10.171'</assert>
				<assert test="count(hl7:substanceAdministration/hl7:consumable/hl7:manufacturedProduct/hl7:manufacturedMaterial/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.172'])=1"
				>ERRORE-b141| Sotto-sezione Terapia Oncologica Pregressa: l'elemento entry/substanceAdministration/manufacturedProduct/manufacturedMaterial deve contenere un templateId valorizzato come @root='2.16.840.1.113883.3.1937.777.63.10.172'</assert>
				<assert test="count(hl7:substanceAdministration/hl7:consumable/hl7:manufacturedProduct/hl7:manufacturedMaterial/hl7:code)=1"
				>ERRORE-b142| Sotto-sezione Terapia Oncologica Pregressa: l'elemento entry/substanceAdministration/manufacturedProduct/manufacturedMaterial deve contenere un elemento code.</assert>
			</rule> <!-- Valeria-->
			
			<!--entry/procedure - Procedure - RAP-->
			<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.175']]/hl7:entry[hl7:procedure]">
				<assert test="count(hl7:procedure[@moodCode='EVN'])=1 and (count(hl7:procedure[@classCode])=0 or count(hl7:procedure[@classCode='PROC'])=1)"
				>ERRORE-b143| Sotto-sezione Terapia Oncologica Pregressa: l'elemento entry/procedure deve avere l'elemento templateId con l'attributo @root valorizzato come @root='2.16.840.1.113883.3.1937.777.63.10.183'</assert>
				<assert test="count(hl7:procedure/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.183'])=1"
				>ERRORE-b144| Sotto-sezione Terapia Oncologica Pregressa: l'elemento entry/procedure deve avere l'elemento templateId con l'attributo @root valorizzato come @root='2.16.840.1.113883.3.1937.777.63.10.183'</assert>
				<assert test="count(hl7:procedure/hl7:code)=1"
				>ERRORE-b145| Sotto-sezione Terapia Oncologica Pregressa: l'elemento entry/procedure deve avere l'elemento code.</assert>
			</rule>		
		
		
		<!--1.7 PRECEDENTI TRATTAMENTI E PROCEDURE CHIRURGICHE E DIAGNOSTICHE PREGRESSE -->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:component/hl7:section[hl7:code[@code='47519-4']]">
			<assert test="count(hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.180'])= 1"
			>ERRORE-b146| Sotto-sezione Precedenti Trattamenti e procedure chirurgiche e diagnostiche pregresse: La sezione, se presente, deve contenere l'elemento templateId con l' attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.180'.</assert>
			<assert test="count(hl7:text)=1"
			>ERRORE-b147| Sotto-sezione Precedenti Trattamenti e procedure chirurgiche e diagnostiche pregresse: La sezione DEVE contenere l'elemento text obbligatorio </assert>	
			<!--act Note e commenti-->
			<assert test="count(hl7:entry[hl7:act])&lt;=1"
			>ERRORE-b148| Sotto-sezione Precedenti Trattamenti e procedure chirurgiche e diagnostiche pregresse: La sezione può contenere al più una entry/act per Note e Commenti</assert>
	
		</rule>
			
			<!-- entry/procedure - Procedure - RAP-->
			<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:component/hl7:section[hl7:code[@code='47519-4']]/hl7:entry[hl7:procedure]">
				<assert test="count(hl7:procedure[@moodCode='EVN'])= 1"
				>ERRORE-b149| Sotto-sezione Precedenti Trattamenti e procedure chirurgiche e diagnostiche pregresse: l'elemento entry/procedure deve avere valorizzato l'attributo @moodCode='EVN'.</assert>			
				<assert test="count(hl7:procedure/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.183'])= 1"
				>ERRORE-b150| Sotto-sezione Precedenti Trattamenti e procedure chirurgiche e diagnostiche pregresse: l'elemento entry/procedure deve contenere l'elemento templateId con l' attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.183'.</assert>
				<assert test="count(hl7:procedure/hl7:code)=1"
				>ERRORE-b151| Sotto-sezione Precedenti Trattamenti e procedure chirurgiche e diagnostiche pregresse: l'elemento entry/procedur deve contenere l'elemento code con gli attributi @code e @codeSystem valorizzti.</assert>
			</rule>
		
		
		<!--1.8 INDAGINI RADIOLOGICHE -->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:component/hl7:section[hl7:code[@code='55114-3']]">
			<assert test="count(hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.184'])= 1"
			>ERRORE-b152| Sotto-sezione Indagini Radiologiche: La sezione, se presente, deve contenere l'elemento templateId con l' attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.184'.</assert>
			<assert test="count(hl7:text)=1"
			>ERRORE-b153| Sotto-sezione Indagini Radiologiche: La sezione DEVE contenere l'elemento text obbligatorio.</assert>
			<!--act Note e commenti-->
			<assert test="count(hl7:entry[hl7:act])&lt;=1"
			>ERRORE-b154| Sotto-sezione Indagini Radiologiche: La sezione può contenere al più una entry/act per Note e Commenti.</assert>

		</rule>
			
			<!--entry/observation - IndaginiRadiologiche - RAP-->
			<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22636-5']]/hl7:component/hl7:section[hl7:code[@code='55114-3']]/hl7:entry[hl7:observation]">
				<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.186'])= 1"
				>ERRORE-b155| Sotto-sezione Indagini Radiologiche: l'elemento entry/observation deve contenere l'elemento templateId con l' attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.186'.</assert>				
				<assert test="count(hl7:observation/hl7:text)=1"
				>ERRORE-b156| Sotto-sezione Indagini Radiologiche: l'elemento entry/observation deve contenere l'elemento text obbligatorio.</assert>
				<assert test="count(hl7:observation/hl7:value)=0 or count(hl7:observation/hl7:value[@xsi:type='ST'])=1"
				>ERRORE-b157| Sotto-sezione Indagini Radiologiche: l'elemento entry/observation può contenere un elemento value di tipo @xsi:type='ST'.</assert>
			</rule>

		
		
		
		<!-- 2.1 PROCEDURA -->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='29300-1']]/hl7:entry[hl7:procedure]">
			<assert test="count(hl7:procedure[@moodCode='EVN'])=1"
			>ERRORE-b158| Sezione Procedura: l'elemento entry/procedure deve avere valorizzato l'attributo @moodCode='EVN'.</assert>
			<assert test="count(hl7:procedure/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.143'])=1"
			>ERRORE-b159| Sezione Procedura: l'elemento entry/procedure deve contenere l'elemento templateId con l' attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.143'.</assert>
			<assert test="count(hl7:procedure/hl7:code[@codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b160| Sezione Procedura: l'elemento entry/procedure/code deve contenere l'elemento code valorizzato tramite @codeSystem='2.16.840.1.113883.6.1'.</assert>
			<assert test="count(hl7:procedure/hl7:effectiveTime)=1"
			>ERRORE-b161| Sezione Procedura: l'elemento entry/procedure/effectiveTime è Obbligatorio.</assert>
			<assert test="count(hl7:procedure/hl7:methodCode[@codeSystem='2.16.840.1.113883.6.96'])=1"
			>ERRORE-b162| Sezione Procedura: l'elemento entry/procedure/methodCode deve contenere l'elemento code valorizzato tramite @codeSystem='2.16.840.1.113883.6.96'.</assert>
			<let name="num_site" value="count(hl7:procedure/hl7:targetSiteCode)"/>
			<assert test="count(hl7:procedure/hl7:targetSiteCode[@codeSystem='2.16.840.1.113883.6.96'])=$num_site"
			>ERRORE-b163| Sezione Procedura: l'elemento entry/procedure/targetSiteCode , se presente, deve contenere l'elemento code valorizzato tramite @codeSystem='2.16.840.1.113883.6.96'.</assert>
			<assert test="count(hl7:procedure/hl7:approachSiteCode)=0 or count(hl7:procedure/hl7:approachSiteCode[@codeSystem='2.16.840.1.113883.6.96'])=1"
			>ERRORE-b164| Sezione Procedura: l'elemento entry/procedure/approachSiteCode , se presente, deve contenere l'elemento code valorizzato tramite @codeSystem='2.16.840.1.113883.6.96'.</assert>
			<assert test="count(hl7:procedure/hl7:specimen)=1"
			>ERRORE-b165| Sezione Procedura: l'elemento entry/procedure/specimen è Obbligatorio.</assert>
			<assert test="count(hl7:procedure/hl7:specimen/hl7:specimenRole/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.259'])=1"
			>ERRORE-b166| Sezione Procedura: l'elemento entry/procedure/specimen/specimenRole deve contenere l'elemento templateId con l' attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.259'.</assert>
			
			<!-- entryRelationship/supply - Identificativo contenitore-->
			<assert test="count(hl7:procedure/hl7:entryRelationship/hl7:supply[@moodCode='EVN'])=1"
			>ERRORE-b167| Sezione Procedura: l'elemento entry/procedure deve contenere una entryRelationship di tipo supply con l'attributo @moodCode='EVN' che specifica l’identificativo del contenitore del campione utilizzato.</assert>
			<assert test="count(hl7:procedure/hl7:entryRelationship/hl7:supply/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.251'])=1"
			>ERRORE-b168| Sezione Procedura: l'elemento entry/procedure/entryRelationship/supply deve contenere l'elemento templateId con l' attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.251'.</assert>
			<assert test="count(hl7:procedure/hl7:entryRelationship/hl7:supply/hl7:id)=1"
			>ERRORE-b169| Sezione Procedura: l'elemento entry/procedure/entryRelationship/supply deve contenere l'elemento id.</assert>
			<assert test="count(hl7:procedure/hl7:entryRelationship/hl7:supply/hl7:code[@code='74384-9' and @codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b170| Sezione Procedura: l'elemento entry/procedure/entryRelationship/supply/code deve avere l'attributo @code e @codeSystem valorizzati con '74384-9'e '2.16.840.1.113883.6.1'.</assert>
			<assert test="count(hl7:procedure/hl7:entryRelationship/hl7:supply/hl7:statusCode[@code='completed'])=1"
			>ERRORE-b171| Sezione Procedura: l'elemento entry/procedure/entryRelationship/supply/statusCode deve avere l'attributo @code 'completed'.</assert>
			
			<!-- entryRelationship/observation Commenti-->
			<let name="num_AP_OBS" value="count(hl7:procedure/hl7:entryRelationship/hl7:observation)"/>
			<assert test="count(hl7:procedure/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.150'])=$num_AP_OBS"
			>ERRORE-b172| Sezione Procedura: ciascun elemento entry/procedure/entryRelationship/observation deve contenere un elemento templateId valorizzato con @root='2.16.840.1.113883.3.1937.777.63.10.150'.</assert>
			<!-- entryRelationship/act - Commenti-->
			<assert test="count(hl7:procedure/hl7:entryRelationship/hl7:act[@classCode='ACT' and @moodCode='EVN'])&lt;=1"
			>ERRORE-b173| Sezione Procedura: l'elemento entry/procedure può contenere al più una entryRelationship di tipo act con gli attributi @classCode='ACT' e @moodCode='EVN' .</assert>

		</rule>

			<!-- 2.1.1 entryRelationship/observationMedia - Oggetti Correlati -->
			<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='29300-1']]/hl7:entry/hl7:procedure/hl7:entryRelationship[hl7:observationMedia]">
			<assert test="count(hl7:observationMedia/@classCode)=0 or count(hl7:observationMedia[@classCode='OBS'])=1"
			>ERRORE-b174| Sezione Procedura: l'elemento entry/procedure può contenere almeno una entryRelationship di tipo observationMedia con l'attributo @classCode='OBS'.</assert>
			<assert test="count(hl7:observationMedia/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.257'])=1"
			>ERRORE-b175| Sezione Procedura: l'elemento entry/procedure/entryRelationship/observationMedia, se presente, deve avere l'elemento templateId con l'attributo @root valorizzato con @root='2.16.840.1.113883.3.1937.777.63.10.257'.</assert>
			<assert test="count(hl7:observationMedia/hl7:value[@representation='B64' and @mediaType])=1"
			>ERRORE-b176| Sezione Procedura: l'elemento entry/procedure/entryRelationship/observationMedia, se presente, deve avere l'elemento value con l'attributo @representation valorizzato con 'B64'.</assert>
		</rule>
		
		
		<!-- 3.1 OSSERVAZIONE MACROSCOPICA -->
		<!--controllo entry/organizer/component (Osservazione Macroscopica)-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22634-0']]/hl7:entry/hl7:organizer/hl7:component">
			<assert test="count(@typeCode)=1"
			>ERRORE-b177| Sezione Osservazione Macroscopica: L'elemento entry/organizer/component deve avere l'attributo @typeCode valorizzato con 'COMP'</assert>
			<assert test="count(hl7:observation[@moodCode='EVN'])=1"
			>ERRORE-b178| Sezione Osservazione Macroscopica: l'elemento entry/organizer/component deve contenere una 'observation' con @moodCode='EVN'.</assert>
			<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.150'])=1"
			>ERRORE-b179| Sezione Osservazione Macroscopica: l'elemento entry/organizer/component/observation deve contenere l'elemento templateId con l' attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.150'.</assert>
		</rule>
		
		<!-- 4.1 OSSERVAZIONE MICROSCOPICA -->
		<!--controllo entry/organizer/component (Osservazione Microscopica)-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22635-7']]/hl7:entry/hl7:organizer/hl7:component">
			
			<assert test="count(@typeCode)=1"
			>ERRORE-b180| Sezione Osservazione Microscopica: L'elemento entry/organizer/component deve avere l'attributo @typeCode valorizzato con 'COMP'</assert>	
			<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.150'])=1"
			>ERRORE-b181| Sezione Osservazione Microscopica: l'elemento entry/organizer/component/observation deve contenere l'elemento templateId con l' attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.150'.</assert>
		</rule>
		
		
		
		<!-- 5.1 STATO DEL MARGINE -->
		<!-- entry/observation Stato del margine-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='33755-0']]/hl7:entry[hl7:observation]">
			<assert test="count(hl7:observation[@moodCode='EVN'])=1"
			>ERRORE-b182| Sezione Stato del margine: l'elemento entry/observation deve avere valorizzato l'attributo @moodCode='EVN'.</assert>
			<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.196'])=1"
			>ERRORE-b183| Sezione Stato del margine: l'elemento entry/observation/templateId deve avere valorizzato l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.196'.</assert>
			<assert test="count(hl7:observation/hl7:code[@code='33738-6' and @codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b184| Sezione Stato del margine: l'elemento entry/observation/code deve avere valorizzato l'attributo @code valorizzato con 33738-6 e @codeSystem valorizzato con 2.16.840.1.113883.6.1.</assert>
			<!-- entryRelationship/act Commenti-->
			<assert test="count(hl7:observation/hl7:entryRelationship/hl7:act[@classCode='ACT' and @moodCode='EVN'])&lt;=1"
			>ERRORE-b186| Sezione Stato del margine: l'elemento entry/observation può contenere al più una entryRelationship di tipo act con gli attributi @classCode='ACT' e @moodCode='EVN' .</assert>

		</rule>

			<!-- 6.1 entry/observation Analisi supplementari dei campioni-->
			<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22639-9']]/hl7:entry/hl7:organizer/hl7:component">
				<assert test="count(@typeCode)=1"
				>ERRORE-b187| Sezione Analisi supplementari dei campioni: l'elemento entry/organizer/component deve avere valorizzato l'attributo @typeCode.</assert>
				<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.150'])=1"
				>ERRORE-b188| Sezione Analisi supplementari dei campioni: l'elemento entry/organizer/component/observation deve contenere un elemento templateId valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.150'.</assert>
			</rule>
		
		
		
		<!-- 6.1 DIAGNOSI -->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:entry/hl7:organizer[hl7:code[@code='22640-7']]/hl7:component[hl7:observation]">
			<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.150' or @root='2.16.840.1.113883.3.1937.777.63.10.217' or @root='2.16.840.1.113883.3.1937.777.63.10.226'])=1"
			>ERRORE-b189| Sezione Diagnosi: L'elemento entry/organizer (Formula del Tumore) può contenere un component/observation relativa a una dei seguenti template:
			- @root='2.16.840.1.113883.3.1937.777.63.10.150' - AP-Observation;
			- @root='2.16.840.1.113883.3.1937.777.63.10.217' - Formula del tumore TNM;
			- @root='2.16.840.1.113883.3.1937.777.63.10.226' - Linfonodi.</assert>

				<!-- component/observation/code Formula del tumore TNM-->
				<assert test="count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.217']])=0 or 
				count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.217']]/hl7:code[@code='59541-3' and @codeSystem='2.16.840.1.113883.6.1'])=1"
				>ERRORE-b190| Sezione Diagnosi: L'elemento entry/organizer/component/observation (Formula del tumore TNM) DEVE avere l'elemento code valorizzato con gli attributi @code='59541-3' e @codeSystem='2.16.840.1.113883.6.1' .</assert>
				
				<!-- entryRelationship/observation - Fase rilevamento del TNM -->
				<assert test="count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.217']])=0 or 
				count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.217']]/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.218'])&lt;=1"
				>ERRORE-b191| Sezione Diagnosi: L'elemento entry/organizer/component/observation (Formula del tumore TNM) può contenere al più una entryRelationship di tipo observation che riporta la fase di rilevamento del TNM.</assert>
				<assert test="count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.217']]/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.218']])=0 or 
				count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.217']]/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.218']]/hl7:value[@code and @codeSystem])=1"
				>ERRORE-b192| Sezione Diagnosi: L'elemento entry/organizer/component/observation/entryRelationship/observation (Fase rilevamento del TNM) Deve avere l'elemento value con gli attributi @code e @codeSystem valorizzati.</assert>

				<!-- component/observation Linfonodi -->
				<assert test="count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.226']])=0 or 
				count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.226']]/hl7:code[@codeSystem='2.16.840.1.113883.6.1'])=1"
				>ERRORE-b193| Sezione Diagnosi: L'elemento entry/organizer/component/observation (Linfonodi) deve avere l'elemento code con l'attributo @codeSystem valorizzato con '2.16.840.1.113883.6.1'.</assert>
				<let name="num_tsc" value="count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.226']]/hl7:targetSiteCode)"/>
				<assert test="count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.226']])=0 or 
				count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.226']]/hl7:targetSiteCode[@code and @codeSystem])=$num_tsc"
				>ERRORE-b194| Sezione Diagnosi: L'elemento entry/organizer/component/observation/targetSiteCode (Linfonodi) deve contenere gli attributi @code e @codeSystem.</assert>
				<assert test="count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.226']])=0 or 
				count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.226']]/hl7:value[@xsi:type='IVL_PQ'])=1"
				>ERRORE-b195| Sezione Diagnosi: L'elemento entry/organizer/component/observation (Linfonodi) deve avere l'elemento value con @xsi:type='IVL_PQ', che identifica il numero dei linfonodi.</assert>

				<!-- entryRelationship/act Commenti-->
				<assert test="count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.226']]/hl7:entryRelationship/hl7:act[@classCode='ACT' and @moodCode='EVN'])&lt;=1"
				>ERRORE-b196| Sezione Diagnosi: l'elemento entry/organizer/component/observation (Linfonodi) può contenere al più una entryRelationship di tipo act con gli attributi @classCode='ACT' e @moodCode='EVN' .</assert>

		</rule>
		

		<!-- entryRelationship/observation Fase di rilevamento del TNM/Categoria_TNM_RAP -->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:entry/hl7:organizer[hl7:code[@code='22640-7']]/hl7:component/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.217']]/hl7:entryRelationship[hl7:observation]">
			
			<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.218' or @root='2.16.840.1.113883.3.1937.777.63.10.222'])=1"
				>ERRORE-b197| Sezione Diagnosi: L'elemento entry/organizer/component/observation/entryRelationship/observation in Formula del tumore TNM, deve contenere un templateId valorizzato con una delle seguenti root:
				- @root='2.16.840.1.113883.3.1937.777.63.10.218' - Fase di rilevamento del TNM
				- @root='2.16.840.1.113883.3.1937.777.63.10.222'- Categoria_TNM.</assert>
				
			<assert test="count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.222']]/hl7:value)=0 or count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.222']]/hl7:value[@code and @codeSystem])=1"
			>ERRORE-b198| Sezione Diagnosi: L'elemento entry/organizer/component/observation/entryRelationship/observation (Categoria_TNM) può contenere un elemento value con gli attributi @code e @codeSystem valorizzati.</assert>
			<assert test="count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.222']]/hl7:targetSiteCode)=0 or count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.222']]/hl7:targetSiteCode[@code and @codeSystem])=1"
			>ERRORE-b199| Sezione Diagnosi: L'elemento entry/organizer/component/observation/entryRelationship/observation (Categoria_TNM) può contenere un elemento targetSiteCode con gli attributi @code e @codeSystem valorizzati .</assert>

		</rule>
		
		<!-- component/observation/entryRelationship Dimensione Linfonodi/Caratteristiche Linfonodi-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='22637-3']]/hl7:entry/hl7:organizer[hl7:code[@code='22640-7']]/hl7:component/hl7:observation/hl7:entryRelationship[hl7:observation]">
			<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.214' or @root='2.16.840.1.113883.3.1937.777.63.10.216'])=1"
			>ERRORE-b200| Sezione Diagnosi: L'elemento entry/organizer/component/observation/entryRelationship/observation deve contenere un elemento templateId valorizzato con una delle seguenti @root:
			- @root='2.16.840.1.113883.3.1937.777.63.10.214' - Dimensione Linfonodi;
			- @root='2.16.840.1.113883.3.1937.777.63.10.216' - Caratteristica Linfonodi.</assert>
			<assert test="count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.214']])=0 or 
			count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.214']]/hl7:code[@code='85351-5' and @codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b201| Sezione Diagnosi: L'elemento entry/organizer/component/observation/entryRelationship/observation (Dimensione Linfonodi) deve avere un elemento code con attributi @code e @codeSystem valorizzati con '85351-5' e '2.16.840.1.113883.6.1'.</assert>
			<assert test="count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.214']])=0 or 
			count(hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.214']]/hl7:value[@xsi:type='IVL_PQ'])=1"
			>ERRORE-b202| Sezione Diagnosi: L'elemento entry/organizer/component/observation/entryRelationship/observation (Dimensione Linfonodi) deve avere un elemento value di tipo @xsi:type='IVL_PQ'.</assert>
		
		</rule>
	</pattern> 
</schema>