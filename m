Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CD24BB35D
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Feb 2022 08:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiBRHc3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Feb 2022 02:32:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbiBRHc0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Feb 2022 02:32:26 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A78D2905B1;
        Thu, 17 Feb 2022 23:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645169528; x=1676705528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SCALdIr7wxcXgyYWV7+ctraSqir5D4Qsnffel822UHg=;
  b=nO82vu3Lj0y9dq6eDqIdcpwbYV2hCLGJrIxi7kGwIwRM0+L6tuVvBVSz
   9g/q7tx5X5A01qcKuixgVdVVy5jszZClM4n4RE4nRF9vJrZCtl9oXqFlp
   h4vgk3QyEggc8KMwCS2f/l8d61QxY5RGWQmUlab0bUY85lAF/ob4T7Ux4
   uQ/mydV/PJOsUYfaiiRgXvHJPLL6KOJyO+G5jpWnUwmL7KWylaKnI+Zbm
   Mak87z5lmHezDnNBZ8RR7/x6TkxFXuiDXvInqy6wUb3o2gZBfolOv1Jpo
   BJ3dKPNhD5yyr6mHFaccWxsdocLqKBZ01jo/2vYWgGN8qBCI5l0C+HxhT
   g==;
X-IronPort-AV: E=Sophos;i="5.88,378,1635177600"; 
   d="scan'208";a="193264916"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2022 15:32:07 +0800
IronPort-SDR: eoX5iwgmNi+aG9BErqfEVNxN82UdplqS5ZFBDHa+yUTDJVpN9iQbEg+BY2h45XNo/TfsPla4lb
 mr3hpYLq/3pjQiVmoGNWIXKBCOA7Dvc0OWEC/TRKgAXL4xL//ewYYzyA4gC2CYgEOQTBi6OQ5l
 J7qbjjTPCXNbgDx5XFBr2jjddcvnAmjDUgXYNhGtCIaNW8E74PvAfPf2QAKNondescTFlZr84R
 3BLau1g2cEvLnXqOBxNKpM8BANyYYaa8ECg0klxLKIntgG0plvy+xNQjS+pKANnBZxeStz3s5L
 P6BVMayOkm9567Y4n0BY3JMW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 23:04:53 -0800
IronPort-SDR: 9C/nd2ihRAMyO6kO4/oZ38LzoX/I7BpdsU8BgzZ9VYa7EDtc9ztQK1Q9kHcmvQdWkUUo9+bTid
 e5D1LeiaHGcScAiODJ55/mT8iLsaoW7UEX0DMj2fDN6jnIXXAkDDpOE8On0kW3yKm325Gb+awR
 3LAFj4mZy7JiVA/DdiKG0XucbdpoTjtzmYtyTBIUoBWtRVgNAwXcuatUr1mWVKgqmVyO3tc94W
 RzXh/I+mupgBbBgD7CLm0mSzXQZvP0YEc+c0jEnEt96pw3v+vR179jly2N7KA1J70DGWV2fFo4
 RVY=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Feb 2022 23:32:07 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v3 6/6] common: factor out xfs unique part from _filter_mkfs
Date:   Fri, 18 Feb 2022 16:31:56 +0900
Message-Id: <20220218073156.2179803-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218073156.2179803-1-shinichiro.kawasaki@wdc.com>
References: <20220218073156.2179803-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Most of the code in the function _filter_mkfs is xfs unique. This is
misleading that the function would be dedicated for xfs. Clean up the
function by factoring out xfs unique part to _xfs_filter_mkfs in
common/xfs. While at the same time, fix indent in _xfs_filter_mkfs to be
consistent with other functions in common/xfs.

Suggested-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 common/filter | 40 +---------------------------------------
 common/xfs    | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 39 deletions(-)

diff --git a/common/filter b/common/filter
index c3db7a56..257227c2 100644
--- a/common/filter
+++ b/common/filter
@@ -121,53 +121,15 @@ _filter_mkfs()
 {
     case $FSTYP in
     xfs)
+	_xfs_filter_mkfs "$@"
 	;;
     *)
 	cat - >/dev/null
 	perl -e 'print STDERR "dbsize=4096\nisize=256\n"'
 	return ;;
     esac
