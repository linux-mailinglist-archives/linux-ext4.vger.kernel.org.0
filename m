Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBBD2B80C3
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbgKRPki (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbgKRPkh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:40:37 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D66C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:37 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id y21so1560206qve.7
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3EsIdul8B1iDcETbJXNdm4LPFL00xJZO0DAQ9j/K5Jw=;
        b=PZPOu0fHUW0bQcF+PUUr5SE5HNC/Q2cALj2eLyW7Bu2wRRz+DbGUfWOkSXxJrotytG
         erK7LrVZSjkA7zYKV0TK0ReXGk8bFjz2cjmc9qbvnisgvUObmEmJcoughy/9HROCuUMd
         t00ukZ19uWD3ZxgIFxGdR/CVXgoQmZszhzLCIkgbYwh3d+wLzf4eiX6OaExibsr/0mJm
         6tf7O/+K7mWHeaHmJlpHX8gyoaCCiWgtiecJbYPnvUQqNXhFqr9u+w2KF0idf17BSDFf
         s1ioi7TIRnFUwBlTXomneV5ID9BvMyyWW+cXkbVupWQerNUuD8ehO9htADG6CEEkcO/J
         sfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3EsIdul8B1iDcETbJXNdm4LPFL00xJZO0DAQ9j/K5Jw=;
        b=RG6WjgMUroV5lrHkG7iQ3lZpahHTOIC+68oCufjIo6iDLA9NYQPsXXtQpfHpRZTN6c
         vHWPMnWbjyUIzUdgNpTjazv1KtmL10iCpQ0yVntISOo1coU8eeZAtXuvsDsA+D2ipzfj
         fjRku5lWmkC1ueO3VAW+yWYNWFdBUh8/iQ3CmOa8hNGwk83BOUrvIDdGteEFfb8tReIs
         2PMFbLyBZGuC2En0PwvC+EAxxbXUvm8FdNEnpYRIvAys0GR5gMHbZAq2k7lJ3DUJ+Cno
         20siCo6CbeLyd4swlookNsXYaW0rRmt8sJtnJOVMxZLZltiNdPt2/e3LGvkO2351YoXH
         8HwA==
X-Gm-Message-State: AOAM531urmpUu+DqVzpygYvXvjaNWabENnwyoW87enH/qYmHVK7a33pq
        KUBxHFSixeCwbwWR1xp/fZNZgu1JzOu1eyMa5rFffIrpzpqGZVFJwlViYWETXolPHDrB/E1wSf7
        iVtejVjl7PffGGFxsdwf4GxyRHS2CO/23Qi0VDkgi4IyC5YXqXS1Pqdt+xTRMN6NyXcYcv5aYoe
        yCBEnduVg=
X-Google-Smtp-Source: ABdhPJzeqc7MiFvXOPS3asQrl23PQQwxFkaAwqigEIvLCX/Thtg64Wy7AUxvoqfH46gOqCtUriG/b4uxO4lEiWCCGhg=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a0c:99c6:: with SMTP id
 y6mr5048968qve.60.1605714036667; Wed, 18 Nov 2020 07:40:36 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:38:52 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-7-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 06/61] e2fsck: copy bitmaps when copying context
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Li Xi <lixi@ddn.com>,
        Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

This patch copies bitmap when the copying context. In the
multi-thread fsck, each thread use different bitmap that copied
from the glboal bitmap. And Bitmaps from multiple threads will
be merged into a global one after the pass1 finishes.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c | 151 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 139 insertions(+), 12 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index d16bedd3..3a4286e1 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2087,6 +2087,22 @@ endit:
 		ctx->invalid_bitmaps++;
 }
 
+static errcode_t e2fsck_pass1_copy_bitmap(ext2_filsys fs, ext2fs_generic_bitmap *src,
+					  ext2fs_generic_bitmap *dest)
+{
+	errcode_t ret;
+
+	ret = ext2fs_copy_bitmap(*src, dest);
+	if (ret)
+		return ret;
+
+	(*dest)->fs = fs;
+	ext2fs_free_generic_bmap(*src);
+	*src = NULL;
+
+	return 0;
+}
+
 static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, ext2_filsys src)
 {
 	errcode_t	retval;
@@ -2094,33 +2110,52 @@ static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, ext2_filsys src)
 	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
 	if (dest->dblist)
 		dest->dblist->fs = dest;
-	if (dest->inode_map)
-		dest->inode_map->fs = dest;
-	if (dest->block_map)
-		dest->block_map->fs = dest;
+	if (src->block_map) {
+		retval = e2fsck_pass1_copy_bitmap(dest, &src->block_map,
+						  &dest->block_map);
+		if (retval)
+			return retval;
+	}
+	if (src->inode_map) {
+		retval = e2fsck_pass1_copy_bitmap(dest, &src->inode_map,
+						  &dest->inode_map);
+		if (retval)
+			return retval;
+	}
 
 	/* icache will be rebuilt if needed, so do not copy from @src */
 	src->icache = NULL;
 	return 0;
 }
 
