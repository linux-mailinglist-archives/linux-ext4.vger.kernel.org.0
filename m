Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D64B1A1F06
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgDHKqf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34895 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgDHKqf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id a13so2237161pfa.2
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o6jxCY3/7VptX/dKB1Kquoqkng2DESomuLljR5WkpYA=;
        b=MjJB/HSRzoiyPp3P8DwioZ/G+IoUOtQM5hFxYPBCEpg7ovdJJRFbY7zCQR1QYhEdPq
         BZTJjob60mk3CFlz4chQcj1C6O/CfYrMJAD3pP7CcgFQnn9pwIQ82OPR+SzJSig05nmX
         X4jhQQfHfYp5D4+HGAsDwHqR5tM2lMW+UD+jt2MnegxKMB1cttIs4ZSkqZAV170UEpji
         3ETQ8WWPY8AHw6pWKG6dY31u7YzrBMc4vITsTfMgPwlyQ7waBVBnyNdgVQ4qXBrXlxTT
         h7mfooXTEXcg/puHMkQeUOS696snM8qxmWhS1pMwi2obQjk3dLiH4N4qdM6ELRvRLSsz
         u7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o6jxCY3/7VptX/dKB1Kquoqkng2DESomuLljR5WkpYA=;
        b=pcgOUVkoBaD+rK8LOPpCPufIwAqWwNKiIiZ8nmcYc30A7OuEQPK9CUlbA7pyiNeqzD
         0h4SFXo9i/BiDBvbOyPPhpksnm67KeJEN9n45ZE72lY5DcaOgUtew52rY9jkA4cZ6Qyg
         KkVb2+hTp6C25yIQXqVZVt9Cl9PkbRTxZlCzk+zQNkhvq4uL4aIHGEoGJ5EtfbU4USOW
         1oNBocBt8AK4euQPxydCzMQpGNc24Cy/3XpGKUhO5E1F+Z5aAgMk55o5g72wWsjctO7M
         x8O4CupVw0bLGw5R3ldjPm5qO5y/yuU0UEpWhjOH1nOPN8/mGsBafABLnS51cpkXFlcU
         EOWg==
X-Gm-Message-State: AGi0PuZCYMc+zCsbsboIHRS2Uao+14rSjwsfOaCiF7JRBsA+YOsNXFw/
        Ktwmqn6UVHH/MAtQ7ZF7oY6/STfPy4Y=
X-Google-Smtp-Source: APiQypI8IqLzvHxtrY6IgXv+wOZMqyJAOJnuMNwSTWFcidFnUPNWeCz04Y5/Uar+qHdcZdfuwQOgCA==
X-Received: by 2002:a65:5642:: with SMTP id m2mr6591232pgs.191.1586342792777;
        Wed, 08 Apr 2020 03:46:32 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:32 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 28/46] e2fsck: make threads splitting aware of flex_bg
Date:   Wed,  8 Apr 2020 19:44:56 +0900
Message-Id: <1586342714-12536-29-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
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
index 6789b701..0044d7e8 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2854,6 +2854,23 @@ static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
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
2.25.2

