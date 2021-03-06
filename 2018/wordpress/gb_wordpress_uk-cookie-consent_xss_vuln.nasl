###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_wordpress_uk-cookie-consent_xss_vuln.nasl 9621 2018-04-26 08:27:24Z asteins $
#
# WordPress Cookie Consent Plugin XSS Vulnerability
#
# Authors:
# Adrian Steins <adrian.steins@greenbone.net>
#
# Copyright:
# Copyright (C) 2018 Greenbone Networks GmbH
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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

CPE = "cpe:/a:wordpress:wordpress";

if (description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.112260");
  script_version("$Revision: 9621 $");
  script_tag(name: "last_modification", value: "$Date: 2018-04-26 10:27:24 +0200 (Thu, 26 Apr 2018) $");
  script_tag(name: "creation_date", value: "2018-04-26 10:40:00 +0200 (Thu, 26 Apr 2018)");
  script_tag(name:"cvss_base", value:"4.3");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:N/I:P/A:N");

  script_cve_id("CVE-2018-10310");

  script_tag(name: "qod_type", value: "remote_banner");

  script_tag(name: "solution_type", value: "VendorFix");

  script_name("WordPress Cookie Consent Plugin XSS Vulnerability");

  script_category(ACT_GATHER_INFO);

  script_copyright("This script is Copyright (C) 2018 Greenbone Networks GmbH");
  script_family("Web application abuses");
  script_dependencies("secpod_wordpress_detect_900182.nasl");
  script_mandatory_keys("wordpress/installed");

  script_tag(name: "summary", value: "Cookie Consent plugin for WordPress is prone to a persistent cross-site scripting (XSS) vulnerability.");
  script_tag(name: "vuldetect", value: "Checks the version.");

  script_tag(name: "affected", value: "WordPress Cookie Consent plugin before version 2.3.10.");

  script_tag(name: "solution", value: "Upgrade to version 2.3.10 or later.");

  script_xref(name: "URL", value: "https://wordpress.org/plugins/uk-cookie-consent/#developers");
  script_xref(name: "URL", value: "https://gist.github.com/B0UG/9732614abccaf2893c352d14c822d07b");
  script_xref(name: "URL", value: "http://packetstormsecurity.com/files/147333/WordPress-UK-Cookie-Consent-2.3.9-Cross-Site-Scripting.html");

  exit(0);
}

include("host_details.inc");
include("http_func.inc");
include("http_keepalive.inc");
include("version_func.inc");

if (!port = get_app_port(cpe: CPE))
  exit(0);

if (!dir = get_app_location(cpe: CPE, port: port))
  exit(0);

if (dir == "/")
  dir = "";

res = http_get_cache(port: port, item: dir + "/wp-content/plugins/uk-cookie-consent/readme.txt");

if ("=== Cookie Consent ===" >< res && "Changelog" >< res) {

  vers = eregmatch(pattern: "Stable tag: ([0-9.]+)", string: res);

  if (!isnull(vers[1]) && version_is_less(version: vers[1], test_version: "2.3.10")) {
    report = report_fixed_ver(installed_version: vers[1], fixed_version: "2.3.10");
    security_message(port: port, data: report);
    exit(0);
  }
}

exit(99);
