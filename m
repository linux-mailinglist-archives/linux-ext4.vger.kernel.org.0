Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276512B80FC
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgKRPmY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgKRPmX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:42:23 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B64C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:42:21 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id r4so2042384ybs.1
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/y900TGUU79g0E/kX5hTm3DULqidupZjxJK3msemDmE=;
        b=KkbP+bO7kFH0Jrjmpv41zNcxXUEqgOxCSgPYkH4cJlaMIBxhthy0wnrKWqGUQbZalV
         4CQ+6uP5RBnaP2u6yBzNvrvNB7PtUzvEE/vkzlAkIs11F9TqSikwlcy1isVJaRyJvyla
         VJS3h6o0Rc19NRVHUueCHntoabuzjOQDkuktQHrAVHZO650uTPvNiyYwupK8mHflnJNE
         PSdTkGk3wGXrDBcsgPV80W8ngOa05EyoLk9jsy19OjLdB47XXkwCFiC+njW2SXfCUJHL
         T086b4bL1mI+haVAz0V838l9w42IPXISbObYpgivMyTS8BGLkMbNfR/mfL52AU/YFYq5
         z9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/y900TGUU79g0E/kX5hTm3DULqidupZjxJK3msemDmE=;
        b=XJFNTvjAXs1DoM7ABBAU+opj4eQGOvQ8jUKBUzJ3p5C2U7echav/pPdf7DZp1+pilh
         TQzU+Hz8o/4fzjPFdaKO0qn4rsmZ4IUJLPa7CsQGWjNQOtrsAb3/GV8ce5cquwRK5QhW
         kUpqLjkev7d63mDLMaNsT5dLZGkp4b+Ume5a2L2MP5bgZLpVFaZtNoFJON7i6Jg9IgJ7
         bhtn8q/TKlPEBnEu6QcrfO3+AVOj2sHxAekZjchDwn/TDbDCK0xX5KC3V/HTzVMZkSg1
         BddYFxD0/WxNomY8czexIb3XVxaBQ8TWgbPCGbny3bcyY6Ku4Hs4cE0vQXiqwm98dBEV
         6CHA==
X-Gm-Message-State: AOAM531q1LsS8BXdsl+Hgn17cyrPMGyoSXQicpHFm6D+gbrWxoELbfI3
        Nke6V0UbkCvYGnBOdNjSX9BAYpiC0rOmnx3qmWAxFGVeLuUhLZbilchsPd2X1lIn618Q2OFAx9w
        E3UGUOCIXwYLCBXCli40c3nLWfVjmBlF8ioNfVgTm2WeB/VyAUxMXxZRIAKjzJZ4B2+vtOzCL10
        mHz8ORFhE=
X-Google-Smtp-Source: ABdhPJwDHI+E6Qy/OtDhWpbEKt1d1Z8T9cYgOSP//oQQK2YCWncOTj89y32s4BxbT0n6eQTh/LhtpDsQc46SPV1sNT8=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a25:4249:: with SMTP id
 p70mr7364470yba.259.1605714141172; Wed, 18 Nov 2020 07:42:21 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:47 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-62-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 61/61] e2fsck: Annotating fields in e2fsck_struct
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Adding information on fields in e2fsck_struct
on how they are used when running parallel fsck.

Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/e2fsck.h | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 362e128c..f15c383d 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -251,7 +251,7 @@ struct e2fsck_thread {
 struct e2fsck_struct {
 	/* Global context to get the cancel flag */
 	e2fsck_t		global_ctx;
-	ext2_filsys fs;
+	ext2_filsys fs; /* [fs_fix_rwlock] */
 	const char *program_name;
 	char *filesystem_name;
 	char *device_name;
@@ -260,7 +260,9 @@ struct e2fsck_struct {
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
@@ -281,6 +283,7 @@ struct e2fsck_struct {
 	int (*progress)(e2fsck_t ctx, int pass, unsigned long cur,
 			unsigned long max);
 
+	/* The following inode bitmaps are separately used in thread_ctx Pass1*/
 	ext2fs_inode_bitmap inode_used_map; /* Inodes which are in use */
 	ext2fs_inode_bitmap inode_bad_map; /* Inodes which are bad somehow */
 	ext2fs_inode_bitmap inode_dir_map; /* Inodes which are directories */
@@ -288,12 +291,14 @@ struct e2fsck_struct {
 	ext2fs_inode_bitmap inode_imagic_map; /* AFS inodes */
 	ext2fs_inode_bitmap inode_reg_map; /* Inodes which are regular files*/
 
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
@@ -315,7 +320,8 @@ struct e2fsck_struct {
 
 	/*
 	 * Array of flags indicating whether an inode bitmap, block
-	 * bitmap, or inode table is invalid
+	 * bitmap, or inode table is invalid.
+	 * Separately used in thread_ctx, pass1
 	 */
 	int *invalid_inode_bitmap_flag;
 	int *invalid_block_bitmap_flag;
@@ -328,7 +334,8 @@ struct e2fsck_struct {
 	char *block_buf;
 
 	/*
-	 * For pass1_check_directory and pass1_get_blocks
+	 * For pass1_check_directory and pass1_get_blocks.
+	 * Separately used in thread_ctx in pass1
 	 */
 	ext2_ino_t		stashed_ino;
 	struct ext2_inode	*stashed_inode;
@@ -387,6 +394,7 @@ struct e2fsck_struct {
 
 	/*
 	 * How we display the progress update (for unix)
+	 * shared by different threads for pass1 [fs_fix_rwlock]
 	 */
 	int progress_fd;
 	int progress_pos;
@@ -395,7 +403,7 @@ struct e2fsck_struct {
 	int interactive;	/* Are we connected directly to a tty? */
 	char start_meta[2], stop_meta[2];
 
-	/* File counts */
+	/* File counts. Separately used in thread_ctx, pass1 */
 	__u32 fs_directory_count;
 	__u32 fs_regular_count;
 	__u32 fs_blockdev_count;
-- 
2.29.2.299.gdc1121823c-goog

