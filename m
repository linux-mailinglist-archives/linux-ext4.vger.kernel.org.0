Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410453C687C
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jul 2021 04:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhGMC2s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Jul 2021 22:28:48 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:10473 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhGMC2r (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Jul 2021 22:28:47 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GP4D02cX0zccnW;
        Tue, 13 Jul 2021 10:22:40 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 13
 Jul 2021 10:25:56 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <yukuai3@huawei.com>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next] ext4: Fix access uninitialized 'retval' in kmmpd
Date:   Tue, 13 Jul 2021 10:27:28 +0800
Message-ID: <20210713022728.2533770-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If (!ext4_has_feature_mmp(sb)) then goto 'wait_to_exit' label, but
retval not be uninitialized.

Fixes: 61bb4a1c417e ("ext4: fix possible UAF when remounting r/o a mmp-protected file system")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/mmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index bc364c119af6..cebea4270817 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -138,7 +138,7 @@ static int kmmpd(void *data)
 	unsigned mmp_check_interval;
 	unsigned long last_update_time;
 	unsigned long diff;
-	int retval;
+	int retval = 0;
 
 	mmp_block = le64_to_cpu(es->s_mmp_block);
 	mmp = (struct mmp_struct *)(bh->b_data);
-- 
2.31.1

