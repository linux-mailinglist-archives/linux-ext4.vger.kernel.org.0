Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF2112DACF
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Dec 2019 19:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfLaSGE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Dec 2019 13:06:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbfLaSGC (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 31 Dec 2019 13:06:02 -0500
Received: from zzz.tds (h75-100-12-111.burkwi.broadband.dynamic.tds.net [75.100.12.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A5AE20718
        for <linux-ext4@vger.kernel.org>; Tue, 31 Dec 2019 18:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577815562;
        bh=0b2oVjlv3RIR0oH1Iiuuu8Xlx1/6SIou/Ey+t7pzKmQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=1feSUfBi0nzZKWM5WLUP6vaBpzOGKwFXfnj4xBWt9Wx3US+SRUhgNXNmErbSwhCbp
         YFFiWXAsquzi+8OdIq1SeHa2jF1zgzp4owCZT5+9BqQ4/WJdYIxKUYk6FLief4F9vP
         ROnhobRgVPI4bjZtKFMFfH31eG4jW6cecCmk94HM=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 4/8] ext4: make some functions static in extents.c
Date:   Tue, 31 Dec 2019 12:04:40 -0600
Message-Id: <20191231180444.46586-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191231180444.46586-1-ebiggers@kernel.org>
References: <20191231180444.46586-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Make the following functions static since they're only used in
extents.c:

	__ext4_ext_dirty()
	ext4_can_extents_be_merged()
	ext4_collapse_range()
	ext4_insert_range()

Also remove the prototype for ext4_ext_writepage_trans_blocks(), as this
function is not defined anywhere.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/ext4.h         |  6 ------
 fs/ext4/ext4_extents.h |  5 -----
 fs/ext4/extents.c      | 22 +++++++++++++++-------
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 0fdc913b0d6c..9b395a2e1cd9 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3251,7 +3251,6 @@ struct ext4_extent;
 #define EXT_MAX_BLOCKS	0xffffffff
 
 extern int ext4_ext_tree_init(handle_t *handle, struct inode *);
-extern int ext4_ext_writepage_trans_blocks(struct inode *, int);
 extern int ext4_ext_index_trans_blocks(struct inode *inode, int extents);
 extern int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 			       struct ext4_map_blocks *map, int flags);
@@ -3271,9 +3270,6 @@ extern int ext4_map_blocks(handle_t *handle, struct inode *inode,
 extern int ext4_ext_calc_credits_for_single_extent(struct inode *inode,
 						   int num,
 						   struct ext4_ext_path *path);
-extern int ext4_can_extents_be_merged(struct inode *inode,
-				      struct ext4_extent *ex1,
-				      struct ext4_extent *ex2);
 extern int ext4_ext_insert_extent(handle_t *, struct inode *,
 				  struct ext4_ext_path **,
 				  struct ext4_extent *, int);
@@ -3289,8 +3285,6 @@ extern int ext4_get_es_cache(struct inode *inode,
 			     struct fiemap_extent_info *fieinfo,
 			     __u64 start, __u64 len);
 extern int ext4_ext_precache(struct inode *inode);
-extern int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len);
-extern int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len);
 extern int ext4_swap_extents(handle_t *handle, struct inode *inode1,
 				struct inode *inode2, ext4_lblk_t lblk1,
 			     ext4_lblk_t lblk2,  ext4_lblk_t count,
diff --git a/fs/ext4/ext4_extents.h b/fs/ext4/ext4_extents.h
index 98bd0e9ee7df..1c216fcc202a 100644
--- a/fs/ext4/ext4_extents.h
+++ b/fs/ext4/ext4_extents.h
@@ -267,10 +267,5 @@ static inline void ext4_idx_store_pblock(struct ext4_extent_idx *ix,
 				     0xffff);
 }
 
-#define ext4_ext_dirty(handle, inode, path) \
-		__ext4_ext_dirty(__func__, __LINE__, (handle), (inode), (path))
-int __ext4_ext_dirty(const char *where, unsigned int line, handle_t *handle,
-		     struct inode *inode, struct ext4_ext_path *path);
-
 #endif /* _EXT4_EXTENTS */
 
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 296ad7fcc302..6c3f8c0ca83b 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -161,8 +161,9 @@ static int ext4_ext_get_access(handle_t *handle, struct inode *inode,
  *  - ENOMEM
  *  - EIO
  */
-int __ext4_ext_dirty(const char *where, unsigned int line, handle_t *handle,
-		     struct inode *inode, struct ext4_ext_path *path)
+static int __ext4_ext_dirty(const char *where, unsigned int line,
+			    handle_t *handle, struct inode *inode,
+			    struct ext4_ext_path *path)
 {
 	int err;
 
@@ -179,6 +180,9 @@ int __ext4_ext_dirty(const char *where, unsigned int line, handle_t *handle,
 	return err;
 }
 
+#define ext4_ext_dirty(handle, inode, path) \
+		__ext4_ext_dirty(__func__, __LINE__, (handle), (inode), (path))
+
 static ext4_fsblk_t ext4_ext_find_goal(struct inode *inode,
 			      struct ext4_ext_path *path,
 			      ext4_lblk_t block)
@@ -1695,9 +1699,9 @@ static int ext4_ext_correct_indexes(handle_t *handle, struct inode *inode,
 	return err;
 }
 
-int
-ext4_can_extents_be_merged(struct inode *inode, struct ext4_extent *ex1,
-				struct ext4_extent *ex2)
+static int ext4_can_extents_be_merged(struct inode *inode,
+				      struct ext4_extent *ex1,
+				      struct ext4_extent *ex2)
 {
 	unsigned short ext1_ee_len, ext2_ee_len;
 
@@ -4656,6 +4660,10 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 	return ret > 0 ? ret2 : ret;
 }
 
+static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len);
+
+static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len);
+
 static long ext4_zero_range(struct file *file, loff_t offset,
 			    loff_t len, int mode)
 {
@@ -5414,7 +5422,7 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
  * This implements the fallocate's collapse range functionality for ext4
  * Returns: 0 and non-zero on error.
  */
-int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
+static int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct super_block *sb = inode->i_sb;
 	ext4_lblk_t punch_start, punch_stop;
@@ -5558,7 +5566,7 @@ int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
  * by len bytes.
  * Returns 0 on success, error otherwise.
  */
-int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
+static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct super_block *sb = inode->i_sb;
 	handle_t *handle;
-- 
2.24.1

