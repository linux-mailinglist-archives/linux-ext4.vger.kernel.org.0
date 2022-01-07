Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D29487780
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jan 2022 13:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbiAGMNC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Jan 2022 07:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238672AbiAGMNB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Jan 2022 07:13:01 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706EFC061212
        for <linux-ext4@vger.kernel.org>; Fri,  7 Jan 2022 04:13:01 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id iy13so5046981pjb.5
        for <linux-ext4@vger.kernel.org>; Fri, 07 Jan 2022 04:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kkz8YJPT1Rn3gUG9xOxi88tjjNI6xlZ3k9kteXJdpzg=;
        b=dR8EfmELbJPnDjmtbSu1v99qKzD39qDf+marFqjMINH4hs2A9ve8er6+0ODrnhRHxd
         a1Q0h02meZL5DUYc9qEzmMPMj/m4FYmXLSBHej6KLzQdUq3SZvl70XjU/WPNuzLyWzYe
         IkZBoQBQtha5/SpCcuVV4G4NrzX9GzrlIthwkaxMg40hUqdPLah3DSSceSbcX+zZNHOL
         RdiLRIkEm7G/bEXbPFt70m3ciB6INFTjC4rTLmnIj2Z2u8hNUIiXC37vkHZOzFXWsF4G
         K51I7MZC2PL5T67dPndmQ+Ja00boC5IRrkrDwBMo5pRhw2vld7t8k+h0Nkg4D/UMTwl+
         fjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kkz8YJPT1Rn3gUG9xOxi88tjjNI6xlZ3k9kteXJdpzg=;
        b=owNZBce5jeB54+oFPY2E40lKejB2dMc517C7smcl+7VJzonkwyXytUEADyDuDn3e3a
         WzJFsFAwaKxdexvG5VtJ0cE/iu0DCS9RWKK2iC6C2uAMnliNMwRwxxmtbsFRmmFOFvkm
         op+TdR9eXDX2o3RKsbhDJcGRXdnDbT0ggIUnubr50wNwSreSnfOt4j4rgR2zGMm6z30E
         JULZW5ONozr6/zJRtmVbZmSNZpY7WAgP3dKrQzrfzR2Ych8J1aYjjlHBDEFrcYgPwdrI
         8WdXuUSfF8R1tOjhtuIhcKIRdpir7vX63pFJ+7EyYTeEtlM8DWGVgrrb8txHjI+A3nMv
         T6gw==
X-Gm-Message-State: AOAM530bIG7+E2IFJc8nOWh6AM2koOCmZzGBTEwCmWvUUqmRszWUjSuw
        Z7rej+UjA35NGsPEJ5Je1VlbMw==
X-Google-Smtp-Source: ABdhPJxj5dCLi5rqa/ivDkZrwleU1gkvFcwudBv/qF4sXMKIHdbutNF47tvP67Dnpl6KCs9GBrIfjQ==
X-Received: by 2002:a17:90b:1c91:: with SMTP id oo17mr15437087pjb.58.1641557580984;
        Fri, 07 Jan 2022 04:13:00 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id h1sm5888137pfi.109.2022.01.07.04.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 04:13:00 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH 2/2] ext4: fast commit may miss file actions
Date:   Fri,  7 Jan 2022 20:12:15 +0800
Message-Id: <20220107121215.1912-3-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107121215.1912-1-yinxin.x@bytedance.com>
References: <20220107121215.1912-1-yinxin.x@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

in the follow scenario:
1. jbd start transaction n
2. task A get new handle for transaction n+1
3. task A do some actions and add inode to FC_Q_MAIN fc_q
4. jbd complete transaction n and clear FC_Q_MAIN fc_q
5. task A call fsync

fast commit will lost the file actions during a full commit.

we should also add updates to staging queue during a full commit.
and in ext4_fc_cleanup(), when reset a inode's fc track range, check
it's i_sync_tid, if it bigger than current transaction tid, do not
rest it, or we will lost the track range.

Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
 fs/ext4/fast_commit.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 3673d4798af3..4cea92aec7c4 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -365,7 +365,8 @@ static int ext4_fc_track_template(
 	spin_lock(&sbi->s_fc_lock);
 	if (list_empty(&EXT4_I(inode)->i_fc_list))
 		list_add_tail(&EXT4_I(inode)->i_fc_list,
-				(ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_COMMITTING)) ?
+				(sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
+				 sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING) ?
 				&sbi->s_fc_q[FC_Q_STAGING] :
 				&sbi->s_fc_q[FC_Q_MAIN]);
 	spin_unlock(&sbi->s_fc_lock);
@@ -418,7 +419,8 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 	node->fcd_name.len = dentry->d_name.len;
 
 	spin_lock(&sbi->s_fc_lock);
-	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_COMMITTING))
+	if (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
+		sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING)
 		list_add_tail(&node->fcd_list,
 				&sbi->s_fc_dentry_q[FC_Q_STAGING]);
 	else
@@ -1202,7 +1204,8 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 		list_del_init(&iter->i_fc_list);
 		ext4_clear_inode_state(&iter->vfs_inode,
 				       EXT4_STATE_FC_COMMITTING);
-		ext4_fc_reset_inode(&iter->vfs_inode);
+		if (iter->i_sync_tid <= tid)
+			ext4_fc_reset_inode(&iter->vfs_inode);
 		/* Make sure EXT4_STATE_FC_COMMITTING bit is clear */
 		smp_mb();
 #if (BITS_PER_LONG < 64)
-- 
2.20.1

