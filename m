Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C23F432E6B
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Oct 2021 08:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbhJSGjq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Oct 2021 02:39:46 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:25232 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbhJSGjl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Oct 2021 02:39:41 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HYPCK6Gb4z8thv;
        Tue, 19 Oct 2021 14:36:13 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Tue, 19
 Oct 2021 14:37:26 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next v3 3/5] ext4: get buffer head before read_mmp_block
Date:   Tue, 19 Oct 2021 14:49:57 +0800
Message-ID: <20211019064959.625557-4-yebin10@huawei.com>
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

There is only pass NULL 'bh' in ext4_multi_mount_protect,
So just call sb_getblk get buffer head fisrt, and we will
simplify read_mmp_block function.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/mmp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 4af8b99ade84..6ac6aacd8fa5 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -295,6 +295,10 @@ int ext4_multi_mount_protect(struct super_block *sb,
 		goto failed;
 	}
 
+	bh = sb_getblk(sb, mmp_block);
+	if (bh)
+		goto failed;
+
 	retval = read_mmp_block(sb, &bh, mmp_block);
 	if (retval)
 		goto failed;
-- 
2.31.1

