###############################################################################
# OpenVAS Vulnerability Test
# $Id: find_service6.nasl 6849 2017-08-04 07:21:15Z cfischer $
#
# Service Detection with 'BINARY' Request
#
# Authors:
# Christian Fischer <christian.fischer@greenbone.net>
#
# Copyright:
# Copyright (c) 2017 Greenbone Networks GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version
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

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.108204");
  script_version("$Revision: 6849 $");
  script_tag(name:"last_modification", value:"$Date: 2017-08-04 09:21:15 +0200 (Fri, 04 Aug 2017) $");
  script_tag(name:"creation_date", value:"2017-08-04 09:08:04 +0200 (Fri, 04 Aug 2017)");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:N/I:N/A:N");
  script_tag(name:"cvss_base", value:"0.0");
  script_name("Service Detection with 'BINARY' Request");
  script_category(ACT_GATHER_INFO); 
  script_copyright("Copyright (c) 2017 Greenbone Networks GmbH");
  script_family("Service detection");
  script_dependencies("find_service5.nasl");
  script_require_ports("Services/unknown");

  script_tag(name:"summary", value:"This plugin performs service detection.

  This plugin is a complement of find_service.nasl. It sends a 'BINARY' 
  request to the remaining unknown services and tries to identify them.");

  script_tag(name:"qod_type", value:"remote_banner");

  exit(0);
}

include("host_details.inc");
include("misc_func.inc");
include("global_settings.inc");

port = get_kb_item( "Services/unknown" );
if( ! port ) exit( 0 );
if( ! get_port_state( port ) ) exit( 0 );
if( ! service_is_unknown( port:port ) ) exit( 0 );

soc = open_sock_tcp( port );
if( ! soc ) exit( 0 );

req = raw_string( 0x00, 0x01, 0x02, 0x03, 0x04 );
send( socket:soc, data:req );
r = recv( socket:soc, length:4096 );
close( soc );

if( ! r ) {
  debug_print( 'service on port ', port, ' does not answer to a "0x00, 0x01, 0x02, 0x03, 0x04" raw string request', "\n" );
  exit( 0 );
}

k = "FindService/tcp/" + port + "/bin";
set_kb_item( name:k, value:r );
if( '\0' >< r )
  set_kb_item( name:k + "Hex", value:hexstr( r ) );

if( "rlogind: Permission denied." >< r ) {
  register_service( port:port, proto:"rlogin", message:"A rlogin service seems to be running on this port." );
  log_message( port:port, data:"A rlogin service seems to be running on this port." );
  exit( 0 );
}

if( "Where are you?" >< r ) {
  register_service( port:port, proto:"rexec", message:"A rexec service seems to be running on this port." );
  log_message( port:port, data:"A rexec service seems to be running on this port." );
  exit( 0 );
}

########################################################################
#             Unidentified service                                     #
########################################################################

if( ! r0 ) set_unknown_banner( port:port, banner:r );
