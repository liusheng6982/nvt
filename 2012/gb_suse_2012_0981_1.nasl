###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_suse_2012_0981_1.nasl 9352 2018-04-06 07:13:02Z cfischer $
#
# SuSE Update for icedtea-web openSUSE-SU-2012:0981-1 (icedtea-web)
#
# Authors:
# System Generated Check
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
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
###############################################################################

include("revisions-lib.inc");
tag_affected = "icedtea-web on openSUSE 12.1, openSUSE 11.4";
tag_insight = "- update to 1.2.1 (bnc#773458)
  - Security Updates
  * CVE-2012-3422, RH840592: Potential read from an
  uninitialized memory location
  * CVE-2012-3423, RH841345: Incorrect handling of not
  0-terminated strings
  - NetX
  * PR898: signed applications with big jnlp-file doesn't
  start (webstart affect like &quot;frozen&quot;)
  * PR811: javaws is not handling urls with spaces (and
  other characters needing encoding) correctly
  * 816592: icedtea-web not loading GeoGebra java applets
  in Firefox or Chrome
  - Plugin
  * PR863: Error passing strings to applet methods in
  Chromium
  * PR895: IcedTea-Web searches for missing classes on each
  loadClass or findClass
  * PR518: NPString.utf8characters not guaranteed to be
  nul-terminated
  - Common
  * RH838417: Disambiguate signed applet security prompt
  from certificate warning
  * RH838559: Disambiguate signed applet security prompt
  from certificate warning";
tag_solution = "Please Install the Updated Packages.";



if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.850308");
  script_version("$Revision: 9352 $");
  script_tag(name:"last_modification", value:"$Date: 2018-04-06 09:13:02 +0200 (Fri, 06 Apr 2018) $");
  script_tag(name:"creation_date", value:"2012-12-13 17:01:37 +0530 (Thu, 13 Dec 2012)");
  script_cve_id("CVE-2012-3422", "CVE-2012-3423");
  script_tag(name:"cvss_base", value:"7.5");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:P/I:P/A:P");
  script_xref(name: "openSUSE-SU", value: "2012:0981_1");
  script_name("SuSE Update for icedtea-web openSUSE-SU-2012:0981-1 (icedtea-web)");

  script_tag(name: "summary" , value: "Check for the Version of icedtea-web");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (c) 2012 Greenbone Networks GmbH");
  script_family("SuSE Local Security Checks");
  script_dependencies("gather-package-list.nasl");
  script_mandatory_keys("ssh/login/suse", "ssh/login/rpms");
  script_tag(name : "affected" , value : tag_affected);
  script_tag(name : "insight" , value : tag_insight);
  script_tag(name : "solution" , value : tag_solution);
  script_tag(name:"qod_type", value:"package");
  script_tag(name:"solution_type", value:"VendorFix");
  exit(0);
}


include("pkg-lib-rpm.inc");

release = get_kb_item("ssh/login/release");

res = "";
if(release == NULL){
  exit(0);
}

if(release == "openSUSE11.4")
{

  if ((res = isrpmvuln(pkg:"icedtea-web", rpm:"icedtea-web~1.2.1~0.13.1", rls:"openSUSE11.4")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"icedtea-web-debuginfo", rpm:"icedtea-web-debuginfo~1.2.1~0.13.1", rls:"openSUSE11.4")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"icedtea-web-debugsource", rpm:"icedtea-web-debugsource~1.2.1~0.13.1", rls:"openSUSE11.4")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"icedtea-web-javadoc", rpm:"icedtea-web-javadoc~1.2.1~0.13.1", rls:"openSUSE11.4")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if (__pkg_match) exit(99); # Not vulnerable.
  exit(0);
}


if(release == "openSUSE12.1")
{

  if ((res = isrpmvuln(pkg:"icedtea-web", rpm:"icedtea-web~1.2.1~6.1", rls:"openSUSE12.1")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"icedtea-web-debuginfo", rpm:"icedtea-web-debuginfo~1.2.1~6.1", rls:"openSUSE12.1")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"icedtea-web-debugsource", rpm:"icedtea-web-debugsource~1.2.1~6.1", rls:"openSUSE12.1")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if ((res = isrpmvuln(pkg:"icedtea-web-javadoc", rpm:"icedtea-web-javadoc~1.2.1~6.1", rls:"openSUSE12.1")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if (__pkg_match) exit(99); # Not vulnerable.
  exit(0);
}