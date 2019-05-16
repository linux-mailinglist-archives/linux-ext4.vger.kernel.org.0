Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7282220316
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2019 12:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfEPKD1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 May 2019 06:03:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:48412 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726336AbfEPKD0 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 16 May 2019 06:03:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6CAC5AFA8;
        Thu, 16 May 2019 10:03:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C576F1E3ED9; Thu, 16 May 2019 12:03:23 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     cgxu519@zoho.com.cn, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] ext2: Strengthen xattr block checks
Date:   Thu, 16 May 2019 12:03:22 +0200
Message-Id: <20190516100322.12632-4-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190516100322.12632-1-jack@suse.cz>
References: <20190516100322.12632-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Check every entry in xattr block for validity in ext2_xattr_set() to
detect on disk corruption early. Also since e_value_block field in xattr
entry is never != 0 in a valid filesystem, just remove checks for it
once we have established entries are valid.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/xattr.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index f9fda6d16d78..d21dbf297b74 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -218,6 +218,8 @@ ext2_xattr_get(struct inode *inode, int name_index, const char *name,
 			EXT2_XATTR_NEXT(entry);
 		if ((char *)next >= end)
 			goto bad_block;
+		if (!ext2_xattr_entry_valid(entry, inode->i_sb->s_blocksize))
+			goto bad_block;
 		if (name_index == entry->e_name_index &&
 		    name_len == entry->e_name_len &&
 		    memcmp(name, entry->e_name, name_len) == 0)
@@ -229,9 +231,6 @@ ext2_xattr_get(struct inode *inode, int name_index, const char *name,
 	error = -ENODATA;
 	goto cleanup;
 found:
-	if (!ext2_xattr_entry_valid(entry, inode->i_sb->s_blocksize))
-		goto bad_block;
-
 	size = le32_to_cpu(entry->e_value_size);
 	if (ext2_xattr_cache_insert(ea_block_cache, bh))
 		ea_idebug(inode, "cache insert failed");
@@ -304,6 +303,8 @@ ext2_xattr_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 
 		if ((char *)next >= end)
 			goto bad_block;
+		if (!ext2_xattr_entry_valid(entry, inode->i_sb->s_blocksize))
+			goto bad_block;
 		entry = next;
 	}
 	if (ext2_xattr_cache_insert(ea_block_cache, bh))
@@ -446,7 +447,9 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 			struct ext2_xattr_entry *next = EXT2_XATTR_NEXT(last);
 			if ((char *)next >= end)
 				goto bad_block;
-			if (!last->e_value_block && last->e_value_size) {
+			if (!ext2_xattr_entry_valid(last, sb->s_blocksize))
+				goto bad_block;
+			if (last->e_value_size) {
 				size_t offs = le16_to_cpu(last->e_value_offs);
 				if (offs < min_offs)
 					min_offs = offs;
@@ -489,12 +492,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 		error = -EEXIST;
 		if (flags & XATTR_CREATE)
 			goto cleanup;
-		if (!here->e_value_block && here->e_value_size) {
-			if (!ext2_xattr_entry_valid(here, sb->s_blocksize))
-				goto bad_block;
-			free += EXT2_XATTR_SIZE(
-					le32_to_cpu(here->e_value_size));
-		}
+		free += EXT2_XATTR_SIZE(le32_to_cpu(here->e_value_size));
 		free += EXT2_XATTR_LEN(name_len);
 	}
 	error = -ENOSPC;
@@ -559,7 +557,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 		here->e_name_len = name_len;
 		memcpy(here->e_name, name, name_len);
 	} else {
-		if (!here->e_value_block && here->e_value_size) {
+		if (here->e_value_size) {
 			char *first_val = (char *)header + min_offs;
 			size_t offs = le16_to_cpu(here->e_value_offs);
 			char *val = (char *)header + offs;
@@ -586,7 +584,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 			last = ENTRY(header+1);
 			while (!IS_LAST_ENTRY(last)) {
 				size_t o = le16_to_cpu(last->e_value_offs);
-				if (!last->e_value_block && o < offs)
+				if (o < offs)
 					last->e_value_offs =
 						cpu_to_le16(o + size);
 				last = EXT2_XATTR_NEXT(last);
-- 
2.16.4

