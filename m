Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24508621688
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Nov 2022 15:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiKHO0y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Nov 2022 09:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbiKHO0M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Nov 2022 09:26:12 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C395D5C77C
        for <linux-ext4@vger.kernel.org>; Tue,  8 Nov 2022 06:24:53 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N69Jv40ZHzHqPG;
        Tue,  8 Nov 2022 22:21:51 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:24:51 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 08/12] ext4: call ext4_xattr_get_block() when getting xattr block
Date:   Tue, 8 Nov 2022 22:46:13 +0800
Message-ID: <20221108144617.4159381-9-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221108144617.4159381-1-yi.zhang@huawei.com>
References: <20221108144617.4159381-1-yi.zhang@huawei.com>
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

We currently open code reading xattr block and checking valid in many
places where getting xattr block, but we already have a helper function
ext4_xattr_get_block(), use this helper can unify all of the getting
xattr block procedure and make them more clean-up.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/xattr.c | 197 ++++++++++++++++++++----------------------------
 1 file changed, 80 insertions(+), 117 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 46a87ae9fdc8..39c80565c65d 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -74,6 +74,7 @@
 # define ea_bdebug(bh, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
 #endif
 
+static struct buffer_head *ext4_xattr_get_block(struct inode *);
 static void ext4_xattr_block_cache_insert(struct mb_cache *,
 					  struct buffer_head *);
 static struct buffer_head *
@@ -542,18 +543,11 @@ ext4_xattr_block_get(struct inode *inode, int name_index, const char *name,
 	ea_idebug(inode, "name=%d.%s, buffer=%p, buffer_size=%ld",
 		  name_index, name, buffer, (long)buffer_size);
 
-	if (!EXT4_I(inode)->i_file_acl)
+	bh = ext4_xattr_get_block(inode);
+	if (!bh)
 		return -ENODATA;
-	ea_idebug(inode, "reading block %llu",
-		  (unsigned long long)EXT4_I(inode)->i_file_acl);
-	bh = ext4_sb_bread(inode->i_sb, EXT4_I(inode)->i_file_acl, REQ_PRIO);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
-	ea_bdebug(bh, "b_count=%d, refcount=%d",
-		atomic_read(&(bh->b_count)), le32_to_cpu(BHDR(bh)->h_refcount));
-	error = ext4_xattr_check_block(inode, bh);
-	if (error)
-		goto cleanup;
 	ext4_xattr_block_cache_insert(ea_block_cache, bh);
 	entry = BFIRST(bh);
 	end = bh->b_data + bh->b_size;
@@ -715,22 +709,13 @@ ext4_xattr_block_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 	ea_idebug(inode, "buffer=%p, buffer_size=%ld",
 		  buffer, (long)buffer_size);
 
-	if (!EXT4_I(inode)->i_file_acl)
-		return 0;
-	ea_idebug(inode, "reading block %llu",
-		  (unsigned long long)EXT4_I(inode)->i_file_acl);
-	bh = ext4_sb_bread(inode->i_sb, EXT4_I(inode)->i_file_acl, REQ_PRIO);
-	if (IS_ERR(bh))
+	bh = ext4_xattr_get_block(inode);
+	if (!bh || IS_ERR(bh))
 		return PTR_ERR(bh);
-	ea_bdebug(bh, "b_count=%d, refcount=%d",
-		atomic_read(&(bh->b_count)), le32_to_cpu(BHDR(bh)->h_refcount));
-	error = ext4_xattr_check_block(inode, bh);
-	if (error)
-		goto cleanup;
+
 	ext4_xattr_block_cache_insert(EA_BLOCK_CACHE(inode), bh);
 	error = ext4_xattr_list_entries(dentry, BFIRST(bh), buffer,
 					buffer_size);
-cleanup:
 	brelse(bh);
 	return error;
 }
@@ -849,18 +834,13 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
 				ea_inode_refs++;
 	}
 
