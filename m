Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8900361F310
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiKGM0W (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbiKGM0R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:26:17 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324E063C2
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:26:17 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id c2so10887392plz.11
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TO3EAnoyooTXPluco+EV2CzZby3gnXHpq0yhCfmKuV0=;
        b=ppGOdpzF9PUS/kWQEid5qsV8N6gFSbQr0lT208UCSAbJeRXFxXXiJ/uej5nyFvWiQ6
         iZTGrDTxJhMq1HO+sF+fFv62ExMZPL29MO7vCw7rjEe3aCTSwucbHcQBkh/IPS54Lwf+
         j6BIpsz3AzH7OWBgfCr1zElfduP7YRWt0vncBsOHw+uw7dC8OtUq4mcvWvRz900buY2b
         Gxkj0ndO6es9xZmiQ89qwGGGJ9O2V7MlZnT2AxIR1zGqmhn5TO8Pt+512gybS9X/2Qqk
         tF6JRYYCTMvtLJ+QyaC/k6L7ScLAsCh9mzuBcsvzy97OaliOy+jJAjpCzE2+uCOYphtb
         nj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TO3EAnoyooTXPluco+EV2CzZby3gnXHpq0yhCfmKuV0=;
        b=D7+29AVVySo+WnosjzQdzY0X5TvD93U5etLxiRWpWWJpP9XfWQ6aNtCF50XCkOunV7
         IuA0430GiAibBb52DEH0oM2pq5GlY5qx4Q7YzApR7LrUGEKpHojFhBUM4rp81WAOPWpI
         2mvaYuRK+fZmkXxLbP8OD17PBd+4hRtjofBB91DmbvqLHpI6MlKTenfGPER/eaoH6GO4
         yQ8PWclXroJt8XYgLReA9bz0ncOQKoQVGo6Kz0NT7M4dYOBYIGx2yX6m8FSuBe0Zp7k0
         I9Zfto/pkVDKShYr3SnsYASMnXIcLcti2OljoYEiArxsjWaqd08RWhKnC00SNY6OqLxR
         eTWw==
X-Gm-Message-State: ACrzQf2/ERbavCDfs/sfASAi7SBMQ2ojHVw1bYvDAgxB/2YmoXD11BhN
        xXoh578S78Rgs42eGwYnEO0=
X-Google-Smtp-Source: AMsMyM7hAPPxEy9zSFaMI+1sxuomge6Cwkh4qmBHv+jj2oAlb7feQvXL8JrePJmlyBnkXZOAblNMPA==
X-Received: by 2002:a17:902:e88d:b0:186:f9d4:3fc5 with SMTP id w13-20020a170902e88d00b00186f9d43fc5mr50765294plg.116.1667823976645;
        Mon, 07 Nov 2022 04:26:16 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902c10400b00186c3af9644sm4816035pli.273.2022.11.07.04.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:26:16 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 38/72] e2fsck: merge counts after threads finish
Date:   Mon,  7 Nov 2022 17:51:26 +0530
Message-Id: <aa2ad3b7525a212b09e125d0a31fefd980cdb444.1667822611.git.ritesh.list@gmail.com>
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

Merge counts properly.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 752dca03..8b502307 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2398,6 +2398,23 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
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
 	jmp_buf old_jmp;
@@ -2424,6 +2441,23 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
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
2.37.3

