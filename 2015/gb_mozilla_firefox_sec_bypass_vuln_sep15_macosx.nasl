###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_mozilla_firefox_sec_bypass_vuln_sep15_macosx.nasl 6132 2017-05-16 09:03:39Z teissa $
#
# Mozilla Firefox Security Bypass Vulnerability - Sep15 (Mac OS X)
#
# Authors:
# Deependra Bapna <bdeependra@secpod.com>
#
# Copyright:
# Copyright (C) 2015 Greenbone Networks GmbH, http://www.greenbone.net
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

CPE = "cpe:/a:mozilla:firefox";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.805747");
  script_version("$Revision: 6132 $");
  script_cve_id("CVE-2015-4498");
  script_bugtraq_id(76505);
  script_tag(name:"cvss_base", value:"7.5");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:P/I:P/A:P");
  script_tag(name:"last_modification", value:"$Date: 2017-05-16 11:03:39 +0200 (Tue, 16 May 2017) $");
  script_tag(name:"creation_date", value:"2015-09-25 15:47:42 +0530 (Fri, 25 Sep 2015)");
  script_name("Mozilla Firefox Security Bypass Vulnerability - Sep15 (Mac OS X)");

  script_tag(name: "summary" , value:"This host is installed with Mozilla
  Firefox and is prone to security bypass vulnerability.");

  script_tag(name: "vuldetect" , value:"Get the installed version with the help
  of detect NVT and check the version is vulnerable or not.");

  script_tag(name: "insight" , value:"The flaw exists as add-on's URL
  failure to handle exceptional conditions.");

  script_tag(name: "impact" , value:"Successful exploitation will allow remote
  attackers to manipulate a user into falsely believing a trusted site has
  initiated the installation. This could lead to users installing an add-on
  from a malicious source.

  Impact Level: System/Application");

  script_tag(name: "affected" , value:"Mozilla Firefox version before 40.0.3 on
  Mac OS X");

  script_tag(name: "solution" , value:"Upgrade to Mozilla Firefox version 40.0.3
  or later, For updates refer to http://www.mozilla.com/en-US/firefox/all.html");

  script_tag(name:"solution_type", value:"VendorFix");

  script_tag(name:"qod_type", value:"registry");

  script_xref(name:"URL", value:"https://www.mozilla.org/en-US/security/advisories/mfsa2015-95/");

  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2015 Greenbone Networks GmbH");
  script_family("General");
  script_dependencies("gb_mozilla_prdts_detect_macosx.nasl");
  script_mandatory_keys("Mozilla/Firefox/MacOSX/Version");
  exit(0);
}


include("host_details.inc");
include("version_func.inc");

## Variable Initialization
ffVer = "";

## Get version
if(!ffVer = get_app_version(cpe:CPE)){
   exit(0);
}

# Check for vulnerable version
if(version_is_less(version:ffVer, test_version:"40.0.3"))
{
  report = 'Installed version: ' + ffVer + '\n' +
           'Fixed version:     ' + "40.0.3" + '\n';
  security_message(data:report);
  exit(0);
}
