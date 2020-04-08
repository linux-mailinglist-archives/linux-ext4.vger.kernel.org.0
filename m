Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80F8D1A1F0A
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgDHKqo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34607 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgDHKqo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id l14so3166543pgb.1
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wqEZgfLU5Xq6IY63Buss+q7miZSgJx5KNKvmjxetdkU=;
        b=sj5VTPoRhdT6vF0q8vKBcnSd5iMeKfpihb1wSvWSDgFax8hR7rLJSdRSwBuYu4cS7K
         txAFzTTa46EvrGy7wINTDDlPik0QiKxzC5SH67bIKbX2q0TlG1G6fUI1xxWVtyToz9Ex
         3E1WyN/oWq1jr2i7z7qzGcilNXDM9h8mNQd4UtNW2JYeSLbKxbIOcpH/wlPYIlksdk7e
         ycKYTqMQaSE2Oll0wKGvtsX857rR2ehS4CBSAprq/hy+2+QIzLu5bSNXuKtLFa4AAsaj
         uvfyzufHfa6I95b4qHGugOEjClEjNoUGWYNXWABCdazBEs5PIzVzt5ODGGzNLnVH7wKV
         RdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wqEZgfLU5Xq6IY63Buss+q7miZSgJx5KNKvmjxetdkU=;
        b=E+eleuxd7YP5P1VgKyvPmCZaUeSw+svq8Da0dO/ZntldLF2kRSRWBTCxbjfUeb6QDJ
         cknr26l/0aNBEKh1bsypUOoDD0nU8O95Bur1EyT0qQMY0lNS0CvvSL4wQMn/O2D4NI+Y
         BVDvuhumxTLXqEwXUR96ePxGHmZzcwn3illjB+pwk8LATLOCN+t+AaPN3AmY9GAtPh9w
         PmS7QYpfzxoFQgB/gpRLKHTiWaX3wLdCohdASsLwOJ/eWHkemkEcYZH9dUpD4Wesoz1T
         7PVapN5HZjuzjlN2QparObHYwKfg8fO9YjoHj6IOipic1lGkZC8SjMT6Q3cq7E7bCjdh
         tZJg==
X-Gm-Message-State: AGi0PuYst6Tmo1AwbBvP11WXSdZDTmaPMeYBWqwQLgInJ7IUcaG/ZIHW
        CfvoYC9TKPpPCWZbh654NEy8fdm0o0Y=
X-Google-Smtp-Source: APiQypKv54uNQYr/8Lpbwovpy8vcP19ptqaNMIzWlA5v65vbjix2RfAkzQGnIawQ66Nvxtf+Ngwu/g==
X-Received: by 2002:a63:2254:: with SMTP id t20mr6558245pgm.121.1586342801300;
        Wed, 08 Apr 2020 03:46:41 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:40 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 32/46] e2fsck: serialize fix operations
Date:   Wed,  8 Apr 2020 19:45:00 +0900
Message-Id: <1586342714-12536-33-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Allow different threads to fix at the same time could
be dangerous and eror-prone now, and most of time
parallel scanning and checking is important.

So this patch try to add a mutex to serialize
fix operations during pass1.

