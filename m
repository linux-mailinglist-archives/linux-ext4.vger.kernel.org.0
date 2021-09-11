Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B114075A2
	for <lists+linux-ext4@lfdr.de>; Sat, 11 Sep 2021 10:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbhIKIwS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 11 Sep 2021 04:52:18 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:16190 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbhIKIwP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 11 Sep 2021 04:52:15 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H65zL1ykLz1DGjS;
        Sat, 11 Sep 2021 16:50:06 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Sat, 11
 Sep 2021 16:51:01 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next v2 3/6] ext4: compare to local seq and nodename when check conflict
Date:   Sat, 11 Sep 2021 17:00:56 +0800
Message-ID: <20210911090059.1876456-4-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210911090059.1876456-1-yebin10@huawei.com>
References: <20210911090059.1876456-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

As mmp and check_mmp is point to the same data, so there will never
detect conflict.
To solve this issue just compare to local data.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/mmp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index c781b09a78c9..4433fe7e9e86 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -154,6 +154,7 @@ static int kmmpd(void *data)
 	unsigned long last_update_time;
 	unsigned long last_check_time;
 	unsigned long diff;
+	char nodename[64];
 	int retval = 0;
 
 	mmp_block = le64_to_cpu(es->s_mmp_block);
@@ -169,8 +170,8 @@ static int kmmpd(void *data)
 	BUILD_BUG_ON(sizeof(mmp->mmp_bdevname) < BDEVNAME_SIZE);
 	bdevname(bh->b_bdev, mmp->mmp_bdevname);
 
-	memcpy(mmp->mmp_nodename, init_utsname()->nodename,
-	       sizeof(mmp->mmp_nodename));
+	memcpy(nodename, init_utsname()->nodename, sizeof(nodename));
+	memcpy(mmp->mmp_nodename, nodename, sizeof(mmp->mmp_nodename));
 	last_check_time = jiffies;
 
 	while (!kthread_should_stop() && !sb_rdonly(sb)) {
@@ -224,8 +225,8 @@ static int kmmpd(void *data)
 			}
 
 			mmp_check = (struct mmp_struct *)(bh_check->b_data);
-			if (mmp->mmp_seq != mmp_check->mmp_seq ||
-			    memcmp(mmp->mmp_nodename, mmp_check->mmp_nodename,
+			if (seq != mmp_check->mmp_seq ||
+			    memcmp(nodename, mmp_check->mmp_nodename,
 				   sizeof(mmp->mmp_nodename))) {
 				dump_mmp_msg(sb, mmp_check,
 					     "Error while updating MMP info. "
-- 
2.31.1

