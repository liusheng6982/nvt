###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_mozilla_firefox_mult_vuln_win_jul11.nasl 9351 2018-04-06 07:05:43Z cfischer $
#
# Mozilla Firefox Multiple Vulnerabilities July-11 (Windows)
#
# Authors:
# Sooraj KS <kssooraj@secpod.com>
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
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
###############################################################################

tag_impact = "Successful exploitation allows remote attackers to disclose potentially
  sensitive information, conduct cross-site scripting attacks, and compromise
  a user's system.
  Impact Level: System/Application";
tag_affected = "Mozilla Firefox versions 4.x through 4.0.1";
tag_insight = "- An error within WebGL allows remote attackers to obtain screenshots of the
    windows of arbitrary desktop applications via vectors involving an SVG
    filter, an IFRAME element, and uninitialized data in graphics memory.
  - An error within WebGL when reading certain data can be exploited to
    disclose GPU memory contents used by other processes.
  - An error within WebGL can be exploited to execute arbitrary code or
    cause a denial of service.
  - Input passed via HTML-encoded entities is not properly decoded before
    being displayed inside SVG elements, which allows remote attackers to
    inject arbitrary web script or HTML.";
tag_solution = "Upgrade to Firefox version 5.0 or later
  http://www.mozilla.com/en-US/firefox/all.html";
tag_summary = "The host is installed with Mozilla Firefox and is prone to multiple
  vulnerabilities.";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.802212");
  script_version("$Revision: 9351 $");
  script_tag(name:"last_modification", value:"$Date: 2018-04-06 09:05:43 +0200 (Fri, 06 Apr 2018) $");
  script_tag(name:"creation_date", value:"2011-07-07 15:43:33 +0200 (Thu, 07 Jul 2011)");
  script_cve_id("CVE-2011-2598", "CVE-2011-2367", "CVE-2011-2368", "CVE-2011-2369");
  script_bugtraq_id(48319, 48371, 48375, 48379);
  script_tag(name:"cvss_base", value:"10.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:C/I:C/A:C");
  script_name("Mozilla Firefox Multiple Vulnerabilities July-11 (Windows)");
  script_xref(name : "URL" , value : "http://secunia.com/advisories/44972/");
  script_xref(name : "URL" , value : "http://www.contextis.com/resources/blog/webgl2/");
  script_xref(name : "URL" , value : "http://blog.mozilla.com/security/2011/06/16/webgl-graphics-memory-stealing-issue/");

  script_tag(name:"qod_type", value:"executable_version");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (c) 2011 Greenbone Networks GmbH");
  script_family("General");
  script_dependencies("gb_firefox_detect_win.nasl");
  script_require_keys("Firefox/Win/Ver");
  script_tag(name : "impact" , value : tag_impact);
  script_tag(name : "affected" , value : tag_affected);
  script_tag(name : "insight" , value : tag_insight);
  script_tag(name : "solution" , value : tag_solution);
  script_tag(name : "summary" , value : tag_summary);
  exit(0);
}


include("version_func.inc");

## Firefox Check
ffVer = get_kb_item("Firefox/Win/Ver");
if(ffVer)
{
  ## Grep for Firefox versions 4.x through 4.0.1
  if(version_in_range(version:ffVer, test_version:"4.0", test_version2:"4.0.1") ||
    version_in_range(version:ffVer, test_version:"4.0.b1", test_version2:"4.0.b12")){
    security_message(0);
  }
}
