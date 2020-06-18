Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F681FF6DC
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbgFRP36 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731662AbgFRP34 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:29:56 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8545C06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:54 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g12so2564902pll.10
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=udiGdftRFUKGhz3T4TyiCaqm5K6DowDaarB8Z63IeFc=;
        b=aXTHgmnUAMF2xfhnGLU1CM/YpXfK4vJ9LcIzgBgY43K1/elbzLAGZfXdev51ZHzbxD
         Uz51BVjWb8Uh1PvMFPypetczUDCwSgkYPwfkW/3YrRA+aknqOYwKj0qTpQYmcXZLdhM/
         jdBCTNqSzBBvp1WbAQ67f5/08xkZZg9sh+dlvx+a44V7bD5UF2RmjqjYC6zkWasr92OC
         lJ8uA0y7dOgcqXX6/20RFTxtb65eZ4I/TTjGPds0zAr/RqsPdvFxH25HnbdPktYlA3S6
         o5/FslTFwpYY5jq3eWzIoJ4Q+fGt5BUTuoFVFdSJGXOsGannrty4zWAkMtGe1NQmglPd
         XShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=udiGdftRFUKGhz3T4TyiCaqm5K6DowDaarB8Z63IeFc=;
        b=YS6QQLYWfrxHayVCycpUx2LwY1SPt4l14S/WLnqQhAOhzKq72r4wyohmjiQQk8yoMv
         Nqaq5zSzWaXijEsx4DtAmjpZrQrJfyAgrqu+xGN5uVOfAFSC4Q4QAtT85eaqOX+W5chj
         xZj1uM6tb5oBx9OSptfh0gbBRh11Tb9tJBqWPd72b36W9VYWU4n6bOrZt/XHqyKebk8/
         KH0N8AgZXm8PA3UambCTVJMjA1DLIHIceLjt9yIYyIvbZDjCY3OD4UNQIu2ZI/FMBhuI
         QjYMWrVVro9v2oIGUJL0ctMrh8pRcGTGnODXyONwlFQI0X+7t1bBPRLYlwUTvmB/xpav
         iVcg==
X-Gm-Message-State: AOAM533qB09CP4jylltYZh9kMfjFCIA+I4AE5zV2wtrGtg11ZbfQEurx
        D5TJAC3giF8nzIe2a8YJo5Mbn6sejLE=
X-Google-Smtp-Source: ABdhPJyXezqbavn9mDvpor4PPNcXvUSWwnQA8ro3PWp4DNlPNY2bfc9utOjCskNtWFwFLa/hUQq7nA==
X-Received: by 2002:a17:90a:c7cb:: with SMTP id gf11mr4800598pjb.98.1592494193995;
        Thu, 18 Jun 2020 08:29:53 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.29.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:29:53 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 42/51] e2fsck: merge inode_bad_map after threads finish
Date:   Fri, 19 Jun 2020 00:27:45 +0900
Message-Id: <1592494074-28991-43-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Change-Id: I19138835c8532eab8f91b711ba25300b33329902
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 06e7d753..dc710e4d 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -3006,6 +3006,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2fs_inode_bitmap inode_imagic_map = global_ctx->inode_imagic_map;
 	ext2fs_inode_bitmap inode_reg_map = global_ctx->inode_reg_map;
 	ext2fs_block_bitmap inodes_to_rebuild = global_ctx->inodes_to_rebuild;
+	ext2fs_inode_bitmap inode_bad_map = global_ctx->inode_bad_map;
 	ext2_icount_t inode_count = global_ctx->inode_count;
 	ext2_icount_t inode_link_info = global_ctx->inode_link_info;
 	__u32	fs_directory_count = global_ctx->fs_directory_count;
@@ -3062,6 +3063,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->inode_reg_map = inode_reg_map;
 	global_ctx->block_dup_map = block_dup_map;
 	global_ctx->block_found_map = block_found_map;
+	global_ctx->inode_bad_map = inode_bad_map;
 	global_ctx->dir_info = dir_info;
 	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
 	global_ctx->dx_dir_info = dx_dir_info;
@@ -3141,6 +3143,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	 * so please do NOT leave any garbage behind after returning.
 	 */
 	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inode_used_map);
+	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inode_bad_map);
 	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inode_dir_map);
 	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inode_bb_map);
 	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inode_imagic_map);
@@ -3185,6 +3188,7 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	PASS1_FREE_CTX_BITMAP(thread_ctx, inodes_to_rebuild);
 	PASS1_FREE_CTX_BITMAP(thread_ctx, block_found_map);
 	PASS1_FREE_CTX_BITMAP(thread_ctx, block_ea_map);
+	PASS1_FREE_CTX_BITMAP(thread_ctx, inode_bad_map);
 	ext2fs_free_icount(thread_ctx->inode_count);
 	ext2fs_free_icount(thread_ctx->inode_link_info);
 	if (thread_ctx->refcount) {
-- 
2.25.4

