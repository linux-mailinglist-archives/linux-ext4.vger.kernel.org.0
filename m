Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478C638E53E
	for <lists+linux-ext4@lfdr.de>; Mon, 24 May 2021 13:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbhEXLVT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 May 2021 07:21:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5534 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbhEXLVS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 May 2021 07:21:18 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FpZRZ3xBdzkYvn
        for <linux-ext4@vger.kernel.org>; Mon, 24 May 2021 19:16:58 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:19:48 +0800
Received: from [10.174.179.184] (10.174.179.184) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:19:48 +0800
Subject: [PATCH 01/12] profile_create_node: set magic before strdup(name) to
 avoid memory leak
From:   Wu Guanghao <wuguanghao3@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
References: <266bc52e-e279-ce84-0e1f-1405b9bc6174@huawei.com>
Message-ID: <fdcf04e8-7fad-886d-eaa2-c8a814269c03@huawei.com>
Date:   Mon, 24 May 2021 19:19:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <266bc52e-e279-ce84-0e1f-1405b9bc6174@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.184]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If new->magic != PROF_MAGIC_NODE, profile_free_node() don't free node.
This will cause the node to be unable to be released correctly and
a memory leak will occur.

Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Reviewed-by: Wu Bo <wubo40@huawei.com>
---
 lib/support/profile.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/support/profile.c b/lib/support/profile.c
index 585ed595..2eb3a9d1 100644
--- a/lib/support/profile.c
+++ b/lib/support/profile.c
@@ -1093,6 +1093,8 @@ errcode_t profile_create_node(const char *name, const char *value,
 	if (!new)
 		return ENOMEM;
 	memset(new, 0, sizeof(struct profile_node));
+	new->magic = PROF_MAGIC_NODE;
+
 	new->name = strdup(name);
 	if (new->name == 0) {
 	    profile_free_node(new);
@@ -1105,7 +1107,6 @@ errcode_t profile_create_node(const char *name, const char *value,
 		    return ENOMEM;
 		}
 	}
-	new->magic = PROF_MAGIC_NODE;

 	*ret_node = new;
 	return 0;
-- 
