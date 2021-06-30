Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2B13B7EEA
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 10:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbhF3IaI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 04:30:08 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6025 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbhF3IaH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Jun 2021 04:30:07 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GFDpw0vh5zXmKT
        for <linux-ext4@vger.kernel.org>; Wed, 30 Jun 2021 16:22:16 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 16:27:35 +0800
Received: from huawei.com (10.175.104.170) by dggpemm500014.china.huawei.com
 (7.185.36.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 30 Jun
 2021 16:27:35 +0800
From:   wuguanghao <wuguanghao3@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <artem.blagodarenko@gmail.com>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>,
        <wuguanghao3@huawei.com>
Subject: [PATCH v2 12/12] ext2ed: fix potential NULL pointer dereference in dupstr()
Date:   Wed, 30 Jun 2021 16:27:24 +0800
Message-ID: <20210630082724.50838-13-wuguanghao3@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210630082724.50838-2-wuguanghao3@huawei.com>
References: <20210630082724.50838-2-wuguanghao3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhiqiang Liu <liuzhiqiang26@huawei.com>

In dupstr(), we should check return value of malloc().

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
Reviewed-by: Wu Bo <wubo40@huawei.com>
---
 ext2ed/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ext2ed/main.c b/ext2ed/main.c
index f7e7d7df..9d33a8e1 100644
--- a/ext2ed/main.c
+++ b/ext2ed/main.c
@@ -524,6 +524,8 @@ char *dupstr (char *src)
 	char *ptr;
 
 	ptr=(char *) malloc (strlen (src)+1);
+	if (!ptr)
+		return NULL;
 	strcpy (ptr,src);
 	return (ptr);
 }
-- 
2.19.1

