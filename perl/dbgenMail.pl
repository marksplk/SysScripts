#!/usr/bin/perl
## Created by Indirajith.thangasamy@splunk.com
##  Created for Identity Server Stress,Deployment & Scalability tests
##  by Indirajith Thangasamy indira@splunk.com x8514
#$Id: dbgenMail.pl,v 1.2 2003/02/17 04:11:51 indira Exp $
use Data::Random qw(:all);

sub PrintUsage {
    print STDERR 
	"Usage: $0 -x root_suffix  -n number\n",
	#"\t Where options are:\n",
	#"\t -x suffix, default is 'o=Ace Industry, c=US'\n",
        #"\t -O for organizationalPersons, default is inetOrgPerson\n",
	#"\t -p for piranha style aci's, default is barracuda\n",
	#"\t -s seed---seed number for random number generator\n",
	#"\t -v verbose -q quiet (no progress dots)\n",
	"\n";
    exit;
}

&PrintUsage if ($#ARGV == -1);

@EmployeeTypes = ("Manager", "Normal", "Peon","Security","Engineer","Janitor","UDC","LDC","Driver","Conductor","Vocalist","Composer","Singer");
@MailQuota=("1000","5000","10000","50000","100000");
sub MakeQuota{
return $MailQuota[rand @MailQuota];
}



@title_ranks = ("Senior", 
		"Master", 
		"Associate", 
		"Junior", 
		"Chief", 
		"Supreme",
		"Elite" );

@positions   =("Accountant", 
	       "Admin", 
	       "Architect", 
	       "Assistant", 
	       "Artist", 
	       "Consultant", 
	       "Czar", 
	       "Dictator",
	       "Director", 
	       "Diva",
	       "Dreamer",
	       "Evangelist", 
	       "Engineer", 
	       "Figurehead", 
	       "Fellow",
	       "Grunt", 
	       "Guru",
	       "Janitor", 
	       "Madonna", 
	       "Manager", 
	       "Pinhead",
	       "President",
	       "Punk", 
	       "Sales Rep", 
	       "Stooge", 
	       "Visionary", 
	       "Vice President", 
	       "Writer", 
	       "Warrior", 
	       "Yahoo");

@localities = `cat /u/indira/cos/citydata`;
##Mountain View", "Redmond", "Redwood Shores", "Armonk",
	
#       "Cambridge", "Santa Clara", "Sunnyvale", "Alameda",
	
#       "Cupertino", "Menlo Park", "Palo Alto", "Orem",
	
#       "San Jose", "San Francisco", "Milpitas");

@area_codes = ("303", "415", "408", "510", "804", "818",
	       "213", "206", "714");
@MailHosts = ("Jurassic.eng","ha-mpk.eng","dredd.mcom","bighome.sfbay","mail.ebay");
@Streets=("1600 Pensylvania Ave","1200 New Jersy Ave","12345 El Camino Real","234 Gandhi Road","12 Limca Dr","22 Wall Street","33 Millers Road");
@States=("California","New York","New Jersy","Columbus","Iowa","Idaho");
@MailDomains=("eng.splunk.com","sfbay.splunk.com","east.splunk.com","corp.splunk.com","ebay.splunk.com"); 
@Category=("CONFIG","BOOTSTRAP","AUDIT","STARTUP","SHUTDOWN","AUTHN","AUTHZ","DATASTORE","RUNTIME_INFORMATION","BACKEND","PROTOCOL","CORE","J2EE","SECURITY"); 
@LogLevel=("NOTICE","WARN","FATAL","ERROR","INFO"); 
@Modes=("yes","no"); 
#@Category=("iPlanet","Computer Systems","Java Soft","Sun Soft"); 
@Delivery=("Inbox","Local Folder"); 
@DeliveryMethod=("UPS","USPS","Fed Ex"); 
sub MakeMailDomains{
return $MailDomains[rand @MailDomains];
}  
sub MakeCategory{
return $Category[rand @Category];
}  
sub MakeLogLevel{
return $LogLevel[rand @LogLevel];
}  
sub MakeStreets{
return $Streets[rand @Streets];
}  
sub MakeStates{
return $States[rand @States];
}  
sub MakeDeliveryMethod{
return $DeliveryMethod[rand @DeliveryMethod];
}  
sub MakeMailReplyMode{
return $Modes[rand @Modes];
}  
sub MakeMailDelivery{
return $Delivery[rand @Delivery];
}  
sub MakeCategory{
return $Category[rand @Category];
}  
require "flush.pl";
require "getopts.pl";
&Getopts('n:o:s:x:pOvq');

$piranha = $opt_p;
$Number_To_Generate = $opt_n;
$Verbose = $opt_v;
$Quiet = $opt_q;
$Output_File_Name = $opt_o;
$Random_Seed = $opt_s || 0xdbdbdbdb;
$TargetServer = $opt_t;
$debug = $opt_d;
$Suffix = $opt_x || 'o=Ace Industry, c=US';
$inetOrgPerson = "objectClass: inetOrgPerson\n" if (!$opt_O);


($Organization) = $Suffix =~ /o=([^,]+)/;

# domain is used for MakeMailAddress
($domain) = $Organization =~ /^(\w+)/;


# Print help message if user doesn't know how many entries to make
# or no output file specified
#if ( (!$Number_To_Generate) || (!$Output_File_Name)) {
if ( (!$Number_To_Generate) ) {
    &PrintUsage;
}

srand($Random_Seed);

print "Loading Name Data...\n" if $Verbose;

$GivenNamesFile = "dbgen-GivenNames";
$FamilyNamesFile = "dbgen-FamilyNames";
$OrgUnitsFile    = "dbgen-OrgUnits";
&ReadGivenNames;
&ReadFamilyNames;
&ReadOrgUnits;

print "Done\n" if $Verbose;
@Mailboxes=("SCA17-101","BRM01-201","MPK17-101","SCA22-101","MPK-201","CUP05-202");
@Languages=("Italiano","Deutch","Latin","Espanol","Thai","French");
@Telexnos=("1-888-call","1-877-Telex-Me","1-800-Telex-Him","1-899-Telex-There","1-444-Telex-Her");


if ($piranha) {
    &PrintPreAmblePiranha($Output_File_Name);
}
else {
    &PrintPreAmbleBarracuda($Output_File_Name);
}



#open (OUTPUT_FILE, ">>$Output_File_Name") || 
#    die "Error---Can't open output file $Output_File_Name\n";

&PrintOrganizationalUnits;

if ($Verbose) {
    print "Ok, now generating $Number_To_Generate entries, please wait\n";
}

# We don't want people with duplicate names, so for each name generated,
# add it to "TheMap", which is an associative array with the
# name as the key. If there's a duplicate, throw the name out and
# try again. 

$dups = 0;

# Generate Number_To_Generate distinct entries. If a duplicate
# is created, toss it out and try again.

for ($x= 0; $x < $Number_To_Generate; $x++) {

    ($givenName, $sn, $cn) = &MakeRandomName;
    if (&AddAndCheck($cn)) {
	print "Duplicate: $cn...\n" if $debug;
	&flush(STDOUT);
	$dups++;
	$x--;
	next;
    }
    $OrgUnit          = &MakeRandomOrgUnit;
    $facsimileTelephoneNumber = &MakeRandomTelephone;
    $postalAddress    = &MakeRandomPostalAddress ($Organization,
						  int rand 1000, 
						  int rand 1000,
						  $OrgUnit);
    $postOfficeBox    = int rand 10000;
    $telephoneNumber  = &MakeRandomTelephone;
    $title        = &MakeRandomTitle($OrgUnit);
    $userPassword = reverse ($cn);
    $userPassword =~ s/\s//g;
    $userPassword = substr($userPassword, 0, 10);
    $locality     = &MakeRandomLocality;
    $description  = "This is $cn" . "'s description";
    $mail         = &MakeMailAddress($givenName, $sn, $domain);
    $amail         = &MakeAlternateMailAddress($givenName, $sn, $domain);
    $fmail         = &MakeForwardMailAddress($sn,$givenName, $domain);
	$maildomain=&MakeMailDomains;
    $CLOUD_TIMESTAMP =rand_datetime();
    $CLOUD_IP_ADDRESS ='$,=".";print map int rand 256,1..4'
    $CLOUD_CATEGORY =&MakeCategory;
    $CLOUD_LOG_LEVEL =&MakeLogLevel;
    $CLOUD_MESG_ID = &MakePostboxes;
    $CLOUD_ADMIN_PORT = int rand 10000;
    $CLOUD_OSARCH= &MakeMailHosts
    $CLOUD_HOST=&MakeMailDomains;
    $CLOUD_PORT= int rand 60000;
    
    if ($inetOrgPerson) {
        $carLicense        = "carLicense: " . &MakeRandomCarLicense . "\n";
        $departmentNumber  = "departmentNumber: " . (int rand 10000) . "\n";
        $employeeType      = "employeeType: " . &MakeRandomEmployeeType . "\n";
        $homePhone         = "homePhone: " . &MakeRandomTelephone . "\n";
        $initials          = "initials: " . &MakeInitials ($givenName, $sn) . "\n";
        $mobile            = "mobile: " . &MakeRandomTelephone . "\n";
        $pager             = "pager: "  . &MakeRandomTelephone . "\n";
        ($junk, $junk, $manager_cn) = &MakeRandomName;
        ($junk, $junk, $secretary_cn) = &MakeRandomName;
        $manager           = "manager: $manager_cn " . "\n";
		$interim=&MakePostboxes;
		$postofficebox	   = "postofficebox: " . $interim . "\n";
		$physicaldeliveryofficename	   = "physicaldeliveryofficename: " . $interim . "\n";
		$preferreddeliverymethod	   = "preferreddeliverymethod: " . &MakeDeliveryMethod . "\n";
		$preferredlanguage = "preferredlanguage: " . &MakeLanguages . "\n";
		$telexnumber	   = "telexnumber: " . &MakeTelexnumber . "\n";
		$mailhost	   = "mailhost: " . &MakeMailHosts . "\n";
		$mailquota	   = "mailquota: " . &MakeQuota . "\n";
		$maildomain	   = "mailaccessdomain: " . &MakeMailDomains . "\n";
		$replymode	   = "mailAutoReplyMode: " . &MakeMailReplyMode . "\n";
		$category	   = "businesscategory: " . &MakeCategory . "\n";
		$deliveryoption	   = "mailDeliveryOption:" . &MakeMailDelivery . "\n";
		$street	   = "street:" . &MakeStreets . "\n";
		$st	   = "st:" . &MakeStates . "\n";
        $secretary         = "secretary: $secretary_cn" . "\n";
        $displayname         = "displayname: $cn" . "\n";
        $regaddress         = "registeredaddress: 901 San Antonio Road, Palo Alto" . "\n";
        $roomNumber        = "roomNumber: " . (int rand 10000) . "\n";
        $employeenumber        = "employeenumber: " . (int rand 1000000) . "\n";
		$uid1= $givenName . "_" . "$sn";
        $uid               = "uid: " . $givenName . "_" . "$sn\n";
        $userPassword      = $givenName . "_" . "$sn\n";
    }
    

 print STDOUT
     "dn: mail=$mail, ou=$OrgUnit, $Suffix\n",
     "cn: $cn\n",
     "sn: $sn\n",
     "givenName: $givenName\n",
     "objectClass: top\n",
     "objectClass: person\n",
     "objectClass: organizationalPerson\n",
     "objectClass: mailrecipient\n",
     $inetOrgPerson, 
     $carLicense,
     $departmentNumber,
     $physicaldeliveryofficename,
     $preferreddeliverymethod,
     $employeeType,
     $homePhone,
     $initials,
     $displayname,
     $regaddress,
     $mobile,
     $pager,
     $st,
     $manager,
	 $postofficebox,
	 $category,
	 $street,
	 $preferredlanguage,
	 $mailhost,
	 $mailquota,
	 $employeenumber,
	 $deliveryoption,
	 $telexnumber,
	 $maildomain,
	 $replymode,
     $secretary,
     $roomNumber,
     $uid,
     "description: $description\n",
     "facsimileTelephoneNumber: $facsimileTelephoneNumber\n",
     "l:  $locality",
     "ou: $OrgUnit\n",
     "mail: $mail\n",
     "postalAddress: $postalAddress\n",
     "telephoneNumber: $telephoneNumber\n",
     "title: $title\n",
     "mailAlternateAddress: $amail\n",
     "mailForwardingAddress: $fmail\n",
     "userPassword: $userPassword",
     "\n";
    
    if (!$Quiet) {
	if ($x % 10000 == 0) {
	   # print ".";
	    &flush(STDOUT);
	}
    }
    
}

if ($Verbose) {
    print "Generated $x entries, $dups duplicates skipped\n";
}

exit 0;
	       

sub ReadOrgUnits {
    open (ORG_UNITS, $OrgUnitsFile) ||
	die "Bad news, failed to open Org Units, $OrgUnitsFile: $!\n";
    while(<ORG_UNITS>) {
	chop;
	push (@OrganizationalUnits, $_);
    }
    close ORG_UNITS;
}


sub ReadGivenNames {
    open (GIVEN_NAMES, $GivenNamesFile) || 
	die "Bad News, failed to load given names. $GivenNamesFile\n";
    $i = 0;
    while (<GIVEN_NAMES>) {
	chop;
	$given_names[$i++] = $_;
    }
    close GIVEN_NAMES;
}

sub ReadFamilyNames {
    open (FAMILY_NAMES, $FamilyNamesFile) ||
	die "Bad News, failed to load Family Names. $FamilyNamesFile\n";
    
    $i = 0;
    while (<FAMILY_NAMES>) {
	chop;
	$family_names[$i++] = $_;
    }
    close FAMILY_NAMES;
}



sub PrintPreAmblePiranha {
    local($output_file) = @_;

    #open (OUTPUT_FILE, ">$output_file") || die "Can't open $output_file for writing $!\n";
    print STDOUT<<End_Of_File
dn: $Suffix
objectClass: top
objectClass: organization
o: $Organization
subtreeaci: +(&(privilege=write)(target=ldap:///self))
subtreeaci: +(privilege=compare)
subtreeaci: +(|(privilege=search)(privilege=read))

End_Of_File
    ;
    
    #close (OUTPUT_FILE);
    
}

sub PrintPreAmbleBarracuda {
    local($output_file) = @_;

#    open (OUTPUT_FILE, ">$output_file") || die "Can't open $output_file for writing $!\n";
    
    print STDOUT<<End_Of_File
dn: $Suffix
objectClass: top
objectClass: organization
o: $Organization
aci: (target=ldap:///$Suffix)(targetattr=*)(version 3.0; acl "acl1"; allow(write) userdn = "ldap:///self";) 
aci: (target=ldap:///$Suffix)(targetattr=*)(version 3.0; acl "acl2"; allow(write) groupdn = "ldap:///cn=Directory Administrators, $Suffix";)
aci: (target=ldap:///$Suffix)(targetattr=*)(version 3.0; acl "acl3"; allow(read, search, compare) userdn = "ldap:///anyone";)

End_Of_File
    ;
#    close (OUTPUT_FILE);
}

sub PrintPreAmbleNoACI {
    local($output_file) = @_;

#    open (OUTPUT_FILE, ">$output_file") || die "Can't open $output_file for writing $!\n";
 
    print STDOUT<<End_Of_File
dn: $Suffix
objectClass: top
objectClass: organization
o: $Organization

End_Of_File
    ;
    #close (OUTPUT_FILE);
    
}



sub PrintOrganizationalUnits {
    foreach $ou (@OrganizationalUnits) {
        print STDOUT 
            "dn: ou=$ou, $Suffix\n",
            "objectClass: top\n",
            "objectClass: organizationalUnit\n",
            "ou: $ou\n\n";
    }
}


sub MakeRandomTitle {
    local($org_unit) = @_;
    return 
	"$title_ranks[rand @title_ranks] $org_unit $positions[rand @positions]";
}

sub MakeRandomLocality {
    return $localities[rand @localities];
}
    

    
sub MakeRandomName {
    local($Given_Name, $Surname, $Display_Name);
    $Given_Name   = $given_names[rand @given_names];
    $Surname      = $family_names[rand @family_names] . $x;
    $Display_Name = "$Given_Name $Surname";
    return ($Given_Name, $Surname, $Display_Name);
}


sub MakeRandomOrgUnit {
    return $OrganizationalUnits[rand @OrganizationalUnits];
}


sub MakeRandomTelephone {
    local($prefix, $suffix, $Phone_Number);
    $prefix = int rand(900) + 100; 
    $suffix = int rand(9000) + 1000;

    return $Phone_Number = "+1 " . $area_codes[rand @area_codes] . " " .
	"$prefix-$suffix";

}
sub MakePostboxes {
return $Mailboxes[rand @Mailboxes];
}
sub MakeLanguages {
return $Languages[rand @Languages];
}
sub MakeMailHosts {
return $MailHosts[rand @MailHosts];
}
sub MakeTelexnumber {
return $Telexnos[rand @Telexnos];
}
 
sub MakeRandomEmployeeType {
    return $EmployeeTypes[rand @EmployeeTypes];
}


sub MakeRandomCarLicense {
    local ($rand_char_index, $ascii_value, $license);
 
    for (1..7) {
        $rand_char_index = int rand 36;
        $ascii_value = ($rand_char_index > 9) ? $rand_char_index + 55 : 
	    $rand_char_index + 48;
        $license .= pack ("c", $ascii_value);
    }
    return $license;
}

# All entries are added to TheMap which checks to see
# if the name is already there
sub AddAndCheck {
    local($cn) = @_;
    # now isn't this better than STL?
    if ($TheMap{$cn}) {
	return 1;
    }
    else {
	$TheMap{$cn} = 1;
	return 0;
    }
}

sub MakeMailAddress {
    local($given_name, $sur_name, $domain) = @_;
    
    return "$given_name". "_$sur_name\@$domain.com";
}
sub MakeAlternateMailAddress {
    local($given_name, $sur_name, $domain) = @_;
    
    return "$given_name". ".$sur_name\@$domain.com";
}
sub MakeForwardMailAddress {
    local($given_name, $sur_name, $domain) = @_;
    
    return "$given_name". ".$sur_name\@$domain.com";
}
       

sub MakeRandomPostalAddress {
    local ($org, $departmentNumber,$roomNumber, $OrgUnit) = @_;
    return "$org, $OrgUnit Dept \#$departmentNumber, Room\#$roomNumber";
}


sub MakeInitials {
    local ($givenName, $sn) = @_;
    local ($first, $last);
    
    ($first) = $givenName =~ /^(\w).*/;
    ($last)  = $sn        =~ /^(\w).*/;
    return "$first" . ". " . "$last" . ".";
}



