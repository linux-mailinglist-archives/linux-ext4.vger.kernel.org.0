Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12931401D26
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Sep 2021 16:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243608AbhIFOjF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Sep 2021 10:39:05 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15299 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243494AbhIFOi6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Sep 2021 10:38:58 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H39wM5Rd5z8stB;
        Mon,  6 Sep 2021 22:37:23 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Mon, 6 Sep
 2021 22:37:51 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next 5/6] ext4: avoid to double free s_mmp_bh
Date:   Mon, 6 Sep 2021 22:47:53 +0800
Message-ID: <20210906144754.2601607-6-yebin10@huawei.com>
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

If call read_mmp_block failed then s_mmp_bh will be freed in read_mmp_block.
Kmmpd wait to be killed, ext4_stop_mmpd stop kmmpd and also release s_mmp_bh.
To avoid double free, just set EXT4_SB(sb)->s_mmp_bh with NULL.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/mmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 2a1473e4a9de..eed854bb6194 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -218,6 +218,7 @@ static int kmmpd(void *data)
 				ext4_error_err(sb, -retval,
 					       "error reading MMP data: %d",
 					       retval);
+				EXT4_SB(sb)->s_mmp_bh = NULL;
 				goto wait_to_exit;
 			}
 
-- 
2.31.1

