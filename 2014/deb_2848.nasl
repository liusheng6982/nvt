# OpenVAS Vulnerability Test
# $Id: deb_2848.nasl 9354 2018-04-06 07:15:32Z cfischer $
# Auto-generated from advisory DSA 2848-1 using nvtgen 1.0
# Script version: 1.3
#
# Author:
# Greenbone Networks
#
# Copyright:
# Copyright (c) 2014 Greenbone Networks GmbH http://greenbone.net
# Text descriptions are largely excerpted from the referenced
# advisory, and are Copyright (c) the respective author(s)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
#

tag_affected  = "mysql-5.5 on Debian Linux";
tag_insight   = "MySQL is a fast, stable and true multi-user, multi-threaded SQL database
server.";
tag_solution  = "For the stable distribution (wheezy), these problems have been fixed in
version 5.5.35+dfsg-0+wheezy1.

For the unstable distribution (sid), these problems have been fixed in
version 5.5.35+dfsg-1.

We recommend that you upgrade your mysql-5.5 packages.";
tag_summary   = "Several issues have been discovered in the MySQL database server. The
vulnerabilities are addressed by upgrading MySQL to the new upstream
version 5.5.35. Please see the MySQL 5.5 Release Notes and Oracle's
Critical Patch Update advisory for further details:

http://dev.mysql.com/doc/relnotes/mysql/5.5/en/news-5-5-34.htmlhttp://dev.mysql.com/doc/relnotes/mysql/5.5/en/news-5-5-35.htmlhttp://www.oracle.com/technetwork/topics/security/cpujan2014-1972949.html";
tag_vuldetect = "This check tests the installed software version using the apt package manager.";

if(description)
{
    script_oid("1.3.6.1.4.1.25623.1.0.702848");
    script_version("$Revision: 9354 $");
    script_cve_id("CVE-2013-5891", "CVE-2013-5908", "CVE-2014-0386", "CVE-2014-0393", "CVE-2014-0401", "CVE-2014-0402", "CVE-2014-0412", "CVE-2014-0420", "CVE-2014-0437");
    script_name("Debian Security Advisory DSA 2848-1 (mysql-5.5 - several vulnerabilities)");
    script_tag(name: "last_modification", value:"$Date: 2018-04-06 09:15:32 +0200 (Fri, 06 Apr 2018) $");
    script_tag(name: "creation_date", value:"2014-01-23 00:00:00 +0100 (Thu, 23 Jan 2014)");
    script_tag(name: "cvss_base", value:"4.0");
    script_tag(name: "cvss_base_vector", value:"AV:N/AC:L/Au:S/C:N/I:N/A:P");

    script_xref(name: "URL", value: "http://www.debian.org/security/2014/dsa-2848.html");


    script_category(ACT_GATHER_INFO);

    script_copyright("Copyright (c) 2014 Greenbone Networks GmbH http://greenbone.net");
    script_family("Debian Local Security Checks");
    script_dependencies("gather-package-list.nasl");
    script_mandatory_keys("ssh/login/debian_linux", "ssh/login/packages");
    script_tag(name: "affected",  value: tag_affected);
    script_tag(name: "insight",   value: tag_insight);
#    script_tag(name: "impact",    value: tag_impact);
    script_tag(name: "solution",  value: tag_solution);
    script_tag(name: "summary",   value: tag_summary);
    script_tag(name: "vuldetect", value: tag_vuldetect);
    script_tag(name:"qod_type", value:"package");
    script_tag(name:"solution_type", value:"VendorFix");

    exit(0);
}

include("revisions-lib.inc");
include("pkg-lib-deb.inc");

res = "";
report = "";
if ((res = isdpkgvuln(pkg:"libmysqlclient-dev", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.0")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"libmysqlclient18", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.0")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"libmysqld-dev", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.0")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"libmysqld-pic", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.0")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-client", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.0")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-client-5.5", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.0")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-common", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.0")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-server", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.0")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-server-5.5", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.0")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-server-core-5.5", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.0")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-source-5.5", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.0")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-testsuite-5.5", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.0")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"libmysqlclient-dev", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.1")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"libmysqlclient18", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.1")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"libmysqld-dev", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.1")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"libmysqld-pic", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.1")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-client", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.1")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-client-5.5", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.1")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-common", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.1")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-server", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.1")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-server-5.5", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.1")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-server-core-5.5", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.1")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-source-5.5", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.1")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-testsuite-5.5", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.1")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"libmysqlclient-dev", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.2")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"libmysqlclient18", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.2")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"libmysqld-dev", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.2")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"libmysqld-pic", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.2")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-client", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.2")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-client-5.5", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.2")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-common", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.2")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-server", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.2")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-server-5.5", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.2")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-server-core-5.5", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.2")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-source-5.5", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.2")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-testsuite-5.5", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.2")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"libmysqlclient-dev", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.3")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"libmysqlclient18", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.3")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"libmysqld-dev", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.3")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"libmysqld-pic", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.3")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-client", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.3")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-client-5.5", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.3")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-common", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.3")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-server", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.3")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-server-5.5", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.3")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-server-core-5.5", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.3")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-source-5.5", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.3")) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"mysql-testsuite-5.5", ver:"5.5.35+dfsg-0+wheezy1", rls:"DEB7.3")) != NULL) {
    report += res;
}

if (report != "") {
    security_message(data:report);
} else if (__pkg_match) {
    exit(99); # Not vulnerable.
}
