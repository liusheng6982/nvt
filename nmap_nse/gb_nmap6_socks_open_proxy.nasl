###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_nmap6_socks_open_proxy.nasl 9364 2018-04-06 07:33:03Z cfischer $
#
# Autogenerated NSE wrapper
#
# Authors:
# NSE-Script: Joao Correa
# NASL-Wrapper: autogenerated
#
# Copyright:
# NSE-Script: The Nmap Security Scanner (http://nmap.org)
# Copyright (C) 2013 Greenbone Networks GmbH, http://www.greenbone.net
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

tag_summary = "Checks if an open socks proxy is running on the target.

The script attempts to connect to a proxy server and send socks4 and socks5 payloads. It is
considered an open proxy if the script receives a Request Granted response from the target port.

The payloads try to open a connection to www.google.com port 80.  A different test host can be
passed as 'proxy.url' argument.


SYNTAX:

proxy.url:  URL that will be requested to the proxy.


proxy.pattern:  Pattern that will be searched inside the request results.";

if(description)
{
    script_oid("1.3.6.1.4.1.25623.1.0.803575");
    script_version("$Revision: 9364 $");
    script_tag(name:"cvss_base", value:"0.0");
    script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:N/I:N/A:N");
    script_tag(name:"last_modification", value:"$Date: 2018-04-06 09:33:03 +0200 (Fri, 06 Apr 2018) $");
    script_tag(name:"creation_date", value:"2013-02-28 19:01:04 +0530 (Thu, 28 Feb 2013)");
    script_name("Nmap NSE 6.01: socks-open-proxy");


    script_category(ACT_ATTACK);
    script_tag(name:"qod_type", value:"remote_analysis");
    script_copyright("NSE-Script: The Nmap Security Scanner; NASL-Wrapper: Greenbone Networks GmbH");
    script_family("Nmap NSE");

    script_add_preference(name:"proxy.url", value:"", type:"entry");
    script_add_preference(name:"proxy.pattern", value:"", type:"entry");

    script_dependencies("toolcheck.nasl");
    script_mandatory_keys("Tools/Present/nmap6.01");
    script_mandatory_keys("Tools/Launch/nmap_nse");

    script_tag(name : "summary" , value : tag_summary);
    exit(0);
}



# Get the preferences
i = 0;

## Socks Proxy Port
port = 1080;


pref = script_get_preference("proxy.url");
if (!isnull(pref) && pref != "") {
  args[i++] = string('"', 'proxy.url', '=', pref, '"');
}
pref = script_get_preference("proxy.pattern");
if (!isnull(pref) && pref != "") {
  args[i++] = string('"', 'proxy.pattern', '=', pref, '"');
}

argv = make_list("nmap", "--script=socks-open-proxy.nse", "-p", port,
                  get_host_ip());

if(i > 0)
{
  scriptArgs= "--script-args=";
  foreach arg(args) {
    scriptArgs += arg + ",";
  }
  argv = make_list(argv,scriptArgs);
}

## Run nmap and Get the Result
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

  if("socks-open-proxy" >< result) {
    msg = string('Result found by Nmap Security Scanner (socks-open-proxy.nse) ',
                'http://nmap.org:\n\n', result);
    log_message(data : msg, port:port);
  }
}
else
{
  msg = string('Nmap command failed entirely:\n', 'nmap ', argv);
  log_message(data: msg, port:port);
}
