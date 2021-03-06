###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_adobe_flash_player_mult_vuln01_mar13_win.nasl 9353 2018-04-06 07:14:20Z cfischer $
#
# Adobe Flash Player Multiple Vulnerabilities -01 March13 (Windows)
#
# Authors:
# Arun Kallavi <karun@secpod.com>
#
# Copyright:
# Copyright (c) 2013 Greenbone Networks GmbH, http://www.greenbone.net
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

CPE = "cpe:/a:adobe:flash_player";

tag_impact = "Successful exploitation will allow remote attackers to execute arbitrary
  code or cause  denial-of-service condition.
  Impact Level: System/Application";

tag_affected = "Adobe Flash Player 10.3.183.63 and earlier, and 11.x to 11.6.602.168 on
  Windows";
tag_insight = "Multiple flaws due to,

  - A flaw in the ExternalInterface ActionScript feature.

  - Firefox sandbox does not restrict privileges.

  - Buffer overflow in the Flash Player broker service.";
tag_solution = "Update to version 10.3.183.67 or 11.6.602.171,
  For updates refer to http://www.adobe.com/products/flash.html";
tag_summary = "This host is installed with Adobe Flash Player and is prone to
  multiple vulnerabilities.";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.803323");
  script_version("$Revision: 9353 $");
  script_tag(name:"last_modification", value:"$Date: 2018-04-06 09:14:20 +0200 (Fri, 06 Apr 2018) $");
  script_tag(name:"creation_date", value:"2013-03-04 18:17:51 +0530 (Mon, 04 Mar 2013)");
  script_tag(name:"cvss_base", value:"10.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:C/I:C/A:C");
  script_cve_id("CVE-2013-0648","CVE-2013-0643","CVE-2013-0504");
  script_bugtraq_id(58186,58185,58184);
  script_name("Adobe Flash Player Multiple Vulnerabilities -01 March13 (Windows)");
  script_xref(name : "URL" , value : "http://www.securitytracker.com/id/1028210");
  script_xref(name : "URL" , value : "http://www.securelist.com/en/advisories/52374");
  script_xref(name : "URL" , value : "http://www.adobe.com/support/security/bulletins/apsb13-08.html");

  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2013 Greenbone Networks GmbH");
  script_family("General");
  script_dependencies("gb_adobe_flash_player_detect_win.nasl");
  script_mandatory_keys("AdobeFlashPlayer/Win/Installed");
  script_tag(name : "impact" , value : tag_impact);
  script_tag(name : "affected" , value : tag_affected);
  script_tag(name : "insight" , value : tag_insight);
  script_tag(name : "solution" , value : tag_solution);
  script_tag(name : "summary" , value : tag_summary);
  script_tag(name:"qod_type", value:"registry");
  script_tag(name:"solution_type", value:"VendorFix");
  exit(0);
}

include("host_details.inc");
include("version_func.inc");

infos = get_app_version_and_location( cpe:CPE, exit_no_version:TRUE );
vers = infos['version'];
path = infos['location'];

## Check for Adobe Flash Player version prior to 10.3.183.63 or 11.6.602.168
if( version_is_less_equal( version:vers, test_version:"10.3.183.63") ||
    version_in_range( version:vers, test_version:"11.0", test_version2:"11.6.602.168" ) ) {
  report = report_fixed_ver( installed_version:vers, fixed_version:"10.3.183.67 or 11.6.602.171", install_path:path );
  security_message( port:0, data:report );
  exit( 0 );
}

exit( 99 );