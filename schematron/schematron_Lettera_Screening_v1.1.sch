<?xml version="1.0" encoding="UTF-8"?>
<!-- schematron versione: 1.0-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" 
		xmlns:cda="urn:hl7-org:v3"
        xmlns:iso="http://purl.oclc.org/dsdl/schematron"
        xmlns:sch="http://www.ascc.net/xml/schematron"
        queryBinding="xslt2">
	<title>Schematron Lettera di invito screening o ad altri percorsi di prevenzione </title>
	<ns prefix="hl7" uri="urn:hl7-org:v3"/>
	<ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
	<pattern id="all">


<!--_______________________________________________________________HEADER _____________________________________________________________-->
	
		<!-- ClinicalDocument --> 
		<rule context="hl7:ClinicalDocument">
	        <!--Controllo realmCode-->
			<assert test="count(hl7:realmCode)>=1"
			>ERRORE-1| L'elemento <name/> DEVE avere almeno un elemento 'realmCode'</assert>
			<assert test="count(hl7:realmCode[@code='IT'])= 1"
			>ERRORE-2| L'elemento <name/>/realmCode' DEVE avere l'attributo @code valorizzato con 'IT'</assert>
			
			<!--Controllo templateId-->
			<let name="num_tid" value="count(hl7:templateId)"/>
			<assert test="$num_tid >= 1"
			>ERRORE-3| L'elemento <name/> DEVE avere almeno un elemento di tipo 'templateId'</assert>
			
			<assert test="count(hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.14.1'])= 1 and count(hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.14.1']/@extension)= 1" 
			>ERRORE-4| Almeno un elemento <name/>/templateId DEVE essere valorizzato attraverso l'attributo @root='2.16.840.1.113883.2.9.10.1.14.1' (id del template nazionale), associato all'attributo @extension che  indica la versione a cui il templateId fa riferimento.</assert>

			<!--Controllo code-->	
			<assert test="count(hl7:code[@code='108276-7'][@codeSystem='2.16.840.1.113883.6.1']) = 1"
			>ERRORE-4a| L'elemento <name/>/code DEVE essere valorizzato con l'attributo @code='108276-7' e il @codeSystem='2.16.840.1.113883.6.1'.</assert>
			
			<!--Warning title-->
			<assert test="hl7:title='Lettera di invito screening e altri percorsi di prevenzione'"
			>W001| L'elemento title specifica dovrebbe essere valorizzato a “Lettera di invito screening e altri percorsi di prevenzione".</assert>
			
			<!--Controllo confidentialityCode-->
			<assert test="(count(hl7:confidentialityCode[@code='N'][@codeSystem='2.16.840.1.113883.5.25'])= 1) or 
			(count(hl7:confidentialityCode[@code='V'][@codeSystem='2.16.840.1.113883.5.25'])= 1) or (count(hl7:confidentialityCode[@code='R'][@codeSystem='2.16.840.1.113883.5.25'])= 1)"
			>ERRORE-5| L'elemento <name/>/confidentialityCode DEVE avere l'attributo @code valorizzato con 'N' o 'R' o 'V', e il @codeSystem='2.16.840.1.113883.5.25'.</assert>
			
			<!--Controllo languageCode-->
			<assert test="count(hl7:languageCode)=1"
			>ERRORE-6| L'elemento <name/> DEVE contenere un solo elemento 'languageCode'. </assert>
			
			<!--Controllo incrociato tra setId-versionNumber e relatedDocument-->
			<let name="versionNumber" value="hl7:versionNumber/@value"/>
			<assert test="(string(number($versionNumber)) = 'NaN') or
					($versionNumber= '1' and count(hl7:setId)=0) or 
					($versionNumber= '1' and hl7:id/@root = hl7:setId/@root and hl7:id/@extension = hl7:setId/@extension) or
					($versionNumber!= '1' and hl7:id/@root = hl7:setId/@root and hl7:id/@extension != hl7:setId/@extension) or
					(hl7:id/@root != hl7:setId/@root)"
			>ERRORE-7| Se ClinicalDocument.id e ClinicalDocument.setId usano lo stesso dominio di identificazione (@root identico) allora l’attributo @extension del ClinicalDocument.id 
			deve essere diverso da quello del ClinicalDocument.setId a meno che ClinicalDocument.versionNumber non sia uguale ad 1; cioè i valori di setId ed id per un documento clinico coincidono solo per la prima versione di un documento.</assert>

			
			<assert test="(string(number($versionNumber)) ='NaN') or
						  ($versionNumber=1)  or 
						  (($versionNumber &gt;1) and count(hl7:relatedDocument)&gt;=1 and count(hl7:relatedDocument)&lt;=2)"
			>ERRORE-8| Se l'attributo <name/>/versionNumber/@value è maggiore di  1, l'elemento <name/>  deve contenere al più due elementi di tipo 'relatedDocument'.</assert>
			
			<!--Controllo recordTarget-->
			<assert test="count(hl7:recordTarget)=1"
			>ERRORE-9| L'elemento <name/> DEVE contenere un solo elemento 'recordTarget'. </assert>

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
			>ERRORE-9a| L'elemento <name/>/recordTarget/patientRole/id  deve avere l'attributo @root valorizzato tramite uno dei seguenti identificatori Nazionali:
				CF 2.16.840.1.113883.2.9.4.3.2
				TEAM 2.16.840.1.113883.2.9.4.3.7 e 2.16.840.1.113883.2.9.4.3.3
				ENI 2.16.840.1.113883.2.9.4.3.18
				STP 2.16.840.1.113883.2.9.4.3.17 oppure un identificativo regionale
				ANA 2.16.840.1.113883.2.9.4.3.15
				Oppure tramite gli identificatori regionali generati per rappresentare l'id del paziente.
			</assert>

			<assert test="
			(
			  count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.7']) = 0 or
			  count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.3']) = 1
			) and
			(
			  count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.3']) = 0 or
			  count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.7']) = 1
			)"

			>ERRORE-9b| Nel caso di Soggetti assicurati da istituzioni estere, devono essere riportati almeno due elementi di tipo 'id' contenenti:
				- 2.16.840.1.113883.2.9.4.3.7: Il numero di identificazione della Tessera TEAM (Tessera Europea di Assicurazione Malattia),
				- 2.16.840.1.113883.2.9.4.3.3: Il numero di identificazione Personale TEAM
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

			>ERRORE-9c| Nel caso di Stranieri Temporaneamente Presenti, l'elemento <name/>/recordTarget/patientRole/id  deve avere l'attributo @root valorizzato tramite un identificativo STP.</assert>
			
			<!--Controllo recordTarget/patientRole/addr-->
			<let name="num_addr" value="count(hl7:recordTarget/hl7:patientRole/hl7:addr)"/>
			
			<assert test="$num_addr &gt;=1 and (count(hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:country)=$num_addr and 
			count(hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:city)=$num_addr and 
			count(hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:streetAddressLine)=$num_addr)"
			>ERRORE-10| L'elemento <name/>/recordTarget/patientRole/addr DEVE riportare i sotto-elementi 'country', 'city' e 'streetAddressLine' </assert>
			
			<!--Controllo recordTarget/patientRole/patient/name-->
			<let name="patient" value="hl7:recordTarget/hl7:patientRole/hl7:patient"/>
			
			<assert test="count($patient)=1"
			>ERRORE-11| L'elemento <name/>/recordTaget/patientRole DEVE contenere l'elemento patient</assert>
			<assert test="count($patient)=0 or count($patient/hl7:name)=1"
			>ERRORE-12| L'elemento <name/>/recordTaget/patientRole/patient DEVE contenere l'elemento 'name'</assert>
			<assert test="count($patient)=0 or (count($patient/hl7:name/hl7:given)=1 and count($patient/hl7:name/hl7:family)=1)"
			>ERRORE-13| L'elemento <name/>/recordTaget/patientRole/patient/name DEVE riportare gli elementi 'given' e 'family'</assert>
			
			<!--Controllo recordTarget/patientRole/patient/administrativeGenderCode-->
			<let name="genderOID" value="hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:administrativeGenderCode/@codeSystem"/>
			
			<assert test="count($patient)=0 or count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:administrativeGenderCode)=1"
			>ERRORE-14| L'elemento <name/>/recordTarget/patientRole/patient DEVE contenere l'elemento administrativeGenderCode </assert>
			
			<assert test="count($patient)=0 or $genderOID='2.16.840.1.113883.5.1'"
			>ERRORE-15| L'OID assegnato all'attributo <name/>/recordTarget/patientRole/patient/administrativeGenderCode/@codeSystem='<value-of select="$genderOID"/>' non è corretto. L'attributo DEVE essere valorizzato con '2.16.840.1.113883.5.1' </assert>
			
			<!--Controllo recordTarget/patientRole/patient/birthTime-->
			<assert test="count($patient)=0 or
			count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthTime)=1"
			>ERRORE-16| L'elemento <name/>/recordTaget/patientRole/patient DEVE riportare un elemento 'birthTime'. Qualora non si possa risalire al dato, è possibile valorizzare l'elemento con @nullFlavor="UNK"</assert>	
			
			
			<!--Controllo recordTarget/patientRole/patient/birthplace-->
			<assert test="count($patient)=0 or count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthplace)=1"
			>ERRORE-17| L'elemento <name/>/recordTarget/patientRole/patient DEVE contenere un elemento birthplace</assert>
			
			<!--Controllo recordTarget/patientRole/patient/birthplace/place/addr-->
			<assert test="count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthplace)=0 or 
			count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthplace/hl7:place/hl7:addr/hl7:country)=1"
			>ERRORE-18| L'elemento <name/>/recordTarget/patientRole/patient/birthplace DEVE contenere un elemento place/addr/country </assert>	
			
			
			<!--Controllo custodian/assignedCustodian/representedCustodianOrganization-->
			<assert test="count(hl7:custodian/hl7:assignedCustodian/hl7:representedCustodianOrganization/hl7:name)=1">
			  ERRORE-19| L'elemento <name/>/custodian/assignedCustodian/representedCustodianOrganization DEVE contenere l'elemento name.
			</assert>
			
			<let name="num_addr_cust" value="count(hl7:custodian/hl7:assignedCustodian/hl7:representedCustodianOrganization/hl7:addr)"/>
			<let name="addr_cust" value="hl7:custodian/hl7:assignedCustodian/hl7:representedCustodianOrganization/hl7:addr"/>
			
			<assert test="$num_addr_cust=0 or (count($addr_cust/hl7:country)=$num_addr_cust and
			count($addr_cust/hl7:city)=$num_addr_cust and 
			count($addr_cust/hl7:streetAddressLine)=$num_addr_cust)"
			>ERRORE-20| L'elemento <name/>/custodian/assignedCustodian/representedCustodianOrganization/addr DEVE riportare i sotto-elementi 'country','city' e 'streetAddressLine'</assert>
			
			 <!--Controllo legalAuthenticator-->
			
			<assert test = "count(hl7:legalAuthenticator)=0 or count(hl7:legalAuthenticator/hl7:signatureCode[@code='S'])=1" 
			>ERRORE-21| L'elemento <name/>/legalAuthenticator/signatureCode deve essere valorizzato con il codice "S" </assert>
			
			<assert test = "count(hl7:legalAuthenticator)=0 or count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=1 or
					count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:id[@root='2.16.840.1.113883.2.9.6.3.2'])=1"
			>ERRORE-22| L'elemento <name/>/legalAuthenticator/assignedEntity DEVE contenere almeno un elemento id valorizzato con uno dei seguenti OID:
			- @root='2.16.840.1.113883.2.9.4.3.2' (CF)
			- @root='2.16.840.1.113883.2.9.6.3.2' (p.iva)</assert>
			
			<assert test = "count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:assignedPerson)=0 or count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:assignedPerson/hl7:name)=1"
			>ERRORE-23| L'elemento <name/>/legalAuthenticator/assignedEntity/assignedPerson DEVE contenere l'elemento 'name'.</assert>
			
			<assert test = "count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:assignedPerson)=0 or (count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:assignedPerson/hl7:name/hl7:family)=1 and 
			count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:assignedPerson/hl7:name/hl7:given)=1)"
			>ERRORE-24| L'elemento <name/>/legalAuthenticator/assignedEntity/assignedPerson/name DEVE riportare gli elementi 'given' e 'family'</assert>
			
			
			<!-- Controllo cardinalità documentationOf -->
			<assert test="count(hl7:documentationOf)=2"
			>ERRORE-25| L'elemento ClinicalDocument/documentationOf deve essere presente con cardinalità pari a due andando a specificare:
							- la tipologia di lettera (invito o sollecito);
							- la tipologia di screening oggetto dell’intervento.</assert>
							
			<assert test = "count(hl7:documentationOf/hl7:serviceEvent/hl7:code[@code='108276-7' and @codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:documentationOf/hl7:serviceEvent/hl7:code[@code='108274-2' and @codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-26| L'elemento ClinicalDocument/documentationOf/serviceEvent DEVE contenere l'elemento code valorizzato con l'attributo @codeSystem che riporti il seguente OID '2.16.840.1.113883.6.1' e con l'attributo @code pari a uno dei seguenti valori:
			- 108276-7 (Lettera di invito allo screening);
			- 108274-2(Lettera di reminder screening). </assert>
			
			<assert test = "count(hl7:documentationOf/hl7:serviceEvent/hl7:code[@code='112070-8'and @codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:documentationOf/hl7:serviceEvent/hl7:code[@code='LA36986-0' and @codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:documentationOf/hl7:serviceEvent/hl7:code[@code='LA36987-8' and @codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:documentationOf/hl7:serviceEvent/hl7:code[@code='LA36988-6' and @codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:documentationOf/hl7:serviceEvent/hl7:code[@code='LA36989-4' and @codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:documentationOf/hl7:serviceEvent/hl7:code[@code='LA36990-2' and @codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-26a| L'elemento ClinicalDocument/documentationOf/serviceEvent DEVE contenere l'elemento code con l'attributo @codeSystem che riporti il seguente OID '2.16.840.1.113883.6.1' e con l'attributo @code valorizzato con uno dei seguenti codici:
			- 112070-8 (Screening initiative);
			- LA36986-0 (Breast cancer screening campaign);
			- LA36987-8 (Colorectal cancer screening campaign);
			- LA36988-6 (Cervical cancer screening campaign);
			- LA36989-4 (Hepatitis C screening campaign);
			- LA36990-2 (Other prevention pathways).
			</assert>
							
			 <!--relatedDocument-->
			<assert test="(count(hl7:relatedDocument)&lt;2 or (count(hl7:relatedDocument[@typeCode='XFRM'])=1 and (count(hl7:relatedDocument[@typeCode='RPLC'])=1 or count(hl7:relatedDocument[@typeCode='APND'])=1)))"
			>ERRORE-27| Un documento CDA2 conforme può avere o un relatedDocument con @typeCode='APND' | 'RPLC' | 'XFRM'; oppure una combinazione di due relatedDocument con la seguente composizione:
			- @typeCode='XFRM' e @typeCode='RPLC'; 
			- @typeCode='XFRM' e @typeCode='APND'.</assert>				
		</rule>
		
		<!-- Controllo author-->
		<rule context="hl7:ClinicalDocument/hl7:author">
		
			<!--Controllo author/assignedAuthor/id-->
			<assert test="count(hl7:assignedAuthor/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=1 or count(hl7:assignedAuthor/hl7:id[@root='2.16.840.1.113883.2.9.6.3.2'])= 1"
			>ERRORE-28| L'elemento <name/>/assignedAuthor DEVE contenere almeno un elemento id valorizzato con uno dei seguenti OID:
			- @root='2.16.840.1.113883.2.9.4.3.2' (CF)
			- @root='2.16.840.1.113883.2.9.6.3.2' (p.iva) '</assert>
			
			<!--Controllo author/assignedAuthor/assignedPerson/name-->
			<let name="name_author" value="hl7:assignedAuthor/hl7:assignedPerson"/>
			
			<assert test="count($name_author)=0 or count($name_author/hl7:name)=1"
			>ERRORE-29| L'elemento <name/>/assignedAuthor/assignedPerson DEVE avere l'elemento 'name'. </assert>
			<assert test="count($name_author/hl7:name)=0 or (count($name_author/hl7:name/hl7:given)=1 and count($name_author/hl7:name/hl7:family)=1)"
			>ERRORE-30| L'elemento <name/>/assignedAuthor/assignedPerson/name DEVE avere gli elementi 'given' e 'family'.</assert>
			
		</rule>
		
		<!-- Controllo participant-->
		<rule context="hl7:ClinicalDocument/hl7:participant">
		
			<assert test="@typeCode='VRF'"
			>ERRORE-31| L'attributo typeCode  deve essere valorizzato con il valore "VRF"
			</assert>
			
			<assert test="count(hl7:functionCode)=0 or count(hl7:functionCode[@codeSystem='2.16.840.1.113883.2.9.5.88'])=1"
			>ERRORE-32| L'elemento <name/>/functionCode se presente deve avere l'attributo @codeSystem valorizzato con OID "2.16.840.1.113883.2.9.5.88"
			</assert>			
			<assert test="count(hl7:associatedEntity[@classCode='PROV'])=1"
			>ERRORE-33| L'elemento <name/>/associatedEntity/@classCode deve deve essere valorizzato con il valore "PROV"</assert>
			
			<assert test="count(hl7:associatedEntity/hl7:id)>=1"
			>ERRORE-34| L'elemento <name/>/associatedEntity deve contenere almeno un elemento 'id'</assert>
			
						
			<assert test="count(hl7:associatedEntity/hl7:associatedPerson)=0 or count(hl7:associatedEntity/hl7:associatedPerson/hl7:name)=1"
			>ERRORE-35| L'elemento <name/>/associatedEntity/associatedPerson deve contenere l'elemento 'name'.</assert>
			
			<assert test="count(hl7:associatedEntity/hl7:associatedPerson)=0 
			or (count(hl7:associatedEntity/hl7:associatedPerson/hl7:name/hl7:family)=1 and count(hl7:associatedEntity/hl7:associatedPerson/hl7:name/hl7:given)=1)"
			>ERRORE-36| L'elemento <name/>/associatedEntity/associatedPerson/name deve contenere gli elementi 'given' e 'family'.</assert>
			

			
		</rule>		
