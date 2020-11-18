Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A294D2B80CC
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgKRPkx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbgKRPkx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:40:53 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAB4C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:52 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id l67so1659180qte.6
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=S3c6Mh8/nw2Ggap0ePvbku8BWleCnPN1cTGG7+MtNvM=;
        b=CucoB8SXUYAJC+MRuNLX8MFG44XN3pDP5PsMf/s1VCEbadKkDonlHrkbaLaBw1K/uD
         V1BgP/R0qohZFbcPzxMneJo1EWLiNtUrlO3r8/oXxc8uqvFfyDwjlbru4E/XgcNUmzUr
         8foKDa5ZSJO7b7IvYmFfVppmIH7x71MDA4dx5+09/t35zPq2DMAvESAEVMMbMpywmInN
         r6EO+0Hse+mGQf/cK9yopq9mTSR4ZWWvyAt7XDPz+a1D/8nGuuwoi9JASAUHWpF7exNc
         j5iPOfK8Pe9JwxTdAs+4jOjUsh2hJm2F08et7bYyxnpRSwAxCp+2Y2S7r9ZUuU5elFc5
         PsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S3c6Mh8/nw2Ggap0ePvbku8BWleCnPN1cTGG7+MtNvM=;
        b=TvAVgibYHR0ne//1hT+Y0tRXb/tqgLZIdZhjrbfzgUKxJehNqO3Rh73Jw3bsilCLVg
         Drp6PlMMxN1A/higT+Ps/llQVOPe+Jnl11i+LCBVvf4FJhvMKqHnRT9i2KqWZPGYDUtH
         tforV58cLS1VvKTImp0+1AMrsyr1FdA7Yvnrf+tww9svcUU5n7KSUh21DQAP0C61u2KU
         6tk+AjYPWCb/sGkqnJhkT+geLDPP/ZlOgPx4wVLW1V/eqSLyOD/8efRPg2fD5IxxE0J6
         I+hjPpOU4g14EqLRM5/pg9hpmMrBVgm8Ry4JT/OhNOrn7kLqurWnisjNkw4Nz+NZOqKY
         umwA==
X-Gm-Message-State: AOAM531ZC9Emo0WLsQ6cE3+Tl+m75bM4vERetRaqShR8cT2JVCoLxSae
        4KKYO6XI5MP0c5TZEzdw4QgtIYjLYLfO+dKDEpx/o0twXkxQ5be85pXh8geEpzENqZHJutNP6Ln
        vtdRcB4gRHIqpxSYbGSkVZt9ezs25rdrN1GdzPosgYX6WzsPtaNhaRf5fSTCp4gOS9q/EotDZoh
        uCfBo4JDw=
X-Google-Smtp-Source: ABdhPJyWp/38Ytx1aVPMcooUXBGxRNJMK9r91iLdb6Hj1O6iVODyWgkth3WDDBPD/RoDOLdUT9PCOEG1VkE2qmQ7QbI=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a0c:99e6:: with SMTP id
 y38mr5506472qve.28.1605714051832; Wed, 18 Nov 2020 07:40:51 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:00 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-15-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 14/61] e2fsck: merge bitmaps after thread completes
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Li Xi <lixi@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

A new method merge_bmap has been added to bitmap operations. But
only red-black bitmap has that operation now.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c            | 239 +++++++++++++++++++++++---------------
 lib/ext2fs/bitmaps.c      |  10 ++
 lib/ext2fs/blkmap64_rb.c  |  65 +++++++++++
 lib/ext2fs/bmap64.h       |   4 +
 lib/ext2fs/ext2fs.h       |   8 ++
 lib/ext2fs/gen_bitmap64.c |  29 +++++
 6 files changed, 264 insertions(+), 91 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 528f0a6b..9e4abad0 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2124,12 +2124,38 @@ static errcode_t e2fsck_pass1_copy_bitmap(ext2_filsys fs, ext2fs_generic_bitmap
 		return ret;
 
 	(*dest)->fs = fs;
-	ext2fs_free_generic_bmap(*src);
-	*src = NULL;
 
 	return 0;
 }
 
