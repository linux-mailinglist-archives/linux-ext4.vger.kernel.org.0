Return-Path: <linux-ext4+bounces-6130-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8DFA13089
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jan 2025 02:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D83165BCE
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jan 2025 01:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A961CAA4;
	Thu, 16 Jan 2025 01:13:39 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from omta003.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACB4BA53
	for <linux-ext4@vger.kernel.org>; Thu, 16 Jan 2025 01:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.97.99.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990019; cv=none; b=eEMLG141vfP/2xxDh7Md4vyTEVZiz1CxyVI5/JZ3TPl7syRpDrku0dA3+UvZNZKj+oa2Dg6bh/dWz/wUJLpz8St8ydwhFGAqBORY4uBFmPzr5yQW96xeFeoYvat2z4FMi3rRGrqkUUwFS9+8qyootvnFs8IL8URA0TDroVmCC5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990019; c=relaxed/simple;
	bh=jTugw8wO9TdzNrUGQNzpKS2xMFRCmYFyUBfMHXeI3FU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lbkANowEKkWZSfe7wuE7qxPolp7LCxz+AYM+QiHErajzcOCRXfuoSt6DQpRsJ0Ua4z2cPTZJO5HPFKrNehzcw8JGCaF9G575CMhtNmU9UyLSQpq0S3Oc5FcPoTXbfhHMNIevCbEo3dPthiBK4irVs7D8jIkNpmYYj8Wt8le5Z5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=whamcloud.com; spf=fail smtp.mailfrom=whamcloud.com; arc=none smtp.client-ip=3.97.99.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=whamcloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=whamcloud.com
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
	by cmsmtp with ESMTPS
	id Y5e1tILMbxv7PYEQStJCII; Thu, 16 Jan 2025 01:12:00 +0000
Received: from localhost.localdomain ([70.77.200.158])
	by cmsmtp with ESMTP
	id YEQRt2t64l5eGYEQRtGCPb; Thu, 16 Jan 2025 01:12:00 +0000
X-Authority-Analysis: v=2.4 cv=EO6l0EZC c=1 sm=1 tr=0 ts=67885ce0
 a=0Thh8+fbYSyN3T2vM72L7A==:117 a=0Thh8+fbYSyN3T2vM72L7A==:17 a=ySfo2T4IAAAA:8
 a=lB0dNpNiAAAA:8 a=eSbgsXjRR5QAzI9SCtwA:9 a=ZUkhVnNHqyo2at-WnAgH:22
 a=c-ZiYqmG3AbHTdtsH08C:22
From: Andreas Dilger <adilger@whamcloud.com>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org,
	Andreas Dilger <adilger@whamcloud.com>,
	Li Dongyang <dongyangli@ddn.com>
Subject: [PATCH 1/2] misc: deduplicate log2/log10 functions
Date: Wed, 15 Jan 2025 18:11:49 -0700
Message-Id: <20250116011150.55313-1-adilger@whamcloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfP1SWsKUNHr7f+UdO/E9FH8nfH/XfFa6B+kifFe7bC1e1zi7jczIueo2+6emi0f8b1g9qY4xreOXwe+xqyCRv3SML/a+zAAPslxnMgjMVdsiOLO7qm4H
 idk4IR1d3DMdU4KrKYtR6jBCw0QhJexNU3ElgZKCbe583dtOUCBWuA6UD3GNKwJSKyFLHHjtq6upj2Hu0GWg2plA8BQbl+abUUgxugrlq1zwWn1KSIEa1W3Y
 BCJXXlsaT9AlNjRlAyJTYj1mu+rZAeZ5ArBU6MG6FQ/dgJhaWgwgFundt31TFD9R

Remove duplicate log2() and log10() functions and replace them
with a single pair of functions ext2fs_log2() and ext2fs_log10().

Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
Reviewed-by: Li Dongyang <dongyangli@ddn.com>
Change-Id: Ifc86efe7e5f0243eb914c6d24319cc7dee3ebbe5
Reviewed-on: https://review.whamcloud.com/52385
---
 debugfs/debugfs.c   | 16 ++--------------
 debugfs/filefrag.c  | 18 +++---------------
 lib/ext2fs/ext2fs.h | 24 ++++++++++++++++++++++++
 lib/ext2fs/extent.c | 17 +++--------------
 misc/e2freefrag.c   | 20 ++++----------------
 misc/e4crypt.c      | 14 +-------------
 misc/filefrag.c     | 32 ++++----------------------------
 misc/mk_hugefiles.c |  2 +-
 misc/mke2fs.c       | 33 ++++++---------------------------
 misc/mke2fs.h       |  1 -
 10 files changed, 48 insertions(+), 129 deletions(-)

