Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0C2320016
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Feb 2021 22:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhBSVEd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Feb 2021 16:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhBSVEa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Feb 2021 16:04:30 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57CEC06178B
        for <linux-ext4@vger.kernel.org>; Fri, 19 Feb 2021 13:03:49 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id cx11so2290666pjb.4
        for <linux-ext4@vger.kernel.org>; Fri, 19 Feb 2021 13:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=owN266y34V0ZrUAH82uf3q260Ueenihmw5xY1YY0G5o=;
        b=oJYQPOEsCpcPYB0W5EaFXgS3MPK83JEGVc7QmL0HOIFOd9EManEud1ktZtIaEa1cvm
         VYh/NmTJ+bBmrBorbJCfuVKxskZqIwt8XXB5YAk+CKk6Xk7PRIKQ3KpjpzOOPsZGCFks
         m6mVqO2xUQJfqzfuidxgjO7TGiIAy/VN7/G/iaWgNzQqdKE5c7KzOYKIBMSiBGtDcK7t
         +vDMtQN6t4k9pVgQZpjjSrv//cFH2toNaOvBS3u27iB93BkRihCWWncDW4wgYLMDkEtr
         rSlX2rzVgzeszNStjC+XcKiGYgziQ9nrJ2kDLysZ/rV/NHWDWlenvWCa/5CmhTCppCVk
         Bnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=owN266y34V0ZrUAH82uf3q260Ueenihmw5xY1YY0G5o=;
        b=U4K2pzcCy08o9lkL/qXk70YDylHape0AAzlOoQSttqjraEves3vZjLJ/5tZE1CZ7+R
         cbKPXgiE7V/dr9AYF4RGXglFG+95aPBb9h8/h1ByFRYXM5GRewq7Ig28fD7pDeVB60Kx
         t3Gcs8BB1ZFANDWZs4j6bWa1gVpYW4QptchedAlyYUpNkTBYjydVDVpy31KX12p2gg1+
         hOSE/5rkOm4zI0CifB7XY+gsECDYGwcRJwQrNIr38fCgdOMlKYqm0dyWaIm7EIh2peJZ
         /Kvhz/ooJfTeXI5PnaBx43kUE0KlVEqobCef7gZgbcUe7B0YAoxOu9HVRK7Uzv8s9J34
         +r4A==
X-Gm-Message-State: AOAM531+7LS/3VYiGVv1P8etgrrUnZ2lnQxTCI6oTtjHb/++Eup9ywOd
        ywHQTR5CuptICWt1dolT2U+rT42z74M=
X-Google-Smtp-Source: ABdhPJwZa2dMHe+JWYBHJpPtcv0qnRYPg3Vn5sb92CCOpSIEqjVRSiA10vghKe+dlBO4q4Xl54zvZg==
X-Received: by 2002:a17:90a:cf82:: with SMTP id i2mr10701748pju.209.1613768629125;
        Fri, 19 Feb 2021 13:03:49 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:48e6:60ce:73b8:bccd])
        by smtp.googlemail.com with ESMTPSA id 30sm10318756pgl.77.2021.02.19.13.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 13:03:48 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 4/4] e2fsck: initialize variable before first use in fast commit replay
Date:   Fri, 19 Feb 2021 13:03:33 -0800
Message-Id: <20210219210333.1439525-4-harshads@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
In-Reply-To: <20210219210333.1439525-1-harshads@google.com>
References: <20210219210333.1439525-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Initialize ext2fs_ex variable in ext4_fc_replay_scan() before first
use.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 e2fsck/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index a67ef745..8e7ba819 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -289,7 +289,7 @@ static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
 	struct ext4_fc_tail *tail;
 	__u8 *start, *end;
 	struct ext4_fc_head *head;
-	struct ext2fs_extent ext2fs_ex;
+	struct ext2fs_extent ext2fs_ex = {0};
 
 	state = &ctx->fc_replay_state;
 
-- 
2.30.0.617.g56c4b15f3c-goog

