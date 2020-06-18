Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3E71FF6A8
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbgFRP2i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731383AbgFRP2e (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:28:34 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DD4C06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:32 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j12so715544pfn.10
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=63C2ZUZK0df9U0KREk83RRj976F+VKOdCZr0yUs3Au4=;
        b=IZ5xVjhY/tw0IeDohMVwg7Nx/RMxcct4VkUUHTdBp1CYpadFxUwlgnxjMMpVoVZpji
         9Kypkdkqza201sDkQywo15553BMzelzJexcaGNDF0uKgCUJeVHnT932VTEyvWDy0NwQU
         Z4a27Jtzi0mNIDTnqf127QxWi02u76TnwWDbgQrdFfrJNqgDudUBneWoBBigRJKs1Ztq
         rLmoKkLzySidIAyJENiG8Sg8rBpziPdE+GGMwM7coWlfs6LDkhEI3tzwQFw6onE6ZgpN
         veoZ+QIx9JTOOHVwILIp1OI8bueclLZqRbF5kEipcZMU4sKSVag6S0uVNGE2zhDCOAwZ
         WcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=63C2ZUZK0df9U0KREk83RRj976F+VKOdCZr0yUs3Au4=;
        b=TSBm84woNsIPzIo93wT2kLX0St+bfvOqPGHpJckISE3rzePlAheDVHdYZt+2Yf7fQP
         Zajn00PCINhklgX243njqfWSjZHPyEN8/CZjXoo1zjJJSPqWpTbbvbf8Ce1dMOWZCevb
         BSSrKdRtfUTBAMrYEcDs4RkwiH9zJK1kazvP+GdlgWlL+LT/HQsraaCyTOTtcL6rORZS
         h7WE670P1Lj3MfTW0acEAtGnrtTPRKCGawdPavjTSW3FvTviR67sovM84ByezD3IhX/u
         gzptKWyjLJavCMZ15hv4NPC3BDmqA0U+VQYVT0zp0K/gjQ+TGc/KmPrS31pmzQJFmu1T
         V9eQ==
X-Gm-Message-State: AOAM530Qseh1rMIjQiWcHhu6+yNXYOOz+n2vrBNTWVDZMMKUB68kk53Y
        aybO+j7btVPTfKuxkooNYnLAaq/Ubss=
X-Google-Smtp-Source: ABdhPJwIxrZB0qSTH8oG+myJPTw5LOGkU6uth97LiAX/9lzdQ6t1RqFUscTUAnENtqLdWIOQNN0iuw==
X-Received: by 2002:a63:7a56:: with SMTP id j22mr3624984pgn.194.1592494111919;
        Thu, 18 Jun 2020 08:28:31 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.28.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:28:31 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 08/51] e2fsck: add assert when copying context
Date:   Fri, 19 Jun 2020 00:27:11 +0900
Message-Id: <1592494074-28991-9-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

Adding the assert would simplify the copying of context.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 22597b12..1ee6b5bc 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -46,6 +46,7 @@
 #ifdef HAVE_ERRNO_H
 #include <errno.h>
 #endif
+#include <assert.h>
 
 #include "e2fsck.h"
 #include <ext2fs/ext2_ext_attr.h>
@@ -2139,6 +2140,18 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 	ext2_filsys	thread_fs;
 	ext2_filsys	global_fs = global_ctx->fs;
 
+	assert(global_ctx->inode_used_map == NULL);
+	assert(global_ctx->inode_dir_map == NULL);
+	assert(global_ctx->inode_bb_map == NULL);
+	assert(global_ctx->inode_imagic_map == NULL);
+	assert(global_ctx->inode_reg_map == NULL);
+	assert(global_ctx->inodes_to_rebuild == NULL);
+
+	assert(global_ctx->block_found_map == NULL);
+	assert(global_ctx->block_dup_map == NULL);
+	assert(global_ctx->block_ea_map == NULL);
+	assert(global_ctx->block_metadata_map == NULL);
+
 	retval = ext2fs_get_mem(sizeof(struct e2fsck_struct), &thread_context);
 	if (retval) {
 		com_err(global_ctx->program_name, retval, "while allocating memory");
-- 
2.25.4

