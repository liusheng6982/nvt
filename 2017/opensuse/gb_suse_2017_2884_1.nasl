###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_suse_2017_2884_1.nasl 8049 2017-12-08 09:11:55Z santu $
#
# SuSE Update for wget openSUSE-SU-2017:2884-1 (wget)
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
  script_oid("1.3.6.1.4.1.25623.1.0.851637");
  script_version("$Revision: 8049 $");
  script_tag(name:"last_modification", value:"$Date: 2017-12-08 10:11:55 +0100 (Fri, 08 Dec 2017) $");
  script_tag(name:"creation_date", value:"2017-10-30 09:25:34 +0100 (Mon, 30 Oct 2017)");
  script_cve_id("CVE-2017-13089", "CVE-2017-13090");
  script_tag(name:"cvss_base", value:"9.3");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:C/I:C/A:C");
  script_tag(name:"qod_type", value:"package");
  script_name("SuSE Update for wget openSUSE-SU-2017:2884-1 (wget)");
  script_tag(name: "summary", value: "Check the version of wget");
  script_tag(name: "vuldetect", value: "Get the installed version with the help 
of detect NVT and check if the version is vulnerable or not.");
  script_tag(name: "insight", value: "
  This update for wget fixes the following security issues:

  - CVE-2017-13089,CVE-2017-13090: Missing checks for negative
  remaining_chunk_size in skip_short_body and fd_read_body could cause
  stack buffer overflows, which could have been exploited by malicious
  servers. (bsc#1064715,bsc#1064716)

  This update was imported from the SUSE:SLE-12:Update update project.");
  script_tag(name: "affected", value: "wget on openSUSE Leap 42.3, openSUSE Leap 42.2");
  script_tag(name: "solution", value: "Please Install the Updated Packages.");

  script_xref(name: "openSUSE-SU", value: "2017:2884_1");
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

if(release == "openSUSELeap42.2")
{

  if ((res = isrpmvuln(pkg:"wget", rpm:"wget~1.14~8.6.1", rls:"openSUSELeap42.2")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"wget-debuginfo", rpm:"wget-debuginfo~1.14~8.6.1", rls:"openSUSELeap42.2")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"wget-debugsource", rpm:"wget-debugsource~1.14~8.6.1", rls:"openSUSELeap42.2")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if (__pkg_match) exit(99); # Not vulnerable.
  exit(0);
}


if(release == "openSUSELeap42.3")
{

  if ((res = isrpmvuln(pkg:"wget", rpm:"wget~1.14~12.1", rls:"openSUSELeap42.3")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"wget-debuginfo", rpm:"wget-debuginfo~1.14~12.1", rls:"openSUSELeap42.3")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"wget-debugsource", rpm:"wget-debugsource~1.14~12.1", rls:"openSUSELeap42.3")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if (__pkg_match) exit(99); # Not vulnerable.
  exit(0);
}
