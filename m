Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6169B1FF6C5
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbgFRP3c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731602AbgFRP32 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:29:28 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66135C06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:27 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id d6so2827944pjs.3
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RAkVjB5r/x0wGP4lXQ1ZMr5DaYhkXmdzrJRMrUQ8jik=;
        b=vgwuyjbOvZzllQbqerbVCkvbPQq2TcIWD3RcWjpoLZ6L3Va8BQURkOrq6hoxb1Vfoq
         9ZlcPSMpyhk1nYIPqVzn3DFe3INCKjvCHAylIdC/64ZrLpS6engsuMvzsMiJRA72ho6u
         fKZqjkUvOCyIj5HMZM2sJNDnH6pfanGOHvjl3e/oKsI9fXlzHWdXh5rpeUMogkuLtGBf
         NWG4gUxs946UYUjwQjJHWvdVtH3zDRRXcxs7NSsDeT5z5nQdplFjJb8httr8FqtA45UY
         cbfLBWV4CXbHR4xo85lZphOxiNo3tjW9lPo5h6lWyi6iVxmzlrndLjRkfJpUuKQSbkSd
         Txmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RAkVjB5r/x0wGP4lXQ1ZMr5DaYhkXmdzrJRMrUQ8jik=;
        b=UVm5wC9Q4AcKt1KT7956p8XKYDmD+NHijGnopp8Su5AGiihgLl3sd1uqs16PTXLCR7
         Rt4Z0s5CK9AIYgyV4lxdHQEpmnXWoyqQxzRjrehMP6q3h5vsYtIsTzrgMnotTyAJiq74
         0lpIeXizYvxPogYHDiLxgo5lS+AAKQxgAQNlWx8bA5V/C69c0fWxMB3tPzlBTTXRJizj
         4SXMTLGyiyavupWGCROSzIzpaaaCfwPupeflDtuGdinaJ5w9u+B6Ym978ZyJ5ZZCfXmC
         CyK0Dj5BgRKwHeMVauMnPYe7XepfASDlIzPdB6VCG8XBjrvn5Op6wjusS7YVuGMrU8Cz
         wtNg==
X-Gm-Message-State: AOAM530Wx3aRJjfMaCmhTsAveEUeZA36xtQX0FNlqGNxUmaB0KiTzPRS
        4ibLMksUl8QOtfydLczKwnRk7s/eObY=
X-Google-Smtp-Source: ABdhPJzKQt3jpi4/lQfJzpPJu1SawhfcdhHI0fyejyg1j50r4QTnd7AftGvpdkwiRXNYqaVcCz2ngg==
X-Received: by 2002:a17:90a:bf0b:: with SMTP id c11mr5018807pjs.47.1592494166586;
        Thu, 18 Jun 2020 08:29:26 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.29.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:29:25 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 31/51] e2fsck: merge context flags properly
Date:   Fri, 19 Jun 2020 00:27:34 +0900
Message-Id: <1592494074-28991-32-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

e2fsck might restart after pass1, so we should keep
flags if possible, this patch try to fix  f_illitable_flexbg failure

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 3e608f3b..182e1cd8 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2604,9 +2604,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_fragmented_dir);
 	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, large_files);
 
-	/* Keep the global singal flags*/
-	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
-			     (global_ctx->flags & E2F_FLAG_SIGNAL_MASK);
+	global_ctx->flags |= flags;
 
 	retval = e2fsck_pass1_merge_fs(global_fs, thread_fs);
 	if (retval) {
-- 
2.25.4

