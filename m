Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08D7B89366
	for <lists+linux-ext4@lfdr.de>; Sun, 11 Aug 2019 21:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfHKTvc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Aug 2019 15:51:32 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40230 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726155AbfHKTvb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 11 Aug 2019 15:51:31 -0400
Received: from callcc.thunk.org (199-127-56.static.fiberhub.net [199.127.56.122] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7BJpGIc007998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Aug 2019 15:51:27 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 339FE4218F1; Sun, 11 Aug 2019 15:51:14 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH v2 3/3] ext4: add new ioctl EXT4_IOC_GET_ES_CACHE
Date:   Sun, 11 Aug 2019 15:51:08 -0400
Message-Id: <20190811195108.24308-3-tytso@mit.edu>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811195108.24308-1-tytso@mit.edu>
References: <20190811195108.24308-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

For debugging reasons, it's useful to know the contents of the extent
cache.  Since the extent cache contains much of what is in the fiemap
ioctl, use an fiemap-style interface to return this information.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ext4.h           | 10 +++++
 fs/ext4/extents.c        | 94 ++++++++++++++++++++++++++++++++++++----
 fs/ext4/extents_status.c | 10 +++++
 fs/ext4/extents_status.h |  1 +
 fs/ext4/inode.c          |  6 +--
 fs/ext4/ioctl.c          | 72 ++++++++++++++++++++++++++++++
 6 files changed, 182 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index ee296797bcd2..e2d8ad27f4d1 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -652,6 +652,7 @@ enum {
 /* ioctl codes 19--39 are reserved for fscrypt */
 #define EXT4_IOC_CLEAR_ES_CACHE		_IO('f', 40)
 #define EXT4_IOC_GETSTATE		_IOW('f', 41, __u32)
+#define EXT4_IOC_GET_ES_CACHE		_IOWR('f', 42, struct fiemap)
 
 #define EXT4_IOC_FSGETXATTR		FS_IOC_FSGETXATTR
 #define EXT4_IOC_FSSETXATTR		FS_IOC_FSSETXATTR
@@ -692,6 +693,12 @@ enum {
 #define EXT4_IOC32_SETVERSION_OLD	FS_IOC32_SETVERSION
 #endif
 
+/*
+ * Returned by EXT4_IOC_GET_ES_CACHE as an additional possible flag.
+ * It indicates that the entry in extent status cache is for a hole.
+ */
+#define EXT4_FIEMAP_EXTENT_HOLE		0x08000000
+
 /* Max physical block we can address w/o extents */
 #define EXT4_MAX_BLOCK_FILE_PHYS	0xFFFFFFFF
 
@@ -3258,6 +3265,9 @@ extern int ext4_ext_check_inode(struct inode *inode);
 extern ext4_lblk_t ext4_ext_next_allocated_block(struct ext4_ext_path *path);
 extern int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			__u64 start, __u64 len);
+extern int ext4_get_es_cache(struct inode *inode,
+			     struct fiemap_extent_info *fieinfo,
+			     __u64 start, __u64 len);
 extern int ext4_ext_precache(struct inode *inode);
 extern int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len);
 extern int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 92266a2da7d6..0620d495fd8a 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2315,6 +2315,52 @@ static int ext4_fill_fiemap_extents(struct inode *inode,
 	return err;
 }
 
+static int ext4_fill_es_cache_info(struct inode *inode,
+				   ext4_lblk_t block, ext4_lblk_t num,
+				   struct fiemap_extent_info *fieinfo)
+{
+	ext4_lblk_t next, end = block + num - 1;
+	struct extent_status es;
+	unsigned char blksize_bits = inode->i_sb->s_blocksize_bits;
+	unsigned int flags;
+	int err;
+
+	while (block <= end) {
+		next = 0;
+		flags = 0;
+		if (!ext4_es_lookup_extent(inode, block, &next, &es))
+			break;
+		if (ext4_es_is_unwritten(&es))
+			flags |= FIEMAP_EXTENT_UNWRITTEN;
+		if (ext4_es_is_delayed(&es))
+			flags |= (FIEMAP_EXTENT_DELALLOC |
+				  FIEMAP_EXTENT_UNKNOWN);
+		if (ext4_es_is_hole(&es))
+			flags |= EXT4_FIEMAP_EXTENT_HOLE;
+		if (next == 0)
+			flags |= FIEMAP_EXTENT_LAST;
+		if (flags & (FIEMAP_EXTENT_DELALLOC|
+			     EXT4_FIEMAP_EXTENT_HOLE))
+			es.es_pblk = 0;
+		else
+			es.es_pblk = ext4_es_pblock(&es);
+		err = fiemap_fill_next_extent(fieinfo,
+				(__u64)es.es_lblk << blksize_bits,
+				(__u64)es.es_pblk << blksize_bits,
+				(__u64)es.es_len << blksize_bits,
+				flags);
+		if (next == 0)
+			break;
+		block = next;
+		if (err < 0)
+			return err;
+		if (err == 1)
+			return 0;
+	}
+	return 0;
+}
+
+
 /*
  * ext4_ext_determine_hole - determine hole around given block
  * @inode:	inode we lookup in
@@ -5017,8 +5063,6 @@ static int ext4_find_delayed_extent(struct inode *inode,
 
 	return next_del;
 }
-/* fiemap flags we can handle specified here */
-#define EXT4_FIEMAP_FLAGS	(FIEMAP_FLAG_SYNC|FIEMAP_FLAG_XATTR)
 
 static int ext4_xattr_fiemap(struct inode *inode,
 				struct fiemap_extent_info *fieinfo)
