###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_mozilla_firefox_esr_mult_vuln02_nov13_win.nasl 31965 2013-11-07 14:47:17Z nov$
#
# Mozilla Firefox ESR Multiple Vulnerabilities-02 Nov13 (Windows)
#
# Authors:
# Shakeel <bshakeel@secpod.com>
#
# Copyright:
# Copyright (C) 2013 Greenbone Networks GmbH, http://www.greenbone.net
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

CPE = "cpe:/a:mozilla:firefox_esr";
SCRIPT_OID  = "1.3.6.1.4.1.25623.1.0.804132";

if(description)
{
  script_oid(SCRIPT_OID);
  script_version("$Revision: 6115 $");
  script_cve_id("CVE-2013-5604", "CVE-2013-5602", "CVE-2013-5601", "CVE-2013-5600",
                "CVE-2013-5599", "CVE-2013-5597", "CVE-2013-5590", "CVE-2013-5595");
  script_bugtraq_id(63430, 63424, 63428, 63427, 63423, 63422, 63415, 63421);
  script_tag(name:"cvss_base", value:"10.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:C/I:C/A:C");
  script_tag(name:"last_modification", value:"$Date: 2017-05-12 11:03:25 +0200 (Fri, 12 May 2017) $");
  script_tag(name:"creation_date", value:"2013-11-07 14:28:51 +0530 (Thu, 07 Nov 2013)");
  script_name("Mozilla Firefox ESR Multiple Vulnerabilities-02 Nov13 (Windows)");

  tag_summary =
"This host is installed with Mozilla Firefox ESR and is prone to multiple
vulnerabilities.";

  tag_vuldetect =
"Get the installed version with the help of detect NVT and check the version
is vulnerable or not.";

  tag_insight =
"Multiple flaws due to,
- Improper data initialization in the 'txXPathNodeUtils::getBaseURI' function.
- An error in 'Worker::SetEventListener' function in Web workers implementation.
- Use-after-free vulnerability in the
'nsEventListenerManager::SetEventHandler' function.
- Use-after-free vulnerability in 'nsIOService::NewChannelFromURIWithProxyFlags'
function.
- Use-after-free vulnerability in the 'nsIPresShell::GetPresContext' function.
- Use-after-free vulnerability in 'nsDocLoader::doStopDocumentLoad' function.
- Multiple unspecified vulnerabilities in the browser engine.
- Improper memory allocation for unspecified functions by JavaScript engine.";

  tag_impact =
"Successful exploitation will allow attackers to execute arbitrary code,
cause a denial of service and conduct buffer overflow attacks.

Impact Level: System/Application.";

  tag_affected =
"Mozilla Firefox ESR version 17.x before 17.0.10 and 24.x before 24.1 on Windows.";

  tag_solution =
"Upgrade to Mozilla Firefox ESR version 17.0.10 or 24.1 or later,
For updates refer http://www.mozilla.org/en-US/firefox/organizations/all.html";


  script_tag(name : "summary" , value : tag_summary);
  script_tag(name : "vuldetect" , value : tag_vuldetect);
  script_tag(name : "solution" , value : tag_solution);
  script_tag(name : "insight" , value : tag_insight);
  script_tag(name : "affected" , value : tag_affected);
  script_tag(name : "impact" , value : tag_impact);
  script_tag(name:"qod_type", value:"registry");
  script_tag(name:"solution_type", value:"VendorFix");

  script_xref(name : "URL" , value : "http://secunia.com/advisories/55520");
  script_xref(name : "URL" , value : "http://www.mozilla.org/security/announce/2013/mfsa2013-96.html");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2013 Greenbone Networks GmbH");
  script_family("General");
  script_dependencies("gb_firefox_detect_win.nasl");
  script_mandatory_keys("Firefox-ESR/Win/Ver");
  exit(0);
}


include("host_details.inc");
include("version_func.inc");

## Variable Initialization
ffVer = "";

## Get version
if(!ffVer = get_app_version(cpe:CPE, nvt:SCRIPT_OID)){
  exit(0);
}

# Check for vulnerable version
if(ffVer && ffVer =~ "^(17\.0|24\.0)")
{
  if(version_in_range(version:ffVer, test_version:"17.0", test_version2:"17.0.9") ||
     version_in_range(version:ffVer, test_version:"24.0", test_version2:"24.0.2"))
  {
    security_message(0);
    exit(0);
  }
}