-
-    echo "_fs_has_crcs=0" >&2
-    set -
-    perl -ne '
-    if (/^meta-data=([\w,|\/.-]+)\s+isize=(\d+)\s+agcount=(\d+), agsize=(\d+) blks/) {
-	print STDERR "ddev=$1\nisize=$2\nagcount=$3\nagsize=$4\n";
-	print STDOUT "meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks\n";
-    }
-    if (/^\s+=\s+sectsz=(\d+)\s+attr=(\d+)/) {
-        print STDERR "sectsz=$1\nattr=$2\n";
-    }
-    if (/^\s+=\s+crc=(\d)/) {
-        print STDERR "_fs_has_crcs=$1\n";
-    }
-    if (/^data\s+=\s+bsize=(\d+)\s+blocks=(\d+), imaxpct=(\d+)/) {
-	print STDERR "dbsize=$1\ndblocks=$2\nimaxpct=$3\n";
-	print STDOUT "data     = bsize=XXX blocks=XXX, imaxpct=PCT\n";
-    }
-    if (/^\s+=\s+sunit=(\d+)\s+swidth=(\d+) blks/) {
-        print STDERR "sunit=$1\nswidth=$2\nunwritten=1\n";
-	print STDOUT "         = sunit=XXX swidth=XXX, unwritten=X\n";
-    }
-    if (/^naming\s+=version\s+(\d+)\s+bsize=(\d+)/) {
-	print STDERR "dirversion=$1\ndirbsize=$2\n";
-	print STDOUT "naming   =VERN bsize=XXX\n";
-    }
-    if (/^log\s+=(internal log|[\w|\/.-]+)\s+bsize=(\d+)\s+blocks=(\d+),\s+version=(\d+)/ ||
-	/^log\s+=(internal log|[\w|\/.-]+)\s+bsize=(\d+)\s+blocks=(\d+)/) {
-	print STDERR "ldev=\"$1\"\nlbsize=$2\nlblocks=$3\nlversion=$4\n";
-	print STDOUT "log      =LDEV bsize=XXX blocks=XXX\n";
-    }
-    if (/^\s+=\s+sectsz=(\d+)\s+sunit=(\d+) blks/) {
-	print STDERR "logsectsz=$1\nlogsunit=$2\n\n";
-    }
-    if (/^realtime\s+=([\w|\/.-]+)\s+extsz=(\d+)\s+blocks=(\d+), rtextents=(\d+)/) {
-	print STDERR "rtdev=$1\nrtextsz=$2\nrtblocks=$3\nrtextents=$4\n";
-	print STDOUT "realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX\n";
-    }'
 }
 
-
 # prints the bits we care about in growfs
 # 
 _filter_growfs()
diff --git a/common/xfs b/common/xfs
index 713e9fe7..053b6189 100644
--- a/common/xfs
+++ b/common/xfs
@@ -1275,3 +1275,44 @@ _require_scratch_xfs_bigtime()
 		_notrun "bigtime feature not advertised on mount?"
 	_scratch_unmount
 }
+
+_xfs_filter_mkfs()
+{
+	echo "_fs_has_crcs=0" >&2
+	set -
+	perl -ne '
+	if (/^meta-data=([\w,|\/.-]+)\s+isize=(\d+)\s+agcount=(\d+), agsize=(\d+) blks/) {
+		print STDERR "ddev=$1\nisize=$2\nagcount=$3\nagsize=$4\n";
+		print STDOUT "meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks\n";
+	}
+	if (/^\s+=\s+sectsz=(\d+)\s+attr=(\d+)/) {
+		print STDERR "sectsz=$1\nattr=$2\n";
+	}
+	if (/^\s+=\s+crc=(\d)/) {
+		print STDERR "_fs_has_crcs=$1\n";
+	}
+	if (/^data\s+=\s+bsize=(\d+)\s+blocks=(\d+), imaxpct=(\d+)/) {
+		print STDERR "dbsize=$1\ndblocks=$2\nimaxpct=$3\n";
+		print STDOUT "data     = bsize=XXX blocks=XXX, imaxpct=PCT\n";
+	}
+	if (/^\s+=\s+sunit=(\d+)\s+swidth=(\d+) blks/) {
+		print STDERR "sunit=$1\nswidth=$2\nunwritten=1\n";
+		print STDOUT "         = sunit=XXX swidth=XXX, unwritten=X\n";
+	}
+	if (/^naming\s+=version\s+(\d+)\s+bsize=(\d+)/) {
+		print STDERR "dirversion=$1\ndirbsize=$2\n";
+		print STDOUT "naming   =VERN bsize=XXX\n";
+	}
+	if (/^log\s+=(internal log|[\w|\/.-]+)\s+bsize=(\d+)\s+blocks=(\d+),\s+version=(\d+)/ ||
+		/^log\s+=(internal log|[\w|\/.-]+)\s+bsize=(\d+)\s+blocks=(\d+)/) {
+		print STDERR "ldev=\"$1\"\nlbsize=$2\nlblocks=$3\nlversion=$4\n";
+		print STDOUT "log      =LDEV bsize=XXX blocks=XXX\n";
+	}
+	if (/^\s+=\s+sectsz=(\d+)\s+sunit=(\d+) blks/) {
+		print STDERR "logsectsz=$1\nlogsunit=$2\n\n";
+	}
+	if (/^realtime\s+=([\w|\/.-]+)\s+extsz=(\d+)\s+blocks=(\d+), rtextents=(\d+)/) {
+		print STDERR "rtdev=$1\nrtextsz=$2\nrtblocks=$3\nrtextents=$4\n";
+		print STDOUT "realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX\n";
+	}'
+}
-- 
2.34.1

