Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826871FF6D3
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbgFRP3o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731622AbgFRP3i (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:29:38 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3541EC0613EE
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:37 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h95so2829644pje.4
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xLtBnn8aN6zAhANEg1oSYr8w+MgeFKxhRm06i7K6rME=;
        b=OuizNkA9eDcAJGD3QPWRVNjGCb3vnq467EImPn5oReshFfoJacja8Jt2xbacQJ7ky6
         jxpgBOAJJly/MntYpl6SIoFURCpNqRQFl/foT1qIulf9iHJXLdu5kX2FDyy9vNHKEDAO
         0s3+5UDUxzCrSvuBsZdMHjsgjXyoZLpUxDPNBh/dfXvLMUDrWbZ3p9A/F8yJJKMjekTZ
         rNJNyS887dydOsde41jutPETRETe1on1g1t7Zmwq5ynVTQSykUxUEqJlivyXYkUtOEWN
         GMKfS8oVgj+5B2fAde3K8zuM7cAAEVrZa5PUvo+aooNlNH87Zk7My22mubbppdDBhJWw
         xDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xLtBnn8aN6zAhANEg1oSYr8w+MgeFKxhRm06i7K6rME=;
        b=uKBwwdF/awhgstwFEktq/uBFlBLReO1FDZbqJx5GS9aK+eXKWDMdTqHf377rZMKBGr
         S7nS1aOJwLRH0hDoXigpInktzXlsVE9kGVuCUPvSR92EfieqD38Yi2oWD7EOPzbpwgti
         Yh0sBb0treFat145tacqH6ReHWIpUjntPtBHEMfpWzUFMm0D6HbF2fBa7tua7AH4iQhw
         pZiBvwqy7yU6zt5Ln5xzW77DSprK8K98ISUOSVt9ZNiaRBdTWdKDdw2JqT8aZechhR2A
         zfZg8Ec5xJbnRKPB4nhcVp1nBPxAnyS8w08JFQYXTppxgczUf9+4U1JDu/uD0fnH+y21
         lr8w==
X-Gm-Message-State: AOAM533wWekkwKq8ipBJMeRVcRaie7UbSOAsXHEbkJAjAs8RyFWPbARp
        171RtoFD7NYWU6M3KI/pv4TG5l3lfCs=
X-Google-Smtp-Source: ABdhPJzb0u7CE1svhqSIKMYhPYFWbVWzdbWF0lENz78M/AwxkcIZGSzbCB7dQL+elEHGIqCIRDJ4Yg==
X-Received: by 2002:a17:902:aa4c:: with SMTP id c12mr4188758plr.280.1592494176427;
        Thu, 18 Jun 2020 08:29:36 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.29.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:29:35 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 35/51] e2fsck: split and merge invalid bitmaps
Date:   Fri, 19 Jun 2020 00:27:38 +0900
Message-Id: <1592494074-28991-36-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index f1bb1fc5..e8c0618b 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2508,6 +2508,65 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	return retval;
 }
 
