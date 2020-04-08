Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFF31A1F17
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgDHKrI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:47:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41566 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgDHKrI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:47:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id b8so376269pfp.8
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qxQKpRrLqljFuiBTr4O911Th7guq7u5hMiM/VjA89uo=;
        b=pDMzW3c5JGbEhxNw5P4casDxZ8saMYhOPLNXHbiFIe4Q/uE/AlxuEqWmB/7222kQ3O
         cUeGTJOvPE70Rc7NpRdwejOkyMVtgz7gkHa/RVpNPbfrDqq0ZCgRx47BSc+v7sEbqC27
         GR98X+EzCdSwf6OvgFt9qX4OpjhDoDF1XvJTeIHCcybbwRXiJD8HTFxUgcFnezSpZrGG
         gI4F/C3fQR/v5/MCpjGrxsf9RC/Q0B5ZstBB8Hj/NZozRI+8lSeNkZJwpih2Istt/9+d
         XaUYtMai1ShdxsYTMsiV9Fs2RQclK1pwb/9g3DEUbOVCextLs40RC2Ggcr1fKWejWaF9
         4QhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qxQKpRrLqljFuiBTr4O911Th7guq7u5hMiM/VjA89uo=;
        b=p5jNHMSgy7Op6KlzCq7enMRP6cnwbFHRCsvACcumfbwCIppfPcbvw+OClOdlCGdgCx
         MJJ1Ngr8lprAISRD+z9Sozl8iNq+hlNJ4d8q468JHJtZm+ZFYhRKkZJdv62OV25aKHgi
         Kqo4ucuK5L9RR/I7wEH39MGqCqDEfrmbOENJs4POPp+Xez0ZvYXtaziyg3QMj8D5kEJ9
         Dl6i9KnUYxPxuRFhrj46u6Vkxj8oWxLFCZHHQ7ZKu0chRhe/MqYDOQ/LPu6GMta6xINT
         6JtTboFk7FKYBX9Mj+IfvJbDIcXC9jmDkHZJEjrvObSZHFLgWasShcepXP9pO1nq+qVe
         Sfng==
X-Gm-Message-State: AGi0Pubj/RlNyTdEZ0PCm0C2hYLufHQtAnqIW1yAFEFSKM/oYPR7luYP
        59hwWhiK+hbeCeFFeRLrBL0wQ9sdeMQ=
X-Google-Smtp-Source: APiQypK9aez2Svf6X+GBeZ/yGSOftwjLHDvL7YSp0mBN+ccQixhHctOYmKzVzUS6uhdw3Jq85U6ocg==
X-Received: by 2002:aa7:940f:: with SMTP id x15mr2033989pfo.312.1586342826904;
        Wed, 08 Apr 2020 03:47:06 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:47:06 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 44/46] e2fsck: reset lost_and_found after threads finish
Date:   Wed,  8 Apr 2020 19:45:12 +0900
Message-Id: <1586342714-12536-45-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

This should not be kept, the reaons is similar to what
e2fsck_pass1 has done before.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 19475815..61b667e0 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -3007,6 +3007,11 @@ static errcode_t e2fsck_pass1_merge_context(e2fsck_t global_ctx,
 	global_ctx->flags |= thread_ctx->flags;
 	/* threads might enable E2F_OPT_YES */
 	global_ctx->options |= thread_ctx->options;
+	/*
+	 * The l+f inode may have been cleared, so zap it now and
+	 * later passes will recalculate it if necessary
+	 */
+	global_ctx->lost_and_found = 0;
 
 	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
 	e2fsck_pass1_merge_dx_dir(global_ctx, thread_ctx);
-- 
2.25.2

