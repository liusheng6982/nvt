##############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_google_chrome_stable-channel-update_24-2016-03_win.nasl 5836 2017-04-03 09:37:08Z teissa $
#
# Google Chrome Security Updates(stable-channel-update_24-2016-03)-Windows
#
# Authors:
# Kashinath T <tkashinath@secpod.com> 
#
# Copyright:
# Copyright (C) 2016 Greenbone Networks GmbH, http://www.greenbone.net
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

CPE = "cpe:/a:google:chrome";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.807642");
  script_version("$Revision: 5836 $");
  script_cve_id("CVE-2016-1646", "CVE-2016-1647", "CVE-2016-1648", "CVE-2016-1649", 
		        "CVE-2016-1650", "CVE-2016-3679");
  script_tag(name:"cvss_base", value:"9.3");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:C/I:C/A:C");
  script_tag(name:"last_modification", value:"$Date: 2017-04-03 11:37:08 +0200 (Mon, 03 Apr 2017) $");
  script_tag(name:"creation_date", value:"2016-03-28 10:36:52 +0530 (Mon, 28 Mar 2016)");
  script_name("Google Chrome Security Updates(stable-channel-update_24-2016-03)-Windows");

  script_tag(name: "summary" , value:"The host is installed with Google Chrome
  and is prone to multiple vulnerabilities.");

  script_tag(name: "vuldetect" , value:"Get the installed version with the help
  of detect NVT and check the version is vulnerable or not.");

  script_tag(name: "insight" , value:"The multiple flaws exists due to,
  - Out-of-bounds read in V8.
  - Use-after-free in Navigation.
  - Use-after-free in Extensions.
  - Buffer overflow in libANGLE.
  - Various fixes from internal audits, fuzzing and other initiatives.
  - Multiple unspecified vulnerabilities in Google V8.");

  script_tag(name: "impact" , value:"Successful exploitation will allow an
  attacker to execute arbitrary code in the context of the browser, obtain
  sensitive information, bypass security restrictions, or cause
  denial-of-service conditions.

  Impact Level: Application");

  script_tag(name: "affected" , value:"Google Chrome version 
  prior to 49.0.2623.108 on Windows.");

  script_tag(name: "solution", value:"Upgrade to Google Chrome version
  49.0.2623.108 or later.
  For updates refer to http://www.google.com/chrome");

  script_tag(name:"solution_type", value:"VendorFix");

  script_tag(name:"qod_type", value:"registry");

  script_xref(name : "URL" , value : "http://googlechromereleases.blogspot.in/2016/03/stable-channel-update_24.html");

  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2016 Greenbone Networks GmbH");
  script_family("General");
  script_dependencies("gb_google_chrome_detect_win.nasl");
  script_mandatory_keys("GoogleChrome/Win/Ver");
  exit(0);
}

include("host_details.inc");
include("version_func.inc");

## Variable Initialization
chr_ver = "";

## Get version
if(!chr_ver = get_app_version(cpe:CPE)){
  exit(0);
}

## Grep for vulnerable version
if(version_is_less(version:chr_ver, test_version:"49.0.2623.108"))
{
  report = report_fixed_ver(installed_version:chr_ver, fixed_version:"49.0.2623.108");
  security_message(data:report);
  exit(0);
}
