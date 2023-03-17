Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B296BE1CB
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 08:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjCQHQI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Mar 2023 03:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjCQHQH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Mar 2023 03:16:07 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850AF10CD;
        Fri, 17 Mar 2023 00:16:02 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z21so16809239edb.4;
        Fri, 17 Mar 2023 00:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679037361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KShndDmtpL/wghNsEWsMIclWE+/Ioe4uetwa8XAxyPI=;
        b=XiSV7Xe+j4vAxn8Wn4s4HU1BPZR7kJx3q/rQBuzCQwnmSdrOu9xRPQuKrmRBH4cLCL
         KGgGVXCXRSCwoIjqKs3+JX+kLFft3tK1u0CNFBcx0hrgCN2VLx8nutygse61czoRwx60
         Yr3FOjsEdDu2qv/SrKqGepBb6tdPnXvPpPid4Y4KRZvdfH/yNDjcyGDCvwQl11CK+Hpc
         QkcJRYb3LPv1A+PAZEN35erFcLIeH5WrWoDIY0GQ5fGOH/MHhz/H9jXlVjPT4DBassN7
         LYj3b8Cw6apyNBXUXPxv4P2ekzd6pe5n0IQlG6j8mA9Qrt4iBXeMJBvSXW0G7IfcZGLU
         69Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679037361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KShndDmtpL/wghNsEWsMIclWE+/Ioe4uetwa8XAxyPI=;
        b=x3PtkVDHznsiLizYHMXW/U5x0aTCsIfh1QIX1sY9BQ74zfjs2SSZpysO0a0MhtGRk9
         FpwEMVLgnnO+FzMKwDjzWwwRQ+cGXkwwuxnNTzk7ob9JxQD53eQA167ptS//Vmt8HYuw
         ONfe2Z3SIE9i6T/oP4bfmwfQcE00zH03+gv+7OdEaK1ipIEOj8Hmjrrq7EcjDKDd3rUO
         dH+vDyYp4xT7OR3vzTUQfemBKKhLDkyYJt557grvl9hjzAq0ZDnKQgM8/A7cEnLkZ8SD
         MEfSYxXuu9I84WYgy2jBK/x8QTLMfvh7I8OV+/aIY/NuHQz3KU2MmGYYuOq50fGFXl1A
         16UQ==
X-Gm-Message-State: AO0yUKWDN1i3R/fsy00F2w5yvR4ILpU93PJ7Zq/CDrXZG4n8KFccC29V
        5wFE3l/pJeufIxIK5l7jTns=
X-Google-Smtp-Source: AK7set+da5nkPqUZwzrH2N9wTQTxnlUyt76NtDfl5j2HdB/nXGh1aTJTyVPIsUDpF3PTPRvTj4A8WQ==
X-Received: by 2002:a05:6402:44b:b0:4fa:eccd:9849 with SMTP id p11-20020a056402044b00b004faeccd9849mr2011896edw.9.1679037360872;
        Fri, 17 Mar 2023 00:16:00 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id i23-20020a508717000000b004af6c5f1805sm642321edb.52.2023.03.17.00.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 00:16:00 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-ext4@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: [PATCH 1/1] ext4: Replace ext4_kvfree_array_rcu() by kvfree_rcu_mightsleep()
Date:   Fri, 17 Mar 2023 08:15:58 +0100
Message-Id: <20230317071558.335645-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The ext4_kvfree_array_rcu() function was introduced in order to
release some memory after a grace period during resizing of a
partition. An object that is freed does not contain any rcu_head
filed.

To do so, it requires to allocate some extra memory for a special
structure that has an rcu_head filed and pointer one where a freed
memory is attached. Finally call_rcu() API is invoked.

Since we have a single argument of kvfree_rcu() API, we can easily
replace all that tricky code by one single call that does the same
but in more efficient way.

