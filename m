Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0512B80DB
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgKRPlR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgKRPlQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:16 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F186C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:16 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v12so2963061ybi.6
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=AZGCHeBKH5vmz22llsXqlzZoKg5JQiUV/C+mJX7pT5A=;
        b=tdKEayAEYP7W+n1STmhODIwNqHkwgEIUfMDDICLJ72jfzKbbkRQaKmrSNFEphFX9Ry
         kO/qMM0uw057WzaOnl1MOS2/Vrt00KLRua48TwLW5fWFWjri0TLQqvcWGzvwXewbnL7S
         EAMhBu26Fi0im/XvOws+rEqstpXt5Av1OaRMlCchvAIxi5JUUDSFLRVVXCdcun6bD6bb
         l84F+QLO3ZPSzl5NEi+9+NkC8CG3YiVik9lTQvvO3zuYfl5HTUap0Yu/WxGG1FzzMZEz
         7K227He9p7a+akLdxrTrfi4+Giy1z1O0M4HW0ndP/5/zeUWLrf2hRB6hPgOKF6hed3Zi
         OzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AZGCHeBKH5vmz22llsXqlzZoKg5JQiUV/C+mJX7pT5A=;
        b=m8xz2kRrQspMHrHyesgIvLCqrqBUeT45TI5dm9XLd+TGnOVtU1zPNzH6Nnvt6KGEd6
         E8opqPKoVyNKuklGTOetx3dOFF+2xoSnl2NqwVH4J3ZzHtFW8zaT4oBIRTs+Rv4diz/y
         vxHOAb5T6mp253O+nveX4Za4ke1kq4P159tkeetMDXTxCF4TaFJOI1ar8k90wHZu54KZ
         fkZCjaIR4LTDlDPLAofi22la7eeMTMilQrgg70bYtv4nDzCUAzUSJP0WXyOr4H0Ryy37
         PA/I95gKGNJRlNF6qXYh1wqBPAy3voWMqvK1sib24+Icc/bSnDKSnWkUV1cHhPR3agW8
         uRzw==
X-Gm-Message-State: AOAM530ZogXqP1wx6UOuRW7d8LjP59rkCHRqzEW1htIGE2Ed2nreL1Fs
        BcRCR8xI7uL1D7fWRZpDFt5fU9WzzMpFoPSTdtc0lL9nzMy5puF3YZzQxcYXM/iV2+T3TIOt/Em
        /D0lA1s+mWsjRPng73I1KObu2qn4iuxab7csn3nwY2hxWIutZ7HX/iMSoCGp78vNd3SUMMf6qfR
        8mjfABu24=
X-Google-Smtp-Source: ABdhPJzzMv9t5/qqTUioxf2gs7QpmYDExxWKfLs1avcwTcepDCkT0VCMOyhGYurCIAanb9Pg3CeOlTEEP2Xtvrg3rAE=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a25:2504:: with SMTP id
 l4mr8369407ybl.72.1605714075690; Wed, 18 Nov 2020 07:41:15 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:13 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-28-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 27/61] e2fsck: merge context flags properly
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

e2fsck might restart after pass1, so we should keep
flags if possible, this patch try to fix f_illitable_flexbg failure

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 5378d7da..35ab9cae 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2573,9 +2573,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->fs_fragmented_dir += fs_fragmented_dir;
 	global_ctx->large_files += large_files;
 
-	/* Keep the global singal flags*/
-	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
-			     (global_ctx->flags & E2F_FLAG_SIGNAL_MASK);
+	global_ctx->flags |= flags;
 
 	retval = e2fsck_pass1_merge_fs(global_fs, thread_fs);
 	if (retval) {
-- 
2.29.2.299.gdc1121823c-goog

