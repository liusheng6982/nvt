###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_php_magic_quotes_gpc_sec_bypass_vuln_win.nasl 7549 2017-10-24 12:10:14Z cfischer $
#
# PHP 'magic_quotes_gpc' Directive Security Bypass Vulnerability (Windows)
#
# Authors:
# Madhuri D <dmadhuri@secpod.com>
#
# Copyright:
# Copyright (c) 2012 Greenbone Networks GmbH, http://www.greenbone.net
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

CPE = "cpe:/a:php:php";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.802591");
  script_version("$Revision: 7549 $");
  script_tag(name:"last_modification", value:"$Date: 2017-10-24 14:10:14 +0200 (Tue, 24 Oct 2017) $");
  script_tag(name:"creation_date", value:"2012-02-10 11:24:19 +0530 (Fri, 10 Feb 2012)");
  script_cve_id("CVE-2012-0831");
  script_bugtraq_id(51954);
  script_tag(name:"cvss_base", value:"6.8");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:P/I:P/A:P");
  script_name("PHP 'magic_quotes_gpc' Directive Security Bypass Vulnerability (Windows)");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2012 Greenbone Networks GmbH");
  script_family("Web application abuses");
  script_dependencies("os_detection.nasl","gb_php_detect.nasl");
  script_require_ports("Services/www", 80);
  script_mandatory_keys("php/installed","Host/runs_windows");

  tag_impact = "Successful exploitation could allow remote attackers to gain sensitive
  information via a crafted request.

  Impact Level: Application";

  tag_affected = "PHP Version 5.3.9 and prior on Windows.";

  tag_insight = "The flaw is due to an error in importing  environment variables,
  it not properly performing a temporary change to the 'magic_quotes_gpc'
  directive during the importing of environment variables.";

  tag_solution = "Upgrade to PHP Version 5.3.10 or later,
  For updates refer to http://php.net/downloads.php";

  tag_summary = "This host is installed with PHP and is prone to security bypass
  vulnerability.";

  script_tag(name:"impact", value:tag_impact);
  script_tag(name:"affected", value:tag_affected);
  script_tag(name:"insight", value:tag_insight);
  script_tag(name:"solution", value:tag_solution);
  script_tag(name:"summary", value:tag_summary);

  script_tag(name:"qod_type", value:"remote_banner");
  script_tag(name:"solution_type", value:"VendorFix");

  script_xref(name:"URL", value:"http://www.securityfocus.com/bid/51954/info");
  script_xref(name:"URL", value:"http://svn.php.net/viewvc?view=revision&revision=323016");

  exit(0);
}

include("version_func.inc");
include("host_details.inc");

if( isnull( phpPort = get_app_port( cpe:CPE ) ) ) exit( 0 );
if( ! phpVer = get_app_version( cpe:CPE, port:phpPort ) ) exit( 0 );

##Check for PHP version
if(version_is_less(version:phpVer, test_version:"5.3.10")){
  report = report_fixed_ver(installed_version:phpVer, fixed_version:"5.3.10");
  security_message(data:report, port:phpPort);
  exit(0);
}

exit(99);
