Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B806A2AA67E
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Nov 2020 16:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgKGP6v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Nov 2020 10:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgKGP6t (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Nov 2020 10:58:49 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7216FC0613CF
        for <linux-ext4@vger.kernel.org>; Sat,  7 Nov 2020 07:58:47 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id oc3so945380pjb.4
        for <linux-ext4@vger.kernel.org>; Sat, 07 Nov 2020 07:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SaUx96VUhaTpzSCRpCpRjcp0sUfE4sJlXfupVTrZ5Jg=;
        b=VwyvrD9bhzm4fBzMUD/ytS9sekUljXtP7EzsZ1e7g+hiz4JpS6f/xDL4GpirziW9H2
         Ss/3toiEvgcqemsK3luHuQjS80J2MSwSecqudGMD3pZxtHjgSu97g6TbTqZgUhM9oPCc
         RCDyUwS31xt1VufCeOZPFEj4qzildJQer/aGpgDdGXJ+TxlOzVw7LMu1XCz/zTw5Iug7
         Iit4hldlem7g3OOEPrrf1qxiL3n/BQiNPcdTVZY62L/F5d9JxEdKKBs6eWgGEkHdKhlk
         lYEuPa+1X1E9vv0UQRZBk3dVKzWutYfs4b5/MryUs0+M6eqcq/GK6dpYBgd/V4aIBLX8
         Fszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SaUx96VUhaTpzSCRpCpRjcp0sUfE4sJlXfupVTrZ5Jg=;
        b=SuhHhGZGAd89ABB7X502SWVSu9WNtv7BnpAYSrEUcOPj1qzZs9Zh6s8gTP2yAX7y6s
         2ONWWLL2HVOJenBmsdzEZdIK8ySvIlct1LelgQLOJ6TkfJzAW0h2KBMLOwO9uZb8F93E
         scKlb28917euI2u4pHTeq9llYwVdnVJ+FLARy+gnLsYZ26cidDjym9zfX6IN00jYRoDt
         BjsOsENEyEi7ibpWnPqpnQNU8MD63o/IKoho/LNY0hSlLw9YgVv/mF5SGiBZDPua+84Z
         hLHL+ZcFZcL26e52+iknQ30ao/MPpIVD2cf3GD17+GyjBNcpMLovJ2ghOFvaXkk6WPXm
         BjHw==
X-Gm-Message-State: AOAM5327ehesQ13Mx8JhtVHop+4ACSQGKYQ08LFM6n+1Gw5l7gLIiOP5
        MeVjE/LqCpiJwWgWKd+R7mCYoIjKACI=
X-Google-Smtp-Source: ABdhPJwAfFIN4gSLjqk3JYzIx2Mdk+NQ+xdd+vhJ7t9DA90rEVphOy7A6FpW1fQkHoQedkyXkZlYzg==
X-Received: by 2002:a17:90a:1b84:: with SMTP id w4mr4718275pjc.65.1604764727114;
        Sat, 07 Nov 2020 07:58:47 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id e81sm6049956pfh.104.2020.11.07.07.58.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2020 07:58:46 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH RESEND 5/8] ext4: update ext4_data_block_valid related comments
Date:   Sat,  7 Nov 2020 23:58:15 +0800
Message-Id: <1604764698-4269-5-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
References: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Since ext4_data_block_valid() has been renamed to ext4_inode_block_valid(),
the related comments need to be updated.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 fs/ext4/block_validity.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 37025e3..07e9dc3 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -206,7 +206,7 @@ static void ext4_destroy_system_zone(struct rcu_head *rcu)
  *
  * The update of system_blks pointer in this function is protected by
  * sb->s_umount semaphore. However we have to be careful as we can be
- * racing with ext4_data_block_valid() calls reading system_blks rbtree
+ * racing with ext4_inode_block_valid() calls reading system_blks rbtree
  * protected only by RCU. That's why we first build the rbtree and then
  * swap it in place.
  */
@@ -262,7 +262,7 @@ int ext4_setup_system_zone(struct super_block *sb)
 
 	/*
 	 * System blks rbtree complete, announce it once to prevent racing
-	 * with ext4_data_block_valid() accessing the rbtree at the same
+	 * with ext4_inode_block_valid() accessing the rbtree at the same
 	 * time.
 	 */
 	rcu_assign_pointer(sbi->s_system_blks, system_blks);
@@ -282,7 +282,7 @@ int ext4_setup_system_zone(struct super_block *sb)
  *
  * The update of system_blks pointer in this function is protected by
  * sb->s_umount semaphore. However we have to be careful as we can be
- * racing with ext4_data_block_valid() calls reading system_blks rbtree
+ * racing with ext4_inode_block_valid() calls reading system_blks rbtree
  * protected only by RCU. So we first clear the system_blks pointer and
  * then free the rbtree only after RCU grace period expires.
  */
-- 
1.8.3.1