diff --git a/debugfs/debugfs.c b/debugfs/debugfs.c
index 8acb56a4d4..6df8355b82 100644
--- a/debugfs/debugfs.c
+++ b/debugfs/debugfs.c
@@ -653,18 +653,6 @@ static void dump_blocks(FILE *f, const char *prefix, ext2_ino_t inode)
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
@@ -1076,11 +1064,11 @@ void do_dump_extents(int argc, ss_argv_t argv, int sci_idx EXT2FS_ATTR((unused))
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
index 9bda65defe..4ad6057d6f 100644
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
@@ -313,7 +301,7 @@ void do_filefrag(int argc, ss_argv_t argv, int sci_idx EXT2FS_ATTR((unused)),
 		return;
 
 	fs.f = open_pager();
-	fs.physical_width = int_log10(ext2fs_blocks_count(current_fs->super));
+	fs.physical_width = ext2fs_log10(ext2fs_blocks_count(current_fs->super));
 	fs.physical_width++;
 	if (fs.physical_width < 8)
 		fs.physical_width = 8;
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index ff22f66bab..65ec74f093 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -2226,6 +2226,30 @@ _INLINE_ int ext2fs_htree_intnode_maxrecs(ext2_filsys fs, int blocks)
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
index 82e75ccd7f..f747a56194 100644
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
index 63a3d43510..eb5abb231e 100644
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
index af907041c8..b662ea9628 100644
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
index eaaa90a8bb..13a533e5ea 100644
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
index 3caaf1b684..17788bcd9f 100644
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
index f24076bc1a..002b838b43 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -147,27 +147,6 @@ static void usage(void)
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
@@ -782,7 +761,7 @@ skip_details:
 			continue;
 		if (i != 1)
 			printf(", ");
-		need = int_log10(group_block) + 2;
+		need = ext2fs_log10(group_block) + 2;
 		if (need > col_left) {
 			printf("\n\t");
 			col_left = 72;
@@ -1753,7 +1732,7 @@ profile_error:
 					blocksize);
 			if (blocksize > 0)
 				fs_param.s_log_block_size =
-					int_log2(blocksize >>
+					ext2fs_log2(blocksize >>
 						 EXT2_MIN_BLOCK_LOG_SIZE);
 			break;
 		case 'c':	/* Check for bad blocks */
@@ -2042,7 +2021,7 @@ profile_error:
 		blocksize = jfs->blocksize;
 		printf(_("Using journal device's blocksize: %d\n"), blocksize);
 		fs_param.s_log_block_size =
-			int_log2(blocksize >> EXT2_MIN_BLOCK_LOG_SIZE);
+			ext2fs_log2(blocksize >> EXT2_MIN_BLOCK_LOG_SIZE);
 		ext2fs_close_free(&jfs);
 	}
 
@@ -2297,7 +2276,7 @@ profile_error:
 	}
 
 	fs_param.s_log_block_size =
-		int_log2(blocksize >> EXT2_MIN_BLOCK_LOG_SIZE);
+		ext2fs_log2(blocksize >> EXT2_MIN_BLOCK_LOG_SIZE);
 
 	/*
 	 * We now need to do a sanity check of fs_blocks_count for
@@ -2396,7 +2375,7 @@ profile_error:
 							    "cluster_size",
 							    blocksize*16);
 		fs_param.s_log_cluster_size =
-			int_log2(cluster_size >> EXT2_MIN_CLUSTER_LOG_SIZE);
+			ext2fs_log2(cluster_size >> EXT2_MIN_CLUSTER_LOG_SIZE);
 		if (fs_param.s_log_cluster_size &&
 		    fs_param.s_log_cluster_size < fs_param.s_log_block_size) {
 			com_err(program_name, 0, "%s",
@@ -2686,7 +2665,7 @@ profile_error:
 				  "flex_bg size may not be specified"));
 			exit(1);
 		}
-		fs_param.s_log_groups_per_flex = int_log2(flex_bg_size);
+		fs_param.s_log_groups_per_flex = ext2fs_log2(flex_bg_size);
 	}
 
 	if (inode_size && fs_param.s_rev_level >= EXT2_DYNAMIC_REV) {
diff --git a/misc/mke2fs.h b/misc/mke2fs.h
index ce72cb3f59..c718fcebaf 100644
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
2.39.5 (Apple Git-154)


