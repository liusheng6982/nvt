###############################################################################
# OpenVAS Vulnerability Test
# $Id: secpod_wordpress_php_files_info_disc_vuln.nasl 7029 2017-08-31 11:51:40Z teissa $
#
# WordPress '.php' Files Information Disclosure Vulnerability
#
# Authors:
# Madhuri D <dmadhuri@secpod.com>
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

tag_impact = "Successful exploitation will allow attacker to gain sensitive
information.

Impact Level: Application";

tag_affected = "WordPress version 2.9.2 and 3.0.4";

tag_insight = "The flaw is due to error in certain '.php' files. A direct request
to these files reveals the installation path in an error message.";

tag_solution = "No solution or patch was made available for at least one year
since disclosure of this vulnerability. Likely none will be provided anymore.
General solution options are to upgrade to a newer release, disable respective
features, remove the product or replace the product by another one.";

tag_summary = "The host is running WordPress and is prone to information
disclosure vulnerability.";

SCRIPT_OID  = "1.3.6.1.4.1.25623.1.0.902741";
CPE = "cpe:/a:wordpress:wordpress";

if(description)
{
  script_oid(SCRIPT_OID);
  script_version("$Revision: 7029 $");
  script_tag(name:"last_modification", value:"$Date: 2017-08-31 13:51:40 +0200 (Thu, 31 Aug 2017) $");
  script_tag(name:"creation_date", value:"2011-09-30 15:58:03 +0200 (Fri, 30 Sep 2011)");
  script_cve_id("CVE-2011-3818");
  script_tag(name:"cvss_base", value:"5.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:P/I:N/A:N");
  script_name("WordPress '.php' Files Information Disclosure Vulnerability");
  script_xref(name : "URL" , value : "https://bugzilla.redhat.com/show_bug.cgi?id=741301");
  script_xref(name : "URL" , value : "https://www.infosecisland.com/alertsview/16806-CVE-2011-3818-wordpress.html");
  script_xref(name : "URL" , value : "http://code.google.com/p/inspathx/source/browse/trunk/paths_vuln/wordpress_2.9.2");

  script_tag(name:"qod_type", value:"remote_active");
  script_category(ACT_ATTACK);
  script_copyright("Copyright (C) 2011 SecPod");
  script_family("Web application abuses");
  script_dependencies("secpod_wordpress_detect_900182.nasl");
  script_require_ports("Services/www", 80);
  script_require_keys("wordpress/installed");
  script_tag(name : "impact" , value : tag_impact);
  script_tag(name : "affected" , value : tag_affected);
  script_tag(name : "insight" , value : tag_insight);
  script_tag(name : "solution" , value : tag_solution);
  script_tag(name : "summary" , value : tag_summary);
  script_tag(name:"solution_type", value:"WillNotFix");
  exit(0);
}


include("http_func.inc");
include("version_func.inc");
include("http_keepalive.inc");
include("host_details.inc");


## Get the HTTP Port
if(!port = get_app_port(cpe:CPE, nvt:SCRIPT_OID))exit(0);

## Check Host Supports PHP
if(!can_host_php(port:port)) {
  exit(0);
}

## Get the version from KB
if(!dir = get_app_location(cpe:CPE, nvt:SCRIPT_OID, port:port))exit(0);

## Construct the Attack Request
url = dir + "/wp-admin/includes/user.php";

## Try attack and check the response to confirm vulnerability.
if(http_vuln_check(port:port, url:url, pattern:"<b>Fatal error</b>:  Call" +
                 " to undefined function add_action().*/wp-admin/" +
                 "includes/user.php")){
  security_message(port:port);
}