@@ -5055,10 +5099,16 @@ static int ext4_xattr_fiemap(struct inode *inode,
 	return (error < 0 ? error : 0);
 }
 
-int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
-		__u64 start, __u64 len)
+static int _ext4_fiemap(struct inode *inode,
+			struct fiemap_extent_info *fieinfo,
+			__u64 start, __u64 len,
+			int (*fill)(struct inode *, ext4_lblk_t,
+				    ext4_lblk_t,
+				    struct fiemap_extent_info *))
 {
 	ext4_lblk_t start_blk;
+	u32 ext4_fiemap_flags = FIEMAP_FLAG_SYNC|FIEMAP_FLAG_XATTR;
+
 	int error = 0;
 
 	if (ext4_has_inline_data(inode)) {
@@ -5075,14 +5125,18 @@ int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		error = ext4_ext_precache(inode);
 		if (error)
 			return error;
+		fieinfo->fi_flags &= ~FIEMAP_FLAG_CACHE;
 	}
 
 	/* fallback to generic here if not in extents fmt */
-	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
+	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) &&
+	    fill == ext4_fill_fiemap_extents)
 		return generic_block_fiemap(inode, fieinfo, start, len,
 			ext4_get_block);
 
-	if (fiemap_check_flags(fieinfo, EXT4_FIEMAP_FLAGS))
+	if (fill == ext4_fill_es_cache_info)
+		ext4_fiemap_flags &= FIEMAP_FLAG_XATTR;
+	if (fiemap_check_flags(fieinfo, ext4_fiemap_flags))
 		return -EBADR;
 
 	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
@@ -5101,12 +5155,36 @@ int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		 * Walk the extent tree gathering extent information
 		 * and pushing extents back to the user.
 		 */
-		error = ext4_fill_fiemap_extents(inode, start_blk,
-						 len_blks, fieinfo);
+		error = fill(inode, start_blk, len_blks, fieinfo);
 	}
 	return error;
 }
 
+int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		__u64 start, __u64 len)
+{
+	return _ext4_fiemap(inode, fieinfo, start, len,
+			    ext4_fill_fiemap_extents);
+}
+
+int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		      __u64 start, __u64 len)
+{
+	if (ext4_has_inline_data(inode)) {
+		int has_inline;
+
+		down_read(&EXT4_I(inode)->xattr_sem);
+		has_inline = ext4_has_inline_data(inode);
+		up_read(&EXT4_I(inode)->xattr_sem);
+		if (has_inline)
+			return 0;
+	}
+
+	return _ext4_fiemap(inode, fieinfo, start, len,
+			    ext4_fill_es_cache_info);
+}
+
+
 /*
  * ext4_access_path:
  * Function to access the path buffer for marking it dirty.
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 02cc8eb3eb0e..a959adc59bcd 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -899,6 +899,7 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
  * Return: 1 on found, 0 on not
  */
 int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
