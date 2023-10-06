<?xml version="1.0" encoding="UTF-8"?>
<!-- schematron versione: 1.0 -->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" 
		xmlns:cda="urn:hl7-org:v3"
        xmlns:iso="http://purl.oclc.org/dsdl/schematron"
        xmlns:sch="http://www.ascc.net/xml/schematron"
        queryBinding="xslt2" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<title>Schematron Erogazione Farmaceutica 1.0</title>
	<ns prefix="hl7" uri="urn:hl7-org:v3"/>
	<ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
	
	<pattern id="all">

	<!--________________________________ HEADER _____________________________________________________________-->
	
		<!-- ClinicalDocument -->
		<rule context="hl7:ClinicalDocument">
			<!--realmCode-->	
			<let name="num_rc" value="count(hl7:realmCode)"/>
			<assert test="count(hl7:realmCode)=0 or count(hl7:realmCode/@code)=$num_rc"
			>ERRORE-1| L'elemento <name/>/realmCode, se presente, deve contenere l'attributo @code valorizzato.</assert>

			<!--templateId-->
			<let name="num_tid" value="count(hl7:templateId)"/>
			<assert test="$num_tid >= 1"
			>ERRORE-2| L'elemento <name/> DEVE avere almeno un elemento di tipo 'templateId'</assert>
			<assert test="count(hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.13.1.1']) = 1 and  count(hl7:typeId[@root='2.16.840.1.113883.1.3']/@extension)=1"
			>ERRORE-3| Almeno un elemento 'templateId' DEVE essere valorizzato attraverso l'attributo  @root='2.16.840.1.113883.2.9.10.1.13.1.1' (id del template nazionale)  associato all'attributo @extension che  indica la versione a cui il template fa riferimento.</assert>
			
			<!--code-->	
			<assert test="count(hl7:code[@code='60593-1'][@codeSystem='2.16.840.1.113883.6.1']) = 1"
			>ERRORE-4| L'elemento <name/>/code deve essere valorizzato con l'attributo @code='60593-1' e il @codeSystem='2.16.840.1.113883.6.1'</assert>
			<report test="not(count(hl7:code[@codeSystemName='LOINC'])=1) or not(count(hl7:code[@displayName='EROGAZIONE FARMACEUTICA'])=1 or
			count(hl7:code[@displayName='Erogazione Farmaceutica'])=1)"
			>W001| Si raccomanda di valorizzare gli attributi dell'elemento <name/>/code nel seguente modo: @codeSystemName ='LOINC' e @displayName ='Erogazione Farmaceutica'.--> </report>
			
			<!--effectiveTime-->	
			<assert test="count(hl7:effectiveTime/@value)=1"
			>ERRORE-5| L'elemento <name/>/effectiveTime DEVE contenere l'attributo @value valorizzato.</assert>
			
			<!--confidentialityCode-->
			<assert test="(count(hl7:confidentialityCode[@code='N'][@codeSystem='2.16.840.1.113883.5.25'])= 1) or (count(hl7:confidentialityCode[@code='V'][@codeSystem='2.16.840.1.113883.5.25'])= 1)"
			>ERRORE-6| L'elemento 'confidentialityCode' di <name/> DEVE avere l'attributo @code valorizzato con 'N' o 'V', e il @codeSystem  con '2.16.840.1.113883.5.25'</assert>
			
			<!--languageCode-->	
			<assert test="count(hl7:languageCode/@code)=1"
			>ERRORE-7| L'elemento <name/> DEVE contenere un elemento 'languageCode' con il relativo attributo @code valorizzato.</assert>
			
			<!-- Controllo incrociato tra setId-versionNumber-relatedDocument-->
			<let name="versionNumber" value="hl7:versionNumber/@value"/>
			<assert test="(string(number($versionNumber)) = 'NaN') or
					($versionNumber= '1' and count(hl7:setId)=0) or 
					($versionNumber= 1 and hl7:id/@root = hl7:setId/@root and hl7:id/@extension = hl7:setId/@extension) or
					($versionNumber!= '1' and hl7:id/@root = hl7:setId/@root and hl7:id/@extension != hl7:setId/@extension) or
					(hl7:id/@root != hl7:setId/@root)"
			>ERRORE-8| Se ClinicalDocument.id e ClinicalDocument.setId usano lo stesso dominio di identificazione (@root identico), allora l’attributo @extension del
			ClinicalDocument.id deve essere diverso da quello del ClinicalDocument.setId a meno che ClinicalDocument.versionNumber non sia uguale ad 1; cioè i valori del setId ed id per un documento clinico coincidono solo per la prima versione di un documento.</assert>
			
			<assert test="(string(number($versionNumber)) ='NaN') or
						  ($versionNumber=1)  or 
						  (($versionNumber &gt;1) and count(hl7:relatedDocument)&gt;=1 and count(hl7:relatedDocument)&lt;=2)"
			>ERRORE-9| Se l'attributo <name/>/versionNumber/@value è maggiore di  1, l'elemento <name/>  deve contenere al più due elementi di tipo 'relatedDocument'.</assert>
			
			<!--recordTarget-->
			<assert test="count(hl7:recordTarget)=1"
			>ERRORE-10| L'elemento <name/> DEVE contenere un solo elemento 'recordTarget' </assert>
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
			>ERRORE-11| L'elemento <name/>/recordTarget/patientRole/id  deve avere l'attributo @root valorizzato tramite uno dei seguenti identificatori Nazionanli:
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
			>ERRORE-12| Nel caso di Soggetto assicurato da istituzioni estere, devono essere riportati almeno due elementi di tipo 'id' contenenti:
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
			>ERRORE-13| Nel caso di Stranieri Temporaneamente Presenti, l'elemento <name/>/recordTarget/patientRole/id deve avere l'attributo @root valorizzato tramite:
			 -identificativo STP (2.16.840.1.113883.2.9.4.3.17).
			 -identificativo STP e un identificativo regionale/locale </assert>
				<!--Controllo recordTarget/patientRole/addr-->
			<let name="num_addr" value="count(hl7:recordTarget/hl7:patientRole/hl7:addr)"/>
			<assert test="$num_addr=0 or (count(hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:country)=$num_addr and 
			count(hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:city)=$num_addr and 
			count(hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:streetAddressLine)=$num_addr)"
			>ERRORE-14| L'elemento <name/>/recordTarget/patientRole/addr DEVE riportare i sotto-elementi 'country', 'city' e 'streetAddressLine' </assert>
			<assert test="$num_addr=0 or count(hl7:recordTarget/hl7:patientRole/hl7:addr[@use='HP' or @use='H' or @use='TMP'])=$num_addr"
			>ERRORE-15| Se presente, l'elemento <name/>/recordTarget/patientRole/addr DEVE riportare l'attributo @use, valorizzato in uno dei seguenti valori:
			- 'HP' (primary home);
			- 'H' (home);
			- 'TMP' (temporary address).</assert>			
				<!--Controllo recordTarget/patientRole/patient/name-->
			<let name="patient" value="hl7:recordTarget/hl7:patientRole/hl7:patient"/>
			<assert test="count($patient)=1"
			>ERRORE-16| L'elemento <name/>/recordTaget/patientRole DEVE contenere l'elemento patient</assert>
			<assert test="count($patient)=0 or count($patient/hl7:name)=1"
			>ERRORE-17| L'elemento <name/>/recordTaget/patientRole/patient DEVE contenere l'elemento 'name'</assert>
			<assert test="count($patient/hl7:name)=0 or (count($patient/hl7:name/hl7:given)=1 and count($patient/hl7:name/hl7:family)=1)"
			>ERRORE-18| L'elemento <name/>/recordTaget/patientRole/patient/name DEVE contenere gli elementi 'given' e 'family'</assert>
				<!--Controllo recordTarget/patientRole/patient/administrativeGenderCode-->
			<assert test="count($patient)=0 or count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:administrativeGenderCode[@code and @codeSystem='2.16.840.1.113883.5.1'])=1"
			>ERRORE-19| L'elemento <name/>/recordTarget/patientRole/patient DEVE contenere l'elemento administrativeGenderCode con l'attributo @code valorizzato secondo il sistema di codifica AdministrativeGender - codeSystem='2.16.840.1.113883.5.1'</assert>
			<assert test="count($patient)=0 or count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthTime)=1"
			>ERRORE-20| L'elemento <name/>/recordTarget/patientRole/patient DEVE contenere un elemento 'birthTime'. Nel caso non si conosca il valore, l'elemento può essere valorizzato tramite l'attributo @nullFlavor.</assert>
				<!--Controllo recordTarget/patientRole/patient/birthplace/place/addr-->
			<assert test="count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthplace)=0 or 
			count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthplace/hl7:place/hl7:addr)=1"
			>ERRORE-21| L'elemento <name/>/recordTarget/patientRole/patient/birthplace DEVE contenere un elemento place/addr.</assert>				
			
			<!--dataEnterer-->
			<assert test="count(hl7:dataEnterer/hl7:time)=0 or count(hl7:dataEnterer/hl7:time/@value)=1"
			>ERRORE-22| L'elemento <name/>/dataEnterer/time, se presente DEVE avere l'attributo @value valorizzato.</assert>
			<assert test="count(hl7:dataEnterer)=0 or count(hl7:dataEnterer/hl7:assignedEntity/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=1"
			>ERRORE-23| L'elemento <name/>/dataEnterer/assignedEntity DEVE avere almeno un elemento 'id' valorizzato tramite il Codice Fiscale - @root='2.16.840.1.113883.2.9.4.3.2'.</assert>
			
			<!--custodian-->
			<let name="num_addr_cust" value="count(hl7:custodian/hl7:assignedCustodian/hl7:representedCustodianOrganization/hl7:addr)"/>
			<let name="addr_cust" value="hl7:custodian/hl7:assignedCustodian/hl7:representedCustodianOrganization/hl7:addr"/>
			<assert test="$num_addr_cust=0 or (count($addr_cust/hl7:country)=$num_addr_cust and count($addr_cust/hl7:city)=$num_addr_cust and count($addr_cust/hl7:streetAddressLine)=$num_addr_cust)"
			>ERRORE-24| L'elemento <name/>/custodian/assignedCustodian/representedCustodianOrganization/addr DEVE riportare i sotto-elementi 'country', 'city' e 'streetAddressLine'.</assert>

			<!--legalAuthenticator -->
			<assert test = "count(hl7:legalAuthenticator)= 0 or count(hl7:legalAuthenticator/hl7:signatureCode[@code='S'])= 1" 
			>ERRORE-25| L'elemento <name/>/legalAuthenticator/signatureCode deve contenere l'attributo @code valorizzato con il codice "S".</assert>
			<assert test = "count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:assignedPerson)= 0 or count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])= 1" 
			>ERRORE-26| L'elemento <name/>/legalAuthenticator/id del firmatario deve essere valorizzato tramite il CF - @root='2.16.840.1.113883.2.9.4.3.2'.</assert>
			<assert test="count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:assignedPerson)= 0 or count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:assignedPerson/hl7:name)=1"
			>ERRORE-27| L'elemento <name/>/legalAuthenticator/assignedEntity/assignedPerson, se presente, deve contenere un elemento name.</assert>
			
						
			<!--relatedDocument-->
			<assert test="(count(hl7:relatedDocument)&lt;2 or (count(hl7:relatedDocument[@typeCode='XFRM'])=1 and (count(hl7:relatedDocument[@typeCode='RPLC'])=1 or count(hl7:relatedDocument[@typeCode='APND'])=1)))"
			>ERRORE-28| Un documento CDA2 conforme può avere o un relatedDocument con @typeCode='APND' | 'RPLC' | 'XFRM'; oppure una combinazione di due relatedDocument con la seguente composizione:
			- @typeCode='XFRM' e @typeCode='RPLC'; 
			- @typeCode='XFRM' e @typeCode='APND'.</assert>
			
		</rule>
		
		<!--author -->	
		<rule context="hl7:ClinicalDocument/hl7:author">
			<assert test="count(hl7:time/@value)= 1 "
			>ERRORE-29| L'elemento ClinicalDocument/<name/> DEVE contenere un elemento time valorizzato tramite l'attributo @value.</assert>
			<assert test="count(hl7:assignedAuthor/hl7:id[@root= '2.16.840.1.113883.2.9.4.3.2'])= 1 "
			>ERRORE-30| L'elemento ClinicalDocument/<name/>/assignedAuthor DEVE contenere almeno un elemento id  valorizzato tramite il Codice Fiscale - @root='2.16.840.1.113883.2.9.4.3.2'.</assert>
			<assert test="count(hl7:assignedAuthor/hl7:code)=0 or count(hl7:assignedAuthor/hl7:code[@codeSystem='2.16.840.1.113883.2.9.5.1.111'])= 1 "
			>ERRORE-31| L'elemento ClinicalDocument/<name/>/assignedAuthor, se contiene l'elemento code, deve essere valorizzato secondo il @codeSystem='2.16.840.1.113883.2.9.5.1.111' - RoleCodeIT.</assert>
			<assert test="count(hl7:assignedAuthor/hl7:assignedPerson/hl7:name)=1"
			>ERRORE-32| L'elemento ClinicalDocument/<name/>/assignedAuthor deve avere un elemento assignedPerson contenente il nome dell'autore.</assert>
		
		</rule>
		<!--authenticator -->
		<rule context="hl7:ClinicalDocument/hl7:authenticator">
			<assert test ="count(hl7:signatureCode[@code='S'])=1"
			>ERRORE-33| L'elemento ClinicalDocument/<name/>/signatureCode deve contenere l'attributo @code valorizzato con il codice "S".</assert>
			<assert test = "count(hl7:assignedEntity/hl7:assignedPerson)=0 or count(hl7:assignedEntity/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])= 1"
			>ERRORE-34| L'elemento ClinicalDocument/<name/>/assignedEntity/id deve essere valorizzato tramite il CF - @root='2.16.840.1.113883.2.9.4.3.2'.</assert>
			<assert test="count(hl7:assignedEntity/hl7:assignedPerson)=0 or count(hl7:assignedEntity/hl7:assignedPerson/hl7:name)=1"
			>ERRORE-35| L'elemento ClinicalDocument/<name/>/assignedEntity/assignedPerson, se presente, deve contenere un elemento name.</assert>
		</rule>
		
		<!--participant-->
		<rule context="hl7:ClinicalDocument/hl7:participant">
			<assert test="count(hl7:associatedEntity/hl7:scopingOrganization)=1"
			>ERRORE-36| L'elemento ClinicalDocument/<name/>/associatedEntity deve contenere almeno un elemento 'scopingOrganization'.</assert>
		</rule>
		
		<!--inFulfillmentOf-->
		<rule context="hl7:ClinicalDocument/hl7:inFulfillmentOf">
			<assert test="count(hl7:order/hl7:id)=1"
			>ERRORE-37| L'elemento ClinicalDocument/<name/>/order deve contenere al più un elemento 'id'.</assert>
			<assert test="count(hl7:order/hl7:priorityCode)=0 or count(hl7:order/hl7:priorityCode[@code and @codeSystem='2.16.840.1.113883.5.7'])=1"
			>ERRORE-38| L'elemento ClinicalDocument/<name/>/order/priorityCode, se presente, deve avere l'attributo @code valorizzato secondo il sistema di codifica HL7 ActPriority - @codeSystem='2.16.840.1.113883.5.7'.</assert>
		</rule>

		
		<!--________________________________CONTROLLI GENERICI_____________________________________________________________-->
		
		<!-- Controllo telecom -->
		<rule context="//hl7:telecom">
			<assert test="(count(@use)=1)"
			>ERRORE-39| L’elemento 'telecom' DEVE contenere l'attributo @use.</assert>
		</rule>
		<rule context="//*[contains(local-name(), 'Organization')][hl7:telecom]">
			<assert test="not(hl7:telecom/@use='H' or hl7:telecom/@use='HP' or hl7:telecom/@use='HV')"
			>ERRORE-40| L'elemento telecom di un'organizzazione non può essere di tipo Home, ovvero l'attributo @use deve essere diverso da: H | HP | HV.</assert>
		</rule>
		
		<!-- Controllo formato: -->
		<rule context="//hl7:id[@root='2.16.840.1.113883.2.9.4.3.2']">
			<let name="CF" value="@extension"/>
			<assert test="matches(@extension, '[A-Z0-9]{16}') and string-length($CF)=16"
			>ERRORE-41| Il codice fiscale '<value-of select="$CF"/>' del cittadino e/o operatore DEVE avere 16 cifre [A-Z0-9]{16}</assert>
		</rule>
		
		<!-- Controllo sotto elementi name-->
		<rule context="//hl7:name[contains(local-name(..), 'Organization') or (parent::hl7:location)]">
			<assert test="count(hl7:delimiter)=0 and count(hl7:prefix)=0 and count(hl7:suffix)=0"
			>ERRORE-42| L’elemento 'name' di un'organizzazione non deve contenere i sotto elementi 'delimiter', 'prefix', 'suffix'.</assert>
    	</rule>
		<rule context="//*[contains(local-name(), 'Person')]/hl7:name">
			<let name="errorPath">
				<xsl:for-each select="ancestor::*[not(self::hl7:ClinicalDocument)]">
					<xsl:value-of select="concat('/', name())"/>
				</xsl:for-each>
			</let>
			<assert test="count(hl7:delimiter)=0 and count(hl7:given)=1 and count(hl7:family)=1"
			>ERRORE-43| L’elemento 'name' di un soggetto deve contenere i tag 'given' e 'family' e non il tag 'delimiter'.
			Path: ClinicalDocument<value-of select="$errorPath"/>.</assert>
		</rule>
		
		<!-- Controllo effectiveTime: -->
		<rule context="//hl7:effectiveTime[hl7:low/@value]">
			<let name="effective_time_low" value="string(hl7:low/@value)"/>
			<let name="effective_time_high" value="string(hl7:high/@value)"/>
			<assert test="count(hl7:high/@value)=0 or ($effective_time_high >= $effective_time_low)"
			>ERRORE-44| Il valore dell'elemento effectiveTime/high : '<value-of select="$effective_time_high"/>' deve essere maggiore o uguale dell'effectiveTime/low : '<value-of select="$effective_time_low"/>'.</assert>
		</rule>
		<!-- Controllo address: -->
		<rule context="//*[contains(local-name(), 'Organization')]/hl7:addr[@use='H' or @use='HP' or @use='HV']">
			<assert test="false()"
			>ERRORE-45| L'indirizzo di un'organizzazione non può essere di tipo Home, ovvero l'attributo @use deve essere diverso da: H | HP | HV.
			</assert>
		</rule>
	<!--da verificare-->
		<rule context="//hl7:addr[not(parent::hl7:place)and not(parent::hl7:scopingOrganization)]">
			<assert test="count(@use)!=0"
			>ERRORE-46| L'elemento addr deve avere l'attributo @use valorizzato.</assert>
		</rule>
	
		<rule context="//hl7:code">
			<assert test="(count(@code)!=0 and count(@codeSystem)!=0) or (count(@nullFlavor)!=0)"
			>ERRORE-47| L'elemento 'code' deve avere gli attributi @code e @codeSystem valorizzati, altrimenti deve avere l'attributo @nullFlavor.</assert>
		</rule>
		
		<rule context="//hl7:id">
			<assert test="(count(@root)!=0 and count(@extension)!=0)"
			>ERRORE-48| L'elemento 'id' deve contenere gli attributi @root ed @extension valorizzati.</assert>
		</rule>
		
		<rule context="//hl7:entryRelationship[not(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.297'])]">
			<assert test="@typeCode='COMP'"
			>ERRORE-49| L'elemento 'entryRelationship' deve contenere l'attributi @typeCode='COMP'.</assert>
		</rule>
		
		<!--Controllo sugli attributi di observation-->
		<rule context="//hl7:observation">
			<let name="moodCd" value="@moodCode"/>
			<assert test="count(@classCode)=0 or @classCode='OBS'"
			>ERRORE-50| L'attributo "@classCode" dell'elemento "observation" deve essere valorizzato con 'OBS'</assert>
		</rule>
	
	
	<!-- _____________________________________________ BODY______________________________________________________-->


		<!-- Controllo Sezione obbligatoria-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody">
			<assert test="count(hl7:component/hl7:section)=1"
			>ERRORE-b0| Il body strutturato deve contenere solamente una sezione 'Erogazione Farmaceutica'.</assert>
			<assert test="count(hl7:component/hl7:section/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.294'])=1"
			>ERRORE-b1| La sezione Deve contenere l'elemento templateId e Deve essere presente l'attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.294'.</assert>
			<assert test="count(hl7:component/hl7:section/hl7:code[@code='60590-7' and @codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b2| La sezione Deve contenere l'elemento code e Deve avere l'attributo @code  valorizzato con '60590-7' e l'attributo @codeSystem deve essere valorizzato con '2.16.840.1.113883.6.1' .</assert>
			<assert test="count(hl7:component/hl7:section/hl7:text)=1"
			>ERRORE-b3| La sezione DEVE contenere l'elemento text obbligatorio.</assert>
			<assert test="count(hl7:component/hl7:section/hl7:entry)>=1"
			>ERRORE-b4| La sezione DEVE contenere almeno un elemento entry obbligatorio.</assert>
		</rule>

		<!-- Controllo entry-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section/hl7:entry">
			<assert test="count(hl7:supply[@moodCode='EVN'])=1"
			>ERRORE-b5| L'elemento <name/>/supply deve contenere l'attributo @moodCode valorizzato con 'EVN'.</assert>
			<assert test="count(hl7:supply/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.295'])=1"
			>ERRORE-b6| L'elemento <name/>/supply deve contenere l'elemento templateId con l'attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.295'.</assert>
			<assert test="count(hl7:supply/hl7:effectiveTime)=1"
			>ERRORE-b7| L'elemento <name/>/supply deve contenere l'elemento effectiveTime .</assert>
			<assert test="count(hl7:supply/hl7:quantity)=1"
			>ERRORE-b8| L'elemento <name/>/supply deve contenere l'elemento quantity.</assert>
			<assert test="count(hl7:supply/hl7:product/hl7:manufacturedProduct)=1"
			>ERRORE-b9| L'elemento <name/>/supply/product deve contenere l'elemento manufacturedProduct.</assert>
			<assert test="count(hl7:supply/hl7:product/hl7:manufacturedProduct/hl7:manufacturedLabeledDrug)=0 or count(hl7:supply/hl7:product/hl7:manufacturedProduct/hl7:manufacturedLabeledDrug/hl7:name)=1"
			>ERRORE-b10| L'elemento <name/>/supply/product/manufacturedProduct/manufacturedLabeledDrug, se presente, deve contenere l'elemento name.</assert>
			<assert test="count(hl7:supply/hl7:product/hl7:manufacturedProduct/hl7:manufacturedMaterial)=0 or count(hl7:supply/hl7:product/hl7:manufacturedProduct/hl7:manufacturedMaterial/hl7:code[@codeSystem='2.16.840.1.113883.2.9.6.1.5'])=1"
			>ERRORE-b11| L'elemento <name/>/supply/product/manufacturedProduct/manufacturedMaterial, se presente, deve contenere l'elemento code che contiene la codifica AIC che rappresenterà il prodotto erogato (attributo @codeSystem='2.16.840.1.113883.2.9.6.1.5').</assert>
		
        <!-- entryRelationship Act_Erogazione -->
			<assert test="count(hl7:supply/hl7:entryRelationship[hl7:act])&lt;=1"
			>ERRORE-b12| L'elemento supply/entryRelationship di tipo act può essere presente al più una volta.</assert>
			<assert test="count(hl7:supply/hl7:entryRelationship[hl7:act])=0 or count(hl7:supply/hl7:entryRelationship/hl7:act[@classCode='ACT' and @moodCode='EVN'])=1"
			>ERRORE-b13| L'elemento supply/entryRelationship di tipo act, se presente, deve contenere gli attributi @classCode e @moodCode valorizzati rispettivamnente con 'ACT' e 'EVN'.</assert>
			<assert test="count(hl7:supply/hl7:entryRelationship[hl7:act])=0 or count(hl7:supply/hl7:entryRelationship/hl7:act/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.296'])=1"
			>ERRORE-b14| L'elemento supply/entryRelationship di tipo act, se presente, deve contenere l'elemento templateId con l'attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.296'.</assert>
			<assert test="count(hl7:supply/hl7:entryRelationship[hl7:act])=0 or count(hl7:supply/hl7:entryRelationship/hl7:act/hl7:entryRelationship[@typeCode='RSON']/hl7:observation)=1"
		    >ERRORE-b15| L'elemento supply/entryRelationship di tipo act, se presente, deve contenere una ed una sola entryRelationship con @typeCode='RSON' e di tipo observation.</assert>
			<assert test="count(hl7:supply/hl7:entryRelationship[hl7:act])=0 or count(hl7:supply/hl7:entryRelationship/hl7:act/hl7:entryRelationship/hl7:observation[@moodCode='EVN'])=1"
		    >ERRORE-b16| L'elemento supply/entryRelationship/act/entryRelationship/observation deve avere l'attributo @moodCode valorizzato con 'EVN'.</assert>
			<assert test="count(hl7:supply/hl7:entryRelationship[hl7:act])=0 or count(hl7:supply/hl7:entryRelationship/hl7:act/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.297'])=1"
		    >ERRORE-b17| L'elemento supply/entryRelationship/act/entryRelationship/observation deve contenere l'elemento templateId con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.297'.</assert>
			<assert test="count(hl7:supply/hl7:entryRelationship[hl7:act])=0 or count(hl7:supply/hl7:entryRelationship/hl7:act/hl7:entryRelationship/hl7:observation/hl7:code[@codeSystem='2.16.840.1.113883.2.9.6.1.53'])=1"
		    >ERRORE-b18| L'elemento supply/entryRelationship/act/entryRelationship/observation deve contenere l'elemento code che contiene il valore indicante la motivazione di una variazione del farmaco erogato rispetto al codice AIC prescritto (attributo @codeSystem='2.16.840.1.113883.2.9.6.1.53').</assert>
			<assert test="count(hl7:supply/hl7:entryRelationship[hl7:act])=0 or count(hl7:supply/hl7:entryRelationship/hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship/hl7:substanceAdministration[@moodCode='RQO'])&lt;=1"
		    >ERRORE-b19| L'elemento supply/entryRelationship/act/entryRelationship/observation può contenere al più una entryRelationship di tipo substanceAdministration con l'attributo @moodCode='RQO'.</assert>
			<assert test="count(hl7:supply/hl7:entryRelationship/hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship/hl7:substanceAdministration)=0 
			or count(hl7:supply/hl7:entryRelationship/hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship/hl7:substanceAdministration/hl7:consumable)=1"
		    >ERRORE-b20| L'elemento supply/entryRelationship/act/entryRelationship/observation/entryRelationship/substanceAdministration, se presente, deve contenere l'elemento consumable.</assert>
		    <assert test="count(hl7:supply/hl7:entryRelationship/hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship/hl7:substanceAdministration)=0 
			or count(hl7:supply/hl7:entryRelationship/hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship/hl7:substanceAdministration/hl7:consumable/hl7:manufacturedProduct/hl7:manufacturedMaterial/hl7:code)=1"
		    >ERRORE-b21| L'elemento supply/entryRelationship/act/entryRelationship/observation/entryRelationship/substanceAdministration, se presente, deve contenere l'elemento consumable/manufacturedProduct/manufacturedMaterial/code in cui è possibile inserire il codice AIC e ATC che valorizza il farmaco prescritto.</assert>
		
		<!-- entryRelationship Obs_RegimeErogazione -->
		    <assert test="count(hl7:supply/hl7:entryRelationship[hl7:observation])&lt;=1"
			>ERRORE-b22| L'elemento supply/entryRelationship di tipo observation può essere presente al più una volta.</assert>
			<assert test="count(hl7:supply/hl7:entryRelationship[hl7:observation])=0 or count(hl7:supply/hl7:entryRelationship/hl7:observation[@moodCode='EVN'])=1"
			>ERRORE-b23| L'elemento supply/entryRelationship di tipo observation, se presente, deve contenere l'attributo @moodCode valorizzato con 'EVN'.</assert>
			<assert test="count(hl7:supply/hl7:entryRelationship[hl7:observation])=0 or count(hl7:supply/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.326'])=1"
			>ERRORE-b24| L'elemento supply/entryRelationship di tipo observation, se presente, deve contenere l'elemento templateId con l'attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.326'.</assert>
			<!--assert test="count(hl7:supply/hl7:entryRelationship[hl7:observation])=0 or count(hl7:supply/hl7:entryRelationship/hl7:observation/hl7:code)=1"
			>ERRORE-b25| L'elemento supply/entryRelationship di tipo observation, se presente, deve contenere l'elemento code che caratterizza il regime di erogazione: Diretta (Dd); Distribuzione per conto (Dpc); Convenzionata.</assert-->
		</rule>
		
	</pattern> 
</schema>