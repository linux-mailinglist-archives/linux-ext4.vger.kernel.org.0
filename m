Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9000E23196A
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jul 2020 08:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgG2GT1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jul 2020 02:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgG2GT0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jul 2020 02:19:26 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC6DC061794
        for <linux-ext4@vger.kernel.org>; Tue, 28 Jul 2020 23:19:26 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t6so13720278pgq.1
        for <linux-ext4@vger.kernel.org>; Tue, 28 Jul 2020 23:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=rIOXkzd3UM4u7MLNWHv7VAb8VIykq9AFMuxB5NPzRRI=;
        b=kzwGHsTXXF4bp7wUDmtsY1TzWSe+iao1y0T0/A8W3abnehscEZPFGb2kisC4YHHTyq
         OaUg7R1aNrVmo5DG7Qj5dB2mvUb91gOVKUrR+mQsc7YO9d9jo8NE7eY8jL5cecf3cs4M
         S0IbQrnFyCWPE5yzpSXwV5jX1wv8+uFJcvtEwuBI9i1KrR9NHnpBPoOQgA2HV5JaI3Qv
         fsY4bwBZeCOV4bRO79F8ZxiFm5feCZGg/pWAjof+/+9AuCIEknsyEAYmnQ6zRxAwdNR6
         VSTvszFFFBbVMtdeF6k4+ws5bl6Ipv0iTyiLFGySvKqYIOVSTVpLI/HZfVUg1WcGNfQd
         8Zpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=rIOXkzd3UM4u7MLNWHv7VAb8VIykq9AFMuxB5NPzRRI=;
        b=I3/DnQf1LTYXXgu1JBwhBhDJUGZ9GlggY4UMWUa22I6IBNvDdVN66nKg+qmL72W70a
         05J+tBvOlZihCiq7FqDSNNnReud7Gcd4bfPGsYvDl/XQAzwSxdP4Wh/Ay9rigRqh1Wce
         CK6BV2tIXfnuVJxwslSHvKLCimGjgm/zlySagDL75wwGq8ASOHndZeWhFxbtr5wIcGQW
         pnUeqnJu7HKvpURVMs2IPdi0q3YEQ+u8FIepGLJDdJ8QNhWontg7MxDmBR+DbwX7X9Gd
         DDgACmUpeIy00oiOt1akAiwCFiDqOCwNwUpEcQdwySWX8e7ngUmZXivJ+5u/VPCn7Hgm
         GHww==
X-Gm-Message-State: AOAM531zsNE+aYglDJNSAi6553GX8w+CyyaDuZW1WKlaZzAXD/9065OF
        AEE8/8y7SU0vJ/Hx+rvRRXO2wyoiLz4=
X-Google-Smtp-Source: ABdhPJxSIKyYp8spToCuwkRtjpo5Hj84RFWdkhxSpxM14lr8fK63LPtGwCoR39NhdwX6Ctd4FzyoPA==
X-Received: by 2002:a63:ec05:: with SMTP id j5mr28459617pgh.109.1596003566217;
        Tue, 28 Jul 2020 23:19:26 -0700 (PDT)
Received: from [10.8.0.10] ([203.205.141.60])
        by smtp.gmail.com with ESMTPSA id z77sm998085pfc.199.2020.07.28.23.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 23:19:25 -0700 (PDT)
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH 2/2] ext4: rename system_blks to s_system_blks inside
 ext4_sb_info
Message-ID: <6af737ee-e16f-9d2b-5045-fb5b8995a6d6@gmail.com>
Date:   Wed, 29 Jul 2020 14:19:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Rename system_blks to s_system_blks inside ext4_sb_info, keep
the naming rules consistent with other variables, which is
convenient for code reading and writing.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/block_validity.c | 14 +++++++-------
 fs/ext4/ext4.h           |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 16e9b2f..69240b4 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -138,7 +138,7 @@ static void debug_print_tree(struct ext4_sb_info *sbi)
 
     printk(KERN_INFO "System zones: ");
     rcu_read_lock();
-    system_blks = rcu_dereference(sbi->system_blks);
+    system_blks = rcu_dereference(sbi->s_system_blks);
     node = rb_first(&system_blks->root);
     while (node) {
         entry = rb_entry(node, struct ext4_system_zone, node);
@@ -263,11 +263,11 @@ int ext4_setup_system_zone(struct super_block *sb)
     int ret;
 
     if (!test_opt(sb, BLOCK_VALIDITY)) {
-        if (sbi->system_blks)
+        if (sbi->s_system_blks)
             ext4_release_system_zone(sb);
         return 0;
     }
-    if (sbi->system_blks)
+    if (sbi->s_system_blks)
         return 0;
 
     system_blks = kzalloc(sizeof(*system_blks), GFP_KERNEL);
@@ -308,7 +308,7 @@ int ext4_setup_system_zone(struct super_block *sb)
      * with ext4_data_block_valid() accessing the rbtree at the same
      * time.
      */
-    rcu_assign_pointer(sbi->system_blks, system_blks);
+    rcu_assign_pointer(sbi->s_system_blks, system_blks);
 
     if (test_opt(sb, DEBUG))
         debug_print_tree(sbi);
@@ -333,9 +333,9 @@ void ext4_release_system_zone(struct super_block *sb)
 {
     struct ext4_system_blocks *system_blks;
 
-    system_blks = rcu_dereference_protected(EXT4_SB(sb)->system_blks,
+    system_blks = rcu_dereference_protected(EXT4_SB(sb)->s_system_blks,
                     lockdep_is_held(&sb->s_umount));
-    rcu_assign_pointer(EXT4_SB(sb)->system_blks, NULL);
+    rcu_assign_pointer(EXT4_SB(sb)->s_system_blks, NULL);
 
     if (system_blks)
         call_rcu(&system_blks->rcu, ext4_destroy_system_zone);
@@ -353,7 +353,7 @@ int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,
      * mount option.
      */
     rcu_read_lock();
-    system_blks = rcu_dereference(sbi->system_blks);
+    system_blks = rcu_dereference(sbi->s_system_blks);
     ret = ext4_data_block_valid_rcu(sbi, system_blks, start_blk,
                     count);
     rcu_read_unlock();
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 8ca9adf..d60a462 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1470,7 +1470,7 @@ struct ext4_sb_info {
     int s_jquota_fmt;            /* Format of quota to use */
 #endif
     unsigned int s_want_extra_isize; /* New inodes should reserve # bytes */
-    struct ext4_system_blocks __rcu *system_blks;
+    struct ext4_system_blocks __rcu *s_system_blks;
 
 #ifdef EXTENTS_STATS
     /* ext4 extents stats */
-- 
1.8.3.1

