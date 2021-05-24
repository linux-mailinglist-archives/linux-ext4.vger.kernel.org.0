Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE77C38E567
	for <lists+linux-ext4@lfdr.de>; Mon, 24 May 2021 13:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhEXL0y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 May 2021 07:26:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5677 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbhEXL0X (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 May 2021 07:26:23 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpZYS1wyGz1BQwD
        for <linux-ext4@vger.kernel.org>; Mon, 24 May 2021 19:22:04 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:24:54 +0800
Received: from [10.174.179.184] (10.174.179.184) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:24:54 +0800
Subject: [PATCH 09/12] lib/ss/error.c: check return value malloc in ss_name()
From:   Wu Guanghao <wuguanghao3@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
References: <266bc52e-e279-ce84-0e1f-1405b9bc6174@huawei.com>
Message-ID: <f9c1241d-2cd4-32f2-230b-db5db16eb901@huawei.com>
Date:   Mon, 24 May 2021 19:24:53 +0800
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

In ss_name(), we should check return value of malloc(),
otherwise, it may cause a segmentation fault problem.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
---
 lib/ss/error.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/ss/error.c b/lib/ss/error.c
index 8d345a9f..656b71be 100644
--- a/lib/ss/error.c
+++ b/lib/ss/error.c
@@ -42,6 +42,8 @@ char *ss_name(int sci_idx)
 			 (strlen(infop->subsystem_name)+
 			  strlen(infop->current_request)+
 			  4));
+	if (ret_val == (char *)NULL)
+		return ((char *)NULL);
 	cp = ret_val;
 	cp1 = infop->subsystem_name;
 	while (*cp1)
-- 