+static void e2fsck_pass1_free_bitmap(ext2fs_generic_bitmap *bitmap)
+{
+	if (*bitmap) {
+		ext2fs_free_generic_bmap(*bitmap);
+		*bitmap = NULL;
+	}
+
+}
+
+static errcode_t e2fsck_pass1_merge_bitmap(ext2_filsys fs, ext2fs_generic_bitmap *src,
+					  ext2fs_generic_bitmap *dest)
+{
+	errcode_t ret = 0;
+
+	if (*src) {
+		if (*dest == NULL) {
+			*dest = *src;
+			*src = NULL;
+		} else {
+			ret = ext2fs_merge_bitmap(*src, *dest, NULL, NULL);
+			if (ret)
+				return ret;
+		}
+		(*dest)->fs = fs;
+	}
+
+	return 0;
+}
 
 static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, e2fsck_t src_context,
 				      ext2_filsys src)
@@ -2137,6 +2163,8 @@ static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, e2fsck_t src_context,
 	errcode_t	retval;
 
 	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
+	dest->inode_map = NULL;
+	dest->block_map = NULL;
 	if (dest->dblist)
 		dest->dblist->fs = dest;
 	if (src->block_map) {
@@ -2196,42 +2224,50 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	errcode_t retval = 0;
 	io_channel dest_io;
 	io_channel dest_image_io;
+	ext2fs_inode_bitmap inode_map;
+	ext2fs_block_bitmap block_map;
 
 	dest_io = dest->io;
 	dest_image_io = dest->image_io;
+	inode_map = dest->inode_map;
+	block_map = dest->block_map;
 
 	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
 	dest->io = dest_io;
 	dest->image_io = dest_image_io;
 	dest->icache = icache;
+	dest->inode_map = inode_map;
+	dest->block_map = block_map;
 	if (dest->dblist)
 		dest->dblist->fs = dest;
-	if (src->inode_map) {
-		retval = e2fsck_pass1_copy_bitmap(dest, &src->inode_map,
-						  &dest->inode_map);
-		if (retval)
-			return retval;
-	}
-	if (src->block_map) {
-		retval = e2fsck_pass1_copy_bitmap(dest, &src->block_map,
-						  &dest->block_map);
-		if (retval)
-			return retval;
-	}
 
 	if (src->icache) {
 		ext2fs_free_inode_cache(src->icache);
 		src->icache = NULL;
 	}
 
+	retval = e2fsck_pass1_merge_bitmap(dest, &src->inode_map,
+					   &dest->inode_map);
+	if (retval)
+		goto out;
+
+	retval = e2fsck_pass1_merge_bitmap(dest, &src->block_map,
+					  &dest->block_map);
+	if (retval)
+		goto out;
+
 	if (src->badblocks) {
 		retval = ext2fs_badblocks_copy(src->badblocks, &dest->badblocks);
 
 		ext2fs_badblocks_list_free(src->badblocks);
 		src->badblocks = NULL;
 	}
-
+out:
 	io_channel_close(src->io);
+	if (src->inode_map)
+		ext2fs_free_generic_bmap(src->inode_map);
+	if (src->block_map)
+		ext2fs_free_generic_bmap(src->block_map);
 	return retval;
 }
 
@@ -2321,6 +2357,18 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2_filsys	 global_fs = global_ctx->fs;
 	FILE		*global_logf = global_ctx->logf;
 	FILE		*global_problem_logf = global_ctx->problem_logf;
+	ext2fs_inode_bitmap inode_bad_map = global_ctx->inode_bad_map;
+	ext2fs_inode_bitmap inode_used_map = global_ctx->inode_used_map;
+	ext2fs_inode_bitmap inode_dir_map = global_ctx->inode_dir_map;
+	ext2fs_inode_bitmap inode_bb_map = global_ctx->inode_bb_map;
+	ext2fs_inode_bitmap inode_imagic_map = global_ctx->inode_imagic_map;
+	ext2fs_inode_bitmap inode_reg_map = global_ctx->inode_reg_map;
+	ext2fs_block_bitmap block_found_map = global_ctx->block_found_map;
+	ext2fs_block_bitmap block_dup_map = global_ctx->block_dup_map;
+	ext2fs_block_bitmap block_ea_map = global_ctx->block_ea_map;
+	ext2fs_block_bitmap block_metadata_map = global_ctx->block_metadata_map;
+	ext2fs_block_bitmap inodes_to_rebuild = global_ctx->inodes_to_rebuild;
+
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
 
