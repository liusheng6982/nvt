###############################################################################
# OpenVAS Vulnerability Test
# $Id: secpod_ms11-002.nasl 9351 2018-04-06 07:05:43Z cfischer $
#
# Microsoft Windows Data Access Components Remote Code Execution Vulnerabilities (2451910)
#
# Authors:
# Antu Sanadi <santu@secpod.com>
#
# Copyright:
# Copyright (c) 2011 SecPod, http://www.secpod.com
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

tag_impact = "Successful exploitation will allow the attacker to execute arbitrary code on
  the targeted system.

  Impact Level: System/Application";
tag_affected = "Microsoft Windows 7

  Microsoft Windows XP Service Pack 3 and prior.

  Microsoft Windows 2K3 Service Pack 2 and prior.

  Microsoft Windows Vista Service Pack 2 and prior.

  Microsoft Windows Server 2008 Service Pack 2 and prior.";
tag_insight = "The flaws are due to:

  - A buffer overflow error in the Data Source Name (DSN) argument of an Open
    Database Connectivity (ODBC) API that may be used by third-party applications,
    which could allow attackers to execute arbitrary code by convincing a user to
    visit a specially crafted web page.

  - A memory corruption error in the Microsoft Data Access Components (MDAC) when
    handling internal data structures, which could be exploited by remote attackers
    to execute arbitrary code via a specially crafted web page.";
tag_solution = "Run Windows Update and update the listed hotfixes or download and
  update mentioned hotfixes in the advisory from the below link,

  http://www.microsoft.com/technet/security/Bulletin/MS11-002.mspx";
tag_summary = "This host is missing a critical security update according to
  Microsoft Bulletin MS11-002.";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.902281");
  script_version("$Revision: 9351 $");
  script_tag(name:"last_modification", value:"$Date: 2018-04-06 09:05:43 +0200 (Fri, 06 Apr 2018) $");
  script_tag(name:"creation_date", value:"2011-01-12 13:59:47 +0100 (Wed, 12 Jan 2011)");
  script_cve_id("CVE-2011-0026", "CVE-2011-0027");
  script_bugtraq_id(45698, 45695);
  script_tag(name:"cvss_base", value:"9.3");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:C/I:C/A:C");
  script_name("Microsoft Windows Data Access Components Remote Code Execution Vulnerabilities (2451910)");

  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2011 SecPod");
  script_family("Windows : Microsoft Bulletins");
  script_dependencies("secpod_reg_enum.nasl");
  script_require_ports(139, 445);
  script_mandatory_keys("SMB/WindowsVersion");

  script_tag(name : "impact" , value : tag_impact);
  script_tag(name : "affected" , value : tag_affected);
  script_tag(name : "insight" , value : tag_insight);
  script_tag(name : "solution" , value : tag_solution);
  script_tag(name : "summary" , value : tag_summary);
  script_tag(name:"qod_type", value:"registry");
  script_tag(name:"solution_type", value:"VendorFix");
  script_xref(name : "URL" , value : "http://support.microsoft.com/kb/2419632");
  script_xref(name : "URL" , value : "http://support.microsoft.com/kb/2419635");
  script_xref(name : "URL" , value : "http://support.microsoft.com/kb/2419640");
  script_xref(name : "URL" , value : "http://www.vupen.com/english/advisories/2011/0075");
  exit(0);
}


include("smb_nt.inc");
include("secpod_reg.inc");
include("version_func.inc");
include("secpod_smb_func.inc");

## Check for OS and Service Pack
if(hotfix_check_sp(xp:4, win2003:3, winVista:3, win2008:3, win7:1) <= 0){
  exit(0);
}

## MS11-002 Hotfix 2419635 2419640 2419632
if((hotfix_missing(name:"2419635") == 0) || (hotfix_missing(name:"2419640") == 0) ||
  (hotfix_missing(name:"2419632") == 0)){
  exit(0);
}

## Get Program Files Dir Path and construct complete path
sysPath =registry_get_sz(key:"SOFTWARE\Microsoft\Windows\CurrentVersion\",
                           item:"ProgramFilesDir");
if(!sysPath ){
  exit(0);
}

dllPath = sysPath + "\Common Files\System\msadc";
share = ereg_replace(pattern:"([a-zA-Z]):.*", replace:"\1$", string:dllPath);
file =  ereg_replace(pattern:"[a-zA-Z]:(.*)", replace:"\1",
                     string:dllPath + "\Msadco.dll");

## Get Version from Msadco.dll file
dllVer = GetVer(file:file, share:share);
if(!dllVer){
  exit(0);
}

## Windows XP
if(hotfix_check_sp(xp:4) > 0)
{
  SP = get_kb_item("SMB/WinXP/ServicePack");
  if("Service Pack 3" >< SP)
  {
    ## Check for Msadco.dll version
    if(version_is_less(version:dllVer, test_version:"2.81.3012.0")){
      security_message(0);
    }
    exit(0);
  }
  security_message(0);
}

## Windows 2003
else if(hotfix_check_sp(win2003:3) > 0)
{
  SP = get_kb_item("SMB/Win2003/ServicePack");
  if("Service Pack 2" >< SP)
  {
    ## Check for Msadco.dll version
    if(version_is_less(version:dllVer, test_version:"2.82.4795.0")){
      security_message(0);
    }
    exit(0);
  }
  security_message(0);
}

## Windows Vista and Windows Server 2008
else if(hotfix_check_sp(winVista:3, win2008:3) > 0)
{
  SP = get_kb_item("SMB/WinVista/ServicePack");

  if(!SP) {
    SP = get_kb_item("SMB/Win2008/ServicePack");
  }

  if("Service Pack 1" >< SP)
  {
    ## Check for Msadco.dll version
    if(version_is_less(version:dllVer, test_version:"6.0.6001.18570")){
      security_message(0);
    }
    exit(0);
  }

  if("Service Pack 2" >< SP)
  {
    ## Check for Msadco.dll version
    if(version_is_less(version:dllVer, test_version:"6.0.6002.18362")){
      security_message(0);
    }
    exit(0);
  }
  security_message(0);
}

## Windows 7
else if(hotfix_check_sp(win7:1) > 0)
{
  ## Check for Msadco.dll version
  if(version_is_less(version:dllVer, test_version:"6.1.7600.16688")){
    security_message(0);
  }
}
