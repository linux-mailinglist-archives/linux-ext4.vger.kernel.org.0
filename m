Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D46738E565
	for <lists+linux-ext4@lfdr.de>; Mon, 24 May 2021 13:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhEXL02 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 May 2021 07:26:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5537 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbhEXLZz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 May 2021 07:25:55 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FpZXw4v7TzkYj0
        for <linux-ext4@vger.kernel.org>; Mon, 24 May 2021 19:21:36 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:24:26 +0800
Received: from [10.174.179.184] (10.174.179.184) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:24:26 +0800
Subject: [PATCH 08/12] misc: fix potential segmentation fault problem in,
 scandir()
From:   Wu Guanghao <wuguanghao3@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
References: <266bc52e-e279-ce84-0e1f-1405b9bc6174@huawei.com>
Message-ID: <4edd3647-80fa-e22f-7da0-4ae504d5aa5e@huawei.com>
Date:   Mon, 24 May 2021 19:24:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <266bc52e-e279-ce84-0e1f-1405b9bc6174@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.184]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In scandir(), temp_list[num_dent] is allocated by calling
malloc(), we should check whether malloc() returns NULL before
accessing temp_list[num_dent].

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
---
 misc/create_inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/misc/create_inode.c b/misc/create_inode.c
index d62e1cb4..869b0614 100644
--- a/misc/create_inode.c
+++ b/misc/create_inode.c
@@ -771,6 +771,9 @@ static int scandir(const char *dir_name, struct dirent ***name_list,
 		}
 		// add the copy of dirent to the list
 		temp_list[num_dent] = (struct dirent*)malloc((dent->d_reclen + 3) & ~3);
+		if (!temp_list[num_dent]) {
+			goto out;
+		}
 		memcpy(temp_list[num_dent], dent, dent->d_reclen);
 		num_dent++;
 	}
-- 
