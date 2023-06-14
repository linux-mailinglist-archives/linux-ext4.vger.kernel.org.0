Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522C072FA06
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jun 2023 12:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbjFNKFD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Jun 2023 06:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243604AbjFNKEx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Jun 2023 06:04:53 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B6B195;
        Wed, 14 Jun 2023 03:04:52 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f7ff69824dso3330455e9.1;
        Wed, 14 Jun 2023 03:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686737091; x=1689329091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CJwr6Y2umkSKUEqhWH9SvLNqVUvRLzxqfJAUFOKrvpU=;
        b=YdnjUdn8XRrLX9Gte6D/c18JhkyLdnvJNnkeJ5RW6fLHTg3J3lJ6sZK1QrI9iIubxY
         gG0WcqYjP1yb/aPYV5td6KD8qnUTor7LPvtrGNelMl5uX/WlXjkbNddKQD74bSeM7l5x
         EENwEbO1aIr92Og1+L0VyHc9qozi0XA1ZqteHyuJIczLGqFBKmgUOxq76oE9+FhOrOcC
         RczP880i3XPQYzgti3VhFDvZy/C/Oj9HMUYqOJFQZWYx3IzYlvyxLQ1TEY1xDx1DFO+O
         oUleUj7OUcDAkAiFWoQjKdPO9MJr9CIgIviZEQOEo4z/5AARj5mYL694nEhHDoO/x/n9
         oGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686737091; x=1689329091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CJwr6Y2umkSKUEqhWH9SvLNqVUvRLzxqfJAUFOKrvpU=;
        b=f5FYvfzxyCeHqYH0lT0+MWovD/C8PJ3OZBaEVAdVjhpQh68jLnAf5Qne3od79+djrw
         CTi6t5CAu78Nzcf+JJ6N2+kls8drV4f0J6SmFDq3+q35HlfDKz7Bc2NXi9ghJS3KRQzY
         pMABjGuzJ/PLLUhJbyu8x7Kro1nF4+ifS5bV5s1o+848C2Ppn/c3TvrO92K1V06thbqv
         LfOwWVLEgc6Vi+4QGX23n05wveHHb9Vr1p0T+tGEp4IrR0tvGVHBs9b1245XxHlI+A3F
         kGxCR8TuH6zkaBTY436PViBsQvK61Pf1l3lAirwvsOKAotMpEU81aWdWQ+9v4F4ogNB+
         3Enw==
X-Gm-Message-State: AC+VfDwJmNGA+pzY9PgdX3f6n6uQWOTx5ficBJMlM366YjSHXAje1dMY
        NTDiq5PHQS1l1CoHriPXDItsTizCgSA=
X-Google-Smtp-Source: ACHHUZ7NnadrCr99c3BsF7uxz0uSZ0Xsaquj+r/MPcopBB5hGiDYUm8XgILbFGUpVTXyfm7ULZI9tg==
X-Received: by 2002:a05:600c:21cf:b0:3f8:6934:9775 with SMTP id x15-20020a05600c21cf00b003f869349775mr1005877wmj.7.1686737090538;
        Wed, 14 Jun 2023 03:04:50 -0700 (PDT)
Received: from localhost.localdomain (host-95-252-166-216.retail.telecomitalia.it. [95.252.166.216])
        by smtp.gmail.com with ESMTPSA id n26-20020a1c721a000000b003f78fd2cf5esm16949354wmc.40.2023.06.14.03.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 03:04:50 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        syzbot+4acc7d910e617b360859@syzkaller.appspotmail.com
Subject: [PATCH] ext4: Drop the call to ext4_error() from ext4_get_group_info()
Date:   Wed, 14 Jun 2023 12:02:55 +0200
Message-ID: <20230614100446.14337-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

A recent patch added a call to ext4_error() which is problematic since
some callers of the ext4_get_group_info() function may be holding a
spinlock, whereas ext4_error() must never be called in atomic context.

This triggered a report from Syzbot: "BUG: sleeping function called from
invalid context in ext4_update_super" (see the link below).

Therefore, drop the call to ext4_error() from ext4_get_group_info(). In
the meantime use eight characters tabs instead of nine characters ones.

Reported-by: syzbot+4acc7d910e617b360859@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/00000000000070575805fdc6cdb2@google.com/
Fixes: 5354b2af3406 ("ext4: allow ext4_get_group_info() to fail")
Suggested-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/ext4/balloc.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index c1edde817be8..e8da678a0103 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -324,17 +324,15 @@ static ext4_fsblk_t ext4_valid_block_bitmap_padding(struct super_block *sb,
 struct ext4_group_info *ext4_get_group_info(struct super_block *sb,
 					    ext4_group_t group)
 {
-	 struct ext4_group_info **grp_info;
-	 long indexv, indexh;
-
-	 if (unlikely(group >= EXT4_SB(sb)->s_groups_count)) {
-		 ext4_error(sb, "invalid group %u", group);
-		 return NULL;
-	 }
-	 indexv = group >> (EXT4_DESC_PER_BLOCK_BITS(sb));
-	 indexh = group & ((EXT4_DESC_PER_BLOCK(sb)) - 1);
-	 grp_info = sbi_array_rcu_deref(EXT4_SB(sb), s_group_info, indexv);
-	 return grp_info[indexh];
+	struct ext4_group_info **grp_info;
+	long indexv, indexh;
+
+	if (unlikely(group >= EXT4_SB(sb)->s_groups_count))
+		return NULL;
+	indexv = group >> (EXT4_DESC_PER_BLOCK_BITS(sb));
+	indexh = group & ((EXT4_DESC_PER_BLOCK(sb)) - 1);
+	grp_info = sbi_array_rcu_deref(EXT4_SB(sb), s_group_info, indexv);
+	return grp_info[indexh];
 }
 
 /*
-- 
2.41.0

