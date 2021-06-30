Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8453B7EF1
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 10:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhF3IaQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 04:30:16 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:9327 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbhF3IaO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Jun 2021 04:30:14 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GFDrL5Zcrz74JM
        for <linux-ext4@vger.kernel.org>; Wed, 30 Jun 2021 16:23:30 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 16:27:32 +0800
Received: from huawei.com (10.175.104.170) by dggpemm500014.china.huawei.com
 (7.185.36.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 30 Jun
 2021 16:27:32 +0800
From:   wuguanghao <wuguanghao3@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <artem.blagodarenko@gmail.com>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>,
        <wuguanghao3@huawei.com>
Subject: [PATCH v2 04/12] ss_add_info_dir: fix memory leak and check whether
Date:   Wed, 30 Jun 2021 16:27:16 +0800
Message-ID: <20210630082724.50838-5-wuguanghao3@huawei.com>
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
index 5204401b..6768b9b1 100644
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
+    if (dirs[n_dirs] == (char *)NULL) {
+        *code_ptr = errno;
+        return;
+    }
     strcpy(dirs[n_dirs], info_dir);
     *code_ptr = 0;
 }
-- 
2.19.1

