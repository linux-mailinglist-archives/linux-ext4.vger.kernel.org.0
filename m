Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B35B3EF5F4
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Aug 2021 00:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbhHQW5c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Aug 2021 18:57:32 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:39653 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbhHQW5a (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Aug 2021 18:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1629241018; x=1660777018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=MzJcUtfc7iPoM8SpKJzbe6uipwEa0d0bW+92yrWo/JI=;
  b=Zh4YS9A9U6On0vbeRk+xfPilISxkCljePVoR1Fz027xH3Np4SXjma91F
   DZd+MEskarNMCGBKSc5axT5gUjZRNIDRBJUEyy1VoC2PQxF0XbnciPj6U
   TyWVyDfiM06x2C9jOjnrGFot15Mkh4dotJvQ1p73FOVYjWuTDcX7hfkko
   0=;
X-IronPort-AV: E=Sophos;i="5.84,330,1620691200"; 
   d="scan'208";a="153147443"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 17 Aug 2021 22:56:57 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id 514BFA2562;
        Tue, 17 Aug 2021 22:56:56 +0000 (UTC)
Received: from EX13D13UWA003.ant.amazon.com (10.43.160.181) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Tue, 17 Aug 2021 22:56:55 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D13UWA003.ant.amazon.com (10.43.160.181) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Tue, 17 Aug 2021 22:56:55 +0000
Received: from dev-dsk-shaoyi-2b-c0ca772a.us-west-2.amazon.com (172.22.152.76)
 by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP Server id
 15.0.1497.23 via Frontend Transport; Tue, 17 Aug 2021 22:56:54 +0000
Received: by dev-dsk-shaoyi-2b-c0ca772a.us-west-2.amazon.com (Postfix, from userid 13116433)
        id A32B143663; Tue, 17 Aug 2021 22:56:54 +0000 (UTC)
From:   Shaoying Xu <shaoyi@amazon.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <fllinden@amazon.com>, <benh@amazon.com>, <shaoyi@amazon.com>
Subject: [PATCH 1/1] ext4: fix lazy initialization next schedule time computation in more granular unit
Date:   Tue, 17 Aug 2021 22:56:54 +0000
Message-ID: <20210817225654.30487-2-shaoyi@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210817225654.30487-1-shaoyi@amazon.com>
References: <20210817225654.30487-1-shaoyi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ext4 file system has default lazy inode table initialization setup once
it is mounted. However, it has issue on computing the next schedule time
that makes the timeout same amount in jiffies but different real time in
secs if with various HZ values. Therefore, fix by measuring the current
time in a more granular unit nanoseconds and make the next schedule time
independent of the HZ value.

Fixes: bfff68738f1c ("ext4: add support for lazy inode table initialization")
Signed-off-by: Shaoying Xu <shaoyi@amazon.com>
Cc: stable@vger.kernel.org
---
 fs/ext4/super.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dfa09a277b56..399cbe9c14a8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3421,9 +3421,9 @@ static int ext4_run_li_request(struct ext4_li_request *elr)
 	struct super_block *sb = elr->lr_super;
 	ext4_group_t ngroups = EXT4_SB(sb)->s_groups_count;
 	ext4_group_t group = elr->lr_next_group;
-	unsigned long timeout = 0;
 	unsigned int prefetch_ios = 0;
 	int ret = 0;
+	u64 start_time;
 
 	if (elr->lr_mode == EXT4_LI_MODE_PREFETCH_BBITMAP) {
 		elr->lr_next_group = ext4_mb_prefetch(sb, group,
@@ -3460,14 +3460,13 @@ static int ext4_run_li_request(struct ext4_li_request *elr)
 		ret = 1;
 
 	if (!ret) {
-		timeout = jiffies;
+		start_time = ktime_get_real_ns();
 		ret = ext4_init_inode_table(sb, group,
 					    elr->lr_timeout ? 0 : 1);
 		trace_ext4_lazy_itable_init(sb, group);
 		if (elr->lr_timeout == 0) {
-			timeout = (jiffies - timeout) *
-				EXT4_SB(elr->lr_super)->s_li_wait_mult;
-			elr->lr_timeout = timeout;
+			elr->lr_timeout = nsecs_to_jiffies((ktime_get_real_ns() - start_time) *
+				EXT4_SB(elr->lr_super)->s_li_wait_mult);
 		}
 		elr->lr_next_sched = jiffies + elr->lr_timeout;
 		elr->lr_next_group = group + 1;
-- 
2.16.6

