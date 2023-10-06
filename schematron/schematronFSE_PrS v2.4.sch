<?xml version="1.0" encoding="UTF-8"?>
<!-- schematron versione: 2.3 -->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" 
		xmlns:cda="urn:hl7-org:v3"
        xmlns:iso="http://purl.oclc.org/dsdl/schematron"
        xmlns:sch="http://www.ascc.net/xml/schematron"
        queryBinding="xslt2">
	<title>Schematron Prescrizione Specialistica 2.1</title>
	<ns prefix="hl7" uri="urn:hl7-org:v3"/>
	<ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
	<pattern id="all">
	<!--________________________________ HEADER _____________________________________________________________-->
	
		<!-- ClinicalDocument -->
		<rule context="hl7:ClinicalDocument">

			<!--Controllo realmCode-->
			<assert test="count(hl7:realmCode)=0 or count(hl7:realmCode/@code)>=1"
			>ERRORE-1| L'elemento 'realmCode' DEVE avere l'attributo @code valorizzato.</assert>

			<!-- Controllo su templateId-->
			<let name="num_tid" value="count(hl7:templateId)"/>
			<assert test="$num_tid >= 1"
			>ERRORE-2| L'elemento <name/> DEVE avere almeno un elemento di tipo 'templateId'</assert>
			<assert test="count(hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.2.2']) = 1 and  count(hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.2.2']/@extension)=1"
			>ERRORE-3| Almeno un elemento 'templateId' DEVE essere valorizzato attraverso l'attributo  @root='2.16.840.1.113883.2.9.10.1.2.2' (id del template nazionale)  associato all'attributo @extension che  indica la versione a cui il templateId fa riferimento</assert>
			
			<!-- Controllo su id-->
			<assert test="count(hl7:id[@root='2.16.840.1.113883.2.9.4.3.9'])=1"
			>ERRORE-4|L'elemento <name/> deve contenere un elemento id valorizzato con l'attributo @root='2.16.840.1.113883.2.9.4.3.9'.</assert>
		
			<!-- Controllo su code-->
			<assert test="count(hl7:code[@code='57832-8'][@codeSystem='2.16.840.1.113883.6.1']) = 1"
			>ERRORE-5| L'elemento <name/>/code deve essere valorizzato con l'attributo @code='57832-8' e l'attributo @codeSystem='2.16.840.1.113883.6.1'</assert>
				
			<report test="not(count(hl7:code[@codeSystemName='LOINC'])=1) or not(count(hl7:code[@displayName='PRESCRIZIONE SPECIALISTICA'])=1 or
			count(hl7:code[@displayName='Prescrizione Specialistica'])=1)"
			>W001| Si raccomanda di valorizzare gli attributi dell'elemento <name/>/code nel seguente modo: @codeSystemName ='LOINC' e @displayName ='Prescrizione Specialistica'</report>
			
			<!-- Controllo su translation -->
			<let name="code_tran" value="count(hl7:code/hl7:translation)"/>
			<assert test="count(hl7:code/hl7:translation)=0 or count(hl7:code/hl7:translation[@code='PRESC_SPEC'][@codeSystem='2.16.840.1.113883.2.9.5.2.1'])=$code_tran"
			>ERRORE-6|Almeno un elemento <name/>/code/translation deve essere valorizzato con il @code='PRESC_SPEC' e con il @codeSystem='2.16.840.1.113883.2.9.5.2.1'</assert>
			<assert test="count(hl7:code/hl7:translation)=0 or count(hl7:code/hl7:translation/hl7:qualifier)=$code_tran"
			>ERRORE-7|L'elemento <name/>/code/translation deve presentare uno ed un solo qualifier'</assert>
			<assert test="count(hl7:code/hl7:translation)=0 or count(hl7:code/hl7:translation/hl7:qualifier/hl7:name[@code='TP'])=1"
            >ERRORE-8|L'elemento <name/>/code/translation/qualifier deve presentare uno ed un solo sottoelemento 'name' valorizzato con @code='TP'</assert>
			<assert test="count(hl7:code/hl7:translation/hl7:qualifier/hl7:name/@codeSystem)=0 or count(hl7:code/hl7:translation/hl7:qualifier/hl7:name[@codeSystem='2.16.840.1.113883.2.9.5.2.1'])=$code_tran"
            >ERRORE-9|Se l'elemento <name/>/code/translation/qualifier/name presenta l'attributo @codeSystem, quest'ultimo deve essere valorizzato con 2.16.840.1.113883.2.9.5.2.1'</assert>

			<!-- Controllo su effectiveTime-->
			<assert test="count(hl7:effectiveTime/@value)=1"
            >ERRORE-10|L'elemento <name/>/effectiveTime è obbligatorio, e deve presentare l'attributo @value</assert>
			
			<!-- Controllo su confidentialityCode-->
			<assert test="count(hl7:confidentialityCode[@code='N'][@codeSystem='2.16.840.1.113883.5.25'])= 1 or 
			count(hl7:confidentialityCode[@code='V'][@codeSystem='2.16.840.1.113883.5.25'])= 1"
			>ERRORE-11| L'elemento  'confidentialityCode' di <name/> DEVE avere l'attributo @code  valorizzato con 'N' o 'V', e il @codeSystem  con '2.16.840.1.113883.5.25'</assert>
			
			<!--Controllo languageCode-->
			<assert test="count(hl7:languageCode)=1"
			>ERRORE-12| L'elemento <name/> DEVE contenere un solo elemento 'languageCode'</assert>
			
			<!-- Controllo incrociato tra setId-versionNumber-relatedDocument-->
			<let name="versionNumber" value="hl7:versionNumber/@value"/>
			<assert test="(string(number($versionNumber)) = 'NaN') or
					($versionNumber= '1' and count(hl7:setId)=0) or 
					($versionNumber= 1 and hl7:id/@root = hl7:setId/@root and hl7:id/@extension = hl7:setId/@extension) or
					($versionNumber!= '1' and hl7:id/@root = hl7:setId/@root and hl7:id/@extension != hl7:setId/@extension) or
					(hl7:id/@root != hl7:setId/@root)"
			>ERRORE-13| Se ClinicalDocument.id e ClinicalDocument.setId usano lo stesso dominio di identificazione (@root identico), allora l'attributo @extension del
			ClinicalDocument.id deve essere diverso da quello del ClinicalDocument.setId a meno che ClinicalDocument.versionNumber non sia uguale ad 1; cioè i valori del setId ed id per un documento clinico coincidono solo per la prima versione di un documento.</assert>
			
			<assert test="(string(number($versionNumber)) ='NaN') or
						  ($versionNumber=1)  or 
						  (($versionNumber &gt;1) and count(hl7:relatedDocument)&gt;=1 and count(hl7:relatedDocument)&lt;=2)"
			>ERRORE-14| Se l'attributo <name/>/versionNumber/@value è maggiore di  1, l'elemento <name/>  deve contenere un elemento di tipo 'relatedDocument'.</assert>
			
			<!--Controllo recordTarget-->
			<assert test="count(hl7:recordTarget)=1"
			>ERRORE-15| L'elemento <name/> DEVE contenere un solo elemento 'recordTarget' </assert>
						
			<assert test="count(hl7:recordTarget[@typeCode and @contextControlCode])=1"
			>ERRORE-16| L'elemento <name/>/recordTarget DEVE avere l'attributo @typeCode valorizzato con 'RCT' e l'attributo @contextControlCode valorizzato con 'OP' </assert>
			
			<assert test ="count(hl7:recordTarget/hl7:patientRole/@classCode)=1"
			>ERRORE-17| L'elemento <name/> deve avere l'attributo @classCode valorizzato con 'PAT'
			</assert>
			
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
			>ERRORE-18| L'elemento <name/>/recordTarget/patientRole/id  deve avere l'attributo @root valorizzato tramite uno dei seguenti identificatori Nazionanli:
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
			
			>ERRORE-18a| Nel caso di Soggetti assicurati da istituzioni estere, devono essere riportati almeno due elementi di tipo 'id' contenenti:
			- 2.16.840.1.113883.2.9.4.3.7: Il numero di identificazione della Tessera TEAM (Tessera Europea di Assicurazione Malattia),
			- 2.16.840.1.113883.2.9.4.3.3Il numero di identificazione Personale TEAM
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
			
			>ERRORE-18b| Nel caso di Stranieri Temporaneamente Presenti, l'elemento <name/>/recordTarget/patientRole/id  deve avere l'attributo @root valorizzato tramite un identificativo STP.</assert>

			<!--Controllo recordTarget/patientRole/addr-->
			<let name="num_addr" value="count(hl7:recordTarget/hl7:patientRole/hl7:addr)"/>
			<assert test="$num_addr=0 or (count(hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:country)=$num_addr and 
			count(hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:city)=$num_addr and 
			count(hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:streetAddressLine)=$num_addr)"
			>ERRORE-19| L'elemento <name/>/recordTarget/patientRole/addr DEVE riportare i sotto-elementi 'country', 'city' e 'streetAddressLine' </assert>
			<assert test="$num_addr=0 or (count(hl7:recordTarget/hl7:patientRole/hl7:addr[@use='HP'])=1 or 
			count(hl7:recordTarget/hl7:patientRole/hl7:addr[@use='H'])=1 or count(hl7:recordTarget/hl7:patientRole/hl7:addr[@use='TMP'])=1)"
			>ERRORE-20| Se presente, l'elemento <name/>/recordTarget/patientRole/addr DEVE riportare l'attributo @use, valorizzato in uno dei seguenti modi:
			- 'HP' (primary home);
			- 'H' (home);
			- 'TMP' (temporary address).</assert>
			
			<!--Controllo recordTarget/patientRole/patient/name-->
			<let name="patient" value="hl7:recordTarget/hl7:patientRole/hl7:patient"/>
			<assert test="count($patient)=1"
			>ERRORE-21| L'elemento <name/>/recordTaget/patientRole DEVE contenere l'elemento patient</assert>
			<assert test="count($patient)=0 or count($patient/hl7:name)=1"
			>ERRORE-22| L'elemento <name/>/recordTaget/patientRole/patient DEVE contenere l'elemento 'name'</assert>
			<assert test="count($patient/hl7:name)=0 or count($patient/hl7:name/hl7:given)=1 and count($patient/hl7:name/hl7:family)=1"
			>ERRORE-23| L'elemento <name/>/recordTaget/patientRole/patient/name DEVE riportare gli elementi 'given' e 'family'</assert>

			<!--Controllo recordTarget/patientRole/patient/administrativeGenderCode-->
			<let name="genderOID" value="hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:administrativeGenderCode/@codeSystem"/>
			<assert test="count($patient)=0 or count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:administrativeGenderCode)=1"
			>ERRORE-24| L'attributo <name/>/recordTarget/patientRole/patient DEVE contenere l'elemento administrativeGenderCode </assert>
			<assert test="count($patient)=0 or ($genderOID='2.16.840.1.113883.5.1')"
			>ERRORE-25| L'OID assegnato a <name/>/recordTarget/patientRole/patient/administrativeGenderCode DEVE essere valorizzato con '2.16.840.1.113883.5.1' </assert>

			<!--Controllo recordTarget/patientRole/patient/birthTime-->		
			<assert test="count($patient)=0 or (count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2' or 
			@root='2.16.840.1.113883.2.9.4.3.7' or @root='2.16.840.1.113883.2.9.4.3.3' or 
			@root='2.16.840.1.113883.2.9.4.3.17'])=0) or 
			count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthTime)=1"
			>ERRORE-26| L'elemento <name/>/recordTaget/patientRole/patient DEVE riportare un elemento 'birthTime'.</assert>
			
			<!--Controllo recordTarget/patientRole/patient/birthplace/place/addr-->
			<assert test="count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthplace)=0 or 
			count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthplace/hl7:place/hl7:addr)=1"
			>ERRORE-27| L'elemento <name/>/recordTarget/patientRole/patient/birthplace DEVE contenere un elemento place/addr </assert>	
			
			<!--Controllo dataEnterer/assignedEntity/assignedPerson-->
			<let name="nome" value="hl7:dataEnterer/hl7:assignedEntity/hl7:assignedPerson/hl7:name"/>
			<assert test="count(hl7:dataEnterer)=0 or count($nome)=0 or 
			(count($nome/hl7:family)=1 and count($nome/hl7:given)=1)"
			>ERRORE-28| L'elemento <name/>/dataEnterer/assignedEntity/assignedPerson/name DEVE avere gli elementi 'given' e 'family'.</assert>
			
			<!-- Controllo ClinicalDocument/custodian-->
			<assert test = "count(hl7:custodian/@typeCode)= 1" 
			>ERRORE-29| L'elemento <name/>/custodian DEVE contenere l'attributo @typeCode valorizzato con 'CST'</assert>
			<let name="num_addr_cust" value="count(hl7:custodian/hl7:assignedCustodian/hl7:representedCustodianOrganization/hl7:addr)"/>
			<let name="addr_cust" value="hl7:custodian/hl7:assignedCustodian/hl7:representedCustodianOrganization/hl7:addr"/>
			<assert test="$num_addr_cust=0 or 
			(count($addr_cust/hl7:country)=$num_addr_cust and 
			count($addr_cust/hl7:city)=$num_addr_cust and 
			count($addr_cust/hl7:streetAddressLine)=$num_addr_cust)"
			>ERRORE-30| L'elemento <name/>/custodian/assignedCustodian/representedCustodianOrganization/addr DEVE riportare i sotto-elementi 'country', 'city' e 'streetAddressLine'.</assert>
            
			<!--Controllo ClinicalDocument/legalAuthenticator-->
			
			<assert test = "count(hl7:legalAuthenticator)= 0 or count(hl7:legalAuthenticator/hl7:signatureCode[@code='S'])= 1" 
			>ERRORE-32| L'elemento <name/>/legalAuthenticator/signatureCode deve contenere l'attributo @code valorizzato con il codice "S"  </assert>
			<assert test = "count(hl7:legalAuthenticator)= 0 or count(hl7:legalAuthenticator/hl7:time[@value])= 1" 
			>ERRORE-33| L'elemento <name/>/legalAuthenticator/time deve presentare l'attributo @value </assert>
			<assert test = "count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:code)= 0 or count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:code[@code and @codeSystem])= 1" 
			>ERRORE-34| L'elemento <name/>/legalAuthenticator/time/assignedEntity/code, se presente, deve avere gli attributi @code e @codeSystem </assert>
			<assert test = "count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:addr)= 0 or count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:addr/@use)= 1" 
			>ERRORE-35| L'elemento <name/>/legalAuthenticator/time/assignedEntity/addr, se presente, deve avere l'attributo @use </assert>
			<assert test = " count(hl7:legalAuthenticator)= 0 or (count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:assignedPerson/hl7:name/hl7:family)=1 and 
			count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:assignedPerson/hl7:name/hl7:given)=1)"
			>ERRORE-36| <name/>/legalAuthenticator/assignedEntity/assignedPerson/name DEVE riportare gli elementi 'given' e 'family'</assert>
			
			<!-- Controllo author-->
			<let name="num_auth" value="count(hl7:author)"/>
			<assert test="count(hl7:author[@contextControlCode and @typeCode])=$num_auth"
			>ERRORE-37| L'elemento <name/> DEVE presentare l'attributo @typeCode valorizzato con 'AUT' e l'attributo @contextControlCode valorizzato con 'OP' </assert>			
			
			<!--controllo participant-->	
			<let name="num_part" value="count(hl7:participant)"/>
			<assert test="$num_part = 0 or count(hl7:participant[@typeCode='IND']) = $num_part"
			>ERRORE-38| L'elemento <name/>/participant, se presente, deve contenere l'attributo 'typeCode' valorizzato o con 'IND'.</assert>
					
					
			<!--controllo componentOf-->		
			<assert test= "count(hl7:componentOf)= 1"
			>ERRORE-39| L'elemento <name/>/componentOf è obbligatorio</assert>
			
			<assert test= "count(hl7:componentOf/hl7:encompassingEncounter/hl7:code[@code='AMB' or @code='HH'][@codeSystem='2.16.840.1.113883.5.4'])= 1"
			>ERRORE-40| L'elemento <name/>/componentOf/encompassingEncounter/code è obbligatorio; i suoi attributi DEVONO essere valorizzati come segue:
			- @code='AMB' e @codeSystem='2.16.840.1.113883.5.4' nel caso si tratti di una prescrizione specialistica per una visita ambulatoriale;
			- @code='HH' e @codeSystem='2.16.840.1.113883.5.4' nel caso si tratti di una prescrizione specialistica per una visita domiciliare.</assert>
			
			<assert test= "count(hl7:componentOf/hl7:encompassingEncounter/hl7:location/@typeCode)= 1"
			>ERRORE-41| L'elemento <name/>/componentOf/encompassingEncounter/location è obbligatorio, e il suo attributo @typeCode deve essere valorizzato con 'LOC'</assert>
			
			<assert test= "count(hl7:componentOf/hl7:encompassingEncounter/hl7:location/hl7:healthCareFacility/@classCode)= 0 or 
			count(hl7:componentOf/hl7:encompassingEncounter/hl7:location/hl7:healthCareFacility[@classCode = 'SDLOC'])= 1"
			>ERRORE-42| L'elemento <name/>/componentOf/encompassingEncounter/location/healthCareFacility è obbligatorio, e il suo attributo @classCode deve essere valorizzato con 'SDLOC'</assert>
			
			<assert test= "count(hl7:componentOf/hl7:encompassingEncounter/hl7:location/hl7:healthCareFacility/hl7:serviceProviderOrganization)= 1"
			>ERRORE-43| L'elemento <name/>/componentOf/encompassingEncounter/location/healthCareFacility/serviceProviderOrganization è obbligatorio </assert>
		
	</rule>
		
		<rule context="hl7:ClinicalDocument/hl7:author">
		
			<assert test="count(hl7:time/@value)=1"
			>ERRORE-44| L'elemento <name/>/time DEVE presentare l'attributo @value </assert>
			
			<assert test="count(hl7:assignedAuthor/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])= 1"
			>ERRORE-45| L'elemento <name/>/assignedAuthor DEVE contenere almeno un elemento id che abbia l'attributo @root  valorizzato nel seguente modo '2.16.840.1.113883.2.9.4.3.2' </assert>
						
			<assert test="count(hl7:assignedAuthor/hl7:code)= 0 or count(hl7:assignedAuthor/hl7:code[@codeSystem = '2.16.840.1.113883.2.9.5.1.111'])= 1"
			>ERRORE-47| L'elemento <name/>/assignedAuthor/code, se presente, DEVE contenere l'attributo @codeSystem valorizzato con '2.16.840.1.113883.2.9.5.1.111'</assert>
			
			<assert test = "count(hl7:assignedAuthor/hl7:assignedPerson)= 1" 
			>ERRORE-48| L'elemento <name/>/assignedPerson è obbligatorio </assert>

			<!--Controllo author/assignedAuthor/assignedPerson/name-->
			<assert test="count(hl7:assignedAuthor/hl7:assignedPerson/hl7:name)=0 or 
			(count(hl7:assignedAuthor/hl7:assignedPerson/hl7:name/hl7:given)=1 and count(hl7:assignedAuthor/hl7:assignedPerson/hl7:name/hl7:family)=1)"
			>ERRORE-49| L'elemento <name/>/assignedAuthor/assignedPerson/name, se presente, DEVE avere gli elementi 'given' e 'family'</assert>

			<!-- controllo author/assignedAuthor/rapresentedOrganization -->
			<assert test="count(hl7:assignedAuthor/hl7:representedOrganization)= 0 or 
			(count(hl7:assignedAuthor/hl7:representedOrganization[@classCode and @determinerCode])=1)"
			>ERRORE-50| L'elemento <name/>/assignedAuthor/representedOrganization, se presente, DEVE contenere un attributo @classCode valorizzato con 'ORG' e l'attributo @determinerCode con 'INSTANCE'</assert>
			
			
			<assert test="count (hl7:assignedAuthor/hl7:representedOrganization/hl7:asOrganizationPartOf)= 0 or 
			count(hl7:assignedAuthor/hl7:representedOrganization/hl7:asOrganizationPartOf/@classCode)=1"
			>ERRORE-51| L'elemento <name/>/assignedAuthor/representedOrganization/asOrganizationPartOf, se presente, DEVE contenere l'attributo @classCode valorizzato con 'PART' </assert>
			
		</rule>		
		
	<rule context="hl7:ClinicalDocument/hl7:participant">
					
		<assert test="count(hl7:functionCode)= 0 or  count(hl7:functionCode[@codeSystem='2.16.840.1.113883.2.9.5.1.88' or @codeSystem='2.16.840.1.113883.2.9.5.88']) = 1"
		>ERRORE-52| L'elemento <name/>/functionCode, se presente, DEVE contenere l'attributo @codeSystem='2.16.840.1.113883.2.9.5.1.88' oppure @codeSystem='2.16.840.1.113883.2.9.5.1.88'.</assert>
			
		<assert test="count(hl7:functionCode[@code='FULINRD'])=0 or count(hl7:time/hl7:high/@value) = 1"
		>ERRORE-53| L'elemento <name/>/time, nel caso di soggetto assicurato da istituzioni estere, DEVE contenere l'elemento 'high/@value'  che riporta la data di scadenza della tessera TEAM.</assert>	
		
		<assert test="count(hl7:associatedEntity[@classCode = 'PROV' or @classCode = 'GUAR'])=1"
		>ERRORE-54| L'elemento <name/>/associatedEntity DEVE contenere l'attributo @classCode valorizzato con 'PROV'(medico sostituto della prescrizione) o 'GUAR'(in presenza di soggetto assicurato da istituzioni estere, ASL di residenza dell'assistitio e numero tessera assistenza SASN)</assert>
		
		<assert test="count(hl7:associatedEntity/hl7:id)>=1 and (count(hl7:associatedEntity[@classCode = 'PROV'])=0 or count(hl7:associatedEntity[@classCode = 'PROV']/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=1 )"
		>ERRORE-55| L'elemento <name/>/associatedEntity DEVE contenere almeno un elemento 'id' dove nel caso di medico sostituto DEVE essere valorizzato con @root='2.16.840.1.113883.2.9.4.3.2'.</assert>
		
		<assert test="count(hl7:associatedEntity/hl7:code)=0 or(count(hl7:associatedEntity[@classCode = 'PROV']/hl7:code[@codeSystem='2.16.840.1.113883.2.9.5.1.111'])=1 or
		count(hl7:associatedEntity[@classCode = 'PROV']/hl7:code[@code='004'])=1 or 
		count(hl7:associatedEntity[@classCode = 'GUAR']/hl7:code[@code='001' or @code='002' or @code='003'])=1)"
		>ERRORE-56| L'elemento <name/>/associatedEntity/code, se presente, DEVE presentare gli attributi @code e @codeSystem valorizzati nei seguenti modi:
			- @codeSystem='2.16.840.1.113883.2.9.5.1.111' o  @code='004': ASL del medico titolare (se @classCode = 'PROV');
			- @code='001': Società di Navigazione  o
			- @code='002': soggetto assicurato da istituzioni estere o
			- @code='003': ASL di residenza/appartenenza(se @classCode = 'GUAR')</assert>
	
		<assert test="count(hl7:associatedEntity/hl7:associatedPerson)=0 or 
		count(hl7:associatedEntity/hl7:associatedPerson[@classCode='PSN' and @determinerCode='INSTANCE'])=1"
		>ERRORE-57| L'elemento <name/>/associatedEntity/associatedPerson, se presente, DEVE avere l'attributo @classCode valorizzato con 'PSN' e l'attributo @determinerCOde valorizzato con 'INSTANCE'</assert>
		
		<assert test="count(hl7:associatedEntity/hl7:associatedPerson/hl7:name)=0 or 
		(count(hl7:associatedEntity/hl7:associatedPerson/hl7:name/hl7:given)=1 and 
		count(hl7:associatedEntity/hl7:associatedPerson/hl7:name/hl7:family)=1)"
		>ERRORE-58| L'elemento <name/>/associatedEntity/associatedPerson/name, se presente, DEVE contenere gli elementi 'given' e 'family'.</assert>
		
		<!--controllo scopingOrganization-->
		<assert test="count(hl7:associatedEntity/hl7:scopingOrganization)=0 or 
		count(hl7:associatedEntity/hl7:scopingOrganization[@classCode and @determinerCode])=1"
		>ERRORE-59| L'elemento <name/>/associatedEntity/scopingOrganization, se presente, DEVE avere l'attributo @classCode valorizzato con 'ORG' e l'attributo @determinerCode valorizzato con 'INSTANCE'</assert>
		
		<assert test="count(hl7:associatedEntity[@classCode = 'GUAR']/hl7:code[@code='001'])=0 or
		count(hl7:associatedEntity/hl7:scopingOrganization)=1"
		>ERRORE-60| L'elemento <name/>/associatedEntity/scopingOrganization è da compilarsi in maniera obbligatoria, per assistiti SASN valorizzando il sotto-elemento 'name'.</assert>
		
		<assert test="(count(hl7:associatedEntity[@classCode = 'PROV'][hl7:code[@code='004']]/hl7:scopingOrganization/hl7:id)=0 or
		count(hl7:associatedEntity[@classCode = 'PROV']/hl7:scopingOrganization/hl7:id[@root='2.16.840.1.113883.2.9.4.1.1'])=1)"
		>ERRORE-61| L'elemento <name/>/associatedEntity/scopingOrganization, nel caso di ASL del medico titolare, se presenta l'elemento 'id' deve essere valorizzato con @root='2.16.840.1.113883.2.9.4.1.1'.</assert>
		
		<assert test="(count(hl7:associatedEntity[@classCode = 'GUAR'][hl7:code[@code='003']]/hl7:scopingOrganization/hl7:id)=0 or
		count(hl7:associatedEntity[@classCode = 'GUAR'][hl7:code[@code='003']]/hl7:scopingOrganization/hl7:id[@root='2.16.840.1.113883.2.9.4.1.1'])=1)"
		>ERRORE-62| L'elemento <name/>/associatedEntity/scopingOrganization, nel caso di ASL di residenza dell'assistito, se presenta l'elemento 'id' deve essere valorizzato con @root='2.16.840.1.113883.2.9.4.1.1'.</assert>
		
		<assert test="count(hl7:associatedEntity/hl7:scopingOrganization/hl7:asOrganizationPartOf)=0 or 
		count(hl7:associatedEntity/hl7:scopingOrganization/hl7:asOrganizationPartOf/@classCode)=1"
		>ERRORE-63| L'elemento <name/>/associatedEntity/asOrganizationPartOf, se presente, deve avere l'attributo @classCode valorizzato con 'PART'</assert>
		
	</rule>
		
		
		<!--________________________________ CONTROLLI GENERICI _____________________________________________________________-->

	<rule context="//hl7:telecom">
		<assert test="(count(@use)=1)"
		>ERRORE-64| L’elemento 'telecom' DEVE contenere l'attributo @use.</assert>
	</rule>
	<rule context="//*[contains(local-name(), 'Organization')][hl7:telecom]">
		<assert test="not(hl7:telecom/@use='H' or hl7:telecom/@use='HP' or hl7:telecom/@use='HV')"
		>ERRORE-65| L'elemento telecom di un'organizzazione non può essere di tipo Home, ovvero l'attributo @use deve essere diverso da: H | HP | HV.
		</assert>
	</rule>
	
	<rule context="//hl7:id[@root='2.16.840.1.113883.2.9.4.3.2']">
		<let name="CF" value="@extension"/>
		<assert test="matches(@extension, '[A-Z0-9]{16}') and string-length($CF)=16"
		>ERRORE-66| codice fiscale '<value-of select="$CF"/>' cittadino ed operatore: 16 cifre [A-Z0-9]{16}</assert>
	</rule>
	
	<rule context="//hl7:name[contains(local-name(..), 'Organization') or (parent::hl7:location)]">
	  <assert test="count(hl7:delimiter)=0 and count(hl7:prefix)=0 and count(hl7:suffix)=0"
	  >ERRORE-67| L’elemento 'name' di un'organizzazione non deve contenere i sotto elementi 'delimiter', 'prefix', 'suffix'.</assert>
	</rule>

	<rule context="//hl7:name">
		<assert test="count(hl7:delimiter)=0"
		>ERRORE-68| L’elemento 'name' del soggetto non deve contenere il sotto-elemento 'delimiter'.</assert>
	</rule>
	
	<rule context="//hl7:effectiveTime[hl7:low/@value]">
		<let name="effective_time_low" value="string(hl7:low/@value)"/>
		<let name="effective_time_high" value="string(hl7:high/@value)"/>
		<assert test="count(hl7:high/@value)=0 or ($effective_time_high >= $effective_time_low)"
		>ERROR-69| Il valore dell'elemento effectiveTime/high : '<value-of select="$effective_time_high"/>' 
		deve essere maggione o uguale di quello di effectiveTime/low : '<value-of select="$effective_time_low"/>'.</assert>
	</rule>
	
	<rule context="//*[contains(local-name(), 'Organization')]/hl7:addr[@use='H' or @use='HP' or @use='HV']">
		<assert test="false()"
		>ERRORE-70| L'indirizzo di un'organizzazione non può essere di tipo Home, ovvero l'attributo @use deve essere diverso da: H | HP | HV.
		</assert>
	</rule>
	
	<rule context="//hl7:originalText[hl7:reference]">
		<assert test="string(hl7:reference/@value)"
		>ERROR-71| L'elemento originalText/reference/@value DEVE essere valorizzato.</assert>
	</rule>

	<rule context="//hl7:addr[not(parent::hl7:place) and not(parent::hl7:scopingOrganization)]">
		<assert test="count(@use)!=0"
		>ERROR-72| L'elemento addr DEVE avere l'attributo @use valorizzato.</assert>
	</rule>
	
	<rule context="//hl7:code">
		<assert test="(count(@code)!=0 and count(@codeSystem)!=0) or (count(@nullFlavor)!=0)"
		>ERROR-73| L'elemento 'code' DEVE avere gli attributi @code e @codeSystem valorizzati, altrimenti deve avere l'attributo @nullFlavor.</assert>
	</rule>
	
	<rule context="//hl7:id">
		<assert test="(count(@root)!=0 and count(@extension)!=0)"
		>ERROR-74| L'elemento 'id' DEVE contenere gli attributi @root ed @extension valorizzati.</assert>
	</rule>
	
	
	<!--________________________________ BODY _____________________________________________________________-->


	<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody">
			
		<!-- 1. ESENZIONI -->
		<assert test="count(hl7:component/hl7:section/hl7:code[@code='57827-8'][@codeSystem='2.16.840.1.113883.6.1'])= 1">
		ERRORE-b1| Sezione Esenzioni: La sezione DEVE essere presente </assert> 
		<assert test="count(hl7:component/hl7:section[hl7:code[@code='57827-8']]/hl7:id[@root='2.16.840.1.113883.2.9.4.3.9'])=1">
		ERRORE-b2| Sezione Esenzioni: la sezione DEVE contenere l'elemento id obbligatorio con l'attributo @root valorizzato '2.16.840.1.113883.2.9.4.3.9'</assert>
		<assert test="count(hl7:component/hl7:section[hl7:code[@code='57827-8']]/hl7:text)=1">
		ERRORE-b3| Sezione Esenzioni: La sezione DEVE contenere l'elemento text obbligatorio</assert> 
		<assert test="count(hl7:component/hl7:section[hl7:code[@code='57827-8']]/hl7:entry)=1">
		ERRORE-b4| Sezione Esenzioni: La sezione DEVE contenere un elemento entry obbligatorio.</assert> 
			<!-- 1.1 controllo entry -->
			<let name="oid" value="substring-after(hl7:component/hl7:section[hl7:code[@code='57827-8']]/hl7:entry/hl7:act/hl7:code/@codeSystem, '2.16.840.1.113883.2.9.2.')"/>
			<assert test="(count(hl7:component/hl7:section[hl7:code[@code='57827-8']]/hl7:entry/hl7:act/hl7:code[@codeSystem ='2.16.840.1.113883.2.9.6.1.22'])=1 or 
			count(hl7:component/hl7:section[hl7:code[@code='57827-8']]/hl7:entry/hl7:act/hl7:code[@code ='NE'][@codeSystem ='2.16.840.1.113883.2.9.5.2.2'])=1 or
			matches($oid, '^\d{2,3}\.6\.22$'))"
			>ERRORE-b5| Sezione Esenzioni: Nel caso in cui sia presente l'esenzione, l'elemento entry/act/code deve avere l'attributo @codeSystem valorizzato con uno dei seguenti valori:
			- @codeSystem = '2.16.840.1.113883.2.9.6.1.22' - (Catalogo Nazionale della Esenzioni)
			- @codeSystem ='2.16.840.1.113883.2.9.2.[REGIONE].6.22' - (Catalogo Regionale della Esenzioni)
			Nel caso in cui non sia presente l'esenzione, l'elemento entry/act/code deve avere gli attributi valorizzati con: @code='NE' (Nessuna Esenzione) e @codeSystem ='2.16.840.1.113883.2.9.5.2.2'.</assert> 
			
			<assert test="count(hl7:component/hl7:section/hl7:entry/hl7:act/hl7:code/hl7:originalText)=0 or 
			(count(hl7:component/hl7:section/hl7:entry/hl7:act/hl7:code/hl7:originalText/hl7:reference/@value)=1)"
			>ERRORE-b6| Sezione Esenzioni: l'elemento entry/act/code/originalText DEVE contenere l'elemento 'reference' valorizzato tramite l'attributo @value.</assert>
			
		<!-- 2. PRESCRIZIONI -->
		<assert test="count(hl7:component/hl7:section/hl7:code[@code='57828-6'][@codeSystem='2.16.840.1.113883.6.1'])= 1">
		ERRORE-b7| Sezione Prescrizioni: La sezione DEVE essere presente </assert>		
		<assert test="count(hl7:component/hl7:section[hl7:code[@code='57828-6']]/hl7:id[@root='2.16.840.1.113883.2.9.4.3.9'])=1">
		ERRORE-b8| Sezione Prescrizioni: la sezione DEVE contenere l'elemento id obbligatorio con l'attributo root valorizzato '2.16.840.1.113883.2.9.4.3.9'</assert>
		<assert test="count(hl7:component/hl7:section[hl7:code[@code='57828-6']]/hl7:text)=1">
		ERRORE-b9| Sezione Prescrizioni: La sezione DEVE contenere l'elemento text obbligatorio </assert>
		<assert test="count(hl7:component/hl7:section[hl7:code[@code='57828-6']]/hl7:entry)=1">
		ERRORE-b10| Sezione Prescrizioni: La sezione DEVE contenere un elemento entry</assert>
		
		<!-- 3. ANNOTAZIONI -->
		<assert test="count(hl7:component/hl7:section/hl7:code[@code='48767-8'])=0 or count(hl7:component/hl7:section[hl7:code[@code='48767-8']]/hl7:id[@root='2.16.840.1.113883.2.9.4.3.9'])=1">
		ERRORE-b11| Sezione Annotazioni: L'elemento id è obbligatorio e DEVE contenere l'attributo @root valorizzato con '2.16.840.1.113883.2.9.4.3.9' </assert>
		<assert test="count(hl7:component/hl7:section/hl7:code[@code='48767-8'])=0 or count(hl7:component/hl7:section[hl7:code[@code='48767-8']]/hl7:text)=1">
		ERRORE-b12| Sezione Annotazioni: La sezione DEVE contenere l'elemento text obbligatorio </assert>
		<assert test="count(hl7:component/hl7:section/hl7:code[@code='48767-8'])=0 or count(hl7:component/hl7:section[hl7:code[@code='48767-8']]/hl7:entry)=1"
		>ERRORE-b13| Sezione Annotazioni: La sezione DEVE contenere un elemento 'entry' di tipo act.</assert>
		<assert test="count(hl7:component/hl7:section/hl7:code[@code='48767-8'])=0 or count(hl7:component/hl7:section[hl7:code[@code='48767-8']]/hl7:entry/hl7:act[@classCode='ACT' and @moodCode='EVN'])=1">
		ERRORE-b14| Sezione Annotazioni: L'elemento entry/act DEVE contenere l'attributo @classCode valorizzato con 'ACT' e l'attributo @moodCode valorizzato con 'EVN' </assert>
		<assert test="count(hl7:component/hl7:section/hl7:code[@code='48767-8'])=0 or 
		(count(hl7:component/hl7:section[hl7:code[@code='48767-8']]/hl7:entry/hl7:act/hl7:code[@code='EL30'][@codeSystem='2.16.840.1.113883.2.9.5.1.4'])=1 or 
		count(hl7:component/hl7:section[hl7:code[@code='48767-8']]/hl7:entry/hl7:act/hl7:code[@code='48767-8'][@codeSystem='2.16.840.1.113883.6.1'])=1)">
		ERRORE-b15| Sezione Annotazioni: L'elemento entry/act/code è obbligatorio e DEVE avere gli attributi @code e @codeSystem valorizzati come segue:
		- @code='EL30' e @codeSystem='2.16.840.1.113883.2.9.5.1.4'
		- @code='48767-8' e @codeSystem= '2.16.840.1.113883.6.1
		</assert>
		<assert test="count(hl7:component/hl7:section/hl7:code[@code='48767-8'])=0 or count(hl7:component/hl7:section[hl7:code[@code='48767-8']]/hl7:entry/hl7:act/hl7:text/hl7:reference/@value)=1">
		ERRORE-b16| Sezione Annotazioni: L'elemento text è obbligatorio e deve contenere l'elemento 'reference' con l'attributo @value valorizzato.</assert>
				
		<!-- 5. PARAMETRI VITALI -->
		<assert test="count(hl7:component/hl7:section[hl7:code[@code='8716-3']])=0 or count(hl7:component/hl7:section[hl7:code[@code='8716-3']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.263'])= 1">
		ERRORE-17| Sezione Parametri Vitali: La sezione, se presente, deve contenere l'elemento templateId con l' attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.263' </assert>
		<assert test="count(hl7:component/hl7:section[hl7:code[@code='8716-3']])=0 or count(hl7:component/hl7:section[hl7:code[@code='8716-3']]/hl7:text)=1">
		ERRORE-b18| Sezione Parametri Vitali: La sezione DEVE contenere l'elemento text obbligatorio </assert>
		
		<!-- 6. ALLERGIE E INTOLLERANZE -->
		<assert test="count(hl7:component/hl7:section/hl7:code[@code='48765-2'])=0 or count(hl7:component/hl7:section[hl7:code[@code='48765-2']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.265'])= 1">
		ERRORE-b19| Sezione Allergie e Intolleranze: La sezione, se presente, deve contenere l'elemento templateId con l' attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.265' </assert>
		<assert test="count(hl7:component/hl7:section/hl7:code[@code='48765-2'])=0 or count(hl7:component/hl7:section[hl7:code[@code='48765-2']]/hl7:text)=1">
		ERRORE-b20| Sezione Allergie e Intolleranze: La sezione DEVE contenere l'elemento text obbligatorio </assert>
		
		<!-- 7. STATO DEL PAZIENTE-->
		<assert test="count(hl7:component/hl7:section[hl7:code[@code='47420-5']])=0 or count(hl7:component/hl7:section[hl7:code[@code='47420-5']]/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.270'])= 1">
		ERRORE-b21| Sezione Stato del Paziente: La sezione, se presente, deve contenere l'elemento templateId con l' attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.270'</assert>
		<assert test="count(hl7:component/hl7:section[hl7:code[@code='47420-5']])=0 or count(hl7:component/hl7:section[hl7:code[@code='47420-5']]/hl7:text)=1">
		ERRORE-b22| Sezione Stato del Paziente: La sezione DEVE contenere l'elemento text obbligatorio </assert>
		
			
	</rule>
						
	<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section">
		<let name="codice" value="hl7:code/@code"/>
		<assert test="count(hl7:code[@code='57827-8'][@codeSystem='2.16.840.1.113883.6.1'])= 1 or 
			count(hl7:code[@code='57828-6'][@codeSystem='2.16.840.1.113883.6.1'])= 1 or
			count(hl7:code[@code='48767-8'][@codeSystem='2.16.840.1.113883.6.1'])= 1 or 
			count(hl7:code[@code='51851-4'][@codeSystem='2.16.840.1.113883.6.1'])= 1 or
			count(hl7:code[@code='8716-3'][@codeSystem='2.16.840.1.113883.6.1'])= 1 or 
			count(hl7:code[@code='48765-2'][@codeSystem='2.16.840.1.113883.6.1'])= 1 or
			count(hl7:code[@code='47420-5'][@codeSystem='2.16.840.1.113883.6.1'])= 1"
			>ERRORE-b23| L'elemento code della section DEVE essere valorizzato con uno dei seguenti codici LOINC individuati:
			57827-8 ESENZIONI
			57828-6 PRESCRIZIONI 
			48767-8 ANNOTAZIONI
			51851-4	MESSAGGIO REGIONALE
			8716-3 PARAMETRI VITALI
			48765-2 ALLERGIE E INTOLLERANZE
			47420-5 STATO DEL PAZIENTE
		</assert>
	</rule>	
		
	<!-- 2.1 controllo entry -->		
	<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='57828-6']]/hl7:entry">
		<assert test="count(hl7:observation[@classCode='OBS' and @moodCode='RQO'])=1">
		ERRORE-b24|Sezione Prescrizioni: L'elemento entry/observation deve avere l'attributo @classCode valorizzato con 'OBS' e l'attributo @moodCode valorizzato con 'RQO'</assert>	
		<assert test="count(hl7:observation/hl7:priorityCode)=0 or count(hl7:observation/hl7:priorityCode[@code='S' or @code='A' or @code='EL' or @code='R'][@codeSystem='2.16.840.1.113883.5.7'])=1">
		Errore-b25|Sezione Prescrizioni: L'elemento entry/observation/priorityCode, se presente, deve avere l'attributo @code valorizzato nei seguenti modi con codeSystem='2.16.840.1.113883.5.7':
		- S -> STAT Urgente
		- A -> ASAP Breve
		- EL -> Elecrtive Differita
		- R -> Routine Programmata
		</assert>
		<assert test="count(hl7:observation/hl7:priorityCode/hl7:translation)=0 or count(hl7:observation/hl7:priorityCode/hl7:translation[@codeSystem='2.16.840.1.113883.2.9.5.2.3'])=1"
		>Errore-b26|Sezione Prescrizioni: L'elemento entry/observation/priorityCode/translation, se presente, deve avere l'attributo @codeSystem='2.16.840.1.113883.2.9.5.2.3'</assert>
		<assert test="count(hl7:observation/hl7:priorityCode/hl7:translation[@codeSystem='2.16.840.1.113883.2.9.5.2.3'])=0 or 
		count(hl7:observation/hl7:priorityCode/hl7:translation[@codeSystem='2.16.840.1.113883.2.9.5.2.3'][@code='U' or @code='B' or @code='D' or @code='P'])=1">
		Errore-b27|Sezione Prescrizioni: L'elemento entry/observation/priorityCode/translation, se presente, deve avere l'attributo @code valorizzato nei seguenti modi:
		- U -> Urgente
		- B -> Breve
		- D -> Differita
		- P -> Programmata 
		</assert>
		<assert test="((count(hl7:observation/hl7:priorityCode)=0 or count(hl7:observation/hl7:priorityCode[@code='S'])=1) and (count(hl7:observation/hl7:priorityCode/hl7:translation[@codeSystem='2.16.840.1.113883.2.9.5.2.3'])=0 or count(hl7:observation/hl7:priorityCode/hl7:translation[@code='U'][@codeSystem='2.16.840.1.113883.2.9.5.2.3'])=1)) or
		(count(hl7:observation/hl7:priorityCode)=0 or count(hl7:observation/hl7:priorityCode[@code='A'])=1 and (count(hl7:observation/hl7:priorityCode/hl7:translation[@codeSystem='2.16.840.1.113883.2.9.5.2.3'])=0 or count(hl7:observation/hl7:priorityCode/hl7:translation[@code='B'][@codeSystem='2.16.840.1.113883.2.9.5.2.3'])=1)) or 
		(count(hl7:observation/hl7:priorityCode)=0 or count(hl7:observation/hl7:priorityCode[@code='EL'])=1 and (count(hl7:observation/hl7:priorityCode/hl7:translation[@codeSystem='2.16.840.1.113883.2.9.5.2.3'])=0 or count(hl7:observation/hl7:priorityCode/hl7:translation[@code='D'][@codeSystem='2.16.840.1.113883.2.9.5.2.3'])=1)) or
		(count(hl7:observation/hl7:priorityCode)=0 or count(hl7:observation/hl7:priorityCode[@code='R'])=1 and (count(hl7:observation/hl7:priorityCode/hl7:translation[@codeSystem='2.16.840.1.113883.2.9.5.2.3'])=0 or count(hl7:observation/hl7:priorityCode/hl7:translation[@code='P'][@codeSystem='2.16.840.1.113883.2.9.5.2.3'])=1))"
		>Errore-b28|Sezione Prescrizioni: L'elemento entry/observation/priorityCode/translation, se presente, deve essere valorizzato con la corretta corrispondenza.</assert>
		<assert test="count(hl7:observation/hl7:repeatNumber)=0 or count(hl7:observation/hl7:repeatNumber/@value)=1">
		ERRORE-b29|Sezione Prescrizioni: L'elemento entry/observation/repeatNumber se presente, deve avere l'attributo @value.</assert>		
		
		<!--participant: tipologia ambulatorio/laboratorio di erogazione prestazione-->
		<assert test="count(hl7:observation/hl7:participant)=0 or count(hl7:observation/hl7:participant[@typeCode='LOC'])=1"
		>Errore-b30|Sezione Prescrizioni: L'elemento entry/observation/participant deve contenere l'attributo @typeCode='LOC'.</assert>
		<assert test="count(hl7:observation/hl7:participant)=0 or count(hl7:observation/hl7:participant/hl7:participantRole/hl7:scopingEntity/hl7:code[@code='H' or @code='MR' or @code='R'][@codeSystem='2.16.840.1.113883.2.9.6.3.1.1'])=1">
		Errore-b31|Sezione Prescrizioni: L'elemento entry/observation/participant/participantRole/scopingEntity/code deve avere l'attributo @codeSystem='2.16.840.1.113883.2.9.6.3.1.1' e @code valorizzato nei seguenti modi:
		- H -> Ambulatorio in struttura di ricovero
		- MR -> Solo malattie rare
		- R -> Ambulatori/Laboratori individuati dalla Regione
		</assert>
		<!--Nota esplicativa (0..1)-->
		<assert test="count(hl7:observation/hl7:entryRelationship[@typeCode='SUBJ'])&lt;=1"
		>ERRORE-b32| Sezione Prescrizioni: L'elemento entry/observation può contenere al più una entryRelationship con @typeCode='SUBJ'.</assert>
		<assert test="count(hl7:observation/hl7:entryRelationship[@typeCode='SUBJ'])=0 or 
		count(hl7:observation/hl7:entryRelationship[@typeCode='SUBJ']/hl7:act[@classCode = 'ACT' and @moodCode ='EVN'])=1"
		>ERRORE-b33| Sezione Prescrizioni: L'elemento entry/observation/entryRelationship, se presente DEVE contenere l'elemento act con gli attributi valorizzati come @classCode='ACT' e @moodCode='EVN'</assert>
		<assert test="count(hl7:observation/hl7:entryRelationship[@typeCode='SUBJ'])=0 or
		count(hl7:observation/hl7:entryRelationship[@typeCode='SUBJ']/hl7:act/hl7:templateId[@root = '2.16.840.1.113883.3.1937.777.63.10.274'])=1"
		>ERRORE-b34| Sezione Prescrizioni: L'elemento entry/observation/entryRelationship/act DEVE contenere l'elemento templateId con l'attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.274'</assert>
		<assert test="count(hl7:observation/hl7:entryRelationship[@typeCode='SUBJ'])=0 or
		count(hl7:observation/hl7:entryRelationship[@typeCode='SUBJ']/hl7:act/hl7:code[@code='48767-8'][@codeSystem='2.16.840.1.113883.6.1'])=1"
		>ERRORE-b35| Sezione Prescrizioni: L'elemento entry/observation/entryRelationship, se presente, DEVE contenere l'elemento act/code, 
		con gli attributi @code valorizzato '48767-8' e @codeSystem valorizzato con '2.16.840.1.113883.6.1'</assert>
		<assert test="count(hl7:observation/hl7:entryRelationship[@typeCode='SUBJ'])=0 or
		count(hl7:observation/hl7:entryRelationship[@typeCode='SUBJ']/hl7:act/hl7:text/hl7:reference/@value)=1"
		>Errore-b36|Sezione Prescrizioni: L'elemento entry/observation/entryRelationship, se presente, DEVE contenere l'elemento act/text/reference/@value.</assert>
		
		
		<!--ER tipologia di accesso (1..N)-->
		<assert test="count(hl7:observation/hl7:entryRelationship[@typeCode='REFR']/hl7:encounter/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.276'])>=1"
		>ERRORE-b37| Sezione Prescrizioni: L'elemento entry/observation/entryRelationship/encounter DEVE contenere l'elemento templateId con l'attributo @root='2.16.840.1.113883.3.1937.777.63.10.276' </assert>
		
		<!--ER tipo visita (0..1)-->
		<assert test="count(hl7:observation/hl7:entryRelationship[@typeCode='REFR']/hl7:encounter/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.281'])=0 or
		count(hl7:observation/hl7:entryRelationship[@typeCode='REFR']/hl7:encounter[@classCode='ENC' and @moodCode='INT'][hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.281']])=1"
		>ERRORE-b38| Sezione Prescrizioni: L'elemento entry/observation/entryRelationship/encounter DEVE contenere l'elemento templateId con l'attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.281'</assert>
		<assert test="count(hl7:observation/hl7:entryRelationship[@typeCode='REFR']/hl7:encounter/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.281'])&lt;=1"
		>ERRORE-b39| Sezione Prescrizioni: L'elemento entry/observation/entryRelationship/encounter DEVE contenere l'elemento templateId con l'attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.281'</assert>
		<assert test="count(hl7:observation/hl7:entryRelationship[@typeCode='REFR']/hl7:encounter/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.281'])=0 or
		count(hl7:observation/hl7:entryRelationship[@typeCode='REFR']/hl7:encounter[hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.281']]/hl7:code[@codeSystem='2.16.840.1.113883.5.4'])=1"
		>ERRORE-b40| Sezione Prescrizioni: L'elemento entry/observation/entryRelationship, se presente, DEVE contenere l'elemento encounter/code, 
		con l'attributo @codeSystem valorizzato con '2.16.840.1.113883.5.4'</assert>
		
		<!--ER numero progressivo (0..1)-->
		<assert test="count(hl7:observation/hl7:entryRelationship[@typeCode='AUTH'])=0 or 
		count(hl7:observation/hl7:entryRelationship[@typeCode='AUTH']/hl7:act[@classCode='ACT' and @moodCode ='EVN'])=1"
		>ERRORE-b41| Sezione Prescrizioni: L'elemento entry/observation/entryRelationship, se presente, deve avere l'elemento act con gli attributi @classCode='ACT' e @moodCode='RQO'</assert>
		<assert test="count(hl7:observation/hl7:entryRelationship[@typeCode='AUTH'])=0 or
		count(hl7:observation/hl7:entryRelationship[@typeCode='AUTH']/hl7:act/hl7:templateId[@root = '2.16.840.1.113883.3.1937.777.63.10.278'])=1"
		>ERRORE-b42 Sezione Prescrizioni: L'elemento entry/observation/entryRelationship/act DEVE contenere l'elemento templateId con l'attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.278'</assert>
		<assert test="count(hl7:observation/hl7:entryRelationship[@typeCode='AUTH'])=0 or
		count(hl7:observation/hl7:entryRelationship[@typeCode='AUTH']/hl7:act/hl7:code)=1"
		>ERRORE-b43| Sezione Prescrizioni: L'elemento entry/observation/entryRelationship, se presente, DEVE contenere l'elemento act/code, con gli attributi @code e @codeSystem.</assert>	
		<assert test="count(hl7:observation/hl7:entryRelationship[@typeCode='AUTH']/hl7:act/hl7:code/hl7:translation/hl7:qualifier)=0 or
		count(hl7:observation/hl7:entryRelationship[@typeCode='AUTH']/hl7:act/hl7:code/hl7:translation/hl7:qualifier/hl7:value[@code and @codeSystem='2.16.840.1.113883.2.9.6.1.55'])=1"
		>Errore-b44|Sezione Prescrizioni: L'elemento entry/observation/entryRelationship/act/code/translation/qualifier, se presente, DEVE contenere l'elemento value con l'attributo @codeSystema valorizzato come '2.16.840.1.113883.2.9.6.1.55'.</assert>
		
		<!--ER numero ripetizioni sedute (0..1)-->		
		<assert test="count(hl7:observation/hl7:entryRelationship[@typeCode='COMP'])=0 or
		count(hl7:observation/hl7:entryRelationship[@typeCode='COMP']/hl7:observation/hl7:templateId[@root = '2.16.840.1.113883.3.1937.777.63.10.277'])=1"
		>ERRORE-b45| Sezione Prescrizioni: L'elemento entry/observation/entryRelationship, se presente, DEVE contenere l'elemento observation/templateId con l'attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.277'</assert>
		<assert test="count(hl7:observation/hl7:entryRelationship[@typeCode='COMP'])=0 or
		count(hl7:observation/hl7:entryRelationship[@typeCode='COMP']/hl7:observation/hl7:repeatNumber/@value)=1"
		>ERRORE-b46| Sezione Prescrizioni: L'elemento entry/observation/entryRelationship, se presente, DEVE contenere l'elemento observation/repeatNumber con l'attributo @value valorizzato.</assert>
		
	</rule>
	<!--Codice patologia (0..N)-->
	<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='57828-6']]/hl7:entry/hl7:observation/hl7:entryRelationship[@typeCode = 'REFR'][hl7:act]">
		
		<assert test="count(hl7:act[@classCode='ACT' and @moodCode='EVN'])=1"
		>ERRORE-b47| Sezione Prescrizioni: L'elemento entry/observation/entryRelationship/act DEVE contenere gli attributi valorizzati con: @classCode='ACT' e @moodCode='EVN'</assert>
		<assert test="count(hl7:act/hl7:templateId[@root = '2.16.840.1.113883.3.1937.777.63.10.275'])=1"
		>ERRORE-b48| Sezione Prescrizioni: L'elemento entry/observation/entryRelationship/act DEVE contenere l'elemento templateId con l'attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.275'</assert>
		<assert test="count(hl7:act/hl7:code[@codeSystem='2.16.840.1.113883.2.9.6.3.1.3'])=1"
		>ERRORE-b49| Sezione Prescrizioni: L'elemento entry/observation/entryRelationship, se presente, DEVE contenere l'elemento act/code, 
		con l'attributo @codeSystem valorizzato con '22.16.840.1.113883.2.9.6.3.1.3'</assert>
		
	</rule>
		
		
	<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='57828-6']]/hl7:entry/hl7:observation/hl7:entryRelationship[@typeCode = 'REFR'][hl7:encounter/hl7:templateId[@root='2.16.840.1.113883.3.1937.777.63.10.276']]">
	
		<assert test="count(hl7:encounter[@classCode = 'ENC' and @moodCode ='INT'])=1"
		>ERRORE-b50| Sezione Prescrizioni: L'elemento entry/observation/entryRelationship/encounter DEVE contenere gli attributi valorizzati con @classCode='ENC' e @moodCode='EVN'</assert>
		<assert test="count(hl7:encounter/hl7:templateId[@root = '2.16.840.1.113883.3.1937.777.63.10.276'])=1"
		>ERRORE-b51| Sezione Prescrizioni: L'elemento entry/observation/entryRelationship/encounter DEVE contenere l'elemento templateId con l'attributo @root valorizzato con '2.16.840.1.113883.3.1937.777.63.10.276'</assert>
		<assert test="count(hl7:encounter/hl7:code)=1"
		>ERRORE-b52| Sezione Prescrizioni: L'elemento entry/observation/entryRelationship/encounter deve contenere l'elemento 'code'.</assert>
	</rule>
	</pattern>
</schema>