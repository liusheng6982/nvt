###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_mantisbt_xss_vuln02_sep15_lin.nasl 7546 2017-10-24 11:58:30Z cfischer $
#
# MantisBT Cross Site Scripting Vulnerability-02 September15 (Linux)
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

CPE = "cpe:/a:mantisbt:mantisbt";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.805976");
  script_version("$Revision: 7546 $");
  script_cve_id("CVE-2014-9272");
  script_bugtraq_id(71375);
  script_tag(name:"cvss_base", value:"4.3");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:N/I:P/A:N");
  script_tag(name:"last_modification", value:"$Date: 2017-10-24 13:58:30 +0200 (Tue, 24 Oct 2017) $");
  script_tag(name:"creation_date", value:"2015-09-08 18:15:16 +0530 (Tue, 08 Sep 2015)");
  script_tag(name:"qod_type", value:"remote_banner_unreliable");
  script_name("MantisBT Cross Site Scripting Vulnerability-02 September15 (Linux)");

  script_tag(name:"summary", value:"This host is running MantisBT and is prone
  to cross site scripting vulnerability.");

  script_tag(name:"vuldetect", value:"Get the installed version with the help
  of detect NVT and check the version is vulnerable or not.");

  script_tag(name:"insight", value:"The flaw exists as the function
  'string_insert_hrefs' doesn't validate the protocol in core/string_api.php
  script.");

  script_tag(name:"impact", value:"Successful exploitation will allow remote
  attackers to inject arbitrary web script or HTML via the
  'config_option' parameter.

  Impact Level: Application");

  script_tag(name:"affected", value:"MantisBT versions 1.2.0a1 through 1.2.x
  before 1.2.18");

  script_tag(name:"solution", value:"Upgrade to version 1.2.18 or later, For
  updates refer to http://www.mantisbt.org.");

  script_tag(name:"solution_type", value:"VendorFix");

  script_xref(name : "URL" , value : "http://seclists.org/oss-sec/2014/q4/902");
  script_xref(name : "URL" , value : "http://seclists.org/oss-sec/2014/q4/867");
  script_xref(name : "URL" , value : "https://www.mantisbt.org/bugs/view.php?id=17297");

  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2015 Greenbone Networks GmbH");
  script_family("Web application abuses");
  script_dependencies("mantis_detect.nasl", "os_detection.nasl");
  script_mandatory_keys("mantisbt/installed","Host/runs_unixoide");
  script_require_ports("Services/www", 80);
  exit(0);
}


include("host_details.inc");
include("version_func.inc");

## Variable Initialization
mantisPort = 0;
mantisVer = "";

## Get HTTP Port
if(!mantisPort = get_app_port(cpe:CPE)){
  exit(0);
}

## Get Version
if(!mantisVer = get_app_version(cpe:CPE, port:mantisPort)){
  exit(0);
}

##1.2.0a1 through 1.2.17== https://www.mantisbt.org/blog/?tag=release&paged=4
##Certain 1.1.x branch versions released after 1.2.0a1 are also vulnerable
if(version_in_range(version:mantisVer, test_version:"1.1.2", test_version2:"1.2.17"))
{
  report = 'Installed version: ' + mantisVer + '\n' +
           'Fixed version:     ' + "1.2.18" + '\n';
  security_message(data:report, port:mantisPort);
  exit(0);
}