<!--____________________________________________________CONTROLLI GENERICI_________________________________________________________________-->
	
		<!--Controllo use Telecom-->
		<rule context="//hl7:telecom">
			<assert test="(count(@use)=1)"
			>ERRORE-37| L’elemento 'telecom' DEVE contenere l'attributo @use. </assert>
		</rule>	
		<rule context="//*[contains(local-name(), 'Organization')][hl7:telecom]">
			<assert test="not(hl7:telecom/@use='H' or hl7:telecom/@use='HP' or hl7:telecom/@use='HV')"
			>ERRORE-37a| L'elemento telecom di un'organizzazione non può essere di tipo Home, ovvero l'attributo @use deve essere diverso da: H | HP | HV.
			</assert>
		</rule>
		<!-- Controllo formato: -->
		<!--campi Codice Fiscale: 16 cifre [A-Z0-9]{16} -->
		<rule context="//hl7:id[@root='2.16.840.1.113883.2.9.4.3.2']">
			<let name="CF" value="@extension"/>
			<assert test="matches(@extension, '[A-Z0-9]{16}') and string-length($CF)=16"
			>ERRORE-38| Il codice fiscale '<value-of select="$CF"/>' cittadino ed operatore deve essere costituito da 16 cifre [A-Z0-9]{16}</assert>
		</rule>
	
		<!--Controllo sugli attributi di observation-->
		<rule context="//hl7:observation">
			<let name="moodCd" value="@moodCode"/>
			<assert test="count(@classCode)=0 or @classCode='OBS'"
			>ERRORE-39| L'attributo "@classCode" dell'elemento "observation" deve essere valorizzato con "OBS". </assert>
			
			<assert test="$moodCd='EVN'"
			>ERRORE-40| L'attributo "@moodCode" dell'elemento "observation" deve essere valorizzato con "EVN". </assert>
		</rule>

		<!--Verifica che i codici ActStatusActiveCompletedAborteSuspended utilizzati siano corretti-->
        <rule context="//hl7:statusCode">
            <let name="val_status" value="@code"/>
            <assert test="$val_status='active' or  $val_status='completed' or $val_status='aborted' or $val_status='suspended'"
            >ERRORE 41| Codice ActStatus '<value-of select="$val_status"/>' errato! L'attributo @code deve essere valorizzato con "active", "completed", "aborted", "suspended".
            </assert>
        </rule>

		<rule context="//hl7:name[contains(local-name(..), 'Organization') or (parent::hl7:location)]">
			<assert test="count(hl7:delimiter)=0 and count(hl7:prefix)=0 and count(hl7:suffix)=0"
			>ERRORE-42| L’elemento 'name' di un'organizzazione non deve contenere i sotto elementi 'delimiter', 'prefix', 'suffix'.</assert>
		</rule>

		<rule context="//hl7:name">
			<assert test="count(hl7:delimiter)=0"
			>ERRORE-43| L’elemento 'name' del soggetto non deve contenere il sotto-elemento 'delimiter'.</assert>
		</rule>

		<rule context="//hl7:effectiveTime[hl7:low/@value]">
			<let name="effective_time_low" value="string(hl7:low/@value)"/>
			<let name="effective_time_high" value="string(hl7:high/@value)"/>
			<assert test="count(hl7:high/@value)=0 or ($effective_time_high >= $effective_time_low)"
			>ERRORE-44| Il valore dell'elemento effectiveTime/high : '<value-of select="$effective_time_high"/>'
				deve essere maggione o uguale di quello di effectiveTime/low : '<value-of select="$effective_time_low"/>'.</assert>
		</rule>

		<rule context="//*[contains(local-name(), 'Organization')]/hl7:addr[@use='H' or @use='HP' or @use='HV']">
			<assert test="false()"
			>ERRORE-45| L'indirizzo di un'organizzazione non può essere di tipo Home, ovvero l'attributo @use DEVE essere diverso da: H | HP | HV.
			</assert>
		</rule>

		<rule context="//hl7:originalText[hl7:reference]">
			<assert test="string(hl7:reference/@value)"
			>ERRORE-46| L'elemento originalText/reference/@value DEVE essere valorizzato.</assert>
		</rule>
		
		<rule context="//hl7:code">
		<assert test="(@code and @codeSystem) or @nullFlavor"
		>ERRORE-47| L'elemento 'code' deve avere gli attributi @code e @codeSystem valorizzati.</assert>
		</rule>
		<rule context="//hl7:id">
		<assert test="@root and @extension"
		>ERRORE-48| L'elemento 'id' deve contenere gli attributi @root ed @extension valorizzati.</assert>
		</rule>

		