And the good benefit of this, we don't need block
allocations and free, superblock updates protection
any more, since only fix operations during pass1
could touch them.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/e2fsck.h |   3 +-
 e2fsck/pass1.c  | 164 +++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 156 insertions(+), 11 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 0b449b69..20d61651 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -448,7 +448,8 @@ struct e2fsck_struct {
 	__u32			fs_ext_attr_inodes;
 	__u32			fs_ext_attr_blocks;
 	__u32			extent_depth_count[MAX_EXTENT_DEPTH_COUNT];
-
+	/* serialize fix operation for multiple threads */
+	pthread_mutex_t		 fs_fix_mutex;
 };
 
 #ifdef DEBUG_THREADS
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index c7b9cf72..f3b52103 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -132,6 +132,24 @@ static void process_inodes(e2fsck_t ctx, char *block_buf,
 static __u64 ext2_max_sizes[EXT2_MAX_BLOCK_LOG_SIZE -
 			    EXT2_MIN_BLOCK_LOG_SIZE + 1];
 
+static void e2fsck_pass1_fix_lock(e2fsck_t ctx)
+{
+	e2fsck_t global_ctx = ctx->global_ctx;
+	if (!global_ctx)
+		global_ctx = ctx;
+
+	pthread_mutex_lock(&global_ctx->fs_fix_mutex);
+}
+
+static void e2fsck_pass1_fix_unlock(e2fsck_t ctx)
+{
+	e2fsck_t global_ctx = ctx->global_ctx;
+	if (!global_ctx)
+		global_ctx = ctx;
+
+	pthread_mutex_unlock(&global_ctx->fs_fix_mutex);
+}
+
 /*
  * Free all memory allocated by pass1 in preparation for restarting
  * things.
@@ -282,8 +300,10 @@ static void check_extents_inlinedata(e2fsck_t ctx,
 	if (!fix_problem(ctx, PR_1_SPECIAL_EXTENTS_IDATA, pctx))
 		return;
 
+	e2fsck_pass1_fix_lock(ctx);
 	pctx->inode->i_flags &= ~BAD_SPECIAL_FLAGS;
 	e2fsck_write_inode(ctx, pctx->ino, pctx->inode, "pass1");
+	e2fsck_pass1_fix_unlock(ctx);
 }
 #undef BAD_SPECIAL_FLAGS
 
@@ -300,8 +320,10 @@ static void check_immutable(e2fsck_t ctx, struct problem_context *pctx)
 	if (!fix_problem(ctx, PR_1_SET_IMMUTABLE, pctx))
 		return;
 
+	e2fsck_pass1_fix_lock(ctx);
 	pctx->inode->i_flags &= ~BAD_SPECIAL_FLAGS;
 	e2fsck_write_inode(ctx, pctx->ino, pctx->inode, "pass1");
+	e2fsck_pass1_fix_unlock(ctx);
 }
 
 /*
@@ -318,8 +340,10 @@ static void check_size(e2fsck_t ctx, struct problem_context *pctx)
 	if (!fix_problem(ctx, PR_1_SET_NONZSIZE, pctx))
 		return;
 
+	e2fsck_pass1_fix_lock(ctx);
 	ext2fs_inode_size_set(ctx->fs, inode, 0);
 	e2fsck_write_inode(ctx, pctx->ino, pctx->inode, "pass1");
+	e2fsck_pass1_fix_unlock(ctx);
 }
 
 /*
@@ -388,9 +412,11 @@ static problem_t check_large_ea_inode(e2fsck_t ctx,
 	if (!(inode.i_flags & EXT4_EA_INODE_FL)) {
 		pctx->num = entry->e_value_inum;
 		if (fix_problem(ctx, PR_1_ATTR_SET_EA_INODE_FL, pctx)) {
+			e2fsck_pass1_fix_lock(ctx);
 			inode.i_flags |= EXT4_EA_INODE_FL;
 			ext2fs_write_inode(ctx->fs, entry->e_value_inum,
 					   &inode);
+			e2fsck_pass1_fix_unlock(ctx);
 		} else {
 			return PR_1_ATTR_NO_EA_INODE_FL;
 		}
@@ -551,11 +577,13 @@ fix:
 	}
 
 	/* simply remove all possible EA(s) */
+	e2fsck_pass1_fix_lock(ctx);
 	*((__u32 *)header) = 0UL;
 	e2fsck_write_inode_full(ctx, pctx->ino, pctx->inode,
 				EXT2_INODE_SIZE(sb), "pass1");
 	ea_ibody_quota->blocks = 0;
 	ea_ibody_quota->inodes = 0;
+	e2fsck_pass1_fix_unlock(ctx);
 }
 
 static int check_inode_extra_negative_epoch(__u32 xtime, __u32 extra) {
@@ -606,12 +634,14 @@ static void check_inode_extra_space(e2fsck_t ctx, struct problem_context *pctx,
 	     inode->i_extra_isize & 3)) {
 		if (!fix_problem(ctx, PR_1_EXTRA_ISIZE, pctx))
 			return;
+		e2fsck_pass1_fix_lock(ctx);
 		if (inode->i_extra_isize < min || inode->i_extra_isize > max)
 			inode->i_extra_isize = sb->s_want_extra_isize;
 		else
 			inode->i_extra_isize = (inode->i_extra_isize + 3) & ~3;
 		e2fsck_write_inode_full(ctx, pctx->ino, pctx->inode,
 					EXT2_INODE_SIZE(sb), "pass1");
+		e2fsck_pass1_fix_unlock(ctx);
 	}
 
 	/* check if there is no place for an EA header */
@@ -640,6 +670,7 @@ static void check_inode_extra_space(e2fsck_t ctx, struct problem_context *pctx,
 		if (!fix_problem(ctx, PR_1_EA_TIME_OUT_OF_RANGE, pctx))
 			return;
 
+		e2fsck_pass1_fix_lock(ctx);
 		if (CHECK_INODE_EXTRA_NEGATIVE_EPOCH(inode, atime))
 			inode->i_atime_extra &= ~EXT4_EPOCH_MASK;
 		if (CHECK_INODE_EXTRA_NEGATIVE_EPOCH(inode, ctime))
@@ -650,6 +681,7 @@ static void check_inode_extra_space(e2fsck_t ctx, struct problem_context *pctx,
 			inode->i_mtime_extra &= ~EXT4_EPOCH_MASK;
 		e2fsck_write_inode_full(ctx, pctx->ino, pctx->inode,
 					EXT2_INODE_SIZE(sb), "pass1");
+		e2fsck_pass1_fix_unlock(ctx);
 	}
 
 }
@@ -807,10 +839,12 @@ static void check_is_really_dir(e2fsck_t ctx, struct problem_context *pctx,
 
 isdir:
 	if (fix_problem(ctx, PR_1_TREAT_AS_DIRECTORY, pctx)) {
+		e2fsck_pass1_fix_lock(ctx);
 		inode->i_mode = (inode->i_mode & 07777) | LINUX_S_IFDIR;
 		e2fsck_write_inode_full(ctx, pctx->ino, inode,
 					EXT2_INODE_SIZE(ctx->fs->super),
 					"check_is_really_dir");
+		e2fsck_pass1_fix_unlock(ctx);
 	}
 }
 
