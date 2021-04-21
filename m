Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF07366F89
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Apr 2021 17:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbhDUP4R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Apr 2021 11:56:17 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:10242 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235610AbhDUP4R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 21 Apr 2021 11:56:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UWK2NsT_1619020519;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0UWK2NsT_1619020519)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 21 Apr 2021 23:55:30 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     tytso@mit.edu, Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     Wen Yang <wenyang@linux.alibaba.com>,
        Baoyou Xie <baoyou.xie@alibaba-inc.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/ext4: remove redundant initialization of variable busy
Date:   Wed, 21 Apr 2021 23:54:55 +0800
Message-Id: <20210421155455.51725-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The variable status is being initialized with a value that is never
read and it is being updated later with a new value. The initialization
is redundant and could be removed. Also put the variable declarations
into reverse christmas tree order. Finally, we add the log printing and
ext4_mb_show_pa() for troubleshooting, they are enabled only when
CONFIG_EXT4_DEBUG is set.

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Baoyou Xie <baoyou.xie@alibaba-inc.com>
Cc: linux-ext4@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/ext4/mballoc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a02fadf..1402b14 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -351,6 +351,8 @@ static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
 						ext4_group_t group);
 static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac);
 
+static inline void ext4_mb_show_pa(struct super_block *sb);
+
 /*
  * The algorithm using this percpu seq counter goes below:
  * 1. We sample the percpu discard_pa_seq counter before trying for block
@@ -4217,9 +4219,9 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
 	struct ext4_prealloc_space *pa, *tmp;
 	struct list_head list;
 	struct ext4_buddy e4b;
+	int free_total = 0;
+	int busy, free;
 	int err;
-	int busy = 0;
-	int free, free_total = 0;
 
 	mb_debug(sb, "discard preallocation for group %u\n", group);
 	if (list_empty(&grp->bb_prealloc_list))
@@ -4247,6 +4249,7 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
 
 	INIT_LIST_HEAD(&list);
 repeat:
+	busy = 0;
 	free = 0;
 	ext4_lock_group(sb, group);
 	list_for_each_entry_safe(pa, tmp,
@@ -4255,6 +4258,8 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
 		if (atomic_read(&pa->pa_count)) {
 			spin_unlock(&pa->pa_lock);
 			busy = 1;
+			mb_debug(sb, "used pa while discarding for group %u\n", group);
+			ext4_mb_show_pa(sb);
 			continue;
 		}
 		if (pa->pa_deleted) {
@@ -4300,7 +4305,6 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
 	if (free_total < needed && busy) {
 		ext4_unlock_group(sb, group);
 		cond_resched();
-		busy = 0;
 		goto repeat;
 	}
 	ext4_unlock_group(sb, group);
-- 
1.8.3.1

