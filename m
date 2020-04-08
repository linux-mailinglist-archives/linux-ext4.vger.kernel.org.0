Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E667D1A1F03
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgDHKq1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43597 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgDHKq1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id s4so3135692pgk.10
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mzk7fcdLkWxvQN5L82i/kFI5nSfFfxWIleCKv+NfelE=;
        b=Yg4sC1+1HDKuSVUqGp0INEW1RcEOtvkWWxi3LDQWlyOdracKDK7kHQx9YXQD07I/BN
         kQZKilMUGhzNoAUrZXdP7i48UyqgdTfIovKCneoeadwdBnKOszj3HaoP/epeYm4dl8QQ
         /0Q4HRWaLt8CActziYbrmx8x018R0zi74S6AD+kKd6Iq3MNW4qhIbVS96mk4ybP0BSPm
         3u5Ecuk9Jug+qZZjQvbN0Aeiu6xdP8FjypH1+PHbtzHSfPHtGzD8IUfWln7rugVVKX/k
         tSrXTks0rfwog/vgzDEqoB5p5p5/tX/1ycINx5xo00JSvmK3vdzrEjQCAXRp6zN94Xsy
         a2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mzk7fcdLkWxvQN5L82i/kFI5nSfFfxWIleCKv+NfelE=;
        b=OCNYmppWVEUNpTc0F6/Sz81oWgTj/+HG4fm8POgrevzKsW/033FXjQWD/3HX3pT9RI
         pl7ZvkenpKPWdzs6DCIOmHJ16f9vROM2aZn3hign5VZu4bRRoAI59g+yMYnVnYIST+0b
         lhDdHyPhis2fkJ1Adxy4SmT0KhybE6bJhP9Ha5fZYLDPr/0AVfaQy/p8Ir9lY0oY3wSc
         AqiqXfJ02p8jlBB0lh3vTybKY7W/+YdvG9pSkW56DpvFB0w5cPz/Lv+W+BiF05Gg2mRa
         89lXS2ok9XDe8+CILI9v+SOhwexyEwOpOlA/wTSXwKitngSoHbAgBXw+4+Y4633y54Gh
         Lsyw==
X-Gm-Message-State: AGi0PuYPPD4uAO2wTG/bX5upraoECtKaB92bBf1LtHygrE8XnJxDI2YR
        fCNg2uVf8wApiJJ1f0hC1P7gfDBefoA=
X-Google-Smtp-Source: APiQypJz3JxNmbG+fMKrI6JK9XoJBCPlnRTesa8DZQHkwK9YnG3V+9v8HrZX/sVt6apMYTZTQyzlaw==
X-Received: by 2002:a62:b603:: with SMTP id j3mr5806474pff.208.1586342786403;
        Wed, 08 Apr 2020 03:46:26 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:25 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 25/46] e2fsck: merge counts when threads finish
Date:   Wed,  8 Apr 2020 19:44:53 +0900
Message-Id: <1586342714-12536-26-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
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
index f8115679..78924b24 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2171,6 +2171,11 @@ do {									\
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
@@ -2505,6 +2510,23 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
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
@@ -2530,6 +2552,23 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
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
2.25.2

