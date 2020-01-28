Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3E4814B275
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2020 11:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgA1KS4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Jan 2020 05:18:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726097AbgA1KSz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 Jan 2020 05:18:55 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SAAG32057186
        for <linux-ext4@vger.kernel.org>; Tue, 28 Jan 2020 05:18:54 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrjmus9xg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Tue, 28 Jan 2020 05:18:53 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 28 Jan 2020 10:18:51 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 Jan 2020 10:18:46 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00SAIjFn60686354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 10:18:46 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E20D4AE04D;
        Tue, 28 Jan 2020 10:18:45 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7F37AE045;
        Tue, 28 Jan 2020 10:18:43 +0000 (GMT)
Received: from dhcp-9-199-158-40.in.ibm.com (unknown [9.199.158.40])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Jan 2020 10:18:43 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        hch@infradead.org, cmaiolino@redhat.com,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFCv2 4/4] ext4: Move ext4_fiemap to use iomap infrastructure
Date:   Tue, 28 Jan 2020 15:48:28 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1580121790.git.riteshh@linux.ibm.com>
References: <cover.1580121790.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012810-0020-0000-0000-000003A4B392
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012810-0021-0000-0000-000021FC5D68
Message-Id: <0147a2923d339bdef5802dde8d5019d719f0d796.1580121790.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_02:2020-01-24,2020-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=592 suspectscore=4
 mlxscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001280083
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since ext4 already defines necessary iomap_ops required to move to iomap
for fiemap, so this patch makes those changes to use existing iomap_ops
for ext4_fiemap and thus removes all unwanted code.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/extents.c | 279 +++++++---------------------------------------
 fs/ext4/inline.c  |  41 -------
 2 files changed, 38 insertions(+), 282 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 0de548bb3c90..901caee2fcb1 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -28,6 +28,7 @@
 #include <linux/uaccess.h>
 #include <linux/fiemap.h>
 #include <linux/backing-dev.h>
+#include <linux/iomap.h>
 #include "ext4_jbd2.h"
 #include "ext4_extents.h"
 #include "xattr.h"
@@ -97,9 +98,6 @@ static int ext4_split_extent_at(handle_t *handle,
 			     int split_flag,
 			     int flags);
 
