Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41114AB5B0
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Feb 2022 08:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiBGHPo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Feb 2022 02:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238533AbiBGG4v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Feb 2022 01:56:51 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587C5C043184;
        Sun,  6 Feb 2022 22:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644217010; x=1675753010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d4ENreMGrlKCk5cIjSx96VRXwooXyBj4UXgKGLLw7K0=;
  b=bLbm+UA3QjgYnLrvUfzpVCVOqHuSFFrjnV0WHRyEoviA95VBwIseOam3
   kbFSjmxYyA3zgsPJrJpzzogD4W9/RzCG9Oc7zcHsY6Rl2ulRIZ6+dDu8+
   55NtmkOF5b6ggrelNgxTCR118Nf3O8IbUu5zskWaOnlMDr1UQU7yXqVre
   BG3OX9ngixALOvpYtirelMyrSFKSpGx6GJst5RsNUj2PqJ7vCS57Y+yto
   jMD/tf52ZMlDZWBVvYoVw8QORpRk2Hcf4PDEV12vdPz5/fL7hd4eG3ffR
   Tdb9oIeRiW8uzda2YTXmK7tKx+DCb6IbJbgrl0YBzk6QXOtaCyl8TzEX0
   g==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635177600"; 
   d="scan'208";a="192305058"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2022 14:55:44 +0800
IronPort-SDR: AzHJ6gb0GNt+dfP9Spn3Ih6ZsGdIJG2OFuQ7GIAjpgYp7Od9R8Jlis2RbaEsAedP+V2SMkAlr5
 mxjLUOeig/KWg7WQsrvQcCPL2b+OQmue51j3IyabafNvtjnySRPxAOX4v+dMEUUYHtITjuCx7z
 +WRFRVpgO99X7CeKV6/CbDpzG+M3JbENGomnNjFSZGRWkyS5xy0oy7VWFrhuOnfAoshmdcnVJJ
 JVRZipFVlmpd2Z+Z+wcat+Qi4Izg2LTYtHKUaDYCeqZQvxo4R6/7oiQ9BBtkXoxgIa6fPpJ7oo
 fCGwkB6kR1w7RhJQgx2N8fOb
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 22:28:46 -0800
IronPort-SDR: JlXGmo5R+Rrf+nwIvfXNcaofNNbbLBybjeVFPFgCsGHnHQqYSyTQWkz2QfCwaXHqTznXdh9WZJ
 UH5PFq8fTrULCAh4VanxcswQOq5VyruByqfZHz0t1fqMLU9koybaBuJLLFmkrA92+s+IhzPWPp
 vyJFcsEUAcXuTMxQYJOqxEuPRyjbpvY4/9fyyxj+hqeW3MadbQ0Np+goQYBKxvf3fBQj77Ukr6
 9TojSxEw+WqoshTtevL/qkZ4LYscIlyAeoRGS299903p1Yz4d/rDKzeg1EeRgVoPv9OMmJly7Q
 Ke0=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Feb 2022 22:55:45 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 2/7] generic/{171,172,173,174,204}: check _scratch_mkfs_sized return code
Date:   Mon,  7 Feb 2022 15:55:36 +0900
Message-Id: <20220207065541.232685-3-shinichiro.kawasaki@wdc.com>
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

The test cases generic/{171,172,173,174,204} call _scratch_mkfs before
_scratch_mkfs_sized, and they do not check return code of
_scratch_mkfs_sized. Even if _scratch_mkfs_sized failed, _scratch_mount
after it cannot detect the sized mkfs failure because _scratch_mkfs
already created a file system on the device. This results in unexpected
test condition of the test cases.

To avoid the unexpected test condition, check return code of
_scratch_mkfs_sized in the test cases.

Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/generic/171 | 2 +-
 tests/generic/172 | 2 +-
 tests/generic/173 | 2 +-
 tests/generic/174 | 2 +-
 tests/generic/204 | 3 ++-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tests/generic/171 b/tests/generic/171
index fb2a6f14..f823a454 100755
--- a/tests/generic/171
+++ b/tests/generic/171
@@ -42,7 +42,7 @@ sz_bytes=$((nr_blks * 8 * blksz))
 if [ $sz_bytes -lt $((32 * 1048576)) ]; then
 	sz_bytes=$((32 * 1048576))
 fi
-_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1
+_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1 || _fail "mkfs failed"
 _scratch_mount >> $seqres.full 2>&1
 rm -rf $testdir
 mkdir $testdir
diff --git a/tests/generic/172 b/tests/generic/172
index ab5122fa..383824b9 100755
--- a/tests/generic/172
+++ b/tests/generic/172
@@ -40,7 +40,7 @@ umount $SCRATCH_MNT
 
 file_size=$((768 * 1024 * 1024))
 fs_size=$((1024 * 1024 * 1024))
-_scratch_mkfs_sized $fs_size >> $seqres.full 2>&1
+_scratch_mkfs_sized $fs_size >> $seqres.full 2>&1 || _fail "mkfs failed"
 _scratch_mount >> $seqres.full 2>&1
 rm -rf $testdir
 mkdir $testdir
diff --git a/tests/generic/173 b/tests/generic/173
index 0eb313e2..e1493278 100755
--- a/tests/generic/173
+++ b/tests/generic/173
@@ -42,7 +42,7 @@ sz_bytes=$((nr_blks * 8 * blksz))
 if [ $sz_bytes -lt $((32 * 1048576)) ]; then
 	sz_bytes=$((32 * 1048576))
 fi
-_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1
+_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1 || _fail "mkfs failed"
 _scratch_mount >> $seqres.full 2>&1
 rm -rf $testdir
 mkdir $testdir
diff --git a/tests/generic/174 b/tests/generic/174
index 1505453e..c7a177b8 100755
--- a/tests/generic/174
+++ b/tests/generic/174
@@ -43,7 +43,7 @@ sz_bytes=$((nr_blks * 8 * blksz))
 if [ $sz_bytes -lt $((32 * 1048576)) ]; then
 	sz_bytes=$((32 * 1048576))
 fi
-_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1
+_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1 || _fail "mkfs failed"
 _scratch_mount >> $seqres.full 2>&1
 rm -rf $testdir
 mkdir $testdir
diff --git a/tests/generic/204 b/tests/generic/204
index a3dabb71..b5deb443 100755
--- a/tests/generic/204
+++ b/tests/generic/204
@@ -35,7 +35,8 @@ _scratch_mkfs 2> /dev/null | _filter_mkfs 2> $tmp.mkfs > /dev/null
 [ $FSTYP = "xfs" ] && MKFS_OPTIONS="$MKFS_OPTIONS -l size=16m -i maxpct=50"
 
 SIZE=`expr 115 \* 1024 \* 1024`
-_scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw
+_scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw \
+	|| _fail "mkfs failed"
 cat $tmp.mkfs.raw | _filter_mkfs 2> $tmp.mkfs > /dev/null
 _scratch_mount
 
-- 
2.34.1

