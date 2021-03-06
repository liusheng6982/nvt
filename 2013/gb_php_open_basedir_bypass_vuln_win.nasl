###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_php_open_basedir_bypass_vuln_win.nasl 7548 2017-10-24 12:06:02Z cfischer $
#
# PHP 'open_basedir' Secuirity Bypass Vulnerability (Windows)
#
# Authors:
# Arun Kallavi <karun@secpod.com>
#
# Copyright:
# Copyright (c) 2013 Greenbone Networks GmbH, http://www.greenbone.net
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
  script_oid("1.3.6.1.4.1.25623.1.0.803318");
  script_version("$Revision: 7548 $");
  script_cve_id("CVE-2012-3365");
  script_bugtraq_id(54612);
  script_tag(name:"cvss_base", value:"5.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:N/I:P/A:N");
  script_tag(name:"last_modification", value:"$Date: 2017-10-24 14:06:02 +0200 (Tue, 24 Oct 2017) $");
  script_tag(name:"creation_date", value:"2013-03-01 12:49:42 +0530 (Fri, 01 Mar 2013)");
  script_name("PHP 'open_basedir' Secuirity Bypass Vulnerability (Windows)");

  script_xref(name:"URL", value:"http://www.php.net/ChangeLog-5.php");
  script_xref(name:"URL", value:"http://en.securitylab.ru/nvd/427459.php");
  script_xref(name:"URL", value:"http://secunia.com/advisories/cve_reference/CVE-2012-3365");

  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (c) 2013 Greenbone Networks GmbH");
  script_family("Web application abuses");
  script_dependencies("os_detection.nasl","gb_php_detect.nasl");
  script_require_ports("Services/www", 80);
  script_mandatory_keys("php/installed","Host/runs_windows");

  tag_impact = "Successful exploitation could allow attackers to bypass certain security
  restrictions.
  Impact Level: Application";

  tag_affected = "PHP version before 5.3.15";
  tag_insight = "Flaw in SQLite functionality allows attackers to bypass the open_basedir
  protection mechanism.";
  tag_solution = "Upgrade to PHP 5.3.15 or later
  For updates refer to http://www.php.net/downloads.php";
  tag_summary = "This host is running PHP and is prone to security bypass
  vulnerability.";

  script_tag(name : "impact" , value : tag_impact);
  script_tag(name : "affected" , value : tag_affected);
  script_tag(name : "insight" , value : tag_insight);
  script_tag(name : "solution" , value : tag_solution);
  script_tag(name : "summary" , value : tag_summary);

  script_tag(name:"qod_type", value:"remote_banner");
  script_tag(name:"solution_type", value:"VendorFix");

  exit(0);
}

include("version_func.inc");
include("host_details.inc");

if( isnull( phpPort = get_app_port( cpe:CPE ) ) ) exit( 0 );
if( ! phpVer = get_app_version( cpe:CPE, port:phpPort ) ) exit( 0 );

##Check for PHP version
if(version_is_less(version:phpVer, test_version:"5.3.15")){
  report = report_fixed_ver(installed_version:phpVer, fixed_version:"5.3.15");
  security_message(data:report, port:phpPort);
  exit(0);
}

exit(99);