@@ -881,8 +915,11 @@ static errcode_t recheck_bad_inode_checksum(ext2_filsys fs, ext2_ino_t ino,
 	if (!fix_problem(ctx, PR_1_INODE_ONLY_CSUM_INVALID, pctx))
 		return 0;
 
+
+	e2fsck_pass1_fix_lock(ctx);
 	retval = ext2fs_write_inode_full(fs, ino, (struct ext2_inode *)&inode,
 					 sizeof(inode));
+	e2fsck_pass1_fix_unlock(ctx);
 	return retval;
 }
 
@@ -892,15 +929,19 @@ static void reserve_block_for_root_repair(e2fsck_t ctx)
 	errcode_t	err;
 	ext2_filsys	fs = ctx->fs;
 
+	e2fsck_pass1_fix_lock(ctx);
 	ctx->root_repair_block = 0;
 	if (ext2fs_test_inode_bitmap2(ctx->inode_used_map, EXT2_ROOT_INO))
-		return;
+		goto out;
 
 	err = ext2fs_new_block2(fs, 0, ctx->block_found_map, &blk);
 	if (err)
-		return;
+		goto out;
 	ext2fs_mark_block_bitmap2(ctx->block_found_map, blk);
 	ctx->root_repair_block = blk;
+out:
+	e2fsck_pass1_fix_unlock(ctx);
+	return;
 }
 
 static void reserve_block_for_lnf_repair(e2fsck_t ctx)
@@ -911,15 +952,19 @@ static void reserve_block_for_lnf_repair(e2fsck_t ctx)
 	static const char name[] = "lost+found";
 	ext2_ino_t	ino;
 
+	e2fsck_pass1_fix_lock(ctx);
 	ctx->lnf_repair_block = 0;
 	if (!ext2fs_lookup(fs, EXT2_ROOT_INO, name, sizeof(name)-1, 0, &ino))
-		return;
+		goto out;
 
 	err = ext2fs_new_block2(fs, 0, ctx->block_found_map, &blk);
 	if (err)
-		return;
+		goto out;
 	ext2fs_mark_block_bitmap2(ctx->block_found_map, blk);
 	ctx->lnf_repair_block = blk;
