#!env perl
#Author: autoCreated
my $para_num = "1";
my %para;
@array_pre_flag = ();
@array_appendix_flag = ();

$para{Linux_su_password} = $ARGV[1];
$para{Linux_su_user} = $ARGV[2];

push(@array_pre_flag, 1);$pre_cmd{1} = "openssl version
lsb_release -a
";
push(@array_pre_flag, 2);$pre_cmd{2} = "env -i  X='() { (a)=>\\' bash -c '/dev/stdout echo vulnerable'  2>/dev/null
";
push(@array_pre_flag, 3);$pre_cmd{3} = "hostname
";
push(@array_pre_flag, 4);$pre_cmd{4} = "ifconfig
";
push(@array_pre_flag, 5);$pre_cmd{5} = "cat /etc/passwd
cat /etc/group
";
push(@array_pre_flag, 7);$pre_cmd{7} = "cat /etc/shadow
";
push(@array_pre_flag, 8);$pre_cmd{8} = "chkconfig --list
";
push(@array_pre_flag, 9);$pre_cmd{9} = "netstat -aptn
";
push(@array_pre_flag, 10);$pre_cmd{10} = "ps -ef
";
push(@array_pre_flag, 11);$pre_cmd{11} = "cat /proc/version
";
push(@array_pre_flag, 12);$pre_cmd{12} = "whoami | id
";
push(@array_pre_flag, 13);$pre_cmd{13} = "lastlog
";
push(@array_pre_flag, 14);$pre_cmd{14} = "/sbin/ifconfig -a
";
push(@array_pre_flag, 15);$pre_cmd{15} = "df
";
push(@array_pre_flag, 16);$pre_cmd{16} = "cat /etc/resolv.conf
";
push(@array_pre_flag, 18);$pre_cmd{18} = "systemctl status firewalld
service iptables status
";
push(@array_pre_flag, 20);$pre_cmd{20} = "service --status-all
";


sub get_os_info
{
	my %os_info = (
 "initSh"=>"","hostname"=>"","osname"=>"","osversion"=>"");
 $os_info{"initSh"} = `unset LANG`;
	$os_info{"hostname"} = `uname -n`;
	$os_info{"osname"} = `uname -s`;
	$os_info{"osversion"} = `lsb_release -a;cat /etc/issue;cat /etc/redhat-release;uname -a`;
	foreach (%os_info){   chomp;}
	return %os_info;
}

sub add_item
{
	 my ($string, $flag, $value)= @_;
	 $string .= "\t\t".'<script>'."\n";
	 $string .= "\t\t\t<id>$flag</id>\n";
	 $string .= "\t\t\t<value><![CDATA[$value]]></value>\n";
	 $string .= "\t\t</script>\n";
	return $string;
}
sub generate_xml
{
	$ARGC = @ARGV;
	if($ARGC lt 1)
	{
		print qq{usag:uuid.pl IP };
		exit;
	}
	my %os_info = get_os_info();
	my $os_name = $os_info{"osname"};
	my $host_name = $os_info{"hostname"};
	my $os_version = $os_info{"osversion"};
	my $date = ` date "+%Y-%m-%d %H:%M:%S"`;
	chomp $date;
	my $coding = `echo \$LANG`;
	my $coding_value = "UTF-8";
	chomp $coding;
	if($coding =~ "GB")
	{
        $coding_value = "GBK"
    }
	my $ipaddr = $ARGV[0];
	my $xml_string = "";
	
	$xml_string .='<?xml version="1.0" encoding="'.$coding_value.'"?>'."\n";
	$xml_string .='<result>'."\n";
	$xml_string .= '<osName><![CDATA['."$os_name".']]></osName>'."\n";
	$xml_string .= '<version><![CDATA['."$os_version".']]></version>'."\n";
	$xml_string .= '<ip><![CDATA['."$ipaddr".']]></ip>'."\n";
	$xml_string .= '<type><![CDATA[/server/Linux]]></type>'."\n";
	$xml_string .= '<startTime><![CDATA['."$date".']]></startTime>'."\n";
	$xml_string .= '<pId><![CDATA[0]]></pId>'."\n";

	$xml_string .=	"\t".'<scripts>'."\n";
	
	foreach $key (@array_pre_flag)
	{
	    print $key."\n";
		$value = $pre_cmd{$key};
		my $tmp_result = $value.`$value`;
		chomp $tmp_result;
		$tmp_result =~ s/>/&gt;/g;
		$tmp_result =~ s/[\x00-\x08\x0b-\x0c\x0e-\x1f]//g;
		$xml_string = &add_item( $xml_string, $key, $tmp_result );
	}
	$xml_string .= "\t</scripts>\n";
	
	my $enddate = ` date "+%Y-%m-%d %H:%M:%S"`;
	$xml_string .= '<endTime><![CDATA['."$enddate".']]></endTime>'."\n";
	
	$xml_string .= "</result>"."\n";
	$xmlfile = $ipaddr."_"."linux"."_chk.xml";
	print $xmlfile."\n";
	open XML,">/tmp/ip_gdsxxaqcpzx_linux.xml" or die "Cannot create ip.xml:$!";
	print XML $xml_string;
	print "write  result to xml'file\n";
    print "execute end!\n";
 }
 generate_xml();