-static void e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
+static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 {
 	struct ext2_inode_cache *icache = dest->icache;
+	errcode_t	retval = 0;
 
 	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
 	if (dest->dblist)
 		dest->dblist->fs = dest;
-	if (dest->inode_map)
-		dest->inode_map->fs = dest;
-	if (dest->block_map)
-		dest->block_map->fs = dest;
+	if (src->inode_map) {
+		retval = e2fsck_pass1_copy_bitmap(dest, &src->inode_map,
+						  &dest->inode_map);
+		if (retval)
+			return retval;
+	}
+	if (src->block_map) {
+		retval = e2fsck_pass1_copy_bitmap(dest, &src->block_map,
+						  &dest->block_map);
+		if (retval)
+			return retval;
+	}
 	dest->icache = icache;
 
 	if (src->icache) {
 		ext2fs_free_inode_cache(src->icache);
 		src->icache = NULL;
 	}
+
+	return retval;
 }
 
 static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx)
@@ -2174,8 +2209,9 @@ out_context:
 	return retval;
 }
 
-static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
+static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 {
+	errcode_t	retval;
 	int		flags = global_ctx->flags;
 	ext2_filsys	thread_fs = thread_ctx->fs;
 	ext2_filsys	global_fs = global_ctx->fs;
@@ -2192,13 +2228,104 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
 			     (global_ctx->flags & E2F_FLAG_SIGNAL_MASK);
 
-	e2fsck_pass1_merge_fs(global_fs, thread_fs);
+	retval = e2fsck_pass1_merge_fs(global_fs, thread_fs);
+	if (retval) {
+		com_err(global_ctx->program_name, 0, _("while merging fs\n"));
+		return retval;
+	}
 	global_fs->priv_data = global_ctx;
 	global_ctx->fs = global_fs;
 
+	if (thread_ctx->inode_used_map) {
+		retval = e2fsck_pass1_copy_bitmap(global_fs,
+					&thread_ctx->inode_used_map,
+					&global_ctx->inode_used_map);
+		if (retval)
+			return retval;
+	}
+	if (thread_ctx->inode_bad_map) {
+		retval = e2fsck_pass1_copy_bitmap(global_fs,
+					&thread_ctx->inode_bad_map,
+					&global_ctx->inode_bad_map);
+		if (retval)
+			return retval;
+	}
+	if (thread_ctx->inode_dir_map) {
+		retval = e2fsck_pass1_copy_bitmap(global_fs,
+					&thread_ctx->inode_dir_map,
+					&global_ctx->inode_dir_map);
+		if (retval)
+			return retval;
+	}
+	if (thread_ctx->inode_bb_map) {
+		retval = e2fsck_pass1_copy_bitmap(global_fs,
+					&thread_ctx->inode_bb_map,
+					&global_ctx->inode_bb_map);
+		if (retval)
+			return retval;
+	}
+	if (thread_ctx->inode_imagic_map) {
+		retval = e2fsck_pass1_copy_bitmap(global_fs,
+					&thread_ctx->inode_imagic_map,
+					&global_ctx->inode_imagic_map);
+		if (retval)
+			return retval;
+	}
+	if (thread_ctx->inode_reg_map) {
+		retval = e2fsck_pass1_copy_bitmap(global_fs,
+					&thread_ctx->inode_reg_map,
+					&global_ctx->inode_reg_map);
+		if (retval)
+			return retval;
+	}
+	if (thread_ctx->inodes_to_rebuild) {
+		retval = e2fsck_pass1_copy_bitmap(global_fs,
+					&thread_ctx->inodes_to_rebuild,
+					&global_ctx->inodes_to_rebuild);
+		if (retval)
+			return retval;
+	}
+	if (thread_ctx->block_found_map) {
+		retval = e2fsck_pass1_copy_bitmap(global_fs,
+					&thread_ctx->block_found_map,
+					&global_ctx->block_found_map);
+		if (retval)
+			return retval;
+	}
+	if (thread_ctx->block_dup_map) {
+		retval = e2fsck_pass1_copy_bitmap(global_fs,
+					&thread_ctx->block_dup_map,
+					&global_ctx->block_dup_map);
+		if (retval)
+			return retval;
+	}
+	if (thread_ctx->block_ea_map) {
+		retval = e2fsck_pass1_copy_bitmap(global_fs,
+					&thread_ctx->block_ea_map,
+					&global_ctx->block_ea_map);
+		if (retval)
+			return retval;
+	}
+	if (thread_ctx->block_metadata_map) {
+		retval = e2fsck_pass1_copy_bitmap(global_fs,
+					&thread_ctx->block_metadata_map,
+					&global_ctx->block_metadata_map);
+		if (retval)
+			return retval;
+	}
+
+	return 0;
+}
+
+static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
+{
+	errcode_t	retval;
+
+	retval = e2fsck_pass1_thread_join_one(global_ctx, thread_ctx);
 	ext2fs_free_mem(&thread_ctx->fs);
 	ext2fs_free_mem(&thread_ctx);
-	return 0;
+
+	return retval;
 }
 
 void e2fsck_pass1_multithread(e2fsck_t ctx)
-- 
2.29.2.299.gdc1121823c-goog

