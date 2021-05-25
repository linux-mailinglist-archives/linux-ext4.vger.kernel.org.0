Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA5C38FBDD
	for <lists+linux-ext4@lfdr.de>; Tue, 25 May 2021 09:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhEYHik (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 May 2021 03:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhEYHii (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 May 2021 03:38:38 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9882DC061574
        for <linux-ext4@vger.kernel.org>; Tue, 25 May 2021 00:37:09 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v12so15916153plo.10
        for <linux-ext4@vger.kernel.org>; Tue, 25 May 2021 00:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X8YIRo6I+du4posIZ80PBegdCRJt8JCFJTNTEx6sLRI=;
        b=qDjwASJydUyCpbdb9gUDvFkYsACycsq15h+uaixN50Evdhk831yZwCmhTWblKVn7dd
         Z83FmKs1o+3m2qggWyqiAduWN8yCZPwwOYcwg7AjfXPq8lSDLt3dlDricFZd+g+jC+7d
         p6xJBEZhj8Fh4B052wifxM6ZEEJ617eiq8XuCA292ZqA2FYwriwp0vng/NNSpZvXrUTH
         yNfuN0BqE2LrPO1x2jE85gkuoZK+xlsVCxO5+S3CGpbPbBnGoW7Cdqeb4fIb9JEctI+L
         d8N34PFWmObLih5MAzWfI3+hp7eDfsnXukLJm5RZfkf0IYLdtGlni360Mpc18HGoV6vm
         Ghpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X8YIRo6I+du4posIZ80PBegdCRJt8JCFJTNTEx6sLRI=;
        b=AAqOea2/DprjViBjfYRF96Ltain6PvaftpNq5Utd5/G8vlKkp9Edb2Xi8xbc0k7gRE
         dQ2l09TKT+CVTmXXFaFExDzXhnxbkya3jE0l9Rn6ZtmSIn127MqOhUuBJEMEwmkNYnwA
         yhnDpM3LXJXeyCjnZQt3OXTO2Tt3o7/EmOXEd4bj5xpb19TOdC0rh8vIrHV/mBX4ChCn
         5dmzJy2rB1xBvoSfIaVPi4OHUtqUyOwIMV5tUJYhkuedUBbJqNDdWO5F5uesy4BiA2b1
         6+hJXILZ4yRiEHRl6yAIegu+UJfPU+joDDmNm313lVFcD+mVsCcvqM2ctlU0FwSVuk7S
         zeCg==
X-Gm-Message-State: AOAM530jtRIXqie0ySWzoKUJBzZZld2d2i/gG0+3ZcVVOLNdPw4f7OFP
        SHRgwQZQ1/6nNoAceO7yybsZew==
X-Google-Smtp-Source: ABdhPJxftDBmvfUCb17oGsNaevPpTzrJLp3OD97G7swR2Vy+c8XfiZQHFylB71jJYxFZwy1pMpxebQ==
X-Received: by 2002:a17:90a:3005:: with SMTP id g5mr3386207pjb.14.1621928229236;
        Tue, 25 May 2021 00:37:09 -0700 (PDT)
Received: from Peter-Pan-MacBook-Pro.local.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id f17sm13242989pgm.37.2021.05.25.00.37.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 May 2021 00:37:08 -0700 (PDT)
From:   Pan Dong <pandong.peter@bytedance.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, Pan Dong <pandong.peter@bytedance.com>
Subject: [PATCH] ext4: fix avefreec in find_group_orlov
Date:   Tue, 25 May 2021 15:36:56 +0800
Message-Id: <20210525073656.31594-1-pandong.peter@bytedance.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The avefreec should be average free clusters instead
of average free blocks, otherwize Orlov's allocator
will not work properly when bigalloc enabled.

Signed-off-by: Pan Dong <pandong.peter@bytedance.com>
---
 fs/ext4/ialloc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 71d321b3b984..6c6b6855e30d 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -400,7 +400,7 @@ static void get_orlov_stats(struct super_block *sb, ext4_group_t g,
  *
  * We always try to spread first-level directories.
  *
- * If there are blockgroups with both free inodes and free blocks counts
+ * If there are blockgroups with both free inodes and free clusters counts
  * not worse than average we return one with smallest directory count.
  * Otherwise we simply return a random group.
  *
@@ -409,7 +409,7 @@ static void get_orlov_stats(struct super_block *sb, ext4_group_t g,
  * It's OK to put directory into a group unless
  * it has too many directories already (max_dirs) or
  * it has too few free inodes left (min_inodes) or
- * it has too few free blocks left (min_blocks) or
+ * it has too few free clusters left (min_clusters) or
  * Parent's group is preferred, if it doesn't satisfy these
  * conditions we search cyclically through the rest. If none
  * of the groups look good we just look for a group with more
@@ -425,7 +425,7 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent,
 	ext4_group_t real_ngroups = ext4_get_groups_count(sb);
 	int inodes_per_group = EXT4_INODES_PER_GROUP(sb);
 	unsigned int freei, avefreei, grp_free;
-	ext4_fsblk_t freeb, avefreec;
+	ext4_fsblk_t freec, avefreec;
 	unsigned int ndirs;
 	int max_dirs, min_inodes;
 	ext4_grpblk_t min_clusters;
@@ -444,9 +444,8 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent,
 
 	freei = percpu_counter_read_positive(&sbi->s_freeinodes_counter);
 	avefreei = freei / ngroups;
-	freeb = EXT4_C2B(sbi,
-		percpu_counter_read_positive(&sbi->s_freeclusters_counter));
-	avefreec = freeb;
+	freec = percpu_counter_read_positive(&sbi->s_freeclusters_counter);
+	avefreec = freec;
 	do_div(avefreec, ngroups);
 	ndirs = percpu_counter_read_positive(&sbi->s_dirs_counter);
 
-- 
2.20.1

