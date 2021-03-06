###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_ms15-068.nasl 6513 2017-07-04 09:59:28Z teissa $
#
# MS Windows Hyper-V Remote Code Execution Vulnerability (3072000)
#
# Authors:
# Shakeel <bshakeel@secpod.com>
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
  script_oid("1.3.6.1.4.1.25623.1.0.805922");
  script_version("$Revision: 6513 $");
  script_cve_id("CVE-2015-2361", "CVE-2015-2362");
  script_tag(name:"cvss_base", value:"7.2");
  script_tag(name:"cvss_base_vector", value:"AV:L/AC:L/Au:N/C:C/I:C/A:C");
  script_tag(name:"last_modification", value:"$Date: 2017-07-04 11:59:28 +0200 (Tue, 04 Jul 2017) $");
  script_tag(name:"creation_date", value:"2015-07-15 13:50:29 +0530 (Wed, 15 Jul 2015)");
  script_name("MS Windows Hyper-V Remote Code Execution Vulnerability (3072000)");

  script_tag(name:"summary", value:"This host is missing a critical security
  update according to Microsoft Bulletin MS15-068.");

  script_tag(name:"vuldetect", value:"Get the vulnerable file version and
  check appropriate patch is applied or not.");

  script_tag(name:"insight", value:"Multiple flaws exists due to,
  - An error in how Hyper-V handles packet size memory initialization in guest
    virtual machines.
  - An error in how Hyper-V initializes system data structures in guest virtual
    machines.");

  script_tag(name:"impact", value:"Successful exploitation will allow remote
  attacker to execute arbitrary code on affected system.

  Impact Level: System");

  script_tag(name:"affected", value:"
  Microsoft Windows 8 x64
  Microsoft Windows 8.1 x64 Edition
  Microsoft Windows Server 2012/2012R2
  Microsoft Windows Server 2008 x64 Edition Service Pack 2
  Microsoft Windows Server 2008 R2 x64 Edition Service Pack 1");

  script_tag(name:"solution", value:"Run Windows Update and update the
  listed hotfixes or download and update mentioned hotfixes in the advisory
  from the below link,
  https://technet.microsoft.com/en-us/library/security/MS15-068");

  script_tag(name:"solution_type", value:"VendorFix");

  script_tag(name:"qod_type", value:"executable_version");

  script_xref(name : "URL" , value : "https://support.microsoft.com/en-us/kb/3046359");
  script_xref(name : "URL" , value : "https://support.microsoft.com/en-us/kb/3046339");
  script_xref(name : "URL" , value : "https://technet.microsoft.com/en-us/library/security/MS15-068");

  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2015 Greenbone Networks GmbH");
  script_family("Windows : Microsoft Bulletins");
  script_dependencies("secpod_reg_enum.nasl");
  script_mandatory_keys("SMB/WindowsVersion");
  exit(0);
}


include("smb_nt.inc");
include("secpod_reg.inc");
include("version_func.inc");
include("secpod_smb_func.inc");

## Variables Initialization
sysPath = "";
dllVer = "";

## Check for OS and Service Pack
if(hotfix_check_sp(win2008r2:2, win8x64:1, win2012:1, win2012R2:1,
                   win8_1x64:1) <= 0){
  exit(0);
}

## Get System Path
sysPath = smb_get_systemroot();
if(!sysPath ){
  exit(0);
}

## Fetch the version of 'Vmicvss.dll' and 'Storvsp.sys' files
dllVer = fetch_file_version(sysPath, file_name:"System32\Vmicvss.dll");
dllVer2 = fetch_file_version(sysPath, file_name:"System32\drivers\Storvsp.sys");
if(!dllVer && !dllVer2){
  exit(0);
}

##Windows 2008 R2
if(hotfix_check_sp(win2008r2:2) > 0 && dllVer)
{
  ## Check for 'Vmicvss.dll' file version
  if(version_is_less(version:dllVer, test_version:"6.1.7601.18844") ||
     version_in_range(version:dllVer, test_version:"6.1.7601.22000", test_version2:"6.1.7601.23044")){
    security_message(0);
  }
  exit(0);
}

## Windows 8 and Windows Server 2012
if(hotfix_check_sp(win8x64:1, win2012:1) > 0 && dllVer)
{
  ## Check for Vmicvss.dll
  if(version_is_less(version:dllVer, test_version:"6.2.9200.17361") ||
     version_in_range(version:dllVer, test_version:"6.2.9200.20000", test_version2:"6.2.9200.21472")){
    security_message(0);
  }
  exit(0);
}

## Win 8.1 and win2012R2
if(hotfix_check_sp(win8_1x64:1, win2012R2:1) > 0)
{
  ## Check for Vmicvss.dll file version
  if((dllVer && version_is_less(version:dllVer, test_version:"6.3.9600.17723"))||
     (dllVer2 && version_is_less(version:dllVer2, test_version:"6.3.9600.17723"))){
    security_message(0);
  }
  exit(0);
}
