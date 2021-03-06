###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_suse_2017_0298_1.nasl 8048 2017-12-08 09:05:48Z santu $
#
# SuSE Update for gstreamer-0_10-plugins-good openSUSE-SU-2017:0298-1 (gstreamer-0_10-plugins-good)
#
# Authors:
# System Generated Check
#
# Copyright:
# Copyright (C) 2017 Greenbone Networks GmbH, http://www.greenbone.net
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# (or any later version), as published by the Free Software Foundation.
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
  script_oid("1.3.6.1.4.1.25623.1.0.851481");
  script_version("$Revision: 8048 $");
  script_tag(name:"last_modification", value:"$Date: 2017-12-08 10:05:48 +0100 (Fri, 08 Dec 2017) $");
  script_tag(name:"creation_date", value:"2017-02-03 12:11:01 +0530 (Fri, 03 Feb 2017)");
  script_cve_id("CVE-2016-9634", "CVE-2016-9635", "CVE-2016-9636", "CVE-2016-9807", 
                "CVE-2016-9808", "CVE-2016-9810");
  script_tag(name:"cvss_base", value:"7.5");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:P/I:P/A:P");
  script_tag(name:"qod_type", value:"package");
  script_name("SuSE Update for gstreamer-0_10-plugins-good openSUSE-SU-2017:0298-1 (gstreamer-0_10-plugins-good)");
  script_tag(name: "summary", value: "Check the version of gstreamer-0_10-plugins-good");
  script_tag(name: "vuldetect", value: "Get the installed version with the help 
of detect NVT and check if the version is vulnerable or not.");
  script_tag(name: "insight", value: "
  This update for gstreamer-0_10-plugins-good fixes the following issues:

  - CVE-2016-9634: Invalid FLIC files could have caused and an out-of-bounds
  write (bsc#1012102)
  - CVE-2016-9635: Invalid FLIC files could have caused and an out-of-bounds
  write (bsc#1012103)
  - CVE-2016-9636: Prevent maliciously crafted flic files from causing
  invalid memory writes (bsc#1012104)
  - CVE-2016-9807: Prevent the reading of invalid memory in
  flx_decode_chunks, leading to DoS (bsc#1013655)
  - CVE-2016-9808: Prevent maliciously crafted flic files from causing
  invalid memory accesses (bsc#1013653)
  - CVE-2016-9810: Invalid files can be used to extraneous unreferences,
  leading to invalid memory access and DoS (bsc#1013663)");
  script_tag(name: "affected", value: "gstreamer-0_10-plugins-good on openSUSE Leap 42.1");
  script_tag(name: "solution", value: "Please Install the Updated Packages.");

  script_xref(name: "openSUSE-SU", value: "2017:0298_1");
  script_tag(name:"solution_type", value:"VendorFix");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2017 Greenbone Networks GmbH");
  script_family("SuSE Local Security Checks");
  script_dependencies("gather-package-list.nasl");
  script_mandatory_keys("ssh/login/suse", "ssh/login/rpms");
  exit(0);
}

include("revisions-lib.inc");
include("pkg-lib-rpm.inc");

release = get_kb_item("ssh/login/release");

res = "";
if(release == NULL){
  exit(0);
}

if(release == "openSUSELeap42.1")
{

  if ((res = isrpmvuln(pkg:"gstreamer-0_10-plugin-esd", rpm:"gstreamer-0_10-plugin-esd~0.10.31~16.1", rls:"openSUSELeap42.1")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"gstreamer-0_10-plugin-esd-debuginfo", rpm:"gstreamer-0_10-plugin-esd-debuginfo~0.10.31~16.1", rls:"openSUSELeap42.1")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"gstreamer-0_10-plugins-good", rpm:"gstreamer-0_10-plugins-good~0.10.31~16.1", rls:"openSUSELeap42.1")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"gstreamer-0_10-plugins-good-debuginfo", rpm:"gstreamer-0_10-plugins-good-debuginfo~0.10.31~16.1", rls:"openSUSELeap42.1")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"gstreamer-0_10-plugins-good-debugsource", rpm:"gstreamer-0_10-plugins-good-debugsource~0.10.31~16.1", rls:"openSUSELeap42.1")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"gstreamer-0_10-plugins-good-doc", rpm:"gstreamer-0_10-plugins-good-doc~0.10.31~16.1", rls:"openSUSELeap42.1")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"gstreamer-0_10-plugins-good-extra", rpm:"gstreamer-0_10-plugins-good-extra~0.10.31~16.1", rls:"openSUSELeap42.1")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"gstreamer-0_10-plugins-good-extra-debuginfo", rpm:"gstreamer-0_10-plugins-good-extra-debuginfo~0.10.31~16.1", rls:"openSUSELeap42.1")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"gstreamer-0_10-plugins-good-lang", rpm:"gstreamer-0_10-plugins-good-lang~0.10.31~16.1", rls:"openSUSELeap42.1")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"gstreamer-0_10-plugin-esd-32bit", rpm:"gstreamer-0_10-plugin-esd-32bit~0.10.31~16.1", rls:"openSUSELeap42.1")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"gstreamer-0_10-plugin-esd-debuginfo-32bit", rpm:"gstreamer-0_10-plugin-esd-debuginfo-32bit~0.10.31~16.1", rls:"openSUSELeap42.1")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"gstreamer-0_10-plugins-good-32bit", rpm:"gstreamer-0_10-plugins-good-32bit~0.10.31~16.1", rls:"openSUSELeap42.1")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"gstreamer-0_10-plugins-good-debuginfo-32bit", rpm:"gstreamer-0_10-plugins-good-debuginfo-32bit~0.10.31~16.1", rls:"openSUSELeap42.1")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"gstreamer-0_10-plugins-good-extra-32bit", rpm:"gstreamer-0_10-plugins-good-extra-32bit~0.10.31~16.1", rls:"openSUSELeap42.1")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"gstreamer-0_10-plugins-good-extra-debuginfo-32bit", rpm:"gstreamer-0_10-plugins-good-extra-debuginfo-32bit~0.10.31~16.1", rls:"openSUSELeap42.1")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if (__pkg_match) exit(99); # Not vulnerable.
  exit(0);
}
