Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D9B61F311
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiKGM02 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiKGM0Z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:26:25 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BD0140F6
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:26:23 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id 4so10956110pli.0
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+HeHSxpZtZ5nOaOUqlqkZGRWAIsUwzBESOK8Dchek0=;
        b=ihAmjaPGcQDy9redWad3uoZ42ppMe4TMvyZ4OW8QDKNJSOBgnC2j4XtnulMWuj3BBo
         zu5qijV1MGnf+R4gzpqpwV0fhFBNNhQZrF53OQ1BSQ9JzneWaHytXfSakFC0SBVaOSal
         wI/vB2Nfc/2BAfSqs1gq9f0+uCSsW02grAJKgiIzRWJH1LBNIn+oB12qR+O958KEootg
         9OZgJsgd1h5we6KRi/xFsL63aL58oatXRceQTlyXJPOZamxvT4CigH+s6qli2DjBjiwJ
         smnMagNdblxP47DZy4OThyNkeB2yodFK00dg/TP6PZpO09YnQrXM1qnj4otbPQn+Ak8Q
         rVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+HeHSxpZtZ5nOaOUqlqkZGRWAIsUwzBESOK8Dchek0=;
        b=8JIyk7ZJ4j6kbCZ2UCZycJr5eNY8sp+IoxoFK88c/oCzV9p1hriiFmQcD3TsEOor+f
         HLkCyfsr+4bLMS5lwQttBGN71ZeOv3WFU5lXihjvdGIXBBtHsFcdb88of5ZKfTPmFbb0
         uxtDQEbKolh67zmDuOVZpGlznq2HkFqkGzxWcxbpPQfgHhOst7OQo3qcrGLZ52k++xCB
         UILvym2baSSScdpnElhnYe6XNqfmlOSfOcwpOKiCBGqsAOl9r+RO1Xe8bcC/O+klxcYm
         9wD21kT2BwQYREcwUWCrceGWOIPTUi8R99U7auqwUlbdDtpYu+GKm9yoNJayBMfEld/k
         u4Nw==
X-Gm-Message-State: ACrzQf3Vak+DaVHFdV0Rq0/spAEVQvQaQu0Nq56XiBmP3s+V+VZEtWcx
        U8fHvz9TruD8wJfHXIV+tlY=
X-Google-Smtp-Source: AMsMyM4jp6GgnjrfuAxRCjvRbirYJwchwVsVkdGwYv03eFcfNkM1k267uFU/NuEJyfFB6PpSdvQl1g==
X-Received: by 2002:a17:90b:3696:b0:214:1611:a497 with SMTP id mj22-20020a17090b369600b002141611a497mr33643779pjb.78.1667823983053;
        Mon, 07 Nov 2022 04:26:23 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id i184-20020a6254c1000000b0053e468a78a8sm4344955pfb.158.2022.11.07.04.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:26:22 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 39/72] e2fsck: merge dx_dir_info after threads finish
Date:   Mon,  7 Nov 2022 17:51:27 +0530
Message-Id: <ce0d19896608c68e0e2adabc754961f9ffeb8e27.1667822611.git.ritesh.list@gmail.com>
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

Merge properly.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/dx_dirinfo.c | 64 +++++++++++++++++++++++++++++++++++++++++++++
 e2fsck/e2fsck.h     |  1 +
 e2fsck/pass1.c      | 23 ++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/e2fsck/dx_dirinfo.c b/e2fsck/dx_dirinfo.c
index caca3e30..91954572 100644
--- a/e2fsck/dx_dirinfo.c
+++ b/e2fsck/dx_dirinfo.c
@@ -5,6 +5,7 @@
  * under the terms of the GNU Public License.
  */
 
+#include <assert.h>
 #include "config.h"
 #include "e2fsck.h"
 
@@ -79,6 +80,69 @@ void e2fsck_add_dx_dir(e2fsck_t ctx, ext2_ino_t ino, struct ext2_inode *inode,
 				       "dx_block info array");
 }
 
