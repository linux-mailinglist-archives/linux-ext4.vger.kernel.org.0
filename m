Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AA22A1A73
	for <lists+linux-ext4@lfdr.de>; Sat, 31 Oct 2020 21:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgJaUFz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 31 Oct 2020 16:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbgJaUFu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 31 Oct 2020 16:05:50 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FF4C0617A7
        for <linux-ext4@vger.kernel.org>; Sat, 31 Oct 2020 13:05:50 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id x13so7641878pgp.7
        for <linux-ext4@vger.kernel.org>; Sat, 31 Oct 2020 13:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dxEat/0LE9d8rSaGyb+4vgvDFg/G5eUmBGJ9C+NdKBM=;
        b=L5tiJ8b8FV+5sROuVU7g/RR1h9+QbMW9ogMBHdWAj3O9KGHF0Oh4VeP1v6T506P5j5
         LehJgwwKx5y5mzWoko2li+l2oifUWpxUY2soAa0KUIbCypE7DBhuJdk1YLsj5Tpxefs3
         PD8kyb90Cf2lfbBwbs3cVK1qLJSlwWClodJFzqwOH3zVDrdtFaZiAkx5FWQLmLyiwHip
         6DRmcuOaWGg8owNXyNYDOB930IjuTb2bVItOF0NXuHaT65l1c7NDU6vuHp9i7w26ioqz
         olf6BQju+kes4F/K7oz64CLY8wwlgAnjJwQvH99MSjzYHdZiQaOjboYaISAq2QH/12LT
         8HsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dxEat/0LE9d8rSaGyb+4vgvDFg/G5eUmBGJ9C+NdKBM=;
        b=cJGYQNVbdn6QzvYkDJ/ECqZtt3+IwzfKa5Lo6zOBPptdVXv925FeP9Wj/p/ShTN1fS
         9sAFYz99PG4i+8mQ9e011PXgr8hHgUhDx6zqhbYSDmJywjChj21Ex6MjBJUfO2EZnOKX
         keV2wCY3fUdLO5Wn5xabXoUfAJ+yQoD3090yB/58pvnAw4IF4zo+1Tdk1bYJDBeBLPgh
         xcXbq4ZyhgmdFeSoETjri9LoVsnXjHAB7MfIY/VXCuAgAdTCMagrpr/RI/eXJOp5CoCR
         oXLGjs4KBJxhOu8XnTTuPWEZmyIQBFBm5evhKBR43ymUovpQwDkcgYD8UN3AGcGJiznp
         Vpkg==
X-Gm-Message-State: AOAM533H7ryv5CUULp730+BJEM8IzEmEsxzKoaF24qXu0EZG8FS5tMUH
        qg/tAD5BLRwy0c4MqpBnOOLbiY8icgM=
X-Google-Smtp-Source: ABdhPJzHovx4vNOUnHW1vYErBTW/zeQ3hkP2FFixAwtKiy1wtzXJg1rAygqT2wWgMqiZSkhZB6embQ==
X-Received: by 2002:a63:c40c:: with SMTP id h12mr7333063pgd.28.1604174749853;
        Sat, 31 Oct 2020 13:05:49 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id t15sm17177102pjq.3.2020.10.31.13.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 13:05:48 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andrea Righi <andrea.righi@canonical.com>
Subject: [PATCH 08/10] ext4: fix inode dirty check in case of fast commits
Date:   Sat, 31 Oct 2020 13:05:16 -0700
Message-Id: <20201031200518.4178786-9-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In case of fast commits, determine if the inode is dirty by checking
if the inode is on fast commit list. This also helps us get rid of
ext4_inode_info.i_fc_committed_subtid field.

Reported-by: Andrea Righi <andrea.righi@canonical.com>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h        | 3 ---
 fs/ext4/fast_commit.c | 3 ---
 fs/ext4/inode.c       | 3 +--
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 573db158382f..7222a9ba5d66 100644
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
index b7b1fe6dbb24..4c0a3e858ea3 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -152,7 +152,6 @@ void ext4_fc_init_inode(struct inode *inode)
 	INIT_LIST_HEAD(&ei->i_fc_list);
 	init_waitqueue_head(&ei->i_fc_wait);
 	atomic_set(&ei->i_fc_updates, 0);
-	ei->i_fc_committed_subtid = 0;
 }
 
 static void ext4_fc_wait_committing_inode(struct inode *inode)
@@ -1026,8 +1025,6 @@ static int ext4_fc_perform_commit(journal_t *journal)
 		if (ret)
 			goto out;
 		spin_lock(&sbi->s_fc_lock);
-		EXT4_I(inode)->i_fc_committed_subtid =
-			atomic_read(&sbi->s_fc_subtid);
 	}
 	spin_unlock(&sbi->s_fc_lock);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 7f6af784e74f..d36c3908272f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3311,8 +3311,7 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
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

