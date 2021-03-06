###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_oraclebi_discoverer_xss_vuln.nasl 7579 2017-10-26 11:10:22Z cfischer $
#
# OracleBI Discoverer 'node' Cross Site Scripting Vulnerability
#
# Authors:
# Antu Sanadi <santu@secpod.com>
#
# Copyright:
# Copyright (c) 2012 Greenbone Networks GmbH, http://www.greenbone.net
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

tag_impact = "Successful exploitation will allow remote attackers to insert
arbitrary HTML and script code, which will be executed in a user's browser
session in the context of an affected site.

Impact Level: Application";

tag_affected = "OracleBI Discoverer Version 10.1.2.48.18";

tag_insight = "The flaw is due to an improper validation of user supplied input
to the 'node' parameter in '/discoverer/app/explorer', which allows attackers
to execute arbitrary HTML and script code in a user's browser session in the
context of an affected site.";

tag_solution = "No solution or patch was made available for at least one year
since disclosure of this vulnerability. Likely none will be provided anymore.
General solution options are to upgrade to a newer release, disable respective
features, remove the product or replace the product by another one.";

tag_summary = "This host is installed with OracleBI Discoverer and is prone to
cross site scripting vulnerability.";

SCRIPT_OID  = "1.3.6.1.4.1.25623.1.0.803131";
CPE = "cpe:/a:oracle:oraclebi_discoverer";

if(description)
{
  script_oid(SCRIPT_OID);
  script_version("$Revision: 7579 $");
  script_tag(name:"cvss_base", value:"4.3");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:P/I:N/A:N");
  script_tag(name:"last_modification", value:"$Date: 2017-10-26 13:10:22 +0200 (Thu, 26 Oct 2017) $");
  script_tag(name:"creation_date", value:"2012-12-19 12:18:56 +0530 (Wed, 19 Dec 2012)");
  script_name("OracleBI Discoverer 'node' Cross Site Scripting Vulnerability");
  script_xref(name : "URL" , value : "http://ur0b0r0x.blogspot.com/");
  script_xref(name : "URL" , value : "http://packetstormsecurity.org/files/118808/oraclebi-xss.txt");

  script_tag(name:"qod_type", value:"remote_banner");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (c) 2012 Greenbone Networks GmbH");
  script_family("Web application abuses");
  script_dependencies("gb_oraclebi_discoverer_detect.nasl");
  script_require_keys("OracleBIDiscoverer/installed");
  script_require_ports("Services/www", 80);
  script_tag(name : "impact" , value : tag_impact);
  script_tag(name : "affected" , value : tag_affected);
  script_tag(name : "insight" , value : tag_insight);
  script_tag(name : "solution" , value : tag_solution);
  script_tag(name : "summary" , value : tag_summary);
  script_tag(name:"solution_type", value:"WillNotFix");
  exit(0);
}

include("host_details.inc");
include("version_func.inc");

## Variable Initialization
port = 0;
url = "";
dir = "";

## Get HTTP Port
if(!port = get_app_port(cpe:CPE, nvt:SCRIPT_OID)){
  exit(0);
}

if(vers = get_app_version(cpe:CPE, nvt:SCRIPT_OID, port:port))
{
  if(version_is_equal(version:vers, test_version:"10.1.2.48.18")){
    security_message(port);
  }
}
