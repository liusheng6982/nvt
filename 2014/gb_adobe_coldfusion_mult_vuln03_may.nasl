###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_adobe_coldfusion_mult_vuln03_may.nasl 6692 2017-07-12 09:57:43Z teissa $
#
# Adobe ColdFusion Multiple Vulnerabilities-03 May-2014
#
# Authors:
# Antu Sanadi <santu@secpod.com>
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

SCRIPT_OID  = "1.3.6.1.4.1.25623.1.0.804445";
CPE = "cpe:/a:adobe:coldfusion";

if(description)
{
  script_oid(SCRIPT_OID);
  script_version("$Revision: 6692 $");
  script_cve_id("CVE-2013-0625", "CVE-2013-0629");
  script_bugtraq_id(57164, 57165);
  script_tag(name:"cvss_base", value:"6.8");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:P/I:P/A:P");
  script_tag(name:"last_modification", value:"$Date: 2017-07-12 11:57:43 +0200 (Wed, 12 Jul 2017) $");
  script_tag(name:"creation_date", value:"2014-05-06 16:22:22 +0530 (Tue, 06 May 2014)");
  script_name("Adobe ColdFusion Multiple Vulnerabilities-03 May-2014");

  tag_summary =
"This host is running Adobe ColdFusion and is prone to multiple
vulnerabilities.";

  tag_vuldetect =
"Get the installed version of Adobe ColdFusion with the help of detect NVT and
check the version is vulnerable or not.";

  tag_insight =
"Multiple flaws are due to,
- The CFIDE/componentutils/cfcexplorer.cfc script not properly sanitizing
  user input, specifically directory traversal attacks supplied via the
  'path' parameter when 'method' is set to: 'getcfcinhtml' and 'name' is
   set to 'CFIDE.adminapi.administrator'.
- The 'ScheduledURL' variable allows specifying an arbitrary resource to save
  to system as specified by the 'publish_file' variable and then schedule this
  task to be executed at a set time. ";

  tag_impact =
"Successful exploitation will allow attackers to disclose the contents of
arbitrary files on the system and execute arbitrary code.

Impact Level: System/Application";

  tag_affected =
"Adobe ColdFusion 9.0, 9.0.1, 9.0.2, and 10";

  tag_solution =
"Apply the patch from below link,
http://www.adobe.com/support/security/bulletins/apsb13-03.html";


  script_tag(name : "summary" , value : tag_summary);
  script_tag(name : "vuldetect" , value : tag_vuldetect);
  script_tag(name : "insight" , value : tag_insight);
  script_tag(name : "impact" , value : tag_impact);
  script_tag(name : "affected" , value : tag_affected);
  script_tag(name : "solution" , value : tag_solution);

  script_xref(name : "URL" , value : "http://www.exploit-db.com/exploits/24946");
  script_xref(name : "URL" , value : "http://www.adobe.com/support/security/bulletins/apsb13-03.html");
  script_category(ACT_GATHER_INFO);
  script_tag(name:"qod_type", value:"remote_banner");
  script_family("Web application abuses");
  script_copyright("Copyright (C) 2014 Greenbone Networks GmbH");
  script_dependencies("gb_coldfusion_detect.nasl");
  script_mandatory_keys("coldfusion/installed");
  script_require_ports("Services/www", 80);
  exit(0);
}


include("version_func.inc");
include("host_details.inc");

## Variable initialization
smgPort = "";
smgVer = "";

## Get Application HTTP Port
if(!smgPort = get_app_port(cpe:CPE, nvt:SCRIPT_OID)){
  exit(0);
}

## Get application version
smgVer = get_app_version(cpe:CPE, nvt:SCRIPT_OID, port:smgPort);
if(!smgVer || "unknown" >< smgVer){
  exit(0);
}

if(version_is_equal(version:smgVer, test_version:"9.0.0.251028") ||
   version_is_equal(version:smgVer, test_version:"9.0.1.274733") ||
   version_is_equal(version:smgVer, test_version:"9.0.2.282541") ||
   version_is_equal(version:smgVer, test_version:"10.0.0.282462"))
{
  security_message(port:smgPort);
  exit(0);
}
