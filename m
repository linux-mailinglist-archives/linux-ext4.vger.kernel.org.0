Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F215476B60
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Dec 2021 09:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhLPIEp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Dec 2021 03:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbhLPIEp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Dec 2021 03:04:45 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCDEC061574
        for <linux-ext4@vger.kernel.org>; Thu, 16 Dec 2021 00:04:44 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id z6so18835740plk.6
        for <linux-ext4@vger.kernel.org>; Thu, 16 Dec 2021 00:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KbVNZb8nETgEP9SUDrzW1/+fQmxBSouz/pw4zYKxPwI=;
        b=scFPB1A9UBmjQMxjJlhKtDisB7+I3WWz6srrVQ0fyHzbUPG+uVPWpduqfMH+IBn/jG
         +R2Q8ds6stvMHpXOPlcUStCAy8mky7NB/BUBqzW37KEqNNCpkJnOg/LKJGrveMtYrEHu
         R9nzGD3nsta/HOr7rPaPfR2E1D/8dPpsmG/WmZlZAf7oVWoNY7vtXCe8zSGBp9i2EZPt
         h+2Pc7m6zo66/sCs0owRf3ta7utg6VJmMLGYiYxJBIwFRgjch4tj9MzhlHKmGB0nr5ql
         XBJnc7tmMbyTDb3amcb/6p+Q5cgGshJhNBOmNpBmxE8FrU/Gk6zQBDrJ425QZwB8GcE1
         a/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KbVNZb8nETgEP9SUDrzW1/+fQmxBSouz/pw4zYKxPwI=;
        b=SWmqcaLA/JNQVE/jt+GEf1WCAVl7v3yyEqI/wa63TrSnOouozADEvLW31DmqMgrs6i
         A+rroieYQtcK4hXJiAEhLudCobPrfpjWOLUHtuuWNCEOVcBQuoJ+32GoNEBtrw6BZgWg
         U+ZY0zr+PfHtoo+oOzO73ODsyXBSJR7cQlRwkKdjlRta69sTbrW/3hvJe0j3cBtP4ews
         Z2iHGF6yj4lR/IqER5mDokEnLwgv2k3dkybi1gx5ZEp5cMbHEtARU8xxerosAZZWLVPP
         CLW8VC3w6y6Y14dbPSwFbAzUkMb0bTdT3xhDk02G9vq5WNtEAtSYIvLSrDcJGW5vG7aE
         JzXQ==
X-Gm-Message-State: AOAM5315Nz7sWqPuo3n8ep61PMcJj7mucy/ahqHYEJ2g3eK7GhnVSdg1
        3j4p4YxY8db+v54ObZWG+aF2iQ==
X-Google-Smtp-Source: ABdhPJzkURPZLlj6lEar7+1Ha9sHqNt/dAh2p3LKqzvyurqxO6/vELgPHZ9foTTWY+AYL3tu2a4ebQ==
X-Received: by 2002:a17:902:6b07:b0:142:852a:9e1f with SMTP id o7-20020a1709026b0700b00142852a9e1fmr15021455plk.29.1639641884160;
        Thu, 16 Dec 2021 00:04:44 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id g22sm5624026pfj.29.2021.12.16.00.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 00:04:43 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH] ext4: call fallocate may cause process to hang when using fast commit
Date:   Thu, 16 Dec 2021 16:03:03 +0800
Message-Id: <20211216080303.388139-1-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If open a file with O_SYNC, and call fallocate with mode=0.when using
fast commit, will cause the process to hang.

During the fast_commit procedure, it will wait for inode update done.
call ext4_fc_stop_update() before ext4_fc_commit() to mark inode
complete update.

Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
 fs/ext4/extents.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 4108896d471b..92db33887b6c 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4707,8 +4707,12 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		goto out;
 
 	if (file->f_flags & O_SYNC && EXT4_SB(inode->i_sb)->s_journal) {
+		ext4_fc_stop_update(inode);
 		ret = ext4_fc_commit(EXT4_SB(inode->i_sb)->s_journal,
 					EXT4_I(inode)->i_sync_tid);
+		inode_unlock(inode);
+		trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
+		return ret;
 	}
 out:
 	inode_unlock(inode);
-- 
2.20.1

