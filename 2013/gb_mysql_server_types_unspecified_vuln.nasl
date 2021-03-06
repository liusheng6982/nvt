###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_mysql_server_types_unspecified_vuln.nasl 6104 2017-05-11 09:03:48Z teissa $
#
# MySQL Server Types Unspecified Vulnerability
#
# Authors:
# Thanga Prakash S <tprakash@secpod.com>
#
# Copyright:
# Copyright (c) 2013 Greenbone Networks GmbH, http://www.greenbone.net
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

tag_impact = "Successful exploitation could allow remote attackers to affect
  confidentiality, integrity, and availability via unknown vectors.
  Impact Level: Application";

tag_affected = "MySQL version 5.1.x before 5.1.64";
tag_insight = "Unspecified error in some unknown vectors related to Server Types.";
tag_solution = "Upgrade to MySQL version 5.1.64 or later,
  http://dev.mysql.com/downloads";
tag_summary = "The host is running MySQL and is prone to multiple unspecified
  vulnerability.";

SCRIPT_OID  = "1.3.6.1.4.1.25623.1.0.803481";
CPE = "cpe:/a:mysql:mysql";

if(description)
{
  script_oid(SCRIPT_OID);
  script_version("$Revision: 6104 $");
  script_cve_id("CVE-2013-1548");
  script_bugtraq_id(59223);
  script_tag(name:"last_modification", value:"$Date: 2017-05-11 11:03:48 +0200 (Thu, 11 May 2017) $");
  script_tag(name:"creation_date", value:"2013-04-22 18:01:05 +0530 (Mon, 22 Apr 2013)");
  script_tag(name:"cvss_base", value:"3.5");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:S/C:N/I:N/A:P");
  script_name("MySQL Server Types Unspecified Vulnerability");
  script_xref(name : "URL" , value : "http://secunia.com/advisories/53022");
  script_xref(name : "URL" , value : "http://www.oracle.com/technetwork/topics/security/cpuapr2013-1899555.html");
  script_xref(name : "URL" , value : "http://www.oracle.com/technetwork/topics/security/cpuapr2013-1899555.html#AppendixMSQL");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (c) 2013 Greenbone Networks GmbH");
  script_family("General");
  script_tag(name:"qod_type", value:"remote_banner_unreliable");
  script_dependencies("mysql_version.nasl");
  script_require_ports("Services/mysql", 3306);
  script_mandatory_keys("MySQL/installed");
  script_tag(name : "impact" , value : tag_impact);
  script_tag(name : "affected" , value : tag_affected);
  script_tag(name : "insight" , value : tag_insight);
  script_tag(name : "solution" , value : tag_solution);
  script_tag(name : "summary" , value : tag_summary);
  exit(0);
}

include("version_func.inc");
include("host_details.inc");

## Variable Initialization
sqlPort = "";
mysqlVer = "";

sqlPort = get_app_port(cpe:CPE, nvt:SCRIPT_OID);
if(!sqlPort){
  sqlPort = 3306;
}

if(!get_port_state(sqlPort)){
  exit(0);
}

mysqlVer = get_app_version(cpe:CPE, nvt:SCRIPT_OID, port:sqlPort);
if(mysqlVer && mysqlVer =~ "^(5\.1)")
{
  if(version_in_range(version:mysqlVer, test_version:"5.1", test_version2:"5.1.63"))
  {
    security_message(sqlPort);
    exit(0);
  }
}

