Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D852432E68
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Oct 2021 08:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbhJSGjm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Oct 2021 02:39:42 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:29908 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhJSGjk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Oct 2021 02:39:40 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HYP7T3NXzzbnLs;
        Tue, 19 Oct 2021 14:32:53 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Tue, 19
 Oct 2021 14:37:25 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next v3 1/5] ext4: init 'seq' with the value which set in 'ext4_multi_mount_protect'
Date:   Tue, 19 Oct 2021 14:49:55 +0800
Message-ID: <20211019064959.625557-2-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211019064959.625557-1-yebin10@huawei.com>
References: <20211019064959.625557-1-yebin10@huawei.com>
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

If two host have the same nodename, and seq start from 0, May cause the
detection mechanism to fail.
So init 'seq' with the value which set in 'ext4_multi_mount_protect' to
accelerate conflict detection.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/mmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index cebea4270817..11627ff002d3 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -132,7 +132,7 @@ static int kmmpd(void *data)
 	struct buffer_head *bh = EXT4_SB(sb)->s_mmp_bh;
 	struct mmp_struct *mmp;
 	ext4_fsblk_t mmp_block;
-	u32 seq = 0;
+	u32 seq;
 	unsigned long failed_writes = 0;
 	int mmp_update_interval = le16_to_cpu(es->s_mmp_update_interval);
 	unsigned mmp_check_interval;
@@ -143,6 +143,7 @@ static int kmmpd(void *data)
 	mmp_block = le64_to_cpu(es->s_mmp_block);
 	mmp = (struct mmp_struct *)(bh->b_data);
 	mmp->mmp_time = cpu_to_le64(ktime_get_real_seconds());
+	seq = le32_to_cpu(mmp->mmp_seq);
 	/*
 	 * Start with the higher mmp_check_interval and reduce it if
 	 * the MMP block is being updated on time.
-- 
2.31.1

