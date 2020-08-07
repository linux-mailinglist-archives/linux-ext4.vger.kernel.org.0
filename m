Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367FC23E72E
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Aug 2020 08:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgHGGUl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Aug 2020 02:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHGGUk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Aug 2020 02:20:40 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A150FC061574
        for <linux-ext4@vger.kernel.org>; Thu,  6 Aug 2020 23:20:40 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d22so461323pfn.5
        for <linux-ext4@vger.kernel.org>; Thu, 06 Aug 2020 23:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=6vY6GJ3kfPSltzYXOecOlzCALH+UEY1kn8sEmSJE0Cg=;
        b=J1OXVwA0HiXdxBfVPQGR2XQyBeu7lZKwg1/nUeV6Cepu1RRZCVlTvDtnVYBlfgal5K
         pG3nKVuXKz+6lT8KJkscp19HDt91kNVRZEQQ8ue+6cxLaJNm5kZvz9nyIkBSkfkL8m87
         h7haZiRpWx81N5rL3w7Jq0t0SxnGW/NVLa6vK/yd92O0lMSkLvzHn1YFBto2PKC7qLDt
         tDYIfYMgYFrxxQwhClN8ZpjeIcTORQwptEfv2Tk9lECdiK2NDV1tzvSNiGugD2pJqYR9
         Qr15esBBmyCq78QXFtjAnR8T04jt83lQoT0b4cZJpDNwtrLJzbFeQUyLOjHQakliWaix
         bxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=6vY6GJ3kfPSltzYXOecOlzCALH+UEY1kn8sEmSJE0Cg=;
        b=sV7/LBAcH4RFXKAbo85lHbQ3Rj6D3kBHnkzlCv3AkjhjzeMJmGnpFwelcWVOgJ9Qsa
         mO/V/S7JS9v67MgCvMWG61AI3hlf29GD/inz0GU0MkM0gDHzYFOs8EixRHx3JU0REYD3
         0cFQsHuqPeAo42JQCt9HhM1CzPUGzS5hHe4ac0MiXk2DFHTrYXmwPXKmuUzvuNPUxj7v
         E/cMPdpRX245aiGMUIMaLzc+rzYkq66zP52AnRR7gb8VvBuqS3Oe7msqOKAvI7RTGDFL
         vtdx5EJv2wNE8pyL1t+DOdYmAdpnzNajsXi02oCzFvkfoJy5sytNMbP+fhg093Eu39a5
         zFcQ==
X-Gm-Message-State: AOAM532gKCAVPQJ/8giBju4EHtK9UPqyZ0KmmB5rRVjMqnQfFBIhA5Kn
        8/rJYVhoa955EkmSU4+SsNluihoDMPs=
X-Google-Smtp-Source: ABdhPJylgyc4A5sV1UhiopaOOQ5iDLfkl62lz1bfgBbYWpdlLR5ft1Oe9OucZLy6nEz5EQWKEUT8LQ==
X-Received: by 2002:aa7:9f5a:: with SMTP id h26mr11585980pfr.114.1596781240066;
        Thu, 06 Aug 2020 23:20:40 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.44])
        by smtp.gmail.com with ESMTPSA id l17sm11792127pff.126.2020.08.06.23.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 23:20:39 -0700 (PDT)
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH v2 2/2] ext4: rename system_blks to s_system_blks inside
 ext4_sb_info
Message-ID: <b37bb523-8d3f-a6d4-f2b2-a321602c26e3@gmail.com>
Date:   Fri, 7 Aug 2020 14:20:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
 fs/ext4/ext4.h           |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 16e9b2f..69240b4 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -138,7 +138,7 @@ static void debug_print_tree(struct ext4_sb_info *sbi)
 
 	printk(KERN_INFO "System zones: ");
 	rcu_read_lock();
-	system_blks = rcu_dereference(sbi->system_blks);
+	system_blks = rcu_dereference(sbi->s_system_blks);
 	node = rb_first(&system_blks->root);
 	while (node) {
 		entry = rb_entry(node, struct ext4_system_zone, node);
@@ -263,11 +263,11 @@ int ext4_setup_system_zone(struct super_block *sb)
 	int ret;
 
 	if (!test_opt(sb, BLOCK_VALIDITY)) {
-		if (sbi->system_blks)
+		if (sbi->s_system_blks)
 			ext4_release_system_zone(sb);
 		return 0;
 	}
-	if (sbi->system_blks)
+	if (sbi->s_system_blks)
 		return 0;
 
 	system_blks = kzalloc(sizeof(*system_blks), GFP_KERNEL);
@@ -308,7 +308,7 @@ int ext4_setup_system_zone(struct super_block *sb)
 	 * with ext4_data_block_valid() accessing the rbtree at the same
 	 * time.
 	 */
-	rcu_assign_pointer(sbi->system_blks, system_blks);
+	rcu_assign_pointer(sbi->s_system_blks, system_blks);
 
 	if (test_opt(sb, DEBUG))
 		debug_print_tree(sbi);
@@ -333,9 +333,9 @@ void ext4_release_system_zone(struct super_block *sb)
 {
 	struct ext4_system_blocks *system_blks;
 
-	system_blks = rcu_dereference_protected(EXT4_SB(sb)->system_blks,
+	system_blks = rcu_dereference_protected(EXT4_SB(sb)->s_system_blks,
 					lockdep_is_held(&sb->s_umount));
-	rcu_assign_pointer(EXT4_SB(sb)->system_blks, NULL);
+	rcu_assign_pointer(EXT4_SB(sb)->s_system_blks, NULL);
 
 	if (system_blks)
 		call_rcu(&system_blks->rcu, ext4_destroy_system_zone);
@@ -353,7 +353,7 @@ int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,
 	 * mount option.
 	 */
 	rcu_read_lock();
-	system_blks = rcu_dereference(sbi->system_blks);
+	system_blks = rcu_dereference(sbi->s_system_blks);
 	ret = ext4_data_block_valid_rcu(sbi, system_blks, start_blk,
 					count);
 	rcu_read_unlock();
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 8ca9adf..d60a462 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1470,7 +1470,7 @@ struct ext4_sb_info {
 	int s_jquota_fmt;			/* Format of quota to use */
 #endif
 	unsigned int s_want_extra_isize; /* New inodes should reserve # bytes */
-	struct ext4_system_blocks __rcu *system_blks;
+	struct ext4_system_blocks __rcu *s_system_blks;
 
 #ifdef EXTENTS_STATS
 	/* ext4 extents stats */
-- 
1.8.3.1