-static int ext4_find_delayed_extent(struct inode *inode,
-				    struct extent_status *newes);
-
 static int ext4_ext_trunc_restart_fn(struct inode *inode, int *dropped)
 {
 	/*
@@ -2176,155 +2174,6 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 	return err;
 }
 
-static int ext4_fill_fiemap_extents(struct inode *inode,
-				    ext4_lblk_t block, ext4_lblk_t num,
-				    struct fiemap_extent_info *fieinfo)
-{
-	struct ext4_ext_path *path = NULL;
-	struct ext4_extent *ex;
-	struct extent_status es;
-	ext4_lblk_t next, next_del, start = 0, end = 0;
-	ext4_lblk_t last = block + num;
-	int exists, depth = 0, err = 0;
-	unsigned int flags = 0;
-	unsigned char blksize_bits = inode->i_sb->s_blocksize_bits;
-
-	while (block < last && block != EXT_MAX_BLOCKS) {
-		num = last - block;
-		/* find extent for this block */
-		down_read(&EXT4_I(inode)->i_data_sem);
-
-		path = ext4_find_extent(inode, block, &path, 0);
-		if (IS_ERR(path)) {
-			up_read(&EXT4_I(inode)->i_data_sem);
-			err = PTR_ERR(path);
-			path = NULL;
-			break;
-		}
-
-		depth = ext_depth(inode);
-		if (unlikely(path[depth].p_hdr == NULL)) {
-			up_read(&EXT4_I(inode)->i_data_sem);
-			EXT4_ERROR_INODE(inode, "path[%d].p_hdr == NULL", depth);
-			err = -EFSCORRUPTED;
-			break;
-		}
-		ex = path[depth].p_ext;
-		next = ext4_ext_next_allocated_block(path);
-
-		flags = 0;
-		exists = 0;
-		if (!ex) {
-			/* there is no extent yet, so try to allocate
-			 * all requested space */
-			start = block;
-			end = block + num;
-		} else if (le32_to_cpu(ex->ee_block) > block) {
-			/* need to allocate space before found extent */
-			start = block;
-			end = le32_to_cpu(ex->ee_block);
-			if (block + num < end)
-				end = block + num;
-		} else if (block >= le32_to_cpu(ex->ee_block)
-					+ ext4_ext_get_actual_len(ex)) {
-			/* need to allocate space after found extent */
-			start = block;
-			end = block + num;
-			if (end >= next)
-				end = next;
-		} else if (block >= le32_to_cpu(ex->ee_block)) {
-			/*
-			 * some part of requested space is covered
-			 * by found extent
-			 */
-			start = block;
-			end = le32_to_cpu(ex->ee_block)
-				+ ext4_ext_get_actual_len(ex);
-			if (block + num < end)
-				end = block + num;
-			exists = 1;
-		} else {
-			BUG();
-		}
-		BUG_ON(end <= start);
-
-		if (!exists) {
-			es.es_lblk = start;
-			es.es_len = end - start;
-			es.es_pblk = 0;
-		} else {
-			es.es_lblk = le32_to_cpu(ex->ee_block);
-			es.es_len = ext4_ext_get_actual_len(ex);
-			es.es_pblk = ext4_ext_pblock(ex);
-			if (ext4_ext_is_unwritten(ex))
-				flags |= FIEMAP_EXTENT_UNWRITTEN;
-		}
-
-		/*
-		 * Find delayed extent and update es accordingly. We call
-		 * it even in !exists case to find out whether es is the
-		 * last existing extent or not.
-		 */
-		next_del = ext4_find_delayed_extent(inode, &es);
-		if (!exists && next_del) {
-			exists = 1;
-			flags |= (FIEMAP_EXTENT_DELALLOC |
-				  FIEMAP_EXTENT_UNKNOWN);
-		}
-		up_read(&EXT4_I(inode)->i_data_sem);
-
-		if (unlikely(es.es_len == 0)) {
-			EXT4_ERROR_INODE(inode, "es.es_len == 0");
-			err = -EFSCORRUPTED;
-			break;
-		}
-
-		/*
-		 * This is possible iff next == next_del == EXT_MAX_BLOCKS.
-		 * we need to check next == EXT_MAX_BLOCKS because it is
-		 * possible that an extent is with unwritten and delayed
-		 * status due to when an extent is delayed allocated and
-		 * is allocated by fallocate status tree will track both of
-		 * them in a extent.
-		 *
-		 * So we could return a unwritten and delayed extent, and
-		 * its block is equal to 'next'.
-		 */
-		if (next == next_del && next == EXT_MAX_BLOCKS) {
-			flags |= FIEMAP_EXTENT_LAST;
-			if (unlikely(next_del != EXT_MAX_BLOCKS ||
-				     next != EXT_MAX_BLOCKS)) {
-				EXT4_ERROR_INODE(inode,
-						 "next extent == %u, next "
-						 "delalloc extent = %u",
-						 next, next_del);
-				err = -EFSCORRUPTED;
-				break;
-			}
-		}
-
-		if (exists) {
-			err = fiemap_fill_next_extent(fieinfo,
-				(__u64)es.es_lblk << blksize_bits,
-				(__u64)es.es_pblk << blksize_bits,
-				(__u64)es.es_len << blksize_bits,
-				flags);
-			if (err < 0)
-				break;
-			if (err == 1) {
-				err = 0;
-				break;
-			}
-		}
-
-		block = es.es_lblk + es.es_len;
-	}
-
-	ext4_ext_drop_refs(path);
-	kfree(path);
-	return err;
-}
-
 static int ext4_fill_es_cache_info(struct inode *inode,
 				   ext4_lblk_t block, ext4_lblk_t num,
 				   struct fiemap_extent_info *fieinfo)
@@ -5058,62 +4907,10 @@ int ext4_convert_unwritten_io_end_vec(handle_t *handle, ext4_io_end_t *io_end)
 	return ret < 0 ? ret : err;
 }
 
