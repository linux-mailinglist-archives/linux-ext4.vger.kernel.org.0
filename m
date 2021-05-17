Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3BD3822F3
	for <lists+linux-ext4@lfdr.de>; Mon, 17 May 2021 04:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbhEQC50 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 May 2021 22:57:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3558 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbhEQC50 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 May 2021 22:57:26 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fk3bl4VfvzmWH5;
        Mon, 17 May 2021 10:53:23 +0800 (CST)
Received: from dggeme759-chm.china.huawei.com (10.3.19.105) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 10:56:05 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggeme759-chm.china.huawei.com (10.3.19.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 17 May 2021 10:56:05 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH] ext4: remove set but rewrite variables
Date:   Mon, 17 May 2021 10:56:05 +0800
Message-ID: <1621220165-11849-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In line 2500 of the ext4_dx_add_entry function, the at variable is
assigned but not used, and it is reassigned in line 2449, so delete
the assignment of the at variable in line 2500.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 fs/ext4/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index afb9d05..18bbf15 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2497,7 +2497,7 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 
 			/* Which index block gets the new entry? */
 			if (at - entries >= icount1) {
-				frame->at = at = at - entries - icount1 + entries2;
+				frame->at = at - entries - icount1 + entries2;
 				frame->entries = entries = entries2;
 				swap(frame->bh, bh2);
 			}
-- 
2.7.4

