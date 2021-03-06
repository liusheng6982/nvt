###############################################################################
# OpenVAS Vulnerability Test
# $Id: smbcl_getversion.nasl 5260 2017-02-10 12:33:44Z cfi $
#
# SMB Test with 'smbclient'
#
# Authors:
# Carsten Koch-Mauthe <c.koch-mauthe at dn-systems.de>
#
# Copyright:
# Copyright (C) 2008 Greenbone Networks GmbH
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2,
# as published by the Free Software Foundation
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
###############################################################################

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.90011");
  script_version("$Revision: 5260 $");
  script_tag(name:"last_modification", value:"$Date: 2017-02-10 13:33:44 +0100 (Fri, 10 Feb 2017) $");
  script_tag(name:"creation_date", value:"2008-05-15 23:18:24 +0200 (Thu, 15 May 2008)");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:N/I:N/A:N");
  script_tag(name:"cvss_base", value:"0.0");
  script_name("SMB Test with 'smbclient'");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2008 Greenbone Networks GmbH");
  script_family("Windows");
  script_dependencies("smb_authorization.nasl", "cifs445.nasl");
  script_require_ports(139, 445);
  script_mandatory_keys("SMB/transport");

  script_tag(name:"summary", value:"This script tests the remote host SMB Functions with the 'smbclient' tool.");

  script_tag(name:"qod_type", value:"remote_banner");

  exit(0);
}

include("smb_nt.inc");
include("smbcl_func.inc");

port = kb_smb_transport();
if( ! port ) port = 139;
if( ! get_port_state( port ) ) exit( 0 );

if( check_smbcl() == 0 ) exit( 0 );

smbOS = get_kb_item( "SMB/OS" );
smbDomain = get_kb_item( "SMB/DOMAIN" );
smbServer = get_kb_item( "SMB/SERVER" );

report = "OS Version = " + smbOS + '\n';
report += "Domain = " + smbDomain + '\n';
report += "SMB Serverversion = " + smbServer + '\n';
log_message( port:port, data:report );

exit( 0 );

#=====
#This is for testing only !
#Here you can see what is possible with smbcl_func.nasl
#This example will read the Versionnumber of all exe in the Windows\ Directory
#=====

  win_dir = get_windir();
#  path = win_dir+"Microsoft.NET\Framework\v2.0.50727\";
  path = win_dir; # +"SYSTEM32\";
  filespec = "*.exe";
#  filespec = "system.WEB.dll";

  r = smbgetdir(share: "C$", dir: path+filespec, typ: 1 );
  if( !isnull(r) ) {
    foreach i (keys(r)) {
      tmp_filename = get_tmp_dir()+"tmpfile"+rand();
      orig_filename = path+r[i];
      if( smbgetfile(share: "C$", filename: orig_filename, tmp_filename: tmp_filename) ) {
        report = string("SMB File successfully loaded ") + string("\n");
        v = GetPEFileVersion(tmp_filename:tmp_filename, orig_filename:orig_filename);
        unlink(tmp_filename);
        smbFileversion = get_kb_item( "SMB/FILEVERSION/" + orig_filename );
        report += "Fileversion : C$ "+orig_filename + " "+v+string("\n");
        report += "KB Fileversion Getting SMB-KB File -> " + smbFileversion + '\n';
        log_message(port:port, data:report);    
      } else {
        smbError = get_kb_item("SMB/ERROR");
        report = "Error getting SMB-File -> " + smbError + '\n';
        log_message(port:port, data:report);
      }
    }
  } else {
    report = string("No Files found according filespec : ")+path+filespec + string("\n");
    log_message(port:port, data:report);
  }
exit(0);
