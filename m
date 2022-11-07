Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC7161F33F
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbiKGMar (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiKGM3C (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:29:02 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396F91038
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:29:02 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id b185so10452183pfb.9
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZW6y/QZcxmvZCTvnr9AhcCkA/wkdGYiX//7dn8rWZ28=;
        b=IhrE6LshpY0kCaNyJT9iNbBFJvfo7qiRUhmcjTqlyJjob47horGomCIcY+ztL6GZsB
         wy6ay6dHHIeQugNCX0oFgok4SAKgGgGHvW7yE+6cVV12ZOCFdoVlMeuSFb5popdt3k0C
         w3gmACEjlRdYQtYpGUsnkTHgKXQiXuwCV2c7gb6SP4klEhzz+1VFyrKD92j4mDvpd+sj
         ZovBrvC/yMxwEsL7AdgxXk8Blmzzh4W8ipQR6HdX+Z1pYfDRAWo6+mhJlYJmSwrp6dSV
         FEBKuiyCUTkmwh1d7OcAaYrfX6WXkQTFC4mYueyN2aaXjX57DUctU+Bm4kfrvhD0ruQh
         UBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZW6y/QZcxmvZCTvnr9AhcCkA/wkdGYiX//7dn8rWZ28=;
        b=2Oigkv22mq59eE2ZOvhvvZkqaG40Q6NPUy14uF815WcYgwd0VNl404Xfh/rto/U5WG
         q0DS9nZkLOE1onywTaJxhzPMt2O+K2/YJwzW7DLZ9iHfoLIy+dQIYchMMndOcnMW5ias
         m0uIpoQ93SdbQGXBOq9ctQVtvTooaPKXOin+dMhqYdKSRMl+7kJ9S9OBgGDecHRiwpbm
         Ls7dra447++8vwSDORgXRSIIFwf67AL4TD5SM0EzSLcae6XVy79NJ/J8Vl54QIgXR/yD
         ZwlCIPDXRt1f6uUOw/RN/bFxbAbwIIZoE3SEEmZ6aczZPo1A6TUYQDQOIOqp9zC0/e4e
         +5eQ==
X-Gm-Message-State: ACrzQf07LVuxovnaf7BEa0Esp35pHOIv+VxrMiUQxnGVlE+fS5PypnY4
        A0jXOEBXklYBz09ls6AbxX7rtB8etTk=
X-Google-Smtp-Source: AMsMyM7WcyetuWj+u7pRp/hvOO4wTrjAgGWF+OjmgWEbprPpsBI5WQ7L+euQ3rFmhWOonLBsgg8v0w==
X-Received: by 2002:a63:c04b:0:b0:46f:c183:242d with SMTP id z11-20020a63c04b000000b0046fc183242dmr34938582pgi.287.1667824141704;
        Mon, 07 Nov 2022 04:29:01 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id e18-20020a056a0000d200b0056c5aee2d6esm4380740pfj.213.2022.11.07.04.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:29:01 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 65/72] e2fsck: Annotating fields in e2fsck_struct
Date:   Mon,  7 Nov 2022 17:51:53 +0530
Message-Id: <17fb23e236be36b22ca578def6d5efeadfba2d0c.1667822612.git.ritesh.list@gmail.com>
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

From: Saranya Muruganandam <saranyamohan@google.com>

Adding information on fields in e2fsck_struct
on how they are used when running parallel fsck.

Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/e2fsck.h | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 33866316..1e82b048 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -285,7 +285,7 @@ struct e2fsck_thread {
 struct e2fsck_struct {
 	/* Global context to get the cancel flag */
 	e2fsck_t global_ctx;
-	ext2_filsys fs;
+	ext2_filsys fs; /* [fs_fix_rwlock] */
 	const char *program_name;
 	char *filesystem_name;
 	char *device_name;
@@ -294,7 +294,9 @@ struct e2fsck_struct {
 	char	*log_fn;
 	FILE	*problem_logf;
 	char	*problem_log_fn;
-	int	flags;		/* E2fsck internal flags */
+	/* E2fsck internal flags.
+	 * shared by different threads for pass1 [fs_fix_rwlock] */
+	int	flags;
 	int	options;
 	unsigned blocksize;	/* blocksize */
 	blk64_t	use_superblock;	/* sb requested by user */
@@ -314,6 +316,7 @@ struct e2fsck_struct {
 	int (*progress)(e2fsck_t ctx, int pass, unsigned long cur,
 			unsigned long max);
 
+	/* The following inode bitmaps are separately used in thread_ctx Pass1*/
 	ext2fs_inode_bitmap inode_used_map; /* Inodes which are in use */
 	ext2fs_inode_bitmap inode_bad_map; /* Inodes which are bad somehow */
 	ext2fs_inode_bitmap inode_dir_map; /* Inodes which are directories */
@@ -322,12 +325,14 @@ struct e2fsck_struct {
 	ext2fs_inode_bitmap inode_reg_map; /* Inodes which are regular files*/
 	ext2fs_inode_bitmap inode_casefold_map; /* Inodes which are casefolded */
 
+	/* Following 3 protected by [fs_block_map_rwlock] */
 	ext2fs_block_bitmap block_found_map; /* Blocks which are in use */
 	ext2fs_block_bitmap block_dup_map; /* Blks referenced more than once */
 	ext2fs_block_bitmap block_ea_map; /* Blocks which are used by EA's */
 
 	/*
-	 * Inode count arrays
+	 * Inode count arrays.
+	 * Separately used in thread_ctx, pass1
 	 */
 	ext2_icount_t	inode_count;
 	ext2_icount_t inode_link_info;
@@ -349,7 +354,8 @@ struct e2fsck_struct {
 
 	/*
 	 * Array of flags indicating whether an inode bitmap, block
-	 * bitmap, or inode table is invalid
+	 * bitmap, or inode table is invalid.
+	 * Separately used in thread_ctx, pass1
 	 */
 	int *invalid_inode_bitmap_flag;
 	int *invalid_block_bitmap_flag;
@@ -362,7 +368,8 @@ struct e2fsck_struct {
 	char *block_buf;
 
 	/*
-	 * For pass1_check_directory and pass1_get_blocks
+	 * For pass1_check_directory and pass1_get_blocks.
+	 * Separately used in thread_ctx in pass1
 	 */
 	ext2_ino_t		stashed_ino;
 	struct ext2_inode	*stashed_inode;
@@ -421,6 +428,7 @@ struct e2fsck_struct {
 
 	/*
 	 * How we display the progress update (for unix)
+	 * shared by different threads for pass1 [fs_fix_rwlock]
 	 */
 	int progress_fd;
 	int progress_pos;
@@ -429,7 +437,7 @@ struct e2fsck_struct {
 	int interactive;	/* Are we connected directly to a tty? */
 	char start_meta[2], stop_meta[2];
 
-	/* File counts */
+	/* File counts. Separately used in thread_ctx, pass1 */
 	__u32 fs_directory_count;
 	__u32 fs_regular_count;
 	__u32 fs_blockdev_count;
-- 
2.37.3

