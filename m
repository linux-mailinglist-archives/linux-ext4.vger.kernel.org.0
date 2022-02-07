Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A044AB5A2
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Feb 2022 08:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiBGHPo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Feb 2022 02:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238603AbiBGG4z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Feb 2022 01:56:55 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B6EC043181;
        Sun,  6 Feb 2022 22:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644217014; x=1675753014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PmOAO/z/5SQRJrAaX0rjm1/SDaYQLCQkeqzLnW4Z6gk=;
  b=Zc9Bb2JQ2mD/1RrbfaXULEHaRFxbDpUhxdp5avSkNmioTTM2CTB3pDXB
   vR9AdvpeJDelWCMohY+ty7mMV9tTESKeGRDLo0I2PlO9a1mcIeNpMVsZh
   k6UE1hN3SDsL0ZnfneUy7UwUTxHs2VXNOJp9buyPqEN7njmeI6Y+s1R2u
   F2Ln5ZsCJE/ZimfozdufRnVt2O00mPGDi4YMh+PLIDwbH0Q2MNzBwPqVv
   PJaDYg/b9LdRyfrC29H4+9pbVo8/Geq+R+7OAoSZWuTUHTEyB3g4fSsh4
   K2y7a+VUQCn6K54eexMyDMK0pUVSHFRwB2A8fusJYH8qfCPY+MAX4U69q
   A==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635177600"; 
   d="scan'208";a="192305063"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2022 14:55:50 +0800
IronPort-SDR: r9932kn+f4XOEzku5Flek6+HFtzQc+8HL+uc3Mwj4k3AoR7t3uIqYKz75WhmKTLnp/0lFImHkI
 IDlWcy0JWXKhbs92gMFpgNLAatAc9qebkeqV80212Q9AVDc0f63bgyW/doz0owoRTKDS13slfl
 ED/nKvydEV3tk/1+hIZkF6kipoNp+NmkM2bJlYocMamIbGZrxaZucjg8sr6DIi7cY6X4apYYEs
 DsWojXKKPT26Ui6yDalliQ4vsZfGADH7S+PguUk+OcMfSOfiHN9aN25q0ipBpJBCI6vtCPl2Zy
 iUSu+9j5/x0pkoAFT5Jh8n9R
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 22:28:52 -0800
IronPort-SDR: r8QQtUb9+zVVEQp3oSLE4cpDzRuok5hPjxlAL9Eb1Pz5tM2Z7zejavee8SQH57O5ZBbdhjKPhf
 Zh8qpfV5RPdCEg51HImkRuSlzoJig7m/auj+plV/nzomwAMpW1kF8UQ0GdtBvygfWXKOVcroD+
 6GLDqJqZWNVtMAgEZBNy4JPC0nNPY1TNwoXZ8NWzEeGWisO52ZwOM14vJ8FbgsP1VRVLU0Ir65
 OObTMBuRjWbNwYKLKvb+yH/D7KMgjsreFcNOdzEN9zj+wO4ZWWU4gPOqTWjNPUhmjLCNOoAEP9
 ei0=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Feb 2022 22:55:50 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 6/7] common: move _xfs_filter_mkfs from common/filter to common/xfs
Date:   Mon,  7 Feb 2022 15:55:40 +0900
Message-Id: <20220207065541.232685-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207065541.232685-1-shinichiro.kawasaki@wdc.com>
References: <20220207065541.232685-1-shinichiro.kawasaki@wdc.com>
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

The helper function _xfs_filter_mkfs works only for xfs. Move it from
common/filter to common/xfs. Also remove useless lines for other
filesystems.

Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/filter | 53 ---------------------------------------------------
 common/xfs    | 43 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 53 deletions(-)

