###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_vmware_serv_dir_trav_vuln_nov09_lin.nasl 9350 2018-04-06 07:03:33Z cfischer $
#
# VMware Server Directory Traversal Vulnerability - Nov09 (Linux)
#
# Authors:
# Sharath S <sharaths@secpod.com>
#
# Copyright:
# Copyright (c) 2009 Greenbone Networks GmbH, http://www.greenbone.net
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

tag_impact = "Successful exploitation will let the remote/local attacker to disclose
  sensitive information.
  Impact Level: System";
tag_affected = "VMware Server version 2.0.x prior to 2.0.2 Build 203138,
  VMware Server version 1.0.x prior to 1.0.10 Build 203137 on Linux.";
tag_insight = "An error exists while handling certain requests can be exploited to download
  arbitrary files from the host system via directory traversal attacks.";
tag_solution = "Upgrade your VMWares according to the below link,
  http://www.vmware.com/security/advisories/VMSA-2009-0015.html";
tag_summary = "The host is installed with VMWare product(s) and is prone to multiple
  vulnerability.";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.801144");
  script_version("$Revision: 9350 $");
  script_tag(name:"last_modification", value:"$Date: 2018-04-06 09:03:33 +0200 (Fri, 06 Apr 2018) $");
  script_tag(name:"creation_date", value:"2009-11-05 12:25:48 +0100 (Thu, 05 Nov 2009)");
  script_tag(name:"cvss_base", value:"5.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:P/I:N/A:N");
  script_cve_id("CVE-2009-3733");
  script_bugtraq_id(36842);
  script_name("VMware Serve Directory Traversal Vulnerability - Nov09 (Linux)");
  script_xref(name : "URL" , value : "http://secunia.com/advisories/37186");
  script_xref(name : "URL" , value : "http://www.vupen.com/english/advisories/2009/3062");
  script_xref(name : "URL" , value : "http://securitytracker.com/alerts/2009/Oct/1023088.html");
  script_xref(name : "URL" , value : "http://lists.vmware.com/pipermail/security-announce/2009/000069.html");

  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2009 Greenbone Networks GmbH");
  script_family("General");
  script_dependencies("gb_vmware_prdts_detect_lin.nasl");
  script_mandatory_keys("VMware/Linux/Installed", "VMware/Server/Linux/Ver");
  script_tag(name : "impact" , value : tag_impact);
  script_tag(name : "affected" , value : tag_affected);
  script_tag(name : "insight" , value : tag_insight);
  script_tag(name : "solution" , value : tag_solution);
  script_tag(name : "summary" , value : tag_summary);
  script_tag(name:"qod_type", value:"executable_version");
  script_tag(name:"solution_type", value:"VendorFix");
  exit(0);
}


include("version_func.inc");

if(!get_kb_item("VMware/Linux/Installed")){
  exit(0);
}

# Check for VMware Server
vmserverVer = get_kb_item("VMware/Server/Linux/Ver");
if(vmserverVer)
{
  # Check for version 1.0 < 1.0.10 (1.0.10 Build 203137) or 2.0 < 2.0.2 (2.0.2 Build 203138)
  if(version_in_range(version:vmserverVer, test_version:"1.0",
                                          test_version2:"1.0.9")||
     version_in_range(version:vmserverVer, test_version:"2.0",
                                          test_version2:"2.0.1")){
    security_message(0);
  }
}