@@ -2330,6 +2378,19 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 #ifdef HAVE_SETJMP_H
 	memcpy(global_ctx->abort_loc, old_jmp, sizeof(jmp_buf));
 #endif
+
+	global_ctx->inode_used_map = inode_used_map;
+	global_ctx->inode_bad_map = inode_bad_map;
+	global_ctx->inode_dir_map = inode_dir_map;
+	global_ctx->inode_bb_map = inode_bb_map;
+	global_ctx->inode_imagic_map = inode_imagic_map;
+	global_ctx->inodes_to_rebuild = inodes_to_rebuild;
+	global_ctx->inode_reg_map = inode_reg_map;
+	global_ctx->block_found_map = block_found_map;
+	global_ctx->block_dup_map = block_dup_map;
+	global_ctx->block_ea_map = block_ea_map;
+	global_ctx->block_metadata_map = block_metadata_map;
+
 	/* Keep the global singal flags*/
 	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
 			     (global_ctx->flags & E2F_FLAG_SIGNAL_MASK);
@@ -2345,83 +2406,62 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->problem_logf = global_problem_logf;
 	global_ctx->global_ctx = NULL;
 
-	if (thread_ctx->inode_used_map) {
-		retval = e2fsck_pass1_copy_bitmap(global_fs,
-					&thread_ctx->inode_used_map,
-					&global_ctx->inode_used_map);
-		if (retval)
-			return retval;
-	}
-	if (thread_ctx->inode_bad_map) {
-		retval = e2fsck_pass1_copy_bitmap(global_fs,
-					&thread_ctx->inode_bad_map,
-					&global_ctx->inode_bad_map);
-		if (retval)
-			return retval;
-	}
-	if (thread_ctx->inode_dir_map) {
-		retval = e2fsck_pass1_copy_bitmap(global_fs,
+	retval = e2fsck_pass1_merge_bitmap(global_fs,
+				&thread_ctx->inode_used_map,
+				&global_ctx->inode_used_map);
+	if (retval)
+		return retval;
+
+	retval = e2fsck_pass1_merge_bitmap(global_fs,
+				&thread_ctx->inode_bad_map,
+				&global_ctx->inode_bad_map);
+	if (retval)
+		return retval;
+	retval = e2fsck_pass1_merge_bitmap(global_fs,
 					&thread_ctx->inode_dir_map,
 					&global_ctx->inode_dir_map);
-		if (retval)
-			return retval;
-	}
-	if (thread_ctx->inode_bb_map) {
-		retval = e2fsck_pass1_copy_bitmap(global_fs,
-					&thread_ctx->inode_bb_map,
-					&global_ctx->inode_bb_map);
-		if (retval)
-			return retval;
-	}
-	if (thread_ctx->inode_imagic_map) {
-		retval = e2fsck_pass1_copy_bitmap(global_fs,
-					&thread_ctx->inode_imagic_map,
-					&global_ctx->inode_imagic_map);
-		if (retval)
-			return retval;
-	}
-	if (thread_ctx->inode_reg_map) {
-		retval = e2fsck_pass1_copy_bitmap(global_fs,
-					&thread_ctx->inode_reg_map,
-					&global_ctx->inode_reg_map);
-		if (retval)
-			return retval;
-	}
-	if (thread_ctx->inodes_to_rebuild) {
-		retval = e2fsck_pass1_copy_bitmap(global_fs,
-					&thread_ctx->inodes_to_rebuild,
-					&global_ctx->inodes_to_rebuild);
-		if (retval)
-			return retval;
-	}
-	if (thread_ctx->block_found_map) {
-		retval = e2fsck_pass1_copy_bitmap(global_fs,
-					&thread_ctx->block_found_map,
-					&global_ctx->block_found_map);
-		if (retval)
-			return retval;
-	}
-	if (thread_ctx->block_dup_map) {
-		retval = e2fsck_pass1_copy_bitmap(global_fs,
-					&thread_ctx->block_dup_map,
-					&global_ctx->block_dup_map);
-		if (retval)
-			return retval;
-	}
-	if (thread_ctx->block_ea_map) {
-		retval = e2fsck_pass1_copy_bitmap(global_fs,
-					&thread_ctx->block_ea_map,
-					&global_ctx->block_ea_map);
-		if (retval)
-			return retval;
-	}
-	if (thread_ctx->block_metadata_map) {
-		retval = e2fsck_pass1_copy_bitmap(global_fs,
-					&thread_ctx->block_metadata_map,
-					&global_ctx->block_metadata_map);
-		if (retval)
-			return retval;
-	}
+	if (retval)
+		return retval;
+	retval = e2fsck_pass1_merge_bitmap(global_fs,
+				&thread_ctx->inode_bb_map,
+				&global_ctx->inode_bb_map);
+	if (retval)
+		return retval;
+	retval = e2fsck_pass1_merge_bitmap(global_fs,
+				&thread_ctx->inode_imagic_map,
+				&global_ctx->inode_imagic_map);
+	if (retval)
+		return retval;
+	retval = e2fsck_pass1_merge_bitmap(global_fs,
+				&thread_ctx->inode_reg_map,
+				&global_ctx->inode_reg_map);
+	if (retval)
+		return retval;
+	retval = e2fsck_pass1_merge_bitmap(global_fs,
+				&thread_ctx->inodes_to_rebuild,
+				&global_ctx->inodes_to_rebuild);
+	if (retval)
+		return retval;
+	retval = e2fsck_pass1_merge_bitmap(global_fs,
+				&thread_ctx->block_found_map,
+				&global_ctx->block_found_map);
+	if (retval)
+		return retval;
+	retval = e2fsck_pass1_merge_bitmap(global_fs,
+				&thread_ctx->block_dup_map,
+				&global_ctx->block_dup_map);
+	if (retval)
+		return retval;
+	retval = e2fsck_pass1_merge_bitmap(global_fs,
+				&thread_ctx->block_ea_map,
+				&global_ctx->block_ea_map);
+	if (retval)
+		return retval;
+	retval = e2fsck_pass1_merge_bitmap(global_fs,
+				&thread_ctx->block_metadata_map,
+				&global_ctx->block_metadata_map);
+	if (retval)
+		return retval;
 
 	return 0;
 }
