Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA821FF6E5
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbgFRPaZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731678AbgFRPaJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:30:09 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4634AC0613F0
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:30:09 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x22so2951692pfn.3
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R5qkqQliF/IpE5txuH8o0nKwqd2J3n0F5FjhcxM1URc=;
        b=n2Qd55DWeZMoFy471Jswd77fjDcUicbL+ka6p1DyXhdGTCNzoPoG++mpvWm0tSyyg4
         nrQtLWTEHNNXHi56ZZzuruig9wC5iyqH8WO+oksN+ZoSemIFhshame3V8mYSxqCUqrtX
         pp3fdrib7UY4wo5h4IlNKJkK137XDtvKN/GER0M4s3NBoOO7Tdvq7fftHKCxiAeajCgC
         bANzPa/fHB4q8dQNV0EVzo9iYaF4Qwigo8jW9+/ibTwt26LeRgRJgUpETXmx9ob0R7En
         Dawd5iluhsL4nuQSax13J3mT2xsUYPQgujFn4KUlVglcQyo85UY0OdkDjYc6IFRscQHS
         kdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R5qkqQliF/IpE5txuH8o0nKwqd2J3n0F5FjhcxM1URc=;
        b=SBPm9xjHIMASaPV3YysAp7J1zygIUQ+NGECKuG0JSAyGBcDwQAnEWCjLO8yKyWIHh0
         WzZFEAsz1nO1d+AZzF3H2DrHTf4anGQwQor/ZkhlLyItGoqZRn6xapAf4CXgSNqszqvc
         8XgFc7ipug+ANrqIZTRbNKPCGtiIaTyKeL1b50M2UL+Zx/VDN7aojRIGMerRF9jW913i
         HL3230s+UMeZ96uwk4S5hPOleVLauO+CujrGjwvxl+1eTEX3luHIcBPaW23QyR/4ayxj
         JIsCpW9MVBv6vSxuG/3lw80I/12Awrm4tSQJxnKOH9BpstiwyqZ0U5ie+4riAqkWkbse
         kTig==
X-Gm-Message-State: AOAM532jSfh/IlArklYSmEE+JSYh8NP0xZdyX+5S6Ua/m1MyLDthcgnj
        SFzPbM4RvA3N9CYxHnwff9p8ME2FJec=
X-Google-Smtp-Source: ABdhPJxQypOJWNdilrADpYbOdWBmZ6Z6luGtvVF/d+Ow74pepcBJu0vG/WzbZ6JVn4xsDtyDUq0o9Q==
X-Received: by 2002:a63:5015:: with SMTP id e21mr3762642pgb.54.1592494208257;
        Thu, 18 Jun 2020 08:30:08 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.30.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:30:07 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 48/51] e2fsck: only setup threads if -m option required
Date:   Fri, 19 Jun 2020 00:27:51 +0900
Message-Id: <1592494074-28991-49-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

For smaller fs(less than TiB filesystem), it doesn't
make sense to setup threads, and default behavior will
be kept as single threads.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 60 +++++++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 45e8090b..969475b4 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1293,6 +1293,27 @@ static void e2fsck_pass1_set_thread_num(e2fsck_t ctx)
 	ctx->fs_num_threads = num_threads;
 }
 
