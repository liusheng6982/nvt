###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_phorum_xss_vuln.nasl 9351 2018-04-06 07:05:43Z cfischer $
#
# Phorum 'real_name' Parameter Cross-Site Scripting Vulnerability
#
# Authors:
# Madhuri D <dmadhuri@secpod.com>
#
# Copyright:
# Copyright (c) 2011 Greenbone Networks GmbH, http://www.greenbone.net
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

tag_impact = "Successful exploitation will allow attacker to execute arbitrary HTML and
  script code in a user's browser session in the context of an affected site.
  Impact Level: Application";
tag_affected = "Phorum version prior to 5.2.17";
tag_insight = "The flaw is due to input passed via the 'real_name' parameter to the
  'control.php' script is not properly sanitised before being returned to the
  user.";
tag_solution = "Upgrade Phorum to 5.2.17 or later,
  For updates refer to http://www.phorum.org/downloads.php";
tag_summary = "This host is running Phorum and is prone to cross-site scripting
  vulnerability.";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.802161");
  script_version("$Revision: 9351 $");
  script_tag(name:"last_modification", value:"$Date: 2018-04-06 09:05:43 +0200 (Fri, 06 Apr 2018) $");
  script_tag(name:"creation_date", value:"2011-09-16 17:22:17 +0200 (Fri, 16 Sep 2011)");
  script_cve_id("CVE-2011-3392");
  script_bugtraq_id(49347);
  script_tag(name:"cvss_base", value:"4.3");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:N/I:P/A:N");
  script_name("Phorum 'real_name' Parameter Cross-Site Scripting Vulnerability");
  script_xref(name : "URL" , value : "http://secunia.com/advisories/45787");
  script_xref(name : "URL" , value : "http://xforce.iss.net/xforce/xfdb/69456");
  script_xref(name : "URL" , value : "http://holisticinfosec.org/content/view/184/45/");

  script_tag(name:"qod_type", value:"remote_banner");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (c) 2011 Greenbone Networks GmbH");
  script_family("Web application abuses");
  script_dependencies("phorum_detect.nasl");
  script_require_ports("Services/www", 80);
  script_tag(name : "impact" , value : tag_impact);
  script_tag(name : "affected" , value : tag_affected);
  script_tag(name : "insight" , value : tag_insight);
  script_tag(name : "solution" , value : tag_solution);
  script_tag(name : "summary" , value : tag_summary);
  exit(0);
}


include("http_func.inc");
include("version_func.inc");

## Get HTTP Port
phorumPort = get_http_port(default:80);
if(!phorumPort){
  exit(0);
}

## Get version from kb
phorumVer =  get_version_from_kb(port:phorumPort,app:"phorum");
if(!phorumVer){
  exit(0);
}

# Check for Phorum Version < 5.2.17
if(version_is_less(version:phorumVer, test_version:"5.2.17")){
  security_message(phorumPort);
}
