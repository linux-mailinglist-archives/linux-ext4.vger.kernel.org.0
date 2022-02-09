Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1425F4AF1CD
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 13:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbiBIMeZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 07:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiBIMeQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Feb 2022 07:34:16 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFDEC05CB86;
        Wed,  9 Feb 2022 04:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644410056; x=1675946056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v8F0a5waA/YQ56I0Dss21pGPmf6h8Cgs4bg7jaXaTAo=;
  b=k8hvicD8502+zKz/mDMAq220TpkNOlW9s6VvfCNALiSZqKr1tW1/NMfa
   S7EUKA4qRrD0CezaOQW7Xpoc5QMrFxWcyy92osZc8hhJdt5T2R5SmEXUz
   7AaURyqsE1TD0tnWBJb/NrPntsm5O5CVHFbcnXTgPC4yQMpG9YSmkM+E8
   J9N5WfoEwyRpKi/fN3+GCGUPBnsV1ZTbWg4uJvHjs8vXJ+7LgzKQtgHsa
   9zCmbExGclC8QxreaCg4psoZEdcYCtyahT4IYYg5ojeU/ktIhaQlqCclU
   0uBqTbA8oaxLzK11Q9rQHezFbu7LdQ04ipfma7WnZ/FPyPfacoRvL1qm9
   w==;
X-IronPort-AV: E=Sophos;i="5.88,355,1635177600"; 
   d="scan'208";a="197323007"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2022 20:33:13 +0800
IronPort-SDR: JpA1HTgLKXxDXk/M17FOAMTA9lWMLKf1K6QM5RetwY1OYxnMGeDkQPbPq3LhmMZPZLfje3h0uV
 T9CF/aG6FVWCv8jK164FLsqqLa5VDCKPhQa4qHBUrWUzgXdOBpTUXHfWuByCLm7U6t8riWafJJ
 jf267+pZaocW8XRJMPfZx8tJTjH3grKFGC26mcefOo9ncVCTHpgHVkYTsWOxB1QzJs/ULk4kvF
 73VAGtpZ3W+f953vXzevFlzgZYd8qHEUFMZHgf0td8x9s4J1IxLEavvYYJviMj6VbbbrYYsa+N
 vXhFUz8BzsOnK3RTI54ZqxS3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 04:05:03 -0800
IronPort-SDR: BfBS6Tk89DZ5JFL4XTsO1eopXGH3faS8RKQ50txEfu0HURHm6tDSXqfZT8NBD5dlhF1I/1Hfq5
 XspOljRD0wsNNcUxmX2hpEIGknQSrrl219G4CJOi/5aVWSSn2bEXSy1EnUIJdLUC53mSANxDqx
 cqHoH/9lrRuv672ipDUQdlW2SMIg/dvNts0P65rVyEQmlDWEwYSuZlqD+G2xPeUzA3aj4FfPBi
 h30t1qgqleAlMQYW5lU6LmQQUltkviMdJrLK0uPOw5p2VUpwF33UAtrX9aGR/SMNA5PFzdVmpr
 j2Q=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Feb 2022 04:33:14 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2 6/6] common: factor out xfs unique part from _filter_mkfs
Date:   Wed,  9 Feb 2022 21:33:05 +0900
Message-Id: <20220209123305.253038-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209123305.253038-1-shinichiro.kawasaki@wdc.com>
References: <20220209123305.253038-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

