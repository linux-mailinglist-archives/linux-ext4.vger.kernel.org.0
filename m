Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A744AF1C4
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 13:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbiBIMeP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 07:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiBIMeK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Feb 2022 07:34:10 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DC1C05CB9E;
        Wed,  9 Feb 2022 04:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644410051; x=1675946051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5YBXzEn8+J8F5Y1tFEsqQdoZ77ZEWS7eBZS6UQQ1Xno=;
  b=bxSrwKCp4V9h9ZsvB4hfEOaNY4p5e7pWbtiW7zJTCO1993tvmJyKKkpg
   A9TM7p+4WEj3GrjuFM0ycd5XEpcPbGY7SL6RPf0U4zKRwbNSL6S7nqj9l
   U5y532UYWPO8Abl1jFcF4ZDSNO7hx0a46SCCMmwG8qAThxEv9pzX+9D+Y
   8BpuifrVcRYCApA4STEVaUq/ZAoHM4MLeEn4wonuLKO8P3+h7cyIz3iT1
   +voqFNehYTXK5BdkiSYzABTLLgwg0XAdDikhVxClMmIWg/fysq/JMofoQ
   K/Rdc9e+4QOtOPx0DFUP0Itkux1opteWinsokdLixhtqpvozl7oNa35k6
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,355,1635177600"; 
   d="scan'208";a="197323000"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2022 20:33:09 +0800
IronPort-SDR: eYEInYXi0nfN1D/j6FKGTObb+wrJcioetUXgdOO07F99XGrfenoBETOTZgyBlbxSvkAa7f0two
 2aEOl3db3V/QHMFosaYDt8Tnql+pGsAjrkzOTV8Xhl+SZ3ZMZnzTDHIt8VlIRO1taqpqgZDT6p
 xbb+Q5ppao41DBFgoLKvn1c3Wq+QziblZqqEMPMS5CptfGBeVeiyqA6ZLYtPCB+KfHvwxZ1Ptv
 4mPQpWwsa58LqKKm/aRU9YJCO5fgRV6t+1oBloGm/c75XXQ7x7Ha0J7CpieBqIuIVLBu6Lntdv
 spGYG7J/SU8UOfiib/gGrz/B
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 04:04:59 -0800
IronPort-SDR: ZRXErby/FnegHYZhqxmDHDeLBoYudP0ebjPQIMwQHTsuebka2eGQNowQiDk3LKovE7VjcJRtM3
 FCqD2atJg/DzahY9RydfTpDbbHH4OJzqOZmFiyQdfYTgimAQpxzPikTane6+keoNQ8l72fsZ8V
 II61+LCiVlrCKwV49juJv7drYYuDWxOCE8DVhnYfrTx/KZa7X1Eo2JyOFXO34vrmOF773ecyFZ
 JIriDxHop0c5+G78lQZ+9xa6giFU7VWLXSskqDQRDZfY+dFadzUwkPHw8BaQenyJQIlbQCEjKq
 wtI=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Feb 2022 04:33:10 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2 3/6] generic/{171,172,173,174}: check _scratch_mkfs_sized return code
Date:   Wed,  9 Feb 2022 21:33:02 +0900
Message-Id: <20220209123305.253038-4-shinichiro.kawasaki@wdc.com>
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

The test cases generic/{171,172,173,174} call _scratch_mkfs before
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
 4 files changed, 4 insertions(+), 4 deletions(-)

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
-- 
2.34.1

