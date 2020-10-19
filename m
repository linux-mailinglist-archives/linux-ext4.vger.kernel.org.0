Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9081292433
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Oct 2020 11:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgJSJCs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Oct 2020 05:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729819AbgJSJCs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Oct 2020 05:02:48 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD57C0613D0
        for <linux-ext4@vger.kernel.org>; Mon, 19 Oct 2020 02:02:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b19so4671305pld.0
        for <linux-ext4@vger.kernel.org>; Mon, 19 Oct 2020 02:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E38ZZ1fQoNa0caGRoy68OnxGvPl91asXRgtOYleWvek=;
        b=SZmcdPxBPtPl+9dGjHScgO3iZ2ntkSAHJnHH4++P+3bJh/Wyw1MSm8NwFvsam9PRCO
         erE5F5Yy6ru5NhWNn0AAzRVeroiEWLG/KrZvj/JBNNYZAXO1UPyH2qteE6DFP2yTjsE/
         bJAWvcZmxPM7USudEVyZNlq9rxVWmBbHgSaL8dHtGutlRRmXmbboTooqjVIAWKrVzIcx
         INfCwKznn0vXlA7CzLnr3MHLJ0WlIxnFRViOb/pLlyYCcNq5NXY/gqSm3wuFDSuFS83t
         H+ZzsY83urqXff/TzgIqMoNJqcdTnd8ytWIhSppj3TJcUmlxsw2H6dAhPuFjZ2sX3Fji
         hvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E38ZZ1fQoNa0caGRoy68OnxGvPl91asXRgtOYleWvek=;
        b=HkoLP0QQwvW6qkNpKQIIIP4PA1Utlv1Y3FSkilLj06xyQRWG7zb6ZPNvJQYVgx2tGb
         6mjO0Ra+t5hsWSESMWaT+9lx7t98/FmuV3j4cMSWwCbx94fPrur+oqTH6inhzTdsiGQH
         Q0///tIpQr2kgWUzW3tk/FmMTrXRz20HBlETxibR6erGSESVVZKAkq6Gc2FLxu3U+o3n
         poX6gbMDH/SZ6FYI/swL99SBD7Lek8/TerURvGEy488JzHIypy+kJ0pc5qE3zaj2qX83
         //TV50zlINDJsOZ7FQce1Nj03Gqr7FrAwDSqeltkf7LCyxJBWG2Tt4OKGGezFvMDA4u/
         hX9Q==
X-Gm-Message-State: AOAM532HUtydEgupvCv6biLVd/2iBeC4t+JBib3azrI8G01BCViNOqZu
        ENZekSWeYCdg0nhB66txbas=
X-Google-Smtp-Source: ABdhPJykhI/qPrUhuWucrrw16UQhb9//l0q9twP0TLg8k1FiGmWEMOORsHSPFyWkZQpD1y4M7JBegg==
X-Received: by 2002:a17:902:b70a:b029:d2:6391:a80f with SMTP id d10-20020a170902b70ab02900d26391a80fmr16247841pls.0.1603098167587;
        Mon, 19 Oct 2020 02:02:47 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id 14sm11422880pjn.48.2020.10.19.02.02.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2020 02:02:47 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH v2 5/8] ext4: update ext4_data_block_valid related comments
Date:   Mon, 19 Oct 2020 17:02:35 +0800
Message-Id: <1603098158-30406-5-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603098158-30406-1-git-send-email-brookxu@tencent.com>
References: <1603098158-30406-1-git-send-email-brookxu@tencent.com>
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

