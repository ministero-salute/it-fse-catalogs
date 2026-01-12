<?xml version="1.0" encoding="UTF-8"?>
<!-- schematron versione: 3.8-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" 
		xmlns:cda="urn:hl7-org:v3"
        xmlns:iso="http://purl.oclc.org/dsdl/schematron"
        xmlns:sch="http://www.ascc.net/xml/schematron"
        queryBinding="xslt2">
	<title>Schematron Profilo Sanitario Sintetico 1.5 </title>
	<ns prefix="hl7" uri="urn:hl7-org:v3"/>
	<ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
	<pattern id="all">


<!--_______________________________________________________________HEADER _____________________________________________________________________-->


	<!-- ClinicalDocument -->
		<rule context="hl7:ClinicalDocument">
	        <!--Controllo realmCode-->	
			<assert test="count(hl7:realmCode)=1"
			>ERRORE-1| L'elemento <name/> DEVE avere un elemento 'realmCode'</assert>
			<assert test="count(hl7:realmCode[@code='IT'])=1"
			>ERRORE-2| L'elemento 'realmCode' DEVE avere l'attributo @code valorizzato con 'IT'</assert>
			
			
			<!--Controllo templateId-->
			<let name="num_tid" value="count(hl7:templateId)"/>
			<assert test="$num_tid >= 1"
			>ERRORE-3| L'elemento <name/> DEVE avere almeno un elemento di tipo 'templateId'</assert>
			<assert test="count(hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.1.1'])= 1 and  count(hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.1.1']/@extension)= 1"
			>ERRORE-4| Almeno un elemento <name/>/templateId DEVE essere valorizzato attraverso l'attributo @root='2.16.840.1.113883.2.9.10.1.4.1.1', associato all'attributo @extension che  indica la versione a cui il templateId fa riferimento</assert>
			
			<!--Controllo code-->	
			<assert test="count(hl7:code[@code='60591-5'][@codeSystem='2.16.840.1.113883.6.1']) = 1"
			>ERRORE-5| L'elemento <name/>/code DEVE essere valorizzato con l'attributo @code='60591-5' e il @codeSystem='2.16.840.1.113883.6.1'</assert>
			
			<report test="not(count(hl7:code[@codeSystemName='LOINC'])=1) or not(count(hl7:code[@displayName='Profilo Sanitario Sintetico'])=1 or
			count(hl7:code[@displayName='PROFILO SANITARIO SINTETICO'])=1 or count(hl7:code[@displayName='Profilo sanitario sintetico'])=1)"
			>W001| Si raccomanda di valorizzare gli attributi dell'elemento <name/>/code nel seguente modo: @codeSystemName ='LOINC' e @displayName ='Profilo Sanitario Sintetico'.> </report>
			
			<!--Controllo confidentialityCode-->
			<assert test="(count(hl7:confidentialityCode[@code='N'][@codeSystem='2.16.840.1.113883.5.25'])= 1) or 
			(count(hl7:confidentialityCode[@code='V'][@codeSystem='2.16.840.1.113883.5.25'])= 1) or (count(hl7:confidentialityCode[@code='R'][@codeSystem='2.16.840.1.113883.5.25'])= 1)"
			>ERRORE-6| L'elemento <name/>/confidentialityCode DEVE avere l'attributo @code valorizzato con 'N' o 'R' o 'V', e il @codeSystem='2.16.840.1.113883.5.25'</assert>
			
			<!--Controllo languageCode-->	
			<assert test="count(hl7:languageCode)=1"
			>ERRORE-7| L'elemento <name/> DEVE contenere un elemento 'languageCode' </assert>
			
			<!--Controllo incrociato tra setId-versionNumber e relatedDocument-->
			<let name="versionNumber" value="hl7:versionNumber/@value"/>
			<assert test="(string(number($versionNumber)) = 'NaN') or
					($versionNumber= '1' and count(hl7:setId)=0) or 
					($versionNumber= 1 and hl7:id/@root = hl7:setId/@root and hl7:id/@extension = hl7:setId/@extension) or
					($versionNumber!= '1' and hl7:id/@root = hl7:setId/@root and hl7:id/@extension != hl7:setId/@extension) or
					(hl7:id/@root != hl7:setId/@root)"
			>ERRORE-8| Se ClinicalDocument.id e ClinicalDocument.setId usano lo stesso dominio di identificazione (@root identico) allora l’attributo @extension del ClinicalDocument.id 
			deve essere diverso da quello del ClinicalDocument.setId a meno che ClinicalDocument.versionNumber non sia uguale ad 1; cioè i valori di setId ed id per un documento clinico coincidono solo per la prima versione di un documento</assert>
			
			<assert test="(string(number($versionNumber)) ='NaN') or
						  ($versionNumber=1) or 
						  (($versionNumber &gt;1) and count(hl7:relatedDocument)=1)"
			>ERRORE-9| Se l'attributo <name/>/versionNumber/@value è maggiore di 1, l'elemento <name/> DEVE contenere un elemento di tipo 'relatedDocument'</assert>
			
			<!--Controllo recordTarget-->
			<assert test="count(hl7:recordTarget)=1"
			>ERRORE-10| L'elemento <name/> DEVE contenere un solo elemento 'recordTarget' </assert>

			<!--Controllo recordTarget/patientRole/id-->
			<assert test="count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=1 or
			count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.15'])=1 or count(hl7:recordTarget/hl7:patientRole/hl7:id[@root='2.16.840.1.113883.2.9.4.3.16'])=1 "
			>ERRORE-10a| L'elemento <name/>/recordTarget/patientRole/id  deve avere l'attributo @root valorizzato tramite uno dei seguenti identificatori Nazionanli:
			CF 2.16.840.1.113883.2.9.4.3.2
			ANA 2.16.840.1.113883.2.9.4.3.15
			ANPR 2.16.840.1.113883.2.9.4.3.16
			Oppure tramite gli identificatori regionali generati per rappresentare l'id del paziente.
			</assert>
			
			<!--Controllo recordTarget/patientRole/addr-->
			<let name="num_addr" value="count(hl7:recordTarget/hl7:patientRole/hl7:addr)"/>
			<assert test="$num_addr=0 or (count(hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:country)=$num_addr and 
			count(hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:city)=$num_addr and
			count(hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:censusTract)=$num_addr and
			count(hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:postalCode)=$num_addr and
			count(hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:streetAddressLine)=$num_addr)"
			>ERRORE-11| L'elemento <name/>/recordTarget/patientRole/addr DEVE riportare i sotto-elementi 'country', 'city', 'censusTract', 'postalCode' e 'streetAddressLine' </assert>
			
			
		    <!--Controllo recordTarget/patientRole/patient/name-->
			<let name="patient" value="hl7:recordTarget/hl7:patientRole/hl7:patient"/>
			<assert test="count($patient)=1 "
			>ERRORE-12| L'elemento <name/>/recordTaget/patientRole DEVE contenere l'elemento patient</assert>
			<assert test="count($patient)=0 or count($patient/hl7:name)=1"
			>ERRORE-13| L'elemento <name/>/recordTaget/patientRole/patient DEVE contenere l'elemento 'name'</assert>
			<assert test="count($patient)=0 or (count($patient/hl7:name/hl7:given)=1 and count($patient/hl7:name/hl7:family)=1)"
			>ERRORE-14| L'elemento ClinicalDocument/recordTaget/patientRole/patient/name DEVE riportare gli elementi 'given' e 'family'</assert>
			
			<!--Controllo recordTarget/patientRole/patient/administrativeGenderCode-->
			<let name="genderOID" value="hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:administrativeGenderCode/@codeSystem"/>
			
			<assert test="count($patient)=0 or count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:administrativeGenderCode)=1"
			>ERRORE-15| L'attributo <name/>/recordTarget/patientRole/patient DEVE contenere l'elemento administrativeGenderCode </assert>
			<assert test="count($patient)=0 or $genderOID='2.16.840.1.113883.5.1'"
			>ERRORE-16| L'OID assegnato all'attributo <name/>/recordTarget/patientRole/patient/administrativeGenderCode/@codeSystem='<value-of select="$genderOID"/>' non è corretto. L'attributo DEVE essere valorizzato con '2.16.840.1.113883.5.1' </assert>
			
			
		<!--Controllo recordTarget/patientRole/patient/birthTime-->
            <assert test="count($patient)=0 or
			count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthTime)=1"
			>ERRORE-17| L'elemento <name/>/recordTaget/patientRole/patient DEVE riportare un elemento 'birthTime'. Qualora non si possa risalire al dato, è possibile valorizzare l'elemento con @nullFlavor="UNK"</assert>	
			
			<!--Controllo recordTarget/patientRole/patient/guardian-->
            <assert test="count($patient)=0 or
			count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:guardian)=0 or count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:guardian/hl7:id)=1"
			>ERRORE-18| L'elemento <name/>/recordTaget/patientRole/patient se valorizzato l'elemento guardian, DEVE essere valorizzato l'elemento id"</assert>	
			
			
			<!--Controllo recordTarget/patientRole/patient/birthplace/place/addr-->
			<assert test="count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthplace)=0 or 
			count(hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthplace/hl7:place/hl7:addr)=1"
			>ERRORE-19| L'elemento <name/>/recordTarget/patientRole/patient/birthplace DEVE contenere un elemento place/addr </assert>	

			
			<let name="brtPlace" value="hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthplace"/>
			<assert test="count($brtPlace)=0 or 
			count($brtPlace/hl7:place/hl7:addr/hl7:country)=1"
			>ERRORE-20| L'elemento <name/>/recordTarget/patientRole/patient/birthplace DEVE contenere un elemento place/addr/country </assert>
			
			<assert test="count($brtPlace)=0 or $brtPlace/hl7:place/hl7:addr/hl7:country!='100' or
			($brtPlace/hl7:place/hl7:addr/hl7:country='100' and count($brtPlace/hl7:place/hl7:addr/hl7:city)=1 and count($brtPlace/hl7:place/hl7:addr/hl7:censusTract)=1)"
			>ERRORE-21| L'elemento <name/>/recordTarget/patientRole/patient/birthplace per i pazienti nati in Italia DEVE contenere gli elementi city e censusTract</assert>
			
			<!--Controllo dataEnterer/assignedEntity/assignedPerson-->
			<let name="nome" value="hl7:dataEnterer/hl7:assignedEntity/hl7:assignedPerson/hl7:name"/>
			<assert test="count(hl7:dataEnterer)=0 or (count(hl7:dataEnterer/hl7:assignedEntity/hl7:assignedPerson/hl7:name)=1)"
			>ERRORE-22| L'elemento <name/>/dataEnterer/assignedEntity DEVE riportare l'elemento 'assignedPerson/name'.</assert>
			<assert test="count(hl7:dataEnterer)=0 or (count($nome/hl7:family)=1 and count($nome/hl7:given)=1)"
			>ERRORE-23| L'elemento <name/>/dataEnterer/assignedEntity/assignedPerson/name DEVE avere gli elementi 'given' e 'family'.</assert>	
			
		
			<!--Controllo custodian/assignedCustodian/representedCustodianOrganization-->
			<assert test="count(hl7:custodian/hl7:assignedCustodian/hl7:representedCustodianOrganization/hl7:id)=1"
			>ERRORE-24| L'elemento <name/>/custodian/assignedCustodian/representedCustodianOrganization deve contenere un solo elemento 'id'</assert>
			
			<assert test="count(hl7:custodian/hl7:assignedCustodian/hl7:representedCustodianOrganization/hl7:name)=1"
			>ERRORE-25| L'elemento <name/>/custodian/assignedCustodian/representedCustodianOrganization deve contenere un elemento 'name'</assert>
			
			<let name="num_addr_cust" value="count(hl7:custodian/hl7:assignedCustodian/hl7:representedCustodianOrganization/hl7:addr)"/>
			<let name="addr_cust" value="hl7:custodian/hl7:assignedCustodian/hl7:representedCustodianOrganization/hl7:addr"/>
			<assert test="$num_addr_cust=0 or (count($addr_cust/hl7:country)=$num_addr_cust and
			count($addr_cust/hl7:city)=$num_addr_cust and 
			count($addr_cust/hl7:streetAddressLine)=$num_addr_cust)"
			>ERRORE-26| L'elemento <name/>/custodian/assignedCustodian/representedCustodianOrganization/addr DEVE riportare i sotto-elementi 'country','city' e 'streetAddressLine'</assert>
			
			
		    <!--Controllo ClinicalDocument/legalAuthenticator-->
			
			<assert test="count(hl7:legalAuthenticator)=1" 
			>ERRORE-26a| L'elemento <name/>/legalAuthenticator è obbligatorio</assert>
			<assert test = "count(hl7:legalAuthenticator)= 0 or count(hl7:legalAuthenticator/hl7:signatureCode[@code='S'])= 1" 
			>ERRORE-27| L'elemento legalAuthenticator/signatureCode deve essere valorizzato con il codice "S" </assert>
			<assert test = "count(hl7:legalAuthenticator)= 0 or count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])= 1"
			>ERRORE-28| L'elemento legalAuthenticator/assignedEntity DEVE contenere almeno un elemento id valorizzato con l'attributo @root='2.16.840.1.113883.2.9.4.3.2'</assert>
			<assert test = "count(hl7:legalAuthenticator)= 0 or count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:assignedPerson/hl7:name)=1"
			>ERRORE-29| L'elemento legalAuthenticator/assignedEntity/assignedPerson DEVE contenere l'elemento 'name'</assert>
			<assert test = "count(hl7:legalAuthenticator)= 0 or count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:assignedPerson/hl7:name/hl7:family)=1 and count(hl7:legalAuthenticator/hl7:assignedEntity/hl7:assignedPerson/hl7:name/hl7:given)=1"
			>ERRORE-30| L'elemento legalAuthenticator/assignedEntity/assignedPerson/name DEVE riportare gli elementi 'given' e 'family'</assert>
			
			
			
			<!--Controllo authenticator-->
			<assert test="count(hl7:authenticator)=0 or count(hl7:authenticator/hl7:signatureCode[@code='S'])=1"
			>ERRORE-31| L'elemento <name/>/authenticator se presente, DEVE contenere l'elemento signatureCode valorizzato con l'attributo @code='S'.</assert>		
			<assert test="count(hl7:authenticator)=0 or count(hl7:authenticator/hl7:assignedEntity/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])=1"
			>ERRORE-32| L'elemento <name/>/authenticator DEVE contenere almeno un elemento assignedEntity/id valorizzato con l'attributo @root='2.16.840.1.113883.2.9.4.3.2'.</assert>
		
			<assert test = "count(hl7:authenticator/hl7:assignedEntity/hl7:assignedPerson)=0 or 
			(count(hl7:authenticator/hl7:assignedEntity/hl7:assignedPerson/hl7:name/hl7:family)=1 and 
			count(hl7:authenticator/hl7:assignedEntity/hl7:assignedPerson/hl7:name/hl7:given)=1)"
			>ERRORE-33| L'elemento <name/>/authenticator/assignedEntity/assignedPerson/name DEVE riportare gli elementi 'given' e 'family'</assert>
			
			<assert test = "count(hl7:documentationOf)>=1"
			>ERRORE-34| Deve essere presente almeno un elemento <name/>/documentationOf.</assert>
			
			<!--Controllo ClinicalDocument/author-->
			<assert test = "count(hl7:author)= 1" 
			>ERRORE-35| L'elemento author DEVE essere uno ed uno solo </assert>
				
		</rule>		
		
		<!-- Controllo author-->
		<rule context="hl7:ClinicalDocument/hl7:author">
			<!--Controllo author/assignedAuthor/id/@root-->
			<assert test="count(hl7:assignedAuthor/hl7:id[@root='2.16.840.1.113883.2.9.4.3.2'])= 1"
			>ERRORE-36| L'elemento <name/>/assignedAuthor DEVE contenere almeno un elemento 'id' con il relativo attributo @root valorizzato con '2.16.840.1.113883.2.9.4.3.2'</assert>
			
			<!--Controllo author/assignedAuthor/code-->
			<assert test="count(hl7:assignedAuthor/hl7:code)=0 or 
			count(hl7:assignedAuthor/hl7:code[@codeSystem='2.16.840.1.113883.2.9.77.22.11.13'])=1"
			>ERRORE-37| L'elemento <name/>/assignedAuthor/code DEVE essere valorizzato secondo il value set "assignedAuthorCode_PSSIT" - @codeSystem='2.16.840.1.113883.2.9.77.22.11.13'</assert>
						


            <!--Controllo author/assignedAuthor/assignedPerson/name-->
			<let name="name_author" value="hl7:assignedAuthor/hl7:assignedPerson"/>
			<assert test="count($name_author/hl7:name)=1"
			>ERRORE-38| L'elemento <name/>/assignedAuthor/assignedPerson DEVE avere l'elemento 'name' </assert>
			<assert test="count($name_author/hl7:name)=0 or (count($name_author/hl7:name/hl7:given)=1 and count($name_author/hl7:name/hl7:family)=1)"
			>ERRORE-39| L'elemento <name/>/assignedAuthor/assignedPerson/name DEVE avere gli elementi 'given' e 'family'</assert>
	
			
			<!--Controllo author/assignedAuthor/telecom-->
			<assert test="count(hl7:assignedAuthor/hl7:telecom)>=1"
			>ERRORE-40| L'elemento <name/>/assignedAuthor DEVE contenere almeno un elemento 'telecom'</assert>
		
		</rule>
		
		<!-- Controllo informant-->
		<rule context="hl7:ClinicalDocument/hl7:informant">
			<assert test="count(hl7:relatedEntity)=0 or(count(hl7:relatedEntity[@classCode='CON' or @classCode='PROV' or @classCode='PRS'])=1)"
			>ERRORE-41| L'elemento <name/>/relatedEntity deve essere valorizzato con l'attributo @classCode='CON' o @classCode='PROV' o @classCode='PRS'.</assert>
			
			<let name="nome" value="hl7:relatedEntity/hl7:relatedPerson/hl7:name"/>
			<assert test="count(hl7:relatedEntity)=0 or (count($nome/hl7:family)=1 and count($nome/hl7:given)=1)"
			>ERRORE-42| L'elemento <name/>/relatedEntity/relatedPerson/name DEVE avere gli elementi 'given' e 'family'</assert>
		</rule>
		
		<!-- Controllo participant-->
		<rule context="hl7:ClinicalDocument/hl7:participant">
			<assert test="count(hl7:associatedEntity/hl7:id)>=1"
			>ERRORE-45| L'elemento <name/>/associatedEntity deve contenere almeno un elemento 'id'</assert>
			<let name="num_addr_pcp" value="count(hl7:associatedEntity/hl7:addr)"/>
            <let name="addr_pcp" value="hl7:associatedEntity/hl7:addr"/>
            <assert test="$num_addr_pcp=0 or (count($addr_pcp/hl7:country)=$num_addr_pcp and
                          count($addr_pcp/hl7:city)=$num_addr_pcp and
                          count($addr_pcp/hl7:streetAddressLine)=$num_addr_pcp)"
            >ERRORE-46| L'elemento <name/>/associatedEntity/addr DEVE riportare i sotto-elementi 'country', 'city' e 'streetAddressLine' </assert>
			<assert test="count(hl7:associatedEntity/hl7:associatedPerson)=0 or 
			(count(hl7:associatedEntity/hl7:associatedPerson/hl7:name)=1)"
			>ERRORE-47| L'elemento <name/>/associatedEntity/associatedPerson deve contenere l'elemento 'name'</assert>
			
			<assert test="count(hl7:associatedEntity/hl7:associatedPerson)=0 or 
			(count(hl7:associatedEntity/hl7:associatedPerson/hl7:name/hl7:family)=1 and count(hl7:associatedEntity/hl7:associatedPerson/hl7:name/hl7:given)=1)"
			>ERRORE-48| L'elemento <name/>/associatedEntity/associatedPerson/name deve contenere gli elementi 'given' e 'family'</assert>
			
		</rule>
		
		<!--Controllo documentationOf-->
		<rule context="hl7:ClinicalDocument/hl7:documentationOf">
			<assert test="count(hl7:serviceEvent/hl7:effectiveTime)=1"
			>ERRORE-49| L'elemento ClinicalDocument/documentationOf/serviceEvent/effectiveTime deve essere valorizzato .</assert>
		</rule>

