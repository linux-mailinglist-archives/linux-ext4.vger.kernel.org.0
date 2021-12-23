Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1297347E8B9
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Dec 2021 21:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240669AbhLWUWA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Dec 2021 15:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245170AbhLWUV6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Dec 2021 15:21:58 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B00C061756
        for <linux-ext4@vger.kernel.org>; Thu, 23 Dec 2021 12:21:58 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p14so5184224plf.3
        for <linux-ext4@vger.kernel.org>; Thu, 23 Dec 2021 12:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XDOPbyMxtC7sEfaPrxp1SLCm0b4KwDAqI3rRsQjajHw=;
        b=gpAPA4SJAU4rSwUV7pZhdAyhT1jYCTudwHKoSashJA0r96wJlUt82LKs5j2uogQ3cx
         8DFgbqFpOb7Ibegn5LIozCpG1q58019/gZk2fcRtMARRemPiH3OG9l+jl7Kenrk6vRNw
         m8JM6pnGWxOG1yOmuyFgMOg7bIH3nklxAhkzopzyLo3ITRHrCvckjN6A+ocnPGCraFel
         SyTlVyxR40gpK3BEkJ07AQBHb3v3Dc8LrfenWwZryHKud/pLB/g81rEzAGBzz4PS8BBP
         WFBOpblv1XP0cmKQe0Jxt/1E4p4mr/8VrajxDd7INdpbUjW/KF/OSOsY4Qz0ychQG5He
         FPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XDOPbyMxtC7sEfaPrxp1SLCm0b4KwDAqI3rRsQjajHw=;
        b=LAYFOqwLFf9Ao1hNs0H44TJbPjHP1kWr8AsAo9sd9lQRut9D9k5Qhx62azJcrYFAKH
         r9bn+S3zykTLewTXenCWWkmR/nV+lR1zXj3sxRb0AUayXg4TsT6q/6DHv805VPzS9s/1
         B4Ai/tV8wfaS5Masvy3nHxnOmaB278oVri6NspfxbuE7g8admrTHYn2TdiTuYtsGZrr3
         /dS0ol8IZIvG1zpBtDDAa3AUqD7fN7/L0MGeQ7/FbMgSGJPC4r6t1QYHH9cktM9Hu/pn
         VgDSGqqBFxrvjo56GEYJE05uukbbiXGROn4CSGGw2UENbHbyWMjNnIpZ5Kz9Smia9Xb4
         6L8A==
X-Gm-Message-State: AOAM533FRy1KEgm9pDMK00rAsXbkDu0V0qg6KdWEZVPqoIJiicmp0X4i
        2C9lxJj4gw6oUqdAIf1OiAtBiivIKAk=
X-Google-Smtp-Source: ABdhPJxa4QMkcGoHQbaEoF6pO5hzNTbZ7A9vfonbcPhsoKzOuaAQ5JC/xv+yr0s3xKidZcPgzt1Eow==
X-Received: by 2002:a17:903:2350:b0:149:2efe:393a with SMTP id c16-20020a170903235000b001492efe393amr3854938plh.113.1640290917824;
        Thu, 23 Dec 2021 12:21:57 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:404a:8e2b:a329:bed6])
        by smtp.googlemail.com with ESMTPSA id lx8sm10351074pjb.18.2021.12.23.12.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 12:21:56 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 4/4] ext4: update fast commit TODOs
Date:   Thu, 23 Dec 2021 12:21:40 -0800
Message-Id: <20211223202140.2061101-5-harshads@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20211223202140.2061101-1-harshads@google.com>
References: <20211223202140.2061101-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

This series takes care of a couple of TODOs and adds new ones. Update
the TODOs section to reflect current state and future work that needs
to happen.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index a37384054c9e..dd002facf6c9 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -156,15 +156,13 @@
  *    fast commit recovery even if that area is invalidated by later full
  *    commits.
  *
- * 1) Make fast commit atomic updates more fine grained. Today, a fast commit
- *    eligible update must be protected within ext4_fc_start_update() and
- *    ext4_fc_stop_update(). These routines are called at much higher
- *    routines. This can be made more fine grained by combining with
- *    ext4_journal_start().
+ * 1) Fast commit's commit path locks the entire file system during fast
+ *    commit. This has significant performance penalty. Instead of that, we
+ *    should use ext4_fc_start/stop_update functions to start inode level
+ *    updates from ext4_journal_start/stop. Once we do that we can drop file
+ *    system locking during commit path.
  *
- * 2) Same above for ext4_fc_start_ineligible() and ext4_fc_stop_ineligible()
- *
- * 3) Handle more ineligible cases.
+ * 2) Handle more ineligible cases.
  */
 
 #include <trace/events/ext4.h>
-- 
2.34.1.307.g9b7440fafd-goog

