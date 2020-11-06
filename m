Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBA52A8DE3
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgKFD7r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgKFD7q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:59:46 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7B7C0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:59:46 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id i7so2929442pgh.6
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jwe/Ku04AbDt7NSH+PYmo4h0fXGuv0hcn0VSTzaPsGs=;
        b=qH/ukCIhfdtwo2k8qQUq48Zwf6oXSBUB/3xd9pFF44k7+6ng7B69jKXpyKW/1ujwn/
         qqg7dUaJtRMXagq6gNraxQpHcdIqAQkYpG0EzPec0S3JAeeoMiOsdQkxMx7hto6Kd+Rw
         AtlQpaks/cEyYYYsrIsUPD5LcUhVNKeeanXPwgbBpVLv+3teaVPT7qZpi5KgT/WkG8M0
         VbF6I47PsjKkDiKNxJLewgZ7Pyb/bjKg6sANM2Hf7+g/FANhOq3fBAe0rufPezNQrUBU
         dxvSMFExU15PUc7gs2ZSMA2suspyvwpCh8t6HVRBstaiD3sZzXhBn4ZxeXBYMhxZSvwE
         g2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jwe/Ku04AbDt7NSH+PYmo4h0fXGuv0hcn0VSTzaPsGs=;
        b=i/mNP9ukRdjOlf+LZ/H6ZBNQGyiQZQX7AouerqkA9+zeFP6nYtCFM85P3C7kk5A2JX
         ArJ6b4aQX08NZMvknmnP10l9cFWJVE0Z8mj6ld6gcgu3Pc8IarGmT1zRyaPPsuBuUtey
         WtYC+Iz/84kjcJBUse6psuF702PV2jknjMvsyuMVpoO8i4eVOCh/CU6iSpprvVEg7wf/
         O7F9WiOLoGGCvZaVfTpkMYGb+x2NCIp12bZXiAS6yRg0/ffNtCYPzxrdqxQ47fofyCRQ
         m88cgL1KroBHVXGMUTTTg161ILK5ZOXOKb229tsaBOUM8ZGdItqSo840dZXr1u+UxOoQ
         a0lQ==
X-Gm-Message-State: AOAM532BvS6XysMCzc6qib+zhn9aId62dq1zt4xV0goFyxryQDQNKiq6
        u4tpm7cZACvtA3qaAzBv27OJB04WHSA=
X-Google-Smtp-Source: ABdhPJzxzsovuG0MAwxken3uDX57VXxB8ovsGF23vrNXNndx3qDLQWJZ/sXH90x+7TkNfPDG6uqLAQ==
X-Received: by 2002:a63:6645:: with SMTP id a66mr45021pgc.207.1604635185903;
        Thu, 05 Nov 2020 19:59:45 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id z13sm3869429pgc.44.2020.11.05.19.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:59:44 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2 17/22] ext4: fix inode dirty check in case of fast commits
Date:   Thu,  5 Nov 2020 19:59:06 -0800
Message-Id: <20201106035911.1942128-18-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
References: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In case of fast commits, determine if the inode is dirty by checking
if the inode is on fast commit list. This also helps us get rid of
ext4_inode_info.i_fc_committed_subtid field.

Reported-by: Andrea Righi <andrea.righi@canonical.com>
Tested-by: Andrea Righi <andrea.righi@canonical.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h        | 3 ---
 fs/ext4/fast_commit.c | 3 ---
 fs/ext4/inode.c       | 3 +--
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 23f8edd4fb2a..e81104578015 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1028,9 +1028,6 @@ struct ext4_inode_info {
 					 * protected by sbi->s_fc_lock.
 					 */
 
-	/* Fast commit subtid when this inode was committed */
-	unsigned int i_fc_committed_subtid;
-
 	/* Start of lblk range that needs to be committed in this fast commit */
 	ext4_lblk_t i_fc_lblk_start;
 
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 05e6e76a7663..6b963e09af2c 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -152,7 +152,6 @@ void ext4_fc_init_inode(struct inode *inode)
 	INIT_LIST_HEAD(&ei->i_fc_list);
 	init_waitqueue_head(&ei->i_fc_wait);
 	atomic_set(&ei->i_fc_updates, 0);
-	ei->i_fc_committed_subtid = 0;
 }
 
 /* This function must be called with sbi->s_fc_lock held. */
@@ -1037,8 +1036,6 @@ static int ext4_fc_perform_commit(journal_t *journal)
 		if (ret)
 			goto out;
 		spin_lock(&sbi->s_fc_lock);
-		EXT4_I(inode)->i_fc_committed_subtid =
-			atomic_read(&sbi->s_fc_subtid);
 	}
 	spin_unlock(&sbi->s_fc_lock);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 87120c4c44f3..000bf70e88ed 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3312,8 +3312,7 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
 			EXT4_I(inode)->i_datasync_tid))
 			return false;
 		if (test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT))
-			return atomic_read(&EXT4_SB(inode->i_sb)->s_fc_subtid) <
-				EXT4_I(inode)->i_fc_committed_subtid;
+			return !list_empty(&EXT4_I(inode)->i_fc_list);
 		return true;
 	}
 
-- 
2.29.1.341.ge80a0c044ae-goog

