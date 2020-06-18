Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE3D1FF6BE
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbgFRP3R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731548AbgFRP3P (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:29:15 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89838C06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:15 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id m2so2832639pjv.2
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7vfxws6JstlW6T2A3UOHoayVm5HHttjMM9F8VZPtQ+4=;
        b=g5hnMWo9yJzm7UcuZ6K1nzqcN02QOqj2PDqkvm6+IcmWdJ5zg8mhGzicxpeNBAd8OX
         OcUNBOLhwoXiDxz/Kk4RP+WBYdQ5tNX6+A6gJHRcS+WlutRDBD1RnTkePM41YmA5/oUV
         ch2lcg4yk2yloIPcyAlt79KO7d/3uuuwDy7ejRPkU0JRoINMqMD1a+9k/Z8ZutIn8t7R
         PtLNBrpTamLNaUJ5g5jrWTsFhdWRzOBouXaLug+XL+SdDGyedgxLiAPsRXPTdvKzN0VO
         1HQN4d1KMvjU0Nm718J8lKk1Zo3iLTv8aJeysdYwgwfx/QvpVXqwq9DheAra0gunLwdG
         v9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7vfxws6JstlW6T2A3UOHoayVm5HHttjMM9F8VZPtQ+4=;
        b=Tl9oFQA0ozfTmjl1vqQ8d39wTnpH4UQw2gzG2SuZEFnxLMjBX727rcMOzlS6BdN4q9
         +SieviKZcI3bI8xAQ9ddaCaLKzbrtB4+nE59IREFjLsW3458crAxSWBWTl+G8JVuxj6b
         pgl6Yyjn97Q8bW+sMaFTqpniHN5rWvbYj9cNIsCfeUslCkQdwWXM2wEXZtWJHlJcDEz7
         Bt9bePBEu2nzg+XC1/QpP5zuzAeLcpe7Ym3ImZsp5PMAzOnAQcA/ADYnjeTOjyTsi6Yh
         egrScaXNrWg7fnMqAooz891rbdmng8+Nq0j4syLiVuvzk3Bo9b1T3et2FfaRgDJqvDoY
         gRVQ==
X-Gm-Message-State: AOAM530ry23PP0B4mUikZ1/mY76KEwwymqTjvUUDapYJWgAqQ1wB80rz
        I4KeNh9+h9vQ3/a6w4FQOrtCx8V1xEU=
X-Google-Smtp-Source: ABdhPJxlaJyvhaDoxVnEdCY9Vz3XfPCrVJEuCJX/gnPn5GcGjYm7X+RsoSjle9yX69Bd5MFkD5X4Sw==
X-Received: by 2002:a17:902:8204:: with SMTP id x4mr4075166pln.153.1592494154803;
        Thu, 18 Jun 2020 08:29:14 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.29.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:29:14 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 26/51] e2fsck: merge counts when threads finish
Date:   Fri, 19 Jun 2020 00:27:29 +0900
Message-Id: <1592494074-28991-27-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index d2f4ba79..efab125d 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2153,6 +2153,11 @@ do {									\
     }									\
 } while (0)
 
+#define PASS1_MERGE_CTX_COUNT(_dest, _src, _field)			\
+do {									\
+    _dest->_field = _field + _src->_field;				\
+} while (0)
+
 static errcode_t pass1_open_io_channel(ext2_filsys fs,
 				       const char *io_options,
 				       io_manager manager, int flags)
@@ -2487,6 +2492,23 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2fs_block_bitmap inodes_to_rebuild = global_ctx->inodes_to_rebuild;
 	ext2_icount_t inode_count = global_ctx->inode_count;
 	ext2_icount_t inode_link_info = global_ctx->inode_link_info;
+	__u32	fs_directory_count = global_ctx->fs_directory_count;
+	__u32	fs_regular_count = global_ctx->fs_regular_count;
+	__u32	fs_blockdev_count = global_ctx->fs_blockdev_count;
+	__u32	fs_chardev_count = global_ctx->fs_chardev_count;
+	__u32	fs_links_count = global_ctx->fs_links_count;
+	__u32	fs_symlinks_count = global_ctx->fs_symlinks_count;
+	__u32	fs_fast_symlinks_count = global_ctx->fs_fast_symlinks_count;
+	__u32	fs_fifo_count = global_ctx->fs_fifo_count;
+	__u32	fs_total_count = global_ctx->fs_total_count;
+	__u32	fs_badblocks_count = global_ctx->fs_badblocks_count;
+	__u32	fs_sockets_count = global_ctx->fs_sockets_count;
+	__u32	fs_ind_count = global_ctx->fs_ind_count;
+	__u32	fs_dind_count = global_ctx->fs_dind_count;
+	__u32	fs_tind_count = global_ctx->fs_tind_count;
+	__u32	fs_fragmented = global_ctx->fs_fragmented;
+	__u32	fs_fragmented_dir = global_ctx->fs_fragmented_dir;
+	__u32	large_files = global_ctx->large_files;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
@@ -2512,6 +2534,23 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
 	global_ctx->inode_count = inode_count;
 	global_ctx->inode_link_info = inode_link_info;
+	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_directory_count);
+	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_regular_count);
+	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_blockdev_count);
+	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_chardev_count);
+	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_links_count);
+	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_symlinks_count);
+	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_fast_symlinks_count);
+	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_fifo_count);
+	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_total_count);
+	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_badblocks_count);
+	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_sockets_count);
+	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_ind_count);
+	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_dind_count);
+	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_tind_count);
+	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_fragmented);
+	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_fragmented_dir);
+	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, large_files);
 
 	/* Keep the global singal flags*/
 	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
-- 
2.25.4

