Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B3C1FF6E2
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbgFRPaM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731554AbgFRPaF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:30:05 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9DEC0613EE
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:30:04 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i12so2695983pju.3
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YkN6ZBPqnb9wASqKLD9KQHxFSSFjMC+5N69Cq+6Ifw4=;
        b=JhLX5xPZ83F0T13Sk9dEHuM5/Yh//WO/6ASx1z65VrvPvJ6f71u+K6dMr+29nzWeOH
         UfDMETunU0Gt2Qu40t5BmfrrBTYIC5Ow5W0el/rpif5iSkqc/Ry6+OFqmalJvKGTgNvl
         6UbRzbdX7iz+xHsKzWxtHQX8fPhK7D/aPrFlUuT7y6YihhAdEadtMnFFgRnj3N0FTC4X
         C+KUct4uzu8RrgcmLCJtQ6T88ualLj0oRHccAKiaHGfPARXJT1VaBUNxCVmnTTermspB
         i6fUO11bMS5NiCX5RLiS8pe9/Gz+4uuO69Y3BygucnTRg2jG498+Yt82zd/qk6kzwgSr
         wQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YkN6ZBPqnb9wASqKLD9KQHxFSSFjMC+5N69Cq+6Ifw4=;
        b=Kqzunxs0XExSkgd9HARZEkb68UGLhNhgTrXsmAgUstmHHkXauNS5wy5/B8AuiO1uQY
         hjtMhRy1xWZDEKXvf02FBv2z4br5UCZL+02YVHKKty3to9EiyYx9lSYMizrOburyb9ZN
         lYgFAfUMpj7MEMFuKpFJCxn5NjKrGcoYglkvHATgGwFJM8zJNar/YotARp3yEAIxEThx
         5zIP0hiJQmA2HXqbVhz/NRNC0mg/eQrqIUAHCnlZ61bJf6DQaVEPVzOSLYlAScUvODkv
         QziJ6oVfr5uoqBNTM0Yc4C0QtAjePatjpIw91KEattTn74DinBVBC++h7zCUfDAYJzZ2
         zYfQ==
X-Gm-Message-State: AOAM530VdJizkcHoDyFpnvtm0juhnQuZr3Vi8h42D8Y07xLPEl9ZE14J
        N5pOADeKAvFR1blUYyhkoaxY/wEUo+8=
X-Google-Smtp-Source: ABdhPJxS5+l/r3dwRL8XrUQfuS7HRmmTun9Qd0tlWekdB4QA4TT2AfyDEUTzVY+IAboRZ5ZG6b1AMA==
X-Received: by 2002:a17:90a:9d8b:: with SMTP id k11mr5014771pjp.10.1592494203742;
        Thu, 18 Jun 2020 08:30:03 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.30.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:30:03 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 46/51] LU-8465 e2fsck: merge extent depth count after threads finish
Date:   Fri, 19 Jun 2020 00:27:49 +0900
Message-Id: <1592494074-28991-47-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

tests covered by f_extent_htree.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 3d6af9fb..d56b7128 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2991,6 +2991,7 @@ static errcode_t e2fsck_pass1_merge_context(e2fsck_t global_ctx,
 					    e2fsck_t thread_ctx)
 {
 	errcode_t retval;
+	int i;
 
 	global_ctx->fs_directory_count += thread_ctx->fs_directory_count;
 	global_ctx->fs_regular_count += thread_ctx->fs_regular_count;
@@ -3018,6 +3019,11 @@ static errcode_t e2fsck_pass1_merge_context(e2fsck_t global_ctx,
 	 */
 	global_ctx->lost_and_found = 0;
 
+	/* merge extent depth count */
+	for (i = 0; i < MAX_EXTENT_DEPTH_COUNT; i++)
+		global_ctx->extent_depth_count[i] +=
+			thread_ctx->extent_depth_count[i];
+
  	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
  	e2fsck_pass1_merge_dx_dir(global_ctx, thread_ctx);
 	retval = e2fsck_pass1_merge_fs(global_ctx->fs, thread_ctx->fs);
-- 
2.25.4

