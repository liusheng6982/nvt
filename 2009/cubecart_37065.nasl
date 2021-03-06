###############################################################################
# OpenVAS Vulnerability Test
# $Id: cubecart_37065.nasl 9350 2018-04-06 07:03:33Z cfischer $
#
# CubeCart 'productId' SQL Injection Vulnerability
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

tag_summary = "CubeCart is prone to an SQL-injection vulnerability because it fails
to sufficiently sanitize user-supplied data before using it in an
SQL query.

Exploiting this issue could allow an attacker to compromise the
application, access or modify data, or exploit latent vulnerabilities
in the underlying database.

The issue affects CubeCart 4.3.6; prior versions may also be affected.";


tag_solution = "The vendor has released updates. Please see the references for
details.";

if (description)
{
 script_oid("1.3.6.1.4.1.25623.1.0.100360");
 script_version("$Revision: 9350 $");
 script_tag(name:"last_modification", value:"$Date: 2018-04-06 09:03:33 +0200 (Fri, 06 Apr 2018) $");
 script_tag(name:"creation_date", value:"2009-11-24 12:49:20 +0100 (Tue, 24 Nov 2009)");
 script_tag(name:"cvss_base", value:"7.5");
 script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:P/I:P/A:P");
 script_cve_id("CVE-2009-4060");
 script_bugtraq_id(37065);

 script_name("CubeCart 'productId' SQL Injection Vulnerability");

 script_xref(name : "URL" , value : "http://www.securityfocus.com/bid/37065");
 script_xref(name : "URL" , value : "http://forums.cubecart.com/index.php?showtopic=39900");

 script_category(ACT_GATHER_INFO);
  script_tag(name:"qod_type", value:"remote_banner");
 script_family("Web application abuses");
 script_copyright("This script is Copyright (C) 2009 Greenbone Networks GmbH");
 script_dependencies("secpod_cubecart_detect.nasl");
 script_require_ports("Services/www", 80);
 script_exclude_keys("Settings/disable_cgi_scanning");
 script_tag(name : "solution" , value : tag_solution);
 script_tag(name : "summary" , value : tag_summary);
 exit(0);
}

include("http_func.inc");
include("version_func.inc");

port = get_http_port(default:80);
if(!get_port_state(port))exit(0);


if(!version = get_kb_item(string("www/", port, "/cubecart")))exit(0);

if(!isnull(version)) {

  if(version_is_equal(version: version, test_version: "4.3.6")) {
      security_message(port:port);
      exit(0);
  }

}

exit(0);
