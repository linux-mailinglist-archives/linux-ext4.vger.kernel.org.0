Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1653388230
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 20:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437135AbfHISSl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Aug 2019 14:18:41 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60954 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2437085AbfHISSl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Aug 2019 14:18:41 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-107.corp.google.com [104.133.0.107] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x79IIb4I005818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Aug 2019 14:18:37 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B519C4218EF; Fri,  9 Aug 2019 14:18:36 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/3] ext4: return the extent cache information via fiemap
Date:   Fri,  9 Aug 2019 14:18:29 -0400
Message-Id: <20190809181831.10618-1-tytso@mit.edu>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

For debugging reasons, it's useful to know the contents of the extent
cache.  Since the extent cache contains much of what is in the fiemap
ioctl, extend the fiemap interface to return this information via some
ext4-specific flags.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ext4.h           | 11 +++++++++
 fs/ext4/extents.c        | 50 ++++++++++++++++++++++++++++++++++++++++
 fs/ext4/extents_status.c | 20 ++++++++++++++--
 fs/ext4/extents_status.h |  3 +++
 4 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index bf660aa7a9e0..36954d951dff 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -679,6 +679,17 @@ enum {
 #define EXT4_IOC32_SETVERSION_OLD	FS_IOC32_SETVERSION
 #endif
 
+/* Extra ext4-specific fiemap flags */
+#define EXT4_FIEMAP_FLAG_EXTENT_CACHE	0x08000000 /* return the extent status cache */
+
+/* These flags are ext4 specific fiemap flags */
+#define EXT4_SPECIFIC_FIEMAP_FLAGS	(FIEMAP_FLAG_CACHE |\
+					 EXT4_FIEMAP_FLAG_EXTENT_CACHE)
+
+#define EXT4_FIEMAP_EXTENT_HOLE		0x08000000 /* Entry in extent status
+						      cache for a hole*/
+
+
 /* Max physical block we can address w/o extents */
 #define EXT4_MAX_BLOCK_FILE_PHYS	0xFFFFFFFF
 
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 92266a2da7d6..7e4aee57c2f3 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2179,6 +2179,46 @@ static int ext4_fill_fiemap_extents(struct inode *inode,
 	unsigned int flags = 0;
 	unsigned char blksize_bits = inode->i_sb->s_blocksize_bits;
 
+	if (fieinfo->fi_flags & EXT4_FIEMAP_FLAG_EXTENT_CACHE) {
+		ext4_lblk_t next, end = block + num - 1;
+		struct extent_status es;
+		unsigned int flags;
+		int err;
+
+		while (block <= end) {
+			next = 0;
+			flags = 0;
+			if (!ext4_es_lookup_extent2(inode, block, &next, &es))
+				break;
+			if (ext4_es_is_unwritten(&es))
+				flags |= FIEMAP_EXTENT_UNWRITTEN;
+			if (ext4_es_is_delayed(&es))
+				flags |= (FIEMAP_EXTENT_DELALLOC |
+					  FIEMAP_EXTENT_UNKNOWN);
+			if (ext4_es_is_hole(&es))
+				flags |= EXT4_FIEMAP_EXTENT_HOLE;
+			if (next == 0)
+				flags |= FIEMAP_EXTENT_LAST;
+			if (flags & (FIEMAP_EXTENT_DELALLOC|
+				     EXT4_FIEMAP_EXTENT_HOLE))
+				es.es_pblk = 0;
+			else
+				es.es_pblk = ext4_es_pblock(&es);
+			err = fiemap_fill_next_extent(fieinfo,
+				(__u64)es.es_lblk << blksize_bits,
+				(__u64)es.es_pblk << blksize_bits,
+				(__u64)es.es_len << blksize_bits,
+				flags);
+			if (next == 0)
+				break;
+			block = next;
+			if (err < 0)
+				return err;
+			if (err == 1)
+				return 0;
+		}
+		return 0;
+	}
 	while (block < last && block != EXT_MAX_BLOCKS) {
 		num = last - block;
 		/* find extent for this block */
@@ -5059,6 +5099,7 @@ int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		__u64 start, __u64 len)
 {
 	ext4_lblk_t start_blk;
+	unsigned int flags = fieinfo->fi_flags;
 	int error = 0;
 
 	if (ext4_has_inline_data(inode)) {
@@ -5077,6 +5118,13 @@ int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			return error;
 	}
 
+	/*
+	 * Mask out the ext4-specific flags since otherwise
+	 * generic_block_fiemap and fiemap_check_flags will get
+	 * cranky.
+	 */
+	fieinfo->fi_flags &= ~EXT4_SPECIFIC_FIEMAP_FLAGS;
+
 	/* fallback to generic here if not in extents fmt */
 	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
 		return generic_block_fiemap(inode, fieinfo, start, len,
@@ -5085,6 +5133,8 @@ int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (fiemap_check_flags(fieinfo, EXT4_FIEMAP_FLAGS))
 		return -EBADR;
 
+	fieinfo->fi_flags = flags;
+
 	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
 		error = ext4_xattr_fiemap(inode, fieinfo);
 	} else {
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 7521de2dcf3a..6611f06c6cdc 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -898,8 +898,9 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
  *
  * Return: 1 on found, 0 on not
  */
-int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
-			  struct extent_status *es)
+int ext4_es_lookup_extent2(struct inode *inode, ext4_lblk_t lblk,
+			   ext4_lblk_t *next_lblk,
+			   struct extent_status *es)
 {
 	struct ext4_es_tree *tree;
 	struct ext4_es_stats *stats;
@@ -948,6 +949,15 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
 		if (!ext4_es_is_referenced(es1))
 			ext4_es_set_referenced(es1);
 		stats->es_stats_cache_hits++;
+		if (next_lblk) {
+			node = rb_next(&es1->rb_node);
+			if (node) {
+				es1 = rb_entry(node, struct extent_status,
+					       rb_node);
+				*next_lblk = es1->es_lblk;
+			} else
+				*next_lblk = 0;
+		}
 	} else {
 		stats->es_stats_cache_misses++;
 	}
@@ -958,6 +968,12 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
 	return found;
 }
 
+int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
+			  struct extent_status *es)
+{
+	return ext4_es_lookup_extent2(inode, lblk, NULL, es);
+}
+
 static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 			      ext4_lblk_t end)
 {
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 131a8b7df265..391b5251a891 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -141,6 +141,9 @@ extern void ext4_es_find_extent_range(struct inode *inode,
 				      struct extent_status *es);
 extern int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
 				 struct extent_status *es);
+extern int ext4_es_lookup_extent2(struct inode *inode, ext4_lblk_t lblk,
+				  ext4_lblk_t *next_lblk,
+				  struct extent_status *es);
 extern bool ext4_es_scan_range(struct inode *inode,
 			       int (*matching_fn)(struct extent_status *es),
 			       ext4_lblk_t lblk, ext4_lblk_t end);
-- 
2.22.0

