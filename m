Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FABF1FF6C3
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbgFRP31 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731602AbgFRP3Y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:29:24 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2202C06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:24 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b16so2916644pfi.13
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gLeoCzqW+OtzfeupIci2vYG8XkDVxg07PvPxmMZqEI4=;
        b=OHRHTBbZPpn/YiG9NXAM4JHqnAPfQo9ud7hWm8Jw6FMlPfacHbRfSyJ0RJ/7vexWL2
         FMbBMV5vm5qQ8pBaW9l8+cNOQkfDXKJtSlGNlnHPl/DUL2/dhKmJgJ3OBRkFfuDru2Hg
         gbnsOMtRp6z6GUGMOBFSz78MQI3YYeGLUKfzSloyeNCazZdjI+601vdRhzAM9G//H4Ln
         8HyQibX2Ri/AhGiiMy96C/ZDy5WL3M9ZwrDDgPUF69ZH1ieIOg5sCT6lzkN7Y3p+Balo
         vImgyG7io6wG8VRDWxcjq1x0jMYp4kitZLxfiHbm54avxBS0E6PLD7KgfLc+sR6oEC5u
         4p6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gLeoCzqW+OtzfeupIci2vYG8XkDVxg07PvPxmMZqEI4=;
        b=kyBBR4ThtnYWLo4KZQHui7y9NZ0bk+VJ03ZsoeZSHHKhvyPmjpLOG2uH5yCxZNjqrP
         lk7I5BrQL56hTYJfepvR5fUV2jbCy9mXU6UcqWOBlbyX4qc3cuXiSjftwn6Gxc0MwzNF
         +8KXo/6jrWXr7yNDb5BF0R0B0wXELfAIZ6drHl+Y2CD+xshsNLhpi4q3UKz/ak5W1X+M
         R0iEi46wc54OqA18UJRhBnFA6M7+oj0lATXxTKeRPv/DD08UGusi1N1f26V1X5UCloeq
         TNddj+KJ4EDqTWfffB71PCOHf+yS8GLQe9at6WaZDAf6w8ks4d1hApWVPT5lepyAeHpI
         PIRg==
X-Gm-Message-State: AOAM531pxNO/yyWQmnx1LJ7tmHI7b7bfJKnb4nk8eEhcsUIn+MNx5uu7
        Gg6CNEM9Z6uQ57UdusQPHso83ZVwWOQ=
X-Google-Smtp-Source: ABdhPJzGIKtyasB8BdvOpe2TLs9AT8HEzma6hmn5u72jSDCJQiCJxWWemKv2ON6V5Ac2whM6CMs5Pw==
X-Received: by 2002:a62:154f:: with SMTP id 76mr4116417pfv.322.1592494164101;
        Thu, 18 Jun 2020 08:29:24 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.29.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:29:23 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 30/51] e2fsck: merge dirs_to_hash when threads finish
Date:   Fri, 19 Jun 2020 00:27:33 +0900
Message-Id: <1592494074-28991-31-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

This will fix t_dangerous test failure with 2 threads.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 868c8777..3e608f3b 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2494,6 +2494,27 @@ static errcode_t e2fsck_pass1_merge_icounts(e2fsck_t global_ctx, e2fsck_t thread
 	return 0;
 }
 
+static int e2fsck_pass1_merge_dirs_to_hash(e2fsck_t global_ctx, e2fsck_t thread_ctx)
+{
+	int retval = 0;
+
+	if (thread_ctx->dirs_to_hash) {
+		if (!global_ctx->dirs_to_hash)
+			retval = ext2fs_badblocks_copy(thread_ctx->dirs_to_hash,
+						       &global_ctx->dirs_to_hash);
+		else
+			retval = ext2fs_badblocks_merge(thread_ctx->dirs_to_hash,
+							global_ctx->dirs_to_hash);
+
+		if (retval)
+			return retval;
+
+		ext2fs_badblocks_list_free(thread_ctx->dirs_to_hash);
+		thread_ctx->dirs_to_hash = 0;
+	}
+	return retval;
+}
+
 static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 {
 	errcode_t	 retval;
@@ -2535,6 +2556,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	__u32	large_files = global_ctx->large_files;
 	int dx_dir_info_size = global_ctx->dx_dir_info_size;
 	int dx_dir_info_count = global_ctx->dx_dir_info_count;
+	ext2_u32_list dirs_to_hash = global_ctx->dirs_to_hash;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
@@ -2602,6 +2624,12 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 			_("while merging icounts\n"));
 		return retval;
 	}
+	global_ctx->dirs_to_hash = dirs_to_hash;
+	retval = e2fsck_pass1_merge_dirs_to_hash(global_ctx, thread_ctx);
+	if (retval) {
+		com_err(global_ctx->program_name, 0, _("while merging dirs to hash\n"));
+		return retval;
+	}
 
 	/*
 	 * PASS1_COPY_CTX_BITMAP might return directly from this function,
-- 
2.25.4

