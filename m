Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A4C2B80E9
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgKRPlo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgKRPlo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:44 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E87C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:42 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id a20so1502535pgb.21
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Cy+36TZ+jm/k9a0XwFzOM5dMptqvuuXClEnH7B0HQRo=;
        b=t+YOMAhuTz7hAEFJSfe1yLvMEJGZgijAfP2u1w35kzOml6u9bHy59ymERFcmmgzsw+
         h2S8A8urTeQ2mpF+Hc/KXRFsSXTQ/9b5exfNBNCkhr7PJfdw53GUDiBJrjFTmNv5NRMK
         xRG39Bk0PchpHpHIatVZidi90X4WtbvFw3ZC4Pa8Imb299WLtAyO8UAcV0RsW0JcCSiG
         MU+2mENKdskVow55NP7ORZAyGivpP+BaK7PKVo9tnrFdvlFoFnvZcshQ8eSBEDFlMq7o
         roGsoabqL1v7YIzf9HOpU/Dyfw3z+EuoJESinNow2B4kkXC6Nro07UdzVhZsZ/nyZF/T
         xUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Cy+36TZ+jm/k9a0XwFzOM5dMptqvuuXClEnH7B0HQRo=;
        b=f335+aiBm5bVHicustPzwDupWUnxNzkMbyHcVfJCp7py8bKrUwaTC8JyisH+snaqbz
         aC+l4vJt1mwvXQwfa3ALsHkRH63l+4Os0GG9T8bV+ao2jsB7elTlG+QTvwYGgoKltFVR
         Mqhm2uqjgahnlQD8a3L2xotYRVoA1O6feG7zsTq2apRl6ssOzpMiGn8uQqdx+uQAiban
         id3JdN+m94bN+zrVWExrIhctwG6l2wRFNEkY/IJke8bhHkivFbAptiFz9QoKATS/SroI
         y6k9p9dbziBGGAAeVRttqAFBlKoHIgvzbwWNKWvyJnznAOpy/r1ar3c409F5QrZ8TRuo
         b5/g==
X-Gm-Message-State: AOAM530UAAfjQDpJew3Nq4gsRrehyCIAUeG5aINNdC4csTjkZq5jAZQs
        xwatDkOHUaZ195u49BpSA759CMYVteOMMF458gl8G01fDeX3/Gt+0iiqAhrQy52i6zmJ5tPHCsL
        PVWK6KieGiUdj6rrxHegLVU+PmBlJZq8POLJo5wL7VRyAPA/EVUvwmEPGfAHuqx5O/NUDIl1UfQ
        Ybn+UiJYU=
X-Google-Smtp-Source: ABdhPJyQwu6cqd2zdlk1h/1H6ZvmKMO28laMsVK9l6s94eWRE2AI21JL27O5S65bTvqIesgQz3PUaT8KN1uvuXVKl8k=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a17:902:b947:b029:d8:ab80:1e9c with
 SMTP id h7-20020a170902b947b02900d8ab801e9cmr5257868pls.42.1605714101991;
 Wed, 18 Nov 2020 07:41:41 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:27 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-42-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 41/61] e2fsck: set E2F_FLAG_ALLOC_OK after threads
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Only flag ALLOC OK after all threads finished without problem.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 03d7f455..62345bb6 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1379,9 +1379,12 @@ static void e2fsck_pass1_post(e2fsck_t ctx)
 {
 	struct problem_context pctx;
 	ext2_filsys fs = ctx->fs;
+	char *block_buf;
 
-	char *block_buf =
-		(char *)e2fsck_allocate_memory(ctx, ctx->fs->blocksize * 3,
+	if (e2fsck_should_abort(ctx))
+		return;
+
+	block_buf = (char *)e2fsck_allocate_memory(ctx, ctx->fs->blocksize * 3,
 					      "block interate buffer");
 	reserve_block_for_root_repair(ctx);
 	reserve_block_for_lnf_repair(ctx);
@@ -1459,6 +1462,8 @@ static void e2fsck_pass1_post(e2fsck_t ctx)
 		ext2fs_free_mem(&block_buf);
 		ctx->flags &= ~E2F_FLAG_DUP_BLOCK;
 	}
+
+	ctx->flags |= E2F_FLAG_ALLOC_OK;
 }
 
 
@@ -2290,6 +2295,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 	}
 
 	ctx->flags |= E2F_FLAG_ALLOC_OK;
+	ext2fs_free_mem(&inodes_to_process);
 endit:
 	e2fsck_use_inode_shortcuts(ctx, 0);
 	ext2fs_free_mem(&inodes_to_process);
-- 
2.29.2.299.gdc1121823c-goog

