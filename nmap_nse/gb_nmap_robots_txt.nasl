###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_nmap_robots_txt.nasl 6603 2017-07-07 10:21:45Z cfischer $
#
# Wrapper for Nmap Robots.txt NSE script
#
# Authors:
# NSE-Script: Eddie Bell
# NASL-Wrapper: Sooraj KS <kssooraj@secpod.com>
#
# Copyright:
# NSE-Script: Copyright (c) The Nmap Security Scanner (http://nmap.org)
# NASL-Wrapper: Copyright (c) 2010 Greenbone Networks GmbH (http://www.greenbone.net)
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

tag_summary = "This script attempts to check for disallowed entries in /robots.txt
  on a web server.

  This is a wrapper on the Nmap Security Scanner's (http://nmap.org) robots.txt.nse.";


if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.801696");
  script_version("$Revision: 6603 $");
  script_tag(name:"last_modification", value:"$Date: 2017-07-07 12:21:45 +0200 (Fri, 07 Jul 2017) $");
  script_tag(name:"creation_date", value:"2011-01-10 13:49:23 +0100 (Mon, 10 Jan 2011)");
  script_tag(name:"cvss_base", value:"0.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:N/I:N/A:N");
  script_name("Nmap NSE: Robots.txt");
  script_category(ACT_GATHER_INFO);
  script_tag(name:"qod_type", value:"remote_analysis");
  script_copyright("NSE-Script: The Nmap Security Scanner; NASL-Wrapper: Greenbone Networks GmbH");
  script_family("Nmap NSE");
  script_add_preference(name: "http-max-cache-size :", value: "",type: "entry");
  script_add_preference(name: "http.useragent :", value: "",type: "entry");
  script_add_preference(name: "http.pipeline :", value: "",type: "entry");

  script_dependencies("toolcheck.nasl", "find_service.nasl");
  script_require_ports("Services/www", 80);
  script_exclude_keys("Settings/disable_cgi_scanning");

  script_mandatory_keys("Tools/Launch/nmap_nse", "Tools/Present/nmap");

  script_tag(name : "summary" , value : tag_summary);
  exit(0);
}


include ("http_func.inc");

## Check for Required Keys
if((! get_kb_item("Tools/Present/nmap5.21") &&
   ! get_kb_item("Tools/Present/nmap5.51")) ||
   ! get_kb_item("Tools/Launch/nmap_nse")) {
 exit(0);
}

## Get HTTP Ports
port = get_http_port(default:80);
if(!port){
  exit(0);
}

# the script was renamed http-robots.txt in nmap 5.51
if (!isnull(get_kb_item("Tools/Present/nmap5.21")))
  nse_script_name = "robots.txt.nse";
else
  nse_script_name = "http-robots.txt.nse";

argv = make_list("nmap","--script="+nse_script_name,"-p",port,get_host_ip());

## Get the preferences
i = 0;
if( pref = script_get_preference("http-max-cache-size :")){
  args[i++] = "http-max-cache-size="+pref;
}

if( pref = script_get_preference("http.useragent :")){
  args[i++] = "http.useragent="+pref;
}

if( pref = script_get_preference("http.pipeline :")){
  args[i++] = "http.pipeline="+pref;
}

if(i > 0)
{
  scriptArgs= "--script-args=";
  foreach arg(args) {
    scriptArgs += arg + ",";
  }
  argv = make_list(argv,scriptArgs);
}

## Run nmap and Get the result
res = pread(cmd: "nmap", argv: argv);
if(res)
{
  foreach line (split(res))
  {
    if(ereg(pattern:"^\|",string:line)) {
      result +=  substr(chomp(line),2) + '\n';
    }

    error = eregmatch(string:line, pattern:"^nmap: (.*)$");
    if (error) {
      msg = string('Nmap command failed with following error message:\n', line);
      log_message(data : msg, port:port);
    }
  }

  if("robots.txt" >< result) {
    msg = string('Result found by Nmap Security Scanner (robots.txt.nse) ',
                'http://nmap.org:\n\n', result);
    security_message(data : msg, port:port);
  }
}
else
{
  msg = string('Nmap command failed entirely:\n');
  log_message(data : msg, port:port);
}