@@ -2438,6 +2478,17 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 		fputs("</problem_log>\n", thread_ctx->problem_logf);
 		fclose(thread_ctx->problem_logf);
 	}
+	e2fsck_pass1_free_bitmap(&thread_ctx->inode_used_map);
+	e2fsck_pass1_free_bitmap(&thread_ctx->inode_bad_map);
+	e2fsck_pass1_free_bitmap(&thread_ctx->inode_dir_map);
+	e2fsck_pass1_free_bitmap(&thread_ctx->inode_bb_map);
+	e2fsck_pass1_free_bitmap(&thread_ctx->inode_imagic_map);
+	e2fsck_pass1_free_bitmap(&thread_ctx->inode_reg_map);
+	e2fsck_pass1_free_bitmap(&thread_ctx->inodes_to_rebuild);
+	e2fsck_pass1_free_bitmap(&thread_ctx->block_found_map);
+	e2fsck_pass1_free_bitmap(&thread_ctx->block_dup_map);
+	e2fsck_pass1_free_bitmap(&thread_ctx->block_ea_map);
+	e2fsck_pass1_free_bitmap(&thread_ctx->block_metadata_map);
 	ext2fs_free_mem(&thread_ctx);
 
 	return retval;
@@ -2464,7 +2515,13 @@ static int e2fsck_pass1_threads_join(struct e2fsck_thread_info *infos,
 			if (ret == 0)
 				ret = rc;
 		}
-		e2fsck_pass1_thread_join(global_ctx, infos[i].eti_thread_ctx);
+		rc = e2fsck_pass1_thread_join(global_ctx, infos[i].eti_thread_ctx);
+		if (rc) {
+			com_err(global_ctx->program_name, rc,
+				_("while joining pass1 thread\n"));
+			if (ret == 0)
+				ret = rc;
+		}
 	}
 	free(infos);
 
