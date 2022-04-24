Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0134350D225
	for <lists+linux-ext4@lfdr.de>; Sun, 24 Apr 2022 15:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiDXN6i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 24 Apr 2022 09:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbiDXN6i (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 24 Apr 2022 09:58:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50792140CF
        for <linux-ext4@vger.kernel.org>; Sun, 24 Apr 2022 06:55:37 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KmV311lmvzGp4N;
        Sun, 24 Apr 2022 21:53:01 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 24 Apr
 2022 21:55:23 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>, <yebin10@huawei.com>
Subject: [RFC PATCH v4 1/2] ext4: add nowait mode for ext4_getblk()
Date:   Sun, 24 Apr 2022 22:09:35 +0800
Message-ID: <20220424140936.1898920-2-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220424140936.1898920-1-yi.zhang@huawei.com>
References: <20220424140936.1898920-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Current ext4_getblk() might sleep if some resources are not valid or
could be race with a concurrent extents modifing procedure. So we
cannot call ext4_getblk() and ext4_map_blocks() to get map blocks in
the atomic context in some fast path (e.g. the upcoming procedure of
getting symlink external block in the RCU context), even if the map
extents have already been check and cached.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  |  2 ++
 fs/ext4/inode.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index a743b1e3b89e..797bc572d6fb 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -673,6 +673,8 @@ enum {
 	/* Caller will submit data before dropping transaction handle. This
 	 * allows jbd2 to avoid submitting data before commit. */
 #define EXT4_GET_BLOCKS_IO_SUBMIT		0x0400
+	/* Caller is in the atomic contex, find extent if it has been cached */
+#define EXT4_GET_BLOCKS_CACHED_NOWAIT		0x0800
 
 /*
  * The bit position of these flags must not overlap with any of the
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 847de9140eee..ea162caace29 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -545,12 +545,21 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		} else {
 			BUG();
 		}
+
+		if (flags & EXT4_GET_BLOCKS_CACHED_NOWAIT)
+			return retval;
 #ifdef ES_AGGRESSIVE_TEST
 		ext4_map_blocks_es_recheck(handle, inode, map,
 					   &orig_map, flags);
 #endif
 		goto found;
 	}
+	/*
+	 * In the query cache no-wait mode, nothing we can do more if we
+	 * cannot find extent in the cache.
+	 */
+	if (flags & EXT4_GET_BLOCKS_CACHED_NOWAIT)
+		return 0;
 
 	/*
 	 * Try to see if we can get the block without requesting a new
@@ -837,10 +846,12 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
 	struct ext4_map_blocks map;
 	struct buffer_head *bh;
 	int create = map_flags & EXT4_GET_BLOCKS_CREATE;
+	bool nowait = map_flags & EXT4_GET_BLOCKS_CACHED_NOWAIT;
 	int err;
 
 	ASSERT((EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		    || handle != NULL || create == 0);
+	ASSERT(create == 0 || !nowait);
 
 	map.m_lblk = block;
 	map.m_len = 1;
@@ -851,6 +862,9 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
 	if (err < 0)
 		return ERR_PTR(err);
 
+	if (nowait)
+		return sb_find_get_block(inode->i_sb, map.m_pblk);
+
 	bh = sb_getblk(inode->i_sb, map.m_pblk);
 	if (unlikely(!bh))
 		return ERR_PTR(-ENOMEM);
-- 
2.31.1

