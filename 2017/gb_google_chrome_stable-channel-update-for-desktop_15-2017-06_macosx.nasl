##############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_google_chrome_stable-channel-update-for-desktop_15-2017-06_macosx.nasl 6377 2017-06-20 10:16:39Z santu $
#
# Google Chrome Security Updates(stable-channel-update-for-desktop_15-2017-06)-MAC OS X
#
# Authors:
# Rinu Kuriakose <krinu@secpod.com> 
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
  script_oid("1.3.6.1.4.1.25623.1.0.810952");
  script_version("$Revision: 6377 $");
  script_cve_id("CVE-2017-5087", "CVE-2017-5088", "CVE-2017-5089" );
  script_tag(name:"cvss_base", value:"10.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:C/I:C/A:C");
  script_tag(name:"last_modification", value:"$Date: 2017-06-20 12:16:39 +0200 (Tue, 20 Jun 2017) $");
  script_tag(name:"creation_date", value:"2017-06-16 17:34:30 +0530 (Fri, 16 Jun 2017)");
  script_name("Google Chrome Security Updates(stable-channel-update-for-desktop_15-2017-06)-MAC OS X");

  script_tag(name: "summary" , value:"The host is installed with Google Chrome
  and is prone to multiple vulnerabilities.");

  script_tag(name: "vuldetect" , value:"Get the installed version with the help
  of detect NVT and check the version is vulnerable or not.");

  script_tag(name: "insight" , value:"The multiple flaws exists due to
  - A Sandbox Escape error in IndexedDB.
  - An Out of bounds read error in V8.
  - A Domain spoofing error in Omnibox.
  - Various fixes from internal audits, fuzzing and other initiatives.");

  script_tag(name: "impact" , value:"Successful exploitation of these
  vulnerabilities will allow remote attackers to conduct spoofing attacks,
  bypass security and cause application crash.

  Impact Level: Application");

  script_tag(name: "affected" , value:"Google Chrome version 
  prior to 59.0.3071.104 on MAC OS X");

  script_tag(name: "solution", value:"Upgrade to Google Chrome version
  59.0.3071.104 or later.
  For updates refer to http://www.google.com/chrome");

  script_tag(name:"solution_type", value:"VendorFix");

  script_tag(name:"qod_type", value:"executable_version");

  script_xref(name : "URL" , value : "https://chromereleases.googleblog.com/2017/06/stable-channel-update-for-desktop_15.html");

  script_summary("Check for the vulnerable version of Google Chrome on MAC OS X");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2016 Greenbone Networks GmbH");
  script_family("General");
  script_dependencies("gb_google_chrome_detect_macosx.nasl");
  script_mandatory_keys("GoogleChrome/MacOSX/Version");
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
if(version_is_less(version:chr_ver, test_version:"59.0.3071.104"))
{
  report = report_fixed_ver(installed_version:chr_ver, fixed_version:"59.0.3071.104");
  security_message(data:report);
  exit(0);
}