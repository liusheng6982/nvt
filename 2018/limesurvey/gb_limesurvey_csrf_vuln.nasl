##############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_limesurvey_csrf_vuln.nasl 9094 2018-03-14 07:52:16Z cfischer $
#
# LimeSurvey CSRF Vulnerability
#
# Authors:
# Christian Kuersteiner <christian.kuersteiner@greenbone.net>
#
# Copyright:
# Copyright (c) 2018 Greenbone Networks GmbH
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

CPE = "cpe:/a:limesurvey:limesurvey";

if (description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.140788");
  script_version("$Revision: 9094 $");
  script_tag(name: "last_modification", value: "$Date: 2018-03-14 08:52:16 +0100 (Wed, 14 Mar 2018) $");
  script_tag(name: "creation_date", value: "2018-02-20 17:01:16 +0700 (Tue, 20 Feb 2018)");
  script_tag(name:"cvss_base", value:"6.8");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:P/I:P/A:P");

  script_cve_id("CVE-2018-1000053");

  script_tag(name: "qod_type", value: "remote_banner");

  script_tag(name: "solution_type", value: "VendorFix");

  script_name("LimeSurvey CSRF Vulnerability");

  script_category(ACT_GATHER_INFO);

  script_copyright("This script is Copyright (C) 2018 Greenbone Networks GmbH");
  script_family("Web application abuses");
  script_dependencies("secpod_limesurvey_detect.nasl");
  script_mandatory_keys("limesurvey/installed");

  script_tag(name: "summary", value: "LimeSurvey contains a Cross ite Request Forgery (CSRF) vulnerability in
Theme Uninstallation that can result in CSRF causing LimeSurvey admins to delete all their themes, rendering the
website unusable. This attack appear to be exploitable via Simple HTML markup can be used to send a GET request to
the affected endpoint.");

  script_tag(name: "vuldetect", value: "Checks the version.");

  script_tag(name: "solution", value: "Update to version 3.3.1 (build 180214) or later.");

  script_xref(name: "URL", value: "https://github.com/LimeSurvey/LimeSurvey/commit/1e440208a8d8bfd71ad7802e6369a136e8bba3dd");

  exit(0);
}

include("host_details.inc");
include("revisions-lib.inc");
include("version_func.inc");

if (!port = get_app_port(cpe: CPE))
  exit(0);

if (!version = get_app_version(cpe: CPE, port: port))
  exit(0);

if (revcomp(a: version, b: "3.3.1_build_180214") < 0) {
  report = report_fixed_ver(installed_version: version, fixed_version: "3.3.1_build_180214");
  security_message(port: port, data: report);
  exit(0);
}

exit(0);
