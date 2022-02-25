Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6ED54C430B
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Feb 2022 12:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239839AbiBYLFG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Feb 2022 06:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239795AbiBYLFG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Feb 2022 06:05:06 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C92235306
        for <linux-ext4@vger.kernel.org>; Fri, 25 Feb 2022 03:04:32 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m14so8774130lfu.4
        for <linux-ext4@vger.kernel.org>; Fri, 25 Feb 2022 03:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c5+HyQ/v5cvjsalYVTfJ47Msc3WhNhFEzUhO7UhjsEM=;
        b=aJVlwTX7PktbX0Hh4XbjdoVvdw99dia05uPv2WYl8EknEnO2WQXfHr26M8nbeZ0aXA
         7Sb14vbQCtPmNylvQMRPSkDp0IBvl/UcQ6L5hX6qz1gEyRpWlTVU9cwTPtiEQGeGCWUh
         Rn+7i+aBKuzaR1Me6F9X5OHIICw0w5TMLjyrbg4GiLtekEtEVn/WOH2VwROD6YNWIXY5
         iuob1VgtCIeM9j7mCPLFqWFOJ+/WLv5aDMazHKfI9UgkyiPYJ2FEXFQEbNhk3eSPx68Y
         2jWJB3NlhJfEIBSkTRuY2Qz8xLAalYw9zW3IThKuy4vmU2Xf2SfnAKlAAd4i23NL8AnR
         IqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c5+HyQ/v5cvjsalYVTfJ47Msc3WhNhFEzUhO7UhjsEM=;
        b=oUip8iPBQsBWzBl2/RQbwT3pH8iRDU4SSLqAkT8IsRLRDLJGpDomt+i37XH+aOz5gK
         FFEEyAPigcPcdfAgReWbPzpOnoOPbYFZzZwYedtOmuzJjVxc30qGVgkSDNeDi++cyMJg
         9/e8Wf1yRYFknd+XF5ck4hJvzyObnFd4/YIRAYW7HCL0V3k3f5pgeLTaYSi3wuSdrhzm
         u9naIeQyJq3hi81KmIfyFYMZzS4JTi4uQ5ueMIObf3OgGJrVT7evhbSLun0xDlRsd/It
         Krhf7MXNCAKZlTUxbHWpNzXZmBmteWmpg4jRncTnlNwbZSK2XfvsySdlVjMbpGRM020S
         3vIg==
X-Gm-Message-State: AOAM533vEDOCo+zWfmqjMCAhwvezqYwKF3gXmSTn/acDl4+yMYLzsycJ
        cZEEeGi26+jllXcJ4Wlx6GidS4hmD1+787un
X-Google-Smtp-Source: ABdhPJyEZwBcXSU8MGCPwKf7waV/5ELpq3Nq2zG/Dh9tJEYObTem1Gu4YbL1mIISs/AhvIF+8VWY7w==
X-Received: by 2002:a19:ee17:0:b0:443:5f2c:289e with SMTP id g23-20020a19ee17000000b004435f2c289emr4625255lfb.57.1645787070383;
        Fri, 25 Feb 2022 03:04:30 -0800 (PST)
Received: from localhost.localdomain ([83.234.50.195])
        by smtp.gmail.com with ESMTPSA id o3-20020a2ebd83000000b002461808adbdsm223261ljq.106.2022.02.25.03.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 03:04:29 -0800 (PST)
From:   Artem Blagodarenko <artem.blagodarenko@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca,
        Andrew Perepechko <andrew.perepechko@hpe.com>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
Subject: [PATCH] ext4: truncate during setxattr leads to kernel panic
Date:   Fri, 25 Feb 2022 06:04:13 -0500
Message-Id: <20220225110413.1663-1-artem.blagodarenko@gmail.com>
X-Mailer: git-send-email 2.31.1
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

From: Andrew Perepechko <andrew.perepechko@hpe.com>