<!--__________________________________________________________CONTROLLI GENERICI________________________________________________________________-->


		<!--Controllo use Telecom-->
		<rule context="//hl7:telecom">
			<assert test="(count(@use)=1)"
			>ERRORE-50| L’elemento 'telecom' DEVE contenere l'attributo @use </assert>
		</rule>	
		<rule context="//*[contains(local-name(), 'Organization')][hl7:telecom]">
			<assert test="not(hl7:telecom/@use='H' or hl7:telecom/@use='HP' or hl7:telecom/@use='HV')"
			>ERRORE-51| L'elemento telecom di un'organizzazione non può essere di tipo Home, ovvero l'attributo @use deve essere diverso da: H | HP | HV.
			</assert>
		</rule>
		<!-- Controllo formato: -->
		<!--campi Codice Fiscale: 16 cifre [A-Z0-9]{16} -->
		<rule context="//hl7:id[@root='2.16.840.1.113883.2.9.4.3.2']">
			<let name="CF" value="@extension"/>
			<assert test="matches(@extension,'[A-Z0-9]{16}') and string-length($CF)=16"
			>ERRORE-52| Il codice fiscale '<value-of select="$CF"/>' cittadino ed operatore deve essere costituito da 16 cifre [A-Z0-9]{16}</assert>
			
		</rule>
	
		<!--Controllo sugli attributi di observation-->
		<rule context="//hl7:observation">
			<assert test="count(@classCode)=0 or @classCode='OBS'"
			>ERRORE-53| L'attributo "@classCode" dell'elemento "observation" deve essere valorizzato con "OBS" </assert>
		</rule>
		
		<!--Controllo sui valori di statusCode-->
		<rule context="//hl7:statusCode[
                  not(
						ancestor::hl7:observation[
							hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.4']
							or
							hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.4.2']
						]
					)
			]">
			<let name="val_status" value="@code"/>
			<assert test="$val_status='active' or  $val_status='completed' or $val_status='aborted' or $val_status='suspended' or $val_status='cancelled'"
			>Errore-54| Codice ActStatus '<value-of select="$val_status"/>' errato! Deve essere valorizzato con uno dei seguenti valori:
			- active
			- completed
			- aborted
			- suspended
			</assert>
		</rule>
		
		
		<!-- Controllo sotto elementi name-->
		<rule context="//hl7:name[contains(local-name(..), 'Organization') or (parent::hl7:location)]">
		  <assert test="count(hl7:delimiter)=0 and count(hl7:prefix)=0 and count(hl7:suffix)=0"
		  >ERRORE-55| L’elemento 'name' di un'organizzazione non deve contenere i sotto elementi 'delimiter', 'prefix', 'suffix'.</assert>
    	</rule>

		<rule context="//hl7:name">
			<assert test="count(hl7:delimiter)=0"
			>ERRORE-56| L’elemento 'name' del soggetto non deve contenere il sotto elemento 'delimiter'.</assert>
		</rule>
		
		<!-- Controllo effectiveTime: -->
		<rule context="//hl7:effectiveTime[hl7:low/@value]">
			<let name="effective_time_low" value="string(hl7:low/@value)"/>
			<let name="effective_time_high" value="string(hl7:high/@value)"/>
			<assert test="count(hl7:high/@value)=0 or ($effective_time_high >= $effective_time_low)"
			>ERROR-57| Il valore dell'elemento effectiveTime/high : '<value-of select="$effective_time_high"/>' 
			deve essere maggiore o uguale di quello di effectiveTime/low : '<value-of select="$effective_time_low"/>'.</assert>
		</rule>
		
		<rule context="//*[contains(local-name(), 'Organization')]/hl7:addr[@use='H' or @use='HP' or @use='HV']">
			<assert test="false()"
			>ERRORE-58| L'indirizzo di un'organizzazione non può essere di tipo Home, ovvero l'attributo @use deve essere diverso da: H | HP | HV.
			</assert>
		</rule>
		
