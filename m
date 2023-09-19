Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8657A5D70
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 11:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjISJJz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Sep 2023 05:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjISJJy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Sep 2023 05:09:54 -0400
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3953E6
        for <linux-ext4@vger.kernel.org>; Tue, 19 Sep 2023 02:09:47 -0700 (PDT)
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
        by cmsmtp with ESMTP
        id iQu2qYDtz6NwhiWjqqy4lT; Tue, 19 Sep 2023 09:09:46 +0000
Received: from webber.adilger.int ([70.77.221.9])
        by cmsmtp with ESMTP
        id iWjhqEziq3fOSiWjqqAHy3; Tue, 19 Sep 2023 09:09:46 +0000
X-Authority-Analysis: v=2.4 cv=J8G5USrS c=1 sm=1 tr=0 ts=6509655a
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=RPJ6JBhKAAAA:8
 a=eSbgsXjRR5QAzI9SCtwA:9 a=fa_un-3J20JGBB2Tu-mn:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH 6/7] misc: deduplicate log2/log10 functions
Date:   Tue, 19 Sep 2023 03:09:32 -0600
Message-Id: <20230919090933.25567-2-adilger@dilger.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230919090933.25567-1-adilger@dilger.ca>
References: <20230919090933.25567-1-adilger@dilger.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfPCG2yr4k6XkOoRJDyDEufunVdxuLpkZcDkuVSVcYVpxa2M4eevwzDuIK3Obo9A4EzSH2t8sA4f58VzKCM5o4MBBH51RP1jUKDNwv2ypdboTRTFrTqkx
 za2CszLU7PWBECpekO821yVEz+Wt6TXM8+9+BMbfdzVz5wpNVuxuhoZmORnoWwpXrD3mf3sjwC2W99JT3E4zQKQHdnAi0XMb9g/Ejq14ZrglBJiBQuSh1dA5
 3BQNNm39FrLrhOa1vlks6g==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Remove duplicate log2() and log10() functions and replace them
with a single pair of functions ext2fs_log2() and ext2fs_log10().

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
Change-Id: Ifc86efe7e5f0243eb914c6d24319cc7dee3ebbe5
---
 debugfs/debugfs.c   | 16 ++--------------
 debugfs/filefrag.c  | 18 +++---------------
 lib/ext2fs/ext2fs.h | 24 ++++++++++++++++++++++++
 lib/ext2fs/extent.c | 17 +++--------------
 misc/e2freefrag.c   | 20 ++++----------------
 misc/e4crypt.c      | 14 +-------------
 misc/filefrag.c     | 32 ++++----------------------------
 misc/mk_hugefiles.c |  2 +-
 misc/mke2fs.c       | 35 +++++++----------------------------
 misc/mke2fs.h       |  1 -
 10 files changed, 49 insertions(+), 130 deletions(-)

diff --git a/debugfs/debugfs.c b/debugfs/debugfs.c
index 742bf794..66428f7d 100644
--- a/debugfs/debugfs.c
+++ b/debugfs/debugfs.c
@@ -652,18 +652,6 @@ static void dump_blocks(FILE *f, const char *prefix, ext2_ino_t inode)
 	fprintf(f,"\n");
 }
 
-static int int_log10(unsigned long long arg)
-{
-	int     l = 0;
-
-	arg = arg / 10;
-	while (arg) {
-		l++;
-		arg = arg / 10;
-	}
-	return l;
-}
-
 #define DUMP_LEAF_EXTENTS	0x01
 #define DUMP_NODE_EXTENTS	0x02
 #define DUMP_EXTENT_TABLE	0x04
@@ -1065,11 +1053,11 @@ void do_dump_extents(int argc, char **argv, int sci_idx EXT2FS_ATTR((unused)),
 		return;
 	}
 
