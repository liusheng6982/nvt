###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_dell_kace_k1000_sma_label_id_xss_vuln.nasl 6878 2017-08-09 05:39:14Z ckuersteiner $
#
# Dell KACE K1000 LABEL_ID Cross Site Scripting Vulnerability
#
# Authors:
# Shashi Kiran N <nskiran@secpod.com>
#
# Copyright:
# Copyright (C) 2014 Greenbone Networks GmbH, http://www.greenbone.net
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

CPE = "cpe:/a:dell:kace_k1000_systems_management_appliance";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.804238");
  script_version("$Revision: 6878 $");
  script_cve_id("CVE-2014-0330");
  script_tag(name: "cvss_base", value: "4.3");
  script_tag(name: "cvss_base_vector", value: "AV:N/AC:M/Au:N/C:N/I:P/A:N");
  script_tag(name: "last_modification", value: "$Date: 2017-08-09 07:39:14 +0200 (Wed, 09 Aug 2017) $");
  script_tag(name: "creation_date", value: "2014-02-14 15:46:39 +0530 (Fri, 14 Feb 2014)");

  script_name("Dell KACE K1000 LABEL_ID Cross Site Scripting Vulnerability");

  script_tag(name: "summary", value: "This host is running Dell KACE K1000 Systems Management Appliance and is
prone to cross site scripting vulnerability.");

  script_tag(name: "vuldetect", value: "Get the installed version of Dell KACE K1000 SMA with the help of detect
NVT and check the version is vulnerable or not.");

  script_tag(name: "insight", value: "The flaw is in adminui/user_list.php script which fails to properly
sanitizing user-supplied input to LABEL_ID parameter.");

  script_tag(name: "impact", value: "Successful exploitation will allow remote attackers to execute arbitrary
script.

Impact Level: Application");

  script_tag(name: "affected", value: "Dell KACE K1000 Systems Management Appliance version 5.5.90545");

  script_tag(name: "solution", value: "Upgrade to latest version of Dell KACE K1000 SMA or Apply the workaround
mentioned below link, http://www.kace.com/support/resources/kb/solutiondetail?sol=SOL120154
For updates refer to http://www.kace.com/products/systems-management-appliance");

  script_xref(name: "URL", value: "http://www.kb.cert.org/vuls/id/813382");
  script_xref(name: "URL", value: "http://www.kace.com/support/resources/kb/solutiondetail?sol=SOL120154");

  script_category(ACT_GATHER_INFO);
  script_tag(name: "qod_type", value: "remote_banner");
  script_copyright("Copyright (C) 2014 Greenbone Networks GmbH");
  script_family("Web application abuses");

  script_dependencies("gb_dell_kace_k1000_sma_detect.nasl");
  script_mandatory_keys("kace_1000/detected");
  script_require_ports("Services/www", 80);

  exit(0);
}

include("host_details.inc");
include("version_func.inc");

## Get HTTP Port
if (!dPort = get_app_port(cpe: CPE))
  exit(0);

## Get Dell KACE K1000 Systems Management Appliance version
if (!vers = get_app_version(cpe:CPE, port:dPort))
  exit(0);

## check the vulnerable versions
if (version_is_equal(version: vers, test_version: "5.5.90545")) {
  report = report_fixed_ver(installed_version: vers, fixed_version: "See advisory");
  security_message(port: dPort, data: report);
  exit(0);
}

exit(99);