+static void init_ext2_max_sizes()
+{
+	int	i;
+	__u64	max_sizes;
+
+	/*
+	 * Init ext2_max_sizes which will be immutable and shared between
+	 * threads
+	 */
+#define EXT2_BPP(bits) (1ULL << ((bits) - 2))
+
+	for (i = EXT2_MIN_BLOCK_LOG_SIZE; i <= EXT2_MAX_BLOCK_LOG_SIZE; i++) {
+		max_sizes = EXT2_NDIR_BLOCKS + EXT2_BPP(i);
+		max_sizes = max_sizes + EXT2_BPP(i) * EXT2_BPP(i);
+		max_sizes = max_sizes + EXT2_BPP(i) * EXT2_BPP(i) * EXT2_BPP(i);
+		max_sizes = (max_sizes * (1UL << i));
+		ext2_max_sizes[i - EXT2_MIN_BLOCK_LOG_SIZE] = max_sizes;
+	}
+#undef EXT2_BPP
+}
+
 /*
  * We need call mark_table_blocks() before multiple
  * thread start, since all known system blocks should be
@@ -1304,6 +1325,7 @@ static int _e2fsck_pass1_prepare(e2fsck_t ctx)
 	ext2_filsys fs = ctx->fs;
 	unsigned long long readahead_kb;
 
+	init_ext2_max_sizes();
 	e2fsck_pass1_set_thread_num(ctx);
 	/* If we can do readahead, figure out how many groups to pull in. */
 	if (!e2fsck_can_readahead(ctx->fs))
@@ -1944,6 +1966,10 @@ void _e2fsck_pass1(e2fsck_t ctx)
 
 		if (ino == EXT2_BAD_INO) {
 			struct process_block_struct pb;
+			e2fsck_t global_ctx = ctx;
+
+			if (ctx->global_ctx)
+				global_ctx = ctx->global_ctx;
 
 			if ((failed_csum || inode->i_mode || inode->i_uid ||
 			     inode->i_gid || inode->i_links_count ||
@@ -1959,7 +1985,7 @@ void _e2fsck_pass1(e2fsck_t ctx)
 			}
 
 			e2fsck_pass1_block_map_r_lock(ctx);
-			pctx.errcode = ext2fs_copy_bitmap(ctx->global_ctx->block_found_map,
+			pctx.errcode = ext2fs_copy_bitmap(global_ctx->block_found_map,
 							  &pb.fs_meta_blocks);
 			e2fsck_pass1_block_map_r_unlock(ctx);
 			if (pctx.errcode) {
@@ -3297,39 +3323,13 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 	return 0;
 }
 
-static void init_ext2_max_sizes()
-{
-	int	i;
-	__u64	max_sizes;
-
-	/*
-	 * Init ext2_max_sizes which will be immutable and shared between
-	 * threads
-	 */
-#define EXT2_BPP(bits) (1ULL << ((bits) - 2))
-
-	for (i = EXT2_MIN_BLOCK_LOG_SIZE; i <= EXT2_MAX_BLOCK_LOG_SIZE; i++) {
-		max_sizes = EXT2_NDIR_BLOCKS + EXT2_BPP(i);
-		max_sizes = max_sizes + EXT2_BPP(i) * EXT2_BPP(i);
-		max_sizes = max_sizes + EXT2_BPP(i) * EXT2_BPP(i) * EXT2_BPP(i);
-		max_sizes = (max_sizes * (1UL << i));
-		ext2_max_sizes[i - EXT2_MIN_BLOCK_LOG_SIZE] = max_sizes;
-	}
-#undef EXT2_BPP
-}
-
 static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
 {
 	struct e2fsck_thread_info	*infos = NULL;
 	errcode_t			 retval;
 
-	retval = _e2fsck_pass1_prepare(global_ctx);
-	if (retval)
-		goto out_abort;
-
 	pthread_mutex_init(&global_ctx->fs_fix_mutex, NULL);
 	pthread_rwlock_init(&global_ctx->fs_block_map_rwlock, NULL);
-	init_ext2_max_sizes();
 	retval = e2fsck_pass1_threads_start(&infos, global_ctx);
 	if (retval) {
 		com_err(global_ctx->program_name, retval,
@@ -3351,7 +3351,11 @@ out_abort:
 
 void e2fsck_pass1(e2fsck_t ctx)
 {
-	e2fsck_pass1_multithread(ctx);
+	_e2fsck_pass1_prepare(ctx);
+	if (ctx->options & E2F_OPT_MULTITHREAD)
+		e2fsck_pass1_multithread(ctx);
+	else
+		_e2fsck_pass1(ctx);
 	_e2fsck_pass1_post(ctx);
 }
 
-- 
2.25.4

