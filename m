Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A03D2A1A6F
	for <lists+linux-ext4@lfdr.de>; Sat, 31 Oct 2020 21:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgJaUFs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 31 Oct 2020 16:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbgJaUFr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 31 Oct 2020 16:05:47 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FF2C0617A6
        for <linux-ext4@vger.kernel.org>; Sat, 31 Oct 2020 13:05:47 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w11so4697737pll.8
        for <linux-ext4@vger.kernel.org>; Sat, 31 Oct 2020 13:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z37iS3+6ejDUSM4Nfe/6F81otAAFJM+4owduwLhvvU4=;
        b=FiTQONPuJl632bg9ktIOk5jpoeqqac7P53z6tT15kD1fbXGGIuLeDyt4MtFGuRbE4i
         +8ocGUKZCn58Ik6+Uv1BNtwRUE3NowpE2X7+nOhRrkdiR3IfIr9HYw6XwQcbTFJogUVi
         YdvglM302TmN7ba8KuZE8YKUkAmRADsKXH0fuN3l4l62kFOXSsZlH6JDpGx4XS6swX81
         I3lqKJCujUji5OF8BVv0X1Fcmeq3TjzYaKIy5VKlSV720fGDK7Sri1GEEnF9a9JoBaA/
         bCK/7Z51X7gRX7LuivquegrbA7/YUsug/sF4uuwBIKWoDnbf02+dTRsZiUhn0P7DxjUc
         lDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z37iS3+6ejDUSM4Nfe/6F81otAAFJM+4owduwLhvvU4=;
        b=N9Ms8HNBS+Nlf1tAzrHxnFvO9t1KonL1D9poL+rl8ieao6DDO96D88+O7V92L3Ke/B
         OTVezaf3bfn4ug8mb3zcZtOGwOpGXv5cjm6XFmMaxoTQTIoLO8pC6JAwUUmJHZGuZADD
         B4KRL1njpa+KYqcgn5o98VGtoGaGxHfpx0kgjdNWzls39wdDLTN+CfqcjjWJ+T1VVX2Z
         zXMLblnpSCSMrHzy2+ihrF8eZI6Svher/lSK8r98TgLOLaFVEFb9VtE9jV51YjvfKwyx
         JSmMy5Q/Y2csgWZQV2tFY/ukxFR2Ohd5vybtxvnr0KLjUOKJV8ssXeAQf+bpj6oGLSq6
         hhgA==
X-Gm-Message-State: AOAM532TOcFf5J1FXN9cw1CRLEc6N9mX8WyTeoztfSE6vCt4Nh/tVzpK
        t77vEw7kJqRPQc0FdM+srbYbjUJ2Xfg=
X-Google-Smtp-Source: ABdhPJx+6G3gRbN+0ToOx25qG+hgc/dDPWdglN39lKD9OlGqMuuTgbfT7I8fmjNrQ6x1duuK5IMUNg==
X-Received: by 2002:a17:902:7485:b029:d6:9c14:f376 with SMTP id h5-20020a1709027485b02900d69c14f376mr9409833pll.62.1604174747157;
        Sat, 31 Oct 2020 13:05:47 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id t15sm17177102pjq.3.2020.10.31.13.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 13:05:46 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 06/10] ext4: dedpulicate the code to wait on inode that's being committed
Date:   Sat, 31 Oct 2020 13:05:14 -0700
Message-Id: <20201031200518.4178786-7-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
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
 fs/ext4/fast_commit.c | 59 ++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 34 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index b1ca55c7d32a..0f2543220d1d 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -155,6 +155,28 @@ void ext4_fc_init_inode(struct inode *inode)
 	ei->i_fc_committed_subtid = 0;
 }
 
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
+	prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
+	spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
+	schedule();
+	finish_wait(wq, &wait.wq_entry);
+}
+
 /*
  * Inform Ext4's fast about start of an inode update
  *
@@ -176,22 +198,7 @@ void ext4_fc_start_update(struct inode *inode)
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
@@ -234,26 +241,10 @@ void ext4_fc_del(struct inode *inode)
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

