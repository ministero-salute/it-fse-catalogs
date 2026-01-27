<?xml version="1.0" encoding="UTF-8"?>
<!-- schematron versione: 1.0-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" 
		xmlns:cda="urn:hl7-org:v3"
        xmlns:iso="http://purl.oclc.org/dsdl/schematron"
        xmlns:sch="http://www.ascc.net/xml/schematron"
        queryBinding="xslt2">
	<title>Schematron Cartella Clinica </title>
	<ns prefix="hl7" uri="urn:hl7-org:v3"/>
	<ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
	<pattern id="all">


<!--_______________________________________________________________HEADER _____________________________________________________________-->
	
		<!-- ClinicalDocument -->
		<rule context="hl7:ClinicalDocument">
	        <!--Controllo realmCode-->
			<assert test="count(hl7:realmCode)>=1"
			>ERRORE-1| L'elemento <name/> DEVE avere almeno un elemento 'realmCode'.</assert>
			
			<assert test="count(hl7:realmCode[@code='IT'])= 1"
			>ERRORE-2| L'elemento <name/>/realmCode DEVE avere l'attributo @code valorizzato con 'IT'.</assert>
			
			<!--Controllo templateId-->
			<let name="num_tid" value="count(hl7:templateId)"/>
			<assert test="$num_tid >= 1"
			>ERRORE-3| L'elemento <name/> DEVE avere almeno un elemento di tipo 'templateId'.</assert>
			
			<assert test="count(hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.18.1'])= 1 and count(hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.18.1']/@extension)= 1" 
			>ERRORE-4| Almeno un elemento <name/>/templateId DEVE essere valorizzato attraverso l'attributo @root='2.16.840.1.113883.2.9.10.1.18.1' (id del template nazionale), associato all'attributo @extension che  indica la versione a cui il templateId fa riferimento. </assert>

			<!--Controllo code-->
			<assert test="count(hl7:code[@code='100971-1'][@codeSystem='2.16.840.1.113883.6.1'])=1" 
			>ERRORE-5| Almeno un elemento <name/>/code DEVE essere valorizzato attraverso l'attributo @code='100971-1' e @codeSystem='2.16.840.1.113883.6.1'. </assert>
			
			<!--Warning title-->
			<assert test="hl7:title='Cartella Clinica'"
			>W001| L'elemento title specifica dovrebbe essere valorizzato a “Cartella Clinica".</assert>
			
			<!--Controllo confidentialityCode-->
			<assert test="(count(hl7:confidentialityCode[@code='N'][@codeSystem='2.16.840.1.113883.5.25'])= 1) or 
			(count(hl7:confidentialityCode[@code='V'][@codeSystem='2.16.840.1.113883.5.25'])= 1) or (count(hl7:confidentialityCode[@code='R'][@codeSystem='2.16.840.1.113883.5.25'])= 1)"
			>ERRORE-6| L'elemento <name/>/confidentialityCode DEVE avere l'attributo @code valorizzato con 'N' o 'R' o 'V', e il @codeSystem='2.16.840.1.113883.5.25'. </assert>
			
			
			<!--Controllo incrociato tra setId-versionNumber e relatedDocument-->
			<let name="versionNumber" value="hl7:versionNumber/@value"/>
			<assert test="(string(number($versionNumber)) = 'NaN') or
					($versionNumber= '1' and count(hl7:setId)=0) or 
					($versionNumber= '1' and hl7:id/@root = hl7:setId/@root and hl7:id/@extension = hl7:setId/@extension) or
					($versionNumber!= '1' and hl7:id/@root = hl7:setId/@root and hl7:id/@extension != hl7:setId/@extension) or
					(hl7:id/@root != hl7:setId/@root)"
			>ERRORE-7| Se ClinicalDocument.id e ClinicalDocument.setId usano lo stesso dominio di identificazione (@root identico) allora l’attributo @extension del ClinicalDocument.id 
			deve essere diverso da quello del ClinicalDocument.setId a meno che ClinicalDocument.versionNumber non sia uguale ad 1; cioè i valori di setId ed id per un documento clinico coincidono solo per la prima versione di un documento. </assert>

			
			<assert test="(string(number($versionNumber)) ='NaN') or
						  ($versionNumber=1)  or 
						  (($versionNumber &gt;1) and count(hl7:relatedDocument)&gt;=1 and count(hl7:relatedDocument)&lt;=2)"
			>ERRORE-8| Se l'attributo <name/>/versionNumber/@value è maggiore di  1, l'elemento <name/> deve contenere al più due elementi di tipo 'relatedDocument'.</assert>
			
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
			>ERRORE-10| L'elemento <name/>/recordTarget/patientRole/id  deve avere l'attributo @root valorizzato tramite uno dei seguenti identificatori Nazionali:
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

			>ERRORE-11| Nel caso di Soggetti assicurati da istituzioni estere, devono essere riportati almeno due elementi di tipo 'id' contenenti:
				- 2.16.840.1.113883.2.9.4.3.7: Il numero di identificazione della Tessera TEAM (Tessera Europea di Assicurazione Malattia),
				- 2.16.840.1.113883.2.9.4.3.3: Il numero di identificazione Personale TEAM.
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

			>ERRORE-12| Nel caso di Stranieri Temporaneamente Presenti, l'elemento <name/>/recordTarget/patientRole/id  deve avere l'attributo @root valorizzato tramite un identificativo STP.</assert>
			
			
			<!--Controllo recordTarget/patientRole/patient/name-->
			<let name="patient" value="hl7:recordTarget/hl7:patientRole/hl7:patient"/>
			
			<assert test="count($patient)=1"
			>ERRORE-13| L'elemento <name/>/recordTaget/patientRole DEVE contenere l'elemento 'patient'.</assert>
			
			<assert test="count($patient)=0 or count($patient/hl7:name)=1"
			>ERRORE-14| L'elemento <name/>/recordTaget/patientRole/patient DEVE contenere l'elemento 'name'.</assert>
			
			<assert test="count($patient)=0 or (count($patient/hl7:name/hl7:given)=1 and count($patient/hl7:name/hl7:family)=1)"
			>ERRORE-15| L'elemento <name/>/recordTaget/patientRole/patient/name DEVE riportare gli elementi 'given' e 'family'. </assert>
			
			<!--Controllo recordTarget/patientRole/patient/administrativeGenderCode-->
			<let name="genderOID" value="hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:administrativeGenderCode/@codeSystem"/>
			
			<assert test="count($patient)=0 or count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:administrativeGenderCode)=1"
			>ERRORE-16| L'elemento <name/>/recordTarget/patientRole/patient DEVE contenere l'elemento 'administrativeGenderCode'. </assert>
			
			<assert test="count($patient)=0 or $genderOID='2.16.840.1.113883.5.1'"
			>ERRORE-17| L'OID assegnato all'attributo <name/>/recordTarget/patientRole/patient/administrativeGenderCode/@codeSystem='<value-of select="$genderOID"/>' non è corretto. L'attributo DEVE essere valorizzato con '2.16.840.1.113883.5.1'. </assert>
			
			<!--Controllo recordTarget/patientRole/patient/birthTime-->
			<assert test="count($patient)=0 or
			count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthTime)=1"
			>ERRORE-18| L'elemento <name/>/recordTaget/patientRole/patient DEVE riportare un elemento 'birthTime'. Qualora non si possa risalire al dato, è possibile valorizzare l'elemento con @nullFlavor="UNK". </assert>	
			
			
			<!--Controllo recordTarget/patientRole/patient/birthplace-->
			<assert test="count($patient)=0 or count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthplace)=1"
			>ERRORE-19| L'elemento <name/>/recordTarget/patientRole/patient DEVE contenere un elemento 'birthplace'.</assert>
			
			<!--Controllo recordTarget/patientRole/patient/birthplace/place/addr-->
			<assert test="count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthplace)=0 or 
			count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthplace/hl7:place/hl7:addr/hl7:country)=1"
			>ERRORE-20| L'elemento <name/>/recordTarget/patientRole/patient/birthplace DEVE contenere un elemento place/addr/country. </assert>	
			
			<!--Controllo recordTarget/patientRole/patient/guardian/guardianPerson/name-->
			<assert test="count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:guardian/hl7:guardianPerson)=0 or 
			(count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:guardian/hl7:guardianPerson/hl7:name/hl7:given)=1 and count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:guardian/hl7:guardianPerson/hl7:name/hl7:family)=1)"
			>ERRORE-21| L'elemento <name/>recordTarget/patientRole/patient/guardian/guardianPerson DEVE contenere gli elementi given e family. </assert>	
			
			<!--Controllo custodian/assignedCustodian/name-->
			<assert test="count(hl7:custodian/hl7:assignedCustodian/hl7:representedCustodianOrganization/hl7:name)=1"
			>ERRORE-22| L'elemento <name/>/custodian/assignedCustodian/representedCustodianOrganization deve contenere un elemento 'name'.</assert>
			
			<!--Controllo custodian/assignedCustodian/addr-->
			<let name="num_addr_cust" value="count(hl7:custodian/hl7:assignedCustodian/hl7:representedCustodianOrganization/hl7:addr)"/>
			<let name="addr_cust" value="hl7:custodian/hl7:assignedCustodian/hl7:representedCustodianOrganization/hl7:addr"/>
			<assert test="$num_addr_cust=0 or (count($addr_cust/hl7:country)=$num_addr_cust and
			count($addr_cust/hl7:city)=$num_addr_cust and 
			count($addr_cust/hl7:streetAddressLine)=$num_addr_cust)"
			>ERRORE-23| L'elemento <name/>/custodian/assignedCustodian/representedCustodianOrganization/addr DEVE riportare i sotto-elementi 'country','city' e 'streetAddressLine'.</assert>
			
			 <!--Controllo legalAuthenticator-->
			<assert test = "count(hl7:legalAuthenticator/hl7:signatureCode)=1" 
			>ERRORE-24| L'elemento <name/>/legalAuthenticator/signatureCode deve essere valorizzato. </assert>
			
			<assert test = "count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:id)>=1"
			>ERRORE-25| L'elemento <name/>/legalAuthenticator/assignedEntity DEVE contenere almeno un elemento id valorizzato con uno dei seguenti OID:
			- @root='2.16.840.1.113883.2.9.4.3.2' (CF)</assert>
			
			<assert test = "count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=1 "
			>ERRORE-26| L'elemento <name/>/legalAuthenticator/assignedEntity DEVE contenere almeno un elemento id valorizzato con uno dei seguenti OID:
			- @root='2.16.840.1.113883.2.9.4.3.2' (CF)</assert>
			
			<!--Controllo legalAuthenticator/assignedEntity/addr-->
			<let name="num_addr_LA" value="count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:addr)"/>
			<let name="addr_LA" value="hl7:legalAuthenticator/hl7:assignedEntity/hl7:addr"/>
			<assert test="$num_addr_LA=0 or (count($addr_LA/hl7:country)=$num_addr_LA and
			count($addr_LA/hl7:city)=$num_addr_LA and 
			count($addr_LA/hl7:streetAddressLine)=$num_addr_LA)"
			>ERRORE-27| L'elemento <name/>/legalAuthenticator/assignedEntity/addr DEVE riportare i sotto-elementi 'country','city' e 'streetAddressLine'. </assert>
			
			<assert test = "count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:assignedPerson/hl7:name)=1"
			>ERRORE-28| L'elemento <name/>/legalAuthenticator/assignedEntity/assignedPerson DEVE contenere l'elemento 'name'.</assert>
			
			<assert test = " (count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:assignedPerson/hl7:name/hl7:family)=1 and 
			count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:assignedPerson/hl7:name/hl7:given)=1)"
			>ERRORE-29| L'elemento <name/>/legalAuthenticator/assignedEntity/assignedPerson/name DEVE riportare gli elementi 'given' e 'family'.</assert>
							
			 <!--relatedDocument-->
			<assert test="(count(hl7:relatedDocument)&lt;2 or (count(hl7:relatedDocument[@typeCode='XFRM'])=1 and (count(hl7:relatedDocument[@typeCode='RPLC'])=1 or count(hl7:relatedDocument[@typeCode='APND'])=1)))"
			>ERRORE-30| Un documento CDA2 conforme può avere o un relatedDocument con @typeCode='APND' | 'RPLC' | 'XFRM'; oppure una combinazione di due relatedDocument con la seguente composizione:
			- @typeCode='XFRM' e @typeCode='RPLC'; 
			- @typeCode='XFRM' e @typeCode='APND'.</assert>	

			<!--Controllo componentOf-->
			<assert test="count(hl7:componentOf)=1"
			>ERRORE-31| L'elemento <name/>/componentOf è obbligatorio. </assert>
			
			<assert test="count(hl7:componentOf)=0 or count(hl7:componentOf/hl7:encompassingEncounter/hl7:id)=1"
			>ERRORE-32| L'elemento <name/>/componentOf/encompassingEncounter/id DEVE essere presente. </assert>
			
			<assert test="count(hl7:componentOf)=0 or count(hl7:componentOf/hl7:encompassingEncounter/hl7:location/hl7:healthCareFacility/hl7:id[@root='2.16.840.1.113883.2.9.4.1.6'])>=1"
			>ERRORE-32a| L'elemento <name/>/componentOf/encompassingEncounter DEVE contenere un elemento location/healthCareFacility che DEVE avere almeno un elemento id con @root=2.16.840.1.113883.2.9.4.1.6. </assert>
			
			<assert test="count(hl7:componentOf)=0 or count(hl7:componentOf/hl7:encompassingEncounter/hl7:location)=0 or count(hl7:componentOf/hl7:encompassingEncounter/hl7:location/hl7:healthCareFacility/hl7:serviceProviderOrganization/hl7:id[@root='2.16.840.1.113883.2.9.4.1.2'])=1"
			>ERRORE-32b| L'elemento <name/>/componentOf/encompassingEncounter/location/healthCareFacility  DEVE contenere l'elemento serviceProviderOrganization che DEVE avere un elemento id con @root= 2.16.840.1.113883.2.9.4.1.2 </assert>
			
			
		</rule>
		
		<!-- Controllo author-->
		<rule context="hl7:ClinicalDocument/hl7:author">
		
			<!--Controllo author/assignedAuthor/id-->
			<assert test="count(hl7:assignedAuthor/hl7:id)>=1
			and (count(hl7:assignedAuthor/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=1 and count(hl7:assignedAuthor/hl7:id[@nullFlavor])=0) "	
			>ERRORE-33| L'elemento <name/>/assignedAuthor DEVE contenere almeno un elemento id. L'autore del documento può essere identificato tramite il codice fiscale root='2.16.840.1.113883.2.9.4.3.2, oppure, nel caso in cui l’autore coincide con un dispositivo che genera il documento, è possibile valorizzare l’elemento attraverso il @nullFlavor.
			</assert>
			
			<!--Controllo author/assignedAuthor/assignedPerson/name-->
			<let name="name_author" value="hl7:assignedAuthor/hl7:assignedPerson"/>
			
			<assert test="count($name_author)=0 or count($name_author/hl7:name)=1"
			>ERRORE-34| L'elemento <name/>/assignedAuthor/assignedPerson DEVE avere l'elemento 'name'. </assert>
			
			<assert test="count($name_author/hl7:name)=0 or (count($name_author/hl7:name/hl7:given)=1 and count($name_author/hl7:name/hl7:family)=1)"
			>ERRORE-35| L'elemento <name/>/assignedAuthor/assignedPerson/name DEVE avere gli elementi 'given' e 'family'.</assert>
		
		</rule>
		
<!--____________________________________________________CONTROLLI GENERICI_________________________________________________________________-->
	
		<!--Controllo use Telecom-->
		<rule context="//hl7:telecom">
			<assert test="(count(@use)=1)"
			>ERRORE-36| L’elemento 'telecom' DEVE contenere l'attributo @use. </assert>
		</rule>	
		<rule context="//*[contains(local-name(), 'Organization')][hl7:telecom]">
			<assert test="not(hl7:telecom/@use='H' or hl7:telecom/@use='HP' or hl7:telecom/@use='HV')"
			>ERRORE-37| L'elemento telecom di un'organizzazione non può essere di tipo Home, ovvero l'attributo @use deve essere diverso da: H | HP | HV.
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
		
		<rule context="//hl7:code">
		<assert test="@code and @codeSystem"
		>ERRORE-46| L'elemento 'code' deve avere gli attributi @code e @codeSystem valorizzati.</assert>
		</rule>
		
		<rule context="//hl7:id [not(
						ancestor::hl7:author
					)]">
		<assert test="@root and @extension"
		>ERRORE-47| L'elemento 'id' deve contenere gli attributi @root ed @extension valorizzati.</assert>
		</rule>

		
