Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4E64D152C
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Mar 2022 11:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345980AbiCHKwg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Mar 2022 05:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345992AbiCHKw3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Mar 2022 05:52:29 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91467433B1
        for <linux-ext4@vger.kernel.org>; Tue,  8 Mar 2022 02:51:33 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v4so16804318pjh.2
        for <linux-ext4@vger.kernel.org>; Tue, 08 Mar 2022 02:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ksr2ssAIpAZ/GZjyqVmBOyXbfw3/aukQ2De9ZueXW/U=;
        b=VQTvssZ9izqd+4YdV+v1wU9lTmqK9s1NUCes6ic0Rj2NevAOItb9QaBdg5Amer9BIu
         Apjguw/yC7Uery9uRUeGI3/CRcbTSCU8LevjKOr1BIQAOXAZqWm7DCPFYUpeptguvmoU
         GhVS2UN3OmQyJCPX7XKTtQaCrRBeMrrV809eZ6LNmG5v23ITiFrOXEG0t6LnaVB+yV8V
         wxytAMMazgB2WxkUwk3RJ3nNBCWB3GnEMMjn4LUwgKUzDg4VJkfgM1Cf4cJMLx1sjz6J
         bWFLSAfxmC26MO1OVi3nSjZroCr/aEqV2cnK/tFgsqCPq6Fv91cg5Xd8rsL8A7+r0Mnk
         G8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ksr2ssAIpAZ/GZjyqVmBOyXbfw3/aukQ2De9ZueXW/U=;
        b=PafikORGGtzSkZGfBSxLjI85BU/vabDTxxDV6GO3aOFMfRYrT2y+6I951kxKIKL34s
         PCsOQW9dbqubIHf1B4QaG1UpBzRnxVW8UUT7uMYlU4xI1aqdz5uoIc+obbDQYXFZ8NBH
         jfegwZp5nmU42FJNBQLE2fFSMH6ecKnfHMYFx9fLdDVYe/x0Vb5FsJahVnjvhrxJXUNq
         vc58IglY41TvgAVPrlHLQ/5c9hWJg2R3Z45nnEfRqpwCxpw1kws6pmWiqC4BJgN16llU
         se849uasNk1Y4qoH1GNSiU/iCtWU8uQ6CfOFVtFcDCYepHSkUH8iHJlnPEX+DfgnsWfZ
         1a9A==
X-Gm-Message-State: AOAM5321lX1nRY9ZOQvDXrX+NGLrfosRu7CaWDfUbaoSX/ZUU1akXB7H
        h9r3YPt8DrcFn/FnYjESqPHPnVylcepRtgc+
X-Google-Smtp-Source: ABdhPJzMqlN/N4KlB+lQgBOcokE5VD9kOhbi9DCFS45XUhLqzYVM97V2EsPgs/QCyplPua6mdv70Uw==
X-Received: by 2002:a17:90a:a887:b0:1bc:388a:329f with SMTP id h7-20020a17090aa88700b001bc388a329fmr3973457pjq.17.1646736692463;
        Tue, 08 Mar 2022 02:51:32 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:c24c:d8e5:a9be:227])
        by smtp.googlemail.com with ESMTPSA id f6-20020a056a00228600b004f709f5f3c1sm6282040pfe.28.2022.03.08.02.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 02:51:31 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com, jack@suse.cz, tytso@mit.edu,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 5/5] ext4: update code documentation
Date:   Tue,  8 Mar 2022 02:51:12 -0800
Message-Id: <20220308105112.404498-6-harshads@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308105112.404498-1-harshads@google.com>
References: <20220308105112.404498-1-harshads@google.com>
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
index 831bb21dcb4f..c4e15898fbd4 100644
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

