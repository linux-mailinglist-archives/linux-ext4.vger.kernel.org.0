Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B12531A1F07
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgDHKqg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45222 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbgDHKqf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id r14so2217153pfl.12
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8ZTvSriwJqZF9t50h+dKtDaZ6PR4kqR3n0K1agSL248=;
        b=JML3aw99UtbB5Mx8ELGFgLW4WL9G3JQsjKm2MW6l07QhuGczuimaggJYltDPg9jhmA
         UYKOzuZENO0vg2HcQTn4C70FYY6nnivRLzsN9lyZfBEv3ctcmvqspkBtyUoGbTGnJkDj
         SCeoXqr7oaRAIreJRCiTOI0vMY29Xl4ndinTfXNRfSP2UWhfmlz0P1tWIh8aPEYfC3OA
         TqzRfcXn9Di3vOtW6b6hlJoYFlQPFQbTnpRmHkaIKLLiUeIuRr6A1SegW6Ttugn/86Yf
         hPOmmn3tw/bjYt0A1zAQbHAFYSgBydIQ1h8d75lh7LVremx8AwbFfCVL9Kf6wD22X0OQ
         v41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8ZTvSriwJqZF9t50h+dKtDaZ6PR4kqR3n0K1agSL248=;
        b=WyOccR4hh3G8iGEGfxDf+DQnhMwH6+nj1D8iU7e0dMBnLML45eE++c/exstqaHJMO7
         5goI/iFwNrhNEm0OQQiCPcj2IzoxfskYW6jQJaFrLZwMEaMjqT32WfTSbpnW2eewtNrT
         noUNbXEeDDUfdQR51BbCFHLGyXuggqT00Yt220YXQaAaqXbirXmNOxmVpVlkjHYUTUUN
         +8DkrmIQbiMEFDwhSYvaiFi5zPPf1IyK7Gu//3vu2qtriJGDp8aFUs8l5OVAmSDp8azh
         iweVfgp1+/4Ms47+w1R+e8vUnUgwgx48JFqluw4AZYDLhYOHycg7nzdGnvZvM4XAwfHY
         mGDQ==
X-Gm-Message-State: AGi0PuZn1J+5k94o7LZsTSNNtzyg6eYVptCsrZzRZCZ+7KmKjpaPF8k9
        qXxPwtvB9hlf0nLFDXr/etCN3Zx0E8w=
X-Google-Smtp-Source: APiQypKD8O7nTXyRi7x6BsUmZzaNqnsURXPV0Bzqr3ETsdvRPgiD2tAN8SMzztsCB21TfeiFWSxeOw==
X-Received: by 2002:aa7:9a5d:: with SMTP id x29mr6697999pfj.284.1586342794930;
        Wed, 08 Apr 2020 03:46:34 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:34 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 29/46] e2fsck: merge dirs_to_hash when threads finish
Date:   Wed,  8 Apr 2020 19:44:57 +0900
Message-Id: <1586342714-12536-30-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
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
index 0044d7e8..52598838 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2512,6 +2512,27 @@ static errcode_t e2fsck_pass1_merge_icounts(e2fsck_t global_ctx, e2fsck_t thread
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
@@ -2553,6 +2574,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	__u32	large_files = global_ctx->large_files;
 	int dx_dir_info_size = global_ctx->dx_dir_info_size;
 	int dx_dir_info_count = global_ctx->dx_dir_info_count;
+	ext2_u32_list dirs_to_hash = global_ctx->dirs_to_hash;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
@@ -2619,6 +2641,12 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	com_err(global_ctx->program_name, 0, _("while merging icounts\n"));
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
2.25.2

