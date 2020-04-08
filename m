Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71A881A1F18
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgDHKrK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:47:10 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40260 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgDHKrJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:47:09 -0400
Received: by mail-pj1-f65.google.com with SMTP id kx8so997845pjb.5
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RI4K8Bq4KjVualKZfgzoqkpxnsQBg30vpB9GLwz60hg=;
        b=Ge2A+sq4SP97doT7iy7PGpcAz3TbuMzUoi5WAvjj4ZUQSrQKDlHmaW1Hrt/cqWGLGo
         XUnD2WIjqZxJ17/euePeIFBuzDj7d0AfojSa9f2UDyK6MzqaRlyfXD9DZjwazcnl2+qv
         YCaIvdLqgtHYa24n9W4lX2X9MRMYKHBBRykTnvF5Ti7clNcq87aFfuxIzzrJsvnXzqn6
         fIYE3JAvpVCx4F0GHZS1oLNOKRnPlTaxSiw8Ndgn2WZFxK2iQHzNgTh/h8T1Exrn+1k3
         92DHTqm/e7NudwrS3crFPurbIMpTlG3OHB8NKzoriNi7CnK1oaIhsl4vuUZUufSSzKWA
         NAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RI4K8Bq4KjVualKZfgzoqkpxnsQBg30vpB9GLwz60hg=;
        b=M65VgZebxZoHlAukgwaIgW2+o7JPg3eXDFhulaqoqybgR4De3J3ZA1Bs7pFOzZO+Vk
         XRHK9yYf3qWICEBHnFV89Nqk7u+JxCP9oWC6GEiAPLVwJ4SeDtM/P0Zns/7BK5E8d/zB
         eiKwRXsLvnUcao2v+8xSfS67+dQBCu7IukGflAtNWoqz709j/qk1dOLbqqXpWN8ayIWG
         7xjg+THVv7hYCncyT1C+Y/uq1eguml7mityJdy2vSMBCApSwwy1573Q5IbFsSxu45LFT
         FaoLUFHPgmoovKQuIPnUCtYn2QmoqwTYdwjojwgPcXc5VJx7iU9n0IE+2AlMWI1VpaJz
         4RRg==
X-Gm-Message-State: AGi0PuZSkq7khdroG1SbIYb71rbJCZfRMx09EGlJTWzup3KA1WQ0XDKf
        fgJEb05k+san2m4/ZrLjCgzeOYiOpg4=
X-Google-Smtp-Source: APiQypJmuoiunQChpcDDB7W2MmWCcV6+QRvLhEaYYw+OwD1q20pA5wANVUeQHXL/1TCQ/7Ri3O3sNw==
X-Received: by 2002:a17:902:b281:: with SMTP id u1mr6637545plr.287.1586342829004;
        Wed, 08 Apr 2020 03:47:09 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:47:08 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 45/46] LU-8465 e2fsck: merge extent depth count after threads finish
Date:   Wed,  8 Apr 2020 19:45:13 +0900
Message-Id: <1586342714-12536-46-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

tests covered by f_extent_htree.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 61b667e0..cd51de4a 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2986,6 +2986,7 @@ static errcode_t e2fsck_pass1_merge_context(e2fsck_t global_ctx,
 					    e2fsck_t thread_ctx)
 {
 	errcode_t retval;
+	int i;
 
 	global_ctx->fs_directory_count += thread_ctx->fs_directory_count;
 	global_ctx->fs_regular_count += thread_ctx->fs_regular_count;
@@ -3012,6 +3013,10 @@ static errcode_t e2fsck_pass1_merge_context(e2fsck_t global_ctx,
 	 * later passes will recalculate it if necessary
 	 */
 	global_ctx->lost_and_found = 0;
+	/* merge extent depth count */
+	for (i = 0; i < MAX_EXTENT_DEPTH_COUNT; i++)
+		global_ctx->extent_depth_count[i] +=
+			thread_ctx->extent_depth_count[i];
 
 	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
 	e2fsck_pass1_merge_dx_dir(global_ctx, thread_ctx);
-- 
2.25.2