+/*
+ * Merge two sorted dir info to @dest
+ */
+void e2fsck_merge_dx_dir(e2fsck_t global_ctx, e2fsck_t thread_ctx)
+{
+	struct dx_dir_info *src_array = thread_ctx->dx_dir_info;
+	struct dx_dir_info *dest_array = global_ctx->dx_dir_info;
+	size_t size_dx_info = sizeof(struct dx_dir_info);
+	ext2_ino_t size = global_ctx->dx_dir_info_size;
+	ext2_ino_t src_count = thread_ctx->dx_dir_info_count;
+	ext2_ino_t dest_count = global_ctx->dx_dir_info_count;
+	ext2_ino_t total_count = src_count + dest_count;
+	struct dx_dir_info *array;
+	struct dx_dir_info *array_ptr;
+	ext2_ino_t src_index = 0, dest_index = 0;
+
+	if (thread_ctx->dx_dir_info_count == 0)
+		return;
+
+	if (size < total_count)
+		size = total_count;
+
+	array = e2fsck_allocate_memory(global_ctx, size * size_dx_info,
+				       "directory map");
+	array_ptr = array;
+	/*
+	 * This can be improved by binary search and memcpy, but codes
+	 * would be more complex. And if the groups distributed to each
+	 * thread are strided, this implementation won't be too bad
+	 * comparing to the optimiztion.
+	 */
+	while (src_index < src_count || dest_index < dest_count) {
+		if (src_index >= src_count) {
+			memcpy(array_ptr, &dest_array[dest_index],
+			       (dest_count - dest_index) * size_dx_info);
+			break;
+		}
+		if (dest_index >= dest_count) {
+			memcpy(array_ptr, &src_array[src_index],
+			       (src_count - src_index) * size_dx_info);
+			break;
+		}
+		if (src_array[src_index].ino < dest_array[dest_index].ino) {
+			*array_ptr = src_array[src_index];
+			src_index++;
+		} else {
+			assert(src_array[src_index].ino >
+			       dest_array[dest_index].ino);
+			*array_ptr = dest_array[dest_index];
+			dest_index++;
+		}
+		array_ptr++;
+	}
+
+	if (global_ctx->dx_dir_info)
+		ext2fs_free_mem(&global_ctx->dx_dir_info);
+	if (thread_ctx->dx_dir_info)
+		ext2fs_free_mem(&thread_ctx->dx_dir_info);
+	global_ctx->dx_dir_info = array;
+	global_ctx->dx_dir_info_size = size;
+	global_ctx->dx_dir_info_count = total_count;
+}
+
 /*
  * get_dx_dir_info() --- given an inode number, try to find the directory
  * information entry for it.
diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 9b0f5067..26c3b8a5 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -578,6 +578,7 @@ extern int e2fsck_dir_info_get_parent(e2fsck_t ctx, ext2_ino_t ino,
 				      ext2_ino_t *parent);
 extern int e2fsck_dir_info_get_dotdot(e2fsck_t ctx, ext2_ino_t ino,
 				      ext2_ino_t *dotdot);
+extern void e2fsck_merge_dx_dir(e2fsck_t global_ctx, e2fsck_t thread_ctx);
 
 /* dx_dirinfo.c */
 extern void e2fsck_add_dx_dir(e2fsck_t ctx, ext2_ino_t ino,
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 8b502307..f998590e 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2341,6 +2341,22 @@ static void e2fsck_pass1_merge_dir_info(e2fsck_t global_ctx, e2fsck_t thread_ctx
 			      global_ctx->dir_info);
 }
 
+static void e2fsck_pass1_merge_dx_dir(e2fsck_t global_ctx, e2fsck_t thread_ctx)
+{
+	if (thread_ctx->dx_dir_info == NULL)
+		return;
+
+	if (global_ctx->dx_dir_info == NULL) {
+		global_ctx->dx_dir_info = thread_ctx->dx_dir_info;
+		global_ctx->dx_dir_info_size = thread_ctx->dx_dir_info_size;
+		global_ctx->dx_dir_info_count = thread_ctx->dx_dir_info_count;
+		thread_ctx->dx_dir_info = NULL;
+		return;
+	}
+
+	e2fsck_merge_dx_dir(global_ctx, thread_ctx);
+}
+
 static inline errcode_t
 e2fsck_pass1_merge_icount(ext2_icount_t *dest_icount,
 			  ext2_icount_t *src_icount)
@@ -2386,6 +2402,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2_filsys global_fs = global_ctx->fs;
 	ext2fs_inode_bitmap inode_bad_map = global_ctx->inode_bad_map;
 	struct dir_info_db *dir_info = global_ctx->dir_info;
+	struct dx_dir_info *dx_dir_info = global_ctx->dx_dir_info;
 	ext2fs_inode_bitmap inode_used_map = global_ctx->inode_used_map;
 	ext2fs_inode_bitmap inode_dir_map = global_ctx->inode_dir_map;
 	ext2fs_inode_bitmap inode_bb_map = global_ctx->inode_bb_map;
@@ -2415,6 +2432,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	__u32 fs_fragmented = global_ctx->fs_fragmented;
 	__u32 fs_fragmented_dir = global_ctx->fs_fragmented_dir;
 	__u32 large_files = global_ctx->large_files;
+	ext2_ino_t dx_dir_info_size = global_ctx->dx_dir_info_size;
+	ext2_ino_t dx_dir_info_count = global_ctx->dx_dir_info_count;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf old_jmp;
@@ -2439,6 +2458,10 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->block_metadata_map = block_metadata_map;
 	global_ctx->dir_info = dir_info;
 	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
+	global_ctx->dx_dir_info = dx_dir_info;
+	global_ctx->dx_dir_info_count = dx_dir_info_count;
+	global_ctx->dx_dir_info_size = dx_dir_info_size;
+	e2fsck_pass1_merge_dx_dir(global_ctx, thread_ctx);
 	global_ctx->inode_count = inode_count;
 	global_ctx->inode_link_info = inode_link_info;
 	global_ctx->fs_directory_count += fs_directory_count;
-- 
2.37.3

