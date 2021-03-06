###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_ms_office_compat_pack_ms16-004.nasl 5505 2017-03-07 10:00:18Z teissa $
#
# Microsoft Office Compatibility Pack Remote Code Execution Vulnerability (3124585)
#
# Authors:
# Antu Sanadi <santu@secpod.com>
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

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.806196");
  script_version("$Revision: 5505 $");
  script_cve_id("CVE-2016-0035");
  script_tag(name:"cvss_base", value:"9.3");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:C/I:C/A:C");
  script_tag(name:"last_modification", value:"$Date: 2017-03-07 11:00:18 +0100 (Tue, 07 Mar 2017) $");
  script_tag(name:"creation_date", value:"2016-01-13 13:01:50 +0530 (Wed, 13 Jan 2016)");
  script_tag(name:"qod_type", value:"executable_version");
  script_name("Microsoft Office Compatibility Pack Remote Code Execution Vulnerability (3124585)");

  script_tag(name:"summary", value:"This host is missing a critical security
  update according to Microsoft Bulletin MS16-004.");

  script_tag(name:"vuldetect", value:"Get the vulnerable file version and check
  appropriate patch is applied or not.");

  script_tag(name:"insight", value:"The flaw is due to improper loading of dynamic
  link library (DLL) files.");

  script_tag(name:"impact", value:"Successful exploitation will allow remote
  attackers to run arbitrary code and corrupt memory in the context of the
  current user.

  Impact Level: System/Application");

  script_tag(name:"affected", value:"
  Microsoft Office Compatibility Pack Service Pack 3 and prior.");

  script_tag(name:"solution", value:"Run Windows Update and update the listed
  hotfixes or download and update mentioned hotfixes in the advisory from the
  below link, https://technet.microsoft.com/en-us/security/bulletin/ms16-004");

  script_tag(name:"solution_type", value:"VendorFix");
  script_xref(name : "URL" , value : "https://support.microsoft.com/en-us/kb/3124585");
  script_xref(name : "URL" , value : "https://support.microsoft.com/en-us/kb/3114546");
  script_xref(name : "URL" , value : "https://technet.microsoft.com/en-us/library/security/MS16-004");

  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2016 Greenbone Networks GmbH");
  script_family("Windows : Microsoft Bulletins");
  script_dependencies("secpod_office_products_version_900032.nasl");
  script_mandatory_keys("SMB/Office/ComptPack/Version", "SMB/Office/XLCnv/Version", "SMB/Office/WordCnv/Version");
  exit(0);
}


include("smb_nt.inc");
include("version_func.inc");

## Variable Initialization
xlcnvVer = "";
wordcnvVer = "";
path = "";
sysVer = "";

## Check for Office Compatibility Pack 2007
if(get_kb_item("SMB/Office/ComptPack/Version") =~ "^12\..*")
{
  xlcnvVer = get_kb_item("SMB/Office/XLCnv/Version");
  if(xlcnvVer)
  {
    ## Check for Office Version 2007 with compatibility pack version 12.0 < 12.0.6742.5000
    ## took the file excelconv.exe which is updated after patch
    if(version_in_range(version:xlcnvVer, test_version:"12.0", test_version2:"12.0.6742.4999"))
    {
      report = 'File checked:     excelconv.exe' + '\n' +
               'File version:     ' + xlcnvVer  + '\n' +
               'Vulnerable range: 12.0 - 12.0.6742.4999' + '\n' ;
      security_message(data:report);
      exit(0);
    }
  }
}
