Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BDA1FF6C4
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbgFRP31 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731568AbgFRP3W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:29:22 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA01C0613ED
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:22 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ne5so2686798pjb.5
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oFSmbD7nnbuFDZD9N+1MF0qrvXmDe29r6LMb7co2PP4=;
        b=fpGxH8H0liCfcq+J8gUX0gEETTNglT1AUDFk7RCMp1nzRTn86WyVNZiQUFYy1Q8gN4
         BQ4wa163wNF4Xigi14779o8xbH9BSO9k36s2pEyeXwx17pWjnMF8nh/XOF6iiMo/BEuF
         aj84cCCp8Ny3zG0MzqAmso2o2axprHc1r/TrdsawLniQs+4t73NwfmNq22qNvx4q0A3M
         nEOwrkFQhruz95ZOjFT0aN9nrrn859XJPLN6zG8iSqb7MQQfL3Z5iauTu3dmpCoxaYBA
         GTjotsLbfyd1Lh6TK9jcBXnWNH0Exn+vXPbPvbwR26wq6XA7Wq+SX8m0Yzh+hHCiUkTO
         Y8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oFSmbD7nnbuFDZD9N+1MF0qrvXmDe29r6LMb7co2PP4=;
        b=gZkFHNS/bzyGS/aVqL13eaYHWcwW8R8kFJLFImau4xQbTZVjeWQXJOBd7WFNGgXgix
         AJ7Xvz/fBhDZvHuegr5GPtzuj3F8ZsHID2w2h3OfcJoTh6C3Tw60wyf/vKeUY0CXG/Q7
         La/WcDVjdqRk4Hqrnm0aqWrbYhI2XS53DMGhATf4QiD4YnBidEI0nmUpNRnn7cyTPT4m
         fB+WhXnKaqUo9MuD0tT+G6XmrMr/T1+3j3O/l8bxvi79Ca/6/1qHQAZqHicjkjvGnG2D
         6hqdud83MNI29tEePhFrw5GcdBPksDsI3OoHYJrg47nzGk7/eBL2E6I2tZwcjhM5Xtap
         xjLg==
X-Gm-Message-State: AOAM532uV3CFBTEeJ1nJxZi8gf+WqHe6M7OYG0w7a46e66SSGUgqGe1F
        o8TbV5KHVt2LU+FFx6Y+jjtSrVT29Fo=
X-Google-Smtp-Source: ABdhPJz7uWOXSkaw95/bmUjF2JTXNkzT2dmqWIBsqI/8f26IXydWeq77BzM9ydxSYTzWwtcKe1l6Mg==
X-Received: by 2002:a17:902:e78f:: with SMTP id cp15mr4282743plb.41.1592494161799;
        Thu, 18 Jun 2020 08:29:21 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.29.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:29:21 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 29/51] e2fsck: make threads splitting aware of flex_bg
Date:   Fri, 19 Jun 2020 00:27:32 +0900
Message-Id: <1592494074-28991-30-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Flex_bg might be enabled, if this is enabled it makes
more sense to split based on this.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index c5107956..868c8777 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2838,6 +2838,23 @@ static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
 	struct e2fsck_thread_info	*infos = NULL;
 	int				 num_threads = 1;
 	errcode_t			 retval;
+	unsigned flexbg_size = 1;
+	int max_threads;
+
+	if (ext2fs_has_feature_flex_bg(global_ctx->fs->super))
+		flexbg_size = 1 << global_ctx->fs->super->s_log_groups_per_flex;
+
+	max_threads = global_ctx->fs->group_desc_count / flexbg_size;
+	if (max_threads == 0)
+		num_threads = 1;
+	else if (max_threads % num_threads) {
+		int times = max_threads / num_threads;
+
+		if (times == 0)
+			num_threads = 1;
+		else
+			num_threads = max_threads / times;
+	}
 
 	init_ext2_max_sizes();
 	retval = e2fsck_pass1_threads_start(&infos, num_threads, global_ctx);
-- 
2.25.4

