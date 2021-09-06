Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39E1401D22
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Sep 2021 16:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243594AbhIFOjE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Sep 2021 10:39:04 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19013 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243551AbhIFOi6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Sep 2021 10:38:58 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H39rJ4zg3zbmG5;
        Mon,  6 Sep 2021 22:33:52 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Mon, 6 Sep
 2021 22:37:51 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next 6/6] ext4: fix possible store wrong check interval value in disk when umount
Date:   Mon, 6 Sep 2021 22:47:54 +0800
Message-ID: <20210906144754.2601607-7-yebin10@huawei.com>
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

Test follow steps:
1. mkfs.ext4 /dev/sda -O mmp
2. mount /dev/sda  /mnt
3. wait for about 1 minute
4. umount mnt
5. debugfs /dev/sda
6. dump_mmp
7. fsck.ext4 /dev/sda

I found 'check_interval' is range in [5, 10]. And sometime run fsck
print "MMP interval is 10 seconds and total wait time is 42 seconds.
Please wait...".
kmmpd:
...
	if (diff < mmp_update_interval * HZ)
		schedule_timeout_interruptible(mmp_update_interval * HZ - diff);
	 diff = jiffies - last_update_time;
...
	mmp_check_interval = max(min(EXT4_MMP_CHECK_MULT * diff / HZ,
				EXT4_MMP_MAX_CHECK_INTERVAL),
			        EXT4_MMP_MIN_CHECK_INTERVAL);
	mmp->mmp_check_interval = cpu_to_le16(mmp_check_interval);
...
We will call ext4_stop_mmpd to stop kmmpd kthread when umount, and
schedule_timeout_interruptible will be interrupted, so 'diff' maybe
little than mmp_update_interval. Then mmp_check_interval will range
in [EXT4_MMP_MAX_CHECK_INTERVAL, EXT4_MMP_CHECK_MULT * diff / HZ].
To solve this issue, if 'diff' little then mmp_update_interval * HZ
just break loop, don't update check interval.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/mmp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index eed854bb6194..41c0a03019db 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -205,6 +205,14 @@ static int kmmpd(void *data)
 			schedule_timeout_interruptible(mmp_update_interval *
 						       HZ - diff);
 			diff = jiffies - last_update_time;
+			/* If 'diff' little 'than mmp_update_interval * HZ', it
+			 * means someone call ext4_stop_mmpd to stop kmmpd
+			 * kthread. We don't need to update mmp_check_interval
+			 * any more, as 'diff' is not exact value.
+			 */
+			if (unlikely(diff < mmp_update_interval * HZ &&
+			    kthread_should_stop()))
+				break;
 		}
 
 		/*
-- 
2.31.1

