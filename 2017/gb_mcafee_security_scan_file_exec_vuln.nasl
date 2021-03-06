###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_mcafee_security_scan_file_exec_vuln.nasl 7174 2017-09-18 11:48:08Z asteins $
#
# McAfee Security Scan Plus File Execution Vulnerability (Windows)
#
# Authors:
# Kashinath T <tkashinath@secpod.com>
#
# Copyright:
# Copyright (C) 2017 Greenbone Networks GmbH, http://www.greenbone.net
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

CPE = "cpe:/a:intel:mcafee_security_scan_plus";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.810826");
  script_version("$Revision: 7174 $");
  script_cve_id("CVE-2015-8991");
  script_tag(name:"cvss_base", value:"6.9");
  script_tag(name:"cvss_base_vector", value:"AV:L/AC:M/Au:N/C:C/I:C/A:C");
  script_tag(name:"last_modification", value:"$Date: 2017-09-18 13:48:08 +0200 (Mon, 18 Sep 2017) $");
  script_tag(name:"creation_date", value:"2017-03-22 11:57:02 +0530 (Wed, 22 Mar 2017)");
  script_name("McAfee Security Scan Plus File Execution Vulnerability (Windows)");

  script_tag(name: "summary" , value:"This host is installed with McAfee Security
  Scan Plus and is prone to file execution vulnerability.");

  script_tag(name: "vuldetect" , value:"Get the installed version with the help
  of detect NVT and check the version is vulnerable or not.");

  script_tag(name: "insight" , value:"The flaw exists only within installers and
  uninstallers, and may manifest only during installation or uninstallation
  operations.");

  script_tag(name: "impact" , value:"Successful exploitation will allows
  attackers to make the product momentarily vulnerable via executing preexisting
  specifically crafted malware during installation or uninstallation, but not
  during normal operation.

  Impact Level: System/Application");

  script_tag(name: "affected" , value:"McAfee Security Scan Plus version prior to
  3.11.266.3. For updates refer to,
  https://service.mcafee.com/webcenter/portal/cp/home/articleview?articleId=TS102462");

  script_tag(name: "solution" , value:"Upgrade to McAfee Security scan plus 3.11.266.3");

  script_tag(name:"solution_type", value:"VendorFix");
  script_tag(name:"qod_type", value:"registry");
  script_xref(name : "URL" , value : "https://service.mcafee.com/webcenter/portal/cp/home/articleview?articleId=TS102462");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2017 Greenbone Networks GmbH");
  script_family("General");
  script_dependencies("gb_mcafee_security_scan_plus_detect.nasl");
  script_mandatory_keys("McAfee/SecurityScanPlus/Win/Ver");
  exit(0);
}

include("host_details.inc");
include("version_func.inc");

## Variable Initialization
msspVer  = "";
report = "";

##Fetch version
if(!msspVer = get_app_version(cpe:CPE)){
  exit(0);
}

##Check for vulnerable versions
if(version_is_less(version:msspVer, test_version:"3.11.266.3"))
{
  report = report_fixed_ver(installed_version:msspVer, fixed_version:"3.11.266.3");
  security_message(data:report);
  exit(0);
}
