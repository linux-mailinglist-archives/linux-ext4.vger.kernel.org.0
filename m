Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6692A8DE0
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgKFD7n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgKFD7m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:59:42 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8847C0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:59:42 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id t22so47152plr.9
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3IcyYOcaSosD0gvb90SB7f2p/tRWOSa7pkWZ526W3rs=;
        b=cNxSCa0brVl4CL91zpBQTGP33eHSpY7Tql7O4HT+vtqe1vsCOUcac4j+fVuUZhlVzZ
         dINCdAWeY2AKJe9JWtd2h9dq5bKBZV8G7t5KCm0Wi8p+Cy76jyEkwZ+g44RoM5uki03Q
         5mLZ6vZ6EtFI8Rdyk5Z81N0D+6EGF5W/YGIu1ZiolK/uKeguI3pLrlmUGb3gGnO7eSSF
         6jxPO9FPaiyTkQOFgLl1TmMAeG4jDFeayOiZyohge+ixFYYOl7Zi+zFEcuNipjB4GISX
         mFwvosb1sn1wn26VuTnvRquv6EFbQ/88jTOk0rAHtqpGnFL4nOQWbyl2jObnENz8rjuT
         lk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3IcyYOcaSosD0gvb90SB7f2p/tRWOSa7pkWZ526W3rs=;
        b=W90lWjk9O2xKGdsybG2wMDo8KtMkIypbLwVUClevivhSVEHYnNXBfVUi6bXulrOHJX
         8bFkZjos31Xpfe4m3bxYGwkYYHXExwCcZFqyGUkILnwJVSYmjKE+6edZRBHbUv9T8ibh
         I9gd75N6mDJiHJewpg9ZfYX//se/PozAwnvIJOeyD0NXhlNPCHqsk+2ggPu02Qt+dkNT
         Gj/pv7kNGEhFD2HZgKRnp6IdXTx+9dUqX0q7PlMOR1o1wq41UZnUNxDfHhXgwXdPK8y1
         kwkh+zni4YVz1wrAp6tvFpLEE5oDZwDH36Jdj/X2VTtmdAg2v6bNDMT9QoOt9YpdtaD2
         setA==
X-Gm-Message-State: AOAM533FxwuCjihUpdcXIpThkdiS4cgFDz3eqeB0rdFzDRJSVgxzL2UJ
        XnZ3He0ZDKmTuWS0C/2RLOeI6ZCxp8A=
X-Google-Smtp-Source: ABdhPJy/PIcTrVlONJNK6aS0pCGQ32g7XVKeVRzDy6uu4s24Z8IaBAgrOE5a7sH5pcG77iF/BS4Npw==
X-Received: by 2002:a17:902:780f:b029:d6:3413:9fe8 with SMTP id p15-20020a170902780fb02900d634139fe8mr207227pll.46.1604635181979;
        Thu, 05 Nov 2020 19:59:41 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id z13sm3869429pgc.44.2020.11.05.19.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:59:40 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 14/22] ext4: fix code documentatioon
Date:   Thu,  5 Nov 2020 19:59:03 -0800
Message-Id: <20201106035911.1942128-15-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
References: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add a TODO to remember fixing REQ_FUA | REQ_PREFLUSH for fast commit
buffers. Also, fix a typo in top level comment in fast_commit.c

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index fc5a5e6a581d..639b2a308c7b 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -83,7 +83,7 @@
  *
  * Atomicity of commits
  * --------------------
- * In order to gaurantee atomicity during the commit operation, fast commit
+ * In order to guarantee atomicity during the commit operation, fast commit
  * uses "EXT4_FC_TAG_TAIL" tag that marks a fast commit as complete. Tail
  * tag contains CRC of the contents and TID of the transaction after which
  * this fast commit should be applied. Recovery code replays fast commit
@@ -542,6 +542,7 @@ static void ext4_fc_submit_bh(struct super_block *sb)
 	int write_flags = REQ_SYNC;
 	struct buffer_head *bh = EXT4_SB(sb)->s_fc_bh;
 
+	/* TODO: REQ_FUA | REQ_PREFLUSH is unnecessarily expensive. */
 	if (test_opt(sb, BARRIER))
 		write_flags |= REQ_FUA | REQ_PREFLUSH;
 	lock_buffer(bh);
-- 
2.29.1.341.ge80a0c044ae-goog