+out:
+	e2fsck_pass1_fix_unlock(ctx);
+	return;
 }
 
 static errcode_t get_inline_data_ea_size(ext2_filsys fs, ext2_ino_t ino,
@@ -1018,8 +1063,10 @@ static int fix_inline_data_extents_file(e2fsck_t ctx,
 	if (ext2fs_extent_header_verify(inode->i_block,
 				 sizeof(inode->i_block)) == 0 &&
 	    fix_problem(ctx, PR_1_CLEAR_INLINE_DATA_FOR_EXTENT, pctx)) {
+		e2fsck_pass1_fix_lock(ctx);
 		inode->i_flags &= ~EXT4_INLINE_DATA_FL;
 		dirty = 1;
+		e2fsck_pass1_fix_unlock(ctx);
 		goto out;
 	}
 
@@ -1033,8 +1080,10 @@ static int fix_inline_data_extents_file(e2fsck_t ctx,
 	if (EXT2_I_SIZE(inode) <
 	    EXT4_MIN_INLINE_DATA_SIZE + max_inline_ea_size &&
 	    fix_problem(ctx, PR_1_CLEAR_EXTENT_FOR_INLINE_DATA, pctx)) {
+		e2fsck_pass1_fix_lock(ctx);
 		inode->i_flags &= ~EXT4_EXTENTS_FL;
 		dirty = 1;
+		e2fsck_pass1_fix_unlock(ctx);
 		goto out;
 	}
 
@@ -1044,6 +1093,7 @@ static int fix_inline_data_extents_file(e2fsck_t ctx,
 	 */
 	if (could_be_block_map(fs, inode) &&
 	    fix_problem(ctx, PR_1_CLEAR_EXTENT_INLINE_DATA_FLAGS, pctx)) {
+		e2fsck_pass1_fix_lock(ctx);
 #ifdef WORDS_BIGENDIAN
 		int i;
 
@@ -1053,18 +1103,24 @@ static int fix_inline_data_extents_file(e2fsck_t ctx,
 
 		inode->i_flags &= ~(EXT4_EXTENTS_FL | EXT4_INLINE_DATA_FL);
 		dirty = 1;
+		e2fsck_pass1_fix_unlock(ctx);
 		goto out;
 	}
 
 	/* Oh well, just clear the busted inode. */
 	if (fix_problem(ctx, PR_1_CLEAR_EXTENT_INLINE_DATA_INODE, pctx)) {
+		e2fsck_pass1_fix_lock(ctx);
 		e2fsck_clear_inode(ctx, ino, inode, 0, "pass1");
+		e2fsck_pass1_fix_unlock(ctx);
 		return -1;
 	}
 
 out:
-	if (dirty)
+	if (dirty) {
+		e2fsck_pass1_fix_lock(ctx);
 		e2fsck_write_inode(ctx, ino, inode, "pass1");
+		e2fsck_pass1_fix_unlock(ctx);
+	}
 
 	return 0;
 }
@@ -1408,7 +1464,9 @@ void _e2fsck_pass1(e2fsck_t ctx)
 					&pctx)) {
 				errcode_t err;
 
+				e2fsck_pass1_fix_lock(ctx);
 				e2fsck_clear_inode(ctx, ino, inode, 0, "pass1");
+				e2fsck_pass1_fix_unlock(ctx);
 				ext2fs_badblocks_list_free(ctx->fs->badblocks);
 				ctx->fs->badblocks = NULL;
 				err = ext2fs_read_bb_inode(ctx->fs,
@@ -1457,7 +1515,9 @@ void _e2fsck_pass1(e2fsck_t ctx)
 		    inode->i_links_count > 0 &&
 		    fix_problem(ctx, PR_1_INODE_IS_GARBAGE, &pctx)) {
 			pctx.errcode = 0;
+			e2fsck_pass1_fix_lock(ctx);
 			e2fsck_clear_inode(ctx, ino, inode, 0, "pass1");
+			e2fsck_pass1_fix_unlock(ctx);
 		}
 		failed_csum = pctx.errcode != 0;
 
@@ -1481,10 +1541,12 @@ void _e2fsck_pass1(e2fsck_t ctx)
 		if (inode->i_dtime && low_dtime_check &&
 		    inode->i_dtime < ctx->fs->super->s_inodes_count) {
 			if (fix_problem(ctx, PR_1_LOW_DTIME, &pctx)) {
+				e2fsck_pass1_fix_lock(ctx);
 				inode->i_dtime = inode->i_links_count ?
 					0 : ctx->now;
 				e2fsck_write_inode(ctx, ino, inode,
 						   "pass1");
+				e2fsck_pass1_fix_unlock(ctx);
 				failed_csum = 0;
 			}
 		}
@@ -1503,9 +1565,11 @@ void _e2fsck_pass1(e2fsck_t ctx)
 			if (!inode->i_dtime && inode->i_mode) {
 				if (fix_problem(ctx,
 					    PR_1_ZERO_DTIME, &pctx)) {
+					e2fsck_pass1_fix_lock(ctx);
 					inode->i_dtime = ctx->now;
 					e2fsck_write_inode(ctx, ino, inode,
 							   "pass1");
+					e2fsck_pass1_fix_unlock(ctx);
 					failed_csum = 0;
 				}
 			}
@@ -1542,11 +1606,15 @@ void _e2fsck_pass1(e2fsck_t ctx)
 			pctx.errcode = get_inline_data_ea_size(fs, ino, &size);
 			if (!pctx.errcode &&
 			    fix_problem(ctx, PR_1_INLINE_DATA_FEATURE, &pctx)) {
+				e2fsck_pass1_fix_lock(ctx);
 				ext2fs_set_feature_inline_data(sb);
 				ext2fs_mark_super_dirty(fs);
+				e2fsck_pass1_fix_unlock(ctx);
 				inlinedata_fs = 1;
 			} else if (fix_problem(ctx, PR_1_INLINE_DATA_SET, &pctx)) {
+				e2fsck_pass1_fix_lock(ctx);
 				e2fsck_clear_inode(ctx, ino, inode, 0, "pass1");
+				e2fsck_pass1_fix_unlock(ctx);
 				/* skip FINISH_INODE_LOOP */
 				continue;
 			}
@@ -1588,10 +1656,12 @@ void _e2fsck_pass1(e2fsck_t ctx)
 				/* broken EA or no system.data EA; truncate */
 				if (fix_problem(ctx, PR_1_INLINE_DATA_NO_ATTR,
 						&pctx)) {
+					e2fsck_pass1_fix_lock(ctx);
 					err = ext2fs_inode_size_set(fs, inode, 0);
 					if (err) {
 						pctx.errcode = err;
 						ctx->flags |= E2F_FLAG_ABORT;
+						e2fsck_pass1_fix_unlock(ctx);
 						goto endit;
 					}
 					inode->i_flags &= ~EXT4_INLINE_DATA_FL;
@@ -1599,6 +1669,7 @@ void _e2fsck_pass1(e2fsck_t ctx)
 					       sizeof(inode->i_block));
 					e2fsck_write_inode(ctx, ino, inode,
 							   "pass1");
+					e2fsck_pass1_fix_unlock(ctx);
 					failed_csum = 0;
 				}
 				break;
@@ -1631,12 +1702,16 @@ void _e2fsck_pass1(e2fsck_t ctx)
 			if ((ext2fs_extent_header_verify(inode->i_block,
 						 sizeof(inode->i_block)) == 0) &&
 			    fix_problem(ctx, PR_1_EXTENT_FEATURE, &pctx)) {
+				e2fsck_pass1_fix_lock(ctx);
 				ext2fs_set_feature_extents(sb);
 				ext2fs_mark_super_dirty(fs);
 				extent_fs = 1;
+				e2fsck_pass1_fix_unlock(ctx);
 			} else if (fix_problem(ctx, PR_1_EXTENTS_SET, &pctx)) {
 			clear_inode:
+				e2fsck_pass1_fix_lock(ctx);
 				e2fsck_clear_inode(ctx, ino, inode, 0, "pass1");
+				e2fsck_pass1_fix_unlock(ctx);
 				if (ino == EXT2_BAD_INO)
 					ext2fs_mark_inode_bitmap2(ctx->inode_used_map,
 								 ino);
@@ -1671,12 +1746,14 @@ void _e2fsck_pass1(e2fsck_t ctx)
 			if ((ext2fs_extent_header_verify(ehp,
 					 sizeof(inode->i_block)) == 0) &&
 			    (fix_problem(ctx, PR_1_UNSET_EXTENT_FL, &pctx))) {
+				e2fsck_pass1_fix_lock(ctx);
 				inode->i_flags |= EXT4_EXTENTS_FL;
 #ifdef WORDS_BIGENDIAN
 				memcpy(inode->i_block, tmp_block,
 				       sizeof(inode->i_block));
 #endif
 				e2fsck_write_inode(ctx, ino, inode, "pass1");
+				e2fsck_pass1_fix_unlock(ctx);
 				failed_csum = 0;
 			}
 		}
@@ -1689,9 +1766,11 @@ void _e2fsck_pass1(e2fsck_t ctx)
 			     (inode->i_flags & EXT4_INLINE_DATA_FL) ||
 			     inode->i_file_acl) &&
 			    fix_problem(ctx, PR_1_INVALID_BAD_INODE, &pctx)) {
+				e2fsck_pass1_fix_lock(ctx);
 				memset(inode, 0, sizeof(struct ext2_inode));
 				e2fsck_write_inode(ctx, ino, inode,
 						   "clear bad inode");
+				e2fsck_pass1_fix_unlock(ctx);
 				failed_csum = 0;
 			}
 
