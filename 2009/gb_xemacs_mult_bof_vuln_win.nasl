###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_xemacs_mult_bof_vuln_win.nasl 9350 2018-04-06 07:03:33Z cfischer $
#
# XEmacs Multiple Buffer Overflow Vulnerabilities (Windows)
#
# Authors:
# Nikita MR <rnikita@secpod.com>
#
# Copyright:
# Copyright (c) 2009 Greenbone Networks GmbH, http://www.greenbone.net
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

tag_impact = "Attackers can exploit this issue to execute arbitrary code in the
context of affected application, and can cause denial of service.

Impact Level: Application";

tag_affected = "XEmacs version 21.4.22 and prior on Windows.";

tag_insight = "Error exists when 'tiff_instantiate' function processing a
crafted TIFF file, 'png_instantiate' function processing a crafted PNG file,
'jpeg_instantiate' function processing a crafted JPEG file in the
glyphs-eimage.c script that can be exploited to cause a heap-based buffer
overflow.";

tag_solution = "No solution or patch was made available for at least one year
since disclosure of this vulnerability. Likely none will be provided anymore.
General solution options are to upgrade to a newer release, disable respective
features, remove the product or replace the product by another one.";

tag_summary = "The host is installed with XEmacs and is prone to multiple
Buffer Overflow vulnerabilities.";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.800927");
  script_version("$Revision: 9350 $");
  script_tag(name:"last_modification", value:"$Date: 2018-04-06 09:03:33 +0200 (Fri, 06 Apr 2018) $");
  script_tag(name:"creation_date", value:"2009-08-11 07:36:16 +0200 (Tue, 11 Aug 2009)");
  script_tag(name:"cvss_base", value:"10.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:C/I:C/A:C");
  script_cve_id("CVE-2009-2688");
  script_bugtraq_id(35473);
  script_name("XEmacs Multiple Buffer Overflow Vulnerabilities (Windows)");
  script_xref(name : "URL" , value : "http://secunia.com/advisories/35348");
  script_xref(name : "URL" , value : "http://www.vupen.com/english/advisories/2009/1666");

  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2009 Greenbone Networks GmbH");
  script_family("Buffer overflow");
  script_dependencies("gb_xemacs_detect_win.nasl");
  script_require_keys("XEmacs/Win/Ver");
  script_tag(name : "impact" , value : tag_impact);
  script_tag(name : "affected" , value : tag_affected);
  script_tag(name : "insight" , value : tag_insight);
  script_tag(name : "solution" , value : tag_solution);
  script_tag(name : "summary" , value : tag_summary);
  script_tag(name:"qod_type", value:"registry");
  script_tag(name:"solution_type", value:"WillNotFix");
  exit(0);
}


include("version_func.inc");

xemacsVer = get_kb_item("XEmacs/Win/Ver");

if(xemacsVer == NULL){
  exit(0);
}

if(version_is_less_equal(version:xemacsVer, test_version:"21.4.22")){
  security_message(0);
}
