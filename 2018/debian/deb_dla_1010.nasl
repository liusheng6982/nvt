###############################################################################
# OpenVAS Vulnerability Test
# $Id: deb_dla_1010.nasl 9250 2018-03-29 05:55:29Z cfischer $
#
# Auto-generated from advisory DLA 1010-1 using nvtgen 1.0
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
  script_oid("1.3.6.1.4.1.25623.1.0.891010");
  script_version("$Revision: 9250 $");
  script_cve_id("CVE-2014-9638", "CVE-2014-9639", "CVE-2014-9640", "CVE-2015-6749");
  script_name("Debian LTS Advisory ([SECURITY] [DLA 1010-1] vorbis-tools security update)");
  script_tag(name:"last_modification", value:"$Date: 2018-03-29 07:55:29 +0200 (Thu, 29 Mar 2018) $");
  script_tag(name:"creation_date", value:"2018-02-05 00:00:00 +0100 (Mon, 05 Feb 2018)");
  script_tag(name:"cvss_base", value:"5.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:N/I:N/A:P");
  script_tag(name:"solution_type", value:"VendorFix");
  script_tag(name:"qod_type", value:"package");

  script_xref(name:"URL", value:"https://lists.debian.org/debian-lts-announce/2017/07/msg00002.html");

  script_category(ACT_GATHER_INFO);

  script_copyright("Copyright (c) 2018 Greenbone Networks GmbH http://greenbone.net");
  script_family("Debian Local Security Checks");
  script_dependencies("gather-package-list.nasl");
  script_mandatory_keys("ssh/login/debian_linux", "ssh/login/packages");
  script_tag(name:"affected", value:"vorbis-tools on Debian Linux");
  script_tag(name:"insight", value:"vorbis-tools contains oggenc (an encoder), ogg123 (a playback tool),
ogginfo (displays ogg information), oggdec (decodes ogg files), vcut
(ogg file splitter), and vorbiscomment (ogg comment editor).");
  script_tag(name:"solution", value:"For Debian 7 'Wheezy', these problems have been fixed in version
1.4.0-1+deb7u1.

We recommend that you upgrade your vorbis-tools packages.");
  script_tag(name:"summary",  value:"vorbis-tools is vulnerable to multiple issues that can result in denial
of service.

CVE-2014-9638

Divide by zero error in oggenc with a WAV file whose number of
channels is set to zero.

CVE-2014-9639

Integer overflow in oggenc via a crafted number of channels in a WAV
file, which triggers an out-of-bounds memory access.

CVE-2014-9640

Out-of bounds read in oggenc via a crafted raw file.

CVE-2015-6749

Buffer overflow in the aiff_open function in oggenc/audio.c
via a crafted AIFF file.");
  script_tag(name:"vuldetect", value:"This check tests the installed software version using the apt package manager.");

  exit(0);
}

include("revisions-lib.inc");
include("pkg-lib-deb.inc");

res = "";
report = "";
if ((res = isdpkgvuln(pkg:"vorbis-tools", ver:"1.4.0-1+deb7u1", rls_regex:"DEB7\.[0-9]+", remove_arch:TRUE )) != NULL) {
    report += res;
}
if ((res = isdpkgvuln(pkg:"vorbis-tools-dbg", ver:"1.4.0-1+deb7u1", rls_regex:"DEB7\.[0-9]+", remove_arch:TRUE )) != NULL) {
    report += res;
}

if (report != "") {
  security_message(data:report);
} else if (__pkg_match) {
  exit(99); # Not vulnerable.
}
