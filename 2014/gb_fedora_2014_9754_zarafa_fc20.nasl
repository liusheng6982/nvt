###############################################################################
# OpenVAS Vulnerability Test
#
# Fedora Update for zarafa FEDORA-2014-9754
#
# Authors:
# System Generated Check
#
# Copyright:
# Copyright (C) 2014 Greenbone Networks GmbH, http://www.greenbone.net
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

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.868143");
  script_version("$Revision: 9594 $");
  script_tag(name:"last_modification", value:"$Date: 2018-04-25 04:13:41 +0200 (Wed, 25 Apr 2018) $");
  script_tag(name:"creation_date", value:"2014-08-31 05:52:21 +0200 (Sun, 31 Aug 2014)");
  script_cve_id("CVE-2014-5447", "CVE-2014-5448", "CVE-2014-5449", "CVE-2014-5450");
  script_tag(name:"cvss_base", value:"2.1");
  script_tag(name:"cvss_base_vector", value:"AV:L/AC:L/Au:N/C:P/I:N/A:N");
  script_name("Fedora Update for zarafa FEDORA-2014-9754");

  tag_insight = "The Zarafa Collaboration Platform is a Microsoft Exchange replacement. The
Open Source Collaboration provides an integration with your existing Linux
mail server, native mobile phone support by ActiveSync compatibility and a
webaccess with 'Look &amp  Feel' similar to Outlook using Ajax. Including an
IMAP and a POP3 gateway as well as an iCal/CalDAV gateway, the Zarafa Open
Source Collaboration can combine the usability with the stability and the
flexibility of a Linux server.

The proven Zarafa groupware solution is using MAPI objects, provides a MAPI
client library as well as programming interfaces for C++, PHP and Python.
The other Zarafa related packages need to be installed to gain all features
and benefits of the Zarafa Collaboration Platform (ZCP).
";

  tag_affected = "zarafa on Fedora 20";

  tag_solution = "Please Install the Updated Packages.";


  script_tag(name : "affected" , value : tag_affected);
  script_tag(name : "insight" , value : tag_insight);
  script_tag(name : "solution" , value : tag_solution);
  script_tag(name:"qod_type", value:"package");
  script_tag(name:"solution_type", value:"VendorFix");
  script_xref(name: "FEDORA", value: "2014-9754");
  script_xref(name: "URL" , value: "https://lists.fedoraproject.org/pipermail/package-announce/2014-August/137158.html");
  script_tag(name:"summary", value:"Check for the Version of zarafa");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2014 Greenbone Networks GmbH");
  script_family("Fedora Local Security Checks");
  script_dependencies("gather-package-list.nasl");
  script_mandatory_keys("ssh/login/fedora", "ssh/login/rpms");
  exit(0);
}


include("pkg-lib-rpm.inc");

release = get_kb_item("ssh/login/release");

res = "";
if(release == NULL){
  exit(0);
}

if(release == "FC20")
{

  if ((res = isrpmvuln(pkg:"zarafa", rpm:"zarafa~7.1.10~4.fc20", rls:"FC20")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if (__pkg_match) exit(99); # Not vulnerable.
  exit(0);
}