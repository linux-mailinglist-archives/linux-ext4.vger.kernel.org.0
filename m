Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19352B80F7
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgKRPmP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbgKRPmM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:42:12 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62154C061A4F
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:42:12 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id s9so1792982qks.2
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=xqJECZo2t3fJB3YHNQYOAUld5JMQjuX171FUJYJ+DMo=;
        b=u56RXdluMCYxxTxIm0SWim18/dHxvpzr7+owNoUNaFbQX0EWwaZ6f3LcNIIUl2R9hh
         +woFwOQ/1AEgZ8kJAxW7L7Q5XgCxjQarqgRYl+Q0yAkL62gb4OHYiMEXYckkUKs5Al/7
         fqySKEJQpYu0gXHUrmzPzMDSnYLcacGkmI+54Q/jhqTV1Gj1Pcomzk+b3GcYWSSCJtib
         dt88jzeblcom2ySI3GQa92Lp1TMnL+CAk+G9FKT+e8BtWWXiVSM1HoIvEfZ5j+0B5itB
         YiNugygV+wCfE0VBLZBc/4/6TjardKxcno3JiyRgl1OyL5RAN8uZved1J0rWdgmuGILv
         B5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xqJECZo2t3fJB3YHNQYOAUld5JMQjuX171FUJYJ+DMo=;
        b=kj/Hnkj92FPEF3SR45dOcfhC6IgVkj/BjTa3/GHLIfAgv8yWTusLMsvd7n+VWnn3d8
         FTDPdzklCG9SmHeO1Ow+75IWTf2dDHlbyxAN/qs79rww/nfm8HSePVH1suGSUVmAzymY
         3wCUy4scnLoEbVSvGSZ4UOidemPfkr9ZNZLEs3JS8U2cIDn0qiSK20rNqpZb3TWm8jib
         AALQsBHJYxx+8SfNshCBAGLPgaWm/DoSilb7ffcyaTxUbn2keVsabofI37nKZUS4tTgE
         AS4DidmWRf5M7l/AKyCta5/UXX6/uhOAr0SmOkjToAq6P3WcFdoy/WbpzEIjUokBF707
         an0A==
X-Gm-Message-State: AOAM533pfgw27otdwCbcgLdkUTRz4JdC3FM6EfVKYLvcveyTieVNgYln
        yyQS2RdcbrGdvLA5un+sKvETkALg/Pp5ms6gWuCpqBVO1ogJU8B17ZENI2s9AZjqrTotQByje7T
        r9vf+zx4SWo5D7GhikRkydJ/yMRxhUyPV7lZTdCoCJh4Cg5wCs9AySxvCcIJVL8IbBBqJs0uMMu
        LWWi1ueD8=
X-Google-Smtp-Source: ABdhPJxGcIc9VsDStZ3RNk6PEb8E4NFurxuLRb5CrpreRC9ugsE7U4OMD9Qc+XyTJv8otqUuljTDcCpJxkPM5q0Nc3w=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a0c:b351:: with SMTP id
 a17mr5406992qvf.7.1605714131404; Wed, 18 Nov 2020 07:42:11 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:42 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-57-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 56/61] e2fsck: fix memory leaks with pfsck enabled
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

valgrind detected few memory leaks:

1) quota context is not released after merging.
2) three block bufs are not freed in read_bitmaps_range_start()
3) @refcount_orig should be released

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/e2fsck.c         |  4 ++++
 e2fsck/pass1.c          |  1 +
 lib/ext2fs/rw_bitmaps.c | 14 ++++----------
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/e2fsck/e2fsck.c b/e2fsck/e2fsck.c
index a03550c0..e406f6dd 100644
--- a/e2fsck/e2fsck.c
+++ b/e2fsck/e2fsck.c
@@ -102,6 +102,10 @@ errcode_t e2fsck_reset_context(e2fsck_t ctx)
 		ea_refcount_free(ctx->refcount_extra);
 		ctx->refcount_extra = 0;
 	}
+	if (ctx->refcount_orig) {
+		ea_refcount_free(ctx->refcount_orig);
+		ctx->refcount_orig = 0;
+	}
 	if (ctx->ea_block_quota_blocks) {
 		ea_refcount_free(ctx->ea_block_quota_blocks);
 		ctx->ea_block_quota_blocks = 0;
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 70826866..7768119b 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -3113,6 +3113,7 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 		fclose(thread_ctx->problem_logf);
 	}
 
+	quota_release_context(&thread_ctx->qctx);
 	/*
 	 * @block_metadata_map and @block_dup_map are
 	 * shared, so we don't free them.
diff --git a/lib/ext2fs/rw_bitmaps.c b/lib/ext2fs/rw_bitmaps.c
index eb791202..5fde2632 100644
--- a/lib/ext2fs/rw_bitmaps.c
+++ b/lib/ext2fs/rw_bitmaps.c
@@ -269,7 +269,7 @@ static errcode_t read_bitmaps_range_start(ext2_filsys fs, int do_inode, int do_b
 	dgrp_t i;
 	char *block_bitmap = 0, *inode_bitmap = 0;
 	char *buf;
-	errcode_t retval;
+	errcode_t retval = 0;
 	int block_nbytes = EXT2_CLUSTERS_PER_GROUP(fs->super) / 8;
 	int inode_nbytes = EXT2_INODES_PER_GROUP(fs->super) / 8;
 	int tail_flags = 0;
@@ -432,18 +432,12 @@ static errcode_t read_bitmaps_range_start(ext2_filsys fs, int do_inode, int do_b
 
 success_cleanup:
 	if (start == 0 && end == fs->group_desc_count - 1) {
-		if (inode_bitmap) {
-			ext2fs_free_mem(&inode_bitmap);
+		if (inode_bitmap)
 			fs->flags &= ~EXT2_FLAG_IBITMAP_TAIL_PROBLEM;
-		}
-		if (block_bitmap) {
-			ext2fs_free_mem(&block_bitmap);
+		if (block_bitmap)
 			fs->flags &= ~EXT2_FLAG_BBITMAP_TAIL_PROBLEM;
-		}
 	}
 	fs->flags |= tail_flags;
-	return 0;
-
 cleanup:
 	if (inode_bitmap)
 		ext2fs_free_mem(&inode_bitmap);
@@ -451,8 +445,8 @@ cleanup:
 		ext2fs_free_mem(&block_bitmap);
 	if (buf)
 		ext2fs_free_mem(&buf);
-	return retval;
 
+	return retval;
 }
 
 static errcode_t read_bitmaps_range_end(ext2_filsys fs, int do_inode, int do_block,
-- 
2.29.2.299.gdc1121823c-goog

