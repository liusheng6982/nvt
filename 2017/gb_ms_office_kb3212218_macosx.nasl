###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_ms_office_kb3212218_macosx.nasl 6012 2017-04-24 04:58:27Z teissa $
#
# Microsoft Office Spoofing Vulnerability-KB3212218 (Mac OS X)
#
# Authors:
# Antu Sanadi <santu@secpod.com>
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

CPE = "cpe:/a:microsoft:office";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.810743");
  script_version("$Revision: 6012 $");
  script_cve_id("CVE-2017-0207");
  script_bugtraq_id(97463);
  script_tag(name:"cvss_base", value:"4.3");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:N/I:P/A:N");
  script_tag(name:"last_modification", value:"$Date: 2017-04-24 06:58:27 +0200 (Mon, 24 Apr 2017) $");
  script_tag(name:"creation_date", value:"2017-04-12 15:10:09 +0530 (Wed, 12 Apr 2017)");
  script_tag(name:"qod_type", value:"executable_version");
  script_name("Microsoft Office Spoofing Vulnerability-KB3212218 (Mac OS X)");

  script_tag(name:"summary", value:"This host is missing a moderate security
  update according to Microsoft security update KB3212218");

  script_tag(name:"vuldetect", value:"Get the vulnerable file version and check
  appropriate patch is applied or not.");

  script_tag(name:"insight", value:"A spoofing vulnerability exists when
  Microsoft Outlook for Mac improperly validates HTML tag input.");

  script_tag(name:"impact", value:"Successful exploitation will allow remote
  attackers to gain access to the user's authentication information or login
  credentials.

  Impact Level: System/Application");

  script_tag(name:"affected", value:"Microsoft Office 2011 on Mac OS X");

  script_tag(name:"solution", value:"Apply the patch from below link,
  https://support.microsoft.com/en-us/help/3212218 ");

  script_tag(name:"solution_type", value:"VendorFix");
  script_xref(name : "URL" , value : "https://support.microsoft.com/en-us/help/3212218");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2017 Greenbone Networks GmbH");
  script_family("Mac OS X Local Security Checks");
  script_dependencies("gb_microsoft_office_detect_macosx.nasl");
  script_mandatory_keys("MS/Office/MacOSX/Ver");
  exit(0);
}


include("version_func.inc");

## Variable Initialization
offVer = "";

## Get the version from KB
if(!offVer = get_kb_item("MS/Office/MacOSX/Ver")){
  exit(0);
}

## check the version
if(!(offVer =~ "^(14\.)")){
  exit(0);
}

## Check for Office Version (14.7.3)
if(offVer =~ "^(14\.)" && version_is_less(version:offVer, test_version:"14.7.3"))
{ 
  report = 'File version:     ' + offVer   + '\n' +
           'Vulnerable range: 14.0 - 14.7.2 ' + '\n' ;
  security_message(data:report);
}
