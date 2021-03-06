###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_apple_macosx_bof_vuln_jan14.nasl 30092 2014-01-20 20:19:58Z Jan$
#
# Apple Mac OS X Directory Service Remote Buffer Overflow Vulnerability
#
# Authors:
# Thanga Prakash S <tprakash@secpod.com>
#
# Copyright:
# Copyright (C) 2014 Greenbone Networks GmbH, http://www.greenbone.net
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# (or any later version), as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
###############################################################################

SCRIPT_OID  = "1.3.6.1.4.1.25623.1.0.804062";

if(description)
{
  script_oid(SCRIPT_OID);
  script_version("$Revision: 6735 $");
  script_cve_id("CVE-2013-0984");
  script_bugtraq_id(60328);
  script_tag(name:"cvss_base", value:"9.3");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:C/I:C/A:C");
  script_tag(name:"last_modification", value:"$Date: 2017-07-17 11:56:49 +0200 (Mon, 17 Jul 2017) $");
  script_tag(name:"creation_date", value:"2014-01-20 20:19:58 +0530 (Mon, 20 Jan 2014)");
  script_name("Apple Mac OS X Directory Service Remote Buffer Overflow Vulnerability");

  tag_summary =
"This host is running Apple Mac OS X and is prone to buffer overflow
vulnerability.";

  tag_vuldetect =
"Get the installed version with the help of detect NVT and check the version
is vulnerable or not.";

  tag_insight =
"Flaw is due to improper handling of network messages.";

  tag_impact =
"Successful exploitation will allow attackers to, execute arbitrary code or
cause a denial of service.

Impact Level: System/Application";

  tag_affected =
"Apple Mac OS X version 10.6.8 and prior.";

  tag_solution =
"Run Mac Updates and install OS X v10.8.4 Supplemental Update,
For updates refer to http://support.apple.com/kb/HT5784";


  script_tag(name : "summary" , value : tag_summary);
  script_tag(name : "vuldetect" , value : tag_vuldetect);
  script_tag(name : "insight" , value : tag_insight);
  script_tag(name : "impact" , value : tag_impact);
  script_tag(name : "affected" , value : tag_affected);
  script_tag(name : "solution" , value : tag_solution);
  script_tag(name:"qod_type", value:"package");
  script_tag(name:"solution_type", value:"VendorFix");

  script_xref(name : "URL" , value : "http://support.apple.com/kb/HT5784");
  script_xref(name : "URL" , value : "http://support.apple.com/kb/HT6001");
  script_xref(name : "URL" , value : "http://secunia.com/advisories/53684");
  script_xref(name : "URL" , value : "http://prod.lists.apple.com/archives/security-announce/2013/Jun/msg00000.html");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2014 Greenbone Networks GmbH");
  script_family("General");
  script_dependencies("gather-package-list.nasl");
  script_mandatory_keys("ssh/login/osx_name", "ssh/login/osx_version");
  exit(0);
}


include("version_func.inc");

## Variable Initialization
osName = "";
osVer = "";

## Get the OS name
osName = get_kb_item("ssh/login/osx_name");
if(!osName){
  exit (0);
}

## Get the OS Version
osVer = get_kb_item("ssh/login/osx_version");
if(!osVer){
 exit(0);
}

## Check for the Mac OS X
if("Mac OS X" >< osName)
{
  ## Check the affected OS versions
  if(version_is_less_equal(version:osVer, test_version:"10.6.8"))
  {
    security_message(0);
    exit(0);
  }
}