@@ -1750,9 +1829,11 @@ void _e2fsck_pass1(e2fsck_t ctx)
 			 */
 			if (inode->i_dtime && inode->i_links_count) {
 				if (fix_problem(ctx, PR_1_ROOT_DTIME, &pctx)) {
+					e2fsck_pass1_fix_lock(ctx);
 					inode->i_dtime = 0;
 					e2fsck_write_inode(ctx, ino, inode,
 							   "pass1");
+					e2fsck_pass1_fix_unlock(ctx);
 					failed_csum = 0;
 				}
 			}
@@ -1762,9 +1843,11 @@ void _e2fsck_pass1(e2fsck_t ctx)
 				if (!LINUX_S_ISREG(inode->i_mode) &&
 				    fix_problem(ctx, PR_1_JOURNAL_BAD_MODE,
 						&pctx)) {
+					e2fsck_pass1_fix_lock(ctx);
 					inode->i_mode = LINUX_S_IFREG;
 					e2fsck_write_inode(ctx, ino, inode,
 							   "pass1");
+					e2fsck_pass1_fix_unlock(ctx);
 					failed_csum = 0;
 				}
 				check_blocks(ctx, &pctx, block_buf, NULL);
@@ -1778,8 +1861,10 @@ void _e2fsck_pass1(e2fsck_t ctx)
 				memset(inode, 0, inode_size);
 				ext2fs_icount_store(ctx->inode_link_info,
 						    ino, 0);
+				e2fsck_pass1_fix_lock(ctx);
 				e2fsck_write_inode_full(ctx, ino, inode,
 							inode_size, "pass1");
+				e2fsck_pass1_fix_unlock(ctx);
 				failed_csum = 0;
 			}
 		} else if (quota_inum_is_reserved(fs, ino)) {
@@ -1789,9 +1874,11 @@ void _e2fsck_pass1(e2fsck_t ctx)
 				if (!LINUX_S_ISREG(inode->i_mode) &&
 				    fix_problem(ctx, PR_1_QUOTA_BAD_MODE,
 							&pctx)) {
+					e2fsck_pass1_fix_lock(ctx);
 					inode->i_mode = LINUX_S_IFREG;
 					e2fsck_write_inode(ctx, ino, inode,
 							"pass1");
+					e2fsck_pass1_fix_unlock(ctx);
 					failed_csum = 0;
 				}
 				check_blocks(ctx, &pctx, block_buf, NULL);
@@ -1802,11 +1889,13 @@ void _e2fsck_pass1(e2fsck_t ctx)
 			     inode->i_blocks || inode->i_block[0]) &&
 			    fix_problem(ctx, PR_1_QUOTA_INODE_NOT_CLEAR,
 					&pctx)) {
-				memset(inode, 0, inode_size);
 				ext2fs_icount_store(ctx->inode_link_info,
 						    ino, 0);
+				e2fsck_pass1_fix_lock(ctx);
+				memset(inode, 0, inode_size);
 				e2fsck_write_inode_full(ctx, ino, inode,
 							inode_size, "pass1");
+				e2fsck_pass1_fix_unlock(ctx);
 				failed_csum = 0;
 			}
 		} else if (ino < EXT2_FIRST_INODE(fs->super)) {
@@ -1826,9 +1915,11 @@ void _e2fsck_pass1(e2fsck_t ctx)
 			}
 			if (problem) {
 				if (fix_problem(ctx, problem, &pctx)) {
+					e2fsck_pass1_fix_lock(ctx);
 					inode->i_mode = 0;
 					e2fsck_write_inode(ctx, ino, inode,
 							   "pass1");
+					e2fsck_pass1_fix_unlock(ctx);
 					failed_csum = 0;
 				}
 			}
