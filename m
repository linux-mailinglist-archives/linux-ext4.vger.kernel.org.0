Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3E16F298F
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Apr 2023 18:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjD3Qyn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Apr 2023 12:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjD3Qym (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Apr 2023 12:54:42 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F761723
        for <linux-ext4@vger.kernel.org>; Sun, 30 Apr 2023 09:54:40 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aaf792c210so231435ad.0
        for <linux-ext4@vger.kernel.org>; Sun, 30 Apr 2023 09:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682873680; x=1685465680;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNG8RUsR9FUAqdTwLBaZpI6pJsBbKdyT1Msigj0pj48=;
        b=aZzu9BHxz1JrW/wmyl5h1y7qfhzXiZzls/8ZLLTnRy2Bcc9GY7pB8JERJcXpvDvzIm
         DmyP/ApSYwYBMRNlSoDqaf2meQi+mhuDSJyzqJ1HZAIbMJdQrbuJug7xJ48V8PRVLTux
         lkEOFl4vqL9ltrwSKr5tfnhOQTLx5I8fQJwoxo1TowkXREvcEhpO0kAB8LecFKqsqy3l
         l1r6+A/oVgkKm0prxdAAmN8OTMhk1lCiJmuPm074K5sCeXcByqx56ISI6kTRlbm9tdo/
         GJSkhBkUU2jYyKiXA4j3revMfKYKDFI/m157NGEi042fWQOPBUGR/3ZxVBz/fi+74RHU
         tn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682873680; x=1685465680;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GNG8RUsR9FUAqdTwLBaZpI6pJsBbKdyT1Msigj0pj48=;
        b=NMWppgUvay7JY0tzIMayzWLuic1nbcgixbwa4TCVwncEHBHsW6XFmbEyZ8hQHQlgfa
         bzV2WfFCoYOv1RCic+uuip+b+lHvzS5zeUpgKD8uE4/TDnbtlP/eIbrYvp9XihoH5H3s
         tpLuDtBZEi8pwfZcaO6hxjxvskjSJ4AV4kfaFCdbPrLvMy00b+bL8GVjM6u/ry/+hGq4
         YOxZgyjt6kpeAO2cnrKk0lgwARhWaIIf8up7moRJ6eQXsPFQkB4LxgAYPm+GnV9jB8J0
         fZxl4QeV7jhUtbhdRINdVphZGsruiPxV2ueZrzsXxCAEMd6uhW46ar4yKVv8Qky2l3VS
         fzIQ==
X-Gm-Message-State: AC+VfDyvLVF4xrd+UfbwpEy2ty8XrIB3O+hr33HZQoNXSJhzC6n4FCze
        2yZDdZwfHd9w4hMPm3Ruy3rQyw==
X-Google-Smtp-Source: ACHHUZ4nZSYEgXjT0MGD1P7m/BExrB7PV9aa0CpbB1RuqZ+/EsvVQs2Pv48ukoN985SXcfoWWygwtQ==
X-Received: by 2002:a17:902:ea10:b0:1a9:1b4:9fdd with SMTP id s16-20020a170902ea1000b001a901b49fddmr10815448plg.2.1682873679998;
        Sun, 30 Apr 2023 09:54:39 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jw11-20020a170903278b00b0019a593e45f1sm16472780plb.261.2023.04.30.09.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Apr 2023 09:54:39 -0700 (PDT)
Message-ID: <123c391a-2569-6afd-2461-4e5b2ca298f3@kernel.dk>
Date:   Sun, 30 Apr 2023 10:54:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] ext4: silence complaint if CONFIG_QUOTA isn't set
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Compiling the kernel ext4 spews a warning that 'i' is unused in two
spots:

axboe@m1max ~/gi/linux-block (master)> make fs/ext4/super.o                    0.027s
  CALL    scripts/checksyscalls.sh
  CC      fs/ext4/super.o
fs/ext4/super.c: In function ?ext4_put_super?:
fs/ext4/super.c:1262:13: warning: unused variable ?i? [-Wunused-variable]
  1262 |         int i, err;
       |             ^
fs/ext4/super.c: In function ?__ext4_fill_super?:
fs/ext4/super.c:5200:22: warning: unused variable ?i? [-Wunused-variable]
  5200 |         unsigned int i;
       |                      ^

Put the quota freeing code into a helper so we can stub it out for
!CONFIG_QUOTA.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---

This appears new, but I didn't check what commit potentially broke
this...

 fs/ext4/super.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d03bf0ecf505..5d85d7377d84 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1254,12 +1254,23 @@ static void ext4_flex_groups_free(struct ext4_sb_info *sbi)
 	rcu_read_unlock();
 }
 
+static void ext4_free_quotas(struct super_block *sb,
+			     struct ext4_sb_info *sbi)
+{
+#ifdef CONFIG_QUOTA
+	unsigned int i;
+
+	for (i = 0; i < EXT4_MAXQUOTAS; i++)
+		kfree(get_qf_name(sb, sbi, i));
+#endif
+}
+
 static void ext4_put_super(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
 	int aborted = 0;
-	int i, err;
+	int err;
 
 	/*
 	 * Unregister sysfs before destroying jbd2 journal.
@@ -1310,10 +1321,7 @@ static void ext4_put_super(struct super_block *sb)
 	ext4_group_desc_free(sbi);
 	ext4_flex_groups_free(sbi);
 	ext4_percpu_param_destroy(sbi);
-#ifdef CONFIG_QUOTA
-	for (i = 0; i < EXT4_MAXQUOTAS; i++)
-		kfree(get_qf_name(sb, sbi, i));
-#endif
+	ext4_free_quotas(sb, sbi);
 
 	/* Debugging code just in case the in-memory inode orphan list
 	 * isn't empty.  The on-disk one can be non-empty if we've
@@ -5197,7 +5205,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	ext4_fsblk_t logical_sb_block;
 	struct inode *root;
 	int ret = -ENOMEM;
-	unsigned int i;
 	int needs_recovery;
 	int err = 0;
 	ext4_group_t first_not_zeroed;
@@ -5627,10 +5634,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	utf8_unload(sb->s_encoding);
 #endif
 
-#ifdef CONFIG_QUOTA
-	for (i = 0; i < EXT4_MAXQUOTAS; i++)
-		kfree(get_qf_name(sb, sbi, i));
-#endif
+	ext4_free_quotas(sb, sbi);
 	fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);
 	/* ext4_blkdev_remove() calls kill_bdev(), release bh before it. */
 	brelse(sbi->s_sbh);
-- 
2.39.2

-- 
Jens Axboe

