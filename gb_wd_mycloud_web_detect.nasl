###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_wd_mycloud_web_detect.nasl 8408 2018-01-12 18:47:24Z cfischer $
#
# Western Digital MyCloud Products Detection
#
# Authors:
# Christian Fischer <christian.fischer@greenbone.net>
#
# Copyright:
# Copyright (c) 2017 Greenbone Networks GmbH
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
  script_oid("1.3.6.1.4.1.25623.1.0.108034");
  script_version("$Revision: 8408 $");
  script_tag(name:"last_modification", value:"$Date: 2018-01-12 19:47:24 +0100 (Fri, 12 Jan 2018) $");
  script_tag(name:"creation_date", value:"2017-01-04 10:00:00 +0100 (Wed, 04 Jan 2017)");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:N/I:N/A:N");
  script_tag(name:"cvss_base", value:"0.0");
  script_name("Western Digital MyCloud Products Detection");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2017 Greenbone Networks GmbH");
  script_family("Product detection");
  script_dependencies("find_service.nasl", "http_version.nasl");
  script_require_ports("Services/www", 80);
  script_exclude_keys("Settings/disable_cgi_scanning");

  script_tag(name:"summary", value:"This script performs HTTP based detecion of Western Digital MyCloud Products.");

  script_tag(name:"qod_type", value:"remote_banner");

  exit(0);
}

include("http_func.inc");
include("http_keepalive.inc");
include("host_details.inc");
include("cpe.inc");

port = get_http_port( default:80 );

res = http_get_cache( item:"/", port:port );

# Possible response
#var _PROJECT_MODEL_ID_LIGHTNING = "WDMyCloudEX4";
#var _PROJECT_MODEL_ID_KINGS_CANYON = "WDMyCloudEX2";
#var _PROJECT_MODEL_ID_ZION = "WDMyCloudMirror";
#var _PROJECT_MODEL_ID_GLACIER = "WDMyCloud";
#var _PROJECT_MODEL_ID_YELLOWSTONE = "WDMyCloudEX4100";
#var _PROJECT_MODEL_ID_YOSEMITE = "WDMyCloudEX2100";
#var _PROJECT_MODEL_ID_SPRITE = "WDMyCloudDL4100";
#var _PROJECT_MODEL_ID_AURORA = "WDMyCloudDL2100";
#var _PROJECT_MODEL_ID_BLACKICE = "WDMyCloudEX1100";
#var MODEL_ID = "WDMyCloudMirror";

if( res =~ "^HTTP/1\.[01] 200" && ( 'MODEL_ID = "WDMyCloud"' >< res || "/web/images/logo_WDMyCloud.png" >< res ) ) {

  version = "unknown";

  # nb: This only offers the major version and seems to be available via 443 only
  url  = "/xml/info.xml";
  req  = http_get( item:url, port:port );
  res2 = http_keepalive_send_recv( data:req, port:port, bodyonly:FALSE );

  model = eregmatch( pattern:'var MODEL_ID = "([a-zA-Z0-9]+)";', string:res );
  if( model[1] ) {
    extra = "Model: " + model[1];
  } else {
    model = eregmatch( pattern:"<hw_ver>([a-zA-Z0-9]+)</hw_ver>", string:res2 );
    if( model[1] ) extra = "Model: " + model[1];
  }

  vers = eregmatch( pattern:"<version>([0-9.]+)</version>", string:res2 );
  if( vers[1] ) {
    version = vers[1];
    conclUrl = report_vuln_url( port:port, url:url, url_only:TRUE );
  }

  set_kb_item( name:"WD-MyCloud/www/detected", value:TRUE );
  
  register_and_report_cpe( app:"Western Digital MyCloud NAS", ver:version, concluded:vers[0], base:"cpe:/a:western_digital:mycloud_nas:",
                           expr:"^([0-9.]+)", insloc:"/", regPort:port, regService:"www", conclUrl:conclUrl, extra:extra );
}

exit( 0 );