@@ -1889,9 +1980,11 @@ void _e2fsck_pass1(e2fsck_t ctx)
 							 ino);
 			} else {
 				if (fix_problem(ctx, PR_1_SET_IMAGIC, &pctx)) {
+					e2fsck_pass1_fix_lock(ctx);
 					inode->i_flags &= ~EXT2_IMAGIC_FL;
 					e2fsck_write_inode(ctx, ino,
 							   inode, "pass1");
+					e2fsck_pass1_fix_unlock(ctx);
 					failed_csum = 0;
 				}
 			}
@@ -1908,8 +2001,10 @@ void _e2fsck_pass1(e2fsck_t ctx)
 		    LINUX_S_ISLNK(inode->i_mode) &&
 		    !ext2fs_inode_has_valid_blocks2(fs, inode) &&
 		    fix_problem(ctx, PR_1_FAST_SYMLINK_EXTENT_FL, &pctx)) {
+			e2fsck_pass1_fix_lock(ctx);
 			inode->i_flags &= ~EXT4_EXTENTS_FL;
 			e2fsck_write_inode(ctx, ino, inode, "pass1");
+			e2fsck_pass1_fix_unlock(ctx);
 			failed_csum = 0;
 		}
 
@@ -2042,8 +2137,11 @@ void _e2fsck_pass1(e2fsck_t ctx)
 		ctx->ea_block_quota_inodes = 0;
 	}
 