-/*
- * If newes is not existing extent (newes->ec_pblk equals zero) find
- * delayed extent at start of newes and update newes accordingly and
- * return start of the next delayed extent.
- *
- * If newes is existing extent (newes->ec_pblk is not equal zero)
- * return start of next delayed extent or EXT_MAX_BLOCKS if no delayed
- * extent found. Leave newes unmodified.
- */
-static int ext4_find_delayed_extent(struct inode *inode,
-				    struct extent_status *newes)
-{
-	struct extent_status es;
-	ext4_lblk_t block, next_del;
-
-	if (newes->es_pblk == 0) {
-		ext4_es_find_extent_range(inode, &ext4_es_is_delayed,
-					  newes->es_lblk,
-					  newes->es_lblk + newes->es_len - 1,
-					  &es);
-
-		/*
-		 * No extent in extent-tree contains block @newes->es_pblk,
-		 * then the block may stay in 1)a hole or 2)delayed-extent.
-		 */
-		if (es.es_len == 0)
-			/* A hole found. */
-			return 0;
-
-		if (es.es_lblk > newes->es_lblk) {
-			/* A hole found. */
-			newes->es_len = min(es.es_lblk - newes->es_lblk,
-					    newes->es_len);
-			return 0;
-		}
-
-		newes->es_len = es.es_lblk + es.es_len - newes->es_lblk;
-	}
-
-	block = newes->es_lblk + newes->es_len;
-	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, block,
-				  EXT_MAX_BLOCKS, &es);
-	if (es.es_len == 0)
-		next_del = EXT_MAX_BLOCKS;
-	else
-		next_del = es.es_lblk;
-
-	return next_del;
-}
-
-static int ext4_xattr_fiemap(struct inode *inode,
-				struct fiemap_extent_info *fieinfo)
+static int ext4_iomap_xattr_fiemap(struct inode *inode, struct iomap *iomap)
 {
 	__u64 physical = 0;
 	__u64 length;
-	__u32 flags = FIEMAP_EXTENT_LAST;
 	int blockbits = inode->i_sb->s_blocksize_bits;
 	int error = 0;
 
@@ -5130,40 +4927,42 @@ static int ext4_xattr_fiemap(struct inode *inode,
 				EXT4_I(inode)->i_extra_isize;
 		physical += offset;
 		length = EXT4_SB(inode->i_sb)->s_inode_size - offset;
-		flags |= FIEMAP_EXTENT_DATA_INLINE;
 		brelse(iloc.bh);
 	} else { /* external block */
 		physical = (__u64)EXT4_I(inode)->i_file_acl << blockbits;
 		length = inode->i_sb->s_blocksize;
 	}
 
-	if (physical)
-		error = fiemap_fill_next_extent(fieinfo, 0, physical,
-						length, flags);
-	return (error < 0 ? error : 0);
+	iomap->addr = physical;
+	iomap->offset = 0;
+	iomap->length = length;
+	iomap->type = IOMAP_INLINE;
+	iomap->flags = 0;
+	return error;
 }
 
-static int _ext4_fiemap(struct inode *inode,
-			struct fiemap_extent_info *fieinfo,
-			__u64 start, __u64 len,
-			int (*fill)(struct inode *, ext4_lblk_t,
-				    ext4_lblk_t,
-				    struct fiemap_extent_info *))
+static int ext4_iomap_xattr_begin(struct inode *inode, loff_t offset,
+				  loff_t length, unsigned flags,
+				  struct iomap *iomap, struct iomap *srcmap)
 {
-	ext4_lblk_t start_blk;
-	u32 ext4_fiemap_flags = FIEMAP_FLAG_SYNC|FIEMAP_FLAG_XATTR;
-
-	int error = 0;
+	int error;
 
-	if (ext4_has_inline_data(inode)) {
-		int has_inline = 1;
+	error = ext4_iomap_xattr_fiemap(inode, iomap);
+	if (error == 0 && (offset >= iomap->length))
+		error = -ENOENT;
+	return error;
+}
 
-		error = ext4_inline_data_fiemap(inode, fieinfo, &has_inline,
-						start, len);
+const struct iomap_ops ext4_iomap_xattr_ops = {
+	.iomap_begin		= ext4_iomap_xattr_begin,
+};
 
-		if (has_inline)
-			return error;
-	}
+static int _ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+			__u64 start, __u64 len, bool from_es_cache)
+{
+	ext4_lblk_t start_blk;
+	u32 ext4_fiemap_flags = FIEMAP_FLAG_SYNC|FIEMAP_FLAG_XATTR;
+	int error = 0;
 
 	if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
 		error = ext4_ext_precache(inode);
@@ -5172,19 +4971,19 @@ static int _ext4_fiemap(struct inode *inode,
 		fieinfo->fi_flags &= ~FIEMAP_FLAG_CACHE;
 	}
 
-	/* fallback to generic here if not in extents fmt */
-	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) &&
-	    fill == ext4_fill_fiemap_extents)
-		return generic_block_fiemap(inode, fieinfo, start, len,
-			ext4_get_block);
-
-	if (fill == ext4_fill_es_cache_info)
+	if (from_es_cache)
 		ext4_fiemap_flags &= FIEMAP_FLAG_XATTR;
