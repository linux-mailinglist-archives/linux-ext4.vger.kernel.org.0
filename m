Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFD41A1F0C
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgDHKqr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:47 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51876 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgDHKqr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:47 -0400
Received: by mail-pj1-f68.google.com with SMTP id n4so1004907pjp.1
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fYXRiYU0Sfgy3GFZs2RGKrN+nTDw2FLVJUWDpghCSrU=;
        b=ADuNUHw4YYBzaCXzD78rYz6iihmLTs6csowzTHfu4PxzVLuQsII4EhV0dquz9a3bU7
         PMRNXRNheoB0aX8D/gvLy9zykSAsaHyEw0ZwoCTToqjbvRK1nIy3pX5xVeKavciMGOLS
         VoOC+qc2L08T9ctfDZ7rUI9nFIx0sBwdXSqfca8gkHMdya0nSigz/ucZDs6myh2Qapmu
         0RxKBI5wf1gHky83bsrs4Hmvjn1r+nP98CXk8ICJCPYXBQnEFWiNyV9q2sP5BaoAUiea
         He3OSTKOU5MBjE6uRZYvSJGf3Fgpaw5N6rmi4NbiCkDAPLhsJyfglykpF1yIUEPlOwqo
         S99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fYXRiYU0Sfgy3GFZs2RGKrN+nTDw2FLVJUWDpghCSrU=;
        b=C81qW014/81jQgu8Yp1J+T9/0sJJBALVgPBXrJFJqxDyQaZVYLk3eGUuZwsv4K5ndR
         4V3hvk6J73kTHERZDTCqFEhFUoIkOVdhKJoWQDjphoAEZGrAgUi2rRRmydgycJ6xNfpV
         6dUQVfofproDKtd1GU+7byuScY6Ckvu7gcjb7THcPIZuFKOhUih+/aOycr+LoNMnH6ds
         Sa6iRQ3emXQF9nrTZ33FDWutGZPkyMcEP//PhtM8goDRpL/+RSgx9QlGAVMn2TkkMnsu
         7hHAyOfDODsvvDJW4+WjXNaBDqrHCpsfbpdAZSJSasYGUsFSis5K/u8XXRdzwlOkyRcD
         6ecQ==
X-Gm-Message-State: AGi0PubDL68XZ1e3zj4G7KEwgJWv33+y6D7BdlbIKs02dr4hDUTE2ORF
        6yM3btBDN7F0Dgbc53hI42anRbQcopU=
X-Google-Smtp-Source: APiQypJ7kLm8DrqxgRyPXYO1G0HTf7vjzQhpWDcuWnVPBoF5U2GXwD/OlPl1a41zk+UkdTj235NoXA==
X-Received: by 2002:a17:90a:2751:: with SMTP id o75mr1393318pje.26.1586342805529;
        Wed, 08 Apr 2020 03:46:45 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:45 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 34/46] e2fsck: split and merge invalid bitmaps
Date:   Wed,  8 Apr 2020 19:45:02 +0900
Message-Id: <1586342714-12536-35-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
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
index 793a2944..348cf46b 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2523,6 +2523,65 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
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
@@ -2599,6 +2658,7 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx,
 		goto out_fs;
 	}
 	*thread_ctx = thread_context;
+	e2fsck_pass1_copy_invalid_bitmaps(global_ctx, thread_context);
 	return 0;
 out_fs:
 	ext2fs_free_mem(&thread_fs);
@@ -2739,6 +2799,10 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	int dx_dir_info_count = global_ctx->dx_dir_info_count;
 	ext2_u32_list dirs_to_hash = global_ctx->dirs_to_hash;
 	quota_ctx_t qctx = global_ctx->qctx;
+	int *invalid_block_bitmap_flag = global_ctx->invalid_block_bitmap_flag;
+	int *invalid_inode_bitmap_flag = global_ctx->invalid_inode_bitmap_flag;
+	int *invalid_inode_table_flag  = global_ctx->invalid_inode_table_flag;
+	int invalid_bitmaps = global_ctx->invalid_bitmaps;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
@@ -2809,6 +2873,11 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
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
@@ -2859,6 +2928,8 @@ static int e2fsck_pass1_threads_join(struct e2fsck_thread_info *infos,
 	int				 i;
 	struct e2fsck_thread_info	*pinfo;
 
+	/* merge invalid bitmaps will recalculate it */
+	global_ctx->invalid_bitmaps = 0;
 	for (i = 0; i < num_threads; i++) {
 		pinfo = &infos[i];
 
-- 
2.25.2

