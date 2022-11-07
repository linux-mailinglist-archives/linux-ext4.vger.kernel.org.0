Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6444161F304
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiKGMZ3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiKGMZL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:25:11 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF7F140FC
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:25:10 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso14458400pjc.0
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2G1Y5RYslrYkDHJpJVANf9ho1llYiDGkhLIpEGsIOvQ=;
        b=pNMdoONQaWLIssCJN0Z7wA0OLZ3vbDWGTtv5cJkcT4+uJGprRm4C9N/XPo3Ff0tAS7
         APOftga1RoYUWSXnVxO8Kp6VFCEBTqjkJyviXp9UaPSKX7elBsrf5nAncYe/nGIpJdAM
         8KbCYYi6Y3FQkwH25d1wzDjQEXCc1sUxZPFbj6UenjA5VeOh3U9cjY8E8iD3Lvuqt34C
         X69hlX+gDJ9dvt6CfS5EOjhq9G33iFMZ32X0MjPxYp2Y8P1laMa1j+tqK/0ZFYsc/xYJ
         nfoZDOzmSXiYGHBfGoPdWKa0vJnv7Rg8HyDoADV+4T0YQA0s60i8rfu2sczgihfT2oAQ
         T25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2G1Y5RYslrYkDHJpJVANf9ho1llYiDGkhLIpEGsIOvQ=;
        b=Ih+YzJrYy5gJ/uvoFQJ+trDdei3pQ+CEAi68ZSFedNL69wvQOrad3OnaJ9I9qPDHPv
         +8KKZZSDY0X65zKhQ3YinpXVY7ToUISG5nEplBRmU4bhfDpK8A/UBfhgjLi52ZpBomFl
         lPq+K6iaeXPbHwc0nFSUay2Cxe4zh2kxr04tBHbAQ7QUPIwEo/xfv2dIjnKur20HvI3P
         fJR5R8tzpmQZD3FTJYlu+aLXEHa3/OHU/Pg1ho6UExM5m/qdbe/5BRup5qDJzg/wL1n4
         pwB/8KUjXuq8t55hPNU9k+k629ZWTvBFDpY7lZPN2w4efGw497QO9iSDU59gNzr0z5vJ
         yPVg==
X-Gm-Message-State: ACrzQf1L8JPO+sVfE2GvzR5fIOLm2B152wwczmuBEaT/lAZ4m9U++g08
        J5rvS7O3HBNutVpayUONXEiT9Va92ig=
X-Google-Smtp-Source: AMsMyM5nEuheg+wky1D63STUoBziZ3VE4hLu3dO7q8F74v3Uw7RFts9IkV8kR27QYMMZM/QFFjF/Pw==
X-Received: by 2002:a17:902:ebc5:b0:186:b848:c6a with SMTP id p5-20020a170902ebc500b00186b8480c6amr49963757plg.46.1667823910258;
        Mon, 07 Nov 2022 04:25:10 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b0018157b415dbsm4889596plg.63.2022.11.07.04.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:25:09 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 27/72] e2fsck: Add e2fsck_pass1_merge_bitmap() api
Date:   Mon,  7 Nov 2022 17:51:15 +0530
Message-Id: <0ec6a72242cc188ef8d9b308bf862a310801ce76.1667822611.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667822611.git.ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

This adds e2fsck_pass1_merge_bitmap() which uses libext2fs merge api
(ext2fs_merge_bitmap()) to merge all the bitmaps after threads finishes.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 128 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 040c58ce..9a273515 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -50,6 +50,7 @@
 #ifdef HAVE_PTHREAD
 #include <pthread.h>
 #endif
+#include <assert.h>
 
 #include "e2fsck.h"
 #include <ext2fs/ext2_ext_attr.h>
@@ -2154,6 +2155,26 @@ endit:
 }
 
 #ifdef HAVE_PTHREAD
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
+
 static errcode_t e2fsck_open_channel_fs(ext2_filsys dest, e2fsck_t dest_context, ext2_filsys src)
 {
 	errcode_t retval;
@@ -2185,6 +2206,19 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 	ext2_filsys thread_fs;
 	ext2_filsys global_fs = global_ctx->fs;
 
+	assert(global_ctx->inode_used_map == NULL);
+	assert(global_ctx->inode_dir_map == NULL);
+	assert(global_ctx->inode_bb_map == NULL);
+	assert(global_ctx->inode_imagic_map == NULL);
+	assert(global_ctx->inode_reg_map == NULL);
+	assert(global_ctx->inodes_to_rebuild == NULL);
+
+	assert(global_ctx->block_found_map == NULL);
+	assert(global_ctx->block_dup_map == NULL);
+	assert(global_ctx->block_ea_map == NULL);
+	assert(global_ctx->block_metadata_map == NULL);
+	assert(global_ctx->fs->dblist == NULL);
+
 	retval = ext2fs_get_mem(sizeof(struct e2fsck_struct), &thread_context);
 	if (retval) {
 		com_err(global_ctx->program_name, retval, "while allocating memory");
@@ -2225,6 +2259,18 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	FILE *global_problem_logf = global_ctx->problem_logf;
 	ext2_filsys thread_fs = thread_ctx->fs;
 	ext2_filsys global_fs = global_ctx->fs;
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
 	jmp_buf old_jmp;
 
@@ -2234,6 +2280,19 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
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
@@ -2248,6 +2307,63 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 		com_err(global_ctx->program_name, 0, _("while merging fs\n"));
 		return retval;
 	}
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
+					&thread_ctx->inode_dir_map,
+					&global_ctx->inode_dir_map);
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
+
 	return retval;
 }
 
@@ -2256,6 +2372,18 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	errcode_t retval;
 
 	retval = e2fsck_pass1_thread_join_one(global_ctx, thread_ctx);
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
+
 	if (thread_ctx->logf)
 		fclose(thread_ctx->logf);
 	if (thread_ctx->problem_logf) {
-- 
2.37.3

