###############################################################################
# OpenVAS Vulnerability Test
#
# Fedora Update for pcsc-lite FEDORA-2011-0164
#
# Authors:
# System Generated Check
#
# Copyright:
# Copyright (c) 2011 Greenbone Networks GmbH, http://www.greenbone.net
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
tag_affected = "pcsc-lite on Fedora 14";
tag_insight = "The purpose of PC/SC Lite is to provide a Windows(R) SCard interface
  in a very small form factor for communicating to smartcards and
  readers.  PC/SC Lite uses the same winscard API as used under
  Windows(R).  This package includes the PC/SC Lite daemon, a resource
  manager that coordinates communications with smart card readers and
  smart cards that are connected to the system, as well as other command
  line tools.";
tag_solution = "Please Install the Updated Packages.";


if(description)
{
  script_xref(name : "URL" , value : "http://lists.fedoraproject.org/pipermail/package-announce/2011-January/053079.html");
  script_oid("1.3.6.1.4.1.25623.1.0.862787");
  script_version("$Revision: 9371 $");
  script_tag(name:"last_modification", value:"$Date: 2018-04-06 10:55:06 +0200 (Fri, 06 Apr 2018) $");
  script_tag(name:"creation_date", value:"2011-01-14 16:07:43 +0100 (Fri, 14 Jan 2011)");
  script_xref(name: "FEDORA", value: "2011-0164");
  script_tag(name:"cvss_base", value:"4.4");
  script_tag(name:"cvss_base_vector", value:"AV:L/AC:M/Au:N/C:P/I:P/A:P");
  script_cve_id("CVE-2010-4531");
  script_name("Fedora Update for pcsc-lite FEDORA-2011-0164");

  script_tag(name:"summary", value:"Check for the Version of pcsc-lite");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (c) 2011 Greenbone Networks GmbH");
  script_family("Fedora Local Security Checks");
  script_dependencies("gather-package-list.nasl");
  script_mandatory_keys("ssh/login/fedora", "ssh/login/rpms");
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

if(release == "FC14")
{

  if ((res = isrpmvuln(pkg:"pcsc-lite", rpm:"pcsc-lite~1.6.4~3.fc14", rls:"FC14")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if (__pkg_match) exit(99); # Not vulnerable.
  exit(0);
}
