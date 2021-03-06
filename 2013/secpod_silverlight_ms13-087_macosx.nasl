###############################################################################
# OpenVAS Vulnerability Test
# $Id: secpod_silverlight_ms13-087_macosx.nasl 6125 2017-05-15 09:03:42Z teissa $
#
# Microsoft Silverlight Information Disclosure Vulnerability-2890788 (Mac OS X)
#
# Authors:
# Veerendra GG <veerendragg@secpod.com>
#
# Copyright:
# Copyright (c) 2013 SecPod, http://www.secpod.com
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

CPE = "cpe:/a:microsoft:silverlight";
SCRIPT_OID  = "1.3.6.1.4.1.25623.1.0.901224";

if(description)
{
  script_oid(SCRIPT_OID);
  script_version("$Revision: 6125 $");
  script_cve_id("CVE-2013-3896");
  script_bugtraq_id(62793);
  script_tag(name:"cvss_base", value:"4.3");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:P/I:N/A:N");
  script_tag(name:"last_modification", value:"$Date: 2017-05-15 11:03:42 +0200 (Mon, 15 May 2017) $");
  script_tag(name:"creation_date", value:"2013-10-09 12:56:06 +0530 (Wed, 09 Oct 2013)");
  script_name("Microsoft Silverlight Information Disclosure Vulnerability-2890788 (Mac OS X)");

  tag_summary =
"This host is missing an important security update according to
Microsoft Bulletin MS13-087.";

  tag_vuldetect =
"Get the installed version with the help of detect NVT and check the version
is vulnerable or not.";

  tag_insight =
"Flaw is caused when Silverlight improperly handles certain objects in
memory.";

  tag_impact =
"Successful exploitation will allow remote attackers to obtain potentially
sensitive information.

Impact Level: Application";

  tag_affected =
"Microsoft Silverlight version 5 on Mac OS X";

  tag_solution =
"Download and update mentioned hotfixes in the advisory from the below link,
https://technet.microsoft.com/en-us/security/bulletin/ms13-087";


  script_tag(name : "summary" , value : tag_summary);
  script_tag(name : "vuldetect" , value : tag_vuldetect);
  script_tag(name : "solution" , value : tag_solution);
  script_tag(name : "insight" , value : tag_insight);
  script_tag(name : "affected" , value : tag_affected);
  script_tag(name : "impact" , value : tag_impact);
  script_tag(name:"qod_type", value:"package");
  script_tag(name:"solution_type", value:"VendorFix");

  script_xref(name : "URL" , value : "http://secunia.com/advisories/55149");
  script_xref(name : "URL" , value : "http://support.microsoft.com/kb/2890788");
  script_xref(name : "URL" , value : "http://technet.microsoft.com/en-us/security/bulletin/ms13-052");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2013 SecPod");
  script_family("Mac OS X Local Security Checks");
  script_dependencies("gb_ms_silverlight_detect_macosx.nasl");
  script_mandatory_keys("MS/Silverlight/MacOSX/Ver");
  exit(0);
}


include("host_details.inc");
include("version_func.inc");

## Variable Initialization
msl_ver = "";

## Get the version
if(!msl_ver = get_app_version(cpe:CPE, nvt:SCRIPT_OID)){
  exit(0);
}

## Check is Silverlight version is 5
if(msl_ver=~ "^5\.")
{
  ## Check for Silverlight version
  if(version_in_range(version:msl_ver, test_version:"5.0", test_version2:"5.1.20912.0"))
  {
    security_message(0);
    exit(0);
  }
}
