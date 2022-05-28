Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F49536C64
	for <lists+linux-ext4@lfdr.de>; Sat, 28 May 2022 12:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355675AbiE1KrM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 May 2022 06:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350071AbiE1Kq7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 May 2022 06:46:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BAB13D66;
        Sat, 28 May 2022 03:46:57 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L9JHM3v4MzjWyv;
        Sat, 28 May 2022 18:45:51 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 28 May
 2022 18:46:55 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yebin10@huawei.com>, <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v3 3/3] ext4: support flex_bg in ext4_mb_normalize_request
Date:   Sat, 28 May 2022 19:00:17 +0800
Message-ID: <20220528110017.354175-4-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220528110017.354175-1-libaokun1@huawei.com>
References: <20220528110017.354175-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In ext4_mb_normalize_request, the size of the allocation request is
limited to no more than EXT4_BLOCKS_PER_GROUP. Ritesh mentions that this
does not take into account the case of flex_bg groups. So we should add
support for flex_bg to make the physical blocks of large files contiguous.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9e06334771a3..253fc250e9a0 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4028,6 +4028,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	loff_t size, start_off;
 	loff_t orig_size __maybe_unused;
 	ext4_lblk_t start;
+	ext4_lblk_t bpg;
 	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
 	struct ext4_prealloc_space *pa;
 
@@ -4051,6 +4052,11 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	}
 
 	bsbits = ac->ac_sb->s_blocksize_bits;
+	bpg = EXT4_BLOCKS_PER_GROUP(ac->ac_sb);
+	if (ext4_has_feature_flex_bg(ac->ac_sb) && sbi->s_log_groups_per_flex) {
+		if (check_shl_overflow(bpg, sbi->s_log_groups_per_flex, &bpg))
+			bpg = EXT_MAX_BLOCKS;
+	}
 
 	/* first, let's learn actual file size
 	 * given current request is allocated */
@@ -4110,8 +4116,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	 * alignment does not move allocation to a different group which
 	 * makes mballoc fail assertions later.
 	 */
-	start = max(start, rounddown(ac->ac_o_ex.fe_logical,
-			(ext4_lblk_t)EXT4_BLOCKS_PER_GROUP(ac->ac_sb)));
+	start = max(start, rounddown(ac->ac_o_ex.fe_logical, bpg));
 
 	/* don't cover already allocated blocks in selected range */
 	if (ar->pleft && start <= ar->lleft) {
@@ -4125,8 +4130,8 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	 * Trim allocation request for filesystems with artificially small
 	 * groups.
 	 */
-	if (size > EXT4_BLOCKS_PER_GROUP(ac->ac_sb))
-		size = EXT4_BLOCKS_PER_GROUP(ac->ac_sb);
+	if (size > bpg)
+		size = bpg;
 
 	end = start + size;
 
@@ -4208,7 +4213,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 			 (unsigned long) ac->ac_o_ex.fe_logical);
 		BUG();
 	}
-	BUG_ON(size <= 0 || size > EXT4_BLOCKS_PER_GROUP(ac->ac_sb));
+	BUG_ON(size <= 0 || size > bpg);
 
 	/* now prepare goal request */
 
-- 
2.31.1

