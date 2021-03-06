###############################################################################
# OpenVAS Vulnerability Test
# $Id: sw_vaadin_xss_vuln4.nasl 6431 2017-06-26 09:59:24Z teissa $
#
# Vaadin Framework Portlet Error Messages Cross-Site Scripting Vulnerability
#
# Authors:
# Christian Fischer <info@schutzwerk.com>
#
# Copyright:
# Copyright (c) 2015 SCHUTZWERK GmbH
# Text descriptions are largely excerpted from the referenced
# advisory, and are Copyright (c) the respective author(s)
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

CPE = 'cpe:/a:vaadin:vaadin';

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.105185");
  script_version("$Revision: 6431 $");
  script_tag(name:"last_modification", value:"$Date: 2017-06-26 11:59:24 +0200 (Mon, 26 Jun 2017) $");
  script_tag(name:"creation_date", value:"2015-01-22 12:00:00 +0100 (Thu, 22 Jan 2015)");
  script_tag(name:"cvss_base", value:"4.3");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:N/I:P/A:N");

  script_name("Vaadin Framework Portlet Error Messages Cross-Site Scripting Vulnerability");

  script_category(ACT_GATHER_INFO);
  script_copyright("This script is Copyright (C) 2015 SCHUTZWERK GmbH");
  script_family("Web application abuses");
  script_dependencies("sw_vaadin_detect.nasl");
  script_require_ports("Services/www", 8888);
  script_mandatory_keys("vaadin/installed");

  script_tag(name : "summary" , value : "This web application is running with the Vaadin Framework which
  is prone to cross-site scripting because the application fails to properly sanitize user-supplied input.");
  script_tag(name : "vuldetect" , value : "Check the version.");
  script_tag(name : "insight" , value : "This flaw exists due to proper escaping of HTML in portlet error
  message was not ensured.");
  script_tag(name : "impact" , value : "This could allow a reflected cross-site scripting attack through
  VaadinPortlet by making the user load a URL designed to include an error message crafted by the attacker.");
  script_tag(name : "affected" , value : "Vaadin Framework versions from 7.0.0 up to 7.3.6");
  script_tag(name : "solution" , value : "Upgrade to Vaadin Framework version 7.3.7 or later
  For updates refer to http://www.vaadin.com/releases");

  script_xref(name:"URL", value:"http://www.vaadin.com/download/release/7.3/7.3.7/release-notes.html");

  script_tag(name:"solution_type", value:"VendorFix");

  script_tag(name:"qod_type", value:"remote_banner_unreliable");

  exit(0);
}

include("version_func.inc");
include("host_details.inc");

if( ! port = get_app_port( cpe:CPE ) ) exit( 0 );
if( ! vers = get_app_version( cpe:CPE, port:port ) ) exit( 0 );

if( version_in_range( version:vers, test_version:"7.0.0", test_version2:"7.3.6" ) ) {

  report = 'Installed version: ' + vers + '\n' +
           'Fixed version:     ' + "7.3.7" + '\n';
  security_message( port:port, data:report );
  exit( 0 );
}

exit( 99 );
