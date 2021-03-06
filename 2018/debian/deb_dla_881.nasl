###############################################################################
# OpenVAS Vulnerability Test
# $Id: deb_dla_881.nasl 9250 2018-03-29 05:55:29Z cfischer $
#
# Auto-generated from advisory DLA 881-1 using nvtgen 1.0
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
  script_oid("1.3.6.1.4.1.25623.1.0.890881");
  script_version("$Revision: 9250 $");
  script_cve_id("CVE-2014-8760");
  script_name("Debian LTS Advisory ([SECURITY] [DLA 881-1] ejabberd security update)");
  script_tag(name:"last_modification", value:"$Date: 2018-03-29 07:55:29 +0200 (Thu, 29 Mar 2018) $");
  script_tag(name:"creation_date", value:"2018-01-17 00:00:00 +0100 (Wed, 17 Jan 2018)");
  script_tag(name:"cvss_base", value:"5.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:P/I:N/A:N");
  script_tag(name:"solution_type", value:"VendorFix");
  script_tag(name:"qod_type", value:"package");

  script_xref(name:"URL", value:"https://lists.debian.org/debian-lts-announce/2017/04/msg00000.html");

  script_category(ACT_GATHER_INFO);

  script_copyright("Copyright (c) 2018 Greenbone Networks GmbH http://greenbone.net");
  script_family("Debian Local Security Checks");
  script_dependencies("gather-package-list.nasl");
  script_mandatory_keys("ssh/login/debian_linux", "ssh/login/packages");
  script_tag(name:"affected", value:"ejabberd on Debian Linux");
  script_tag(name:"insight", value:"ejabberd is a distributed, fault-tolerant Jabber/XMPP server written in Erlang.
Its features contain:

- XMPP-compliant
- Web based administration
- Load balancing: can run in a cluster of machines
- Fault-tolerance: database can be replicated and stored on multiple
nodes (nodes can be added or replaced 'on the fly')
- Virtual hosting: several virtual domains can be served using single ejabberd
instance
- SSL/TLS support
- Multi-User Chat (MUC/conference)
- IRC transport
- Jabber Users Directory, based on users vCards
- Service Discovery
- Shared roster");
  script_tag(name:"solution", value:"For Debian 7 'Wheezy', this problem has been fixed in version
2.1.10-4+deb7u2.

This update also disables the insecure SSLv3.

We recommend that you upgrade your ejabberd packages.");
  script_tag(name:"summary",  value:"It was found that ejabberd does not enforce the starttls_required
setting when compression is used, which causes clients to establish
connections without encryption.");
  script_tag(name:"vuldetect", value:"This check tests the installed software version using the apt package manager.");

  exit(0);
}

include("revisions-lib.inc");
include("pkg-lib-deb.inc");

res = "";
report = "";
if ((res = isdpkgvuln(pkg:"ejabberd", ver:"2.1.10-4+deb7u2", rls_regex:"DEB7\.[0-9]+", remove_arch:TRUE )) != NULL) {
    report += res;
}

if (report != "") {
  security_message(data:report);
} else if (__pkg_match) {
  exit(99); # Not vulnerable.
}
