<?xml version="1.0" encoding="UTF-8"?>
<!-- schematron versione: 1.1 -->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" 
		xmlns:cda="urn:hl7-org:v3"
        xmlns:iso="http://purl.oclc.org/dsdl/schematron"
        xmlns:sch="http://www.ascc.net/xml/schematron"
        queryBinding="xslt2" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<title>Schematron Erogazione Farmaceutica No SSN 1.0</title>
	<ns prefix="hl7" uri="urn:hl7-org:v3"/>
	<ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
	
	<pattern id="all">

	<!--________________________________ HEADER _____________________________________________________________-->
	
		<!-- ClinicalDocument -->
		<rule context="hl7:ClinicalDocument">
			<!--realmCode-->		
			<assert test="count(hl7:realmCode)>=1 "
			>ERRORE-1| L'elemento 'realmCode' DEVE essere presente.</assert>
			
			<!--templateId-->
			<let name="num_tid" value="count(hl7:templateId)"/>
			<assert test="$num_tid >= 1"
			>ERRORE-2| L'elemento <name/> DEVE avere almeno un elemento di tipo 'templateId'.</assert>
			
			<assert test="count(hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.13.2.1']) = 1 and  count(hl7:typeId[@root='2.16.840.1.113883.1.3']/@extension)=1"
			>ERRORE-3| Almeno un elemento 'templateId' DEVE essere valorizzato attraverso l'attributo @root='2.16.840.1.113883.2.9.10.1.13.2.1' (id del template nazionale) associato all'attributo @extension che indica la versione a cui il template fa riferimento.</assert>
			
			<!--code-->	
			<assert test="count(hl7:code[@code='60593-1'][@codeSystem='2.16.840.1.113883.6.1']) = 1"
			>ERRORE-4| L'elemento <name/>/code deve essere valorizzato con l'attributo @code='60593-1' e il @codeSystem='2.16.840.1.113883.6.1'.</assert>
			
			<report test="not(count(hl7:code[@codeSystemName='LOINC'])=1) or not(count(hl7:code[@displayName='EROGAZIONE FARMACEUTICA'])=1 or
			count(hl7:code[@displayName='Erogazione Farmaceutica'])=1)"
			>W001| Si raccomanda di valorizzare gli attributi dell'elemento <name/>/code nel seguente modo: @codeSystemName ='LOINC' e @displayName ='Erogazione Farmaceutica'. </report>
			
			<!--effectiveTime-->	
			<assert test="count(hl7:effectiveTime/@value)=1"
			>ERRORE-5| L'elemento <name/>/effectiveTime DEVE contenere l'attributo @value valorizzato.</assert>
			
			<!--confidentialityCode-->
			<assert test="(count(hl7:confidentialityCode[@code='N'][@codeSystem='2.16.840.1.113883.5.25'])= 1) or 
			(count(hl7:confidentialityCode[@code='V'][@codeSystem='2.16.840.1.113883.5.25'])= 1) or (count(hl7:confidentialityCode[@code='R'][@codeSystem='2.16.840.1.113883.5.25'])= 1)"
			>ERRORE-6| L'elemento <name/>/confidentialityCode DEVE avere l'attributo @code valorizzato con 'N' o 'R' o 'V', e il @codeSystem='2.16.840.1.113883.5.25'.</assert>
			
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
			>ERRORE-9| Se l'attributo <name/>/versionNumber/@value è maggiore di 1, l'elemento <name/> deve contenere al più due elementi di tipo 'relatedDocument'.</assert>
			
			<!--recordTarget-->
			<assert test="count(hl7:recordTarget)=1"
			>ERRORE-10| L'elemento <name/> DEVE contenere un solo elemento 'recordTarget'. </assert>
			
			<!--Controllo recordTarget/patientRole/id-->
			<assert test="count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.7'])=1 or 
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.3'])=1 or 
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.18'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.17'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.15'])=1 or count(hl7:recordTarget/hl7:patientRole/hl7:id[matches(@root,'^2\.16\.840\.1\.113883\.2\.9\.2\.(10|20|30|41|42|50|60|70|80|90|100|110|120|130|140|150|160|170|180|190|200)\.4\.1\.1$')])=1 or count(hl7:recordTarget/hl7:patientRole/hl7:id[matches(@root,'^2\.16\.840\.1\.113883\.2\.9\.2\.(10|20|30|41|42|50|60|70|80|90|100|110|120|130|140|150|160|170|180|190|200)\.4\.1$')])=1"
			>ERRORE-11| L'elemento <name/>/recordTarget/patientRole/id  deve avere l'attributo @root valorizzato tramite uno dei seguenti identificatori Nazionanli:
			- CF 2.16.840.1.113883.2.9.4.3.2
			- TEAM 2.16.840.1.113883.2.9.4.3.7 e 2.16.840.1.113883.2.9.4.3.3
			- ENI 2.16.840.1.113883.2.9.4.3.18
			- STP 2.16.840.1.113883.2.9.4.3.17 oppure un identificativo regionale 
			- ANA 2.16.840.1.113883.2.9.4.3.15
			Oppure tramite gli identificatori regionali generati per rappresentare l'id del paziente.
			</assert>
			
			
			<assert test="
			( count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.7']) = 0 or
			  count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.3']) = 1 
			) and (count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.3']) = 0 or
			  count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.7']) = 1)"			
			>ERRORE-12| Nel caso di Soggetto assicurato da istituzioni estere, devono essere riportati almeno due elementi di tipo 'id' contenenti:
			- 2.16.840.1.113883.2.9.4.3.7: Il numero di identificazione della Tessera TEAM (Tessera Europea di Assicurazione Malattia);
			- 2.16.840.1.113883.2.9.4.3.3: Il numero di identificazione Personale TEAM.
			</assert>		
			
			<assert test="(count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=0 and 
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.7'])=0 and 
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.3'])=0 and 
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.18'])=0 and
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.15'])=0) or not(count(hl7:recordTarget/hl7:patientRole/hl7:id[matches(@root,'^2\.16\.840\.1\.113883\.2\.9\.2\.(10|20|30|41|42|50|60|70|80|90|100|110|120|130|140|150|160|170|180|190|200)\.4\.1\.1$')])=1)"			
			>ERRORE-13| Nel caso di Stranieri Temporaneamente Presenti, l'elemento <name/>/recordTarget/patientRole/id deve avere l'attributo @root valorizzato tramite:
			 - identificativo STP (2.16.840.1.113883.2.9.4.3.17).
			 - identificativo STP e un identificativo regionale/locale </assert>
			 
			<!--Controllo recordTarget/patientRole/addr-->
			<let name="num_addr" value="count(hl7:recordTarget/hl7:patientRole/hl7:addr)"/>
			<assert test="$num_addr=0 or (count(hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:country)=$num_addr and 
			count(hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:city)=$num_addr and 
			count(hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:streetAddressLine)=$num_addr)"
			>ERRORE-14| L'elemento <name/>/recordTarget/patientRole/addr DEVE riportare i sotto-elementi 'country', 'city' e 'streetAddressLine'. </assert>
			
			<assert test="$num_addr=0 or count(hl7:recordTarget/hl7:patientRole/hl7:addr[@use='HP' or @use='H' or @use='TMP'])=$num_addr"
			>ERRORE-15| Se presente, l'elemento <name/>/recordTarget/patientRole/addr DEVE riportare l'attributo @use, valorizzato in uno dei seguenti valori:
			- 'HP' (primary home);
			- 'H' (home);
			- 'TMP' (temporary address).</assert>		
			
			<!--Controllo recordTarget/patientRole/patient/name-->
			<let name="patient" value="hl7:recordTarget/hl7:patientRole/hl7:patient"/>
			<assert test="count($patient)=1"
			>ERRORE-16| L'elemento <name/>/recordTaget/patientRole DEVE contenere l'elemento 'patient'.</assert>
			
			<assert test="count($patient)=0 or count($patient/hl7:name)=1"
			>ERRORE-17| L'elemento <name/>/recordTaget/patientRole/patient DEVE contenere l'elemento 'name'.</assert>
			
			<assert test="count($patient/hl7:name)=0 or (count($patient/hl7:name/hl7:given)=1 and count($patient/hl7:name/hl7:family)=1)"
			>ERRORE-18| L'elemento <name/>/recordTaget/patientRole/patient/name DEVE contenere gli elementi 'given' e 'family'.</assert>
			
			<!--Controllo recordTarget/patientRole/patient/administrativeGenderCode-->
			<assert test="count($patient)=0 or count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:administrativeGenderCode[@code and @codeSystem='2.16.840.1.113883.5.1'])=1"
			>ERRORE-19| L'elemento <name/>/recordTarget/patientRole/patient DEVE contenere l'elemento 'administrativeGenderCode' con l'attributo @code valorizzato secondo il sistema di codifica AdministrativeGender - codeSystem='2.16.840.1.113883.5.1'.</assert>
			
			<assert test="count($patient)=0 or count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthTime)=1"
			>ERRORE-20| L'elemento <name/>/recordTarget/patientRole/patient DEVE contenere un elemento 'birthTime'. Nel caso non ne si conosca il valore, l'elemento può essere valorizzato tramite l'attributo @nullFlavor="UNK".</assert>
			
			<!--Controllo recordTarget/patientRole/patient/birthplace/place/addr-->
			<assert test="count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthplace)=0 or 
			count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthplace/hl7:place/hl7:addr/hl7:country)=1"
			>ERRORE-21| L'elemento <name/>/recordTarget/patientRole/patient/birthplace DEVE contenere un elemento place/addr/country che identifica il codice ISTAT dello stato di nascita del paziente.</assert>				
			
			<!--dataEnterer-->
			<assert test="count(hl7:dataEnterer)=0 or count(hl7:dataEnterer/hl7:time)=0 or count(hl7:dataEnterer/hl7:time/@value)=1"
			>ERRORE-22| L'elemento <name/>/dataEnterer/time, se presente DEVE avere l'attributo @value valorizzato.</assert>
			
			<!--Controllo dataEnterer/assignedEntity/id-->
			
			<assert test = "count(hl7:dataEnterer)=0 or (count(hl7:dataEnterer/hl7:assignedEntity/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=0 and (count(hl7:dataEnterer/hl7:assignedEntity/hl7:id[matches(@root, '^2\.16\.840\.1\.113883\.2\.9\.2\.(10|20|30|41|42|50|60|70|80|90|100|110|120|130|140|150|160|170|180|190|200)\.4\.2$')])=1)) or
			count(hl7:dataEnterer/hl7:assignedEntity/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=1 and (
			count(hl7:dataEnterer/hl7:assignedEntity/hl7:id[matches(@root, '^2\.16\.840\.1\.113883\.2\.9\.2\.(10|20|30|41|42|50|60|70|80|90|100|110|120|130|140|150|160|170|180|190|200)\.4\.2$')])=1) or 
			count(hl7:dataEnterer/hl7:assignedEntity/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=1 and (count(hl7:dataEnterer/hl7:assignedEntity/hl7:id[matches(@root,'^2\.16\.840\.1\.113883\.2\.9\.2\.(10|20|30|41|42|50|60|70|80|90|100|110|120|130|140|150|160|170|180|190|200)\.4\.2$')])=0)"
			>ERRORE-23| L'elemento <name/>/dataEnterer/assignedEntity DEVE avere almeno un elemento 'id'. Tale elemento può essere valorizzato tramite il Codice Fiscale, ossia con @root='2.16.840.1.113883.2.9.4.3.2', oppure tramite un identificativo regionale con l'attributo @root strutturato nel seguente modo: “2.16.840.1.113883.2.9.2.” + [REGIONE] + “.4.2”.</assert>
			

			<!--legalAuthenticator -->
			<assert test = "count(hl7:legalAuthenticator)= 0 or count(hl7:legalAuthenticator/hl7:signatureCode[@code='S'])= 1" 
			>ERRORE-24| L'elemento <name/>/legalAuthenticator/signatureCode deve contenere l'attributo @code valorizzato con il codice "S".</assert>
			
			<!--Controllo legalAuthenticator/assignedEntity/id-->
			<assert test = "count(hl7:legalAuthenticator)= 0 or (count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=0 and (count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:id[matches(@root,'^2\.16\.840\.1\.113883\.2\.9\.2\.(10|20|30|41|42|50|60|70|80|90|100|110|120|130|140|150|160|170|180|190|200)\.4\.2$')])=1)) or
			count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=1 and (count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:id[matches(@root,'^2\.16\.840\.1\.113883\.2\.9\.2\.(10|20|30|41|42|50|60|70|80|90|100|110|120|130|140|150|160|170|180|190|200)\.4\.2$')])=1) or 
			count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=1 and (count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:id[matches(@root,'^2\.16\.840\.1\.113883\.2\.9\.2\.(10|20|30|41|42|50|60|70|80|90|100|110|120|130|140|150|160|170|180|190|200)\.4\.2$')])=0)"
			>ERRORE-25| L'elemento <name/>/legalAuthenticator/assignedEntity DEVE avere almeno un elemento 'id'. Tale elemento può essere valorizzato tramite il Codice Fiscale, ossia con @root='2.16.840.1.113883.2.9.4.3.2', oppure tramite un identificativo regionale con l'attributo @root strutturato nel seguente modo: “2.16.840.1.113883.2.9.2.” + [REGIONE] + “.4.2”.</assert>
			
			<assert test="count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:assignedPerson)= 0 or count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:assignedPerson/hl7:name)=1"
			>ERRORE-26| L'elemento <name/>/legalAuthenticator/assignedEntity/assignedPerson, se presente, deve contenere un elemento 'name'.</assert>
						
			<!--relatedDocument-->
			<assert test="(count(hl7:relatedDocument)&lt;2 or (count(hl7:relatedDocument[@typeCode='XFRM'])=1 and (count(hl7:relatedDocument[@typeCode='RPLC'])=1 or count(hl7:relatedDocument[@typeCode='APND'])=1)))"
			>ERRORE-27| Un documento CDA2 conforme può avere o un 'relatedDocument' con @typeCode='APND' | 'RPLC' | 'XFRM'; oppure una combinazione di due 'relatedDocument' con la seguente composizione:
			- @typeCode='XFRM' e @typeCode='RPLC'; 
			- @typeCode='XFRM' e @typeCode='APND'.</assert>
			
		</rule>
		
		<!--author -->	
		<rule context="hl7:ClinicalDocument/hl7:author">
			<assert test="count(hl7:time/@value)=1 or count(hl7:time/@nullFlavor)= 1 "
			>ERRORE-28| L'elemento ClinicalDocument/<name/> DEVE contenere un elemento 'time' valorizzato tramite l'attributo @value, se non si conosce il valore è possibile utilizzare il @nullFlavor.</assert>
			
			<assert test="count(hl7:assignedAuthor/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])= 1 "
			>ERRORE-29| L'elemento ClinicalDocument/<name/>/assignedAuthor DEVE contenere almeno un elemento 'id'  valorizzato tramite il Codice Fiscale - @root='2.16.840.1.113883.2.9.4.3.2'.</assert>
			
			<assert test="count(hl7:assignedAuthor/hl7:code)=0 or count(hl7:assignedAuthor/hl7:code[@codeSystem='2.16.840.1.113883.2.9.5.1.111'])= 1 "
			>ERRORE-30| L'elemento ClinicalDocument/<name/>/assignedAuthor, se contiene l'elemento 'code', deve essere valorizzato secondo il @codeSystem='2.16.840.1.113883.2.9.5.1.111' - RoleCodeIT.</assert>
			
			<assert test="count(hl7:assignedAuthor/hl7:assignedPerson/hl7:name)=1"
			>ERRORE-31| L'elemento ClinicalDocument/<name/>/assignedAuthor deve avere un elemento 'assignedPerson' contenente il nome dell'autore.</assert>
		</rule>
		
		<!--authenticator -->
		<rule context="hl7:ClinicalDocument/hl7:authenticator">
			<assert test ="count(hl7:signatureCode[@code='S'])=1"
			>ERRORE-32| L'elemento ClinicalDocument/<name/>/signatureCode deve contenere l'attributo @code valorizzato con il codice "S".</assert>
			
			<assert test = "(count(hl7:assignedEntity/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=0 and (count(hl7:assignedEntity/hl7:id[matches(@root,'^2\.16\.840\.1\.113883\.2\.9\.2\.(10|20|30|41|42|50|60|70|80|90|100|110|120|130|140|150|160|170|180|190|200)\.4\.2$')])=1)) or
			count(hl7:assignedEntity/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=1 and (count(hl7:assignedEntity/hl7:id[matches(@root,'^2\.16\.840\.1\.113883\.2\.9\.2\.(10|20|30|41|42|50|60|70|80|90|100|110|120|130|140|150|160|170|180|190|200)\.4\.2$')])=1) or 
			count(hl7:assignedEntity/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=1 and (count(hl7:assignedEntity/hl7:id[matches(@root,'^2\.16\.840\.1\.113883\.2\.9\.2\.(10|20|30|41|42|50|60|70|80|90|100|110|120|130|140|150|160|170|180|190|200)\.4\.2$')])=0)"
			>ERRORE-33| L'elemento ClinicalDocument/<name/>/assignedEntity DEVE avere almeno un elemento 'id'. Tale elemento può essere valorizzato tramite il Codice Fiscale, ossia con @root='2.16.840.1.113883.2.9.4.3.2', oppure tramite un identificativo regionale con l'attributo @root strutturato nel seguente modo: “2.16.840.1.113883.2.9.2.” + [REGIONE] + “.4.2”.</assert>
			
			<assert test="count(hl7:assignedEntity/hl7:assignedPerson)=0 or count(hl7:assignedEntity/hl7:assignedPerson/hl7:name)=1"
			>ERRORE-34| L'elemento ClinicalDocument/<name/>/assignedEntity/assignedPerson, se presente, deve contenere un elemento 'name'.</assert>
		</rule>
		
		<!--inFulfillmentOf-->
		<rule context="hl7:ClinicalDocument/hl7:inFulfillmentOf">
			<assert test="count(hl7:order/hl7:id)=1"
			>ERRORE-35| L'elemento ClinicalDocument/<name/>/order deve contenere al più un elemento 'id'.</assert>
			
			<assert test="count(hl7:order/hl7:priorityCode)=0 or count(hl7:order/hl7:priorityCode[@code and @codeSystem='2.16.840.1.113883.5.7'])=1"
			>ERRORE-36| L'elemento ClinicalDocument/<name/>/order/priorityCode, se presente, deve avere l'attributo @code valorizzato secondo il sistema di codifica HL7 ActPriority - @codeSystem='2.16.840.1.113883.5.7'.</assert>
		</rule>

		
		<!--__________________________________________CONTROLLI GENERICI__________________________________________-->
		
		<!-- Controllo telecom -->
		<rule context="//hl7:telecom">
			<assert test="(count(@use)=1)"
			>ERRORE-37| L’elemento 'telecom' DEVE contenere l'attributo @use.</assert>
		</rule>
		
		<rule context="//*[contains(local-name(), 'Organization')][hl7:telecom]">
			<assert test="not(hl7:telecom/@use='H' or hl7:telecom/@use='HP' or hl7:telecom/@use='HV')"
			>ERRORE-38| L'elemento telecom di un'organizzazione non può essere di tipo Home, ovvero l'attributo @use deve essere diverso da: H | HP | HV.</assert>
		</rule>
		
		<!-- Controllo CF -->
		<rule context="//hl7:id[@root='2.16.840.1.113883.2.9.4.3.2']">
			<let name="CF" value="@extension"/>
			<assert test="matches(@extension, '[A-Z0-9]{16}') and string-length($CF)=16"
			>ERRORE-39| Il codice fiscale '<value-of select="$CF"/>' del cittadino e/o operatore DEVE avere 16 cifre [A-Z0-9]{16}</assert>
		</rule>
		
		<!-- Controllo sotto elementi name-->
		<rule context="//hl7:name[contains(local-name(..), 'Organization') or (parent::hl7:location)]">
			<assert test="count(hl7:delimiter)=0 and count(hl7:prefix)=0 and count(hl7:suffix)=0"
			>ERRORE-40| L’elemento 'name' di un'organizzazione non deve contenere i sotto elementi 'delimiter', 'prefix', 'suffix'.</assert>
    	</rule>
		
		<rule context="//*[contains(local-name(), 'Person')]/hl7:name">
			<let name="errorPath">
				<xsl:for-each select="ancestor::*[not(self::hl7:ClinicalDocument)]">
					<xsl:value-of select="concat('/', name())"/>
				</xsl:for-each>
			</let>
			<assert test="count(hl7:delimiter)=0 and count(hl7:given)=1 and count(hl7:family)=1"
			>ERRORE-41| L’elemento 'name' di un soggetto deve contenere i tag 'given' e 'family' e non il tag 'delimiter'.
			Path: ClinicalDocument<value-of select="$errorPath"/>.</assert>
		</rule>
		
		<!-- Controllo effectiveTime: -->
		<rule context="//hl7:effectiveTime[hl7:low/@value]">
			<let name="effective_time_low" value="string(hl7:low/@value)"/>
			<let name="effective_time_high" value="string(hl7:high/@value)"/>
			<assert test="count(hl7:high/@value)=0 or ($effective_time_high >= $effective_time_low)"
			>ERRORE-42| Il valore dell'elemento effectiveTime/high : '<value-of select="$effective_time_high"/>' deve essere maggiore o uguale dell'effectiveTime/low : '<value-of select="$effective_time_low"/>'.</assert>
		</rule>
		
		<!-- Controllo address: -->
		<rule context="//*[contains(local-name(), 'Organization')]/hl7:addr[@use='H' or @use='HP' or @use='HV']">
			<assert test="false()"
			>ERRORE-43| L'indirizzo di un'organizzazione non può essere di tipo Home, ovvero l'attributo @use deve essere diverso da: H | HP | HV.
			</assert>
		</rule>
		
		<rule context="//hl7:addr[
                  not(
						ancestor::hl7:birthplace
					)
			]">
			<assert test="count(hl7:country)=1 and count(hl7:city)=1 and count(hl7:streetAddressLine)=1"
			>ERRORE-44| L'elemento <name/> addr deve avere valorizzati gli elementi 'country', 'city', 'streetAddressLine'.</assert>
		</rule>
		
		
		<let name="num_addr" value="count(//hl7:addr[not(parent::hl7:place)and not(parent::hl7:scopingOrganization)])"/>
		<rule context="//hl7:addr">
		<assert test="count(//hl7:addr[not(parent::hl7:place)and not(parent::hl7:scopingOrganization)][@use])=$num_addr"
		>ERRORE-45| L'elemento 'addr'deve avere l'attributo @use valorizzato.</assert>
		</rule>
	
		<rule context="//hl7:code">
			<assert test="(count(@code)!=0 and count(@codeSystem)!=0) or (count(@nullFlavor)!=0)"
			>ERRORE-46| L'elemento 'code' deve avere gli attributi @code e @codeSystem valorizzati, altrimenti deve avere l'attributo @nullFlavor.</assert>
		</rule>
		
		<rule context="//hl7:id">
			<assert test="(count(@root)!=0 and count(@extension)!=0)"
			>ERRORE-47| L'elemento 'id' deve contenere gli attributi @root ed @extension valorizzati.</assert>
		</rule>
		
				
		<rule context="//hl7:entryRelationship[
				hl7:observation
				and not(
					ancestor::hl7:entryRelationship/
					hl7:act[hl7:templateId/@root='2.16.840.1.113883.3.1937.777.63.10.811']/
					hl7:entryRelationship[hl7:observation]
				)
			]">
		<assert test="@typeCode='COMP'">
			ERRORE-48 | L'elemento 'entryRelationship' di tipo observation deve avere l'attributo @typeCode='COMP' ad esclusione della entryRelationship/Observation contenuta in act_VariazioneFarmaco che deve avere l'attributo @typeCode='RSON'.
		</assert>
	</rule>
		
		
		<!--Controllo sugli attributi di observation-->
		<rule context="//hl7:observation">
			<assert test="count(@classCode)=0 or @classCode='OBS' and @moodCode='EVN'"
			>ERRORE-49| L'attributo "@classCode" dell'elemento 'observation' deve essere valorizzato con 'OBS' e l'attributo @moodCode deve essere valorizzato con 'EVN' </assert>
		</rule>
		
	
	
	<!--__________________________________________BODY__________________________________________-->


		<!-- Controllo Sezione obbligatoria-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody">
			
		<!-- 1. EROGAZIONE FARMACEUTICA NON SSN-->
			<assert test="count(hl7:component/hl7:section/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.809'])=1"
			>ERRORE-b1| Sezione Erogazione Farmaceutica non SSN: La sezione DEVE contenere l'elemento 'templateId' e DEVE essere presente l'attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.809'.</assert>
			
			<assert test="count(hl7:component/hl7:section/hl7:code[@code='60590-7' and @codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b2| Sezione Erogazione Farmaceutica non SSN: La sezione DEVE essere presente e DEVE contenere l'elemento 'code' con l'attributo @code valorizzato con '60590-7' e l'attributo @codeSystem valorizzato con '2.16.840.1.113883.6.1'.</assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.809']]/hl7:text)=1"
			>ERRORE-b3| Sezione Erogazione Farmaceutica non SSN: La sezione DEVE contenere l'elemento 'text' obbligatorio.</assert>
			
			<assert test="count(hl7:component/hl7:section/hl7:entry)>=1"
			>ERRORE-b4| Sezione Erogazione Farmaceutica non SSN: La sezione DEVE contenere almeno un elemento 'entry' obbligatorio.</assert>
		
		
		<!-- 2. MESSAGGIO REGIONALE -->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='51851-4']])=0 or count(hl7:component/hl7:section[hl7:code[@code='51851-4']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.816'])=1">
			ERRORE-b5| Sezione Messaggio Regionale: La sezione, se presente, DEVE avere l'attributo @code valorizzato con '51851-4' e l'elemento 'templateId' con l'attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.816'. </assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='51851-4']])=0 or count(hl7:component/hl7:section[hl7:code[@code='51851-4']]/hl7:text)=1">
			ERRORE-b6| Sezione Messaggio Regionale: La sezione DEVE contenere l'elemento 'text'. </assert>	
		
		<!-- 3. ANNOTAZIONI -->
			<assert test =" count(hl7:component/hl7:section[hl7:code[@code='48767-8']])=0 or count(hl7:component/hl7:section[hl7:code[@code='48767-8']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.815'])=1">
			ERRORE-b7| Sezione Annotazioni: la sezione DEVE contenere l'elemento 'templateId' con l'attributo @root valorizzato '2.16.840.1.113883.3.1937.777.63.10.815'.</assert>

			<assert test="count(hl7:component/hl7:section[hl7:code[@code='48767-8']])=0 or count(hl7:component/hl7:section[hl7:code[@code='48767-8']]/hl7:text)=1"
			>ERRORE-b8| Sezione Annotazioni: La sezione DEVE contenere l'elemento 'text'. </assert>
		
		</rule>

		<!-- Controllo entry-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section/hl7:entry">
			<assert test="count(hl7:supply[@moodCode='EVN'])=1"
			>ERRORE-b9| Sezione Erogazione Farmaceutica non SSN: L'elemento <name/>/supply deve contenere l'attributo @moodCode valorizzato con 'EVN'.</assert>
			
			<assert test="count(hl7:supply/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.810'])=1"
			>ERRORE-b10| Sezione Erogazione Farmaceutica non SSN: L'elemento <name/>/supply deve contenere l'elemento 'templateId' con l'attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.810'.</assert>
			
			<assert test="count(hl7:supply/hl7:id)=1"
			>ERRORE-b11| Sezione Erogazione Farmaceutica non SSN: L'elemento <name/>/supply deve contenere l'elemento 'id'.</assert>
			
			<assert test="count(hl7:supply/hl7:effectiveTime)=1"
			>ERRORE-b12| Sezione Erogazione Farmaceutica non SSN: L'elemento <name/>/supply deve contenere l'elemento 'effectiveTime'.</assert>
			
			<assert test="count(hl7:supply/hl7:product/hl7:manufacturedProduct)=1"
			>ERRORE-b13| Sezione Erogazione Farmaceutica non SSN: L'elemento <name/>/supply/product deve contenere l'elemento 'manufacturedProduct'.</assert>
			
			<assert test="count(hl7:supply/hl7:product/hl7:manufacturedProduct/hl7:id)=1"
			>ERRORE-b14| Sezione Erogazione Farmaceutica non SSN: L'elemento <name/>/supply/product/manufacturedProduct deve contenere l'elemento 'id'.</assert>
			
			
			<assert test="count(hl7:supply/hl7:product/hl7:manufacturedProduct/hl7:manufacturedLabeledDrug/hl7:code[@codeSystem='2.16.840.1.113883.2.9.6.1.5'])=1"
			>ERRORE-b15| Sezione Erogazione Farmaceutica non SSN: L'elemento <name/>/supply/product/manufacturedProduct/manufacturedLabeledDrug DEVE contenere l'elemento 'code' che contiene la codifica AIC che rappresenterà il prodotto erogato (attributo @codeSystem='2.16.840.1.113883.2.9.6.1.5').</assert>
		
        <!-- entryRelationship Act-->
			<assert test="count(hl7:supply/hl7:entryRelationship[hl7:act])&lt;=2"
			>ERRORE-b16| Sezione Erogazione Farmaceutica non SSN: L'elemento supply/entryRelationship di tipo act può essere presente al più due volte.</assert>
			
			<let name="num_Act" value="count(hl7:supply/hl7:entryRelationship[hl7:act])"/>
			<assert test="count(hl7:supply/hl7:entryRelationship[hl7:act])=0 or count(hl7:supply/hl7:entryRelationship/hl7:act[@classCode='ACT' and @moodCode='EVN'])=$num_Act"
			>ERRORE-b17| Sezione Erogazione Farmaceutica non SSN: L'elemento supply/entryRelationship di tipo act, se presente, deve contenere gli attributi @classCode e @moodCode valorizzati rispettivamnente con 'ACT' e 'EVN'.</assert>
			
		<!-- entryRelationship Act_Variazione Farmaco-->	
			<assert test="count(hl7:supply/hl7:entryRelationship[hl7:act])=0 or count(hl7:supply/hl7:entryRelationship/hl7:act/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.811'])=1"
			>ERRORE-b18| Sezione Erogazione Farmaceutica non SSN: L'elemento supply/entryRelationship di tipo act(Variazione Farmaco), se presente, deve contenere l'elemento templateId con l'attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.811'.</assert>
				
			<assert test="count(hl7:supply/hl7:entryRelationship/hl7:act[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.811']])=0 or count(hl7:supply/hl7:entryRelationship/hl7:act[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.811']]/hl7:code[(@code='S' or @code='A' or @code='V') and @codeSystem='2.16.840.1.113883.3.1937.777.63.11.16'])=1"
			>ERRORE-b19| Sezione Erogazione Farmaceutica non SSN: L'elemento supply/entryRelationship di tipo act (Variazione Farmaco), se presente, deve contenere l'elemento 'code' valorizzato con uno dei seguenti valori derivati dal @codeSystem:2.16.840.1.113883.3.1937.777.63.11.16:
			- S: il codice AIC inserito nel campo rappresenta una sostituzione di farmaco, prevista per legge, rispetto a quanto indicato dal medico prescrittore;
			- A: il codice inserito nel campo si riferisce ad un codice AIC, riferito allo stesso farmaco prescritto dal medico, ma che il farmacista ritiene più aggiornato come codice;
			- V: il codice prestazione inserito nel campo è stato variato dall’erogatore specialistico rispetto a quanto prescritto dal medico.
			</assert>
			
			<!-- Act_Variazione Farmaco/Observation_MotivazioneSostituibilità-->
			<assert test="count(hl7:supply/hl7:entryRelationship[hl7:act])=0 or count(hl7:supply/hl7:entryRelationship/hl7:act/hl7:entryRelationship[@typeCode='RSON']/hl7:observation)=1"
		    >ERRORE-b20| Sezione Erogazione Farmaceutica non SSN: L'elemento supply/entryRelationship di tipo act (Variazione Farmaco), se presente, deve contenere una ed una sola 'entryRelationship' con @typeCode='RSON' e di tipo observation.</assert>
			
			<assert test="count(hl7:supply/hl7:entryRelationship[hl7:act])=0 or count(hl7:supply/hl7:entryRelationship/hl7:act/hl7:entryRelationship/hl7:observation[@moodCode='EVN'])=1"
		    >ERRORE-b21| Sezione Erogazione Farmaceutica non SSN: L'elemento supply/entryRelationship/act/entryRelationship/observation deve avere l'attributo @moodCode valorizzato con 'EVN'.</assert>
			
			<assert test="count(hl7:supply/hl7:entryRelationship[hl7:act])=0 or count(hl7:supply/hl7:entryRelationship/hl7:act/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.812'])=1"
		    >ERRORE-b22| Sezione Erogazione Farmaceutica non SSN: L'elemento supply/entryRelationship/act/entryRelationship/observation deve contenere l'elemento 'templateId' con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.812'.</assert>
			
			<assert test="count(hl7:supply/hl7:entryRelationship[hl7:act])=0 or count(hl7:supply/hl7:entryRelationship/hl7:act/hl7:entryRelationship/hl7:observation/hl7:code[@codeSystem='2.16.840.1.113883.2.9.6.1.53'])=1"
		    >ERRORE-b23| Sezione Erogazione Farmaceutica non SSN: L'elemento supply/entryRelationship/act/entryRelationship/observation deve contenere l'elemento 'code' che contiene il valore indicante la motivazione di una variazione del farmaco erogato rispetto al codice AIC prescritto (attributo @codeSystem='2.16.840.1.113883.2.9.6.1.53').</assert>
			
			<!--Observation_MotivazioneSostituibilità/entryRelationship FarmacoSostituito-->
			<assert test="count(hl7:supply/hl7:entryRelationship[hl7:act])=0 or count(hl7:supply/hl7:entryRelationship/hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='COMP'])&lt;=1"
		    >ERRORE-b24| Sezione Erogazione Farmaceutica non SSN: L'elemento supply/entryRelationship/act/entryRelationship/observation può contenere al più una 'entryRelationship' con @typeCode='COMP'.</assert>
			
			<assert test= "count(hl7:supply/hl7:entryRelationship/hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='COMP'])=0 or count(hl7:supply/hl7:entryRelationship/hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship/hl7:substanceAdministration[@moodCode='RQO'])=1"
		    >ERRORE-b25| Sezione Erogazione Farmaceutica non SSN: L'elemento supply/entryRelationship/act/entryRelationship/observation/entryRelationship/substanceAdministration, se presente, deve avere il @moodCode='RQO'.</assert>
			
			<assert test="count(hl7:supply/hl7:entryRelationship/hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship/hl7:substanceAdministration)=0 
			or count(hl7:supply/hl7:entryRelationship/hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship/hl7:substanceAdministration/hl7:consumable)=1"
		    >ERRORE-b26| Sezione Erogazione Farmaceutica non SSN: L'elemento supply/entryRelationship/act/entryRelationship/observation/entryRelationship/substanceAdministration, se presente, deve contenere l'elemento 'consumable'.</assert>
		    <assert test="count(hl7:supply/hl7:entryRelationship/hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship/hl7:substanceAdministration)=0 
			or count(hl7:supply/hl7:entryRelationship/hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship/hl7:substanceAdministration/hl7:consumable/hl7:manufacturedProduct/hl7:manufacturedLabeledDrug/hl7:code)=1"
		    >ERRORE-b27| Sezione Erogazione Farmaceutica non SSN: L'elemento supply/entryRelationship/act/entryRelationship/observation/entryRelationship/substanceAdministration, se presente, deve contenere l'elemento consumable/manufacturedProduct/manufacturedLabeledDrug/code in cui è possibile inserire il codice AIC e ATC che valorizza il farmaco prescritto.</assert>
			
		<!-- entryRelationship Act_Messaggio Regionale-->
			<assert test="count(hl7:supply/hl7:entryRelationship[@typeCode='SUBJ'])=0 or count(hl7:supply/hl7:entryRelationship/hl7:act/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.818'])=1"
			>ERRORE-b28| Sezione Erogazione Farmaceutica non SSN: L'elemento supply/entryRelationship di tipo act (Messaggio Regionale), se presente, deve contenere l'elemento 'templateId' con l'attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.818'.</assert>
			
			
			<assert test="count(hl7:supply/hl7:entryRelationship/hl7:act[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.818']])=0 or count(hl7:supply/hl7:entryRelationship/hl7:act[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.818']]/hl7:code[@code='48767-8' and @codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b29| Sezione Erogazione Farmaceutica non SSN: L'elemento supply/entryRelationship di tipo act (Messaggio Regionale), se presente, deve contenere l'elemento 'code' con l'attributo @code valorizzato con '48767-8' e @codeSystem='2.16.840.1.113883.6.1'.</assert>
			
			
			<assert test="count(hl7:supply/hl7:entryRelationship/hl7:act[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.818']])=0 or count(hl7:supply/hl7:entryRelationship/hl7:act[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.818']]/hl7:text)=0 or 
			count(hl7:supply/hl7:entryRelationship/hl7:act[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.818']]/hl7:text/hl7:reference)=1"
			>ERRORE-b30| Sezione Erogazione Farmaceutica non SSN: L'elemento supply/entryRelationship di tipo act (Messaggio Regionale), se presente, deve contenere l'elemento text/reference.</assert>
			

		<!-- entryRelationship Observation_Prezzo-->
			<assert test="count(hl7:supply/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.829'])=1"
			>ERRORE-b31| Sezione Erogazione Farmaceutica non SSN: L'elemento supply/entryRelationship/observation(Prezzo) DEVE essere presente e DEVE avere il 'templateId' valorizzato con @root='2.16.840.1.113883.3.1937.777.63.10.829'.</assert>
			
			<assert test="count(hl7:supply/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.829']]/hl7:code[@code='92033-0' and @codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b32| Sezione Erogazione Farmaceutica non SSN: L'elemento supply/entryRelationship/observation(Prezzo) DEVE essere presente e DEVE avere il code valorizzato con @code='92033-0' e @codeSystem='2.16.840.1.113883.6.1'.</assert>
			
			<assert test="count(hl7:supply/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.829']]/hl7:value)=0 or count(hl7:supply/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.829']]/hl7:value[@xsi:type='MO' and @value and @currency])=1"
			>ERRORE-b33| Sezione Erogazione Farmaceutica non SSN: L'elemento supply/entryRelationship/observation(Prezzo)/value se presente e DEVE avere @xsi:type='MO' e deve valorizzare gli attributi @value e @currency.</assert>
		
		<!-- entryRelationship Observation_AltriCosti-->
			<assert test="count(hl7:supply/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.830'])=1"
			>ERRORE-b34| Sezione Erogazione Farmaceutica non SSN: L'elemento supply/entryRelationship/observation(Altri Costi) DEVE essere presente e DEVE avere il 'templateId' valorizzato con @root='2.16.840.1.113883.3.1937.777.63.10.830'.</assert>
			
			<assert test="count(hl7:supply/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.830']]/hl7:code[@code='surcharge' and @codeSystem='2.16.840.1.113883.4.642.3.3093'])=1"
			>ERRORE-b35| Sezione Erogazione Farmaceutica non SSN: L'elemento supply/entryRelationship/observation(Altri Costi) DEVE essere presente e DEVE avere il 'code' valorizzato con @code='surcharge' e @codeSystem='2.16.840.1.113883.4.642.3.3093'.</assert>
			
			
			<assert test="count(hl7:supply/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.830']]/hl7:value)=0 or count(hl7:supply/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.830']]/hl7:value[@xsi:type='MO' and @value and @currency])=1"
			>ERRORE-b36| Sezione Erogazione Farmaceutica non SSN: L'elemento supply/entryRelationship/observation(Altri Costi)/value se presente e deve avere @xsi:type='MO' e deve valorizzare gli attributi @value e @currency.</assert>
			
		
		<!-- entryRelationship Obs_RegimeErogazione -->
		    <assert test="count(hl7:supply/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.813']])&lt;=1"
			>ERRORE-b37| Sezione Erogazione Farmaceutica non SSN: L'elemento supply/entryRelationship di tipo observation(Regime Erogazione) può essere presente al più una volta.</assert>
			
			
			<assert test="count(hl7:supply/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.813']])=0 or count(hl7:supply/hl7:entryRelationship/hl7:observation/hl7:code[@code='1' or @code='2' or @code='3' and @codeSystem='2.16.840.1.113883.3.1937.777.63.11.25'])=1"
			>ERRORE-b38| Sezione Erogazione Farmaceutica non SSN: L'elemento supply/entryRelationship di tipo observation(Regime Erogazione), se presente, deve contenere l'attributo @code valorizzato con: 
			- 1 (Diretta)
			- 2 (Distribuzione per Conto)
			- 3 (Convenzionata)
			derivati dal @codeSystem='2.16.840.1.113883.3.1937.777.63.11.25'.</assert>
						
		</rule>
		
		<!--Controllo sui codici delle sezioni-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section">
			<let name="codice" value="hl7:code/@code"/>
			<assert test="count(hl7:code[@code='60590-7'][@codeSystem='2.16.840.1.113883.6.1'])=1 or 
			count(hl7:code[@code='51851-4'][@codeSystem='2.16.840.1.113883.6.1'])=1 or 
			count(hl7:code[@code='48767-8'][@codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b39| Il codice '<value-of select="$codice"/>' non è corretto. La sezione deve essere valorizzata con uno dei seguenti codici:
			60590-7		- Sezione Erogazione Farmaceutica non SSN
			51851-4		- Sezione Messaggio Regionale
			48767-8		- Sezione Annotazioni
					
			</assert>
		</rule>	
		
		
	</pattern> 
</schema>