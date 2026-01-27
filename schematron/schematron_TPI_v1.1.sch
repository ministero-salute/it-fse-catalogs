<?xml version="1.0" encoding="UTF-8"?>
<!-- schematron versione: 1.1-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" 
		xmlns:cda="urn:hl7-org:v3"
        xmlns:iso="http://purl.oclc.org/dsdl/schematron"
        xmlns:sch="http://www.ascc.net/xml/schematron"
        queryBinding="xslt2">
	<title>Schematron Tessera Portatore Di Impianto 1.1 </title>
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
			<assert test="count(hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.17.1'])= 1 and count(hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.17.1']/@extension)= 1" 
			>ERRORE-4| Almeno un elemento <name/>/templateId DEVE essere valorizzato attraverso l'attributo @root='2.16.840.1.113883.2.9.10.1.17.1' (id del template nazionale), associato all'attributo @extension che  indica la versione a cui il templateId fa riferimento</assert>


			<assert test="count(hl7:code[@code='101881-1'][@codeSystem='2.16.840.1.113883.6.1'])=1" 
			>ERRORE-5| Almeno un elemento <name/>/code DEVE essere valorizzato attraverso l'attributo @code='101881-1' e @codeSystem='2.16.840.1.113883.6.1'</assert>
			
			<!--Warning title-->
			<assert test="hl7:title='Tessera Portatore di Impianto'"
			>W001| L'elemento title specifica dovrebbe essere valorizzato a “Tessera Portatore di Impianto.</assert>
			
			<!--Controllo confidentialityCode-->
			<assert test="(count(hl7:confidentialityCode[@code='N'][@codeSystem='2.16.840.1.113883.5.25'])= 1) or 
			(count(hl7:confidentialityCode[@code='V'][@codeSystem='2.16.840.1.113883.5.25'])= 1) or (count(hl7:confidentialityCode[@code='R'][@codeSystem='2.16.840.1.113883.5.25'])= 1)"
			>ERRORE-6| L'elemento <name/>/confidentialityCode DEVE avere l'attributo @code valorizzato con 'N' o 'R' o 'V', e il @codeSystem='2.16.840.1.113883.5.25'</assert>
			
			
			<!--Controllo incrociato tra setId-versionNumber e relatedDocument-->
			<let name="versionNumber" value="hl7:versionNumber/@value"/>
			<assert test="(string(number($versionNumber)) = 'NaN') or
					($versionNumber= '1' and count(hl7:setId)=0) or 
					($versionNumber= '1' and hl7:id/@root = hl7:setId/@root and hl7:id/@extension = hl7:setId/@extension) or
					($versionNumber!= '1' and hl7:id/@root = hl7:setId/@root and hl7:id/@extension != hl7:setId/@extension) or
					(hl7:id/@root != hl7:setId/@root)"
			>ERRORE-7| Se ClinicalDocument.id e ClinicalDocument.setId usano lo stesso dominio di identificazione (@root identico) allora l’attributo @extension del ClinicalDocument.id 
			deve essere diverso da quello del ClinicalDocument.setId a meno che ClinicalDocument.versionNumber non sia uguale ad 1; cioè i valori di setId ed id per un documento clinico coincidono solo per la prima versione di un documento</assert>

			
			<assert test="(string(number($versionNumber)) ='NaN') or
						  ($versionNumber=1)  or 
						  (($versionNumber &gt;1) and count(hl7:relatedDocument)&gt;=1 and count(hl7:relatedDocument)&lt;=2)"
			>ERRORE-8| Se l'attributo <name/>/versionNumber/@value è maggiore di  1, l'elemento <name/>  deve contenere al più due elementi di tipo 'relatedDocument'.</assert>
			
			<!--Controllo recordTarget-->
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

			>ERRORE-12| Nel caso di Stranieri Temporaneamente Presenti, l'elemento <name/>/recordTarget/patientRole/id  deve avere l'attributo @root valorizzato tramite un identificativo STP.</assert>
			
			
			<!--Controllo recordTarget/patientRole/patient/name-->
			<let name="patient" value="hl7:recordTarget/hl7:patientRole/hl7:patient"/>
			
			<assert test="count($patient)=1"
			>ERRORE-13| L'elemento <name/>/recordTaget/patientRole DEVE contenere l'elemento patient</assert>
			<assert test="count($patient)=0 or count($patient/hl7:name)=1"
			>ERRORE-14| L'elemento <name/>/recordTaget/patientRole/patient DEVE contenere l'elemento 'name'</assert>
			<assert test="count($patient)=0 or (count($patient/hl7:name/hl7:given)=1 and count($patient/hl7:name/hl7:family)=1)"
			>ERRORE-15| L'elemento <name/>/recordTaget/patientRole/patient/name DEVE riportare gli elementi 'given' e 'family'</assert>
			
			<!--Controllo recordTarget/patientRole/patient/administrativeGenderCode-->
			<let name="genderOID" value="hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:administrativeGenderCode/@codeSystem"/>
			
			<assert test="count($patient)=0 or count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:administrativeGenderCode)=1"
			>ERRORE-16| L'elemento <name/>/recordTarget/patientRole/patient DEVE contenere l'elemento administrativeGenderCode </assert>
			
			<assert test="count($patient)=0 or $genderOID='2.16.840.1.113883.5.1'"
			>ERRORE-17| L'OID assegnato all'attributo <name/>/recordTarget/patientRole/patient/administrativeGenderCode/@codeSystem='<value-of select="$genderOID"/>' non è corretto. L'attributo DEVE essere valorizzato con '2.16.840.1.113883.5.1' </assert>
			
			<!--Controllo recordTarget/patientRole/patient/birthTime-->
			<assert test="count($patient)=0 or
			count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthTime)=1"
			>ERRORE-18| L'elemento <name/>/recordTaget/patientRole/patient DEVE riportare un elemento 'birthTime'. Qualora non si possa risalire al dato, è possibile valorizzare l'elemento con @nullFlavor="UNK"</assert>	
			
			
			<!--Controllo recordTarget/patientRole/patient/birthplace-->
			<assert test="count($patient)=0 or count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthplace)=1"
			>ERRORE-19| L'elemento <name/>/recordTarget/patientRole/patient DEVE contenere un elemento birthplace</assert>
			
			<!--Controllo recordTarget/patientRole/patient/birthplace/place/addr-->
			<assert test="count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthplace)=0 or 
			count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthplace/hl7:place/hl7:addr/hl7:country)=1"
			>ERRORE-20| L'elemento <name/>/recordTarget/patientRole/patient/birthplace DEVE contenere un elemento place/addr/country </assert>	
			
			
			 <!--Controllo legalAuthenticator-->
			
			<assert test = "count(hl7:legalAuthenticator)=0 or count(hl7:legalAuthenticator/hl7:signatureCode[@code='S'])=1" 
			>ERRORE-21| L'elemento <name/>/legalAuthenticator/signatureCode deve essere valorizzato con il codice "S" </assert>
			<assert test = "count(hl7:legalAuthenticator)=0 or count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=1 or
					count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:id[@root='2.16.840.1.113883.2.9.6.3.2'])=1"
			>ERRORE-22| L'elemento <name/>/legalAuthenticator/assignedEntity DEVE contenere almeno un elemento id valorizzato con uno dei seguenti OID:
			- @root='2.16.840.1.113883.2.9.4.3.2' (CF)
			- @root='2.16.840.1.113883.2.9.6.3.2' (p.iva)</assert>
			
			<assert test = "count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:assignedPerson)=0 or count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:assignedPerson/hl7:name)=1"
			>ERRORE-23| L'elemento <name/>/legalAuthenticator/assignedEntity/assignedPerson DEVE contenere l'elemento 'name'</assert>
			<assert test = "count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:assignedPerson)=0 or (count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:assignedPerson/hl7:name/hl7:family)=1 and 
			count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:assignedPerson/hl7:name/hl7:given)=1)"
			>ERRORE-24| L'elemento <name/>/legalAuthenticator/assignedEntity/assignedPerson/name DEVE riportare gli elementi 'given' e 'family'</assert>
			
							
			 <!--relatedDocument-->
			<assert test="(count(hl7:relatedDocument)&lt;2 or (count(hl7:relatedDocument[@typeCode='XFRM'])=1 and (count(hl7:relatedDocument[@typeCode='RPLC'])=1 or count(hl7:relatedDocument[@typeCode='APND'])=1)))"
			>ERRORE-25| Un documento CDA2 conforme può avere o un relatedDocument con @typeCode='APND' | 'RPLC' | 'XFRM'; oppure una combinazione di due relatedDocument con la seguente composizione:
			- @typeCode='XFRM' e @typeCode='RPLC'; 
			- @typeCode='XFRM' e @typeCode='APND'.</assert>				
		</rule>
		
		<!-- Controllo author-->
		<rule context="hl7:ClinicalDocument/hl7:author">
		
			<!--Controllo author/assignedAuthor/id-->
			<assert test="count(hl7:assignedAuthor/hl7:id)>=1"
			>ERRORE-26| L'elemento <name/>/assignedAuthor DEVE contenere almeno un elemento id. Qualora l'author è un operatore sanitario allora almeno un elemento id deve essere valorizzato con il codice fiscale.
			</assert>
			
			<!--Controllo author/assignedAuthor/assignedPerson/name-->
			<let name="name_author" value="hl7:assignedAuthor/hl7:assignedPerson"/>
			
			<assert test="count($name_author)=0 or count($name_author/hl7:name)=1"
			>ERRORE-27| L'elemento <name/>/assignedAuthor/assignedPerson DEVE avere l'elemento 'name' </assert>
			<assert test="count($name_author/hl7:name)=0 or (count($name_author/hl7:name/hl7:given)=1 and count($name_author/hl7:name/hl7:family)=1)"
			>ERRORE-28| L'elemento <name/>/assignedAuthor/assignedPerson/name DEVE avere gli elementi 'given' e 'family'</assert>
			
		</rule>
		
