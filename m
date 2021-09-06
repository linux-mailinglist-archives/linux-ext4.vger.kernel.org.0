Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C3B401D1F
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Sep 2021 16:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243556AbhIFOjD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Sep 2021 10:39:03 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:15242 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243450AbhIFOi6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Sep 2021 10:38:58 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H39vx2HwNz1DGhl;
        Mon,  6 Sep 2021 22:37:01 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Mon, 6 Sep
 2021 22:37:50 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next 2/6] ext4: introduce last_check_time record previous check time
Date:   Mon, 6 Sep 2021 22:47:50 +0800
Message-ID: <20210906144754.2601607-3-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210906144754.2601607-1-yebin10@huawei.com>
References: <20210906144754.2601607-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

kmmpd:
...
    diff = jiffies - last_update_time;
    if (diff > mmp_check_interval * HZ) {
...
As "mmp_check_interval = 2 * mmp_update_interval", 'diff' always little
than 'mmp_update_interval', so there will never trigger detection.
Introduce last_check_time record previous check time.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/mmp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 12af6dc8457b..89797f12a815 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -152,6 +152,7 @@ static int kmmpd(void *data)
 	int mmp_update_interval = le16_to_cpu(es->s_mmp_update_interval);
 	unsigned mmp_check_interval;
 	unsigned long last_update_time;
+	unsigned long last_check_time;
 	unsigned long diff;
 	int retval = 0;
 
@@ -170,6 +171,7 @@ static int kmmpd(void *data)
 
 	memcpy(mmp->mmp_nodename, init_utsname()->nodename,
 	       sizeof(mmp->mmp_nodename));
+	last_update_time = jiffies;
 
 	while (!kthread_should_stop() && !sb_rdonly(sb)) {
 		if (!ext4_has_feature_mmp(sb)) {
@@ -198,17 +200,18 @@ static int kmmpd(void *data)
 		}
 
 		diff = jiffies - last_update_time;
-		if (diff < mmp_update_interval * HZ)
+		if (diff < mmp_update_interval * HZ) {
 			schedule_timeout_interruptible(mmp_update_interval *
 						       HZ - diff);
+			diff = jiffies - last_update_time;
+		}
 
 		/*
 		 * We need to make sure that more than mmp_check_interval
-		 * seconds have not passed since writing. If that has happened
-		 * we need to check if the MMP block is as we left it.
+		 * seconds have not passed since check. If that has happened
+		 * we need to check if the MMP block is as we write it.
 		 */
-		diff = jiffies - last_update_time;
-		if (diff > mmp_check_interval * HZ) {
+		if (jiffies - last_check_time > mmp_check_interval * HZ) {
 			struct buffer_head *bh_check = NULL;
 			struct mmp_struct *mmp_check;
 
@@ -234,6 +237,7 @@ static int kmmpd(void *data)
 				goto wait_to_exit;
 			}
 			put_bh(bh_check);
+			last_check_time = jiffies;
 		}
 
 		 /*
-- 
2.31.1