diff --git a/common/filter b/common/filter
index 24fd0650..7c71be4f 100644
--- a/common/filter
+++ b/common/filter
@@ -115,59 +115,6 @@ _filter_date()
 	-e 's/[A-Z][a-z][a-z] [A-z][a-z][a-z]  *[0-9][0-9]* [0-9][0-9]:[0-9][0-9]:[0-9][0-9] [0-9][0-9][0-9][0-9]$/DATE/'
 }
 
-# prints filtered output on stdout, values (use eval) on stderr
-# Non XFS filesystems always return a 4k block size and a 256 byte inode.
-_xfs_filter_mkfs()
-{
-    case $FSTYP in
-    xfs)
-	;;
-    *)
-	cat - >/dev/null
-	perl -e 'print STDERR "dbsize=4096\nisize=256\n"'
-	return ;;
-    esac
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
-}
-
-
 # prints the bits we care about in growfs
 # 
 _filter_growfs()
diff --git a/common/xfs b/common/xfs
index 3435c706..a3da25dd 100644
--- a/common/xfs
+++ b/common/xfs
@@ -1275,3 +1275,46 @@ _require_scratch_xfs_bigtime()
 		_notrun "bigtime feature not advertised on mount?"
 	_scratch_unmount
 }
+
+# prints filtered output on stdout, values (use eval) on stderr
+# Non XFS filesystems always return a 4k block size and a 256 byte inode.
+_xfs_filter_mkfs()
+{
+    echo "_fs_has_crcs=0" >&2
+    set -
+    perl -ne '
+    if (/^meta-data=([\w,|\/.-]+)\s+isize=(\d+)\s+agcount=(\d+), agsize=(\d+) blks/) {
+	print STDERR "ddev=$1\nisize=$2\nagcount=$3\nagsize=$4\n";
+	print STDOUT "meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks\n";
+    }
+    if (/^\s+=\s+sectsz=(\d+)\s+attr=(\d+)/) {
+        print STDERR "sectsz=$1\nattr=$2\n";
+    }
+    if (/^\s+=\s+crc=(\d)/) {
+        print STDERR "_fs_has_crcs=$1\n";
+    }
+    if (/^data\s+=\s+bsize=(\d+)\s+blocks=(\d+), imaxpct=(\d+)/) {
+	print STDERR "dbsize=$1\ndblocks=$2\nimaxpct=$3\n";
+	print STDOUT "data     = bsize=XXX blocks=XXX, imaxpct=PCT\n";
+    }
+    if (/^\s+=\s+sunit=(\d+)\s+swidth=(\d+) blks/) {
+        print STDERR "sunit=$1\nswidth=$2\nunwritten=1\n";
+	print STDOUT "         = sunit=XXX swidth=XXX, unwritten=X\n";
+    }
+    if (/^naming\s+=version\s+(\d+)\s+bsize=(\d+)/) {
+	print STDERR "dirversion=$1\ndirbsize=$2\n";
+	print STDOUT "naming   =VERN bsize=XXX\n";
+    }
+    if (/^log\s+=(internal log|[\w|\/.-]+)\s+bsize=(\d+)\s+blocks=(\d+),\s+version=(\d+)/ ||
+	/^log\s+=(internal log|[\w|\/.-]+)\s+bsize=(\d+)\s+blocks=(\d+)/) {
+	print STDERR "ldev=\"$1\"\nlbsize=$2\nlblocks=$3\nlversion=$4\n";
+	print STDOUT "log      =LDEV bsize=XXX blocks=XXX\n";
+    }
+    if (/^\s+=\s+sectsz=(\d+)\s+sunit=(\d+) blks/) {
+	print STDERR "logsectsz=$1\nlogsunit=$2\n\n";
+    }
+    if (/^realtime\s+=([\w|\/.-]+)\s+extsz=(\d+)\s+blocks=(\d+), rtextents=(\d+)/) {
+	print STDERR "rtdev=$1\nrtextsz=$2\nrtblocks=$3\nrtextents=$4\n";
+	print STDOUT "realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX\n";
+    }'
+}
-- 
2.34.1