<!--___________________________________________________________________BODY__________________________________________________________________________-->
	
	
	
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody">
			
		<!--Controllo sulle Section obbligatorie-->
		
			<!--1-->
			<!--Allergie e intolleranze-->
			<assert test="count(hl7:component/hl7:section/hl7:code[@code='48765-2'][@codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b1| Sezione Allergie e intolleranze: la sezione DEVE essere presente.</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='48765-2']]/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.2.1'])=1"
			>ERRORE-b2| Sezione Allergie e intolleranze: la sezione deve contenere l'elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.2.9.10.1.4.2.1'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='48765-2']]/hl7:title)=1"
			>ERRORE-b3| Sezione Allergie e intolleranze: la sezione DEVE contenere un elemento 'title' possibilmente valorizzato con 'Allergie e Intolleranze'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='48765-2']]/hl7:entry)&gt;=1"
			>ERRORE-b4| Sezione Allergie e intolleranze: la sezione DEVE contenere almeno un elemento 'entry'</assert>			
		
			<!--2-->
			<!--Sezione Terapie farmacologiche-->
			<assert test="count(hl7:component/hl7:section/hl7:code[@code='10160-0'][@codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b5| Sezione Terapie farmacologiche: la sezione DEVE essere presente</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='10160-0']]/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.2.2'])=1"
			>ERRORE-b6| Sezione Terapie farmacologiche: la sezione deve contenere l'elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.2.9.10.1.4.2.2'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='10160-0']]/hl7:title)=1"
			>ERRORE-b7| Sezione Terapie farmacologiche: la sezione DEVE contenere un elemento 'title' possibilmente valorizzato con 'Terapie farmacologiche'</assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='10160-0']]/hl7:text)=1"
			>ERRORE-b8| Sezione Terapie farmacologiche: la sezione DEVE contenere un elemento 'text' </assert>
			
			<assert test="(count(hl7:component/hl7:section[hl7:code[@code='10160-0']]/hl7:entry[hl7:substanceAdministration/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.2.1']])=0 and
			count(hl7:component/hl7:section[hl7:code[@code='10160-0']]/hl7:entry[hl7:substanceAdministration/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.2.3']])=1) or 
			(count(hl7:component/hl7:section[hl7:code[@code='10160-0']]/hl7:entry[hl7:substanceAdministration/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.2.1']])>=1 and
			count(hl7:component/hl7:section[hl7:code[@code='10160-0']]/hl7:entry[hl7:substanceAdministration/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.2.3']])=0)"
			>ERRORE-b9| Sezione Terapie farmacologiche: la sezione DEVE contenere:  
			- In caso di "Assenza di Terapia Farmacologica" un unico elemento 'entry'
			- In caso di "Presenza di Terapia " almeno un elemento 'entry'</assert>
		
			<!--4-->
			<!--Sezione Lista dei problemi-->
			<assert test="count(hl7:component/hl7:section/hl7:code[@code='11450-4'][@codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b10| Sezione Lista dei problemi: la sezione DEVE essere presente</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='11450-4']]/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.2.4'])=1"
			>ERRORE-b11| Sezione Lista dei problemi: la sezione deve contenere l'elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.2.9.10.1.4.2.4'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='11450-4']]/hl7:title)=1"
			>ERRORE-b12| Sezione Lista dei problemi: la sezione DEVE contenere un elemento 'title' possibilmente valorizzato con 'Lista dei problemi'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='11450-4']]/hl7:entry)&gt;=1"
			>ERRORE-b13| Sezione Lista dei problemi: la sezione DEVE contenere almeno un elemento 'entry'</assert>
		
			<!--5-->
			<!--Anamnesi familiare-->
			<assert test="count(hl7:component/hl7:section/hl7:code[@code='10157-6'][@codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b14| Sezione Anamnesi Familiare: la sezione DEVE essere presente</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='10157-6']]/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.2.16'])=1"
			>ERRORE-b15| Sezione Anamnesi familiare: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.2.9.10.1.4.2.16”'</assert>
			<assert test=" count(hl7:component/hl7:section[hl7:code[@code='10157-6']]/hl7:title)=1"
			>ERRORE-b16| Sezione Anamnesi familiare: la sezione DEVE contenere un elemento 'title' possibilmente valorizzato con 'Anamnesi Familiare'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='10157-6']]/hl7:text)=1"
			>ERRORE-b17| Sezione Anamnesi familiare: la sezione DEVE contenere un elemento 'text'</assert>
			
			
			<let name="anamnesiOrganizer" value="hl7:component/hl7:section[hl7:code[@code='10157-6']]/hl7:entry/hl7:organizer"/>
			<assert test="(count(hl7:component/hl7:section[hl7:code[@code='10157-6']]/hl7:entry/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.16.4'])=0 and count($anamnesiOrganizer/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.16.1'])>=0) or (count(hl7:component/hl7:section[hl7:code[@code='10157-6']]/hl7:entry/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.16.4'])&lt;=1 and count($anamnesiOrganizer/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.16.1'])=0)"
			>ERRORE-b18| Sezione Anamnesi Familiare: PUO' contenere al più una delle due entry:
			- entryRelationship/observation (Assenza Anamnesi) conenente l'elemento 'templateId' @root='2.16.840.1.113883.2.9.10.1.4.3.16.4'			
			- entryRelationship/organizer (Presenza Anamnesi) conenente l'elemento 'templateId'  @root='2.16.840.1.113883.2.9.10.1.4.3.16.1'
			</assert>
			
			
			<!--observation - Assenza Anamnesi-->
			<let name="anamnesiObservation" value="hl7:component/hl7:section[hl7:code[@code='10157-6']]/hl7:entry/hl7:observation"/>
			<assert test="count($anamnesiObservation)=0 or count($anamnesiObservation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.16.4'])=1"
			>ERRORE-b19| Sezione Anamnesi Familiare: entry/observation DEVE contenere un elemento 'templateId' valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.16.4'</assert>
			
			<assert test="count($anamnesiObservation)=0 or count($anamnesiObservation/hl7:id)=1"
			>ERRORE-b20| Sezione Anamnesi Familiare: entry/observation DEVE contenere un elemento 'id'</assert>
			
			<assert test="count($anamnesiObservation)=0 or count($anamnesiObservation/hl7:statusCode)=1"
			>ERRORE-b21| Sezione Anamnesi Familiare: entry/observation DEVE contenere un elemento 'statusCode'</assert>
			
			<assert test="count($anamnesiObservation)=0 or count($anamnesiObservation/hl7:value[@xsi:type='CD' and @codeSystem='2.16.840.1.113883.11.22.17'])=1 "
			>ERRORE-b22| Sezione Anamnesi Familiare: entry/observation se presente l'elemento value DEVE contentere @xsi:type='CD' e @codeSystem='2.16.840.1.113883.11.22.17' </assert>
			
		
		<!--Controllo sulle Section opzionali-->
		
			<!--3-->
			<!--Sezione Vaccinazioni-->	
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='11369-6']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='11369-6']]/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.2.3'])=1"
			>ERRORE-b23| Sezione Vaccinazioni: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.2.9.10.1.4.2.3'</assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='11369-6']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='11369-6']]/hl7:title)=1"
			>ERRORE-b24| Sezione Vaccinazioni: la sezione DEVE contenere un elemento 'title' possibilmente valorizzato con 'Vaccinazioni'</assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='11369-6']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='11369-6']]/hl7:text)=1"
			>ERRORE-b25| Sezione Vaccinazioni: la sezione DEVE contenere un elemento 'text'</assert>
			
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='11369-6']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='11369-6']]/hl7:entry)&gt;=1"
			>ERRORE-b26| Sezione Vaccinazioni: la sezione DEVE contenere almeno un elemento 'entry'</assert>
			
			
		
			
			<!--6-->
			<!--Stile di vita-->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='29762-2']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='29762-2']]/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.2.6'])=1"
			>ERRORE-b27| Sezione Stile di vita: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.2.9.10.1.4.2.6'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='29762-2']])=0 or count(hl7:component/hl7:section[hl7:code[@code='29762-2']]/hl7:title)=1"
			>ERRORE-b28| Sezione Stile di vita: la sezione DEVE contenere un elemento 'title' possibilmente valorizzato con 'Stile di vita'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='29762-2']])=0 or count(hl7:component/hl7:section[hl7:code[@code='29762-2']]/hl7:text)=1"
			>ERRORE-b29| Sezione Stile di vita: la sezione DEVE contenere un elemento 'text'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='29762-2']])=0 or count(hl7:component/hl7:section[hl7:code[@code='29762-2']]/hl7:entry)>=1"
			>ERRORE-b30| Sezione Stile di vita: la sezione DEVE contenere almeno un elemento 'entry/observation'</assert>
		

			<!--7-->
			<!--Gravidanze e parto-->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='10162-6']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='10162-6']]/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.2.7'])=1"
			>ERRORE-b31| Sezione Gravidanze e parto: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.2.9.10.1.4.2.7'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='10162-6']])=0 or count(hl7:component/hl7:section[hl7:code[@code='10162-6']]/hl7:title)=1"
			>ERRORE-b32| Sezione Gravidanze e parto: la sezione DEVE contenere un elemento 'title' possibilmente valorizzato con 'Gravidanze, parti e stato mestruale'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='10162-6']])=0 or count(hl7:component/hl7:section[hl7:code[@code='10162-6']]/hl7:text)=1"
			>ERRORE-b33| Sezione Gravidanze e parto: la sezione DEVE contenere un elemento 'text'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='10162-6']])=0 or count(hl7:component/hl7:section[hl7:code[@code='10162-6']]/hl7:entry)&gt;=1"
			>ERRORE-b34| Sezione Gravidanze e parto: la sezione DEVE contenere almeno un elemento 'entry'</assert>
		
			<!--8-->
			<!--Parametri vitali-->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='8716-3']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='8716-3']]/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.2.8'])=1"
			>ERRORE-b35| Sezione Parametri vitali: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.2.9.10.1.4.2.8'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='8716-3']])=0 or count(hl7:component/hl7:section[hl7:code[@code='8716-3']]/hl7:title)=1"
			>ERRORE-b36| Sezione Parametri vitali: la sezione DEVE contenere un elemento 'title' possibilmente valorizzato con 'Parametri vitali'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='8716-3']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='8716-3']]/hl7:text)=1"
			>ERRORE-b37| Sezione Parametri vitali: la sezione DEVE contenere un elemento 'text' </assert>
		
		<!--9-->
			<!--Protesi, Impianti e Ausili -->
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='46264-8']])=0 or count(hl7:component/hl7:section[hl7:code[@code='46264-8']]/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.2.9'])=1"
			>ERRORE-b38| Sezione Protesi, impianti e ausili: la sezione deve contenere l'elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.2.9.10.1.4.2.9'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='46264-8']])=0 or  count(hl7:component/hl7:section[hl7:code[@code='46264-8']]/hl7:title)=1"
			>ERRORE-b39| Sezione Protesi, impianti e ausili: la sezione DEVE contenere un elemento 'title' possibilmente valorizzato con 'Protesi, impianti e ausili'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='46264-8']])=0 or  count(hl7:component/hl7:section[hl7:code[@code='46264-8']]/hl7:text)=1"
			>ERRORE-b40| Sezione Protesi, impianti e ausili: la sezione DEVE contenere un elemento 'text'</assert>
			
		
			<!--10-->
			<!--Piani di cura-->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='18776-5']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='18776-5']]/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.2.10'])=1"
			>ERRORE-b41| Sezione Piani di cura: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.2.9.10.1.4.2.10'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='18776-5']])=0 or count(hl7:component/hl7:section[hl7:code[@code='18776-5']]/hl7:title)=1"
			>ERRORE-b42| Sezione Piani di cura: la sezione DEVE contenere un elemento 'title' possibilmente valorizzato con 'Piani di cura'</assert>
			
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='18776-5']])=0 or count(hl7:component/hl7:section[hl7:code[@code='18776-5']]/hl7:text)=1"
			>ERRORE-b43| Sezione Piani di cura: la sezione DEVE contenere un elemento 'text'</assert>
			
			
			<!--11-->
			<!--Trattamenti e procedure terapeutiche, chirurgiche e diagnostiche-->
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='47519-4']])=0 or count(hl7:component/hl7:section[hl7:code[@code='47519-4']]/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.2.11'])=1"
			>ERRORE-b44| Sezione Trattamenti e procedure terapeutiche, chirurgiche e diagnostiche: la sezione deve contenere l'elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.2.9.10.1.4.2.11'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='47519-4']])=0 or count(hl7:component/hl7:section[hl7:code[@code='47519-4']]/hl7:title)=1"
			>ERRORE-b45| Sezione Trattamenti e procedure terapeutiche, chirurgiche e diagnostiche: la sezione DEVE contenere un elemento 'title' possibilmente valorizzato con 'Trattamenti e procedure terapeutiche, chirurgiche e diagnostiche'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='47519-4']])=0 or count(hl7:component/hl7:section[hl7:code[@code='47519-4']]/hl7:text)=1"
			>ERRORE-b46| Sezione Trattamenti e procedure terapeutiche, chirurgiche e diagnostiche: la sezione DEVE contenere un elemento 'text' </assert>
			
			
			<!--13-->
			<!--Sezione Stato funzionale del paziente-->
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='47420-5']])=0 or count(hl7:component/hl7:section[hl7:code[@code='47420-5']]/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.2.13'])=1"
			>ERRORE-b47| Sezione Stato funzionale del paziente: la sezione deve contenere l'elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.2.9.10.1.4.2.13'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='47420-5']])=0 or count(hl7:component/hl7:section[hl7:code[@code='47420-5']]/hl7:title)=1"
			>ERRORE-b48| Sezione Stato funzionale del paziente: la sezione DEVE contenere un elemento 'title' possibilmente valorizzato con 'Stato funzionale del paziente'</assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='47420-5']])=0 or count(hl7:component/hl7:section[hl7:code[@code='47420-5']]/hl7:text)=1"
			>ERRORE-b49| Sezione Stato funzionale del paziente: la sezione DEVE contenere un elemento 'text'</assert>
			
			
			<!--12-->
			<!--Visite o ricoveri-->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='46240-8']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='46240-8']]/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.2.12'])=1"
			>ERRORE-b50| Sezione Visite o ricoveri: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.2.9.10.1.4.2.12'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='46240-8']])=0 or count(hl7:component/hl7:section[hl7:code[@code='46240-8']]/hl7:title)=1"
			>ERRORE-b51| Sezione Visite o ricoveri: la sezione DEVE contenere un elemento 'title' possibilmente valorizzato con 'Visite e ricoveri'</assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='46240-8']])=0 or count(hl7:component/hl7:section[hl7:code[@code='46240-8']]/hl7:text)=1"
			>ERRORE-b52| Sezione Visite o ricoveri: la sezione DEVE contenere un elemento 'text'</assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='46240-8']])=0 or count(hl7:component/hl7:section[hl7:code[@code='46240-8']]/hl7:entry)&gt;=1"
			>ERRORE-b53| Sezione Visite o ricoveri: la sezione DEVE contenere almeno un elemento 'entry'</assert>
			
			<!--14-->
			<!--Indagini diagnostiche e esami di laboratorio-->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='30954-2']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='30954-2']]/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.2.14'])=1"
			>ERRORE-b54| Sezione Indagini diagnostiche e esami di laboratorio: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.2.9.10.1.4.2.14'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='30954-2']])=0 or count(hl7:component/hl7:section[hl7:code[@code='30954-2']]/hl7:title)=1"
			>ERRORE-b55| Sezione Indagini diagnostiche e esami di laboratorio: la sezione DEVE contenere un elemento 'title' possibilmente valorizzato con 'Indagini diagnostiche e esami di laboratorio'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='30954-2']])=0 or count(hl7:component/hl7:section[hl7:code[@code='30954-2']]/hl7:text)=1"
			>ERRORE-b56| Sezione Indagini diagnostiche e esami di laboratorio: la sezione DEVE contenere un elemento 'text'</assert>
		
		
			<!--15-->
			<!--Assenso/dissenso donazione organi-->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='42348-3']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='42348-3']]/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.2.15'])=1"
			>ERRORE-b57| Sezione Assenso/dissenso donazione organi: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.2.9.10.1.4.2.15'</assert>
			
		
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='42348-3']])=0 or count(hl7:component/hl7:section[hl7:code[@code='42348-3']]/hl7:title)=1"
			>ERRORE-b58| Sezione Assenso/dissenso donazione organi: la sezione DEVE contenere un elemento 'title' possibilmente valorizzato con 'Assenso/dissenso donazione organi'</assert>
			
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='42348-3']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='42348-3']]/hl7:text)=1"
			>ERRORE-b59| Sezione Assenso/dissenso donazione organi: la sezione DEVE contenere un elemento 'text'</assert>
			
			<!--16-->
			<!--Esenzioni-->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='57827-8']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='57827-8']]/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.2.17'])=1"
			>ERRORE-b60| Sezione Esenzioni: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.2.9.10.1.4.2.17'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='57827-8']])=0 or count(hl7:component/hl7:section[hl7:code[@code='57827-8']]/hl7:title)=1"
			>ERRORE-b61| Sezione Esenzioni: la sezione DEVE contenere un elemento 'title' possibilmente valorizzato con 'Esenzioni'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='57827-8']])=0 or count(hl7:component/hl7:section[hl7:code[@code='57827-8']]/hl7:text)=1"
			>ERRORE-b62| Sezione Esenzioni: la sezione DEVE contenere un elemento 'text'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='57827-8']])=0 or count(hl7:component/hl7:section[hl7:code[@code='57827-8']]/hl7:entry)&gt;=1"
			>ERRORE-b63| Sezione Esenzioni: la sezione DEVE contenere almeno un elemento 'entry'</assert>
			
			<!--17-->
			<!--Reti di patologia-->
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='PSSIT99']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='PSSIT99']]/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.2.18'])=1"
			>ERRORE-b64| Sezione Reti di patologia: la sezione DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.2.9.10.1.4.2.18'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='PSSIT99']])=0 or 
			count(hl7:component/hl7:section[hl7:code[@code='PSSIT99']]/hl7:code[@codeSystem='2.16.840.1.113883.2.9.5.2.8'])=1"
			>ERRORE-b65| Sezione Reti di patologia: la sezione DEVE contenere un elemento 'code' valorizzato con l'attributo @codeSystem='2.16.840.1.113883.2.9.5.2.8'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='PSSIT99']])=0 or count(hl7:component/hl7:section[hl7:code[@code='PSSIT99']]/hl7:title)=1"
			>ERRORE-b66| Sezione Reti di patologia: la sezione DEVE contenere un elemento 'title' possibilmente valorizzato con 'Reti di patologia'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='PSSIT99']])=0 or count(hl7:component/hl7:section[hl7:code[@code='PSSIT99']]/hl7:text)=1"
			>ERRORE-b67| Sezione Reti di patologia: la sezione DEVE contenere un elemento 'text'</assert>
			<assert test="count(hl7:component/hl7:section[hl7:code[@code='PSSIT99']])=0 or count(hl7:component/hl7:section[hl7:code[@code='PSSIT99']]/hl7:entry)&gt;=1"
			>ERRORE-b68| Sezione Reti di patologia: la sezione DEVE contenere almeno un elemento 'entry'</assert>
		
		</rule>
	
	
		<!--Controllo sui codici delle sezioni-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section">
			<let name="codice" value="hl7:code/@code"/>
			<assert test="count(hl7:code[@code='48765-2'][@codeSystem='2.16.840.1.113883.6.1'])=1 or 
			count(hl7:code[@code='10160-0'][@codeSystem='2.16.840.1.113883.6.1'])=1 or 
			count(hl7:code[@code='11369-6'][@codeSystem='2.16.840.1.113883.6.1'])=1 or
			count(hl7:code[@code='11450-4'][@codeSystem='2.16.840.1.113883.6.1'])=1 or 
			count(hl7:code[@code='10157-6'][@codeSystem='2.16.840.1.113883.6.1'])=1 or 
			count(hl7:code[@code='29762-2'][@codeSystem='2.16.840.1.113883.6.1'])=1 or
			count(hl7:code[@code='10162-6'][@codeSystem='2.16.840.1.113883.6.1'])=1 or 
			count(hl7:code[@code='8716-3'][@codeSystem='2.16.840.1.113883.6.1'])=1 or 
			count(hl7:code[@code='46264-8'][@codeSystem='2.16.840.1.113883.6.1'])=1 or
			count(hl7:code[@code='18776-5'][@codeSystem='2.16.840.1.113883.6.1'])=1 or 
			count(hl7:code[@code='47519-4'][@codeSystem='2.16.840.1.113883.6.1'])=1 or 
			count(hl7:code[@code='46240-8'][@codeSystem='2.16.840.1.113883.6.1'])=1 or
			count(hl7:code[@code='47420-5'][@codeSystem='2.16.840.1.113883.6.1'])=1 or 
			count(hl7:code[@code='30954-2'][@codeSystem='2.16.840.1.113883.6.1'])=1 or 
			count(hl7:code[@code='42348-3'][@codeSystem='2.16.840.1.113883.6.1'])=1 or 
			count(hl7:code[@code='57827-8'][@codeSystem='2.16.840.1.113883.6.1'])=1 or 
			count(hl7:code[@code='PSSIT99'][@codeSystem='2.16.840.1.113883.2.9.5.2.8'])=1"
			>ERRORE-b69| Il codice '<value-of select="$codice"/>' non è corretto. La sezione deve essere valorizzata con uno dei seguenti codici:
			48765-2		- Sezione Allergie e intolleranze
			10160-0		- Sezione Terapie farmacologiche
			11369-6		- Sezione Vaccinazioni
			11450-4		- Sezione Lista dei problemi
			10157-6		- Sezione Anamnesi familiare
			29762-2		- Sezione Stile di vita
			10162-6		- Sezione Gravidanze e parto
			8716-3		- Sezione Parametri vitali
			46264-8		- Sezione Protesi, impianti e ausili
			18776-5		- Sezione Piani di cura 
			47519-4 	- Sezione Trattamenti e procedure terapeutiche, chirurgiche e diagnostiche
			46240-8	  	- Sezione Visite e ricoveri
			47420-5		- Sezione Stato funzionale del paziente
			30954-2		- Sezione Indagini diagnostiche e esami di laboratorio
			42348-3		- Sezione Assenso/dissenso donazione organi
			57827-8		- Sezione Esenzioni
			PSSIT99		- Sezione Reti di patologia			
			</assert>
		</rule>	



		<!--1-->
		<!--Allergie e Intolleranze: controllo sulle entry-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='48765-2']]/hl7:entry">
			
			<assert test="count(hl7:act/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.1'])=1"
			>ERRORE-b70| Sezione Allergie e Intolleranze: entry/act DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.2.9.10.1.4.3.1.1'.</assert>
			<assert test="count(hl7:act/hl7:id)>=1"
			>ERRORE-71| Sezione Allergie e Intolleranze: entry/act DEVE contenere almeno un elemento 'id'.</assert>
			
			<assert test="count(hl7:act/hl7:code[@nullFlavor='NA'])=1"
			>ERRORE-72| Sezione Allergie e Intolleranze: entry/act DEVE contenere almeno un elemento 'code' valorizzato con @nullFlavor=NA.</assert>
			
			<assert test="count(hl7:act/hl7:statusCode)=1"
			>ERRORE-73| Sezione Allergie e Intolleranze: entry/act DEVE contenere almeno un elemento 'statusCode'</assert>
			
			<let name="status" value="hl7:act/hl7:statusCode/@code"/>
			<assert test="count(hl7:act/hl7:effectiveTime/hl7:low)=1 or count(hl7:act/hl7:effectiveTime[@nullFlavor='UNK'])=1"
			>ERRORE-b74| Sezione Allergie e Intolleranze: entry/act DEVE contenere un elemento 'effectiveTime' il quale deve avere l'elemento 'low' valorizzato, se non noto è possibile valorizzare l’elemento col @nullFlavor = UNK.</assert>
			<assert test="($status='completed' and count(hl7:act/hl7:effectiveTime/hl7:high)=1) or
					($status='aborted' and count(hl7:act/hl7:effectiveTime/hl7:high)=1) or 
					($status='suspended' and count(hl7:act/hl7:effectiveTime/hl7:high)=0) or 
					($status='active' and count(hl7:act/hl7:effectiveTime/hl7:high)=0)"
			>ERRORE-b75| Sezione Allergie e Intolleranze: entry/act/effectiveTime deve contenere l'elemento 'high' valorizzato nel caso in cui lo 'statusCode' è "completed"|"aborted".</assert>
			<assert test="(count(hl7:act/hl7:entryRelationship[hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.4']])=0 and 
			count(hl7:act/hl7:entryRelationship[hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.3']])=1) or
			(count(hl7:act/hl7:entryRelationship[hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.3']])=0 and 
			count(hl7:act/hl7:entryRelationship[hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.4']])=1)"
			>ERRORE-b76| Sezione Allergie e Intolleranze: entry/act DEVE contenere una sola entryRelationship/observation conenente l'elemento 'templateId' valorizzato nei seguenti modi:
			- @root='2.16.840.1.113883.2.9.10.1.4.3.1.4' per "Assenza allergie note" 
			- @root='2.16.840.1.113883.2.9.10.1.4.3.1.3' per "Presenza allergie e/o intolleranze".</assert>
			
			<!--Presenza  di allergie-->
			<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.3'])=0 or 
			count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:code[@code='52473-6'][@codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-77| Sezione Allergie e Intolleranze: è necessario valorizzare l'elemento entry/act/entryRelationship/observation/code con @code='52473-6' e @codeSystem='2.16.840.1.113883.6.1'.</assert>
			
			<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.3'])=0 or
			count(hl7:act/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.3']]/hl7:effectiveTime/hl7:low)=1"
			>ERRORE-b78| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation DEVE contenere un elemento 'effectiveTime' il quale deve avere l'elemento 'low' valorizzato.</assert>
			<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.3'])=0 or
			count(hl7:act/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.3']]/hl7:value[@xsi:type='CD'])=1"
			>ERRORE-b79| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation DEVE contenere un elemento 'value' con l'attributo @xsi:type="CD".</assert>			
			
			<let name="temp" value="hl7:act/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.3']]"/>
			<assert test="count($temp)=0 or 
			(count($temp/hl7:value/@code)=1 and count($temp/hl7:value/hl7:originalText/hl7:reference/@value)&lt;=1 and 
			count($temp/hl7:value[@codeSystem='2.16.840.1.113883.5.4' or @codeSystem='2.16.840.1.113883.1.11.19700'])=1) or 
			(count($temp/hl7:value/@code)=0 and count($temp/hl7:value/hl7:originalText/hl7:reference/@value)=1)"
			>ERRORE-b80| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation/value può essere valorizzato nei modi seguenti:
			- nel caso di 'value' non codificato DEVE avere l'elemento originalText/reference/@value valorizzato;
			- nel caso di 'value' codificato DEVE essere valorizzato con l'attributo @codeSystem='2.16.840.1.113883.5.4' o @codeSystem='2.16.840.1.113883.1.11.19700'</assert>
				
				<!--Descrizione Agente-->
				<assert test="count($temp)=0 or count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:participant)>=1"
				>ERRORE-b81| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation DEVE contenere almeno un 'participant' - "Descrizione Agente".</assert>
				
				<!--Criticità allergia-->
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='SUBJ'][hl7:observation])=0 or 
				count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.5.3'])=1"
				>ERRORE-b82| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation/entryRelationship/observation (Criticità di un'allergia o intolleranza) DEVE includere l'identificativo 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.2.9.10.1.4.3.1.5.3' </assert>
				
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='SUBJ'][hl7:observation])=0 or 
				count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='SUBJ'][hl7:observation]/hl7:observation/hl7:code[@code='SEV'][@codeSystem='2.16.840.1.113883.5.4'])=1"
				>ERRORE-b83| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation/entryRelationship/observation (Criticità di un'allergia o intolleranza) DEVE avere un elemento 'code'valorizzato con gli attributi @code='SEV' e codeSystem='2.16.840.1.113883.5.4'.</assert>
				
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='SUBJ'][hl7:observation])=0 or 
				count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='SUBJ'][hl7:observation]/hl7:observation/hl7:value[@xsi:type='CD'])=1"
				>ERRORE-b84| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation/entryRelationship/observation (Criticità di un'allergia o intolleranza) DEVE avere un elemento 'value' con l'attributo @xsi:type='CD'.</assert>
				
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='SUBJ'][hl7:observation])=0 or 
				count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship/hl7:observation/hl7:value[@codeSystem='2.16.840.1.113883.5.1063'])=1"
				>ERRORE-b85| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation/entryRelationship/observation/value (Criticità di un'allergia o intolleranza) DEVE essere derivato dal value set "CriticalityObservation" - @codeSystem='2.16.840.1.113883.5.1063'.</assert>
				
				<!--Stato allergia-->
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='REFR'])=0 or
				count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.6'])=1"
				>ERRORE-b86| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation/entryRelationship/observation (Stato di un'allergia) DEVE includere l'identificativo 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.2.9.10.1.4.3.1.6'.</assert>
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='REFR'])=0 or
				count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship/hl7:observation/hl7:code[@code='33999-4'][@codeSystem='2.16.840.1.113883.6.1'])=1"
				>ERRORE-b87| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation/entryRelationship/observation (Stato di un'allergia) DEVE contenere un elemento 'code' valorizzato con gli attributi @code='33999-4' e @codeSystem='2.16.840.1.113883.6.1'.</assert>
				
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='REFR'])=0 or
				count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='REFR']/hl7:observation/hl7:statusCode)=1"
				>ERRORE-b88| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation/entryRelationship/observation (Stato di un'allergia) DEVE contenere un elemento 'statusCode'.</assert>
				
				
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='REFR'])=0 or
				count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship/hl7:observation/hl7:value[@codeSystem='2.16.840.1.113883.2.9.77.22.11.11' or @codeSystem='2.16.840.1.113883.6.1'])=1"
				>ERRORE-b89| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation/entryRelationship/observation (Stato di un'allergia) DEVE avere un elemento 'value' valorizzato secondo il value set "Stato clinico allergia" - @codeSystem='2.16.840.1.113883.6.1' oppure @codeSystem='2.16.840.1.113883.2.9.77.22.11.11'. </assert>
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='REFR'])=0 or
				(count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship/hl7:observation/hl7:value[@code='LA16666-2'])=1 or
				count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship/hl7:observation/hl7:value[@code='LA18632-2'])=1)"
				>ERRORE-b90| Sezione Allergie e Intolleranze: il @code di entry/act/entryRelationship/observation/entryRelationship/observation/value (Stato di un'allergia) deve essere valorizzato con:
				- "LA16666-2" se "active";
				- "LA18632-2" se "inactive".
				</assert>
				
				
				<!--Note e commenti-->
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='SUBJ'][hl7:act])=0 or
				count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship/hl7:act/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.7'])=1"
				>ERRORE-b91| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation/entryRelationship/observation (Note e commenti) DEVE contenere un 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.2.9.10.1.4.3.1.7'.</assert>
				
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='SUBJ'][hl7:act])=0 or
				count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship/hl7:act/hl7:code[@code='48767-8'][@codeSystem='2.16.840.1.113883.6.1'])=1"
				>ERRORE-b92| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation/entryRelationship/observation (Note e commenti) DEVE contenere un 'code' valorizzato con l'attributo @code='48767-8' e codeSystem='2.16.840.1.113883.6.1'.</assert>
				
				<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship[@typeCode='SUBJ'][hl7:act])=0 or
				count(hl7:act/hl7:entryRelationship/hl7:observation/hl7:entryRelationship/hl7:act/hl7:statusCode)=1"
				>ERRORE-b93| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation/entryRelationship/observation (Note e commenti) DEVE contenere un elemento 'statusCode' .</assert>
			
						
			<!--Assenza allergia-->
			<let name="temp_abs" value="hl7:act/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.4']]"/>
			<assert test="count($temp_abs)=0 or 
			count(hl7:act/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.4']]/hl7:code[@code='OINT'][@codeSystem='2.16.840.1.113883.5.4' or @codeSystem='2.16.840.1.113883.1.11.19700'])=1"
			>ERRORE-b94| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation DEVE avere un elemento 'code' valorizzato con @code='OINT' e @codeSystem='2.16.840.1.113883.5.4' o @codeSystem='2.16.840.1.113883.1.11.19700'.</assert>
			
			
			<assert test="count($temp_abs)=0 or (count($temp_abs/hl7:id)=1)"
			>ERRORE-b95| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation/id DEVE essere Presente  
			</assert>
			
			<assert test="count($temp_abs)=0 or (count($temp_abs/hl7:statusCode[@code='completed'])=1)"
			>ERRORE-b96| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation/statusCode DEVE  essere presente con code='completed'  
			</assert>
			
			<assert test="count($temp_abs)=0 or (count($temp_abs/hl7:effectiveTime/hl7:low)=1) or (count($temp_abs/hl7:effectiveTime[@code='UNK'])=1)"
			>ERRORE-b97| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation/effectiveTime/low DEVE  essere presente la data di inizio dello stato di assenza delle allergie note. Se non si conosce questo valore deve essere valorizzato con @nullFlavor = UNK 
			</assert>
			
			<assert test="count($temp_abs)=0 or 
			(count($temp_abs/hl7:value/@code)=1 and	
			count($temp_abs/hl7:value[@codeSystem='2.16.840.1.113883.11.22.9'])=1
			and count($temp_abs/hl7:value/hl7:originalText/hl7:reference/@value)&lt;=1)"
			>ERRORE-b98| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation/value DEVE essere valorizzato secondo il value set "Absent or Unknown allergies" @codeSystem='2.16.840.1.113883.11.22.9'  
			</assert>
				
			
		</rule>
			
			<!--Descrizione Agente-->
			<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='48765-2']]/hl7:entry/hl7:act/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.3']]/hl7:participant">	
				
			
				<assert test="count(hl7:participantRole/hl7:playingEntity/hl7:code[(@nullFlavor='UNK' or @nullFlavor='NI') and not(@code or @codeSystem or @codeSystemName or @displayName)])=1 or
					count(hl7:participantRole/hl7:playingEntity/hl7:code[@code and @codeSystem='2.16.840.1.113883.6.73' and not(@nullFlavor)])=1 or
					count(hl7:participantRole/hl7:playingEntity/hl7:code[@code and @codeSystem='2.16.840.1.113883.2.9.6.1.5' and not(@nullFlavor)])=1 or
					count(hl7:participantRole/hl7:playingEntity/hl7:code[@code and @codeSystem='2.16.840.1.113883.2.9.77.22.11.2' and not(@nullFlavor)])=1"
					>ERRORE-b99| Sotto sezione Allergie: L'elemento participant/participantRole/playingEntity deve avere l'elemento code valorizzato con:
					- @nullFlavor='UNK' nel caso in cui non è noto l'agente che ha causato la reazione allergica
					- @nullFlavor='NI' nel caso in cui  l’agente scatenante non sia descrivibile attraverso una codifica
					- code/@codeSystem valorizzato come segue:
						- '2.16.840.1.113883.6.73' per la codifica "WHO ATC"
						- '2.16.840.1.113883.2.9.6.1.5' per la codifica "AIC"
						- '2.16.840.1.113883.2.9.77.22.11.2' per il value set "AllergenNoDrugs" (- per le allergie non a farmaci –)
				</assert>		
				
			
				<assert test="count(hl7:participantRole/hl7:playingEntity/hl7:code[@code])=1 or count(hl7:participantRole/hl7:playingEntity/hl7:code[@nullFlavor]/hl7:originalText/hl7:reference)=1"
				>ERRORE-b100| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation/participant/participantRole/playingEntity DEVE contenere l'elemento originalText/reference.</assert>
				
			</rule>
			<!--Descrizione Reazioni-->
			<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='48765-2']]/hl7:entry/hl7:act/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.3']]/hl7:entryRelationship[@typeCode='MFST']">	
				
				<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.5.1' or @root='2.16.840.1.113883.2.9.10.1.4.3.1.5.2'])=1"
				>ERRORE-b101| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation/entryRelationship/observation (Descrizione reazioni) DEVE contenere il 'templateId' valorizzato come segue:
				- @root='2.16.840.1.113883.2.9.10.1.4.3.1.5.1' nel caso di Descrizione Reazione codificato
				- @root='2.16.840.1.113883.2.9.10.1.4.3.1.5.2' nel caso di Descrizione reazione non codificato.</assert>	
				
				<assert test="count(hl7:observation/hl7:code[@code='75321-0'][@codeSystem='2.16.840.1.113883.6.1'])=1"
				>ERRORE-b102| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation/entryRelationship/observation (Descrizione reazioni) DEVE contenere l'elemento 'code' valorizzato con i seguenti attributi @code='75321-0' e @codeSystem='2.16.840.1.113883.6.1'. </assert>
				
				<assert test="count(hl7:observation/hl7:effectiveTime/hl7:low)=1 or count(hl7:observation/hl7:effectiveTime/hl7:low[@nullFlavor='UNK'])=1"
				>ERRORE-b103| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation/entryRelationship/observation (Descrizione reazioni) DEVE contenere un elemento 'effectiveTime' il quale deve avere l'elemento 'low' valorizzato, se non noto è possibile valorizzare l’elemento col @nullFlavor = UNK. </assert>
				
				<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.5.1'])=0 or
				count(hl7:observation/hl7:value[@xsi:type='CD'])=1"
				>ERRORE-b104| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation/entryRelationship/observation/value (Descrizione reazioni) DEVE avere l'elemento Value con @xsi:type='CD'
				</assert>
				
				<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.5.1'])=0 or
				count(hl7:observation/hl7:value[@codeSystem='2.16.840.1.113883.2.9.77.22.11.3' or @codeSystem='2.16.840.1.113883.2.9.77.22.11.4' or @codeSystem='2.16.840.1.113883.6.103'])=1"
				>ERRORE-b105| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation/entryRelationship/observation/value (Descrizione reazioni) DEVE essere valorizzato secondo i seguenti dizionari:
				- 2.16.840.1.113883.2.9.77.22.11.3		Value Set Reazioni Intolleranza
				- 2.16.840.1.113883.2.9.77.22.11.4 		Value Set Reazioni Allergiche
				- 2.16.840.1.113883.6.103				ICD-9-CM
				</assert>				
				<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.5.2'])=0 or
				count(hl7:observation/hl7:value/hl7:originalText/hl7:reference)=1"
				>ERRORE-b106| Sezione Allergie e Intolleranze: entry/act/entryRelationship/observation/entryRelationship/observation/value (Descrizione reazioni) DEVE contenere l'elemento originalText/reference.</assert>
				
			</rule>

		
		
		<!--2-->
		<!--Sezione Terapie farmacologiche: controllo sulle entry-->			
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='10160-0']]/hl7:entry">
			<assert test="count(hl7:substanceAdministration[@moodCode='INT' or @moodCode='EVN'])=1"
			>ERRORE-b107| Sezione Terapia Farmacologica: entry DEVE contenere un elemento di tipo 'substanceAdministration' con attributo @moodCode valrizzato con 'INT' o 'EVN'. </assert>
			<assert test="(count(hl7:substanceAdministration/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.2.1'])=1 or
						  count(hl7:substanceAdministration/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.2.3'])=1)"
			>ERRORE-b101| Sezione Terapia Farmacologica: entry/substanceAdministration DEVE contenere un elemento 'templateId' valorizato come segue:
			- @root='2.16.840.1.113883.2.9.10.1.4.3.2.1' per Terapia o 
			- @root='2.16.840.1.113883.2.9.10.1.4.3.2.3' per Assenza di terapia</assert>
		<!--Terapia-->
			<assert test="count(hl7:substanceAdministration/hl7:text)=0 or count(hl7:substanceAdministration/hl7:text/hl7:reference[@value])=1"
			>ERRORE-b108| Sezione Terapia Farmacologica: entry/substanceAdministration/text DEVE contenere l'elemento reference/@value valorizzato con l’URI che punta alla descrizione della terapia nel narrative block della sezione.</assert>
			
			<assert test="count(hl7:substanceAdministration/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.2.1'])=0 or count(hl7:substanceAdministration[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.2.1']]/hl7:statusCode)=1"
			>ERRORE-b109| Sezione Terapia Farmacologica: entry/substanceAdministration DEVE contenere l'elemento statusCode.</assert>
							
			<assert test="count(hl7:substanceAdministration/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.2.1'])=0 or
			count(hl7:substanceAdministration/hl7:effectiveTime[@xsi:type='IVL_TS']/hl7:low)=1 or count(hl7:substanceAdministration/hl7:effectiveTime[@nullFlavor='UNK'])=1"
			>ERRORE-b110| Sezione Terapia Farmacologica: entry/substanceAdministration/effectiveTime DEVE essere presente e deve avere l'elemento 'low' valorizzato, nel caso non se ne conosca il valore deve essere valorizzato con @nullflavor="UNK"  </assert>					
			
			<let name="status" value="hl7:substanceAdministration/hl7:statusCode/@code"/>
			<assert test="count(hl7:substanceAdministration/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.2.1'])=0 or
			($status='completed' and count(hl7:substanceAdministration/hl7:effectiveTime[@xsi:type='IVL_TS']/hl7:high)=1) or
			($status='aborted' and count(hl7:substanceAdministration/hl7:effectiveTime[@xsi:type='IVL_TS']/hl7:high)=1) or 
			($status='suspended' and count(hl7:substanceAdministration/hl7:effectiveTime[@xsi:type='IVL_TS']/hl7:high)=0) or 
			($status='active' and count(hl7:substanceAdministration/hl7:effectiveTime[@xsi:type='IVL_TS']/hl7:high)=0)"
			>ERRORE-b111| Sezione Terapia Farmacologica: entry/substanceAdministration/effectiveTime/high DEVE essere presente nel caso in cui lo 'statusCode' sia 'completed' oppure 'aborted'
			</assert>	
			
			<assert test="count(hl7:substanceAdministration/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.2.1'])=0 or count(hl7:substanceAdministration/hl7:routeCode[@code and @codeSystem])=1 " 
			>ERRORE-b112| Sezione Terapia Farmacologica: entry/substanceAdministration/routeCode  DEVE essere presente .</assert>
			
			<assert test="count(hl7:substanceAdministration/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.2.1'])=0 or
			count(hl7:substanceAdministration/hl7:consumable/hl7:manufacturedProduct/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.2.2'])=1"
			>ERRORE-b113| Sezione Terapia Farmacologica: entry/substanceAdministration/consumable/manufacturedProduct DEVE contenere un elemento 'templateId' valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.2.2'.</assert>
			<let name="farma" value="hl7:substanceAdministration[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.2.1']]/hl7:consumable/hl7:manufacturedProduct/hl7:manufacturedMaterial"/>
			<assert test="count(hl7:substanceAdministration[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.2.1']])=0 or 
			(count($farma/hl7:code[@codeSystem='2.16.840.1.113883.2.9.6.1.5'])=1 or 
			count($farma/hl7:code[@codeSystem='2.16.840.1.113883.6.73'])=1 or
			count($farma/hl7:code[@codeSystem='2.16.840.1.113883.2.9.6.1.51'])=1)"
			>ERRORE-b114| Sezione Terapia Farmacologica: entry/substanceAdministration/consumable/manufacturedProduct/manufacturedMaterial deve contenere un elemento 'code' valorizzato secondo i seguenti sistemi di codifica:
			- @codeSystem='2.16.840.1.113883.2.9.6.1.5' 	(AIC)
			- @codeSystem='2.16.840.1.113883.6.73'			(ATC)
			- @codeSystem='2.16.840.1.113883.2.9.6.1.51'	(GE)
			</assert>			
			<let name="trans_vl" value="hl7:substanceAdministration[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.2.1']]/hl7:consumable/hl7:manufacturedProduct/hl7:manufacturedMaterial"/>
			<assert test="count($trans_vl/hl7:code/hl7:translation)=0 or
			(count($trans_vl/hl7:code[@codeSystem='2.16.840.1.113883.6.73']/hl7:translation[@codeSystem='2.16.840.1.113883.2.9.6.1.5'])=1 or
			count($trans_vl/hl7:code[@codeSystem='2.16.840.1.113883.6.73']/hl7:translation[@codeSystem='2.16.840.1.113883.2.9.6.1.51'])=1 or
			count($trans_vl/hl7:code[@codeSystem='2.16.840.1.113883.2.9.6.1.5']/hl7:translation[@codeSystem='2.16.840.1.113883.6.73'])=1 or
			count($trans_vl/hl7:code[@codeSystem='2.16.840.1.113883.2.9.6.1.5']/hl7:translation[@codeSystem='2.16.840.1.113883.2.9.6.1.51'])=1 or
			count($trans_vl/hl7:code[@codeSystem='2.16.840.1.113883.2.9.6.1.51']/hl7:translation[@codeSystem='2.16.840.1.113883.6.73'])=1 or
			count($trans_vl/hl7:code[@codeSystem='2.16.840.1.113883.2.9.6.1.51']/hl7:translation[@codeSystem='2.16.840.1.113883.2.9.6.1.5'])=1)"
			>ERRORE-b115| Sezione Terapia farmacologica: entry/substanceAdministration/consumable/manufacturedProduct/manufacturedMaterial/code/translation, Se presente, DEVE essere valorizzato secondo i seguenti sistemi di codifica:
			@codeSystem='2.16.840.1.113883.6.73' (ATC)
			@codeSystem='2.16.840.1.113883.2.9.6.1.5' (AIC)
			@codeSystem='2.16.840.1.113883.2.9.6.1.51' (GE)</assert>
			
			<!--Indicazione assenza terapie note-->
			<assert test="count(hl7:substanceAdministration/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.2.3'])=0 or 
			count(hl7:substanceAdministration/hl7:code[@codeSystem='2.16.840.1.113883.11.22.15'])=1"
			>ERRORE-b116| Sezione Terapia farmacologica: entry/substanceAdministration/code DEVE essere valorizzato secondo il value set @codeSystem='2.16.840.1.113883.11.22.15'(Absent or Unknown Medication)</assert>

			
		</rule>


		
		<!--3-->
		<!--Vaccinazioni controlli sulla entry-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='11369-6']]/hl7:entry">
	   
			<assert test="count(hl7:substanceAdministration)=1 and count(hl7:substanceAdministration/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.3.1'])=1"
			>ERRORE-b117| Sezione Vaccinazioni: entry/substanceAdministration DEVE essere conforme al 'templateId' valorizzato con  @root='2.16.840.1.113883.2.9.10.1.4.3.3.1'
			</assert>
			<assert test="count(hl7:substanceAdministration/hl7:code[@code='IMMUNIZ'][@codeSystem='2.16.840.1.113883.5.4'])=1 "
			>ERRORE-b118| Sezione Vaccinazioni: entry/substanceAdministration DEVE contenere un 'code' valorizzato con il gli attributi @code='IMMUNIZ' e @codeSystem='2.16.840.1.113883.5.4' </assert>		   
			<assert test="count(hl7:substanceAdministration/hl7:text)=0 or count(hl7:substanceAdministration/hl7:text/hl7:reference/@value)=1"
			>ERRORE-b119| Sezione Vaccinazioni: entry/substanceAdministration/text/reference DEVE contenere l'attributo @value valorizzato con l’URI che punta alla descrizione della terapia nel narrative block della sezione.</assert>
			<assert test="count(hl7:substanceAdministration/hl7:statusCode[@code='completed'])=1 "
			>ERRORE-b120| Sezione Vaccinazioni: entry/substanceAdministration DEVE contenere uno statusCode valorizzato @code='completed' </assert> 
			
			<assert test="count(hl7:substanceAdministration/hl7:effectiveTime)=1 or count(hl7:substanceAdministration/hl7:effectiveTime[@nullFlavor='UNK'])=1 "
			>ERRORE-b121| Sezione Vaccinazioni: entry/substanceAdministration DEVE contenere un effectiveTime. Se la data è sconosciuta, questo va registrato attraverso l’uso dell’opportuno attributo @nullFlavor=“UNK” </assert> 

			
			<assert test="count(hl7:substanceAdministration/hl7:consumable/hl7:manufacturedProduct/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.3.2'])=1"
			>ERRORE-b122| Sezione Vaccinazioni: entry/substanceAdministration/consumable/manufacturedProduct DEVE contenere l'elemento 'templateId' valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.3.2'</assert>			   		
			<let name="farma_vacc" value="hl7:substanceAdministration/hl7:consumable/hl7:manufacturedProduct/hl7:manufacturedMaterial"/>
			<assert test=" (count($farma_vacc/hl7:code[@nullFlavor='OTH'])=1 and 
			count($farma_vacc/hl7:code/hl7:originalText/hl7:reference)=1) or
			count($farma_vacc/hl7:code[@codeSystem='2.16.840.1.113883.2.9.6.1.5'])=1 or 
			count($farma_vacc/hl7:code[@codeSystem='2.16.840.1.113883.6.73'])=1"
			>ERRORE-b123| Sezione Vaccinazioni: entry/substanceAdministration/consumable/manufacturedProduct/manufacturedMaterial DEVE contenere un elemento 'code' valorizzato secondo i seguenti sistemi di codifica:
			- @codeSystem='2.16.840.1.113883.2.9.6.1.5' 	(AIC)
			- @codeSystem='2.16.840.1.113883.6.73'			(ATC)
			</assert>			
			<let name="trans_vacc" value="hl7:substanceAdministration/hl7:consumable/hl7:manufacturedProduct/hl7:manufacturedMaterial"/>
			<assert test="count($trans_vacc/hl7:code/hl7:translation)=0 or
			(count($trans_vacc/hl7:code[@codeSystem='2.16.840.1.113883.6.73']/hl7:translation[@codeSystem='2.16.840.1.113883.2.9.6.1.5'])=1 or
			count($trans_vacc/hl7:code[@codeSystem='2.16.840.1.113883.2.9.6.1.5']/hl7:translation[@codeSystem='2.16.840.1.113883.6.73'])=1)"
			>ERRORE-b124| Sezione Vaccinazioni: entry/substanceAdministration/consumable/manufacturedProduct/manufacturedMaterial/code/translation se presente, DEVE essere valorizzato secondo i seguenti sistemi di codifica:
			@codeSystem='2.16.840.1.113883.6.73' (ATC)
			@codeSystem='2.16.840.1.113883.2.9.6.1.5' (AIC)</assert>	
			<assert test="count(hl7:substanceAdministration/hl7:consumable/hl7:manufacturedProduct/hl7:manufacturedMaterial/hl7:lotNumberText)=1"
			>ERRORE-b125| Sezione Vaccinazioni: entry/substanceAdministration/consumable/manufacturedProduct/manufacturedMaterial DEVE contenere un elemento 'lotNumberText'. </assert> 
					
			<!--periodo di copertura-->
			<assert test="count(hl7:substanceAdministration/hl7:entryRelationship[@typeCode='REFR']/hl7:observation/hl7:templateId)=0 or count(hl7:substanceAdministration/hl7:entryRelationship[@typeCode='REFR']/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.3.3'])=1"
			>ERRORE-b127| Sezione Vaccinazioni: entry/substanceAdministration può contenere  al più un entryRelationship/obersavation che descrive il "Periodo di copertura" conforme al 'templateId' @root='2.16.840.1.113883.2.9.10.1.4.3.3.3' </assert> 	  
			<assert test="count(hl7:substanceAdministration/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.3.3'])=0 or
			count(hl7:substanceAdministration/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.3.3']]/hl7:code[@code='59781-5'][@codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b128| Sezione Vaccinazioni: entry/substanceAdministration/entryReletionship/observation (Periodo di copertura) DEVE avere un elemento 'code' valorizzato con @code='59781-5' e @codeSystem='2.16.840.1.113883.6.1' </assert> 
			<assert test="count(hl7:substanceAdministration/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.3.3'])=0 or
			count(hl7:substanceAdministration/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.3.3']]/hl7:statusCode[@code='completed'])=1"
			>ERRORE-b129| Sezione Vaccinazioni: entry/substanceAdministration/entryReletionship/observation (Periodo di copertura) DEVE contenere un elemento 'statusCode' valorizzato con 'completed'</assert> 
			<assert test="count(hl7:substanceAdministration/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.3.3'])=0 or
			count(hl7:substanceAdministration/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.3.3']]/hl7:value/hl7:high)=1"
			>ERRORE-b130| Sezione Vaccinazioni: entry/substanceAdministration/entryReletionship/observation (Periodo di copertura) DEVE deve contenere un elemento 'value' il quale deve avere l'elemento 'high' valorizzato. </assert> 
	 
			<!--numero di dose-->
			<assert test="count(hl7:substanceAdministration/hl7:entryRelationship[@typeCode='SUBJ']/hl7:observation/hl7:templateId)=0 or count(hl7:substanceAdministration/hl7:entryRelationship[@typeCode='SUBJ']  /hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.3.4'])=1"
			>ERRORE-b131| Sezione Vaccinazioni: entry/substanceAdministration può contenere al più un entryRelationship/obersavation che descrive il "Numero delle dose" conforme al 'templateId' @root='2.16.840.1.113883.2.9.10.1.4.3.3.4'.</assert> 
			<assert test="count(hl7:substanceAdministration/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.3.4'])=0 or
			count(hl7:substanceAdministration/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.3.4']]/hl7:code[@code='30973-2'][@codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b132| Sezione Vaccinazioni: entry/substanceAdministration/entryReletionship/observation (Numero delle dosi) DEVE contenere un elemento 'code' valorizzato con @code='30973-2' e @codeSystem='2.16.840.1.113883.6.1' </assert> 
			<assert test="count(hl7:substanceAdministration/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.3.4'])=0 or
			count(hl7:substanceAdministration/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.3.4']]/hl7:statusCode[@code='completed'])=1"
			>ERRORE-b133| Sezione Vaccinazioni: entry/substanceAdministration/entryReletionship/observation (Numero delle dosi) DEVE deve contenere un elemento 'statusCode' valorizzato con @code='completed' </assert> 
			<assert test="count(hl7:substanceAdministration/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.3.4'])=0 or
			count(hl7:substanceAdministration/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.3.4']]/hl7:value[@xsi:type='INT'])=1"
			>ERRORE-b134| Sezione Vaccinazioni: entry/substanceAdministration/entryReletionship/observation (Numero delle dosi) DEVE contenere un elemento 'value' il cui attributo @xsi:type='INT' </assert> 
		 	<assert test="count(hl7:substanceAdministration/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.3.4'])=0 or
			count(hl7:substanceAdministration/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.3.4']]/hl7:value/@value)=1"
			>ERRORE-b135| Sezione Vaccinazioni: entry/substanceAdministration/entryReletionship/observation/value DEVE avere l'attributo @value valorizzato</assert> 
		 	
			<!--annotazioni e commenti-->
			<assert test="count(hl7:substanceAdministration/hl7:entryRelationship/hl7:act)=0 or 
			count(hl7:substanceAdministration/hl7:entryRelationship/hl7:act/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.7'])=1"
			>ERRORE-b136| Sezione Vaccinazioni: entry/substanceAdministration/entryRelationship/act relativo a "Annotazioni e commenti" deve contenere l'elemento 'templateId' valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.1.7' </assert>
			
			<assert test="count(hl7:substanceAdministration/hl7:entryRelationship/hl7:act)=0 or 
			count(hl7:substanceAdministration/hl7:entryRelationship/hl7:act/hl7:statusCode)=1"
			>ERRORE-b137| Sezione Vaccinazioni: entry/substanceAdministration/entryRelationship/act relativo a "Annotazioni e commenti" deve contenere l'elemento 'statusCode'</assert>

			<assert test="count(hl7:substanceAdministration/hl7:entryRelationship/hl7:act)=0 or
			count(hl7:substanceAdministration/hl7:entryRelationship/hl7:act/hl7:code[@code='48767-8' and @codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b138| Sezione Vaccinazioni: entry/act/entryRelationship/observation/entryRelationship/observation (Note e commenti) DEVE contenere un 'code' valorizzato con l'attributo @code='48767-8' e codeSystem='2.16.840.1.113883.6.1'.</assert>			
			
	   </rule>	
		
			<!--Vaccinazioni: descrizione reazioni avversa-->
			<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='11369-6']]/hl7:entry/hl7:substanceAdministration/hl7:entryRelationship[@typeCode='CAUS']">
				
				<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.5.1' or @root='2.16.840.1.113883.2.9.10.1.4.3.1.5.2'])=1"
				>ERRORE-b139| Sezione Vaccinazioni: entry/substanceAdministration/entryRelationship/observation (Descrizione reazione) DEVE essere conforme al 'templateId' @root='2.16.840.1.113883.2.9.10.1.4.3.1.5.1' (Descrizione reazione codificata) o '2.16.840.1.113883.2.9.10.1.4.3.1.5.2' (Descrizione reazione non codificata)</assert> 
				
				<assert test="count(hl7:observation/hl7:code[@code='75321-0'][@codeSystem='2.16.840.1.113883.6.1'])=1"
				>ERRORE-b140| Sezione Vaccinazioni: entry/substanceAdministration/entryRelationship/observation (Descrizione reazione) DEVE contenere l'elemento 'code' valorizzato con @code='75321-0' e @codeSystem='2.16.840.1.113883.6.1'. </assert>
				
				<assert test="count(hl7:observation/hl7:statusCode)=1"
				>ERRORE-b141| Sezione Vaccinazioni: entry/substanceAdministration/entryRelationship/observation (Descrizione reazione) DEVE contenere l'elemento 'statusCode'. </assert>
				
				<assert test="count(hl7:observation/hl7:effectiveTime/hl7:low)=1 or count(hl7:observation/hl7:effectiveTime/hl7:low[@nullFlavor='UNK'])=1 "
				>ERRORE-b142| Sezione Vaccinazioni: entry/substanceAdministration/entryRelationship/observation (Descrizione reazione) DEVE contenere l'elemento 'effectiveTime/low' per riportare la data di inizio in cui si è presentata la reazione avversa. Se non si conosce questo valore deve essere valorizzato con @nullFlavor = UNK. </assert>
				
				
				<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.5.1'])=0 or
				count(hl7:observation/hl7:value[@xsi:type='CD'])=1"
				>ERRORE-b143| Sezione Vaccinazioni: entry/substanceAdministration/entryRelationship/observation (Descrizione reazione) DEVE contenere l'elemento 'value' con @xsi:type='CD'
				</assert>
				
				<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.5.1'])=0 or
				count(hl7:observation/hl7:value[@code])=0 or
				count(hl7:observation/hl7:value[@codeSystem='2.16.840.1.113883.2.9.77.22.11.3' or @codeSystem='2.16.840.1.113883.2.9.77.22.11.4' or @codeSystem='2.16.840.1.113883.6.103'])=1"
				>ERRORE-b144| Sezione Vaccinazioni: entry/substanceAdministration/entryRelationship/observation (Descrizione reazione) DEVE contenere l'elemento 'value' valorizzato secondo i seguenti sistemi di codifica:
				- 2.16.840.1.113883.2.9.77.22.11.3		Value Set Reazioni Intolleranza
				- 2.16.840.1.113883.2.9.77.22.11.4 		Value Set Reazioni Allergiche
				-2.16.840.1.113883.6.103				ICD-9-CM
				</assert>		
				
				<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.5.1'])=0 or
				count(hl7:observation/hl7:value[@xsi:type='CD']/hl7:originalText/hl7:reference)=1"
				>ERRORE-b145| Sezione Vaccinazioni: entry/substanceAdministration/entryRelationship/observation/value (Descrizione reazione) DEVE contenere l'elemento originalText/reference.</assert>
					
			</rule>
		
		
		<!--4-->
		<!--Sezione Lista dei problemi: problema (entry/act)-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='11450-4']]/hl7:entry">
			
			<assert test="count(hl7:act[@classCode='ACT'][@moodCode='EVN'])=1"
			>ERRORE-b146| Sezione Lista dei problemi: la 'entry' DEVE essere di tipo 'act' valorizzato con gli attributi @classCode='ACT' e @moodCode='EVN'</assert>
			
			
			
			<assert test="count(hl7:act/hl7:templateId)=0 or count(hl7:act/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.4.1'])=1"
			>ERRORE-b147| Sezione Lista dei problemi: entry/act DEVE contenere un elemento 'templateId' valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.4.1'.</assert>
			
			
			<assert test="count(hl7:act/hl7:id)=1"
			>ERRORE-b148| Sezione Lista dei problemi: entry/act DEVE contenere un elemento 'id' .</assert>
			
			
			<assert test="count(hl7:act/hl7:code[@nullFlavor='NA'])=1"
			>ERRORE-b149| Sezione Lista dei problemi: entry/act DEVE contenere un elemento 'code' con @nullFlavor='NA'.</assert>
			
			<assert test="count(hl7:act/hl7:statusCode)=1"
			>ERRORE-b150| Sezione Lista dei problemi: entry/act DEVE contenere un elemento 'statusCode'.</assert>
			
			
			<assert test="count(hl7:act/hl7:effectiveTime/hl7:low)=1 or count(hl7:act/hl7:effectiveTime[@nullFlavor='UNK'])=1"
			>ERRORE-b151| Sezione Lista dei problemi: entry/act DEVE contenere un elemento 'effectiveTime' il quale deve avere l'elemento 'low' valorizzato, se non noto è possibile valorizzare l’elemento col @nullFlavor = UNK.</assert>
			
			<assert test="count(hl7:act/hl7:effectiveTime[@nullFlavor='UNK'])=1 or 
					(hl7:act/hl7:statusCode[@code='completed'] and count(hl7:act/hl7:effectiveTime/hl7:high)=1) or
					(hl7:act/hl7:statusCode[@code='aborted'] and count(hl7:act/hl7:effectiveTime/hl7:high)=1) or 
					(hl7:act/hl7:statusCode[@code='suspended'] and count(hl7:act/hl7:effectiveTime/hl7:high)=0) or 
					(hl7:act/hl7:statusCode[@code='active'] and count(hl7:act/hl7:effectiveTime/hl7:high)=0)"
			>ERRORE-b152| Sezione Lista dei problemi: entry/act/effectiveTime deve contenere l'elemento 'high' valorizzato nel caso in cui lo 'statusCode' è "completed"|"aborted".</assert>
			
			
			<assert test="count(hl7:act/hl7:entryRelationship/hl7:observation)&gt;=1"
			>ERRORE-b153| Sezione Lista dei problemi: entry/act DEVE contenere almeno una entryRelationship/observation relativa ai "Dettagli del problema" </assert>
			
			
		</rule>
		
			<!--Sezione Lista dei problemi: dettagli problema (entry/act/entryRelationship/observation)-->
			<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='11450-4']]/hl7:entry/hl7:act/hl7:entryRelationship">
			
				<assert test="count(hl7:observation)=1 or count(hl7:act)=1"
				>ERRORE-b154| Sezione Lista dei problemi: l'elemento entry/act/entryRelationship deve avere uno dei seguenti sotto elementi:
				- 'observation': per i dettagli del problema;
				- 'act': per i riferimenti interni al problema;</assert>
				
				<!-- observation - Dettagli Problema -->
				<assert test="count(hl7:observation)=0 or count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.4.2'])=1"
				>ERRORE-b155| Sezione Lista dei problemi: entry/act/entryRelationship/observation deve avere un elemento templateId con attributo @root='2.16.840.1.113883.2.9.10.1.4.3.4.2'</assert>
				<assert test="count(hl7:observation)=0 or count(hl7:observation/hl7:id)=1"
				>ERRORE-b156| Sezione Lista dei problemi: entry/act/entryRelationship/observation deve contenere l'elemento id </assert>	

				<assert test="count(hl7:observation)=0 or count(hl7:observation/hl7:statusCode)=1"
				>ERRORE-b157| Sezione Lista dei problemi: entry/act/entryRelationship/observation deve contenere l'elemento statusCode </assert>				
				
				<assert test="count(hl7:observation)=0 or count(hl7:observation/hl7:effectiveTime/hl7:low)=1 or count(hl7:observation/hl7:effectiveTime[@nullFlavor='UNK'])=1"
				>ERRORE-b158| Sezione Lista dei problemi: entry/act/entryRelationship/observation/effectiveTime deve contenere l'elemento low e deve essere valorizzato, se non se ne conosca il valore deve essere valorizzato con @nullFlavor='UNK'</assert>
				
				<assert test="count(hl7:observation)=0 or count(hl7:observation/hl7:value)=1"
				>ERRORE-b159| Sezione Lista dei problemi: entry/act/entryRelationship/observation deve contenere l'elemento 'value'.</assert>
				
				<assert test="count(hl7:observation/hl7:statusCode[@nullFlavor='NA'])=0 or 
				count(hl7:observation/hl7:value[@codeSystem='2.16.840.1.113883.11.22.17'])=1"
				>ERRORE-b160| Sezione Lista dei problemi: In caso di Assenza di Problemi la entry/act/entryRelationship/observation/value deve essere valorizzato secondo il value set  "IPSNoProbsInfos" - @codeSystem='2.16.840.1.113883.11.22.17' .</assert>
			
				
					<!--Gravità del Problema-->
					
					<assert test="count(hl7:observation)=0 or 
					count(hl7:observation/hl7:entryRelationship[hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.4.4']])&lt;=1"
					>ERRORE-b161| Sezione Lista dei problemi: entry/act/entryRelationship/observation può contenere una ed una sola 'entryRelationship/observation' relativa alla "Gravità del problema" </assert>

					<assert test="count(hl7:observation/hl7:entryRelationship/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.4.4'])=0 or count(hl7:observation/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.4.4']]/hl7:value[@code='L' or @code='M' or @code='H'][@codeSystem='2.16.840.1.113883.5.1063' or @codeSystem='2.16.840.1.113883.2.9.77.22.11.5'])=1"
					>ERRORE-b162| Sezione Lista dei problemi: entry/act/entryRelationship/observation se presente, DEVE avere l'elemento value con il @codeSystem='2.16.840.1.113883.5.1063' oppure con '2.16.840.1.113883.2.9.77.22.11.5' e valorizzare l'elemento code con i seguenti valori:
					-"H" high
					-"M" moderate
					-"L" low
					. </assert>
					
					
					<!--Stato del Problema-->
					
					<assert test="count(hl7:observation)=0 or 
					count(hl7:observation/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.6']])&lt;=1"
					>ERRORE-b163| Sezione Lista dei problemi: entry/act/entryRelationship/observation può contenere una ed una sola 'entryRelationship/observation' relativa allo "Stato clinico del problema"</assert>
				
					
					<assert test="count(hl7:observation/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.6']])=0 or
					count(hl7:observation/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.6']]/hl7:code[@code='33999-4'][@codeSystem='2.16.840.1.113883.6.1'])=1"
					>ERRORE-b164| Sezione Lista dei problemi: entry/act/entryRelationship/observation/entryRelationship/observation/code (Stato problema) DEVE essere valorizzato con @code='33999-4' e @codeSystem='2.16.840.1.113883.6.1'.</assert>
					
					
					<assert test="count(hl7:observation/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.6']])=0 or
					count(hl7:observation/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.6']]/hl7:value[@codeSystem='2.16.840.1.113883.2.9.77.22.11.11' or @codeSystem='2.16.840.1.113883.6.1'])=1"
					>ERRORE-b165| Sezione Lista dei problemi: entry/act/entryRelationship/observation/entryRelationship/observation/value/@code DEVE essere selezionato dal value set "Stato clinico del Problema" - @codeSystem='2.16.840.1.113883.2.9.77.22.11.11' oppure LOINC - @codeSystem='2.16.840.1.113883.6.1'. </assert>
					<assert test="count(hl7:observation/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.6']])=0 or
					(count(hl7:observation/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.6']]/hl7:value[@code='LA16666-2'])=1 or
					count(hl7:observation/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.6']]/hl7:value[@code='LA18632-2'])=1)"
					>ERRORE-b166| Sezione Lista dei problemi: l'attributo @code di entry/act/entryRelationship/observation/entryRelationship/observation/value/ relativo allo "Stato Clinico del problema" deve essere valorizzato con:
					- "LA16666-2" se "active";
					- "LA18632-2" se "inactive".
					</assert>
				
					<!--Cronicità del Problema-->
					<assert test="count(hl7:observation)=0 or 
					count(hl7:observation/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.4.5']])&lt;=1"
					>ERRORE-b167| Sezione Lista dei problemi: entry/act/entryRelationship/observation può contenere una ed una sola 'entryRelationship/observation' relativa alla "Cronicità del problema"</assert>
					
					<assert test="count(hl7:observation/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.4.5']])=0 or 
					count(hl7:observation/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.4.5']]/hl7:code[@code='89261-2'][@codeSystem='2.16.840.1.113883.6.1'])=1"
					>ERRORE-b168| Sezione Lista dei problemi: entry/act/entryRelationship/observation/entryRelationship/observation (Cronicità del Problema) DEVE contenere un elemento 'code' valorizzato con @code='89261-2' e @codeSystem='2.16.840.1.113883.6.1'</assert>
					
					<assert test="count(hl7:observation/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.4.5']])=0 or 
					count(hl7:observation/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.4.5']]/hl7:value[@codeSystem='2.16.840.1.113883.2.9.77.22.11.10' or @codeSystem='2.16.840.1.113883.6.1'])=1"
					>ERRORE-b169| Sezione Lista dei problemi: entry/act/entryRelationship/observation/entryRelationship/observation (Cronicità del Problema) DEVE contenere un elemento 'value' valorizzato secondo @codeSystem='2.16.840.1.113883.2.9.77.22.11.10' (CronicitàProblema_PSS) or @codeSystem='2.16.840.1.113883.6.1'</assert>
					
					<assert test="count(hl7:observation/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.4.5']])=0 or 
					(count(hl7:observation/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.4.5']]/hl7:value[@code='LA28752-6'])=1 or
					count(hl7:observation/hl7:entryRelationship/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.4.5']]/hl7:value[@code='LA18821-1'])=1)"
					>ERRORE-b170| Sezione Lista dei problemi: l'attributo @code di entry/act/entryRelationship/observation/entryRelationship/observation/value (Cronicità del Problema) deve essere valorizzato con:
					- "LA28752-6" se "chronic";
					- "LA18821-1" se "acute".
					</assert>
					
					<!--Note e commenti-->
					<assert test="count(hl7:observation/hl7:entryRelationship[@typeCode='SUBJ'][hl7:act])=0 or 
					count(hl7:observation/hl7:entryRelationship/hl7:act/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.7'])=1"
					>ERRORE-b171| Sezione Lista dei problemi: entry/act/entryRelationship/observation/entryRelationship/act (Note e Commenti) se presente, DEVE avere un templateId valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.1.7'</assert>
					
					<assert test="count(hl7:observation/hl7:entryRelationship[@typeCode='SUBJ'][hl7:act])=0 or 
					count(hl7:observation/hl7:entryRelationship/hl7:act/hl7:statusCode)=1"
					>ERRORE-b172| Sezione Lista dei problemi: entry/act/entryRelationship/observation/entryRelationship/act (Note e Commenti) se presente, DEVE contenere l'elemento statusCode</assert>
					
					<assert test="count(hl7:observation/hl7:entryRelationship[@typeCode='SUBJ'][hl7:act])=0 or 
					count(hl7:observation/hl7:entryRelationship/hl7:act/hl7:code[@code='48767-8' and @codeSystem='2.16.840.1.113883.6.1'])=1"
					>ERRORE-b172b| Sezione Lista dei problemi: entry/act/entryRelationship/observation/entryRelationship/act (Note e Commenti), se presente, DEVE contenere un elemento code con attributo code=48767-8 e codeSystem=2.16.840.1.113883.6.1</assert>
					
					
				<!--Riferimenti Interni-->		
				<assert test="count(hl7:act)=0 or count(hl7:act/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.4.3'])=1"
				>ERRORE-b173| Sezione Lista dei problemi: entry/act/entryRelationship/act (Riferimenti interni) DEVE avere un elemento 'templateId' valorizzato con  @root='2.16.840.1.113883.2.9.10.1.4.3.4.3'</assert>
			
			</rule>
			
		<!--5-->
		<!--Sezione Anamnesi Familiare: (entry/organizer)-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='10157-6']]/hl7:entry/hl7:organizer">
			<assert test="@classCode='CLUSTER' and @moodCode='EVN'"
			>ERRORE-b174| Sezione Anamnesi Familiare: la sezione DEVE contenere un elemento entry/organizer valorizzato con attributi @classCode='CLUSTER' e @moodCode='EVN'</assert>
			<assert test="count(hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.16.1'])=1"
			>ERRORE-b175| Sezione Anamnesi Familiare: entry/organizer DEVE contenere un elemento 'templateId' dvalorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.16.1'</assert>
			<assert test="count(hl7:subject)=1"
			>ERRORE-b176| Sezione Anamnesi Familiare: entry/organizer DEVE contenere un elemento 'subject'</assert>
			<assert test="count(hl7:subject/hl7:relatedSubject[@classCode='PRS'])=1"
			>ERRORE-b177| Sezione Anamnesi Familiare: entry/organizer/subject/relatedSubject DEVE essere valorizzato con l'attributo @classCode='PRS'</assert>
			<assert test="count(hl7:subject/hl7:relatedSubject/hl7:code[@codeSystem='2.16.840.1.113883.5.111'])=1"
			>ERRORE-b178| Sezione Anamnesi Familiare: entry/organizer/subject/relatedSubject/code deve essere valorizzato secondo la tabella "PersonalRelationshipRoleCodeType" relativo al code system "RoleCode" - @codeSystem='2.16.840.1.113883.5.111' </assert>
			<assert test="count(hl7:subject/hl7:relatedSubject/hl7:subject/hl7:administrativeGenderCode)=0 or
			count(hl7:subject/hl7:relatedSubject/hl7:subject/hl7:administrativeGenderCode[@codeSystem='2.16.840.1.113883.5.1' or @codeSystem='2.16.840.1.113883.1.11.1'])=1"
			>ERRORE-b179| Sezione Anamnesi Familiare: entry/organizer/subject/relatedSubject/subject/administrativeGenderCode DEVE essere valorizzato secondo il code system "HL7 AdministrativeGender" - @codeSystem='2.16.840.1.113883.1.11.1'oppure con il codeSystem='2.16.840.1.113883.5.1' </assert>
			<assert test="count(hl7:component[hl7:observation])>=1"
			>ERRORE-b180| Sezione Anamnesi Familiare: entry/organizer DEVE contenere almeno un elemento 'component' di tipo 'observation'</assert>
			
		</rule>
			
			
			
			<!--Sezione Anamnesi Familiare: Dettaglio Anamnesi Familiare(entry/organizer/component/observation)-->
			<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='10157-6']]/hl7:entry/hl7:organizer/hl7:component">
			
				<assert test="count(hl7:observation)=1"
				>ERRORE-b181| Sezione Anamnesi Familiare: entry/organizer/component DEVE contenere un elemento di tipo 'observation'</assert>
				<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.16.2'])=1"
				>ERRORE-b182| Sezione Anamnesi Familiare: entry/organizer/component/observation DEVE contenere un elemento 'templateId' valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.16.2'</assert>
				<assert test="count(hl7:observation/hl7:code[@codeSystem='2.16.840.1.113883.6.1' or @codeSystem='2.16.840.1.113883.2.9.77.22.11.9'])=1"
				>ERRORE-b183| Sezione Anamnesi Familiare: entry/organizer/component/observation DEVE contenere un elemento 'code' valorizzato secondo @codeSystem='2.16.840.1.113883.6.1' oppure @codeSystem='2.16.840.1.113883.2.9.77.22.11.9'</assert>
				
				<assert test="count(hl7:observation/hl7:statusCode[@code='completed'])=1"
				>ERRORE-b184| Sezione Anamnesi Familiare: entry/organizer/component/observation DEVE contenere un elemento di tipo 'statusCode'valorizzato con @code='completed'</assert>
				
				<assert test="(count(hl7:observation/hl7:entryRelationship[hl7:observation])&lt;=2)"
				>ERRORE-b185| Sezione Anamnesi Familiare: entry/organizer/component/observation/entryRelationship di tipo 'observation' DEVE essere presente al più 2 volte:
				- età di insorgenza
				- età di decesso</assert>
			</rule>
			<!--Sezione Anamnesi Familiare: Età insorgenza e di decesso(entry/organizer/component/observation/entryRelationship/observation)-->
			<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='10157-6']]/hl7:entry/hl7:organizer/hl7:component/hl7:observation/hl7:entryRelationship">
			
				<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.16.3'])=1"
				>ERRORE-b186| Sezione Anamnesi Familiare: entry/organizer/component/observation/entryRelationship/observation DEVE contenere un elemento 'templateId' valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.16.3'</assert>
				
				<assert test="count(hl7:observation/hl7:code[@code='35267-4' or @code='39016-1'])=1"
				>ERRORE-b187| Sezione Anamnesi Familiare: entry/organizer/component/observation/entryRelationship/observation/code DEVE essere valorizzato secondo il value set "EtàInsorgenza" derivato da @codeSystem='2.16.840.1.113883.6.1':
				- @code='35267-4': età di insorgenza
				- @code='39016-1': età di decesso</assert>
				<assert test="count(hl7:observation/hl7:statusCode[@code='completed'])=1"
				>ERRORE-b188| Sezione Anamnesi Familiare: entry/organizer/component/observation/entryRelationship/observation DEVE contenere un elemento 'statusCode' valorizzato con @code='completed'</assert>
			</rule>
		

		
		<!--6-->
		<!--Sezione Stile di vita: osservazione (entry/observation)-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='29762-2']]/hl7:entry">
			
			<assert test="count(hl7:observation)=0 or count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.6.1'])=1"
			>ERRORE-b189| Sezione stile di vita: entry/observation DEVE contenere un elemento 'templateId' valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.6.1'</assert>
			<assert test="count(hl7:observation)=0 or count(hl7:observation/hl7:id)=1"
			>ERRORE-b190| Sezione stile di vita: entry/observation DEVE contenere un solo elemento 'id' </assert>
			<assert test="count(hl7:observation)=0 or count(hl7:observation/hl7:statusCode)=1"
			>ERRORE-b191| Sezione stile di vita: entry/observation DEVE contenere l'elemento 'statusCode'</assert>
			<assert test="count(hl7:observation/hl7:text)=0 or count(hl7:observation/hl7:text/hl7:reference/@value)=1"
			>ERRORE-b192| Sezione stile di vita: entry/observation/text DEVE contenere l'elemento 'reference/@value' valorizzato con l'URI che punta alla descrizione del problema nel narrative block</assert>
			<assert test="count(hl7:observation/hl7:value/hl7:originalText)=0 or count(hl7:observation/hl7:value/hl7:originalText/hl7:reference/@value)=1"
			>ERRORE-b193| Sezione stile di vita: entry/observation/value/originalText DEVE contenere l'elemento 'reference/@value' valorizzato con l'URI che punta alla descrizione dell'informazione nel narrative block</assert>
		
		</rule> 
		
		
		
		<!--7-->
		<!--Sezione Gravidanze e parto: dettaglio (entry/observation)-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='10162-6']]/hl7:entry">
			
			<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.7.1'])=1"
			>ERRORE-b194| Sezione gravidanze e parto: entry/observation DEVE contenere un elemento 'templateId' valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.7.1'</assert>
			<assert test="count(hl7:observation/hl7:id)=1"
			>ERRORE-b195| Sezione gravidanze e parto: entry/observation DEVE contenere un solo elemento 'id' </assert>
			<assert test="count(hl7:observation/hl7:code[@codeSystem='2.16.840.1.113883.6.1'])=1 or count(hl7:observation/hl7:code[@nullFlavor='UNK'])=1"
			>ERRORE-b196| Sezione gravidanze e parto: entry/observation/code DEVE essere selezionato dal value set "PregnancyObservation_PSSIT" derivato da @codeSystem='2.16.840.1.113883.6.1' altrimenti se non si conosce il code è possibile utilizzare @nullFlavor='UNK'</assert>
			<assert test="count(hl7:observation/hl7:statusCode)=1"
			>ERRORE-b197| Sezione gravidanze e parto: entry/observation DEVE contenere un solo elemento 'statusCode' </assert>			
		</rule>



		<!--8-->
		<!--Parametri Vitali: controllo sulle entry-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='8716-3']]/hl7:entry">
			
			<assert test="count(hl7:organizer)=1 or count(hl7:observation)=1"
			>ERRORE-b198| Sezione Parametri Vitali: l'entry DEVE contenere o un elemento di tipo 'organizer' oppure di tipo 'observation'.</assert>
			
			<!--organizer-->
			<assert test="count(hl7:organizer)=0 or count(hl7:organizer/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.8.1'])=1"
			>ERRORE-b199| Sezione Parametri Vitali: entry/organizer DEVE contenere un 'templateId' valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.8.1' </assert>
			
			<assert test="count(hl7:organizer)=0 or count(hl7:organizer/hl7:statusCode)=1"
			>ERRORE-b200| Sezione Parametri Vitali: entry/organizer DEVE contenere un elemento 'statusCode' </assert>
			
			<assert test="count(hl7:organizer)=0 or count(hl7:organizer/hl7:component[hl7:observation])>=1"
			>ERRORE-b201| Sezione Parametri Vitali: entry/organizer DEVE contenere almeno un elemento 'component' di tipo 'observation'</assert>
			
			<!--observation-->
			<assert test="count(hl7:observation)=0 or count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.8.2'])=1"
			>ERRORE-b202| Sezione Parametri Vitali: entry/observation DEVE contenere un elemento 'templateId' valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.8.2'.</assert>
			
			
			<assert test="count(hl7:observation)=0 or count(hl7:observation/hl7:id)=1"
			>ERRORE-b203| Sezione Parametri Vitali: entry/observation DEVE contenere un elemento 'id'.</assert>
			
			<assert test="count(hl7:observation)=0 or count(hl7:observation/hl7:code[@codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b204| Sezione Parametri Vitali: entry/observation/code DEVE essere valorizzato con @codeSystem='2.16.840.1.113883.6.1'.</assert>
			<assert test="count(hl7:observation)=0 or count(hl7:observation/hl7:value[@xsi:type='PQ'])=1"
			>ERRORE-b205| Sezione Parametri Vitali: entry/observation/value DEVE avere valorizzato l'attributo @xsi:type='PQ'.</assert>
			
		</rule>
			
			<!--Parametri Vitali: controllo entry/organizer/component/observation-->
			<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='8716-3']]/hl7:entry/hl7:organizer/hl7:component">
				
				<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.8.2'])=1"
				>ERRORE-b206| Sezione Parametri Vitali: entry/organizer/component/observation DEVE contenere un elemento 'templateId' valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.8.2'.</assert>
				
				<assert test="count(hl7:observation/hl7:id)=1"
				>ERRORE-b207| Sezione Parametri Vitali: entry/organizer/component/observation DEVE contenere un elemento 'id'</assert>
				
				<assert test="count(hl7:observation/hl7:code[@codeSystem='2.16.840.1.113883.6.1'])=1"
				>ERRORE-b208| Sezione Parametri Vitali: entry/organizer/component/observation/code DEVE essere valorizzato secondo il @codeSystem='2.16.840.1.113883.6.1'.</assert>
				<assert test="count(hl7:observation/hl7:value[@xsi:type='PQ'])=1"
				>ERRORE-b209| Sezione Parametri Vitali: entry/organizer/component/observation/value DEVE avere valorizzato l'attributo @xsi:type='PQ'.</assert>
			
			</rule>



		<!--9-->
		<!--Protesi, Impianti e Ausili: controllo sulle entry-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='46264-8']]/hl7:entry">
			
		
			<assert test="(count(hl7:supply[@moodCode='EVN'])=1) and
			(count(hl7:supply/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.9.1'])=1)"
			>ERRORE-b210| Sezione Protesi, impianti, ausili: l'entry DEVE essere di tipo 'supply' con @moodCode='EVN' e DEVE contenere un elemento 'templateId' valorizzato @root='2.16.840.1.113883.2.9.10.1.4.3.9.1'</assert>
			
			<!--dettaglio presenza protesi impianti ausili-->
			<assert test="count(hl7:supply[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.9.1']])=0 or 
			count(hl7:supply/hl7:code[@code and @codeSystem='2.16.840.1.113883.2.9.6.1.48'])=1"
			>ERRORE-b211| Sezione Protesi, impianti, ausili: entry/supply DEVE contenere un elemento 'code'valorizzato secondo il code system "Classificazione Nazionale dei Dispositivi medici" - @codeSystem='2.16.840.1.113883.2.9.6.1.48'.</assert>
			
			<assert test="count(hl7:supply[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.9.1']])=0 or 
			count(hl7:supply[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.9.1']]/hl7:effectiveTime)=1 or count(hl7:supply[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.9.1']]/hl7:effectiveTime[nullFlavor='UNK'])=1 "
			>ERRORE-b212| Sezione Protesi, impianti, ausili: entry/supply DEVE contenere un elemento 'effectiveTime', nel caso non se ne conosca il valore deve essere valorizzato con @nullFlavor="UNK" . </assert>
		

			
		</rule>

		
		<!--10-->
		<!--Sezione Piani di cura: controllo sulle entry/observation-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='18776-5']]/hl7:entry">
		
		
			<assert test="count(hl7:observation)=0 or count(hl7:observation[@moodCode='RQO'])=1"
			>ERRORE-b213|Sezione Piani di cura: eentry/observation DEVE avere l'attributo @moodCode valorizzato con 'RQO'</assert>
			<assert test="count(hl7:observation)=0 or count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.10.1'])=1"
			>ERRORE-b214|Sezione Piani di cura: entry/observation DEVE contenere un elemento 'templateId' valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.10.1'</assert>
			<assert test="count(hl7:observation)=0 or count(hl7:observation/hl7:id)=1"
			>ERRORE-b215|Sezione Piani di cura: entry/observation DEVE contenere un elemento 'id'</assert>
			<assert test="count(hl7:observation)=0 or count(hl7:observation/hl7:effectiveTime[@value])=1 or (count(hl7:observation/hl7:effectiveTime/hl7:low)=1 and count(hl7:observation/hl7:effectiveTime/hl7:high)=1)"
			>ERRORE-b216|Sezione Piani di cura: entry/observation/effectiveTime DEVE avere l'attributo @value valorizzato nel caso si voglia descrivere un preciso istante (point in time)
			oppure DEVE avere l'elemento 'low' e 'high' valorizzato nel caso si voglia indicare un intervallo temporale.</assert>
		
			
		</rule>
		
		
		<!--Sezione Piani di cura: substanceAdministration-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='18776-5']]/hl7:entry/hl7:substanceAdministration">
		
		
			<assert test="@moodCode='RQO'"
			>ERRORE-b217|Sezione Piani di cura: entry/substanceAdministration DEVE avere l'attributo @moodCode valorizzato con 'RQO'</assert>
			<assert test="count(hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.10.2'])=1"
			>ERRORE-b218|Sezione Piani di cura: entry/substanceAdministration DEVE contenere un elemento 'templateId' valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.10.2'</assert>
			<assert test="count(hl7:id)=1"
			>ERRORE-b219|Sezione Piani di cura: entry/substanceAdministration DEVE contenere un elemento 'id'.</assert>
			
			<assert test="count(hl7:effectiveTime)>=1 and 
			(count(hl7:effectiveTime/@value)=1 or
			count(hl7:effectiveTime[@xsi:type='IVL_TS']/hl7:low)=1)"
			>ERRORE-b220|Sezione Piani di cura: entry/substanceAdministration/effectiveTime DEVE avere l'attributo @value valorizzato nel caso si voglia descrivere un preciso istante (point in time)
			oppure DEVE un effectiveTime con @xsi:type='IVL_TS' con 'low' valorizzato nel caso si voglia indicare un intervallo temporale. </assert>
			
			<assert test="count(hl7:consumable)=1"
			>ERRORE-b221|Sezione Piani di cura: entry/substanceAdministration DEVE contenere un elemento 'consumable'.</assert>
			
			<assert test="count(hl7:consumable/hl7:manufacturedProduct/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.2.2'])=1"
			>ERRORE-b222|Sezione Piani di cura: entry/substanceAdministration DEVE contenere un elemento 'manufacturedProduct'con templateId @root ='2.16.840.1.113883.2.9.10.1.4.3.2.2'.</assert>
			
			<assert test="count(hl7:consumable/hl7:manufacturedProduct/hl7:manufacturedMaterial/hl7:templateId[@root='2.16.840.1.113883.10.22.4.3'])=1"
			>ERRORE-b223|Sezione Piani di cura: entry/substanceAdministration DEVE contenere un solo elemento 'manufacturedMaterial con templateId @root ='2.16.840.1.113883.10.22.4.3'</assert>
			
			<let name="farma" value="hl7:consumable/hl7:manufacturedProduct/hl7:manufacturedMaterial"/>
			<assert test="(count($farma/hl7:code[@codeSystem='2.16.840.1.113883.2.9.6.1.5'])=1 or 
			count($farma/hl7:code[@codeSystem='2.16.840.1.113883.6.73'])=1 or
			count($farma/hl7:code[@codeSystem='2.16.840.1.113883.2.9.6.1.51'])=1)"
			>ERRORE-b224| Sezione Piani di cura: entry/substanceAdministration/consumable/manufacturedProduct/manufacturedMaterial deve contenere un elemento 'code' valorizzato secondo i seguenti sistemi di codifica:
			- @codeSystem='2.16.840.1.113883.2.9.6.1.5' 	(AIC)
			- @codeSystem='2.16.840.1.113883.6.73'			(ATC)
			- @codeSystem='2.16.840.1.113883.2.9.6.1.51'	(GE)
			</assert>	
			
			<let name="trans_vl" value="hl7:consumable/hl7:manufacturedProduct/hl7:manufacturedMaterial"/>
			<assert test="count($trans_vl/hl7:code/hl7:translation)=0 or
			(count($trans_vl/hl7:code[@codeSystem='2.16.840.1.113883.2.9.6.1.5']/hl7:translation[@codeSystem!='2.16.840.1.113883.2.9.6.1.5'])=1 or count($trans_vl/hl7:code[@codeSystem='2.16.840.1.113883.6.73']/hl7:translation[@codeSystem!='2.16.840.1.113883.6.73'])=1 or 
			count($trans_vl/hl7:code[@codeSystem='2.16.840.1.113883.2.9.6.1.51']/hl7:translation[@codeSystem!='2.16.840.1.113883.2.9.6.1.51'])=1)"
			>ERRORE-b225| Sezione Piani di cura: entry/substanceAdministration/consumable/manufacturedProduct/manufacturedMaterial/code/translation DEVE essere valorizzato con un valore diverso da quello utilizzato nel 'code'
			</assert>
		
		
		</rule>

		
		
		
		<!--Sezione Piani di cura: procedure-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='18776-5']]/hl7:entry/hl7:procedure">
		
			<assert test="@moodCode='RQO'"
			>ERRORE-b226|Sezione Piani di cura: entry/procedure DEVE avere l'attributo @moodCode valorizzato con 'RQO'</assert>
			<assert test="count(hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.10.3'])=1"
			>ERRORE-b227|Sezione Piani di cura: entry/procedure DEVE contenere un elemento 'templateId' valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.10.3'</assert>
			<assert test="count(hl7:id)=1"
			>ERRORE-b228|Sezione Piani di cura: entry/procedure DEVE contenere un solo elemento 'id' </assert>
			<assert test="count(hl7:code)=1"
			>ERRORE-b229|Sezione Piani di cura: entry/procedure DEVE contenere un solo elemento code </assert>
			<assert test="(count(hl7:effectiveTime[@value])=1) or (count(hl7:effectiveTime/hl7:low)=1 and count(hl7:effectiveTime/hl7:high)=1)"
			>ERRORE-b230|Sezione Piani di cura: entry/procedure/effectiveTime DEVE avere l'attributo @value valorizzato nel caso si voglia descrivere un preciso istante (point in time)
			oppure DEVE avere l'elemento 'low' e 'high' valorizzato nel caso si voglia indicare un intervallo temporale.</assert>		
		</rule>
		
		
		<!--Sezione Piani di cura: encounter-->
		
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='18776-5']]/hl7:entry/hl7:encounter">
		
		<assert test="@moodCode='RQO'"
			>ERRORE-b231|Sezione Piani di cura: entry/encounter DEVE avere l'attributo @moodCode valorizzato con 'RQO'</assert>
			<assert test="count(hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.10.4'])=1"
			>ERRORE-b232|Sezione Piani di cura: entry/encounter DEVE contenere un elemento 'templateId' valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.10.4'</assert>
			<assert test="count(hl7:id)=1"
			>ERRORE-b233|Sezione Piani di cura: entry/encounter DEVE contenere un solo elemento 'id'.</assert>
			<assert test="count(hl7:code)=1"
			>ERRORE-b234|Sezione Piani di cura: entry/encounter DEVE contenere un solo elemento 'code' </assert>
			
			<assert test="count(hl7:code[@codeSystem='2.16.840.1.113883.2.9.77.22.11.14' or @codeSystem='2.16.840.1.113883.5.4'])=1"
			>ERRORE-b235|Sezione Piani di cura: entry/encounter/code DEVE essere valorizzato secondo il value set "EncounterCode" - @codeSystem='2.16.840.1.113883.2.9.77.22.11.14' oppure con @codeSystem='2.16.840.1.113883.5.4  </assert>
			<assert test="(count(hl7:effectiveTime[@value])=1) or (count(hl7:effectiveTime/hl7:low)=1 and count(hl7:effectiveTime/hl7:high)=1)"
			>ERRORE-b236|Sezione Piani di cura: entry/encounter/effectiveTime DEVE avere l'attributo @value valorizzato nel caso si voglia descrivere un preciso istante (point in time)
			oppure DEVE avere l'elemento 'low' e 'high' valorizzato nel caso si voglia indicare un intervallo temporale.</assert>
		
		</rule>
		
		<!--Sezione Piani di cura: act-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='18776-5']]/hl7:entry/hl7:act">
		
			<assert test="@moodCode='RQO'"
			>ERRORE-b237|Sezione Piani di cura: entry/act DEVE acere l'attributo @moodCode valorizzato secondo i seguenti valori: 'RQO'</assert>
			<assert test="count(hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.10.5'])=1"
			>ERRORE-b238|Sezione Piani di cura: entry/act DEVE contenere un elemento 'templateId' valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.10.5'</assert>
			<assert test="count(hl7:id)=1"
			>ERRORE-b239|Sezione Piani di cura: entry/act DEVE contenere un solo elemento 'id' </assert>
			<assert test="(count(hl7:effectiveTime[@value])=1) or (count(hl7:effectiveTime/hl7:low)=1 and count(hl7:effectiveTime/hl7:high)=1)"
			>ERRORE-b240|Sezione Piani di cura: entry/act/effectiveTime DEVE avere l'attributo @value valorizzato nel caso si voglia descrivere un preciso istante (point in time)
			oppure DEVE avere l'elemento 'low' e 'high' valorizzato nel caso si voglia indicare un intervallo temporale.</assert>
		</rule>
		
				
		
		
		<!--11-->
		<!--Trattamenti e procedure terapeutiche, chirurgiche e diagnostiche: controllo delle entry-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='47519-4']]/hl7:entry">
			
			<assert test="count(hl7:procedure/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.11.1'])=1"
			>ERRORE-b241| Sezione Trattamenti e procedure terapeutiche, chirurgiche e diagnostiche: entry/procedure DEVE contenere un elemento 'templateId' valorizzato con l'attributo @root='2.16.840.1.113883.2.9.10.1.4.3.11.1'. </assert>
			
			<assert test="count(hl7:procedure/hl7:id)=1"
			>ERRORE-b242| Sezione Trattamenti e procedure terapeutiche, chirurgiche e diagnostiche: entry/procedure DEVE contenere un elemento 'id'. </assert>
			
			<report test="count(hl7:procedure/hl7:code[not(@codeSystem='2.16.840.1.113883.6.1' or @codeSystem='2.16.840.1.113883.6.103' or @codeSystem='2.16.840.1.113883.2.9.77.22.11.12')])=1">
			  WA001| Sezione Trattamenti e procedure terapeutiche, chirurgiche e diagnostiche: entry/procedure si consiglia di valorizzare l'elemento 'code' con uno dei seguenti sistemi di codifica:
			  - LOINC (@codeSystem: 2.16.840.1.113883.6.1)
			  - ICD-9-CM (@codeSystem: 2.16.840.1.113883.6.103)
			  - ProcedureTrapianti_PSSIT (2.16.840.1.113883.2.9.77.22.11.12)
			</report>
				
			
			<assert test="count(hl7:procedure/hl7:statusCode)=1"
			>ERRORE-b243| Sezione Trattamenti e procedure terapeutiche, chirurgiche e diagnostiche: entry/procedure DEVE contenere un elemento 'statusCode'. </assert>
			
			<assert test="count(hl7:procedure/hl7:effectiveTime)=0 or (count(hl7:procedure/hl7:effectiveTime/hl7:low)=1 and count(hl7:procedure/hl7:effectiveTime/hl7:high)=1)"
			>ERRORE-b244| Sezione Trattamenti e procedure terapeutiche, chirurgiche e diagnostiche: entry/procedure se contiene   un elemento 'effectiveTime' DEVE contenere effectiveTime/low e effectiveTime/high che identificano l'inizio e fine della procedura. </assert>
			
			<!-- Procedura entryRelationship/observation  -->
			
			<assert test="count(hl7:procedure/hl7:entryRelationship[@typeCode='RSON']/hl7:observation)=0 or count(hl7:procedure/hl7:entryRelationship[@typeCode='RSON']/hl7:observation/hl7:id)=1"
			>ERRORE-b245| Sezione Trattamenti e procedure terapeutiche, chirurgiche e diagnostiche: entry/procedure/entryRelationship/observation se presente DEVE contenere un elemento 'id'</assert>
			
			<assert test="count(hl7:procedure/hl7:entryRelationship[@typeCode='RSON']/hl7:observation)=0 or count(hl7:procedure/hl7:entryRelationship[@typeCode='RSON']/hl7:observation/hl7:code[@codeSystem='2.16.840.1.113883.6.103'])=1"
			>ERRORE-b246| Sezione Trattamenti e procedure terapeutiche, chirurgiche e diagnostiche: entry/procedure/entryRelationship/observation se presente DEVE contenere un elemento 'code' con @codeSystem=2.16.840.1.113883.6.103 (ICD9CM)</assert>
			
			<!-- Visite e ricoveri entryRelationship/encounter  -->
			<assert test="count(hl7:procedure/hl7:entryRelationship[@typeCode='RSON']/hl7:encounter)=0 or count(hl7:procedure/hl7:entryRelationship[@typeCode='RSON']/hl7:encounter/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.12.1'])=1"
			>ERRORE-b247| Sezione Trattamenti e procedure terapeutiche, chirurgiche e diagnostiche: entry/procedure/entryRelationship/encounter se presente DEVE contenere un elemento 'templateId' con @root='2.16.840.1.113883.2.9.10.1.4.3.12.1'. </assert>
			
			<assert test="count(hl7:procedure/hl7:entryRelationship[@typeCode='RSON']/hl7:encounter)=0 or count(hl7:procedure/hl7:entryRelationship[@typeCode='RSON']/hl7:encounter/hl7:id)=1"
			>ERRORE-b248| Sezione Trattamenti e procedure terapeutiche, chirurgiche e diagnostiche: entry/procedure/entryRelationship/encounter se presente DEVE contenere un elemento 'id'</assert>
			
			<assert test="count(hl7:procedure/hl7:entryRelationship[@typeCode='RSON']/hl7:encounter)=0 or count(hl7:procedure/hl7:entryRelationship[@typeCode='RSON']/hl7:encounter/hl7:code[@codeSystem='2.16.840.1.113883.6.1' or @codeSystem='2.16.840.1.113883.2.9.77.22.11.14' or @codeSystem='2.16.840.1.113883.5.4'])=1"
			>ERRORE-b249| Sezione Trattamenti e procedure terapeutiche, chirurgiche e diagnostiche: entry/procedure/encounter DEVE contenere un elemento 'code' valorizzato secondo i seguenti sistemi di codifica:
			- LOINC (@codeSystem: 2.16.840.1.113883.6.1)
			- EncounterCode_PSST (@codeSystem=2.16.840.1.113883.2.9.77.22.11.14) (derivato da ActCode)
			- ActCode  (@codeSystem=2.16.840.1.113883.5.4)</assert>
			
			<assert test="count(hl7:procedure/hl7:entryRelationship[@typeCode='RSON']/hl7:encounter)=0 or count(hl7:procedure/hl7:entryRelationship[@typeCode='RSON']/hl7:encounter/hl7:text)=0 or count(hl7:procedure/hl7:entryRelationship[@typeCode='RSON']/hl7:encounter/hl7:text/hl7:reference)=1"
			>ERRORE-b250| Sezione Trattamenti e procedure terapeutiche, chirurgiche e diagnostiche: entry/procedure/entryRelationship/encounter/text se presente DEVE essere valorizzato con l’URI che punta alla descrizione della visita/ricovero nel narrative block della sezione.</assert>
			
			<assert test="count(hl7:procedure/hl7:entryRelationship[@typeCode='RSON']/hl7:encounter)=0 or count(hl7:procedure/hl7:entryRelationship[@typeCode='RSON']/hl7:encounter/hl7:effectiveTime[@value])=1 or (count(hl7:procedure/hl7:entryRelationship[@typeCode='RSON']/hl7:encounter/hl7:effectiveTime/hl7:low)=1 and count(hl7:procedure/hl7:entryRelationship[@typeCode='RSON']/hl7:encounter/hl7:effectiveTime/hl7:high)=1)"
			>ERRORE-b251| Sezione Trattamenti e procedure terapeutiche, chirurgiche e diagnostiche: entry/procedure/entryRelationship/encounter DEVE essere presente l'elemento effectiveTime valorizzato in forma di data precisa o come intervallo.</assert>
			
			<assert test="count(hl7:procedure/hl7:entryRelationship[@typeCode='RSON']/hl7:encounter)=0 or count(hl7:procedure/hl7:entryRelationship[@typeCode='RSON']/hl7:encounter/hl7:performer)=0 or count(hl7:procedure/hl7:entryRelationship[@typeCode='RSON']/hl7:encounter/hl7:performer/hl7:time)=0 or
			(count(hl7:procedure/hl7:entryRelationship[@typeCode='RSON']/hl7:encounter/hl7:performer/hl7:time/hl7:low)=1 and 
			count(hl7:procedure/hl7:entryRelationship[@typeCode='RSON']/hl7:encounter/hl7:performer/hl7:time/hl7:high)=1)"
			>ERRORE-b252| Sezione Trattamenti e procedure terapeutiche, chirurgiche e diagnostiche: entry/procedure/entryRelationship/encounter/performer/time se presente Deve avere gli elementi low e high.</assert>
			
			
		</rule>	
	

	
		<!--12-->
		<!--Visite o ricoveri: controllo entry-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='46240-8']]/hl7:entry">
			
			<assert test="count(hl7:encounter[@moodCode='EVN'])=1"
			>ERRORE-b253| Sezione Visite o ricoveri: entry/encounter DEVE avere l'attributo @moodCode valorizzato con 'EVN'.</assert>
			<assert test="count(hl7:encounter/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.12.1'])=1"
			>ERRORE-b254| Sezione Visite o ricoveri: entry/encounter DEVE contenere un elemento 'templateId valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.12.1'.</assert>
			<assert test="count(hl7:encounter/hl7:id)=1"
			>ERRORE-b255| Sezione Visite o ricoveri: entry/encounter DEVE contenere un 'id'.</assert>
			
			<assert test="(count(hl7:encounter/hl7:code[@codeSystem='2.16.840.1.113883.6.1'])=1 or 
			count(hl7:encounter/hl7:code[@codeSystem='2.16.840.1.113883.2.9.77.22.11.14'])=1 or 
			count(hl7:encounter/hl7:code[@codeSystem='2.16.840.1.113883.5.4'])=1)"
			>ERRORE-b256| Sezione Visite o ricoveri: entry/encounter DEVE contenere un elemento code valorizzato secondo i seguenti sistemi di codifica:
			- LOINC (@codeSystem: 2.16.840.1.113883.6.1)
			- EncounterCode_PSST (@codeSystem=2.16.840.1.113883.2.9.77.22.11.14) (derivato da ActCode)
			- ActCode  (@codeSystem=2.16.840.1.113883.5.4).</assert>
			
			<assert test="count(hl7:encounter/hl7:text)=0 or count(hl7:encounter/hl7:text/hl7:reference/@value)=1"
			>ERRORE-b257| Sezione Visite o ricoveri: entry/encounter/text DEVE contenere un elemento reference/@value valorizzato con l’URI che punta alla descrizione estesa della visita o ricovero nel narrative block della sezione.</assert>
			
			<assert test="count(hl7:encounter/hl7:effectiveTime[@value])=1 or (count(hl7:encounter/hl7:effectiveTime/hl7:low)=1 and count(hl7:encounter/hl7:effectiveTime/hl7:high)=1)"
			>ERRORE-b258| Sezione Visite o ricoveri: entry/encounter DEVE essere presente l'elemento effectiveTime valorizzato in forma di data precisa o come intervallo.</assert>
			
			<report test="not(count(hl7:encounter/hl7:performer)=1)"
			>W002| Sezione Visite o ricoveri: si consiglia di valorizzare, all'interno di entry/encounter, almeno un elemento 'performer'.</report>
		
			<assert test=" count(hl7:encounter/hl7:performer)=0 or count(hl7:encounter/hl7:performer/hl7:assignedEntity)=0 or count(hl7:encounter/hl7:performer/hl7:time)=0 or
			(count(hl7:encounter/hl7:performer/hl7:time/hl7:low)=1 and 
			count(hl7:encounter/hl7:performer/hl7:time/hl7:high)=1)"
			>ERRORE-b259| Sezione Visite o ricoveri: entry/encounter/performer/time se presente DEVE avere gli elementi low e high.</assert>
		
		</rule>


	
		<!--13-->
		<!--Sezione Stato funzionale del paziente: controllo delle entry -->

		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='47420-5']]/hl7:entry">
			
			<assert test="count(hl7:organizer/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.1'])=1"
			>ERRORE-b260| Sezione Stato funzionale del paziente: entry/organizer DEVE contenere un 'templateId' valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.14.1'. </assert>
			
			<assert test="count(hl7:organizer/hl7:statusCode)=1"
			>ERRORE-b261| Sezione Stato funzionale del paziente: entry/organizer DEVE contenere un elemento 'statusCode'</assert>
			
					
			<!--observation Capacità Motoria-->
			

			<assert test="count(hl7:organizer/hl7:component/hl7:observation/hl7:code[@code='75246-9'])=0 or count(hl7:organizer/hl7:component/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.2'])=1"
			>ERRORE-b262| Sezione Stato funzionale del paziente: entry/organizer/component/observation (Capacità Motoria) se presente DEVE contenere una sola component observation con templateId @root='2.16.840.1.113883.2.9.10.1.4.3.14.2'</assert>
			
			<assert test="count(hl7:organizer/hl7:component/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.2'])=0 or count(hl7:organizer/hl7:component/hl7:observation/hl7:code[@code='75246-9'][@codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b263| Sezione Stato funzionale del paziente: entry/organizer/component/observation (Capacità motoria) DEVE contenere un elemento 'code' valorizzato con @code='75246-9' e @codeSystem='2.16.840.1.113883.6.1'</assert>

			<assert test="count(hl7:organizer/hl7:component/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.2'])=0 or count(hl7:organizer/hl7:component/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.2']]/hl7:statusCode)=1"
			>ERRORE-b264| Sezione Stato funzionale del paziente: entry/organizer/component/observation (Capacità Motoria) se presente DEVE contenere l'elemento 'statusCode'</assert>
			
			<assert test="count(hl7:organizer/hl7:component/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.2'])=0 or count(hl7:organizer/hl7:component/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.2']]/hl7:effectiveTime)=0 or count(hl7:organizer/hl7:component/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.2']]/hl7:effectiveTime/hl7:low)=1"
			>ERRORE-b265| Sezione Stato funzionale del paziente: entry/organizer/component/observation (Capacità Motoria) se presente l'elemento effectiveTime DEVE essere valorizzato l'elemento 'low'</assert>
			
			<assert test="count(hl7:organizer/hl7:component/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.2'])=0 or count(hl7:organizer/hl7:component/hl7:observation[hl7:code[@code='75246-9']]/hl7:value[@codeSystem='2.16.840.1.113883.6.1' or @codeSystem='2.16.840.1.113883.2.9.77.22.11.15'])=1"
			>ERRORE-b266| Sezione Stato funzionale del paziente: entry/organizer/component/observation (Capacità motoria) DEVE contenere un elemento 'value' valorizzato secondo i seguenti code system:
			- LOINC (@codeSystem: 2.16.840.1.113883.6.1)
			- CapacitàMotoria_PSSIT  (@codeSystem=2.16.840.1.113883.2.9.77.22.11.15). </assert>
			
			
			<!--Observation Regime di assistenza-->
			
			

			<assert test="count(hl7:organizer/hl7:component/hl7:observation[hl7:code[@codeSystem='2.16.840.1.113883.5.4']])=0 or count(hl7:organizer/hl7:component/hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.3'])=1"
			>ERRORE-b267| Sezione Stato funzionale del paziente: entry/organizer se presente DEVE contenere una sola component/observation con templateId  @root='2.16.840.1.113883.2.9.10.1.4.3.14.3' relativa al "Regime di assistenza" </assert>
			
			<assert test="count(hl7:organizer/hl7:component/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.3']]/hl7:code)=0 or 
			count(hl7:organizer/hl7:component/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.3']]/hl7:code[@codeSystem='2.16.840.1.113883.5.4'])=1"
			>ERRORE-b268| Sezione Stato funzionale del paziente: entry/organizer/component/observation (Regime di assistenza) se presente un elemento 'code' DEVE essere valorizzato utilizzando il valueset "ActCode"-@codeSystem='2.16.840.1.113883.5.4' </assert>
			
			<assert test="count(hl7:organizer/hl7:component/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.3']])=0 or count(hl7:organizer/hl7:component/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.3']]/hl7:statusCode)=1"
			>ERRORE-b269| Sezione Stato funzionale del paziente: entry/organizer/component/observation (Regime di assistenza) se presente DEVE contenere l'elemento statusCode </assert>
			
			<assert test="count(hl7:organizer/hl7:component/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.3']])=0 or 
			count(hl7:organizer/hl7:component/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.3']]/hl7:effectiveTime)=0 or count(hl7:organizer/hl7:component/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.3']]/hl7:effectiveTime/hl7:low)=1"
			>ERRORE-b270| Sezione Stato funzionale del paziente: entry/organizer/component/observation (Regime di assistenza) se valorizzato l'effectiveTime deve contenere l'elemento low </assert>
					
			
			<assert test="count(hl7:organizer/hl7:component/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.3']])=0 or	count(hl7:organizer/hl7:component/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.3']]/hl7:value[@xsi:type='CD'])=1"
			>ERRORE-b271| Sezione Stato funzionale del paziente: entry/organizer/component/observation/value (Regime di assistenza) DEVE avere attributo  xsi:type='CD' </assert>
			
			<!--AltreInfo  - Stato Mentale-->
			
			<assert test="count(hl7:organizer/hl7:component/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.4']])&lt;=1"
			>ERRORE-b272| Sezione Stato funzionale del paziente: entry/organizer/component/observation  può contenere una ed una sola component/observation relativa al "AltreInfo  - Stato Mentale" </assert>
			
			<assert test="count(hl7:organizer/hl7:component/hl7:observation[hl7:code[@code='8693-4']])=0 or 
			count(hl7:organizer/hl7:component/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.4']])=1"
			>ERRORE-b273| Sezione Stato funzionale del paziente: entry/organizer/component/observation (Stato Mentale) DEVE contenere una sola component/observation con 'templateId' valorizzato secondo il @root='2.16.840.1.113883.2.9.10.1.4.3.14.4' </assert>
			
			<assert test="count(hl7:organizer/hl7:component/hl7:observation[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.4']])=0 or 
			count(hl7:organizer/hl7:component/hl7:observation[hl7:code[@code='8693-4']]/hl7:code[@codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b274| Sezione Stato funzionale del paziente: entry/organizer/component/observation (Altre Info - Stato Mentale) DEVE contenere un elemento 'code' valorizzato secondo il codeSystem "LOINC" - @code='8693-4' @codeSystem='2.16.840.1.113883.6.1' </assert>
			
			<assert test="count(hl7:organizer/hl7:component/hl7:observation[hl7:code[@code='8693-4']])=0 or 
			count(hl7:organizer/hl7:component/hl7:observation[hl7:code[@code='8693-4']]/hl7:statusCode[@code='normal'])=1 or count(hl7:organizer/hl7:component/hl7:observation[hl7:code[@code='8693-4']]/hl7:statusCode[@code='nullified'])=1 or 
			count(hl7:organizer/hl7:component/hl7:observation[hl7:code[@code='8693-4']]/hl7:statusCode[@code='obsolete'])=1"
			>ERRORE-b275| Sezione Stato funzionale del paziente: entry/organizer/component/observation (Altre Info - Stato Mentale) DEVE contenere un elemento 'statuscode' valorizzato con uno dei seguenti valori:
			- normal
			- nullified
			- obsolete </assert>
			
			<assert test="count(hl7:organizer/hl7:component/hl7:observation[hl7:code[@code='8693-4']])=0 or count(hl7:organizer/hl7:component/hl7:observation[hl7:code[@code='8693-4']]/hl7:effectiveTime)=0 or count(hl7:organizer/hl7:component/hl7:observation[hl7:code[@code='8693-4']]/hl7:effectiveTime/hl7:low)=1"
			>ERRORE-b276| Sezione Stato funzionale del paziente: entry/organizer/component/observation (Altre Info - Stato Mentale) se presente l'elemento effectiveTime DEVE essere valorizzato l'elemento 'low'</assert>
			
			<assert test="count(hl7:organizer/hl7:component/hl7:observation[hl7:code[@code='8693-4']])=0 or count(hl7:organizer/hl7:component/hl7:observation[hl7:code[@code='8693-4']]/hl7:value[@xsi:type='CD'])=1"
			>ERRORE-b277| Sezione Stato funzionale del paziente: entry/organizer/component/observation/value (Altre Info - Stato Mentale) DEVE avere l'elemento @xsi:Type='CD', inoltre si consiglia di utilizzare il valueset "ICD9CM" - @codeSystem='2.16.840.1.113883.6.103' </assert>
								
		</rule>
		
		
		<!--14-->
		<!--Indagini diagnostiche ed esami di laboratorio: controlli sulla entry-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='30954-2']]/hl7:entry">
			
			<assert test="count(hl7:organizer/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.1'])=1"
			>ERRORE-b278| Sezione Indagini diagnostiche ed esami di laboratorio:  entry/organizer DEVE contenere un elemento 'templateId' valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.14.1'. </assert>
			
			<assert test="count(hl7:organizer/hl7:code)=1"
			>ERRORE-b279| Sezione Indagini diagnostiche ed esami di laboratorio:  entry/organizer DEVE contenere un elemento 'code'.</assert>
			
			<assert test="count(hl7:organizer/hl7:statusCode)=1"
			>ERRORE-b280| Sezione Indagini diagnostiche ed esami di laboratorio:  entry/organizer DEVE contenere un elemento 'statusCode'.</assert>
			
			<assert test="count(hl7:organizer/hl7:code[@code])=1 or count(hl7:organizer/hl7:code[@nullFlavor='OTH'])=1"
			>ERRORE-b281| Sezione Indagini diagnostiche ed esami di laboratorio:  entry/organizer se non esiste una codice corrispondente alla batteria di esami di cui si intende riportare i valori si DEVE utilizzare il valore @nullFlavor=“OTH”. </assert>
			
			<assert test="count(hl7:organizer/hl7:component[hl7:observation])>=1"
			>ERRORE-b282| Sezione Indagini diagnostiche ed esami di laboratorio:  entry/organizer DEVE contenere almeno un elemento 'component' di tipo 'observation'</assert>
			
		</rule>
			
			<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='30954-2']]/hl7:entry/hl7:organizer/hl7:component">
				
				<assert test="count(hl7:observation/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.14.2'])=1"
				>ERRORE-b283| Sezione Indagini diagnostiche ed esami di laboratorio: entry/organizer/component/observation DEVE contenere un elemento 'templateId' valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.14.2'.</assert>
				<assert test="count(hl7:observation/hl7:id)=1"
				>ERRORE-b284| Sezione Indagini diagnostiche ed esami di laboratorio: entry/organizer/component/observation DEVE contenere un solo elemento 'id'.</assert>
				
				<assert test="count(hl7:observation/hl7:code[@code])=1 or count(hl7:observation/hl7:code[@nullFlavor='OTH'])=1"
				>ERRORE-b285| Sezione Indagini diagnostiche ed esami di laboratorio:  component/observation DEVE contenere un elemento 'code'.Se non esiste una codice corrispondente alla batteria di esami di cui si intende riportare i valori utilizzare il valore @nullFlavor='OTH'.</assert>
				
				<assert test="count(hl7:observation/hl7:value)=1"
				>ERRORE-b286| Sezione Indagini diagnostiche ed esami di laboratorio: component/observation DEVE contenere un elemento 'value'. </assert>
				
				
				<assert test="count(hl7:observation/hl7:interpretationCode)=0 or count(hl7:observation/hl7:interpretationCode[@codeSystem='2.16.840.1.113883.5.83'])=1"
				>ERRORE-b287| Sezione Indagini diagnostiche ed esami di laboratorio: component/observation/interpretationCode se presente DEVE avere l'elemento code valorizzato con il @codeSystem='2.16.840.1.113883.5.83'. </assert>
				
				<assert test="count(hl7:observation/hl7:referenceRange)=0 or count(hl7:observation/hl7:referenceRange/hl7:observationRange/hl7:text)=1 or (count(hl7:observation/hl7:referenceRange/hl7:observationRange/hl7:value[@xsi:type='IVL_PQ'])=1 and 
				count(hl7:observation/hl7:referenceRange/hl7:observationRange/hl7:value[@xsi:type='IVL_PQ']/hl7:low)=1 and 
				count(hl7:observation/hl7:referenceRange/hl7:observationRange/hl7:value[@xsi:type='IVL_PQ']/hl7:high)=1)"
				>ERRORE-b288| Sezione Indagini diagnostiche ed esami di laboratorio:  component/observation/referenceRange se presente può essere valorizzato sia in forma codificata(value[@xsi:type='IVL_PQ'] e DEVE contenere low e high che non codificata (text). </assert>
				
			</rule>


		<!--16-->
		<!--Esenzioni-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='57827-8']]/hl7:entry">
			
			<assert test="count(hl7:act[@classCode='ACT'][@moodCode='EVN'])=1"
			>ERRORE-b289| Sezione Esenzioni: entry/act DEVE avere valorizzati gli attributi nel seguente modo @classCode='ACT' e @moodCode='EVN'.</assert>		
			<assert test="count(hl7:act[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.17.1']])=1"
			>ERRORE-b290| Sezione Esenzioni: entry/act DEVE contenere un elemento 'templateId' valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.17.1'. </assert>
			
			
			<assert test="count(hl7:act/hl7:code[@codeSystem='2.16.840.1.113883.2.9.6.1.22' or @codeSystem='2.16.840.1.113883.2.9.5.2.2'])=1 or 
			(count(hl7:act/hl7:code[@codeSystem='2.16.840.1.113883.2.9.2.10.6.22'])=1 or 
			count(hl7:act/hl7:code[@codeSystem='2.16.840.1.113883.2.9.2.20.6.22'])=1 or
			count(hl7:act/hl7:code[@codeSystem='2.16.840.1.113883.2.9.2.30.6.22'])=1 or
			count(hl7:act/hl7:code[@codeSystem='2.16.840.1.113883.2.9.2.41.6.22'])=1 or
			count(hl7:act/hl7:code[@codeSystem='2.16.840.1.113883.2.9.2.42.6.22'])=1 or
			count(hl7:act/hl7:code[@codeSystem='2.16.840.1.113883.2.9.2.50.6.22'])=1 or
			count(hl7:act/hl7:code[@codeSystem='2.16.840.1.113883.2.9.2.60.6.22'])=1 or
			count(hl7:act/hl7:code[@codeSystem='2.16.840.1.113883.2.9.2.70.6.22'])=1 or
			count(hl7:act/hl7:code[@codeSystem='2.16.840.1.113883.2.9.2.80.6.22'])=1 or
			count(hl7:act/hl7:code[@codeSystem='2.16.840.1.113883.2.9.2.90.6.22'])=1 or
			count(hl7:act/hl7:code[@codeSystem='2.16.840.1.113883.2.9.2.100.6.22'])=1 or
			count(hl7:act/hl7:code[@codeSystem='2.16.840.1.113883.2.9.2.110.6.22'])=1 or
			count(hl7:act/hl7:code[@codeSystem='2.16.840.1.113883.2.9.2.120.6.22'])=1 or
			count(hl7:act/hl7:code[@codeSystem='2.16.840.1.113883.2.9.2.130.6.22'])=1 or
			count(hl7:act/hl7:code[@codeSystem='2.16.840.1.113883.2.9.2.140.6.22'])=1 or
			count(hl7:act/hl7:code[@codeSystem='2.16.840.1.113883.2.9.2.150.6.22'])=1 or
			count(hl7:act/hl7:code[@codeSystem='2.16.840.1.113883.2.9.2.160.6.22'])=1 or
			count(hl7:act/hl7:code[@codeSystem='2.16.840.1.113883.2.9.2.170.6.22'])=1 or
			count(hl7:act/hl7:code[@codeSystem='2.16.840.1.113883.2.9.2.180.6.22'])=1 or
			count(hl7:act/hl7:code[@codeSystem='2.16.840.1.113883.2.9.2.190.6.22'])=1 or
			count(hl7:act/hl7:code[@codeSystem='2.16.840.1.113883.2.9.2.200.6.22'])=1)"
			>ERRORE-b291| Sezione Esenzioni: entry/act/code DEVE essere valorizzato secondo i seguenti sistemi di codifica:
			- Catalogo Nazionale Esenzioni (2.16.840.1.113883.2.9.6.1.22)
			- Catalogo Regionale (2.16.840.1.113883.2.9.2.[REGIONE].6.22)
			- Catalogo Nazionale Nessuna Esenzione (2.16.840.1.113883.2.9.5.2.2)</assert>
			
			<assert test="count(hl7:act/hl7:statusCode)=1"
			>ERRORE-b292| Sezione Esenzioni: entry/act DEVE contenere un elemento 'statusCode'</assert>
			
			<assert test="count(hl7:act/hl7:effectiveTime/hl7:low)=1 or count(hl7:act/hl7:effectiveTime/hl7:low[@nullFlavor='UNK'])=1"
			>ERRORE-b293| Sezione Esenzioni: entry/act DEVE contenere un elemento 'effectiveTime' il quale deve avere l'elemento 'low' valorizzato. Se non noto valorizzare l’elemento col @nullFlavor = UNK</assert>
			
			
			<let name="status" value="hl7:act/hl7:statusCode/@code"/>
			<assert test="($status='completed' and count(hl7:act/hl7:effectiveTime/hl7:high)=1) or
						($status='aborted' and count(hl7:act/hl7:effectiveTime/hl7:high)=1) or 
						($status='suspended' and count(hl7:act/hl7:effectiveTime/hl7:high)=0) or 
						($status='active' and count(hl7:act/hl7:effectiveTime/hl7:high)=0)"
			>ERRORE-b294| Sezione Esenzioni: entry/act/effectiveTime DEVE avere un elemento 'high' nel caso in cui lo 'statusCode' è 'completed'|'aborted'.</assert>
			
			<assert test="count(hl7:act/hl7:entryRelationship/hl7:act)=0 or 
			count(hl7:act/hl7:entryRelationship/hl7:act[@classCode='ACT'][@moodCode='EVN'])=1"
			>ERRORE-b295| Sezione Esenzioni: entry/act/entryRelationship/act relativo a Note e Commenti se presente deve avere valorizzati gli attributi nel seguente modo @classCode='ACT' e @moodCode='EVN'.'</assert>
			
			<assert test="count(hl7:act/hl7:entryRelationship/hl7:act)=0 or 
			count(hl7:act/hl7:entryRelationship/hl7:act/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.7'])=1"
			>ERRORE-b296| Sezione Esenzioni: entry/act/entryRelationship/act relativo a Note e Commenti se presente deve contenere un elemento 'templateId' valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.1.7'</assert>
			
			<assert test="count(hl7:act/hl7:entryRelationship/hl7:act)=0 or 
			count(hl7:act/hl7:entryRelationship/hl7:act/hl7:code[@code='48767-8'][@codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b297| Sezione Esenzioni: entry/act/entryRelationship/act relativo a Note e Commenti se presente deve contenere un elemento 'code' valorizzato con @code='48767-8' e @codeSystem='2.16.840.1.113883.6.1'</assert>
			
			<assert test="count(hl7:act/hl7:entryRelationship/hl7:act)=0 or 
			count(hl7:act/hl7:entryRelationship/hl7:act/hl7:statusCode)=1"
			>ERRORE-b298| Sezione Esenzioni: entry/act/entryRelationship/act relativo a Note e Commenti se presente deve contenere un elemento 'statusCode'</assert>
			
			<assert test="count(hl7:act/hl7:entryRelationship/hl7:act/hl7:text)=0 or 
			count(hl7:act/hl7:entryRelationship/hl7:act/hl7:text/hl7:reference[@value])=1"
			>ERRORE-b299| Sezione Esenzioni: entry/act/entryRelationship/act relativo a Note e Commenti se presente l'elemento 'text' deve contenere un elemento reference, valorizzando l'attributo @value.</assert>
			
		</rule>


		
		<!--17-->
		<!--Reti di patologia: controlli sulla entry-->
		<rule context="hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component/hl7:section[hl7:code[@code='PSSIT99']]/hl7:entry">
			
			<assert test="count(hl7:act[@classCode='PCPR'][@moodCode='EVN'])=1"
			>ERRORE-b300| Sezione Reti di Patologia: entry/act DEVE avere gli attributi valorizzati nel seguente modo @classCode='PCPR' e @moodCode='EVN'.</assert>		
			<assert test="count(hl7:act[hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.18.1']])=1"
			>ERRORE-b301| Sezione Reti di Patologia: entry/act DEVE avere un elemento 'templateId' valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.18.1'. </assert>
			<assert test="count(hl7:act/hl7:id)=1"
			>ERRORE-b302| Sezione Reti di Patologia: entry/act DEVE contenere un elemento 'id'.</assert>			
			<assert test="count(hl7:act/hl7:effectiveTime/hl7:low)=1"
			>ERRORE-b303| Sezione Reti di Patologia: entry/act DEVE contenere un elemento 'effectiveTime' il quale deve avere l'elemento 'low' valorizzato.</assert>
			
			<assert test="count(hl7:act/hl7:statusCode)=1"
			>ERRORE-b304| Sezione Reti di Patologia: entry/act DEVE contenere un elemento 'statusCode'.</assert>	
			
			
			<let name="status" value="hl7:act/hl7:statusCode"/>
			<assert test="($status[@code='completed'] and count(hl7:act/hl7:effectiveTime/hl7:high)=1) or
						($status[@code='aborted'] and count(hl7:act/hl7:effectiveTime/hl7:high)=1) or 
						($status[@code='suspended'] and count(hl7:act/hl7:effectiveTime/hl7:high)=0) or 
						($status[@code='active'] and count(hl7:act/hl7:effectiveTime/hl7:high)=0)"
			>ERRORE-b305| Sezione Reti di Patologia: entry/act/effectiveTime DEVE contenere un elemento 'high' nel caso in cui lo 'statusCode' è 'completed'|'aborted'.</assert>
			
			<assert test="count(hl7:act/hl7:entryRelationship/hl7:act)=0 or 
			count(hl7:act/hl7:entryRelationship/hl7:act[@classCode='ACT'][@moodCode='EVN'])=1"
			>ERRORE-b306| Sezione Reti di Patologia: entry/act/entryRelationship/act relativo a Note e Commenti se presente DEVE avere valorizzati gli attributi nel seguente modo @classCode='ACT' e @moodCode='EVN'</assert>
			
			<assert test="count(hl7:act/hl7:entryRelationship/hl7:act)=0 or 
			count(hl7:act/hl7:entryRelationship/hl7:act/hl7:templateId[@root='2.16.840.1.113883.2.9.10.1.4.3.1.7'])>=1"
			>ERRORE-b307| Sezione Reti di Patologia: entry/act/entryRelationship/act relativo a "Note e Commenti" DEVE contenere un elemento 'templateId' valorizzato con @root='2.16.840.1.113883.2.9.10.1.4.3.1.7'</assert>
			
			
			<assert test="count(hl7:act/hl7:entryRelationship/hl7:act)=0 or 
			count(hl7:act/hl7:entryRelationship/hl7:act/hl7:code[@code='48767-8'][@codeSystem='2.16.840.1.113883.6.1'])=1"
			>ERRORE-b308| Sezione Reti di Patologia: entry/act/entryRelationship/act relativo a "Note e Commenti" se presente DEVE contenere un elemento 'code' valorizzato con @code='48767-8' e @codeSystem='2.16.840.1.113883.6.1'</assert>
			
			<assert test="count(hl7:act/hl7:entryRelationship/hl7:act)=0 or 
			count(hl7:act/hl7:entryRelationship/hl7:act/hl7:statusCode)=1"
			>ERRORE-b309| Sezione Reti di Patologia: entry/act/entryRelationship/act relativo a "Note e Commenti" se presente DEVE contenere un elemento 'statusCode'</assert>
			
			<assert test="count(hl7:act/hl7:entryRelationship/hl7:act/hl7:text)=0 or 
			count(hl7:act/hl7:entryRelationship/hl7:act/hl7:text/hl7:reference[@value])=1"
			>ERRORE-b310| Sezione Reti di Patologia: entry/act/entryRelationship/act relativo a Note e Commenti se presente l'elemento 'text' DEVE contenere un elemento reference, valorizzando l'attributo @value.</assert>
		
		</rule>
		
	</pattern>
</schema>