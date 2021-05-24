Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF70E38E56E
	for <lists+linux-ext4@lfdr.de>; Mon, 24 May 2021 13:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhEXL2H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 May 2021 07:28:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3644 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbhEXL2G (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 May 2021 07:28:06 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FpZZY5MfyzNyyF
        for <linux-ext4@vger.kernel.org>; Mon, 24 May 2021 19:23:01 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:26:37 +0800
Received: from [10.174.179.184] (10.174.179.184) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:26:36 +0800
Subject: [PATCH 12/12] ext2ed: fix potential NULL pointer dereference in,
 dupstr()
From:   Wu Guanghao <wuguanghao3@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
References: <266bc52e-e279-ce84-0e1f-1405b9bc6174@huawei.com>
Message-ID: <f77ce978-86ed-7a25-abaa-4267592db28e@huawei.com>
Date:   Mon, 24 May 2021 19:26:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <266bc52e-e279-ce84-0e1f-1405b9bc6174@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.184]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

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
