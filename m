Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BD44BB353
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Feb 2022 08:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiBRHcU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Feb 2022 02:32:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiBRHcT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Feb 2022 02:32:19 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC91C28D3B0;
        Thu, 17 Feb 2022 23:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645169523; x=1676705523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KEuWIoMVLJ58HRVAmVtsxGEysPraVNqGHgTji0wI3VQ=;
  b=iLOT3wsFR0lG/oykmKV65j+Z0tbSp+W1vsquDSs7yVKFcahdjWcNiOMJ
   x9cBC4SisCjFpyX52wBZ04z7JBgjYXjYaLeumVIUb7FvJpubwqjH4FsRn
   61NvA/x3OatECB69ngNhFPrpEZY3106yNY6oyhEQ92Y/iVVmBek4PKstm
   ym56fu5x4+9cD0yxAm7STb0MxWDTwjhJokdkt10ajyucXTQvrGcs9p7b4
   YhClNsNV9JFwN+YVDytJXbh3JyLOvMAPnxyHDkRebAQ0CREZzb6iTLFvh
   YsuRzv9hZdVaxWWBnWPzdzbuEEQ4MsGkQ5Y37fPkO3XFJNMZY5EoqXrkn
   A==;
X-IronPort-AV: E=Sophos;i="5.88,378,1635177600"; 
   d="scan'208";a="193264901"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2022 15:32:03 +0800
IronPort-SDR: gS3wxDTgaxZx8AHPP+Urf2h2eYQdN0UuSZPKSWFUwQPUXjCJmJSSOaMbWEc3fpi368eEr8pB5D
 1EbjVF23w5/aZfXdI79ZdeSFsaJAqkKT1m/nG/Ss5+wlu80xPPa96NZ4BPA3qoWbaS9NNzzHxy
 7LRPJL4xzlR/XEkcDrUAAMjL2Olb36aq39p30i1S1Vjk3DC/wBorRHVJjApyJ8kVEPfcxLJXeR
 /rXvSTfhlstEHrixxOPdf+dAx5vfFP8ZLBVQR+5H9ooX7NRGYbSX5scNsdwfcZns7y3WpyRodG
 KLE0xgXxu889HTgw+icN86Xk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 23:04:48 -0800
IronPort-SDR: f8Y1hGD4Ilmy1jzsREBseRt646DjALD1/hbFiLzYp6G9dSf37GE7cinxL7lcY6uvmVJBMPY3Cn
 Jd3Dxt+3C4lBZCaq/xyIlePQqiXx+upBrtb/9atEdD+BWTq+oMX5VrogENmoNKng3xEKsFTmu5
 aD+9WdGt9zotnTSl7W/hEOpINuIG5E2Irwo1A0HNP5HwvV1rVnNg8ST/lX5KClafbfyrKvroD1
 5cs1IyJSbN+yTW3HEUEFq/EMiJ95h4yz1cnxMwBlWV35qnXTeXch4y3a7Wy9mBvIH9Fk3b6se2
 7kg=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Feb 2022 23:32:02 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v3 3/6] generic/{171,172,173,174}: check _scratch_mkfs_sized return code
Date:   Fri, 18 Feb 2022 16:31:53 +0900
Message-Id: <20220218073156.2179803-4-shinichiro.kawasaki@wdc.com>
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
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
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