+			  ext4_lblk_t *next_lblk,
 			  struct extent_status *es)
 {
 	struct ext4_es_tree *tree;
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
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index e16785f431e7..eb56a1289031 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -140,6 +140,7 @@ extern void ext4_es_find_extent_range(struct inode *inode,
 				      ext4_lblk_t lblk, ext4_lblk_t end,
 				      struct extent_status *es);
 extern int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
+				 ext4_lblk_t *next_lblk,
 				 struct extent_status *es);
 extern bool ext4_es_scan_range(struct inode *inode,
 			       int (*matching_fn)(struct extent_status *es),
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index a6523516d681..4b92c7603907 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -527,7 +527,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		return -EFSCORRUPTED;
 
 	/* Lookup extent status tree firstly */
-	if (ext4_es_lookup_extent(inode, map->m_lblk, &es)) {
+	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
 		if (ext4_es_is_written(&es) || ext4_es_is_unwritten(&es)) {
 			map->m_pblk = ext4_es_pblock(&es) +
 					map->m_lblk - es.es_lblk;
@@ -695,7 +695,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		 * extent status tree.
 		 */
 		if ((flags & EXT4_GET_BLOCKS_PRE_IO) &&
-		    ext4_es_lookup_extent(inode, map->m_lblk, &es)) {
+		    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
 			if (ext4_es_is_written(&es))
 				goto out_sem;
 		}
@@ -1868,7 +1868,7 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 		  (unsigned long) map->m_lblk);
 
 	/* Lookup extent status tree firstly */
-	if (ext4_es_lookup_extent(inode, iblock, &es)) {
+	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
 		if (ext4_es_is_hole(&es)) {
 			retval = 0;
 			down_read(&EXT4_I(inode)->i_data_sem);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index ffb7bde4900d..d6242b7b8718 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -745,6 +745,74 @@ static void ext4_fill_fsxattr(struct inode *inode, struct fsxattr *fa)
 		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
 }
 
+/* copied from fs/ioctl.c */
+static int fiemap_check_ranges(struct super_block *sb,
+			       u64 start, u64 len, u64 *new_len)
+{
+	u64 maxbytes = (u64) sb->s_maxbytes;
+
+	*new_len = len;
+
+	if (len == 0)
+		return -EINVAL;
+
+	if (start > maxbytes)
+		return -EFBIG;
+
+	/*
+	 * Shrink request scope to what the fs can actually handle.
+	 */
+	if (len > maxbytes || (maxbytes - len) < start)
+		*new_len = maxbytes - start;
+
+	return 0;
+}
+
+/* So that the fiemap access checks can't overflow on 32 bit machines. */
+#define FIEMAP_MAX_EXTENTS	(UINT_MAX / sizeof(struct fiemap_extent))
+
+static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
+{
+	struct fiemap fiemap;
+	struct fiemap __user *ufiemap = (struct fiemap __user *) arg;
+	struct fiemap_extent_info fieinfo = { 0, };
+	struct inode *inode = file_inode(filp);
+	struct super_block *sb = inode->i_sb;
+	u64 len;
+	int error;
+
+	if (copy_from_user(&fiemap, ufiemap, sizeof(fiemap)))
+		return -EFAULT;
+
+	if (fiemap.fm_extent_count > FIEMAP_MAX_EXTENTS)
+		return -EINVAL;
+
+	error = fiemap_check_ranges(sb, fiemap.fm_start, fiemap.fm_length,
+				    &len);
+	if (error)
+		return error;
+
+	fieinfo.fi_flags = fiemap.fm_flags;
+	fieinfo.fi_extents_max = fiemap.fm_extent_count;
+	fieinfo.fi_extents_start = ufiemap->fm_extents;
+
+	if (fiemap.fm_extent_count != 0 &&
+	    !access_ok(fieinfo.fi_extents_start,
+		       fieinfo.fi_extents_max * sizeof(struct fiemap_extent)))
+		return -EFAULT;
+
+	if (fieinfo.fi_flags & FIEMAP_FLAG_SYNC)
+		filemap_write_and_wait(inode->i_mapping);
+
+	error = ext4_get_es_cache(inode, &fieinfo, fiemap.fm_start, len);
+	fiemap.fm_flags = fieinfo.fi_flags;
+	fiemap.fm_mapped_extents = fieinfo.fi_extents_mapped;
+	if (copy_to_user(ufiemap, &fiemap, sizeof(fiemap)))
+		error = -EFAULT;
+
+	return error;
+}
+
 long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -1139,6 +1207,9 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return put_user(state, (__u32 __user *) arg);
 	}
 
+	case EXT4_IOC_GET_ES_CACHE:
+		return ext4_ioctl_get_es_cache(filp, arg);
+
 	case EXT4_IOC_FSGETXATTR:
 	{
 		struct fsxattr fa;
@@ -1259,6 +1330,7 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case FS_IOC_GETFSMAP:
 	case EXT4_IOC_CLEAR_ES_CACHE:
 	case EXT4_IOC_GETSTATE:
+	case EXT4_IOC_GET_ES_CACHE:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.22.0