<!--____________________________________________________CONTROLLI GENERICI_________________________________________________________________-->
	
		<!--Controllo use Telecom-->
		<rule context="//hl7:telecom">
			<assert test="(count(@use)=1)"
			>ERRORE-29| L’elemento 'telecom' DEVE contenere l'attributo @use </assert>
		</rule>	
		<rule context="//*[contains(local-name(), 'Organization')][hl7:telecom]">
			<assert test="not(hl7:telecom/@use='H' or hl7:telecom/@use='HP' or hl7:telecom/@use='HV')"
			>ERRORE-30| L'elemento telecom di un'organizzazione non può essere di tipo Home, ovvero l'attributo @use deve essere diverso da: H | HP | HV.
			</assert>
		</rule>
		<!-- Controllo formato: -->
		<!--campi Codice Fiscale: 16 cifre [A-Z0-9]{16} -->
		<rule context="//hl7:id[@root='2.16.840.1.113883.2.9.4.3.2']">
			<let name="CF" value="@extension"/>
			<assert test="matches(@extension, '[A-Z0-9]{16}') and string-length($CF)=16"
			>ERRORE-31| Il codice fiscale '<value-of select="$CF"/>' cittadino ed operatore deve essere costituito da 16 cifre [A-Z0-9]{16}</assert>
		</rule>
	
		<!--Controllo sugli attributi di observation-->
		<rule context="//hl7:observation">
			<let name="moodCd" value="@moodCode"/>
			<assert test="count(@classCode)=0 or @classCode='OBS'"
			>ERRORE-32| L'attributo "@classCode" dell'elemento "observation" deve essere valorizzato con "OBS" </assert>
			<assert test="$moodCd='EVN'"
			>ERRORE-33| L'attributo "@moodCode" dell'elemento "observation" deve essere valorizzato con "EVN" </assert>
		</rule>

		<!--Verifica che i codici ActStatusActiveCompletedAborteSuspended utilizzati siano corretti-->
        <rule context="//hl7:statusCode">
            <let name="val_status" value="@code"/>
            <assert test="$val_status='active' or  $val_status='completed' or $val_status='aborted' or $val_status='suspended'"
            >ERRORE 34| Codice ActStatus '<value-of select="$val_status"/>' errato! L'attributo @code deve essere valorizzato con "active", "completed", "aborted", "suspended"
            </assert>
        </rule>

		<rule context="//hl7:name[contains(local-name(..), 'Organization') or (parent::hl7:location)]">
			<assert test="count(hl7:delimiter)=0 and count(hl7:prefix)=0 and count(hl7:suffix)=0"
			>ERRORE-35| L’elemento 'name' di un'organizzazione non deve contenere i sotto elementi 'delimiter', 'prefix', 'suffix'.</assert>
		</rule>

		<rule context="//hl7:name">
			<assert test="count(hl7:delimiter)=0"
			>ERRORE-36| L’elemento 'name' del soggetto non deve contenere il sotto-elemento 'delimiter'.</assert>
		</rule>

		<rule context="//hl7:effectiveTime[hl7:low/@value]">
			<let name="effective_time_low" value="string(hl7:low/@value)"/>
			<let name="effective_time_high" value="string(hl7:high/@value)"/>
			<assert test="count(hl7:high/@value)=0 or ($effective_time_high >= $effective_time_low)"
			>ERRORE-37| Il valore dell'elemento effectiveTime/high : '<value-of select="$effective_time_high"/>'
				deve essere maggione o uguale di quello di effectiveTime/low : '<value-of select="$effective_time_low"/>'.</assert>
		</rule>

		<rule context="//*[contains(local-name(), 'Organization')]/hl7:addr[@use='H' or @use='HP' or @use='HV']">
			<assert test="false()"
			>ERRORE-38| L'indirizzo di un'organizzazione non può essere di tipo Home, ovvero l'attributo @use DEVE essere diverso da: H | HP | HV.
			</assert>
		</rule>

		<rule context="//hl7:originalText[hl7:reference]">
			<assert test="string(hl7:reference/@value)"
			>ERRORE-39| L'elemento originalText/reference/@value DEVE essere valorizzato.</assert>
		</rule>
		
		<rule context="//hl7:code">
		<assert test="@code and @codeSystem"
		>ERRORE-40| L'elemento 'code' deve avere gli attributi @code e @codeSystem valorizzati.</assert>
		</rule>
		<rule context="//hl7:id">
		<assert test="@root and @extension"
		>ERRORE-41| L'elemento 'id' deve contenere gli attributi @root ed @extension valorizzati.</assert>
		</rule>

		
