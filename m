Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80C5294A50
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Oct 2020 11:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437567AbgJUJQS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Oct 2020 05:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437538AbgJUJQR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Oct 2020 05:16:17 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B46FC0613CE
        for <linux-ext4@vger.kernel.org>; Wed, 21 Oct 2020 02:16:17 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gv6so825381pjb.4
        for <linux-ext4@vger.kernel.org>; Wed, 21 Oct 2020 02:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E38ZZ1fQoNa0caGRoy68OnxGvPl91asXRgtOYleWvek=;
        b=NCtqH4mFIz/5VQkTSFXe9A05g05ay+tqjTmzQ+nUtOGMKFLGTCgNfgtCdZKw9l515K
         ut5hCIoF0lxdBSnGo9BytCNZw2Vkn8NgVSTdiTJXce8OaB1pE/ZrfjZtiZ+jNsrXdgbg
         HytlPUvhzKxrMEvJykQe70UTSArpMrowZW8pYm9p6MditnlBKxaa4/3+ogDZtCxulA6Q
         oLQAAsTHdHLPD5KYQ4WAlxBTHtnpE5g7R6RdwGF0eQPD7X4xMgjYzx4sQyjffHD31l0F
         jOjhUjyEloKPPCstrYFaQPF2+gI1ndupkxkoW9Vv3MDWeTGiAjdOd2nHFrkc3D+ZsQl3
         gghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E38ZZ1fQoNa0caGRoy68OnxGvPl91asXRgtOYleWvek=;
        b=L78oh5Nd2HJc5zRKuGEFH9CP5Qs/0XvutEZ8GHZRgkCqnrqvXGx5b2ChfrJN5DS4OO
         G1G9KR+1be+QveWH27h/J5Fe2DOlvW+Jh7K4ehFc1Tzo4hM2s7soo3Fs4AWQpeNmiHmy
         kIQh4rzYFwPONYeVP8EPEo/tF1f0Blq7fR4IH1d7v7N9PDdSHJozbM5W31pcf8Xj0luP
         DzfH0xoDn2IP8NbFVVQcF8buT0yQ8PyVoz7TQj8MNibP+J375LbFMkS9zByK1AS5oEFB
         Y5AjouUHF6s05aMxiYuDl85TIGKwxLONR34QaSetUZlEG9LI6YWO7YDfYDgksMYiwbAf
         B4gw==
X-Gm-Message-State: AOAM532aIWl6kyUZUSMIFny5CARcU2eLlxQFuyoyIOhconj9yjy0aUSG
        wReZSW1aHFinJgttBBsYdgM=
X-Google-Smtp-Source: ABdhPJw35+kyRP4egs/DlkSga3XowCzS7OJ1IXSVS5WYkw8iCFfRxsrmEavhQsDkPXlNom6DMAXKOA==
X-Received: by 2002:a17:90a:4e0c:: with SMTP id n12mr2369658pjh.78.1603271777060;
        Wed, 21 Oct 2020 02:16:17 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id x16sm1573002pff.14.2020.10.21.02.16.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2020 02:16:16 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 5/8] ext4: update ext4_data_block_valid related comments
Date:   Wed, 21 Oct 2020 17:15:25 +0800
Message-Id: <1603271728-7198-5-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603271728-7198-1-git-send-email-brookxu@tencent.com>
References: <1603271728-7198-1-git-send-email-brookxu@tencent.com>
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

