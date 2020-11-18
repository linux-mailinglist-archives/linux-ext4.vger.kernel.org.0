Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C3C2B80D8
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgKRPlK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgKRPlJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:09 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED3AC0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:09 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a6so2980610ybi.0
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=BHD4ufBZiGRPhS9uyriqVz/N2Lvd/jndSOp/RLCo5Iw=;
        b=e6LwVKmqX025tcC83tKwsqfdtxt3RDgL4T7ZijVhv4FxXXilAhouESkd98qxu6FEY4
         iaIJcTmCUVkCZzB2T3S9pKh0Lfg1ZzjF4C6VpPWIbqkFZj9zOYkHEh9G3MZ/7yOLErJh
         cXlW3vYHXAMJxRpVSnxuI23gX8FyD8vQg6Keqhb0OulK2EIhqHFH7vAxZqG6/b+8uq6V
         hGAZ9SAbqq9x5W6I2LohgzvIRKwujGpY1m6n3nNcrnO/VzAasvsLKD/Wur82B9g+kXFU
         pWYnfLtIunREn9WhSuLpIxlM9jqXzTsDPK5XwZMtJ70ppqsDmYyuVjFJpW8ILeIewtFL
         ZBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BHD4ufBZiGRPhS9uyriqVz/N2Lvd/jndSOp/RLCo5Iw=;
        b=fKy+8QRCdSVVdztarUvRHc9padB0IIAnQ1xQQgpvQlbClhBaJAPEiZARp5M0eK2TIH
         GJ+yxVuq7SRZr2g03McCQcIXNUTFeQdzspEWatb5F/RAw4cH/gw1Pn9LpP9xoP8jGHk7
         +2K4y6cph4Kuoof/88T6BQvaFTe7CjCLxRT5mBYSmaRuzE/a27usIyBsDIYmOyvILSjF
         lxXGD6PGCsw0UdiP5A0N+Ov6GDFiHZorRvPyY/sAx7LKllCA7NErjsNp9NBtJMU4kvSs
         0y21yOWaE1LHuAwkBkq0BV8apDm820OdVefemNgYgCPJypXqkwUodUCJBuo97SvQLKgj
         RzYQ==
X-Gm-Message-State: AOAM531q5wf2+5ViH69Kte3bP/9hG3YTTIV8gPU03ZjMe/EEVm+dLN18
        hGd1t32dWwVeOgh7Z0mfMUCJQGRIGaoe0HkZZW8NTW7oYjx3qV61wVIjh6/3bQwLOmwLbF+Ptbv
        M3j6AIZU8IbMNASelj7x8BEMRm92+GEBawr1K5kAhW/sQxAGz8tF1ZUrNW/NdEPiw8vFWJbNejl
        4XYV0bo4Q=
X-Google-Smtp-Source: ABdhPJwrJThAwej1Tg0YqVnC577TNtiAaAuMR9GGA50r8dSE6f6d/YSyHVvvpuOidK/p4j2DdKtDZldCFMDjNmrs+Uc=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a25:c7c6:: with SMTP id
 w189mr6109606ybe.403.1605714068605; Wed, 18 Nov 2020 07:41:08 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:09 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-24-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 23/61] e2fsck: merge counts after threads finish
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

Merge counts properly.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index f36b3e70..af0ff724 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2464,6 +2464,23 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2fs_block_bitmap inodes_to_rebuild = global_ctx->inodes_to_rebuild;
 	ext2_icount_t inode_count = global_ctx->inode_count;
 	ext2_icount_t inode_link_info = global_ctx->inode_link_info;
+	__u32 fs_directory_count = global_ctx->fs_directory_count;
+	__u32 fs_regular_count = global_ctx->fs_regular_count;
+	__u32 fs_blockdev_count = global_ctx->fs_blockdev_count;
+	__u32 fs_chardev_count = global_ctx->fs_chardev_count;
+	__u32 fs_links_count = global_ctx->fs_links_count;
+	__u32 fs_symlinks_count = global_ctx->fs_symlinks_count;
+	__u32 fs_fast_symlinks_count = global_ctx->fs_fast_symlinks_count;
+	__u32 fs_fifo_count = global_ctx->fs_fifo_count;
+	__u32 fs_total_count = global_ctx->fs_total_count;
+	__u32 fs_badblocks_count = global_ctx->fs_badblocks_count;
+	__u32 fs_sockets_count = global_ctx->fs_sockets_count;
+	__u32 fs_ind_count = global_ctx->fs_ind_count;
+	__u32 fs_dind_count = global_ctx->fs_dind_count;
+	__u32 fs_tind_count = global_ctx->fs_tind_count;
+	__u32 fs_fragmented = global_ctx->fs_fragmented;
+	__u32 fs_fragmented_dir = global_ctx->fs_fragmented_dir;
+	__u32 large_files = global_ctx->large_files;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
@@ -2490,6 +2507,23 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
 	global_ctx->inode_count = inode_count;
 	global_ctx->inode_link_info = inode_link_info;
+	global_ctx->fs_directory_count += fs_directory_count;
+	global_ctx->fs_regular_count += fs_regular_count;
+	global_ctx->fs_blockdev_count += fs_blockdev_count;
+	global_ctx->fs_chardev_count += fs_chardev_count;
+	global_ctx->fs_links_count += fs_links_count;
+	global_ctx->fs_symlinks_count += fs_symlinks_count;
+	global_ctx->fs_fast_symlinks_count += fs_fast_symlinks_count;
+	global_ctx->fs_fifo_count += fs_fifo_count;
+	global_ctx->fs_total_count += fs_total_count;
+	global_ctx->fs_badblocks_count += fs_badblocks_count;
+	global_ctx->fs_sockets_count += fs_sockets_count;
+	global_ctx->fs_ind_count += fs_ind_count;
+	global_ctx->fs_dind_count += fs_dind_count;
+	global_ctx->fs_tind_count += fs_tind_count;
+	global_ctx->fs_fragmented += fs_fragmented;
+	global_ctx->fs_fragmented_dir += fs_fragmented_dir;
+	global_ctx->large_files += large_files;
 
 	/* Keep the global singal flags*/
 	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
-- 
2.29.2.299.gdc1121823c-goog