<!--__________________________________________________BODY__________________________________________________________________________-->

		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody">
		<!--Controlli sulle sezioni obbligatorie-->
			<!--1-->
			<!--Sezione: Livello Screening-->
			
			<assert test="count(hl7:component/hl7:section/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.613'])=1"
			>ERRORE-b1| Sezione Lettera Screening: DEVE essere presente un'unica sezione con templateId/@root valorizzato con il seguente OID "2.16.840.1.113883.3.1937.777.63.10.613"</assert>				
			<assert test="count(hl7:component/hl7:section/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.613'])=0 or count(hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.613']]/hl7:code[@code='112071-6' and @codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b2| Sezione Lettera Screening: la sezione DEVE contenere un elemento code con l'attributo @code valorizzato con '112071-6' e l'attributo @codeSystem valorizzato con il seguente OID '2.16.840.1.113883.6.1'.</assert>
			<assert test="count(hl7:component/hl7:section/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.613'])=0 or count(hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.613']]/hl7:text)=1"
			>ERRORE-b3| Sezione Lettera Screening: la sezione DEVE contenere un elemento text.</assert>
			
			
			
			<!-- Controlli Encounter della sezione Lettera Screening -->
			
			<assert test="
			  count(hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.613']]/hl7:entry/hl7:encounter)=0
			  or
			  count(hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.613']]/hl7:entry/hl7:encounter[@moodCode='APT'])=1">
			  ERRORE-b4| Sezione Lettera Screening: l'elemento encounter è utilizzato per descrivere un invito, già programmato o da programmare tra l’assistito e la struttura sanitaria. L’attributo @moodCode DEVE essere valorizzato con "APT".

			</assert>
			
			
			<!-- Controlli elementi encounter della sezione Lettera Screening -->
			<assert test="
			  count(hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.613']]/hl7:entry/hl7:encounter)=0
			  or			  count(hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.613']]/hl7:entry/hl7:encounter/hl7:effectiveTime[@value or @nullFlavor='UNK'])=1">
			  ERRORE-b5| Sezione Lettera Screening: l'elemento encounter Deve contenere un elemento effectiveTime. Se l'incontro non è ancora avvenuto e la data non è nota o non disponibile, è possibile valorizzarlo con @nullFlavor='UNK'.
			</assert>
			
			<assert test="
			  count(hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.613']]/hl7:entry/hl7:encounter/hl7:entryRelationship)=0
			  or
			  count(hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.613']]/hl7:entry/hl7:encounter/hl7:entryRelationship/hl7:observation/hl7:code[@code='ASSERTION'][@codeSystem='2.16.840.1.113883.5.4'])=1">
			  ERRORE-b6| Sezione Lettera Screening: l'elemento encounter deve contentenere all'interno l'elemento l'elemento code con gli attributi valorizzati nel seguente modo: 
			  @code valorizzato con 'ASSERTION'
			  @codeSystem valorizzato con il seguente OID "2.16.840.1.113883.5.4"
			</assert>
			
			<!-- Controlli entry della sezione Lettera Screening -->
			<assert test="count(hl7:component/hl7:section/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.613'])=0 or count(hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.613']]/hl7:entry/hl7:act[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.614']])>=1"  
			>ERRORE-b7| Sezione Lettera Screening: la sezione DEVE contenere almeno un elemento di tipo 'entry' con templateId/@root valorizzato con il seguente OID '2.16.840.1.113883.3.1937.777.63.10.614'. </assert>
			
			
			<!-- Controlli ActLetteraScreening della sezione Livello Screening -->
			
			<assert test="count(hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.613']]/hl7:entry) = 0 or count(hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.613']]/hl7:entry/hl7:act[hl7:code[@codeSystem='2.16.840.1.113883.6.1' and (@code='108273-4' or @code='LA32760-3' or @code='LA32759-5') or (@nullFlavor='UNK')]])=1" 
			>ERRORE-b7a| Sezione Lettera Screening: la sola entry/act (Livello Screening) DEVE contenere al suo interno un unico elemento di tipo code che contenga i seguenti valori:
			- 108273-4(Preventive medicine screening level)
			- LA32760-3 (Level 1)
			- LA32759-5 (Level 2)
			- @nullFlavor='UNK'
			
			</assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.613']]/hl7:entry) = 0 or count(hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.613']]/hl7:entry/hl7:act[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.614']]/hl7:text)=1" 
			>ERRORE-b8| Sezione Lettera Screening: la sola entry/act (Livello Screening) DEVE contenere al suo interno un unico elemento di tipo text.</assert>
			
			
			<assert test="count(hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.613']]/hl7:entry) = 0 or count(hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.613']]/hl7:entry/hl7:act[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.614']]/hl7:entryRelationship)=1" 
			>ERRORE-b9| Sezione Lettera Screening: la sola entry/act (Livello Screening) DEVE contenere al suo interno un unico elemento di tipo entryRelationship.</assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.613']]/hl7:entry) = 0 or count(hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.613']]/hl7:entry/hl7:act[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.614']]/hl7:entryRelationship/hl7:procedure/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.623'])=1" 
			>ERRORE-b10| Sezione Lettera Screening: all'interno della sola entry/act/entryRelationship (Livello Screening) DEVE essere presente l'elemento templateId con l'attributo @root	valorizzato con il seguente OID "2.16.840.1.113883.3.1937.777.63.10.623".</assert>
							
			<!--2-->
			<!--Sezione: Riferimento ad Invito Precedente-->
			<!-- Controlli della sezione riferimento ad invito precedente -->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='55107-7']])=0 or
			(count(hl7:component/hl7:section[hl7:code[@code='55107-7']]/hl7:templateId)=0 or	count(hl7:component/hl7:section[hl7:code[@code='55107-7']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.676'])=1)"
			>ERRORE-b11| Sezione Riferimento a lettera invito precedente: La sezione, se presente, può contenere l'elemento templateId con l' attributo @root valorizzato con il seguente OID "2.16.840.1.113883.3.1937.777.63.10.676".</assert>
			
			<assert test="count(hl7:component/hl7:section/hl7:code[@code='55107-7'][@codeSystem='2.16.840.1.113883.6.1'])=0 or count(hl7:component/hl7:section[hl7:code[@code='55107-7']]/hl7:text)=1"
			>ERRORE-b12| Sezione Riferimento a invito precedente: la sezione DEVE contenere un elemento text.</assert>
		
			<assert test="count(hl7:component/hl7:section/hl7:code[@code='55107-7'])=0 or count(hl7:component/hl7:section[hl7:code[@code='55107-7']]/hl7:entry)>=1"
			>ERRORE-b13| Sezione Riferimento a invito precedente: la sezione DEVE contenere almeno una entry.</assert>
			
		</rule>
		
		<!--2-->
		<!-- Controlli sull'entryRelationship -->
		
		
			<!--2-->
		<!-- Controlli sull'Act della sezione riferimento ad invito precedente -->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='55107-7']]/hl7:entry/hl7:act">
			<let name="codice" value="hl7:code/@code"/>
			<assert test="count(hl7:code[@code='55107-7'][@codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b14| Il codice '<value-of select="$codice"/>' non è corretto. L'elemento act/code DEVE avere l'attributo @code valorizzato con il seguente codice '55107-7' Sezione Riferimento a invito precedente e il codesystem valorizzatocon '2.16.840.1.113883.6.1'.</assert>
			
			<assert test="count(hl7:reference)=1"
			>ERRORE-b15|Sezione Riferimento a lettera invito precedente: All'interno della entry/act l'elemento reference DEVE essere presente.</assert>
			
			<assert test="count(hl7:reference/hl7:externalDocument/hl7:id)=1"
			>ERRORE-b16|Sezione Riferimento a lettera invito precedente: All'interno della entry/act/reference/externalDocument l'elemento id DEVE essere presente</assert>
			
			<assert test="count(hl7:templateId)=0 or count(hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.677'])=1"
			>ERRORE-b17| Sezione Riferimento a lettera invito precedente: La sezione, se presente, può contenere l'elemento templateId con l' attributo @root valorizzato con il seguente OID "2.16.840.1.113883.3.1937.777.63.10.677".</assert>
		</rule>
		
		<!--Controllo sui codici delle sezioni-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.676']]">
			<let name="codice" value="hl7:code/@code"/>
			<assert test="count(hl7:code[@code='55107-7'][@codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b18| Il codice '<value-of select="$codice"/>' non è corretto. L'elemento code DEVE avere l'attributo @code valorizzato con il seguente codice:
			55107-7	Sezione Riferimento a invito precedente.
			</assert>
		</rule>
	
					
	</pattern>
</schema>