-	if (EXT4_I(inode)->i_file_acl) {
-		bh = ext4_sb_bread(inode->i_sb, EXT4_I(inode)->i_file_acl, REQ_PRIO);
-		if (IS_ERR(bh)) {
-			ret = PTR_ERR(bh);
-			bh = NULL;
-			goto out;
-		}
-
-		ret = ext4_xattr_check_block(inode, bh);
-		if (ret)
-			goto out;
-
+	bh = ext4_xattr_get_block(inode);
+	if (IS_ERR(bh)) {
+		ret = PTR_ERR(bh);
+		bh = NULL;
+		goto out;
+	}
+	if (bh) {
 		for (entry = BFIRST(bh); !IS_LAST_ENTRY(entry);
 		     entry = EXT4_XATTR_NEXT(entry))
 			if (entry->e_value_inum)
@@ -1816,37 +1796,27 @@ static int
 ext4_xattr_block_find(struct inode *inode, struct ext4_xattr_info *i,
 		      struct ext4_xattr_block_find *bs)
 {
-	struct super_block *sb = inode->i_sb;
+	struct buffer_head *bh;
 	int error;
 
 	ea_idebug(inode, "name=%d.%s, value=%p, value_len=%ld",
 		  i->name_index, i->name, i->value, (long)i->value_len);
 
-	if (EXT4_I(inode)->i_file_acl) {
-		/* The inode already has an extended attribute block. */
-		bs->bh = ext4_sb_bread(sb, EXT4_I(inode)->i_file_acl, REQ_PRIO);
-		if (IS_ERR(bs->bh)) {
-			error = PTR_ERR(bs->bh);
-			bs->bh = NULL;
-			return error;
-		}
-		ea_bdebug(bs->bh, "b_count=%d, refcount=%d",
-			atomic_read(&(bs->bh->b_count)),
-			le32_to_cpu(BHDR(bs->bh)->h_refcount));
-		error = ext4_xattr_check_block(inode, bs->bh);
-		if (error)
-			return error;
-		/* Find the named attribute. */
-		bs->s.base = BHDR(bs->bh);
-		bs->s.first = BFIRST(bs->bh);
-		bs->s.end = bs->bh->b_data + bs->bh->b_size;
-		bs->s.here = bs->s.first;
-		error = xattr_find_entry(inode, &bs->s.here, bs->s.end,
-					 i->name_index, i->name, 1);
-		if (error && error != -ENODATA)
-			return error;
-		bs->s.not_found = error;
-	}
+	bh = ext4_xattr_get_block(inode);
+	if (!bh || IS_ERR(bh))
+		return PTR_ERR(bh);
+
+	/* Find the named attribute. */
+	bs->bh = bh;
+	bs->s.base = BHDR(bs->bh);
+	bs->s.first = BFIRST(bs->bh);
+	bs->s.end = bs->bh->b_data + bs->bh->b_size;
+	bs->s.here = bs->s.first;
+	error = xattr_find_entry(inode, &bs->s.here, bs->s.end,
+				 i->name_index, i->name, 1);
+	if (error && error != -ENODATA)
+		return error;
+	bs->s.not_found = error;
 	return 0;
 }
 
@@ -2260,9 +2230,15 @@ static struct buffer_head *ext4_xattr_get_block(struct inode *inode)
 
 	if (!EXT4_I(inode)->i_file_acl)
 		return NULL;
+
+	ea_idebug(inode, "reading block %llu",
+		  (unsigned long long)EXT4_I(inode)->i_file_acl);
 	bh = ext4_sb_bread(inode->i_sb, EXT4_I(inode)->i_file_acl, REQ_PRIO);
 	if (IS_ERR(bh))
 		return bh;
+
+	ea_bdebug(bh, "b_count=%d, refcount=%d",
+		atomic_read(&(bh->b_count)), le32_to_cpu(BHDR(bh)->h_refcount));
 	error = ext4_xattr_check_block(inode, bh);
 	if (error) {
 		brelse(bh);
@@ -2703,6 +2679,7 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 	int error = 0, tried_min_extra_isize = 0;
 	int s_min_extra_isize = le16_to_cpu(sbi->s_es->s_min_extra_isize);
 	int isize_diff;	/* How much do we need to grow i_extra_isize */
+	struct buffer_head *bh;
 
 retry:
 	isize_diff = new_extra_isize - EXT4_I(inode)->i_extra_isize;
@@ -2733,19 +2710,12 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 	 * Enough free space isn't available in the inode, check if
 	 * EA block can hold new_extra_isize bytes.
 	 */
-	if (EXT4_I(inode)->i_file_acl) {
-		struct buffer_head *bh;
-
-		bh = ext4_sb_bread(inode->i_sb, EXT4_I(inode)->i_file_acl, REQ_PRIO);
-		if (IS_ERR(bh)) {
-			error = PTR_ERR(bh);
-			goto cleanup;
-		}
-		error = ext4_xattr_check_block(inode, bh);
-		if (error) {
-			brelse(bh);
-			goto cleanup;
-		}
+	bh = ext4_xattr_get_block(inode);
+	if (IS_ERR(bh)) {
+		error = PTR_ERR(bh);
+		goto cleanup;
+	}
+	if (bh) {
 		base = BHDR(bh);
 		end = bh->b_data + bh->b_size;
 		min_offs = end - base;
@@ -2892,56 +2862,49 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
 						     false /* skip_quota */);
 	}
 
-	if (EXT4_I(inode)->i_file_acl) {
-		bh = ext4_sb_bread(inode->i_sb, EXT4_I(inode)->i_file_acl, REQ_PRIO);
-		if (IS_ERR(bh)) {
-			error = PTR_ERR(bh);
-			if (error == -EIO) {
-				EXT4_ERROR_INODE_ERR(inode, EIO,
-						     "block %llu read error",
-						     EXT4_I(inode)->i_file_acl);
-			}
-			bh = NULL;
-			goto cleanup;
+	bh = ext4_xattr_get_block(inode);
+	if (!bh || IS_ERR(bh)) {
+		error = PTR_ERR(bh);
+		bh = NULL;
+		if (error == -EIO) {
+			EXT4_ERROR_INODE_ERR(inode, EIO, "block %llu read error",
+					     EXT4_I(inode)->i_file_acl);
 		}
-		error = ext4_xattr_check_block(inode, bh);
-		if (error)
-			goto cleanup;
-
-		if (ext4_has_feature_ea_inode(inode->i_sb)) {
-			for (entry = BFIRST(bh); !IS_LAST_ENTRY(entry);
-			     entry = EXT4_XATTR_NEXT(entry)) {
-				if (!entry->e_value_inum)
-					continue;
-				error = ext4_xattr_inode_iget(inode,
-					      le32_to_cpu(entry->e_value_inum),
-					      le32_to_cpu(entry->e_hash),
-					      &ea_inode);
-				if (error)
-					continue;
-				ext4_xattr_inode_free_quota(inode, ea_inode,
-					      le32_to_cpu(entry->e_value_size));
-				iput(ea_inode);
-			}
+		goto cleanup;
+	}
 
+	if (ext4_has_feature_ea_inode(inode->i_sb)) {
+		for (entry = BFIRST(bh); !IS_LAST_ENTRY(entry);
+		     entry = EXT4_XATTR_NEXT(entry)) {
+			if (!entry->e_value_inum)
+				continue;
+			error = ext4_xattr_inode_iget(inode,
+				      le32_to_cpu(entry->e_value_inum),
+				      le32_to_cpu(entry->e_hash),
+				      &ea_inode);
+			if (error)
+				continue;
+			ext4_xattr_inode_free_quota(inode, ea_inode,
+				      le32_to_cpu(entry->e_value_size));
+			iput(ea_inode);
 		}
 
-		ext4_xattr_release_block(handle, inode, bh, ea_inode_array,
-					 extra_credits);
-		/*
-		 * Update i_file_acl value in the same transaction that releases
-		 * block.
-		 */
-		EXT4_I(inode)->i_file_acl = 0;
-		error = ext4_mark_inode_dirty(handle, inode);
-		if (error) {
-			EXT4_ERROR_INODE(inode, "mark inode dirty (error %d)",
-					 error);
-			goto cleanup;
-		}
-		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR, handle);
 	}
-	error = 0;
+
+	ext4_xattr_release_block(handle, inode, bh, ea_inode_array,
+				 extra_credits);
+	/*
+	 * Update i_file_acl value in the same transaction that releases
+	 * block.
+	 */
+	EXT4_I(inode)->i_file_acl = 0;
+	error = ext4_mark_inode_dirty(handle, inode);
+	if (error) {
+		EXT4_ERROR_INODE(inode, "mark inode dirty (error %d)",
+				 error);
+		goto cleanup;
+	}
+	ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR, handle);
 cleanup:
 	brelse(iloc.bh);
 	brelse(bh);
-- 
2.31.1