+
 	if (fiemap_check_flags(fieinfo, ext4_fiemap_flags))
 		return -EBADR;
 
 	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
-		error = ext4_xattr_fiemap(inode, fieinfo);
+		fieinfo->fi_flags &= ~FIEMAP_FLAG_XATTR;
+		error = iomap_fiemap(inode, fieinfo, start, len,
+				     &ext4_iomap_xattr_ops);
+	} else if (!from_es_cache) {
+		error = iomap_fiemap(inode, fieinfo, start, len,
+				     &ext4_iomap_report_ops);
 	} else {
 		ext4_lblk_t len_blks;
 		__u64 last_blk;
@@ -5199,7 +4998,8 @@ static int _ext4_fiemap(struct inode *inode,
 		 * Walk the extent tree gathering extent information
 		 * and pushing extents back to the user.
 		 */
-		error = fill(inode, start_blk, len_blks, fieinfo);
+		error = ext4_fill_es_cache_info(inode, start_blk, len_blks,
+						fieinfo);
 	}
 	return error;
 }
@@ -5207,8 +5007,7 @@ static int _ext4_fiemap(struct inode *inode,
 int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		__u64 start, __u64 len)
 {
-	return _ext4_fiemap(inode, fieinfo, start, len,
-			    ext4_fill_fiemap_extents);
+	return _ext4_fiemap(inode, fieinfo, start, len, false);
 }
 
 int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
@@ -5224,11 +5023,9 @@ int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			return 0;
 	}
 
-	return _ext4_fiemap(inode, fieinfo, start, len,
-			    ext4_fill_es_cache_info);
+	return _ext4_fiemap(inode, fieinfo, start, len, true);
 }
 
-
 /*
  * ext4_access_path:
  * Function to access the path buffer for marking it dirty.
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index e61603f47035..b8b99634c832 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1857,47 +1857,6 @@ int ext4_inline_data_iomap(struct inode *inode, struct iomap *iomap)
 	return error;
 }
 
-int ext4_inline_data_fiemap(struct inode *inode,
-			    struct fiemap_extent_info *fieinfo,
-			    int *has_inline, __u64 start, __u64 len)
-{
-	__u64 physical = 0;
-	__u64 inline_len;
-	__u32 flags = FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_NOT_ALIGNED |
-		FIEMAP_EXTENT_LAST;
-	int error = 0;
-	struct ext4_iloc iloc;
-
-	down_read(&EXT4_I(inode)->xattr_sem);
-	if (!ext4_has_inline_data(inode)) {
-		*has_inline = 0;
-		goto out;
-	}
-	inline_len = min_t(size_t, ext4_get_inline_size(inode),
-			   i_size_read(inode));
-	if (start >= inline_len)
-		goto out;
-	if (start + len < inline_len)
-		inline_len = start + len;
-	inline_len -= start;
-
-	error = ext4_get_inode_loc(inode, &iloc);
-	if (error)
-		goto out;
-
-	physical = (__u64)iloc.bh->b_blocknr << inode->i_sb->s_blocksize_bits;
-	physical += (char *)ext4_raw_inode(&iloc) - iloc.bh->b_data;
-	physical += offsetof(struct ext4_inode, i_block);
-
-	brelse(iloc.bh);
-out:
-	up_read(&EXT4_I(inode)->xattr_sem);
-	if (physical)
-		error = fiemap_fill_next_extent(fieinfo, start, physical,
-						inline_len, flags);
-	return (error < 0 ? error : 0);
-}
-
 int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 {
 	handle_t *handle;
-- 
2.21.0

