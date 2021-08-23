Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC7F3F44CE
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Aug 2021 08:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbhHWGOn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Aug 2021 02:14:43 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:53683 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231267AbhHWGOl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 23 Aug 2021 02:14:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UlCK-Sz_1629699238;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UlCK-Sz_1629699238)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 23 Aug 2021 14:13:58 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, joseph.qi@linux.alibaba.com,
        enwlinux@gmail.com, hsiangkao@linux.alibaba.com
Subject: [PATCH v2] ext4: fix reserved space counter leakage
Date:   Mon, 23 Aug 2021 14:13:58 +0800
Message-Id: <20210823061358.84473-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When ext4_insert_delayed block receives and recovers from an error from
ext4_es_insert_delayed_block(), e.g., ENOMEM, it does not release the
space it has reserved for that block insertion as it should. One effect
of this bug is that s_dirtyclusters_counter is not decremented and
remains incorrectly elevated until the file system has been unmounted.
This can result in premature ENOSPC returns and apparent loss of free
space.

Another effect of this bug is that
/sys/fs/ext4/<dev>/delayed_allocation_blocks can remain non-zero even
after syncfs has been executed on the filesystem.

Besides, add check for s_dirtyclusters_counter when inode is going to be
evicted and freed. s_dirtyclusters_counter can still keep non-zero until
inode is written back in .evict_inode(), and thus the check is delayed
to .destroy_inode().

Fixes: 51865fda28e5 ("ext4: let ext4 maintain extent status tree")
Cc: <stable@vger.kernel.org>
Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
changes since v1:
- improve commit log suggested by Eric Whitney
- update "Suggested-by" title for Gao Xian, who actually found this bug
  code
- add check for s_dirtyclusters_counter in .destroy_inode()
---
 fs/ext4/inode.c | 5 +++++
 fs/ext4/super.c | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d8de607849df..73daf9443e5e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1640,6 +1640,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	int ret;
 	bool allocated = false;
+	bool reserved = false;
 
 	/*
 	 * If the cluster containing lblk is shared with a delayed,
@@ -1656,6 +1657,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 		ret = ext4_da_reserve_space(inode);
 		if (ret != 0)   /* ENOSPC */
 			goto errout;
+		reserved = true;
 	} else {   /* bigalloc */
 		if (!ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)) {
 			if (!ext4_es_scan_clu(inode,
@@ -1668,6 +1670,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 					ret = ext4_da_reserve_space(inode);
 					if (ret != 0)   /* ENOSPC */
 						goto errout;
+					reserved = true;
 				} else {
 					allocated = true;
 				}
@@ -1678,6 +1681,8 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 	}
 
 	ret = ext4_es_insert_delayed_block(inode, lblk, allocated);
+	if (ret && reserved)
+		ext4_da_release_space(inode, 1);
 
 errout:
 	return ret;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dfa09a277b56..61bf52b58fca 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1351,6 +1351,12 @@ static void ext4_destroy_inode(struct inode *inode)
 				true);
 		dump_stack();
 	}
+
+	if (EXT4_I(inode)->i_reserved_data_blocks)
+		ext4_msg(inode->i_sb, KERN_ERR,
+			 "Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
+			 inode->i_ino, EXT4_I(inode),
+			 EXT4_I(inode)->i_reserved_data_blocks);
 }
 
 static void init_once(void *foo)
-- 
2.27.0

