###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_mitel_enterprise_manager_detect.nasl 7076 2017-09-07 11:53:47Z teissa $
#
# Mitel Enterprise Manager Detection
#
# Authors:
# Michael Meyer <michael.meyer@greenbone.net>
#
# Copyright:
# Copyright (c) 2016 Greenbone Networks GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version
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

if (description)
{
 script_oid("1.3.6.1.4.1.25623.1.0.105857");
 script_tag(name:"cvss_base", value:"0.0");
 script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:N/I:N/A:N");
 script_version ("$Revision: 7076 $");
 script_tag(name:"last_modification", value:"$Date: 2017-09-07 13:53:47 +0200 (Thu, 07 Sep 2017) $");
 script_tag(name:"creation_date", value:"2016-08-09 10:21:09 +0200 (Tue, 09 Aug 2016)");
 script_name("Mitel Enterprise Manager Detection");

 script_tag(name: "summary" , value: "The script sends a connection request to the server and attempts to extract the version number from the reply.");

 script_tag(name:"qod_type", value:"remote_banner");

 script_category(ACT_GATHER_INFO);
 script_family("Product detection");
 script_copyright("This script is Copyright (C) 2016 Greenbone Networks GmbH");
 script_dependencies("find_service.nasl", "http_version.nasl");
 script_require_ports("Services/www", 9090);
 script_exclude_keys("Settings/disable_cgi_scanning");
 exit(0);
}


include("http_func.inc");
include("http_keepalive.inc");
include("host_details.inc");

port = get_http_port( default:9090 );

url = '/LoginPage.do';

req = http_post_req( port:port,
                     url:url,
                     data:'supportedBrowser=yes',
                     add_headers: make_array( "Content-Type", "application/x-www-form-urlencoded" ) );

buf = http_keepalive_send_recv( port:port, data:req, bodyonly:FALSE );

if( buf !~ "<title>(MiVoice )?Enterprise Manager" || ( "enterprise_manager_administrator_guide.htm" >!< buf && "Mitel Networks" >!< buf ) ) exit( 0 );

set_kb_item( name:"mitel/enterprise_manager/installed", value:TRUE );

vers = 'unknown';
cpe = 'cpe:/a:mitel:enterprise_manager';

version = eregmatch( pattern:'Enterprise Manager ([0-9.]+)', string:buf );
if( ! isnull( version[1] ) )
{
  vers = version[1];
  cpe += ':' + vers;
}

register_product( cpe:cpe, location:"/", port:port, service:'www' );

report = build_detection_report( app:"Mitel Enterprise Manager", version:vers, install:"/", cpe:cpe, concluded:version[0] );
log_message( port:port, data:report );

exit( 0 );
