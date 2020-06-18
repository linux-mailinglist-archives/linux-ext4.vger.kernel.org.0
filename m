Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C561FF6E1
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731681AbgFRPaK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731321AbgFRPaA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:30:00 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D88AC06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:30:00 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b7so3495868pju.0
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mYgHtiD3RT/PF1gpGhPfPw6D2NptmfB338VaCzf/V88=;
        b=dEFhz7Jgn5pG1R0U3Sk2QTNbq5Q2V6Wj8v1jhRTUNWgpcKZqF3eur7hJsvvZEKm8dX
         JKqgGMjFVkuBmvdY80IX9FD29D+nbtIStmQie0LzhHJ9vZmCTmaPVggmRq3zQzYPesXb
         uGfhl3kfUhEryo/I+T8m3h7eSHHQIwLT+aPD/t/iuCWXIxPRFxsO1oQJ6OQGGOiTLIb7
         blSS7S6jp6tpLnuB+SImr7o06hkVepPfFDGwnXC9UqlkPHpBVqc0Swbgvn0wH5LjPmHd
         Lj0rF+r2Pzn1RjLcklDruMvDqUF9k41dK20MVZMg4yA4JSZw2f/JoaeeuLuxrfBjO9oo
         RfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mYgHtiD3RT/PF1gpGhPfPw6D2NptmfB338VaCzf/V88=;
        b=cUPyc99SDfNMxkeJPJqDOBd17O2EgrzeecrMZYEmJdvMiQiw/t7ryf7fDZnH8Dg08u
         JrFvSUJmd+/FkFhO6U7qaT2Y+LRGJcVQFLmcjpsx6gHpo5RjYtQs78iDd8PScamgHsf4
         MXrOuaScvCkVdJFX2yeJfvm+iQ8IUrhguFgg+he6Glq9cjlM1DHpiW9Oqt53x8hRUw+l
         Abc8VPninlDmPJiPZF4p7XJCgOF3lUlUTk1jlx9lqgjoeHbSy5x/K9i3Eqsgz+1rD+62
         n+yo57g5X14kPPO5aAqY9Quf2ybIcmyEGtL4DfKGoTAjs9tHBnXTSsDqad1pD6rdP6Sc
         PK/A==
X-Gm-Message-State: AOAM53123GWdo9ODlZQZX6KQVbHdGB5M0JOSwf2LJE+FMtyoc4NfL2hG
        Uq3U2dxfFUPiTtkJ2+gUNkkpMA8XYQs=
X-Google-Smtp-Source: ABdhPJzLfUCf6RadhMwL38FlP3wrGNHN7Yk272PtON+KZyArYVI+kWThbQFG9hjwCVgchwnfy7oHWg==
X-Received: by 2002:a17:902:e989:: with SMTP id f9mr4384719plb.268.1592494198660;
        Thu, 18 Jun 2020 08:29:58 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.29.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:29:58 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 44/51] e2fsck: merge options after threads finish
Date:   Fri, 19 Jun 2020 00:27:47 +0900
Message-Id: <1592494074-28991-45-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

It will be possible that threads might append E2F_OPT_YES,
so we need merge options to global, test f_yesall cover this.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 7d6e531a..b4adb8fa 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -3010,6 +3010,8 @@ static errcode_t e2fsck_pass1_merge_context(e2fsck_t global_ctx,
 	global_ctx->fs_fragmented_dir += thread_ctx->fs_fragmented_dir;
 	global_ctx->large_files += thread_ctx->large_files;
 	global_ctx->flags |= thread_ctx->flags;
+	/* threads might enable E2F_OPT_YES */
+	global_ctx->options |= thread_ctx->options;
  	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
  	e2fsck_pass1_merge_dx_dir(global_ctx, thread_ctx);
 	retval = e2fsck_pass1_merge_fs(global_ctx->fs, thread_ctx->fs);
-- 
2.25.4