<!--__________________________________________________BODY__________________________________________________________________________-->
		
		<!--Controlli sulla sezione obbligatoria-->
		
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody">			
			<!--1-->
			<!--Sezione: Riferimento al Documento-->
			<assert test="count(hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.848']])=0 or 
			count(hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.848']]/hl7:entry)>=1"
			>ERRORE-b1| Sezione Riferimento al Documento: la sezione DEVE contenere almeno un elemento 'entry'.</assert>
			
			<!--2-->
			<!--Sezione: Accertamento Assistenziale-->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='47039-3']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='47039-3']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.851'])=1"
			>ERRORE-b2| Sezione Accertamento Assistenziale: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.851'.</assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='47039-3']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='47039-3']]/hl7:text)=1"
			>ERRORE-b3| Sezione Accertamento Assistenziale: la sezione DEVE contenere l'elemento 'text'.</assert>
			
			<!--3-->
			<!--Sezione: Allergie e Intolleranze-->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='48765-2']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='48765-2']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.852'])=1"
			>ERRORE-b4| Sezione Allergie e Intolleranze: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.852'. </assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='48765-2']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='48765-2']]/hl7:text)=1"
			>ERRORE-b5| Sezione Allergie e Intolleranze: la sezione DEVE contenere l'elemento 'text'.</assert>
			
			<!--4-->
			<!--Sezione: Processo Terapeutico-->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='84172-6']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='84172-6']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.853'])=1"
			>ERRORE-b6| Sezione Processo Terapeutico: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.853'. </assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='84172-6']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='84172-6']]/hl7:text)=1"
			>ERRORE-b7| Sezione Processo Terapeutico: la sezione DEVE contenere l'elemento 'text'. </assert>
			
			<!--5-->
			<!--Sezione: Parametri-->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='8716-3']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='8716-3']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.854'])=1"
			>ERRORE-b8| Sezione Parametri: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.854'.</assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='8716-3']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='8716-3']]/hl7:text)=1"
			>ERRORE-b9| Sezione Parametri : la sezione DEVE contenere l'elemento 'text'. </assert>
			
			<!--6-->
			<!--Sezione: Piano riabilitativo individuale PRI -->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='83734-4']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='83734-4']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.855'])=1"
			>ERRORE-b10| Sezione Piano riabilitativo individuale: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.855'. </assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='83734-4']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='83734-4']]/hl7:text)=1"
			>ERRORE-b11| Sezione Piano riabilitativo individuale: la sezione DEVE contenere l'elemento 'text'.</assert>
			
			<!--7-->
			<!--Sezione: Piano assistenziale individuale -->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='101541-1']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='101541-1']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.856'])=1"
			>ERRORE-b12| Sezione Piano assistenziale individuale: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.856'. </assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='101541-1']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='101541-1']]/hl7:text)=1"
			>ERRORE-b13| Sezione Piano assistenziale individuale: la sezione DEVE contenere l'elemento 'text'. </assert>
			
			<!--8-->
			<!--Sezione: Consensi -->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='59284-0']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='59284-0']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.865'])=1"
			>ERRORE-b14| Sezione Consensi: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.865'.</assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='59284-0']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='59284-0']]/hl7:text)=1"
			>ERRORE-b15| Sezione Consensi: la sezione DEVE contenere l'elemento 'text'. </assert>
			
			<!--9-->
			<!--Sezione: Richieste -->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='11487-6']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='11487-6']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.857'])=1"
			>ERRORE-b16| Sezione Richieste: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.857'. </assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='11487-6']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='11487-6']]/hl7:text)=1"
			>ERRORE-b17| Sezione Richieste: la sezione DEVE contenere l'elemento 'text'.</assert>
			
			<!--10-->
			<!--Sezione: Diario Clinico Assistenziale -->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='11506-3']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='11506-3']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.849'])=1"
			>ERRORE-b18| Sezione Diario Clinico Assistenziale: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.849'</assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='11506-3']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='11506-3']]/hl7:text)=1"
			>ERRORE-b19| Sezione Diario Clinico Assistenziale: la sezione DEVE contenere l'elemento 'text'.</assert>
			
			<!--11-->
			<!--Sezione: Documentazione di dispositivi impiantati o utilizzati -->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='108277-5']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='108277-5']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.847'])=1"
			>ERRORE-20| Sezione Documentazione di dispositivi impiantati o utilizzati: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.847'.</assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='108277-5']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='108277-5']]/hl7:text)=1"
			>ERRORE-b21| Sezione Documentazione di dispositivi impiantati o utilizzati: la sezione DEVE contenere l'elemento 'text'.</assert>
			
			<!--12-->
			<!--Sezione: Lesioni e ferite -->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='46215-0']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='46215-0']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.846'])=1"
			>ERRORE-b22| Sezione Lesioni e ferite: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.846'.</assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='46215-0']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='46215-0']]/hl7:text)=1"
			>ERRORE-b23| Sezione Lesioni e ferite: la sezione DEVE contenere l'elemento 'text'.</assert>
			
			<!--13-->
			<!--Sezione: Scale e altri strumenti di valutazione e monitoraggio  -->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='51848-0']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='51848-0']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.845'])=1"
			>ERRORE-b24| Sezione Scale e altri strumenti di valutazione e monitoraggio: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.845'.</assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='51848-0']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='51848-0']]/hl7:text)=1"
			>ERRORE-b25| Sezione Scale e altri strumenti di valutazione e monitoraggio: la sezione DEVE contenere l'elemento 'text'.</assert>
			
			<!--14-->
			<!--Sezione: Provvedimento contenitivo e/o di altra natura  -->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='70007-0']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='70007-0']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.843'])=1"
			>ERRORE-b26| Sezione Provvedimento contenitivo e/o di altra natura: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.843'.</assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='70007-0']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='70007-0']]/hl7:text)=1"
			>ERRORE-b27| Sezione Provvedimento contenitivo e/o di altra natura: la sezione DEVE contenere l'elemento 'text'. </assert>
			
			<!--15-->
			<!--Sezione: Pianificazione assistenziale  -->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='80754-5']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='80754-5']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.842'])=1"
			>ERRORE-b28| Sezione Pianificazione assistenziale: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.842'. </assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='80754-5']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='80754-5']]/hl7:text)=1"
			>ERRORE-b29| Sezione Pianificazione assistenziale: la sezione DEVE contenere l'elemento 'text'. </assert>
			
			<!--16-->
			<!--Documentazione anestesiologica  -->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='34750-0']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='34750-0']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.841'])=1"
			>ERRORE-b30| Sezione Documentazione anestesiologica: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.841'.</assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='34750-0']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='34750-0']]/hl7:text)=1"
			>ERRORE-b31| Sezione Documentazione anestesiologica: la sezione DEVE contenere l'elemento 'text'. </assert>
			
			<!--17-->
			<!--Documentazione relativa ad interventi chirurgici e Proc interventistiche  -->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='34848-2']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='34848-2']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.864'])=1"
			>ERRORE-b32| Sezione Documentazione relativa ad interventi chirurgici e Proc interventistiche: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.864'.</assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='34848-2']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='34848-2']]/hl7:text)=1"
			>ERRORE-b33| Sezione Documentazione relativa ad interventi chirurgici e Proc interventistiche: la sezione DEVE contenere l'elemento 'text'.</assert>
			
			<!--18-->
			<!--Documentazione relativa all'evento parto  -->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='15508-5']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='15508-5']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.863'])=1"
			>ERRORE-b34| Sezione Documentazione relativa all'evento parto: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.863'. </assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='15508-5']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='15508-5']]/hl7:text)=1"
			>ERRORE-b35| Sezione Documentazione relativa all'evento parto: la sezione DEVE contenere l'elemento 'text'.</assert>
			
			<!--19-->
			<!--Trasferimento  -->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='104920-4']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='104920-4']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.862'])=1"
			>ERRORE-b36| Sezione Trasferimento: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.862'.</assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='104920-4']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='104920-4']]/hl7:text)=1"
			>ERRORE-b37| Sezione Trasferimento: la sezione DEVE contenere l'elemento 'text'.</assert>
			
			<!--20-->
			<!--Dimissione -->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='8650-4']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='8650-4']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.861'])=1"
			>ERRORE-b38| Sezione Dimissione: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.861'.</assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='8650-4']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='8650-4']]/hl7:text)=1"
			>ERRORE-b39| Sezione Dimissione: la sezione DEVE contenere l'elemento 'text'.</assert>
			
			<!--21-->
			<!--Documento di dimissione di altre professioni sanitarie-->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='68674-1']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='68674-1']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.860'])=1"
			>ERRORE-b40| Sezione Documento di dimissione di altre professioni sanitarie: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.860'.</assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='68674-1']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='68674-1']]/hl7:text)=1"
			>ERRORE-b41| Sezione Documento di dimissione di altre professioni sanitarie: la sezione DEVE contenere l'elemento 'text'.</assert>
			
		</rule>
		<!--Controllo sui codici delle sezioni-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section">		
			<let name="codice" value="hl7:code/@code"/>
			<assert test="count(hl7:code[@code='47039-3'][@codeSystem='2.16.840.1.113883.6.1'])=1 or
			count(hl7:code[@code='67851-6'][@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:code[@code='48765-2'][@codeSystem='2.16.840.1.113883.6.1'])=1 
			or count(hl7:code[@code='84172-6'][@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:code[@code='8716-3'][@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:code[@code='83734-4'][@codeSystem='2.16.840.1.113883.6.1'])=1 
			or count(hl7:code[@code='101541-1'][@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:code[@code='59284-0'][@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:code[@code='11487-6'][@codeSystem='2.16.840.1.113883.6.1'])=1  
			or count(hl7:code[@code='11506-3'][@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:code[@code='108277-5'][@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:code[@code='46215-0'][@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:code[@code='51848-0'][@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:code[@code='70007-0'][@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:code[@code='80754-5'][@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:code[@code='34750-0'][@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:code[@code='34848-2'][@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:code[@code='15508-5'][@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:code[@code='104920-4'][@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:code[@code='8650-4'][@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:code[@code='68674-1'][@codeSystem='2.16.840.1.113883.6.1'])=1 or
			((count(hl7:code[@code='11502-2'][@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:code[@code='11488-4'][@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:code[@code='57832-8'][@codeSystem='2.16.840.1.113883.6.1'])=1 
			or count(hl7:code[@code='59258-4'][@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:code[@code='81223-0'][@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:code[@code='57833-6'][@codeSystem='2.16.840.1.113883.6.1'])=1 
			or count(hl7:code[@code='60593-1'][@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:code[@code='87273-9'][@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:code[@code='68604-8'][@codeSystem='2.16.840.1.113883.6.1'])=1  
			or count(hl7:code[@code='101881-1'][@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:code[@code='34105-7'][@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:code[@code='11526-1'][@codeSystem='2.16.840.1.113883.6.1'])=1) and count(hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.848'])=1) 
			"
			>ERRORE-b42| Il codice '<value-of select="$codice"/>' non è corretto. La sezione deve essere valorizzata con uno dei seguenti codici:

			|47039-3	Sezione Inquadramento Clinico
			|67851-6	Sezione Accertamento Assistenziale
			|48765-2	Sezione Allergie e Intolleranze
			|84172-6	Sezione Processo Terapeutico
			|8716-3	Sezione Parametri
			|83734-4	Sezione Piano Riabilitativo Individuale (PRI)
			|101541-1 Sezione Piano Assistenziale Individuale (PAI)
			|59284-0 Sezione Consensi
			|11487-6	Sezione Richieste
			|11506-3	Sezione Diario Clinico Assistenziale
			|108277-5 Sezione Documentazione di Dispositivi Impiantati o Utilizzati 
			|46215-0 Sezione Lesioni e Ferite
			|51848-0 Sezione Scale e altri Strumenti di Valutazione e Monitoraggio
			|70007-0 Sezione Provvedimento contenitivo e/o di Altra Natura	
			|80754-5 Sezione Pianificazione Assistenziale
			|34750-0 Sezione Documentazione Anestesiologica
			|34848-2 Sezione Documentazione Relativa a Interventi Chirurgici e Proc. Interventistica
			|15508-5 Sezione Documentazione Relativa all'evento Parto
			|104920-4 Sezione Trasferimento
			|8650-4 Sezione Dimissione
			|68674-1 Sezione Documento di Dimissione di Altre Professioni Sanitarie
			
			Per la Sezione Riferimento al Documento, utilizzare il templateId "2.16.840.1.113883.3.1937.777.63.10.848" e uno dei seguenti Codici:
			
			|11502-2	Referto di Laboratorio
			|11488-4	Nota di Consulto (RSA)
			|57832-8	Prescrizione Specialistica
			|59258-4	Verbale di Pronto Soccorso
			|81223-0	Erogazione Specialistica
			|57833-6	Prescrizione Farmaceutica
			|60593-1	Erogazione Farmaceutica
			|87273-9 Scheda di Singola Vaccinazione
			|68604-8	Referto di Radiologia (RAD)
			|101881-1 Tessera Portatore di Impianto (TPI)
			|34105-7 Lettera di Dimissione Ospedaliera (LDO)
			|11526-1 Referto di Anatoimia Patologica (RAP)
			</assert>
			
		</rule>
		
		
		<!--1-->
		
			<!--Sezione: Riferimento al Documento/entry-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.848']]/hl7:entry">
			<assert test="count(hl7:act/hl7:templateId)=0 or 
			count(hl7:act/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.850'])=1"
			>ERRORE-b44| Sezione Riferimento al Documento: entry/act/templateId se presente, DEVE essere valorizzato con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.850'.</assert>
			
			<assert test="count(hl7:act/hl7:code[@code='55107-7'][@codeSystem='2.16.840.1.113883.6.1'])=1 "
			>ERRORE-b45| Sezione Riferimento al Documento: entry/act/code DEVE essere valorizzato con code='55107-7' e @codeSystem='2.16.840.1.113883.6.1'.</assert>
			
			<assert test="count(hl7:act/hl7:reference/hl7:externalDocument/hl7:id[@root and @extension])=1"
			>ERRORE-b46| Sezione Riferimento al Documento: entry/act/reference/externalDocument/id DEVE essere presente valorizzando gli attributi @root e @extension.</assert>
		
		</rule>
		
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section/hl7:author">
			
			<assert test="count(hl7:assignedAuthor/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=1"
			>ERRORE-b47| L'elemento <name/>/assignedAuthor DEVE contenere almeno un elemento id valorizzato con il seguente OID @root='2.16.840.1.113883.2.9.4.3.2'.
			</assert>
			
			<!--Controllo author/assignedAuthor/assignedPerson/name-->
			<let name="name_author" value="hl7:assignedAuthor/hl7:assignedPerson"/>
			
			<assert test="count($name_author)=0 or count($name_author/hl7:name)=1"
			>ERRORE-b48| L'elemento <name/>/assignedAuthor/assignedPerson DEVE avere l'elemento 'name'. </assert>
			
			<assert test="count($name_author/hl7:name)=0 or (count($name_author/hl7:name/hl7:given)=1 and count($name_author/hl7:name/hl7:family)=1)"
			>ERRORE-b49| L'elemento <name/>/assignedAuthor/assignedPerson/name DEVE avere gli elementi 'given' e 'family'.</assert>
		</rule>
		
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section/hl7:entry">
			
			<assert test="count(hl7:observationMedia/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.866'])=1"
			>ERRORE-b50| L'elemento <name/>/observationMedia DEVE contenere almeno un elemento TemplateId valorizzato con la seguente  @root='2.16.840.1.113883.3.1937.777.63.10.866'.
			</assert>
			
			<assert test="count(hl7:observationMedia/hl7:value)=1"
			>ERRORE-b51| L'elemento <name/>/observationMedia DEVE contenere almeno un elemento 'value'.
			</assert>
			
		</rule>
		
		
	</pattern>
</schema>