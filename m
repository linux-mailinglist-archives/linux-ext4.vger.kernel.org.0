Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427D0507697
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Apr 2022 19:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353834AbiDSRfB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Apr 2022 13:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354474AbiDSRez (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Apr 2022 13:34:55 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2BE393CD
        for <linux-ext4@vger.kernel.org>; Tue, 19 Apr 2022 10:32:12 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t12so16440658pll.7
        for <linux-ext4@vger.kernel.org>; Tue, 19 Apr 2022 10:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mDfOyvyhiWtyl6B1dMEKj0y27044TcELCrCOpYVq/uw=;
        b=clw64hdeDr8ODhCMWpeweiSpdCcrEB4/oxPLMAvGqiR/mx3TAmm0vBHvJlSo2vWhoc
         cYugobAZ0gPw0oPU/BTUnuHEMqO2jeGuIfcETj/97iFiqVyp207Qg94nKKkIKIU4g1pJ
         aoZqAjgSqTjnw5NV5uf55izLsbVr50xQBAzhS4zYqTSjsx8sJD1LH9uAmQmF0dWN6PHd
         oNvLRx94DSKff14qN9IRG/hofyjtfJtXZBUOeMwh7wqIsMddSHSQnwCncoA5FLbOOQRM
         B1GcSdPFeOGuWhvzSpadB49JNwP7Wa4LPGRD4eGCk84bq+GY6JRU8UZVN34cQxIO2CvI
         nJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDfOyvyhiWtyl6B1dMEKj0y27044TcELCrCOpYVq/uw=;
        b=ysaiwNQnsdeBUgDJYvGuDgpUi4PfVFq3RV3iXGqUndXIxuPFC9JcVp6TlNmLeliWMN
         k2ZHmFwiRnwPmWriOmBJHze5KYSzrtRmHBXCGFEQFW6DNHBDUMlarym8c+qoYC+P21FH
         V5p1o4+q3anAIPCwYu/Tiv8bMSGIrwfM5NsXGeuo8c+UFl3uW0/p2Lb3XkKDr6OxDbar
         BtBtyzUG/5jwkOBkHbU4NESE9aM0PU3vbHSoDeL+bfB/XWjxMebyOO0oFgyMxChh+kUk
         fsyq0la0ZipUWzQyjxhRkERvudsrrksduSL07qqxN7LpsVOZ+f1FI4Gpri7qRcUWDu1T
         ZaIQ==
X-Gm-Message-State: AOAM532OmLk8likXkUUI2691kxH90o/MP/DwHx3BS37V8BGQVDfSH2gT
        Q0en9YmoslN9q3tnqEsGKHFtZf5wfqo+tQ==
X-Google-Smtp-Source: ABdhPJzdd4LJhBeJnEiCCMbhA8mzqneid0Li6d8ME1vXCzWbengqI1LlcbQinlpCD0DSN0Ua65kaCw==
X-Received: by 2002:a17:90b:4a41:b0:1d2:a83c:e480 with SMTP id lb1-20020a17090b4a4100b001d2a83ce480mr10394208pjb.18.1650389531210;
        Tue, 19 Apr 2022 10:32:11 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:91ac:bc24:f886:dffc])
        by smtp.googlemail.com with ESMTPSA id q9-20020a638c49000000b00398677b6f25sm17266093pgn.70.2022.04.19.10.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 10:32:10 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com, jack@suse.cz, tytso@mit.edu,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 6/6] ext4: update code documentation
Date:   Tue, 19 Apr 2022 10:31:43 -0700
Message-Id: <20220419173143.3564144-7-harshads@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220419173143.3564144-1-harshads@google.com>
References: <20220419173143.3564144-1-harshads@google.com>
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
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/fast_commit.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 266c95ff0d74..1691cfd89954 100644
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
@@ -156,13 +170,12 @@
  *    fast commit recovery even if that area is invalidated by later full
  *    commits.
  *
- * 1) Fast commit's commit path locks the entire file system during fast
- *    commit. This has significant performance penalty. Instead of that, we
- *    should use ext4_fc_start/stop_update functions to start inode level
- *    updates from ext4_journal_start/stop. Once we do that we can drop file
- *    system locking during commit path.
+ * 1) Handle more ineligible cases.
  *
- * 2) Handle more ineligible cases.
+ * 2) Change ext4_fc_commit() to lookup logical to physical mapping using extent
+ *    status tree. This would get rid of the need to call ext4_fc_track_inode()
+ *    before acquiring i_data_sem. To do that we would need to ensure that
+ *    modified extents from the extent status tree are not evicted from memory.
  */
 
 #include <trace/events/ext4.h>
-- 
2.36.0.rc0.470.gd361397f0d-goog

