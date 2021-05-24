Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2699C38E546
	for <lists+linux-ext4@lfdr.de>; Mon, 24 May 2021 13:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhEXLWr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 May 2021 07:22:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5753 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbhEXLWp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 May 2021 07:22:45 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpZSP3P7yzmkrx
        for <linux-ext4@vger.kernel.org>; Mon, 24 May 2021 19:17:41 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:21:16 +0800
Received: from [10.174.179.184] (10.174.179.184) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:21:16 +0800
Subject: [PATCH 04/12] ss_add_info_dir: fix memory leak and check whether,NULL
 pointer
From:   Wu Guanghao <wuguanghao3@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
References: <266bc52e-e279-ce84-0e1f-1405b9bc6174@huawei.com>
Message-ID: <94591388-2107-6943-8988-5cd3a6371236@huawei.com>
Date:   Mon, 24 May 2021 19:21:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <266bc52e-e279-ce84-0e1f-1405b9bc6174@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.184]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In ss_add_info_dir(), need free info->info_dirs before return,
otherwise it will cause memory leak. At the same time, it is necessary
to check whether dirs[n_dirs] is a null pointer, otherwise a segmentation
fault will occur.

Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Reviewed-by: Wu Bo <wubo40@huawei.com>
---
 lib/ss/help.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/ss/help.c b/lib/ss/help.c
index 5204401b..429f410e 100644
--- a/lib/ss/help.c
+++ b/lib/ss/help.c
@@ -148,6 +148,7 @@ void ss_add_info_dir(int sci_idx, char *info_dir, int *code_ptr)
     dirs = (char **)realloc((char *)dirs,
 			    (unsigned)(n_dirs + 2)*sizeof(char *));
     if (dirs == (char **)NULL) {
+	free(info->info_dirs);
 	info->info_dirs = (char **)NULL;
 	*code_ptr = errno;
 	return;
@@ -155,6 +156,10 @@ void ss_add_info_dir(int sci_idx, char *info_dir, int *code_ptr)
     info->info_dirs = dirs;
     dirs[n_dirs + 1] = (char *)NULL;
     dirs[n_dirs] = malloc((unsigned)strlen(info_dir)+1);
+    if (dirs[n_dirs] = (char *)NULL) {
+        *code_ptr = errno;
+        return;
+    }
     strcpy(dirs[n_dirs], info_dir);
     *code_ptr = 0;
 }
-- 