<!--__________________________________________________BODY__________________________________________________________________________-->
		
		<!--Controlli sulla sezione obbligatoria-->
		<!--1-->
		<!--Sezione: Impianto Dispositivo-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody">			
			
			<assert test="count(hl7:component/hl7:section/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.733'])=1"
			>ERRORE-b1| Sezione Impianto Dispositivo: DEVE essere presente un'unica sezione con templateId/@root valorizzato con il seguente OID "2.16.840.1.113883.3.1937.777.63.10.733"</assert>

			<assert test="count(hl7:component/hl7:section/hl7:code[@code='74720-4'][@codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b2| Sezione Impianto Dispositivo: la sezione DEVE essere presente e DEVE contenere un elemento code valorizzato con i seguenti attributi: 	
			@code: "74720-4"
			@codeSystems: "2.16.840.1.113883.6.1" </assert>				
			
			<assert test="count(hl7:component/hl7:section/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.733'])=0 or count(hl7:component/hl7:section[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.733']]/hl7:entry)>=1"
			>ERRORE-b3| Sezione Impianto Dispositivo: la sezione DEVE contenere un elemento entry</assert>
			
			
		</rule>
		
		<!--2-->
		<!-- Controlli Entry: Organizer della sezione Impianto Dispositivo -->

		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='74720-4']]/hl7:entry">
			
			<assert test="count(hl7:organizer[@classCode='CLUSTER'])=1"
			> ERRORE-b4| Sezione Impianto del Dispositivo: l'elemento organizer deve avere l'attributo @classCode='CLUSTER'</assert>
			
			<assert test="count(hl7:organizer/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.757'])=1"
			>ERRORE-b5| Sezione Impianto del Dispositivo: l'elemento entry/organizer/templateID deve avere l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.733'</assert>
			
			<assert test="count(hl7:organizer/hl7:text)=0 or count(hl7:organizer/hl7:text/hl7:reference/@value)=1"
			>ERRORE-b6| Sezione Impianto del Dispositivo: entry/organizer/text DEVE contenere l'elemento reference/@value.</assert>
			
			<assert test="count(hl7:organizer/hl7:component/hl7:supply)>=1"
			>ERRORE-b7| Sezione Impianto del Dispositivo: entry/organizer DEVE contenere almeno un elemento 'component' di tipo 'supply' relativa al "Dettaglio del Dispositivo"</assert>
			
			
			<assert test="count(hl7:organizer/hl7:component/hl7:observation)&lt;=1"
			>ERRORE-b8| Sezione Impianto del Dispositivo: entry/organizer può contenere al più un elemento 'component' di tipo 'observation' relativa alla "Sede Anatomica"</assert>
			
			<assert test="count(hl7:organizer/hl7:component/hl7:observation)=0 or count(hl7:organizer/hl7:component/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.758'])=1"
			>ERRORE-b9| Sezione Impianto del Dispositivo: entry/organizer/component/observation se Presente Deve avere un templateId con @root=2.16.840.1.113883.3.1937.777.63.10.758</assert>
			
			<assert test="count(hl7:organizer/hl7:component/hl7:observation)=0 or count(hl7:organizer/hl7:component/hl7:observation/hl7:code[@code='20228-3' and @codeSystem='2.16.840.1.113883.6.1'])=1 "
			>ERRORE-b10| Sezione Impianto del Dispositivo: entry/organizer/component/observation se Presente Deve avere un code con attributo @code='20228-3' e @codeSystem='2.16.840.1.113883.6.1'(LOINC)</assert>
			
			<assert test="count(hl7:organizer/hl7:component/hl7:observation)=0 or count(hl7:organizer/hl7:component/hl7:observation/hl7:value[@xsi:type='CD'])=1 "
			>ERRORE-b11| Sezione Impianto del Dispositivo: entry/organizer/component/observation se Presente Deve avere un value con attributo @xsi:type='CD'</assert>
			
		</rule>
		
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='74720-4']]/hl7:entry/hl7:organizer/hl7:component/hl7:supply">
				
				<assert test="count(hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.753'])=1"
				>ERRORE-b12| Sezione Impianto del Dispositivo: entry/organizer/component/supply DEVE contenere un elemento 'templateId' valorizzato con @root='2.16.840.1.113883.3.1937.777.63.10.753'</assert>
				
				<assert test="count(hl7:id)=1"
				>ERRORE-b13| Sezione Impianto del Dispositivo: entry/organizer/component/supply DEVE contenere un elemento 'id'</assert>
				
				<assert test="count(hl7:code)=1"
				>ERRORE-b14| Sezione Impianto del Dispositivo: entry/organizer/component/supply DEVE contenere un elemento 'code'</assert>
				
				
				<assert test="count(hl7:statusCode[@code='completed'])=1"
				>ERRORE-b15| Sezione Impianto del Dispositivo: entry/organizer/component/supply DEVE contenere un elemento 'statusCode' valorizzato con @code='	completed'</assert>
				
				<assert test="count(hl7:effectiveTime)=1"
				>ERRORE-b16| Sezione Impianto del Dispositivo: entry/supply DEVE contenere un elemento 'effectiveTime'  </assert>
				
				<assert test="count(hl7:effectiveTime[@xsi:type='IVL_TS']/hl7:low)=1"
				>ERRORE-b17| Sezione Impianto del Dispositivo: entry/supply DEVE contenere un elemento 'effectiveTime' con @xsi:type='IVL_TS', valorizzando l'elemento low indicando la data e ora di impianto del dispositivo. </assert>
				
				<!--3-->
				<!-- Controlli su supply (product/participant) -->
				
				<assert test="count(hl7:product)=1"
				>ERRORE-b18| Sezione Impianto del Dispositivo: l'elemento supply DEVE contenere un elemento di tipo 'product'</assert>
				
				<assert test="count(hl7:product)=0 or count(hl7:product/hl7:manufacturedProduct/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.754'])=1"
				>ERRORE-b19| Sezione Impianto del Dispositivo: l'elemento manufacturedProduct DEVE contenere un elemento 'templateId' valorizzato con @root='2.16.840.1.113883.3.1937.777.63.10.754'</assert>
				
				<!--4-->
				<!--Controlli su manufacturedMaterial-->
				<assert test="count(hl7:product)=0 or count(hl7:product/hl7:manufacturedProduct/hl7:manufacturedMaterial)=1"
				>ERRORE-b20| Sezione Impianto del Dispositivo: l'elemento manufacturedProduct DEVE contenere un elemento manufacturedMaterial</assert>
				
				<assert test="count(hl7:product)=0 or count(hl7:product/hl7:manufacturedProduct/hl7:manufacturedMaterial/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.755'])=1"
				>ERRORE-b21| Sezione Impianto del Dispositivo: l'elemento manufacturedProduct/manufacturedMaterial DEVE contenere un elemento 'templateId' valorizzato con @root='2.16.840.1.113883.3.1937.777.63.10.755'</assert>
				
				<assert test="count(hl7:product)=0 or count(hl7:product/hl7:manufacturedProduct/hl7:manufacturedMaterial/hl7:name)=1"
				>ERRORE-b22| Sezione Impianto del Dispositivo: l'elemento manufacturedProduct/manufacturedMaterial DEVE contenere un elemento name</assert>
				
				<assert test="count(hl7:product)=0 or count(hl7:product/hl7:manufacturedProduct/hl7:manufacturedMaterial/hl7:lotNumberText)=1"
				>ERRORE-b23| Sezione Impianto del Dispositivo: l'elemento manufacturedProduct/manufacturedMaterial DEVE contenere un elemento lotNumberText</assert>
				
				<!--5-->
				<!--Controlli su manufacturerOrganization-->
				
				<assert test="count(hl7:product)=0 or count(hl7:product/hl7:manufacturedProduct/hl7:manufacturerOrganization)=1"
				>ERRORE-b24| Sezione Impianto del Dispositivo: l'elemento manufacturedProduct DEVE contenere un elemento manufacturerOrganization</assert>
				
				<assert test="count(hl7:product)=0 or count(hl7:product/hl7:manufacturedProduct/hl7:manufacturerOrganization/hl7:name)=1"
				>ERRORE-b25| Sezione Impianto del Dispositivo: l'elemento manufacturerOrganization DEVE contenere un elemento name indicando il nome del fabbricante del dispositivo </assert>
				
				<assert test="count(hl7:product)=0 or count(hl7:product/hl7:manufacturedProduct/hl7:manufacturerOrganization/hl7:telecom[@use])=1"
				>ERRORE-b26| Sezione Impianto del Dispositivo: l'elemento manufacturerOrganization DEVE contenere un elemento telecom</assert>
				
				<assert test="count(hl7:product)=0 or count(hl7:product/hl7:manufacturedProduct/hl7:manufacturerOrganization/hl7:addr[@use])=1"
				>ERRORE-b27| Sezione Impianto del Dispositivo: l'elemento manufacturerOrganization DEVE contenere un elemento addr</assert>
				
				<!--6-->
				<!--Controlli su participant/participantRole[@LOC]-->
				
				
				<assert test="count(hl7:participant[@typeCode='LOC']/hl7:participantRole/hl7:playingEntity)=0 or count(hl7:participant[@typeCode='LOC']/hl7:participantRole/hl7:playingEntity/hl7:name)=1"
				>ERRORE-b28| Sezione Impianto del Dispositivo: l'elemento participantRole, con @typeCode='LOC', se valorizzato, DEVE avere l'elemento name</assert>
				
				<!--Controlli su participant/participantRole[@DEV]-->
				
				
				<assert test="count(hl7:participant[@typeCode='DEV']/hl7:participantRole/hl7:playingDevice)=1"
				>ERRORE-b29| Sezione Impianto del Dispositivo: l'elemento participantRole, con @typeCode='DEV', DEVE avere l'elemento playingDevice</assert>
				
				<assert test="count(hl7:participant[@typeCode='DEV']/hl7:participantRole/hl7:playingDevice/hl7:manufacturerModelName)=1"
				>ERRORE-b30| Sezione Impianto del Dispositivo: l'elemento participantRole/playingDevice DEVE avere l'elemento manufacturedModelName</assert>
				
				<!--7-->
				<!--Entryrelationship/act-->
				
				<assert test="count(hl7:entryRelationship/hl7:act)=0 or count(hl7:entryRelationship/hl7:act/hl7:templateId)=0 or  count(hl7:entryRelationship/hl7:act/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.677'])=1"
				>ERRORE-b31| Sezione Impianto del Dispositivo: l'elemento supply può contenere al più un entryRelationship/act che consente di riportare il riferimento alla tessera portatore di impianto precedentemente associata al dispositivo conforme al 'templateId' @root='2.16.840.1.113883.3.1937.777.63.10.677' </assert>
				
				<assert test="count(hl7:entryRelationship/hl7:act)=0 or count(hl7:entryRelationship/hl7:act[@moodCode ='EVN' or @classCode='ACT'])=1"
				> ERRORE-b32| Sezione Impianto del Dispositivo: l'elemento act deve avere: 
				- @moodCode='EVN'
				- @classCode='ACT' </assert>
				
		
				<assert test="count(hl7:entryRelationship/hl7:act)=0 or count(hl7:entryRelationship/hl7:act/hl7:code[@code='55107-7' and @codeSystem='2.16.840.1.113883.6.1'])=1"
				>ERRORE-b33| Sezione Impianto del Dispositivo: l'elemento act/code deve avere:
				- @code='55107-7'
				- @codeSystem='2.16.840.1.113883.6.1'</assert>
				
				<assert test="count(hl7:entryRelationship/hl7:act)=0 or count(hl7:entryRelationship/hl7:act/hl7:reference)=1"
				>ERRORE-b33| Sezione Impianto del Dispositivo: l'elemento act/reference DEVE essere presente</assert>
				
			
				<assert test="count(hl7:entryRelationship/hl7:act)=0 or count(hl7:entryRelationship/hl7:act/hl7:reference)=0 or count(hl7:entryRelationship/hl7:act/hl7:reference/hl7:externalDocument/hl7:id)=1"
				>ERRORE-b34| Sezione Impianto del Dispositivo: l'elemento act/reference/externalDocument/id DEVE essere presente</assert>
				
				
				<!--8-->
				<!--Entryrelationship/observation-->
				<assert test="count(hl7:entryRelationship/hl7:observation)=0 or count(hl7:entryRelationship/hl7:observation/hl7:templateId)=0 or count(hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.761'])=1"
				>ERRORE-b35| Sezione Impianto del Dispositivo: l'elemento supply può contenere al più un entryRelationship/observation che riporta lo stato del dispositivo conforme al 'templateId' @root='2.16.840.1.113883.3.1937.777.63.10.761' </assert>
				
				
				
				<assert test="count(hl7:entryRelationship/hl7:observation)=0 or count(hl7:entryRelationship/hl7:observation/hl7:code[@code='104959-2' and @codeSystem='2.16.840.1.113883.6.1'])=1"
				>ERRORE-b36| Sezione Impianto del Dispositivo: l'elemento entry/observation/code deve avere:
				- @code='104959-2'
				- @codeSystem='2.16.840.1.113883.6.1'</assert>
				
				<assert test="count(hl7:entryRelationship/hl7:observation)=0 or count(hl7:entryRelationship/hl7:observation/hl7:value[@xsi:type='CD'])=1"
				>ERRORE-b37| Sezione Impianto del Dispositivo: l'elemento entryRelationship/observation/value deve avere @xsi:type='CD'</assert>
				
				<assert test="count(hl7:entryRelationship/hl7:observation)=0 or count(hl7:entryRelationship/hl7:observation/hl7:value[(@code='LA9634-2' or @code='LA9633-4') and @codeSystem='2.16.840.1.113883.6.1'])=1"
				>ERRORE-b38| Sezione Impianto del Dispositivo: l'elemento entry/observation/value deve avere l'elemento @code valorizzato con:
				- LA9634-2 – Absent: il dispositivo è stato rimosso (espiantato).
				- LA9633-4 – Present: il dispositivo è ancora impiantato.
				Derivato dal @codeSystem='2.16.840.1.113883.6.1'
				</assert>	
			</rule>
	</pattern>
</schema>