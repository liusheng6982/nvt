###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_simatic_s7_1200_mult_dos_vuln.nasl 6086 2017-05-09 09:03:30Z teissa $
#
# Siemens SIMATIC S7-1200 Multiple Denial of Service Vulnerabilities
#
# Authors:
# Arun Kallavi <karun@secpod.com>
#
# Copyright:
# Copyright (c) 2013 Greenbone Networks GmbH, http://www.greenbone.net
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
###############################################################################

CPE = "cpe:/a:siemens:simatic_s7_1200";

tag_impact = "Successful exploitation will allow attackers to cause denial
of service via specially-crafted packets to TCP port 102 or UCP port 161.

Impact Level: Application";

tag_summary = "This host is installed with Siemens SIMATIC S7-1200 and is
prone to multiple denial of service vulnerabilities.";

tag_solution = "Upgrade to SIMATIC S7-1200 V4.0.0 or later,
http://support.automation.siemens.com/WW/view/en/86567043 ";

tag_insight = "Multiple flaws allows device management over TCP and UDP ports.";
tag_affected = "Siemens SIMATIC S7-1200 2.x and 3.x";

if (description)
{
  script_tag(name : "impact" , value : tag_impact);
  script_tag(name : "affected" , value : tag_affected);
  script_tag(name : "insight" , value : tag_insight);
  script_tag(name : "solution" , value : tag_solution);
  script_tag(name : "summary" , value : tag_summary);
  script_oid("1.3.6.1.4.1.25623.1.0.803387");
  script_version ("$Revision: 6086 $");
  script_cve_id("CVE-2013-0700","CVE-2013-2780");
  script_bugtraq_id(59399,57023);
  script_tag(name:"cvss_base", value:"7.8");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:N/I:N/A:C");
  script_tag(name:"last_modification", value:"$Date: 2017-05-09 11:03:30 +0200 (Tue, 09 May 2017) $");
  script_tag(name:"creation_date", value:"2013-04-25 16:01:27 +0530 (Thu, 25 Apr 2013)");
  script_name("Siemens SIMATIC S7-1200 Multiple Denial of Service Vulnerabilities");
  script_xref(name : "URL" , value : "http://cxsecurity.com/cveshow/CVE-2013-0700");
  script_xref(name : "URL" , value : "http://cxsecurity.com/cveshow/CVE-2013-2780");
  script_xref(name : "URL" , value : "http://www.siemens.com/corporate-technology/pool/de/forschungsfelder/siemens_security_advisory_ssa-724606.pdf");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2013 Greenbone Networks GmbH");
  script_family("General");
  script_dependencies("gb_simatic_s7_version.nasl");
  script_mandatory_keys("simatic_s7/detected");

  script_tag(name:"qod_type", value:"remote_banner");
  script_tag(name: "solution_type", value: "VendorFix");
  exit(0);
}

include("host_details.inc");

## Variable Initialization
port = 0;
version = "";

## Get port
if(!port = get_app_port(cpe:CPE)){
  exit(0);
}

## Check port status
if(!get_port_state(port)){
  exit(0);
}

## Get version
if(!version = get_app_version(cpe:CPE, port:port)){
  exit(0);
}

## Check for version 2.x or 3.x
if(version =~ "^(2\.|3\.)")
{
  security_message(port:port);
  exit(0);
}
