###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_php_pdo_sql_parser_re_file_pdo_ext_dos_vuln_win.nasl 7549 2017-10-24 12:10:14Z cfischer $
#
# PHP pdo_sql_parser.re 'PDO' extension DoS vulnerability (Windows)
#
# Authors:
# Sharath S <sharaths@secpod.com>
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
  script_oid("1.3.6.1.4.1.25623.1.0.802670");
  script_version("$Revision: 7549 $");
  script_cve_id("CVE-2012-3450");
  script_bugtraq_id(54777);
  script_tag(name:"cvss_base", value:"2.6");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:H/Au:N/C:N/I:N/A:P");
  script_tag(name:"last_modification", value:"$Date: 2017-10-24 14:10:14 +0200 (Tue, 24 Oct 2017) $");
  script_tag(name:"creation_date", value:"2012-08-27 17:03:25 +0530 (Mon, 27 Aug 2012)");
  script_name("PHP pdo_sql_parser.re 'PDO' extension DoS vulnerability (Windows)");

  script_xref(name:"URL", value:"http://seclists.org/bugtraq/2012/Jun/60");
  script_xref(name:"URL", value:"http://www.php.net/ChangeLog-5.php");
  script_xref(name:"URL", value:"https://bugs.php.net/bug.php?id=61755");
  script_xref(name:"URL", value:"https://bugzilla.novell.com/show_bug.cgi?id=769785");

  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (c) 2012 Greenbone Networks GmbH");
  script_family("Denial of Service");
  script_dependencies("os_detection.nasl","gb_php_detect.nasl");
  script_require_ports("Services/www", 80);
  script_mandatory_keys("php/installed","Host/runs_windows");

  tag_impact = "Successful exploitation could allow remote attackers to cause a denial of
  service condition.

  Impact Level: Application";

  tag_affected = "PHP version before 5.3.14 and 5.4.x before 5.4.4 on Windows";

  tag_insight = "The flaw is due to an error in the PDO extension in pdo_sql_parser.re
  file, which fails to determine the end of the query string during parsing of
  prepared statements.";

  tag_solution = "Upgrade to PHP Version 5.3.14 or 5.4.4 or later,
  For updates refer to http://php.net/downloads.php";

  tag_summary = "This host is installed with PHP and is prone denial of service
  vulnerability.";

  script_tag(name:"impact", value:tag_impact);
  script_tag(name:"affected", value:tag_affected);
  script_tag(name:"insight", value:tag_insight);
  script_tag(name:"solution", value:tag_solution);
  script_tag(name:"summary", value:tag_summary);

  script_tag(name:"qod_type", value:"remote_banner");
  script_tag(name:"solution_type", value:"VendorFix");

  exit(0);
}

include("version_func.inc");
include("host_details.inc");

if( isnull( phpPort = get_app_port( cpe:CPE ) ) ) exit( 0 );
if( ! phpVer = get_app_version( cpe:CPE, port:phpPort ) ) exit( 0 );

##Check for PHP version < 5.3.14 and 5.4.x before 5.4.4
if(version_is_less(version:phpVer, test_version:"5.3.14") ||
   version_in_range(version: phpVer, test_version: "5.4.0", test_version2: "5.4.3")){
  report = report_fixed_ver(installed_version:phpVer, fixed_version:"5.3.14/5.4.4");
  security_message(data:report, port:phpPort);
  exit(0);
}

exit(99);
