###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_fedora_2018_57fbdb1cb5_roundcubemail_fc27.nasl 9581 2018-04-24 09:03:17Z santu $
#
# Fedora Update for roundcubemail FEDORA-2018-57fbdb1cb5
#
# Authors:
# System Generated Check
#
# Copyright:
# Copyright (C) 2018 Greenbone Networks GmbH, http://www.greenbone.net
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
  script_oid("1.3.6.1.4.1.25623.1.0.874377");
  script_version("$Revision: 9581 $");
  script_tag(name:"last_modification", value:"$Date: 2018-04-24 11:03:17 +0200 (Tue, 24 Apr 2018) $");
  script_tag(name:"creation_date", value:"2018-04-21 09:10:40 +0200 (Sat, 21 Apr 2018)");
  script_cve_id("CVE-2018-9846");
  script_tag(name:"cvss_base", value:"10.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:C/I:C/A:C");
  script_tag(name:"qod_type", value:"package");
  script_name("Fedora Update for roundcubemail FEDORA-2018-57fbdb1cb5");
  script_tag(name: "summary", value: "Check the version of roundcubemail");
  script_tag(name: "vuldetect", value: "Get the installed version with the help 
of detect NVT and check if the version is vulnerable or not.");
  script_tag(name: "insight", value: "RoundCube Webmail is a browser-based 
multilingual IMAP client with an application-like user interface. It provides 
full functionality you expect from an e-mail client, including MIME support, 
address book, folder manipulation, message searching and spell checking. 
RoundCube Webmail is written in PHP and requires a database: MySQL, PostgreSQL 
and SQLite are known to work. The user interface is fully skinnable using XHTML 
and CSS 2.
");
  script_tag(name: "affected", value: "roundcubemail on Fedora 27");
  script_tag(name: "solution", value: "Please Install the Updated Packages.");

  script_xref(name: "FEDORA", value: "2018-57fbdb1cb5");
  script_xref(name: "URL" , value: "https://lists.fedoraproject.org/archives/list/package-announce%40lists.fedoraproject.org/message/Z5Z2OC2XYT33AXQAC6NBFEM5PJNFVZRR");
  script_tag(name:"solution_type", value:"VendorFix");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2018 Greenbone Networks GmbH");
  script_family("Fedora Local Security Checks");
  script_dependencies("gather-package-list.nasl");
  script_mandatory_keys("ssh/login/fedora", "ssh/login/rpms");
  exit(0);
}

include("revisions-lib.inc");
include("pkg-lib-rpm.inc");

release = get_kb_item("ssh/login/release");

res = "";
if(release == NULL){
  exit(0);
}

if(release == "FC27")
{

  if ((res = isrpmvuln(pkg:"roundcubemail", rpm:"roundcubemail~1.3.6~1.fc27", rls:"FC27")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if (__pkg_match) exit(99); # Not vulnerable.
  exit(0);
}
