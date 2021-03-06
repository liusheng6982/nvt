###############################################################################
# OpenVAS Vulnerability Test
# $Id: deb_dla_1273.nasl 9250 2018-03-29 05:55:29Z cfischer $
#
# Auto-generated from advisory DLA 1273-1 using nvtgen 1.0
# Script version:1.0
# #
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
  script_oid("1.3.6.1.4.1.25623.1.0.891273");
  script_version("$Revision: 9250 $");
  script_cve_id("CVE-2017-18121", "CVE-2017-18122", "CVE-2018-6521");
  script_name("Debian LTS Advisory ([SECURITY] [DLA 1273-1] simplesamlphp security update)");
  script_tag(name:"last_modification", value:"$Date: 2018-03-29 07:55:29 +0200 (Thu, 29 Mar 2018) $");
  script_tag(name:"creation_date", value:"2018-02-21 00:00:00 +0100 (Wed, 21 Feb 2018)");
  script_tag(name:"cvss_base", value:"7.5");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:P/I:P/A:P");
  script_tag(name:"solution_type", value:"VendorFix");
  script_tag(name:"qod_type", value:"package");

  script_xref(name:"URL", value:"https://lists.debian.org/debian-lts-announce/2018/02/msg00008.html");

  script_category(ACT_GATHER_INFO);

  script_copyright("Copyright (c) 2018 Greenbone Networks GmbH http://greenbone.net");
  script_family("Debian Local Security Checks");
  script_dependencies("gather-package-list.nasl");
  script_mandatory_keys("ssh/login/debian_linux", "ssh/login/packages");
  script_tag(name:"affected", value:"simplesamlphp on Debian Linux");
  script_tag(name:"insight", value:"simpleSAMLphp, with its support for several authentication mechanisms
and federation protocols, can be used for local authentication, as a
service provider or identity provider.");
  script_tag(name:"solution", value:"For Debian 7 'Wheezy', these problems have been fixed in version
1.9.2-1+deb7u2.

We recommend that you upgrade your simplesamlphp packages.");
  script_tag(name:"summary",  value:"simplesamlphp, an authentication and federation application has been
found vulnerable to Cross Site Scripting (XSS), signature validation
byepass and using insecure connection charset.

CVE-2017-18121

A Cross Site Scripting (XSS) issue has been found in the
consentAdmin module of SimpleSAMLphp through 1.14.15, allowing an
attacker to manually craft links that a victim can open, executing
arbitrary javascript code.

CVE-2017-18122

A signature-validation bypass issue was discovered in SimpleSAMLphp
through 1.14.16. Service Provider using SAML 1.1 will regard as
valid any unsigned SAML response containing more than one signed
assertion, provided that the signature of at least one of the
assertions is valid. Attributes contained in all the assertions
received will be merged and the entityID of the first assertion
received will be used, allowing an attacker to impersonate any user
of any IdP given an assertion signed by the targeted IdP.

CVE-2018-6521

The sqlauth module in SimpleSAMLphp before 1.15.2 relies on the
MySQL utf8 charset, which truncates queries upon encountering
four-byte characters. There might be a scenario in which this allows
remote attackers to bypass intended access restrictions.");
  script_tag(name:"vuldetect", value:"This check tests the installed software version using the apt package manager.");

  exit(0);
}

include("revisions-lib.inc");
include("pkg-lib-deb.inc");

res = "";
report = "";
if ((res = isdpkgvuln(pkg:"simplesamlphp", ver:"1.9.2-1+deb7u2", rls_regex:"DEB7\.[0-9]+", remove_arch:TRUE )) != NULL) {
    report += res;
}

if (report != "") {
  security_message(data:report);
} else if (__pkg_match) {
  exit(99); # Not vulnerable.
}
