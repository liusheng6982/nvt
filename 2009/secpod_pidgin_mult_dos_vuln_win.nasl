###############################################################################
# OpenVAS Vulnerabilities Test
# $Id: secpod_pidgin_mult_dos_vuln_win.nasl 9350 2018-04-06 07:03:33Z cfischer $
#
# Pidgin Multiple Denial Of Service Vulnerabilities (Windows)
#
# Authors:
# Nikita MR <rnikita@secpod.com>
#
# Copyright:
# Copyright (c) 2009 SecPod, http://www.secpod.com
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# (or any later version), as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
###############################################################################

tag_summary = "This host has Pidgin installed and is prone to multiple Denial of
  Service vulnerabilities.

  Vulnerabilities Insight:
  - An error in libpurple/protocols/irc/msgs.c in the IRC protocol plugin in
    libpurple can trigger a NULL-pointer dereference when processing TOPIC
    messages which lack a topic string.
  - An error in the 'msn_slp_sip_recv' function in libpurple/protocols/msn/slp.c
    in the MSN protocol can trigger a NULL-pointer dereference via an SLP invite
    message missing expected fields.
  - An error in the 'msn_slp_process_msg' function in libpurple/protocols/msn/
    slpcall.c in the MSN protocol when converting the encoding of a handwritten
    message can be exploited by improper utilisation of uninitialised variables.
  - An error in the XMPP protocol plugin in libpurple is fails to handle an
    error IQ stanza during an attempted fetch of a custom smiley is processed
    via XHTML-IM content with cid: images.";

tag_impact = "Attackers can exploit this issue to execute arbitrary code, corrupt memory
  and cause the application to crash.
  Impact Level: System/Application";
tag_affected = "Pidgin version prior to 2.6.2 on Windows.";
tag_solution = "Upgrade to Pidgin version 2.6.2
  http://pidgin.im/download";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.900940");
  script_version("$Revision: 9350 $");
  script_tag(name:"last_modification", value:"$Date: 2018-04-06 09:03:33 +0200 (Fri, 06 Apr 2018) $");
  script_tag(name:"creation_date", value:"2009-09-15 09:32:43 +0200 (Tue, 15 Sep 2009)");
  script_tag(name:"cvss_base", value:"5.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:N/I:N/A:P");
  script_cve_id("CVE-2009-2703", "CVE-2009-3083", "CVE-2009-3084",
                "CVE-2009-3085");
  script_bugtraq_id(36277);
  script_name("Pidgin Multiple Denial Of Service Vulnerabilities (Windows)");
  script_xref(name : "URL" , value : "http://secunia.com/advisories/36601");
  script_xref(name : "URL" , value : "http://developer.pidgin.im/ticket/10159");
  script_xref(name : "URL" , value : "http://www.pidgin.im/news/security/?id=37");
  script_xref(name : "URL" , value : "http://www.pidgin.im/news/security/?id=38");
  script_xref(name : "URL" , value : "http://www.pidgin.im/news/security/?id=39");
  script_xref(name : "URL" , value : "http://www.pidgin.im/news/security/?id=40");

  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2009 SecPod");
  script_family("Denial of Service");
  script_dependencies("secpod_pidgin_detect_win.nasl");
  script_require_keys("Pidgin/Win/Ver");
  script_tag(name : "impact" , value : tag_impact);
  script_tag(name : "affected" , value : tag_affected);
  script_tag(name : "solution" , value : tag_solution);
  script_tag(name : "summary" , value : tag_summary);
  script_tag(name:"qod_type", value:"registry");
  script_tag(name:"solution_type", value:"VendorFix");
  exit(0);
}


include("version_func.inc");

pidginVer = get_kb_item("Pidgin/Win/Ver");

if(pidginVer != NULL)
{
  if(version_is_less(version:pidginVer, test_version:"2.6.2")){
    security_message(0);
  }
}
