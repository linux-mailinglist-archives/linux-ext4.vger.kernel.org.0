Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BFB4D1D46
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Mar 2022 17:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348358AbiCHQeo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Mar 2022 11:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348368AbiCHQem (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Mar 2022 11:34:42 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AEA427E9
        for <linux-ext4@vger.kernel.org>; Tue,  8 Mar 2022 08:33:42 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id g1so17792963pfv.1
        for <linux-ext4@vger.kernel.org>; Tue, 08 Mar 2022 08:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pbuYz6YiXIlLZzGmxXWhYRCymgIoYaOBHIs/RHlGFUU=;
        b=MR90+yIpeyeMBPzb3Zwqfw3IrbPmquz7FmHvIr4nSAMAs2+LKs94TXtnRfUeoZQxSB
         jMfJJ2znHLbVivjNV6QqcrfLuyXLzcsvDg1mUlCZskfDS6tV7l2vrEKwq0pz3q8QDVpH
         CgOU9gOxOYeLegahb6dmL5Vq1Hc8Wq9tUXpmizrQwrGoG2DfQPkexw9gZwx/kqo2h/DF
         AHhMoNQN9jKuUrvCKFqtrh43jmYsT/rqfsZMQF259ce+igvz9QhqJPN4QA2g00wJK4L/
         HOazZYKC6WhfQ+vmmilZd8tI/guQqt82CveeQBqvZbyYh4flokrIQOQ9JdJmeWJ2DuBF
         Pw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pbuYz6YiXIlLZzGmxXWhYRCymgIoYaOBHIs/RHlGFUU=;
        b=yj/B/h0k+vgL7nvU/ICLNTNRglcgLzlVxGpAVUHBijhcIDIQhTepgK+r7g+xeuUQDz
         rxTZlCEUPbD5Cf3SoPnBf0jDdORVv437Jij7wnVEexyTxPEbU7WZ/B3f0PpHBUYRBMDX
         4lue+sCGku5pXTWR7zFDqzP7HwZtu1gycSJM/HKub+toB6inKFr1HJXWt+69AUV6WYmo
         fFcsf9cH4tJIWvdJMVbiDBb9OXnoiYWmNkyM5yC1smr3PRHXULv2kp8GFLeLz73MYo0J
         Nz/Fg1XeGiyhOK/PhRS8ZBvj/jS8HWrqmzt7pZtSLfNyWVRER9HbEu9o+0IYm49Hp9yX
         wZSA==
X-Gm-Message-State: AOAM532zaIIA3+MAjx30Qry0fwUUeDdKJ7u+CPeSH07qJGEP8s5LzVoh
        mOEZ8Ezkix5iV8UhbMiVtLv9nM+pRHtLsCDJ
X-Google-Smtp-Source: ABdhPJxFsd9TLxFY3Ezyg5P3vp4T8fSgHQlKj4uECK8tlxEw8vDmaXdOIxHKQEzJKtmfpxy9tdu/WA==
X-Received: by 2002:a63:b21:0:b0:372:f0e9:50b9 with SMTP id 33-20020a630b21000000b00372f0e950b9mr14572250pgl.566.1646757221002;
        Tue, 08 Mar 2022 08:33:41 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:c24c:d8e5:a9be:227])
        by smtp.googlemail.com with ESMTPSA id m8-20020a17090a158800b001bf2cec0377sm4517720pja.3.2022.03.08.08.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 08:33:39 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com, jack@suse.cz, tytso@mit.edu,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 5/5] ext4: update code documentation
Date:   Tue,  8 Mar 2022 08:33:19 -0800
Message-Id: <20220308163319.1183625-6-harshads@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308163319.1183625-1-harshads@google.com>
References: <20220308163319.1183625-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

This patch updates code documentation to reflect the commit path changes
made in this series.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index eea19e3ea9ba..c14e6d34d552 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -49,14 +49,21 @@
  * that need to be committed during a fast commit in another in memory queue of
  * inodes. During the commit operation, we commit in the following order:
  *
- * [1] Lock inodes for any further data updates by setting COMMITTING state
- * [2] Submit data buffers of all the inodes
- * [3] Wait for [2] to complete
- * [4] Commit all the directory entry updates in the fast commit space
- * [5] Commit all the changed inode structures
- * [6] Write tail tag (this tag ensures the atomicity, please read the following
+ * [1] Lock the journal by calling jbd2_journal_lock_updates. This ensures that
+ *     all the exsiting handles finish and no new handles can start.
+ * [2] Mark all the fast commit eligible inodes as undergoing fast commit
+ *     by setting "EXT4_STATE_FC_COMMITTING" state.
+ * [3] Unlock the journal by calling jbd2_journal_unlock_updates. This allows
+ *     starting of new handles. If new handles try to start an update on
+ *     any of the inodes that are being committed, ext4_fc_track_inode()
+ *     will block until those inodes have finished the fast commit.
+ * [4] Submit data buffers of all the committing inodes.
+ * [5] Wait for [4] to complete.
+ * [6] Commit all the directory entry updates in the fast commit space.
+ * [7] Commit all the changed inodes in the fast commit space and clear
+ *     "EXT4_STATE_FC_COMMITTING" for these inodes.
+ * [8] Write tail tag (this tag ensures the atomicity, please read the following
  *     section for more details).
- * [7] Wait for [4], [5] and [6] to complete.
  *
  * All the inode updates must call ext4_fc_start_update() before starting an
  * update. If such an ongoing update is present, fast commit waits for it to
@@ -142,6 +149,13 @@
  * similarly. Thus, by converting a non-idempotent procedure into a series of
  * idempotent outcomes, fast commits ensured idempotence during the replay.
  *
+ * Locking
+ * -------
+ * sbi->s_fc_lock protects the fast commit inodes queue and the fast commit
+ * dentry queue. ei->i_fc_lock protects the fast commit related info in a given
+ * inode. Most of the code avoids acquiring both the locks, but if one must do
+ * that then sbi->s_fc_lock must be acquired before ei->i_fc_lock.
+ *
  * TODOs
  * -----
  *
@@ -156,13 +170,7 @@
  *    fast commit recovery even if that area is invalidated by later full
  *    commits.
  *
- * 1) Fast commit's commit path locks the entire file system during fast
- *    commit. This has significant performance penalty. Instead of that, we
- *    should use ext4_fc_start/stop_update functions to start inode level
- *    updates from ext4_journal_start/stop. Once we do that we can drop file
- *    system locking during commit path.
- *
- * 2) Handle more ineligible cases.
+ * 1) Handle more ineligible cases.
  */
 
 #include <trace/events/ext4.h>
-- 
2.35.1.616.g0bdcbb4464-goog

