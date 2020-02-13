Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1E5C15BC80
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2020 11:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgBMKQG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Feb 2020 05:16:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:51220 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729572AbgBMKQG (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 13 Feb 2020 05:16:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A6646AF47;
        Thu, 13 Feb 2020 10:16:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2D7B51E0E33; Thu, 13 Feb 2020 11:16:05 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/7] e2fsck: Fix indexed dir rehash failure with metadata_csum enabled
Date:   Thu, 13 Feb 2020 11:15:57 +0100
Message-Id: <20200213101602.29096-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200213101602.29096-1-jack@suse.cz>
References: <20200213101602.29096-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

E2fsck directory rehashing code can fail with ENOSPC due to a bug in
ext2fs_htree_intnode_maxrecs() which fails to take metadata checksum
into account and thus e.g. e2fsck can decide to create 1 indirect level
of index tree when two are actually needed. Fix the logic to account for
metadata checksum.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/ext2fs/ext2fs.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 93ecf29c568d..5fde3343b1f1 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1783,7 +1783,6 @@ extern blk_t ext2fs_group_first_block(ext2_filsys fs, dgrp_t group);
 extern blk_t ext2fs_group_last_block(ext2_filsys fs, dgrp_t group);
 extern blk_t ext2fs_inode_data_blocks(ext2_filsys fs,
 				      struct ext2_inode *inode);
-extern int ext2fs_htree_intnode_maxrecs(ext2_filsys fs, int blocks);
 extern unsigned int ext2fs_div_ceil(unsigned int a, unsigned int b);
 extern __u64 ext2fs_div64_ceil(__u64 a, __u64 b);
 extern int ext2fs_dirent_name_len(const struct ext2_dir_entry *entry);
@@ -2015,9 +2014,14 @@ _INLINE_ blk_t ext2fs_inode_data_blocks(ext2_filsys fs,
 	return (blk_t) ext2fs_inode_data_blocks2(fs, inode);
 }
 
-_INLINE_ int ext2fs_htree_intnode_maxrecs(ext2_filsys fs, int blocks)
+static inline int ext2fs_htree_intnode_maxrecs(ext2_filsys fs, int blocks)
 {
-	return blocks * ((fs->blocksize - 8) / sizeof(struct ext2_dx_entry));
+	int csum_size = 0;
+
+	if (ext2fs_has_feature_metadata_csum(fs->super))
+		csum_size = sizeof(struct ext2_dx_tail);
+	return blocks * ((fs->blocksize - (8 + csum_size)) /
+						sizeof(struct ext2_dx_entry));
 }
 
 /*
-- 
2.16.4

