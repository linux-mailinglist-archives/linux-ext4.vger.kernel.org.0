Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD75A2B80F0
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgKRPl7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgKRPl4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:56 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36D3C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:56 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k7so2894169ybm.13
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=UTLg+CGayr6X9HdLF8+fpEo3MODBqTn3f897ddxuEjs=;
        b=BDECphOEIpEXkOKBYjk/D/nv8Pm1Fa/e9bN6pkg+LtHTdcpbv328LDo3TQObT9M3J5
         lV6STdBylxmP6QE/Dp49NkjQ3qKtHV03o7jAApprSamBexGFzluZiZ5YbdRGXLBnl/nQ
         fl6jfxBwUsNbhEZ45EuYCz2/43vP8MON3ze1SdGetmoYLjRhNP7JLFxKXv9ymfOEPCWa
         CVIwbA4ii+apOdX0zCJtIq2NsrSN7d7dkSknEzyTfJ4ZTNGqiO6Q5b6bO2CuEE+fMG4s
         mCey+PZOJM91Cn9G2kH1rAEQWBJQomzU1A4N//o/uwjWL12qsBbGE0RAiLw2gEyqNDV1
         bLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UTLg+CGayr6X9HdLF8+fpEo3MODBqTn3f897ddxuEjs=;
        b=oWS5af2FBaWhW+hPhYNJwXqelGdmbgTphGbVH6HQnkaCfbggilrj6lCaZ0p8rtXG1e
         8iHVIH6Cw/A8wsFTyFJgeHyfpbeqLzwpgbmNF7f5wjRoJ9wFjHEPJcm7gjLwXnqU/Lcf
         eeLerqsBIXm2wNjNArRQGBor6/rIwpi2omkCJg1H0bvaLsFjRYj+Q/yTJ8EuVpJ6KOxv
         L0AIN6xiDW1/uRuqBRPVb4l81z1lwJGRj24fFHw0M6tteQfWu7JxGd6gmewqYBDmktYE
         29L8MT7Qc+uF//23IjM4/p9YI3YAHwfg/5BQgllD3kN1GGDaTjyrbjt3k8447UsypOeL
         RJ0g==
X-Gm-Message-State: AOAM532XfhoxXqF64o1A3xNkfO4z3mQz2W4T2I5BYNianB7fXb3zmmAz
        OnA4niKl3FOutzcwcMSOTFhPzE5MtXRl5Ra7Zd/I3TimHSG5Lmu2gci6RCtzmrQqK6Bo9/ob4XE
        ZbcTlBBpd4bnJ9NMxPBWMaMiEuk6DgsYCC1oOjGymh8eMH50pWouXWU4pWeuIx0RX3guePiWrCV
        xLX5KOYTw=
X-Google-Smtp-Source: ABdhPJw+EPF+egPC2g7jXAP3AWlf4o/flFAvAS4PD+0wCsL8S9NuQM8/TenVfkQvZgquwE8h7ZrUiA8CSpe3KRUW50o=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a25:874e:: with SMTP id
 e14mr7372803ybn.112.1605714115826; Wed, 18 Nov 2020 07:41:55 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:34 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-49-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 48/61] e2fsck: reset @inodes_to_rebuild if restart
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Verify multiple thread on a corrupted images hit following bug:

pass1.c:2902: e2fsck_pass1_thread_prepare:
Assertion `global_ctx->inodes_to_rebuild == NULL' failed.
Signal (6) SIGABRT si_code=SI_TKILL
./e2fsck/e2fsck[0x43829e]
/lib64/libpthread.so.0(+0x14b20)[0x7f3b45135b20]
/lib64/libc.so.6(gsignal+0x145)[0x7f3b44f2c625]
/lib64/libc.so.6(abort+0x12b)[0x7f3b44f158d9]
/lib64/libc.so.6(+0x257a9)[0x7f3b44f157a9]
/lib64/libc.so.6(+0x34a66)[0x7f3b44f24a66]
./e2fsck/e2fsck(e2fsck_pass1+0x1662)[0x423572]
./e2fsck/e2fsck(e2fsck_run+0x5a)[0x41611a]
./e2fsck/e2fsck(main+0x1608)[0x4121b8]
/lib64/libc.so.6(__libc_start_main+0xf3)[0x7f3b44f171a3]
./e2fsck/e2fsck(_start+0x2e)[0x413dde]

@inodes_to_rebuild could be not NULL after we restart pass1

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/e2fsck.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/e2fsck/e2fsck.c b/e2fsck/e2fsck.c
index 1fd57504..a03550c0 100644
--- a/e2fsck/e2fsck.c
+++ b/e2fsck/e2fsck.c
@@ -75,6 +75,10 @@ errcode_t e2fsck_reset_context(e2fsck_t ctx)
 		ext2fs_free_block_bitmap(ctx->block_found_map);
 		ctx->block_found_map = 0;
 	}
+	if (ctx->inodes_to_rebuild) {
+		ext2fs_free_inode_bitmap(ctx->inodes_to_rebuild);
+		ctx->inodes_to_rebuild = 0;
+	}
 	if (ctx->inode_link_info) {
 		ext2fs_free_icount(ctx->inode_link_info);
 		ctx->inode_link_info = 0;
-- 
2.29.2.299.gdc1121823c-goog