-	if (ctx->invalid_bitmaps)
+	if (ctx->invalid_bitmaps) {
+		e2fsck_pass1_fix_lock(ctx);
 		handle_fs_bad_blocks(ctx);
+		e2fsck_pass1_fix_unlock(ctx);
+	}
 
 	/* We don't need the block_ea_map any more */
 	if (ctx->block_ea_map) {
@@ -2056,7 +2154,9 @@ void _e2fsck_pass1(e2fsck_t ctx)
 
 	if (ctx->flags & E2F_FLAG_RESIZE_INODE) {
 		clear_problem_context(&pctx);
+		e2fsck_pass1_fix_lock(ctx);
 		pctx.errcode = ext2fs_create_resize_inode(fs);
+		e2fsck_pass1_fix_unlock(ctx);
 		if (pctx.errcode) {
 			if (!fix_problem(ctx, PR_1_RESIZE_INODE_CREATE,
 					 &pctx)) {
@@ -2068,9 +2168,11 @@ void _e2fsck_pass1(e2fsck_t ctx)
 		if (!pctx.errcode) {
 			e2fsck_read_inode(ctx, EXT2_RESIZE_INO, inode,
 					  "recreate inode");
+			e2fsck_pass1_fix_lock(ctx);
 			inode->i_mtime = ctx->now;
 			e2fsck_write_inode(ctx, EXT2_RESIZE_INO, inode,
 					   "recreate inode");
+			e2fsck_pass1_fix_unlock(ctx);
 		}
 		ctx->flags &= ~E2F_FLAG_RESIZE_INODE;
 	}
@@ -2092,7 +2194,9 @@ void _e2fsck_pass1(e2fsck_t ctx)
 			clear_problem_context(&pctx);
 			fix_problem(ctx, PR_1_DUP_BLOCKS_PREENSTOP, &pctx);
 		}
+		e2fsck_pass1_fix_lock(ctx);
 		e2fsck_pass1_dupblocks(ctx, block_buf);
+		e2fsck_pass1_fix_unlock(ctx);
 	}
 	ctx->flags |= E2F_FLAG_ALLOC_OK;
 	ext2fs_free_mem(&inodes_to_process);
@@ -2906,6 +3010,7 @@ static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
 	unsigned flexbg_size = 1;
 	int max_threads;
 
+	pthread_mutex_init(&global_ctx->fs_fix_mutex, NULL);
 	if (ext2fs_has_feature_flex_bg(global_ctx->fs->super))
 		flexbg_size = 1 << global_ctx->fs->super->s_log_groups_per_flex;
 
@@ -3210,10 +3315,12 @@ static void adjust_extattr_refcount(e2fsck_t ctx, ext2_refcount_t refcount,
 		should_be = header->h_refcount + adjust_sign * (int)count;
 		pctx.num = should_be;
 		if (fix_problem(ctx, PR_1_EXTATTR_REFCOUNT, &pctx)) {
+			e2fsck_pass1_fix_lock(ctx);
 			header->h_refcount = should_be;
 			pctx.errcode = ext2fs_write_ext_attr3(fs, blk,
 							     block_buf,
 							     pctx.ino);
+			e2fsck_pass1_fix_unlock(ctx);
 			if (pctx.errcode) {
 				fix_problem(ctx, PR_1_EXTATTR_WRITE_ABORT,
 					    &pctx);
@@ -3442,8 +3549,10 @@ static int check_ext_attr(e2fsck_t ctx, struct problem_context *pctx,
 	 */
 	if (failed_csum &&
 	    fix_problem(ctx, PR_1_EA_BLOCK_ONLY_CSUM_INVALID, pctx)) {
+		e2fsck_pass1_fix_lock(ctx);
 		pctx->errcode = ext2fs_write_ext_attr3(fs, blk, block_buf,
 						       pctx->ino);
+		e2fsck_pass1_fix_unlock(ctx);
 		if (pctx->errcode)
 			return 0;
 	}
@@ -3489,8 +3598,10 @@ refcount_fail:
 clear_extattr:
 	if (region)
 		region_free(region);
+	e2fsck_pass1_fix_lock(ctx);
 	ext2fs_file_acl_block_set(fs, inode, 0);
 	e2fsck_write_inode(ctx, ino, inode, "check_ext_attr");
+	e2fsck_pass1_fix_unlock(ctx);
 	return 0;
 }
 
@@ -3720,10 +3831,12 @@ static void scan_extent_node(e2fsck_t ctx, struct problem_context *pctx,
 		if (try_repairs && is_dir && problem == 0 &&
 		    (extent.e_flags & EXT2_EXTENT_FLAGS_UNINIT) &&
 		    fix_problem(ctx, PR_1_UNINIT_DBLOCK, pctx)) {
+			e2fsck_pass1_fix_lock(ctx);
 			extent.e_flags &= ~EXT2_EXTENT_FLAGS_UNINIT;
 			pb->inode_modified = 1;
 			pctx->errcode = ext2fs_extent_replace(ehandle, 0,
 							      &extent);
+			e2fsck_pass1_fix_unlock(ctx);
 			if (pctx->errcode)
 				return;
 			failed_csum = 0;
@@ -3767,13 +3880,17 @@ report_problem:
 				}
 				e2fsck_read_bitmaps(ctx);
 				pb->inode_modified = 1;
+				e2fsck_pass1_fix_lock(ctx);
 				pctx->errcode =
 					ext2fs_extent_delete(ehandle, 0);
+				e2fsck_pass1_fix_unlock(ctx);
 				if (pctx->errcode) {
 					pctx->str = "ext2fs_extent_delete";
 					return;
 				}
+				e2fsck_pass1_fix_lock(ctx);
 				pctx->errcode = ext2fs_extent_fix_parents(ehandle);
+				e2fsck_pass1_fix_unlock(ctx);
 				if (pctx->errcode &&
 				    pctx->errcode != EXT2_ET_NO_CURRENT_NODE) {
 					pctx->str = "ext2fs_extent_fix_parents";
@@ -3837,9 +3954,11 @@ report_problem:
 				pctx->num = e_info.curr_level - 1;
 				problem = PR_1_EXTENT_INDEX_START_INVALID;
 				if (fix_problem(ctx, problem, pctx)) {
+					e2fsck_pass1_fix_lock(ctx);
 					pb->inode_modified = 1;
 					pctx->errcode =
 						ext2fs_extent_fix_parents(ehandle);
+					e2fsck_pass1_fix_unlock(ctx);
 					if (pctx->errcode) {
 						pctx->str = "ext2fs_extent_fix_parents";
 						return;
@@ -3903,15 +4022,19 @@ report_problem:
 			pctx->blk = extent.e_lblk;
 			pctx->blk2 = new_lblk;
 			if (fix_problem(ctx, PR_1_COLLAPSE_DBLOCK, pctx)) {
+				e2fsck_pass1_fix_lock(ctx);
 				extent.e_lblk = new_lblk;
 				pb->inode_modified = 1;
 				pctx->errcode = ext2fs_extent_replace(ehandle,
 								0, &extent);
+				e2fsck_pass1_fix_unlock(ctx);
 				if (pctx->errcode) {
 					pctx->errcode = 0;
 					goto alloc_later;
 				}
+				e2fsck_pass1_fix_lock(ctx);
 				pctx->errcode = ext2fs_extent_fix_parents(ehandle);
+				e2fsck_pass1_fix_unlock(ctx);
 				if (pctx->errcode)
 					goto failed_add_dir_block;
 				pctx->errcode = ext2fs_extent_goto(ehandle,
@@ -4007,8 +4130,10 @@ alloc_later:
 	/* Failed csum but passes checks?  Ask to fix checksum. */
 	if (failed_csum &&
 	    fix_problem(ctx, PR_1_EXTENT_ONLY_CSUM_INVALID, pctx)) {
+		e2fsck_pass1_fix_lock(ctx);
 		pb->inode_modified = 1;
 		pctx->errcode = ext2fs_extent_replace(ehandle, 0, &extent);
+		e2fsck_pass1_fix_unlock(ctx);
 		if (pctx->errcode)
 			return;
 	}
@@ -4033,9 +4158,12 @@ static void check_blocks_extents(e2fsck_t ctx, struct problem_context *pctx,
 	eh = (struct ext3_extent_header *) &inode->i_block[0];
 	retval = ext2fs_extent_header_verify(eh, sizeof(inode->i_block));
 	if (retval) {
-		if (fix_problem(ctx, PR_1_MISSING_EXTENT_HEADER, pctx))
+		if (fix_problem(ctx, PR_1_MISSING_EXTENT_HEADER, pctx)) {
+			e2fsck_pass1_fix_lock(ctx);
 			e2fsck_clear_inode(ctx, ino, inode, 0,
 					   "check_blocks_extents");
+			e2fsck_pass1_fix_unlock(ctx);
+		}
 		pctx->errcode = 0;
 		return;
 	}
@@ -4043,9 +4171,12 @@ static void check_blocks_extents(e2fsck_t ctx, struct problem_context *pctx,
 	/* ...since this function doesn't fail if i_block is zeroed. */
 	pctx->errcode = ext2fs_extent_open2(fs, ino, inode, &ehandle);
 	if (pctx->errcode) {
-		if (fix_problem(ctx, PR_1_READ_EXTENT, pctx))
+		if (fix_problem(ctx, PR_1_READ_EXTENT, pctx)) {
+			e2fsck_pass1_fix_lock(ctx);
 			e2fsck_clear_inode(ctx, ino, inode, 0,
 					   "check_blocks_extents");
+			e2fsck_pass1_fix_unlock(ctx);
+		}
 		pctx->errcode = 0;
 		return;
 	}
@@ -4082,8 +4213,10 @@ static void check_blocks_extents(e2fsck_t ctx, struct problem_context *pctx,
 	    fix_problem(ctx, PR_1_EXTENT_ITERATE_FAILURE, pctx)) {
 		pb->num_blocks = 0;
 		inode->i_blocks = 0;
+		e2fsck_pass1_fix_lock(ctx);
 		e2fsck_clear_inode(ctx, ino, inode, E2F_FLAG_RESTART,
 				   "check_blocks_extents");
+		e2fsck_pass1_fix_unlock(ctx);
 		pctx->errcode = 0;
 	}
 	ext2fs_extent_free(ehandle);
@@ -4259,8 +4392,10 @@ static void check_blocks(e2fsck_t ctx, struct problem_context *pctx,
 	}
 
 	if (pb.clear) {
+		e2fsck_pass1_fix_lock(ctx);
 		e2fsck_clear_inode(ctx, ino, inode, E2F_FLAG_RESTART,
 				   "check_blocks");
+		e2fsck_pass1_fix_unlock(ctx);
 		return;
 	}
 
@@ -4276,7 +4411,9 @@ static void check_blocks(e2fsck_t ctx, struct problem_context *pctx,
 	if (!pb.num_blocks && pb.is_dir &&
 	    !(inode->i_flags & EXT4_INLINE_DATA_FL)) {
 		if (fix_problem(ctx, PR_1_ZERO_LENGTH_DIR, pctx)) {
+			e2fsck_pass1_fix_lock(ctx);
 			e2fsck_clear_inode(ctx, ino, inode, 0, "check_blocks");
+			e2fsck_pass1_fix_unlock(ctx);
 			ctx->fs_directory_count--;
 			return;
 		}
@@ -4355,6 +4492,7 @@ static void check_blocks(e2fsck_t ctx, struct problem_context *pctx,
 			pctx->num = (pb.last_block + 1) * fs->blocksize;
 		pctx->group = bad_size;
 		if (fix_problem(ctx, PR_1_BAD_I_SIZE, pctx)) {
+			e2fsck_pass1_fix_lock(ctx);
 			if (LINUX_S_ISDIR(inode->i_mode))
 				pctx->num &= 0xFFFFFFFFULL;
 			ext2fs_inode_size_set(fs, inode, pctx->num);
@@ -4365,6 +4503,7 @@ static void check_blocks(e2fsck_t ctx, struct problem_context *pctx,
 				inode->i_flags &= ~EXT4_INLINE_DATA_FL;
 			}
 			dirty_inode++;
+			e2fsck_pass1_fix_unlock(ctx);
 		}
 		pctx->num = 0;
 	}
@@ -4378,8 +4517,10 @@ static void check_blocks(e2fsck_t ctx, struct problem_context *pctx,
 	      (inode->osd2.linux2.l_i_blocks_hi != 0)))) {
 		pctx->num = pb.num_blocks;
 		if (fix_problem(ctx, PR_1_BAD_I_BLOCKS, pctx)) {
+			e2fsck_pass1_fix_lock(ctx);
 			inode->i_blocks = pb.num_blocks;
 			inode->osd2.linux2.l_i_blocks_hi = pb.num_blocks >> 32;
+			e2fsck_pass1_fix_unlock(ctx);
 			dirty_inode++;
 		}
 		pctx->num = 0;
@@ -4408,8 +4549,11 @@ static void check_blocks(e2fsck_t ctx, struct problem_context *pctx,
 		e2fsck_rehash_dir_later(ctx, ino);
 
 out:
-	if (dirty_inode)
+	if (dirty_inode) {
+		e2fsck_pass1_fix_lock(ctx);
 		e2fsck_write_inode(ctx, ino, inode, "check_blocks");
+		e2fsck_pass1_fix_unlock(ctx);
+	}
 }
 
 #if 0
-- 
2.25.2

