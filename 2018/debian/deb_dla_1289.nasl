###############################################################################
# OpenVAS Vulnerability Test
# $Id: deb_dla_1289.nasl 9250 2018-03-29 05:55:29Z cfischer $
#
# Auto-generated from advisory DSA 1289-1 using nvtgen 1.0
# Script version: 1.0
#
# Author:
# Greenbone Networks
#
# Copyright:
# Copyright (c) 2018 Greenbone Networks GmbH http://greenbone.net
# Text descriptions are largely excerpted from the referenced
# advisory, and are Copyright (c) the respective author(s)
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

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.891289");
  script_version("$Revision: 9250 $");
  script_cve_id("CVE-2018-7050", "CVE-2018-7051", "CVE-2018-7052");
  script_name("Debian LTS Advisory ([SECURITY] [DLA 1289-1] irssi security update)");
  script_tag(name:"last_modification", value:"$Date: 2018-03-29 07:55:29 +0200 (Thu, 29 Mar 2018) $");
  script_tag(name:"creation_date", value:"2018-03-27 00:00:00 +0200 (Tue, 27 Mar 2018)");
  script_tag(name:"cvss_base", value:"5.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:N/I:N/A:P");
  script_tag(name:"solution_type", value:"VendorFix");
  script_tag(name:"qod_type", value:"package");

  script_xref(name:"URL", value:"https://lists.debian.org/debian-lts-announce/2018/02/msg00024.html");

  script_category(ACT_GATHER_INFO);

  script_copyright("Copyright (c) 2018 Greenbone Networks GmbH http://greenbone.net");
  script_family("Debian Local Security Checks");
  script_dependencies("gather-package-list.nasl");
  script_mandatory_keys("ssh/login/debian_linux", "ssh/login/packages");
  script_tag(name:"affected", value:"irssi on Debian Linux");
  script_tag(name:"insight", value:"Irssi is a terminal based IRC client for UNIX systems. It also supports
SILC and ICB protocols via plugins.");
  script_tag(name:"solution", value:"For Debian 7 'Wheezy', these issues have been fixed in irssi version
0.8.15-5+deb7u5.

We recommend that you upgrade your irssi packages.");
  script_tag(name:"summary",  value:"<summary>");
  script_tag(name:"vuldetect", value:"This check tests the installed software version using the apt package manager.");

  exit(0);
}

include("revisions-lib.inc");
include("pkg-lib-deb.inc");

res = "";
report = "";
if ((res = isdpkgvuln(pkg:"irssi", ver:"0.8.15-5+deb7u5", rls_regex:"DEB7\.[0-9]+", remove_arch:TRUE )) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"irssi-dev", ver:"0.8.15-5+deb7u5", rls_regex:"DEB7\.[0-9]+", remove_arch:TRUE )) != NULL) {
    report += res;
}

if (report != "") {
  security_message(data:report);
} else if (__pkg_match) {
  exit(99); # Not vulnerable.
}