When changing a large xattr value to a different large xattr value,
the old xattr inode is freed. Truncate during the final iput causes
current transaction restart. Eventually, parent inode bh is marked
dirty and kernel panic happens when jbd2 figures out that this bh
belongs to the committed transaction.

Here is a reproducer

#!/bin/bash
dd if=/dev/zero of=/tmp/ldiskfs bs=1M count=100
mkfs.ext4 -O ea_inode /tmp/ldiskfs -J size=16 -I 512

mkdir -p /tmp/ldiskfs_m
mount -t ext4 /tmp/ldiskfs /tmp/ldiskfs_m -o loop,commit=600,no_mbcache
touch /tmp/ldiskfs_m/file{1..1024}

V=$(for i in `seq 60000`; do echo -n x ; done)
V1="1$V"
V2="2$V"

while true; do
       setfattr -n user.xattr -v $V /tmp/ldiskfs_m/file{1..1024}
       setfattr -n user.xattr -v $V1 /tmp/ldiskfs_m/file{1..1024} &
       setfattr -n user.xattr -v $V2 /tmp/ldiskfs_m/file{1024..1} &
       wait
done

A possible fix is to call this final iput in a separate thread.
This way, setxattr transactions will never be split into two.
Since the setxattr code adds xattr inodes with nlink=0 into the
orphan list, old xattr inodes will be properly cleaned up in
any case.

Signed-off-by: Andrew Perepechko <andrew.perepechko@hpe.com>
Signed-off-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>
HPE-bug-id: LUS-10534
---
 fs/ext4/super.c |  1 +
 fs/ext4/xattr.c | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c5021ca0a28a..8c04c19fa4b8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1199,6 +1199,7 @@ static void ext4_put_super(struct super_block *sb)
 	int aborted = 0;
 	int i, err;
 
+	flush_scheduled_work();
 	ext4_unregister_li_request(sb);
 	ext4_quota_off_umount(sb);
 
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 042325349098..0cadbf4a9f2b 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1544,6 +1544,31 @@ static int ext4_xattr_inode_lookup_create(handle_t *handle, struct inode *inode,
 	return 0;
 }
 
+struct delayed_iput_work {
+	struct work_struct work;
+	struct inode *inode;
+};
+
+static void delayed_iput_fn(struct work_struct *work)
+{
+	struct delayed_iput_work *diwork;
+
+	diwork = container_of(work, struct delayed_iput_work, work);
+	iput(diwork->inode);
+	kfree(diwork);
+}
+
+static void delayed_iput(struct inode *inode, struct delayed_iput_work *work)
+{
+	if (!work) {
+		iput(inode);
+	} else {
+		INIT_WORK(&work->work, delayed_iput_fn);
+		work->inode = inode;
+		schedule_work(&work->work);
+	}
+}
+
 /*
  * Reserve min(block_size/8, 1024) bytes for xattr entries/names if ea_inode
  * feature is enabled.
@@ -1561,6 +1586,7 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 	int in_inode = i->in_inode;
 	struct inode *old_ea_inode = NULL;
 	struct inode *new_ea_inode = NULL;
+	struct delayed_iput_work *diwork = NULL;
 	size_t old_size, new_size;
 	int ret;
 
@@ -1637,7 +1663,11 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 	 * Finish that work before doing any modifications to the xattr data.
 	 */
 	if (!s->not_found && here->e_value_inum) {
-		ret = ext4_xattr_inode_iget(inode,
+		diwork = kmalloc(sizeof(*diwork), GFP_NOFS);
+		if (!diwork)
+			ret = -ENOMEM;
+		else
+			ret = ext4_xattr_inode_iget(inode,
 					    le32_to_cpu(here->e_value_inum),
 					    le32_to_cpu(here->e_hash),
 					    &old_ea_inode);
@@ -1791,7 +1821,7 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 	ret = 0;
 out:
 	iput(old_ea_inode);
-	iput(new_ea_inode);
+	delayed_iput(old_ea_inode, diwork);
 	return ret;
 }
 
-- 
2.31.1

