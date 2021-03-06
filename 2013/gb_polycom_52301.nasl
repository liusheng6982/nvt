###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_polycom_52301.nasl 7765 2017-11-15 06:34:32Z cfischer $
#
# Polycom Products Directory Traversal and Command Injection Vulnerabilities
#
# Authors:
# Michael Meyer <michael.meyer@greenbone.net>
#
# Copyright:
# Copyright (c) 2013 Greenbone Networks GmbH
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

tag_summary = "Multiple Polycom products are prone to a directory-traversal
vulnerability and a command-injection vulnerability because it fails
to sufficiently sanitize user-supplied input.

Remote attackers can use a specially crafted request with directory-
traversal sequences ('../') to retrieve arbitrary files in the context
of the application. Also, attackers can execute arbitrary commands
with the privileges of the user running the application.";


tag_solution = "Updates are available. Please see the references for more information.";

SCRIPT_OID  = "1.3.6.1.4.1.25623.1.0.103661";
CPE = "";

if (description)
{
 script_oid(SCRIPT_OID);
 script_bugtraq_id(52301);
 script_tag(name:"cvss_base", value:"9.0");
 script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:C/I:P/A:P");
 script_version ("$Revision: 7765 $");

 script_name("Polycom Products Directory Traversal and Command Injection Vulnerabilities");

 script_xref(name : "URL" , value : "http://www.securityfocus.com/bid/52301");
 script_xref(name : "URL" , value : "http://seclists.org/fulldisclosure/2012/Mar/18");
 script_xref(name : "URL" , value : "http://blog.tempest.com.br/joao-paulo-campello/path-traversal-on-polycom-web-management-interface.html");
 script_xref(name : "URL" , value : "http://www.polycom.com/");
 script_xref(name : "URL" , value : "http://blog.tempest.com.br/joao-paulo-campello/polycom-web-management-interface-os-command-injection.html");

 script_tag(name:"last_modification", value:"$Date: 2017-11-15 07:34:32 +0100 (Wed, 15 Nov 2017) $");
 script_tag(name:"creation_date", value:"2013-02-13 11:31:54 +0100 (Wed, 13 Feb 2013)");
 script_category(ACT_ATTACK);
  script_tag(name:"qod_type", value:"remote_vul");
 script_family("Web application abuses");
 script_copyright("This script is Copyright (C) 2013 Greenbone Networks GmbH");
 script_dependencies("find_service.nasl", "http_version.nasl");
 script_require_ports("Services/www", 80);
 script_exclude_keys("Settings/disable_cgi_scanning");
 script_tag(name : "solution" , value : tag_solution);
 script_tag(name : "summary" , value : tag_summary);
 exit(0);
}

include("http_func.inc");
include("http_keepalive.inc");
   
port = get_http_port(default:80);
if(!get_port_state(port))exit(0);


if(http_vuln_check(port:port, url:"/",pattern:"Polycom")) {

  url = '/a_getlog.cgi?name=../../../etc/passwd';

  if(http_vuln_check(port:port, url:url,pattern:"root:.*:0:[01]:")) {
     
    security_message(port:port);
    exit(0);

  }  

}

exit(0);