Cc: linux-ext4@vger.kernel.org
Cc: Lukas Czerner <lczerner@redhat.com>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 fs/ext4/ext4.h    |  1 -
 fs/ext4/mballoc.c |  2 +-
 fs/ext4/resize.c  | 31 ++-----------------------------
 fs/ext4/super.c   |  2 +-
 4 files changed, 4 insertions(+), 32 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 140e1eb300d1..e43d1a2d175e 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3057,7 +3057,6 @@ extern int ext4_generic_delete_entry(struct inode *dir,
 extern bool ext4_empty_dir(struct inode *inode);
 
 /* resize.c */
-extern void ext4_kvfree_array_rcu(void *to_free);
 extern int ext4_group_add(struct super_block *sb,
 				struct ext4_new_group_data *input);
 extern int ext4_group_extend(struct super_block *sb,
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5b2ae37a8b80..96b4e3317640 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3055,7 +3055,7 @@ int ext4_mb_alloc_groupinfo(struct super_block *sb, ext4_group_t ngroups)
 	rcu_assign_pointer(sbi->s_group_info, new_groupinfo);
 	sbi->s_group_info_size = size / sizeof(*sbi->s_group_info);
 	if (old_groupinfo)
-		ext4_kvfree_array_rcu(old_groupinfo);
+		kvfree_rcu_mightsleep(old_groupinfo);
 	ext4_debug("allocated s_groupinfo array for %d meta_bg's\n",
 		   sbi->s_group_info_size);
 	return 0;
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 6b91443d6bf3..330b81f36e10 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -18,33 +18,6 @@
 
 #include "ext4_jbd2.h"
 
-struct ext4_rcu_ptr {
-	struct rcu_head rcu;
-	void *ptr;
-};
-
-static void ext4_rcu_ptr_callback(struct rcu_head *head)
-{
-	struct ext4_rcu_ptr *ptr;
-
-	ptr = container_of(head, struct ext4_rcu_ptr, rcu);
-	kvfree(ptr->ptr);
-	kfree(ptr);
-}
-
-void ext4_kvfree_array_rcu(void *to_free)
-{
-	struct ext4_rcu_ptr *ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
-
-	if (ptr) {
-		ptr->ptr = to_free;
-		call_rcu(&ptr->rcu, ext4_rcu_ptr_callback);
-		return;
-	}
-	synchronize_rcu();
-	kvfree(to_free);
-}
-
 int ext4_resize_begin(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -931,7 +904,7 @@ static int add_new_gdb(handle_t *handle, struct inode *inode,
 	n_group_desc[gdb_num] = gdb_bh;
 	rcu_assign_pointer(EXT4_SB(sb)->s_group_desc, n_group_desc);
 	EXT4_SB(sb)->s_gdb_count++;
-	ext4_kvfree_array_rcu(o_group_desc);
+	kvfree_rcu_mightsleep(o_group_desc);
 
 	lock_buffer(EXT4_SB(sb)->s_sbh);
 	le16_add_cpu(&es->s_reserved_gdt_blocks, -1);
@@ -994,7 +967,7 @@ static int add_new_gdb_meta_bg(struct super_block *sb,
 
 	rcu_assign_pointer(EXT4_SB(sb)->s_group_desc, n_group_desc);
 	EXT4_SB(sb)->s_gdb_count++;
-	ext4_kvfree_array_rcu(o_group_desc);
+	kvfree_rcu_mightsleep(o_group_desc);
 	return err;
 }
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 87aa23d047c9..34d802848d6d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3108,7 +3108,7 @@ int ext4_alloc_flex_bg_array(struct super_block *sb, ext4_group_t ngroup)
 	rcu_assign_pointer(sbi->s_flex_groups, new_groups);
 	sbi->s_flex_groups_allocated = size;
 	if (old_groups)
-		ext4_kvfree_array_rcu(old_groups);
+		kvfree_rcu_mightsleep(old_groups);
 	return 0;
 }
 
-- 
2.30.2

