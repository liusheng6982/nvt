###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_ms_visio_ms15-081.nasl 5338 2017-02-18 16:20:24Z cfi $
#
# Microsoft Visio Multiple Remote Code Execution Vulnerabilities (3080790)
#
# Authors:
# Antu Sanadi <santu@secpod.com>
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

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.805092");
  script_version("$Revision: 5338 $");
  script_cve_id("CVE-2015-2423");
  script_tag(name:"cvss_base", value:"4.3");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:P/I:N/A:N");
  script_tag(name:"last_modification", value:"$Date: 2017-02-18 17:20:24 +0100 (Sat, 18 Feb 2017) $");
  script_tag(name:"creation_date", value:"2015-08-12 16:44:01 +0530 (Wed, 12 Aug 2015)");
  script_tag(name:"qod_type", value:"executable_version");
  script_name("Microsoft Visio Multiple Remote Code Execution Vulnerabilities (3080790)");

  script_tag(name:"summary", value:"This host is missing an important security
  update according to Microsoft Bulletin MS15-081.");

  script_tag(name:"vuldetect", value:"Get the vulnerable file version and check
  appropriate patch is applied or not.");

  script_tag(name:"insight", value:"Flaws are due to improper handling of files
  in the memory.");

  script_tag(name:"impact", value:"Successful exploitation will allow remote
  attackers to run arbitrary code in the context of the current user and
  to perform actions in the security context of the current user.

  Impact Level: System/Application");

  script_tag(name:"affected", value:"
  Microsoft Visio 2007
  Microsoft Visio 2010
  Microsoft Visio 2013");

  script_tag(name:"solution", value:"Run Windows Update and update the listed
  hotfixes or download and update mentioned hotfixes in the advisory from the
  below link, https://technet.microsoft.com/en-us/security/bulletin/ms15-081");

  script_tag(name:"solution_type", value:"VendorFix");

  script_xref(name : "URL" , value : "https://support.microsoft.com/en-us/kb/2965280");
  script_xref(name : "URL" , value : "https://support.microsoft.com/en-us/kb/3054876");
  script_xref(name : "URL" , value : "https://support.microsoft.com/en-us/kb/3054929");
  script_xref(name : "URL" , value : "https://technet.microsoft.com/en-us/library/security/MS15-081");

  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2015 Greenbone Networks GmbH");
  script_family("Windows : Microsoft Bulletins");
  script_dependencies("secpod_reg_enum.nasl");
  script_require_ports(139, 445);
  script_mandatory_keys("SMB/WindowsVersion");

  exit(0);
}


include("smb_nt.inc");
include("version_func.inc");
include("secpod_smb_func.inc");

## Variable Initialization
sysPath = "";
exeVer = "";

## Check for Office Visio
sysPath = registry_get_sz(key:"SOFTWARE\Microsoft\Windows\CurrentVersion" +
                             "\App Paths\visio.exe", item:"Path");
if(!sysPath){
  exit(0);
}

## Get file version
exeVer = fetch_file_version(sysPath, file_name:"visio.exe");
if(exeVer && exeVer =~ "^(12|14|15)\..*")
{
  # Check for visio.exe version for 2007, 2010 and 2013
   if(version_in_range(version:exeVer, test_version:"12.0", test_version2:"12.0.6727.4999") ||
      version_in_range(version:exeVer, test_version:"14.0", test_version2:"14.0.7155.4999") ||
      version_in_range(version:exeVer, test_version:"15.0", test_version2:"15.0.4745.999"))
  {
    security_message(0);
    exit(0);
  }
}
