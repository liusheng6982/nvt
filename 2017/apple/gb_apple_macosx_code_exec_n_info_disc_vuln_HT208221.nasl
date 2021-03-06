###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_apple_macosx_code_exec_n_info_disc_vuln_HT208221.nasl 7734 2017-11-10 11:35:05Z santu $
#
# Apple MacOSX Code Execution And Information Disclosure Vulnerabilities-HT208221
#
# Authors:
# Kashinath T <tkashinath@secpod.com>
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

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.811962");
  script_version("$Revision: 7734 $");
  script_cve_id("CVE-2017-13786", "CVE-2017-13800");
  script_tag(name:"cvss_base", value:"9.3");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:C/I:C/A:C");
  script_tag(name:"last_modification", value:"$Date: 2017-11-10 12:35:05 +0100 (Fri, 10 Nov 2017) $");
  script_tag(name:"creation_date", value:"2017-11-02 12:06:10 +0530 (Thu, 02 Nov 2017)");
  script_name("Apple MacOSX Code Execution And Information Disclosure Vulnerabilities-HT208221");

  script_tag(name: "summary" , value:"This host is running Apple Mac OS X and
  is prone to code execution and information disclosure vulnerabilities.");

  script_tag(name: "vuldetect" , value:"Get the installed version with the help
  of detect NVT and check the version is vulnerable or not.");

  script_tag(name: "insight" , value:"Multiple flaws exists due to,

  - An issue existed in the handling of DMA.

  - A memory corruption issue.");

  script_tag(name: "impact" , value:"Successful exploitation will allow attacker
  to execute arbitrary code with system privileges and also can recover unencrypted
  APFS file system data.

  Impact Level: System");

  script_tag(name: "affected" , value:"Apple Mac OS X version 10.13");

  script_tag(name: "solution" , value:"Upgrade to Apple Mac OS X version
  10.13.1 or later. For updates refer to, https://www.apple.com");

  script_tag(name:"solution_type", value:"VendorFix");
  script_tag(name:"qod_type", value:"package");
  script_xref(name : "URL" , value : "https://support.apple.com/en-us/HT208221");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2017 Greenbone Networks GmbH");
  script_family("Mac OS X Local Security Checks");
  script_dependencies("gather-package-list.nasl");
  script_mandatory_keys("ssh/login/osx_name", "ssh/login/osx_version");
  exit(0);
}


include("version_func.inc");

osName = "";
osVer = "";

osName = get_kb_item("ssh/login/osx_name");
if(!osName){
  exit (0);
}

osVer = get_kb_item("ssh/login/osx_version");
if(!osVer){
  exit(0);
}

if("Mac OS X" >< osName && osVer == "10.13")
{
  report = report_fixed_ver(installed_version:osVer, fixed_version:"10.13.1");
  security_message(data:report);
  exit(0);
}
