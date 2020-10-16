Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD17728FD08
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Oct 2020 05:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394330AbgJPD4O (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 23:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394324AbgJPD4I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Oct 2020 23:56:08 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B512C061755
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 20:56:08 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id j8so676931pjy.5
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 20:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/+nRZRg1osfRYD9wIlSKjZkJRaed31ccSuUL9TKtMjI=;
        b=QmbF8YPlMh+md2fPeAiQmSVZbJC6KcPij/C/i/25MNz+ghkdFOtOX+LGEqv6OHBRqG
         ODh9GpNUu/RaRntvlmRgFKVne+s/ipZMazy+y9A+gkiAzp1T3DCRkmNVBr0VW7ty1nka
         LF/2AcaA4BNJA9uTdEValiOd3c27wudpH6st9C6GVSqgZIFL/6pvnlL9yNbD5DkaOWea
         6STUDrCR2XfMzjWC5ZXKffV8uelkqmlz2Wpkw9rUjavxSkLSlIioldlhMpgF0ypHdttE
         F4nQQ4lSSvwW4mg7EGZhi54TWABF0mqwGwx+LqpGnL8hc1RoGyv0NeTsL7jZ9LHExDCr
         hrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/+nRZRg1osfRYD9wIlSKjZkJRaed31ccSuUL9TKtMjI=;
        b=StHZKGoBvM06DSEohSnIn9O7xS1RK/uX39iPmEZ1yFNKPKn7o6Y+wS6hHJeNXJBfd+
         smlwgcr/XEYKc8BB46h4LwPCiFOwn5x3K1NpZ4gjWUs2GhLOcnQWQY+gUTY04WFhIs/8
         9XfSlz97NRgYOkYC0G3JyTJD1mqF4R43/NX37uaetOIM7Lu2PGgZ5V0aVWaCgfHjZqTh
         DsMxkaY4/QCtCv+mLVC/69Y8lFHfa9WEym1dOphOG/qyCCLNk2KhLG4dd+T0HaroXmGi
         Znkjt/tdXiw8gg4JUDc1DbMrto4UaiOpcoYPu2hDmpUW0aYZFP0ArkMUe2k19rIc/JeW
         kKcg==
X-Gm-Message-State: AOAM530W6QM4CYisjqqpXZBX+1krPh2umvp9RRMnGCioV3QvOVEqYmkx
        EVbp2v3dFgJ8L1Mg7pBbcr4=
X-Google-Smtp-Source: ABdhPJyO/50W041AisqWmmke5qIJXnUH0tO334TMypHApXce7vJ7aru3vJuQ2obktoMcHtm9rhpPig==
X-Received: by 2002:a17:90a:7d06:: with SMTP id g6mr1997995pjl.113.1602820567800;
        Thu, 15 Oct 2020 20:56:07 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id v12sm861555pgr.4.2020.10.15.20.56.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2020 20:56:07 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 6/8] ext4: update ext4_data_block_valid related comments
Date:   Fri, 16 Oct 2020 11:55:50 +0800
Message-Id: <1602820552-4082-6-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1602820552-4082-1-git-send-email-brookxu@tencent.com>
References: <1602820552-4082-1-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Since ext4_data_block_valid() has been renamed to ext4_inode_block_valid(),
the related comments need to be updated.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/block_validity.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 5e98ca0..03b237f 100644
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
 	rcu_assign_pointer(sbi->system_blks, system_blks);
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

