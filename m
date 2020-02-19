Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46CE3163AD7
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Feb 2020 04:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgBSDKh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Feb 2020 22:10:37 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:28837 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbgBSDKg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Feb 2020 22:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582081836; x=1613617836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=e1oXJfZBSx36T8zyqlO7Ym0sxxdftjyL/oc8QOwGnV8=;
  b=U8bAmS7gjatXjlRGsD/kgVmJivvWu7sPODohlrIty5DwKIih5kq/TVRz
   FMKdcF51y2qV1lw6gsq9MTNEGjIPZJg3Fdd1iOIxNO8NrCp18nyutA3zt
   wkKs8ig7Xeh+QjzpbB9SawY4xnvrnU0Wke45NGogmd5RUcFz8oY9llvLD
   c=;
IronPort-SDR: iw7D6vEZjVsgrOJTCP4ICogjQU/2m6YQHtSB6AmgtpK//Y6SfZDwy1AvDJgXeHFGlpe2r5lp5b
 lnmWApqcS0/g==
X-IronPort-AV: E=Sophos;i="5.70,458,1574121600"; 
   d="scan'208";a="16986532"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 19 Feb 2020 03:10:25 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 61B63A27DF;
        Wed, 19 Feb 2020 03:10:23 +0000 (UTC)
Received: from EX13D30UWC001.ant.amazon.com (10.43.162.128) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 19 Feb 2020 03:10:22 +0000
Received: from u3c3f5cfe23135f.ant.amazon.com (10.43.161.235) by
 EX13D30UWC001.ant.amazon.com (10.43.162.128) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 19 Feb 2020 03:10:22 +0000
From:   Suraj Jitindar Singh <surajjs@amazon.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <sblbir@amazon.com>, <sjitindarsingh@gmail.com>,
        "Suraj Jitindar Singh" <surajjs@amazon.com>,
        <stable@vger-kernel.org>
Subject: [PATCH 1/3] ext4: introduce macro sbi_array_rcu_deref() to access rcu protected fields
Date:   Tue, 18 Feb 2020 19:08:49 -0800
Message-ID: <20200219030851.2678-2-surajjs@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219030851.2678-1-surajjs@amazon.com>
References: <20200219030851.2678-1-surajjs@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.235]
X-ClientProxiedBy: EX13D33UWB004.ant.amazon.com (10.43.161.225) To
 EX13D30UWC001.ant.amazon.com (10.43.162.128)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The s_group_desc field in the super block info (sbi) is protected by rcu to
prevent access to an invalid pointer during online resize operations.
There are 2 other arrays in sbi, s_group_info and s_flex_groups, which
require similar rcu protection which is introduced in the subsequent
patches. Introduce a helper macro sbi_array_rcu_deref() to be used to
provide rcu protected access to such fields.

Also update the current s_group_desc access site to use the macro.

Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
Cc: stable@vger-kernel.org
---
 fs/ext4/balloc.c | 11 +++++------
 fs/ext4/ext4.h   | 17 +++++++++++++++++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 5368bf67300b..8fd0b3cdab4c 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -281,14 +281,13 @@ struct ext4_group_desc * ext4_get_group_desc(struct super_block *sb,
 
 	group_desc = block_group >> EXT4_DESC_PER_BLOCK_BITS(sb);
 	offset = block_group & (EXT4_DESC_PER_BLOCK(sb) - 1);
-	rcu_read_lock();
-	bh_p = rcu_dereference(sbi->s_group_desc)[group_desc];
+	bh_p = sbi_array_rcu_deref(sbi, s_group_desc, group_desc);
 	/*
-	 * We can unlock here since the pointer being dereferenced won't be
-	 * dereferenced again. By looking at the usage in add_new_gdb() the
-	 * value isn't modified, just the pointer, and so it remains valid.
+	 * sbi_array_rcu_deref returns with rcu unlocked, this is ok since
+	 * the pointer being dereferenced won't be dereferenced again. By
+	 * looking at the usage in add_new_gdb() the value isn't modified,
+	 * just the pointer, and so it remains valid.
 	 */
-	rcu_read_unlock();
 	if (!bh_p) {
 		ext4_error(sb, "Group descriptor not loaded - "
 			   "block_group = %u, group_desc = %u, desc = %u",
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 149ee0ab6d64..236fc6500340 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1576,6 +1576,23 @@ static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
 		 ino <= le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count));
 }
 
+/*
+ * Returns: sbi->field[index]
+ * Used to access an array element from the following sbi fields which require
+ * rcu protection to avoid dereferencing an invalid pointer due to reassignment
+ * - s_group_desc
+ * - s_group_info
+ * - s_flex_group
+ */
+#define sbi_array_rcu_deref(sbi, field, index)				   \
+({									   \
+	typeof(*((sbi)->field)) _v;					   \
+	rcu_read_lock();						   \
+	_v = ((typeof((sbi)->field))rcu_dereference((sbi)->field))[index]; \
+	rcu_read_unlock();						   \
+	_v;								   \
+})
+
 /*
  * Simulate_fail codes
  */
-- 
2.17.1