diff --git a/lib/ext2fs/bitmaps.c b/lib/ext2fs/bitmaps.c
index 834a3962..000df234 100644
--- a/lib/ext2fs/bitmaps.c
+++ b/lib/ext2fs/bitmaps.c
@@ -45,6 +45,16 @@ errcode_t ext2fs_copy_bitmap(ext2fs_generic_bitmap src,
 {
 	return (ext2fs_copy_generic_bmap(src, dest));
 }
+
+errcode_t ext2fs_merge_bitmap(ext2fs_generic_bitmap src,
+			      ext2fs_generic_bitmap dest,
+			      ext2fs_generic_bitmap dup,
+			      ext2fs_generic_bitmap dup_allowed)
+{
+	return ext2fs_merge_generic_bmap(src, dest, dup,
+					 dup_allowed);
+}
+
 void ext2fs_set_bitmap_padding(ext2fs_generic_bitmap map)
 {
 	ext2fs_set_generic_bmap_padding(map);
diff --git a/lib/ext2fs/blkmap64_rb.c b/lib/ext2fs/blkmap64_rb.c
index 1fd55274..7150d791 100644
--- a/lib/ext2fs/blkmap64_rb.c
+++ b/lib/ext2fs/blkmap64_rb.c
@@ -968,11 +968,76 @@ static void rb_print_stats(ext2fs_generic_bitmap_64 bitmap EXT2FS_ATTR((unused))
 }
 #endif
 
+static errcode_t rb_merge_bmap(ext2fs_generic_bitmap_64 src,
+			       ext2fs_generic_bitmap_64 dest,
+			       ext2fs_generic_bitmap_64 dup,
+			       ext2fs_generic_bitmap_64 dup_allowed)
+{
+	struct ext2fs_rb_private *src_bp, *dest_bp, *dup_bp = NULL;
+	struct bmap_rb_extent *src_ext;
+	struct rb_node *src_node;
+	errcode_t retval = 0;
+	int dup_found = 0;
+	__u64 i;
+
+	src_bp = (struct ext2fs_rb_private *) src->private;
+	dest_bp = (struct ext2fs_rb_private *) dest->private;
+	if (dup)
+		dup_bp = (struct ext2fs_rb_private *)dup->private;
+	src_bp->rcursor = NULL;
+	dest_bp->rcursor = NULL;
+
+	src_node = ext2fs_rb_first(&src_bp->root);
+	while (src_node) {
+		src_ext = node_to_extent(src_node);
+		retval = rb_test_clear_bmap_extent(dest,
+					src_ext->start + src->start,
+					src_ext->count);
+		if (retval) {
+			rb_insert_extent(src_ext->start, src_ext->count,
+					 dest_bp);
+			goto next;
+		}
+
+		/* unlikely case, do it one by one block */
+		for (i = src_ext->start;
+		     i < src_ext->start + src_ext->count; i++) {
+			retval = rb_test_clear_bmap_extent(dest, i + src->start, 1);
+			if (retval) {
+				rb_insert_extent(i, 1, dest_bp);
+				continue;
+			}
+			if (dup_allowed) {
+				retval = rb_test_clear_bmap_extent(dup_allowed,
+							i + src->start, 1);
+				/* not existed in dup_allowed */
+				if (retval) {
+					dup_found = 1;
+					if (dup_bp)
+						rb_insert_extent(i, 1, dup_bp);
+				} /* else we conside it not duplicated */
+			} else {
+				if (dup_bp)
+					rb_insert_extent(i, 1, dup_bp);
+				dup_found = 1;
+			}
+		}
+next:
+		src_node = ext2fs_rb_next(src_node);
+	}
+
+	if (dup_found && dup)
+		return EEXIST;
+
+	return 0;
+}
+
 struct ext2_bitmap_ops ext2fs_blkmap64_rbtree = {
 	.type = EXT2FS_BMAP64_RBTREE,
 	.new_bmap = rb_new_bmap,
 	.free_bmap = rb_free_bmap,
 	.copy_bmap = rb_copy_bmap,
+	.merge_bmap = rb_merge_bmap,
 	.resize_bmap = rb_resize_bmap,
 	.mark_bmap = rb_mark_bmap,
 	.unmark_bmap = rb_unmark_bmap,
diff --git a/lib/ext2fs/bmap64.h b/lib/ext2fs/bmap64.h
index de334548..555193ee 100644
--- a/lib/ext2fs/bmap64.h
+++ b/lib/ext2fs/bmap64.h
@@ -72,6 +72,10 @@ struct ext2_bitmap_ops {
 	void	(*free_bmap)(ext2fs_generic_bitmap_64 bitmap);
 	errcode_t (*copy_bmap)(ext2fs_generic_bitmap_64 src,
 			     ext2fs_generic_bitmap_64 dest);
+	errcode_t (*merge_bmap)(ext2fs_generic_bitmap_64 src,
+				ext2fs_generic_bitmap_64 dest,
+				ext2fs_generic_bitmap_64 dup,
+				ext2fs_generic_bitmap_64 dup_allowed);
 	errcode_t (*resize_bmap)(ext2fs_generic_bitmap_64 bitmap,
 			       __u64 new_end,
 			       __u64 new_real_end);
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 5b76d02e..0aa1d94e 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -837,6 +837,10 @@ extern void ext2fs_free_block_bitmap(ext2fs_block_bitmap bitmap);
 extern void ext2fs_free_inode_bitmap(ext2fs_inode_bitmap bitmap);
 extern errcode_t ext2fs_copy_bitmap(ext2fs_generic_bitmap src,
 				    ext2fs_generic_bitmap *dest);
+errcode_t ext2fs_merge_bitmap(ext2fs_generic_bitmap src,
+			      ext2fs_generic_bitmap dest,
+			      ext2fs_generic_bitmap dup,
+			      ext2fs_generic_bitmap dup_allowed);
 extern errcode_t ext2fs_write_inode_bitmap(ext2_filsys fs);
 extern errcode_t ext2fs_write_block_bitmap (ext2_filsys fs);
 extern errcode_t ext2fs_read_inode_bitmap (ext2_filsys fs);
@@ -1433,6 +1437,10 @@ void ext2fs_set_generic_bmap_padding(ext2fs_generic_bitmap bmap);
 errcode_t ext2fs_resize_generic_bmap(ext2fs_generic_bitmap bmap,
 				     __u64 new_end,
 				     __u64 new_real_end);
+errcode_t ext2fs_merge_generic_bmap(ext2fs_generic_bitmap gen_src,
+                                    ext2fs_generic_bitmap gen_dest,
+				    ext2fs_generic_bitmap gen_dup,
+				    ext2fs_generic_bitmap dup_allowed);
 errcode_t ext2fs_compare_generic_bmap(errcode_t neq,
 				      ext2fs_generic_bitmap bm1,
 				      ext2fs_generic_bitmap bm2);
diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
index b2370667..50617a34 100644
--- a/lib/ext2fs/gen_bitmap64.c
+++ b/lib/ext2fs/gen_bitmap64.c
@@ -344,6 +344,35 @@ errcode_t ext2fs_copy_generic_bmap(ext2fs_generic_bitmap gen_src,
 	return 0;
 }
 
+errcode_t ext2fs_merge_generic_bmap(ext2fs_generic_bitmap gen_src,
+				    ext2fs_generic_bitmap gen_dest,
+				    ext2fs_generic_bitmap gen_dup,
+				    ext2fs_generic_bitmap gen_dup_allowed)
+{
+	ext2fs_generic_bitmap_64 src = (ext2fs_generic_bitmap_64)gen_src;
+	ext2fs_generic_bitmap_64 dest = (ext2fs_generic_bitmap_64)gen_dest;
+	ext2fs_generic_bitmap_64 dup = (ext2fs_generic_bitmap_64)gen_dup;
+	ext2fs_generic_bitmap_64 dup_allowed = (ext2fs_generic_bitmap_64)gen_dup_allowed;
+
+	if (!src || !dest)
+		return EINVAL;
+
+	if (!EXT2FS_IS_64_BITMAP(src) || !EXT2FS_IS_64_BITMAP(dest) ||
+	    (dup && !EXT2FS_IS_64_BITMAP(dup)) ||
+		(dup_allowed && !EXT2FS_IS_64_BITMAP(dup_allowed)))
+		return EINVAL;
+
+	if (src->bitmap_ops != dest->bitmap_ops ||
+	    (dup && src->bitmap_ops != dup->bitmap_ops) ||
+	    (dup_allowed && src->bitmap_ops != dup_allowed->bitmap_ops))
+		return EINVAL;
+
+	if (src->bitmap_ops->merge_bmap == NULL)
+		return EOPNOTSUPP;
+
+	return src->bitmap_ops->merge_bmap(src, dest, dup, dup_allowed);
+}
+
 errcode_t ext2fs_resize_generic_bmap(ext2fs_generic_bitmap gen_bmap,
 				     __u64 new_end,
 				     __u64 new_real_end)
-- 
2.29.2.299.gdc1121823c-goog

