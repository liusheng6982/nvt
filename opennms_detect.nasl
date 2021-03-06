###############################################################################
# OpenVAS Vulnerability Test
# $Id: opennms_detect.nasl 7278 2017-09-26 13:20:44Z cfischer $
#
# OpenNMS Version Detection
#
# Authors:
# Rinu Kuriaksoe <krinu@secpod.com>
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

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.806530");
  script_version("$Revision: 7278 $");
  script_tag(name:"cvss_base", value:"0.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:N/I:N/A:N");
  script_tag(name:"last_modification", value:"$Date: 2017-09-26 15:20:44 +0200 (Tue, 26 Sep 2017) $");
  script_tag(name:"creation_date", value:"2015-11-04 17:27:57 +0530 (Wed, 04 Nov 2015)");
  script_name("OpenNMS Version Detection");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2015 Greenbone Networks GmbH");
  script_family("Product detection");
  script_dependencies("find_service.nasl", "http_version.nasl");
  script_require_ports("Services/www", 8980);
  script_exclude_keys("Settings/disable_cgi_scanning");

  script_tag(name:"summary", value:"Detection of installed version of
  OpenNMS.

  This script sends HTTP GET request and try to get the version from the
  response, and sets the result in KB.");

  script_tag(name:"qod_type", value:"remote_banner");

  exit(0);
}

include("cpe.inc");
include("host_details.inc");
include("http_func.inc");
include("http_keepalive.inc");

port = get_http_port( default:8980 );

foreach dir( make_list_unique( "/", "/opennms", cgi_dirs( port:port ) ) ) {

  install = dir;
  if( dir == "/" ) dir = "";

  rcvRes = http_get_cache( item: dir + "/login.jsp", port:port );

  ## confirm the application
  if( "OpenNMS Group, Inc." >< rcvRes && "http://www.opennms.com/" >< rcvRes
      && ">Login" >< rcvRes ) {

    version = "unknown";

    ## Set the KB value
    set_kb_item( name:"www/" + port + "/OpenNms", value:version );
    set_kb_item( name:"OpenNms/Installed", value:TRUE );

    ## build cpe and store it as host_detail
    cpe = build_cpe( value:version, exp:"^([0-9.]+)", base:"cpe:/a:opennms:opennms:" );
    if( ! cpe )
      cpe = "cpe:/a:opennms:opennms";

    register_product( cpe:cpe, location:install, port:port );

    log_message( data:build_detection_report( app:"OpenNms",
                                              version:version,
                                              install:install,
                                              cpe:cpe ),
                                              port:port );
  }
}

exit( 0 );