+static void e2fsck_pass1_copy_invalid_bitmaps(e2fsck_t global_ctx,
+					      e2fsck_t thread_ctx)
+{
+	int i, j;
+	int grp_start = thread_ctx->thread_info.et_group_start;
+	int grp_end = thread_ctx->thread_info.et_group_end;
+	int total = grp_end - grp_start;
+
+	thread_ctx->invalid_inode_bitmap_flag = e2fsck_allocate_memory(global_ctx,
+				sizeof(int) * total, "invalid_inode_bitmap");
+	thread_ctx->invalid_block_bitmap_flag = e2fsck_allocate_memory(global_ctx,
+				sizeof(int) * total, "invalid_block_bitmap");
+	thread_ctx->invalid_inode_table_flag = e2fsck_allocate_memory(global_ctx,
+				sizeof(int) * total, "invalid_inode_table");
+	thread_ctx->invalid_bitmaps = 0;
+
+	for (i = grp_start, j = 0; i < grp_end; i++, j++) {
+		thread_ctx->invalid_block_bitmap_flag[j] =
+				global_ctx->invalid_block_bitmap_flag[i];
+		thread_ctx->invalid_inode_bitmap_flag[j] =
+				global_ctx->invalid_inode_bitmap_flag[i];
+		thread_ctx->invalid_inode_table_flag[j] =
+				global_ctx->invalid_inode_table_flag[i];
+		if (thread_ctx->invalid_block_bitmap_flag[j])
+			thread_ctx->invalid_bitmaps++;
+		if (thread_ctx->invalid_inode_bitmap_flag[j])
+			thread_ctx->invalid_bitmaps++;
+		if (thread_ctx->invalid_inode_table_flag[j])
+			thread_ctx->invalid_bitmaps++;
+
+	}
+}
+
+static void e2fsck_pass1_merge_invalid_bitmaps(e2fsck_t global_ctx,
+					       e2fsck_t thread_ctx)
+{
+	int i, j;
+	int grp_start = thread_ctx->thread_info.et_group_start;
+	int grp_end = thread_ctx->thread_info.et_group_end;
+
+	for (i = grp_start, j = 0; i < grp_end; i++, j++) {
+		global_ctx->invalid_block_bitmap_flag[i] =
+				thread_ctx->invalid_block_bitmap_flag[j];
+		global_ctx->invalid_inode_bitmap_flag[i] =
+				thread_ctx->invalid_inode_bitmap_flag[j];
+		global_ctx->invalid_inode_table_flag[i] =
+				thread_ctx->invalid_inode_table_flag[j];
+		if (thread_ctx->invalid_block_bitmap_flag[j])
+			global_ctx->invalid_bitmaps++;
+		if (thread_ctx->invalid_inode_bitmap_flag[j])
+			global_ctx->invalid_bitmaps++;
+		if (thread_ctx->invalid_inode_table_flag[j])
+			global_ctx->invalid_bitmaps++;
+	}
+	ext2fs_free_mem(&thread_ctx->invalid_block_bitmap_flag);
+	ext2fs_free_mem(&thread_ctx->invalid_inode_bitmap_flag);
+	ext2fs_free_mem(&thread_ctx->invalid_inode_table_flag);
+}
+
 static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx,
 					     e2fsck_t *thread_ctx,
 					     int thread_index,
@@ -2584,6 +2643,7 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx,
 		goto out_fs;
 	}
 	*thread_ctx = thread_context;
+	e2fsck_pass1_copy_invalid_bitmaps(global_ctx, thread_context);
 	return 0;
 out_fs:
 	ext2fs_free_mem(&thread_fs);
@@ -2724,6 +2784,10 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	int dx_dir_info_count = global_ctx->dx_dir_info_count;
 	ext2_u32_list dirs_to_hash = global_ctx->dirs_to_hash;
 	quota_ctx_t qctx = global_ctx->qctx;
+	int *invalid_block_bitmap_flag = global_ctx->invalid_block_bitmap_flag;
+	int *invalid_inode_bitmap_flag = global_ctx->invalid_inode_bitmap_flag;
+	int *invalid_inode_table_flag  = global_ctx->invalid_inode_table_flag;
+	int invalid_bitmaps = global_ctx->invalid_bitmaps;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
@@ -2795,6 +2859,11 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	}
 	global_ctx->qctx = qctx;
 	e2fsck_pass1_merge_quota_ctx(global_ctx, thread_ctx);
+	global_ctx->invalid_block_bitmap_flag = invalid_block_bitmap_flag;
+	global_ctx->invalid_inode_bitmap_flag = invalid_inode_bitmap_flag;
+	global_ctx->invalid_inode_table_flag = invalid_inode_table_flag;
+	global_ctx->invalid_bitmaps = invalid_bitmaps;
+	e2fsck_pass1_merge_invalid_bitmaps(global_ctx, thread_ctx);
 
 	/*
 	 * PASS1_COPY_CTX_BITMAP might return directly from this function,
@@ -2846,6 +2915,8 @@ static int e2fsck_pass1_threads_join(struct e2fsck_thread_info *infos,
 	int				 i;
 	struct e2fsck_thread_info	*pinfo;
 
+	/* merge invalid bitmaps will recalculate it */
+	global_ctx->invalid_bitmaps = 0;
 	for (i = 0; i < num_threads; i++) {
 		pinfo = &infos[i];
 
-- 
2.25.4

