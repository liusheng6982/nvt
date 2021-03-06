###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_parallels_plesk_sitebuilder_remote_detect.nasl 8263 2017-12-29 15:35:55Z santu $
#
# Parallels Plesk Sitebuilder Remote Detection
#
# Authors:
# Rinu Kuriakose <krinu@secpod.com>
#
# Copyright:
# Copyright (C) 2017 Greenbone Networks GmbH, http://www.greenbone.net
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
  script_oid("1.3.6.1.4.1.25623.1.0.812278");
  script_version("$Revision: 8263 $");
  script_tag(name:"cvss_base", value:"0.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:N/I:N/A:N");
  script_tag(name:"last_modification", value:"$Date: 2017-12-29 16:35:55 +0100 (Fri, 29 Dec 2017) $");
  script_tag(name:"creation_date", value:"2017-12-27 12:18:56 +0530 (Wed, 27 Dec 2017)");
  script_name("Parallels Plesk Sitebuilder Remote Detection");

  script_tag(name : "summary" , value : "Detection of installed version
  of Parallels Plesk Sitebuilder.

  This script sends HTTP GET request and try to get the version from the
  response, and sets the result in KB.");

  script_tag(name:"qod_type", value:"remote_banner");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2017 Greenbone Networks GmbH");
  script_family("Product detection");
  script_dependencies("find_service.nasl");
  script_require_ports("Services/www", 2006);
  exit(0);
}

##
### Code Starts Here
##

include("cpe.inc");
include("http_func.inc");
include("host_details.inc");
include("http_keepalive.inc");

ppsPort = get_http_port(default:2006);

url = "/Login.aspx";
ppsReq = http_get(item:url, port:ppsPort);
ppsRes = http_keepalive_send_recv(port:ppsPort, data:ppsReq);

if("Log in to Plesk Sitebuilder" >< ppsRes && ppsRes =~ "Copyright.*Parallels" &&
   ">Interface language" >< ppsRes && ">User name" >< ppsRes)
{
  ppsVer = "Unknown";

  vers = eregmatch(pattern:"Log in to Plesk Sitebuilder ([0-9.]+)" , string:ppsRes);
  if(vers[1]){
    ppsVer = vers[1];
  }

  set_kb_item(name:"Parallels/Plesk/Sitebuilder/Installed", value:TRUE);

  ## Created new cpe
  cpe = build_cpe(value:ppsVer, exp:"^([0-9.]+)", base:"cpe:/a:parallels:parallels_plesk_sitebuilder:");
  if(!cpe)
    cpe= "cpe:/a:parallels:parallels_plesk_sitebuilder";

  register_product(cpe:cpe, location:"/", port:ppsPort);

  log_message(data: build_detection_report(app: "Parallels Plesk Sitebuilder",
                                           version: ppsVer,
                                           install: "/",
                                           cpe: cpe,
                                           concluded: ppsVer),
                                           port: ppsPort);
  exit(0);
}
exit(0);