-	logical_width = int_log10((EXT2_I_SIZE(&inode)+current_fs->blocksize-1)/
+	logical_width = ext2fs_log10((EXT2_I_SIZE(&inode)+current_fs->blocksize-1)/
 				  current_fs->blocksize) + 1;
 	if (logical_width < 5)
 		logical_width = 5;
-	physical_width = int_log10(ext2fs_blocks_count(current_fs->super)) + 1;
+	physical_width = ext2fs_log10(ext2fs_blocks_count(current_fs->super)) + 1;
 	if (physical_width < 5)
 		physical_width = 5;
 
diff --git a/debugfs/filefrag.c b/debugfs/filefrag.c
index 31c1440c..080c2c37 100644
--- a/debugfs/filefrag.c
+++ b/debugfs/filefrag.c
@@ -54,18 +54,6 @@ struct filefrag_struct {
 	struct dir_list *dir_list, *dir_last;
 };
 
-static int int_log10(unsigned long long arg)
-{
-	int     l = 0;
-
-	arg = arg / 10;
-	while (arg) {
-		l++;
-		arg = arg / 10;
-	}
-	return l;
-}
-
 static void print_header(struct filefrag_struct *fs)
 {
 	if (fs->options & VERBOSE_OPT) {
@@ -135,8 +123,8 @@ static void filefrag(ext2_ino_t ino, struct ext2_inode *inode,
 	errcode_t	retval;
 	int		blocksize = current_fs->blocksize;
 
-	fs->logical_width = int_log10((EXT2_I_SIZE(inode) + blocksize - 1) /
-				      blocksize) + 1;
+	fs->logical_width = ext2fs_log10((EXT2_I_SIZE(inode) + blocksize - 1) /
+					 blocksize) + 1;
 	if (fs->logical_width < 7)
 		fs->logical_width = 7;
 	fs->ext = 0;
@@ -313,7 +301,7 @@ void do_filefrag(int argc, char *argv[], int sci_idx EXT2FS_ATTR((unused)),
 		return;
 
 	fs.f = open_pager();
-	fs.physical_width = int_log10(ext2fs_blocks_count(current_fs->super));
+	fs.physical_width = ext2fs_log10(ext2fs_blocks_count(current_fs->super));
 	fs.physical_width++;
 	if (fs.physical_width < 8)
 		fs.physical_width = 8;
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index b5477c10..8e02d6b6 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -2119,6 +2119,30 @@ _INLINE_ int ext2fs_htree_intnode_maxrecs(ext2_filsys fs, int blocks)
 						sizeof(struct ext2_dx_entry));
 }
 
+_INLINE_ int ext2fs_log2(unsigned long long arg)
+{
+	int l = 0;
+
+	arg >>= 1;
+	while (arg) {
+		l++;
+		arg >>= 1;
+	}
+	return l;
+}
+
+_INLINE_ int ext2fs_log10(unsigned long long arg)
+{
+	int l = 0;
+
+	arg /= 10;
+	while (arg) {
+		l++;
+		arg /= 10;
+	}
+	return l;
+}
+
 /*
  * This is an efficient, overflow safe way of calculating ceil((1.0 * a) / b)
  */
diff --git a/lib/ext2fs/extent.c b/lib/ext2fs/extent.c
index 82e75ccd..f747a561 100644
--- a/lib/ext2fs/extent.c
+++ b/lib/ext2fs/extent.c
@@ -1720,18 +1720,6 @@ errcode_t ext2fs_extent_get_info(ext2_extent_handle_t handle,
 	return 0;
 }
 
-static int ul_log2(unsigned long arg)
-{
-	int	l = 0;
-
-	arg >>= 1;
-	while (arg) {
-		l++;
-		arg >>= 1;
-	}
-	return l;
-}
-
 size_t ext2fs_max_extent_depth(ext2_extent_handle_t handle)
 {
 	size_t iblock_sz = sizeof(((struct ext2_inode *)NULL)->i_block);
@@ -1746,8 +1734,9 @@ size_t ext2fs_max_extent_depth(ext2_extent_handle_t handle)
 	if (last_blocksize && last_blocksize == handle->fs->blocksize)
 		return last_result;
 
-	last_result = 1 + ((ul_log2(EXT_MAX_EXTENT_LBLK) - ul_log2(iblock_extents)) /
-		    ul_log2(extents_per_block));
+	last_result = 1 + ((ext2fs_log2(EXT_MAX_EXTENT_LBLK) -
+			    ext2fs_log2(iblock_extents)) /
+			   ext2fs_log2(extents_per_block));
 	last_blocksize = handle->fs->blocksize;
 	return last_result;
 }
diff --git a/misc/e2freefrag.c b/misc/e2freefrag.c
index 04f155b6..903789f0 100644
--- a/misc/e2freefrag.c
+++ b/misc/e2freefrag.c
@@ -57,28 +57,16 @@ static void usage(const char *prog)
 #endif
 }
 
-static int ul_log2(unsigned long arg)
-{
-        int     l = 0;
-
-        arg >>= 1;
-        while (arg) {
-                l++;
-                arg >>= 1;
-        }
-        return l;
-}
-
 static void init_chunk_info(ext2_filsys fs, struct chunk_info *info)
 {
 	int i;
 
-	info->blocksize_bits = ul_log2((unsigned long)fs->blocksize);
+	info->blocksize_bits = ext2fs_log2(fs->blocksize);
 	if (info->chunkbytes) {
-		info->chunkbits = ul_log2(info->chunkbytes);
+		info->chunkbits = ext2fs_log2(info->chunkbytes);
 		info->blks_in_chunk = info->chunkbytes >> info->blocksize_bits;
 	} else {
-		info->chunkbits = ul_log2(DEFAULT_CHUNKSIZE);
+		info->chunkbits = ext2fs_log2(DEFAULT_CHUNKSIZE);
 		info->blks_in_chunk = DEFAULT_CHUNKSIZE >> info->blocksize_bits;
 	}
 
@@ -97,7 +85,7 @@ static void update_chunk_stats(struct chunk_info *info,
 {
 	unsigned long idx;
 
-	idx = ul_log2(chunk_size) + 1;
+	idx = ext2fs_log2(chunk_size) + 1;
 	if (idx >= MAX_HIST)
 		idx = MAX_HIST-1;
 	info->histogram.fc_chunks[idx]++;
diff --git a/misc/e4crypt.c b/misc/e4crypt.c
index 67d25d88..6f23927d 100644
--- a/misc/e4crypt.c
+++ b/misc/e4crypt.c
@@ -114,18 +114,6 @@ static const size_t hexchars_size = 16;
 #define EXT4_IOC_SET_ENCRYPTION_POLICY      _IOR('f', 19, struct ext4_encryption_policy)
 #define EXT4_IOC_GET_ENCRYPTION_POLICY      _IOW('f', 21, struct ext4_encryption_policy)
 
-static int int_log2(int arg)
-{
-	int     l = 0;
-
-	arg >>= 1;
-	while (arg) {
-		l++;
-		arg >>= 1;
-	}
-	return l;
-}
-
 static void validate_paths(int argc, char *argv[], int path_start_index)
 {
 	int x;
@@ -386,7 +374,7 @@ static void set_policy(struct salt *set_salt, int pad,
 			EXT4_ENCRYPTION_MODE_AES_256_XTS;
 		policy.filenames_encryption_mode =
 			EXT4_ENCRYPTION_MODE_AES_256_CTS;
-		policy.flags = int_log2(pad >> 2);
+		policy.flags = ext2fs_log2(pad >> 2);
 		memcpy(policy.master_key_descriptor, salt->key_desc,
 		       EXT4_KEY_DESCRIPTOR_SIZE);
 		rc = ioctl(fd, EXT4_IOC_SET_ENCRYPTION_POLICY, &policy);
diff --git a/misc/filefrag.c b/misc/filefrag.c
index eaaa90a8..13a533e5 100644
--- a/misc/filefrag.c
+++ b/misc/filefrag.c
@@ -76,30 +76,6 @@ const char *hex_fmt = "%4d: %*llx..%*llx: %*llx..%*llx: %6llx: %s\n";
 #define	EXT4_EXTENTS_FL			0x00080000 /* Inode uses extents */
 #define	EXT3_IOC_GETFLAGS		_IOR('f', 1, long)
 
-static int ulong_log2(unsigned long arg)
-{
-	int     l = 0;
-
-	arg >>= 1;
-	while (arg) {
-		l++;
-		arg >>= 1;
-	}
-	return l;
-}
-
-static int ulong_log10(unsigned long long arg)
-{
-	int     l = 0;
-
-	arg = arg / 10;
-	while (arg) {
-		l++;
-		arg = arg / 10;
-	}
-	return l;
-}
-
 static unsigned int div_ceil(unsigned int a, unsigned int b)
 {
 	if (!a)
@@ -483,20 +459,20 @@ static int frag_report(const char *filename)
 	}
 	last_device = st.st_dev;
 
-	width = ulong_log10(fsinfo.f_blocks);
+	width = ext2fs_log10(fsinfo.f_blocks);
 	if (width > physical_width)
 		physical_width = width;
 
 	numblocks = (st.st_size + blksize - 1) / blksize;
 	if (blocksize != 0)
-		blk_shift = ulong_log2(blocksize);
+		blk_shift = ext2fs_log2(blocksize);
 	else
-		blk_shift = ulong_log2(blksize);
+		blk_shift = ext2fs_log2(blksize);
 
 	if (use_extent_cache)
 		width = 10;
 	else
-		width = ulong_log10(numblocks);
+		width = ext2fs_log10(numblocks);
 	if (width > logical_width)
 		logical_width = width;
 	if (verbose) {
diff --git a/misc/mk_hugefiles.c b/misc/mk_hugefiles.c
index 3caaf1b6..17788bcd 100644
--- a/misc/mk_hugefiles.c
+++ b/misc/mk_hugefiles.c
@@ -417,7 +417,7 @@ errcode_t mk_hugefiles(ext2_filsys fs, const char *device_name)
 	fn_prefix = get_string_from_profile(fs_types, "hugefiles_name",
 					    "hugefile");
 	idx_digits = get_int_from_profile(fs_types, "hugefiles_digits", 5);
-	d = int_log10(num_files) + 1;
+	d = ext2fs_log10(num_files) + 1;
 	if (idx_digits > d)
 		d = idx_digits;
 	dsize = strlen(fn_prefix) + d + 16;
diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index ba5f179a..c6e26e70 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -144,27 +144,6 @@ static void usage(void)
 	exit(1);
 }
 
-static int int_log2(unsigned long long arg)
-{
-	int	l = 0;
-
-	arg >>= 1;
-	while (arg) {
-		l++;
-		arg >>= 1;
-	}
-	return l;
-}
-
-int int_log10(unsigned long long arg)
-{
-	int	l;
-
-	for (l=0; arg ; l++)
-		arg = arg / 10;
-	return l;
-}
-
 #ifdef __linux__
 static int parse_version_number(const char *s)
 {
@@ -743,7 +722,7 @@ skip_details:
 			continue;
 		if (i != 1)
 			printf(", ");
-		need = int_log10(group_block) + 2;
+		need = ext2fs_log10(group_block) + 2;
 		if (need > col_left) {
 			printf("\n\t");
 			col_left = 72;
@@ -1669,8 +1648,8 @@ profile_error:
 					blocksize);
 			if (blocksize > 0)
 				fs_param.s_log_block_size =
-					int_log2(blocksize >>
-						 EXT2_MIN_BLOCK_LOG_SIZE);
+					ext2fs_log2(blocksize >>
+						    EXT2_MIN_BLOCK_LOG_SIZE);
 			break;
 		case 'c':	/* Check for bad blocks */
 			cflag++;
@@ -1949,7 +1928,7 @@ profile_error:
 		blocksize = jfs->blocksize;
 		printf(_("Using journal device's blocksize: %d\n"), blocksize);
 		fs_param.s_log_block_size =
-			int_log2(blocksize >> EXT2_MIN_BLOCK_LOG_SIZE);
+			ext2fs_log2(blocksize >> EXT2_MIN_BLOCK_LOG_SIZE);
 		ext2fs_close_free(&jfs);
 	}
 
@@ -2188,7 +2167,7 @@ profile_error:
 	}
 
 	fs_param.s_log_block_size =
-		int_log2(blocksize >> EXT2_MIN_BLOCK_LOG_SIZE);
+		ext2fs_log2(blocksize >> EXT2_MIN_BLOCK_LOG_SIZE);
 
 	/*
 	 * We now need to do a sanity check of fs_blocks_count for
@@ -2312,7 +2291,7 @@ profile_error:
 							    "cluster_size",
 							    blocksize*16);
 		fs_param.s_log_cluster_size =
-			int_log2(cluster_size >> EXT2_MIN_CLUSTER_LOG_SIZE);
+			ext2fs_log2(cluster_size >> EXT2_MIN_CLUSTER_LOG_SIZE);
 		if (fs_param.s_log_cluster_size &&
 		    fs_param.s_log_cluster_size < fs_param.s_log_block_size) {
 			com_err(program_name, 0, "%s",
@@ -2580,7 +2559,7 @@ profile_error:
 				  "flex_bg size may not be specified"));
 			exit(1);
 		}
-		fs_param.s_log_groups_per_flex = int_log2(flex_bg_size);
+		fs_param.s_log_groups_per_flex = ext2fs_log2(flex_bg_size);
 	}
 
 	if (inode_size && fs_param.s_rev_level >= EXT2_DYNAMIC_REV) {
diff --git a/misc/mke2fs.h b/misc/mke2fs.h
index ce72cb3f..c718fceb 100644
--- a/misc/mke2fs.h
+++ b/misc/mke2fs.h
@@ -21,7 +21,6 @@ extern char *get_string_from_profile(char **types, const char *opt,
 				     const char *def_val);
 extern int get_int_from_profile(char **types, const char *opt, int def_val);
 extern int get_bool_from_profile(char **types, const char *opt, int def_val);
-extern int int_log10(unsigned long long arg);
 
 /* mk_hugefiles.c */
 extern errcode_t mk_hugefiles(ext2_filsys fs, const char *device_name);
-- 
2.25.1

