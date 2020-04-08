Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89F521A1EF1
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgDHKpt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:45:49 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53128 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgDHKpt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:45:49 -0400
Received: by mail-pj1-f68.google.com with SMTP id ng8so1002749pjb.2
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xn/9gW4cVNsKY+C/0Cg/50ED51EAz2uYRVZSESOP2rA=;
        b=mEKVhFw9l0TWDeIOwnyKe3Kvx59CkvLwgSp+QZkkoiLICNpi6XxU7BOwEPH8OE3UxO
         1BBSZgQQgYo2SBL3StGT6lsjR/O9CXs7OsKe9QyLs4ZJeydb9Jq1Tr2uycE0oOFEIeHb
         Jnkr82nCM4zyGxCtmZ1wZXclgX0u7dY374gTTCY0aWqRUc3KvPs291msMpHkj2pJ9zu9
         kUafp0LIwrO18Bu9gQLROeXRM86jyiDiXbST7mzP3rA15m+3bT87Z5JrIrlGxHaa0hbj
         eVz0FYmTeUwfB0sJof+ncRtTVe3hO8POISwwB9AvT6mbBtkaBJLLMlS0BZ5Yy2QG6+D2
         jEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xn/9gW4cVNsKY+C/0Cg/50ED51EAz2uYRVZSESOP2rA=;
        b=fM9XFaNhXuD0UDzRtDhkeOEC2k0MBrElDM2VQxF/MSKy+wTid1+y4JbYuiWPmUTqDr
         3hgSVdAd/ELTIkZMBGbrWQoGonb46nWoB5YjR5VpY/lRsOrkEyePO6dsLQnvxCOITS+H
         EynIDNvAKZUnG3AFxrVhAA8wiwYEDEN5P1exAZ2GaJeFxwFsYqP9/6aZ/jSa9PcgrEUT
         oh0aCCJfH086sP86ETFQ+ECNcKb12DsL2cYpEfYTFTPVp2R+7Cqlm8kEYVEVXSoNl/YC
         6cFPmBSjsv5EcwpTl3m+hYEJD/6G7bEhYj97X2UxdCbvL+UrwC3lcqixqsQ/pIQfYuyn
         VQ/w==
X-Gm-Message-State: AGi0PuY/fEIA14LIKXBupBnMkmQYJG9Ij0QMStT0Sju9RzvBKvQOtj8w
        N+xJOi7wkbBxfFiYtXqtrzJ5OQeH9CI=
X-Google-Smtp-Source: APiQypK/zJMFeBuICaoojoSnsEq1SR5vfAo3iEEasC3TA5/odkwEh2Kn5+YOesNLwOc6SwQJjUGYDA==
X-Received: by 2002:a17:902:be12:: with SMTP id r18mr6836746pls.303.1586342747917;
        Wed, 08 Apr 2020 03:45:47 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:45:47 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 07/46] e2fsck: add assert when copying context
Date:   Wed,  8 Apr 2020 19:44:35 +0900
Message-Id: <1586342714-12536-8-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
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
index 599c69aa..2fafeb38 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -46,6 +46,7 @@
 #ifdef HAVE_ERRNO_H
 #include <errno.h>
 #endif
+#include <assert.h>
 
 #include "e2fsck.h"
 #include <ext2fs/ext2_ext_attr.h>
@@ -2157,6 +2158,18 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
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
2.25.2

