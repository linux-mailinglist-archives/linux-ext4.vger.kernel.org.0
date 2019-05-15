Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4244E1F629
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2019 16:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfEOOBy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 May 2019 10:01:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:43242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727179AbfEOOBy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 May 2019 10:01:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 287F2AF8F;
        Wed, 15 May 2019 14:01:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3D1341E3C4B; Wed, 15 May 2019 16:01:51 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Chengguang Xu <cgxu519@zoho.com.cn>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/3] ext2: introduce helper for xattr entry validation
Date:   Wed, 15 May 2019 16:01:42 +0200
Message-Id: <20190515140144.1183-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190515140144.1183-1-jack@suse.cz>
References: <20190515140144.1183-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chengguang Xu <cgxu519@zoho.com.cn>

Introduce helper function ext2_xattr_entry_valid()
for xattr entry validation and clean up the entry
check related code.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/xattr.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index db27260d6a5b..fb2e008d4406 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -144,6 +144,22 @@ ext2_xattr_header_valid(struct ext2_xattr_header *header)
 	return true;
 }
 
+static bool
+ext2_xattr_entry_valid(struct ext2_xattr_entry *entry, size_t end_offs)
+{
+	size_t size;
+
+	if (entry->e_value_block != 0)
+		return false;
+
+	size = le32_to_cpu(entry->e_value_size);
+	if (size > end_offs ||
+	    le16_to_cpu(entry->e_value_offs) + size > end_offs)
+		return false;
+
+	return true;
+}
+
 /*
  * ext2_xattr_get()
  *
@@ -213,14 +229,10 @@ ext2_xattr_get(struct inode *inode, int name_index, const char *name,
 	error = -ENODATA;
 	goto cleanup;
 found:
-	/* check the buffer size */
-	if (entry->e_value_block != 0)
-		goto bad_block;
-	size = le32_to_cpu(entry->e_value_size);
-	if (size > inode->i_sb->s_blocksize ||
-	    le16_to_cpu(entry->e_value_offs) + size > inode->i_sb->s_blocksize)
+	if (!ext2_xattr_entry_valid(entry, inode->i_sb->s_blocksize))
 		goto bad_block;
 
+	size = le32_to_cpu(entry->e_value_size);
 	if (ext2_xattr_cache_insert(ea_block_cache, bh))
 		ea_idebug(inode, "cache insert failed");
 	if (buffer) {
@@ -481,12 +493,10 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 		if (flags & XATTR_CREATE)
 			goto cleanup;
 		if (!here->e_value_block && here->e_value_size) {
-			size_t size = le32_to_cpu(here->e_value_size);
-
-			if (le16_to_cpu(here->e_value_offs) + size > 
-			    sb->s_blocksize || size > sb->s_blocksize)
+			if (!ext2_xattr_entry_valid(here, sb->s_blocksize))
 				goto bad_block;
-			free += EXT2_XATTR_SIZE(size);
+			free += EXT2_XATTR_SIZE(
+					le32_to_cpu(here->e_value_size));
 		}
 		free += EXT2_XATTR_LEN(name_len);
 	}
-- 
2.16.4

