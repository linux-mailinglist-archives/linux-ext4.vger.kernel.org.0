Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C7B757CFE
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Jul 2023 15:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjGRNNp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Jul 2023 09:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjGRNNo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Jul 2023 09:13:44 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F341CB3;
        Tue, 18 Jul 2023 06:13:42 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R4zs60LD9z18Lvp;
        Tue, 18 Jul 2023 21:12:58 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 18 Jul
 2023 21:13:40 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <ojaswin@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH 1/4] ext4: add two helper functions fex_end() and pa_end()
Date:   Tue, 18 Jul 2023 21:10:49 +0800
Message-ID: <20230718131052.283350-2-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230718131052.283350-1-libaokun1@huawei.com>
References: <20230718131052.283350-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When we use lstart + len to calculate the end of free extent or prealloc
space, it may exceed the maximum value of 4294967295(0xffffffff) supported
by ext4_lblk_t and cause overflow, which may lead to various problems.

Therefore, we add two helper functions, fex_end() and pa_end(), to limit
the type of end to loff_t, and also convert lstart to loff_t for
calculation to avoid overflow.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c |  4 ++--
 fs/ext4/mballoc.h | 13 +++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 456150ef6111..eb7f5d35ef96 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4432,7 +4432,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 
 	/* first, let's learn actual file size
 	 * given current request is allocated */
-	size = ac->ac_o_ex.fe_logical + EXT4_C2B(sbi, ac->ac_o_ex.fe_len);
+	size = fex_end(sbi, &ac->ac_o_ex, NULL);
 	size = size << bsbits;
 	if (size < i_size_read(ac->ac_inode))
 		size = i_size_read(ac->ac_inode);
@@ -5665,7 +5665,7 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
 
 	group_pa_eligible = sbi->s_mb_group_prealloc > 0;
 	inode_pa_eligible = true;
-	size = ac->ac_o_ex.fe_logical + EXT4_C2B(sbi, ac->ac_o_ex.fe_len);
+	size = fex_end(sbi, &ac->ac_o_ex, NULL);
 	isize = (i_size_read(ac->ac_inode) + ac->ac_sb->s_blocksize - 1)
 		>> bsbits;
 
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index df6b5e7c2274..fe6bf381f30a 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -233,6 +233,19 @@ static inline ext4_fsblk_t ext4_grp_offs_to_block(struct super_block *sb,
 		(fex->fe_start << EXT4_SB(sb)->s_cluster_bits);
 }
 
+static inline loff_t fex_end(struct ext4_sb_info *sbi,
+			     struct ext4_free_extent *fex, ext4_grpblk_t *fe_len)
+{
+	return (loff_t)fex->fe_logical +
+		EXT4_C2B(sbi, fe_len ? *fe_len : fex->fe_len);
+}
+
+static inline loff_t pa_end(struct ext4_sb_info *sbi,
+			    struct ext4_prealloc_space *pa)
+{
+	return (loff_t)pa->pa_lstart + EXT4_C2B(sbi, pa->pa_len);
+}
+
 typedef int (*ext4_mballoc_query_range_fn)(
 	struct super_block		*sb,
 	ext4_group_t			agno,
-- 
2.31.1

