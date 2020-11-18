Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E2A2B80FD
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgKRPlg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbgKRPlf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:35 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDB8C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:35 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z29so2885179ybi.23
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6e3QHpxWYS5pREffVmkDbMng1wHtMagVt6U7jho/w5M=;
        b=AjQEOCJVRTZHcPDd3WEh0lncuncx1Mngl6692ZuxuZzC2FIocCQnbvVasczjQ9y5P4
         BMyJbitPUuKWv6Eekzu6+qJhjmPW0u59qrjlRw1OW9rN2vwlcNX4QWcYw+oT2oLF6RDD
         6obH1sgpnB/Fa7mzQTbbc5CwTOdsCFDXp0cjg86J4nCb38meiT/0QN4rKVeyWcGwA0fg
         LES7c1wNP3+T34p7OfbeJmL59Z/FL0dou+o+T5o7AB8cwECrf5RMdBtmoHBVxuUzoQDv
         BCZ1u0vVql9BN4TqxWtNQSwfBR3e/9r9mKeNwboFsQD7mMDP7aSJ0Hj7dDR83EFJmgCl
         k4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6e3QHpxWYS5pREffVmkDbMng1wHtMagVt6U7jho/w5M=;
        b=pI6e85AvMMM5ONYOkpiv/iDD46g7vRDWbzS+/cScB4MZIYhlGubY7IBqevZzjau03M
         nU2UvG3Vd/g5WK3wDCJATOSYEHoRPdQBgmkAxcFucKY3HhKrwNVqqLsDPKCEXZKD2qYZ
         tbE4Yhad5To39VXdmd7GyXxerqsGoGBkDZ8aXNvQNCvY62aFJ5ttyfWaM8P6gTh/eOc1
         lmmUJvYtdTMZNl9/QWLJRQqy6y55TgOHiVUmR8LZCtffAo1qq7NfkEKGaNKf5j2BYzDg
         6MqmWSZwNYoenor1ajcxSxp6Lp3rSVbkDp0DBiRNwr6mTwlka4dWCCQZKFC9UhUgi3UL
         P4VQ==
X-Gm-Message-State: AOAM533TMaP9MOa2bLJ4muQfkdz4ky3aGIwd0VIoG7KCVbwLKtK57p6w
        zvH/0cYx23yv18seE/wnitn9Exup6fMIsjL0nl8miRw6zh4td+E1raZ7HJS1dpYZ/PxSt0b1aap
        D49/VVIh02pDm89hvMezsMvXj8OiAlCoIsUq4ziNkIjTrr41a6EmUPZ3zTk/jAlYKtTuBMBk0jV
        TtsBEeg/0=
X-Google-Smtp-Source: ABdhPJxXlzvqgP8nctltuybtGM4MQuKY1GNhWxB9jLm1vEiyypvEzxRAzkhiGiwANGboaS/7j12J/k/o+K2Te68Sdrw=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a25:7e42:: with SMTP id
 z63mr8602623ybc.63.1605714094707; Wed, 18 Nov 2020 07:41:34 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:23 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-38-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 37/61] e2fsck: merge options after threads finish
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

It will be possible that threads might append E2F_OPT_YES,
so we need merge options to global, test f_yesall cover this.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index ad3bd8be..1a68a2fb 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2935,6 +2935,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2_refcount_t ea_inode_refs = global_ctx->ea_inode_refs;
 	ext2fs_block_bitmap  block_found_map = global_ctx->block_found_map;
 	ext2fs_block_bitmap  block_dup_map = global_ctx->block_dup_map;
+	int options = global_ctx->options;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
@@ -2987,7 +2988,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->fs_fragmented += fs_fragmented;
 	global_ctx->fs_fragmented_dir += fs_fragmented_dir;
 	global_ctx->large_files += large_files;
-
+	/* threads might enable E2F_OPT_YES */
+	global_ctx->options |= options;
 	global_ctx->flags |= flags;
 
 	retval = e2fsck_pass1_merge_fs(global_fs, thread_fs);
@@ -3022,10 +3024,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 					      thread_ctx->qctx);
 	if (retval)
 		return retval;
-	global_ctx->invalid_block_bitmap_flag = invalid_block_bitmap_flag;
-	global_ctx->invalid_inode_bitmap_flag = invalid_inode_bitmap_flag;
-	global_ctx->invalid_inode_table_flag = invalid_inode_table_flag;
-	global_ctx->invalid_bitmaps = invalid_bitmaps;
+
 	e2fsck_pass1_merge_invalid_bitmaps(global_ctx, thread_ctx);
 
 	retval = e2fsck_pass1_merge_bitmap(global_fs,
-- 
2.29.2.299.gdc1121823c-goog

