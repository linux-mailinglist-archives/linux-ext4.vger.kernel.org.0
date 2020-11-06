Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8582A8DDF
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgKFD7l (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgKFD7l (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:59:41 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48484C0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:59:41 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id x13so2928907pgp.7
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0WCR0myZmWLzn79EtZxHkg0PeRjnICWyXLz98JpoUvk=;
        b=lETZpOTdGzFDc+9Dgtt4OGb0He6cYhVytIhYWeUHLMJMVCaNsg8K8dw9mPlgvvrvdI
         TYXexq2YOxWo6Atq6Sc/OfYhHzMnGiiyuUJRMAuAu95GwI9nXGAfrOPP8pwVMc3rp5gz
         QEkUv8x33Pi8uAB5136LeeNdavprjO9/8S4AcHTzvpqsxu1jncXbqpqe7ng9ysvs4FKF
         trBsi2LVZqKN1UZnDuSc75VQ8pcQlvRxOB5uzDrcbTDTmOH3RTnXF07khUQQq6jl0ax/
         xqWJuq2xUBkqfb6fFiUU9nqzdMifLWmBGCHmyIuITG2FQqlVw9OyxqGh1XQtKu15m44R
         3mWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0WCR0myZmWLzn79EtZxHkg0PeRjnICWyXLz98JpoUvk=;
        b=bjOZ0832zQM75a7nMrLnqHl5aTzgH9Gg4PwY9JQlLWAi8lazJ5VNwW9XucseiZyts1
         z+ZeIc0yNpHzEj4ZZWGej7uZ6sbD/FtpnbDWbvCa5KfDLbVQBftCGzj9hnHJA6ZhEsWC
         Ca5vk5TNPR0PvxMpaYWN1kZx9Olq2qe/2n6rXW69SH88Ie0QYHFY0qTXycnJOqHaT6Uo
         j46+bz80zfxzg6tTmQd+NLphNfRJF5EU9X0I0XTLmThbYR8cenGsSGssFxKsEczo+ahk
         3oytfiNtktve8vTwUdlc2Aq3rTfkoc/V1hUe+K2DtbvXR1ggw2G9KhOw0cvgu4gbEX5T
         ePYw==
X-Gm-Message-State: AOAM530+2dggOmpuI/WiOET9ZbCcOv8YjgrtCd2fQEszDQN4BXaZwXNv
        PPffOpyeCtWwYLjL58h1vLPH9B98VuY=
X-Google-Smtp-Source: ABdhPJwW/ocnMJfTc/j2XxD7u4joFLhlB7qHnfFiVUMztLyuwSurbUSkfFLSXr9+3AkkX2Lj2KkSlA==
X-Received: by 2002:a17:90a:fd8d:: with SMTP id cx13mr288999pjb.138.1604635180467;
        Thu, 05 Nov 2020 19:59:40 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id z13sm3869429pgc.44.2020.11.05.19.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:59:39 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2 13/22] ext4: dedpulicate the code to wait on inode that's being committed
Date:   Thu,  5 Nov 2020 19:59:02 -0800
Message-Id: <20201106035911.1942128-14-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
References: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch removes the deduplicates the code that implements waiting
on inode that's being committed. That code is moved into a new
function.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c | 61 +++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 34 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index e69c580fa91e..fc5a5e6a581d 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -155,6 +155,30 @@ void ext4_fc_init_inode(struct inode *inode)
 	ei->i_fc_committed_subtid = 0;
 }
 
+/* This function must be called with sbi->s_fc_lock held. */
+static void ext4_fc_wait_committing_inode(struct inode *inode)
+{
+	wait_queue_head_t *wq;
+	struct ext4_inode_info *ei = EXT4_I(inode);
+
+#if (BITS_PER_LONG < 64)
+	DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
+			EXT4_STATE_FC_COMMITTING);
+	wq = bit_waitqueue(&ei->i_state_flags,
+				EXT4_STATE_FC_COMMITTING);
+#else
+	DEFINE_WAIT_BIT(wait, &ei->i_flags,
+			EXT4_STATE_FC_COMMITTING);
+	wq = bit_waitqueue(&ei->i_flags,
+				EXT4_STATE_FC_COMMITTING);
+#endif
+	lockdep_assert_held(&EXT4_SB(inode->i_sb)->s_fc_lock);
+	prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
+	spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
+	schedule();
+	finish_wait(wq, &wait.wq_entry);
+}
+
 /*
  * Inform Ext4's fast about start of an inode update
  *
@@ -176,22 +200,7 @@ void ext4_fc_start_update(struct inode *inode)
 		goto out;
 
 	if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
-		wait_queue_head_t *wq;
-#if (BITS_PER_LONG < 64)
-		DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
-				EXT4_STATE_FC_COMMITTING);
-		wq = bit_waitqueue(&ei->i_state_flags,
-				   EXT4_STATE_FC_COMMITTING);
-#else
-		DEFINE_WAIT_BIT(wait, &ei->i_flags,
-				EXT4_STATE_FC_COMMITTING);
-		wq = bit_waitqueue(&ei->i_flags,
-				   EXT4_STATE_FC_COMMITTING);
-#endif
-		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
-		spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
-		schedule();
-		finish_wait(wq, &wait.wq_entry);
+		ext4_fc_wait_committing_inode(inode);
 		goto restart;
 	}
 out:
@@ -234,26 +243,10 @@ void ext4_fc_del(struct inode *inode)
 	}
 
 	if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
-		wait_queue_head_t *wq;
-#if (BITS_PER_LONG < 64)
-		DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
-				EXT4_STATE_FC_COMMITTING);
-		wq = bit_waitqueue(&ei->i_state_flags,
-				   EXT4_STATE_FC_COMMITTING);
-#else
-		DEFINE_WAIT_BIT(wait, &ei->i_flags,
-				EXT4_STATE_FC_COMMITTING);
-		wq = bit_waitqueue(&ei->i_flags,
-				   EXT4_STATE_FC_COMMITTING);
-#endif
-		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
-		spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
-		schedule();
-		finish_wait(wq, &wait.wq_entry);
+		ext4_fc_wait_committing_inode(inode);
 		goto restart;
 	}
-	if (!list_empty(&ei->i_fc_list))
-		list_del_init(&ei->i_fc_list);
+	list_del_init(&ei->i_fc_list);
 	spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
 }
 
-- 
2.29.1.341.ge80a0c044ae-goog

