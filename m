Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177843D85B9
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jul 2021 03:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhG1B4g (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Jul 2021 21:56:36 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:12273 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbhG1B4f (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Jul 2021 21:56:35 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GZGp562Nrz1CPbH;
        Wed, 28 Jul 2021 09:50:37 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 09:56:24 +0800
Received: from huawei.com (10.175.104.170) by dggpemm500014.china.huawei.com
 (7.185.36.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 28 Jul
 2021 09:56:23 +0800
From:   wuguanghao <wuguanghao3@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>
CC:     <linfeilong@huawei.com>, <liuzhiqiang26@huawei.com>,
        <wuguanghao3@huawei.com>
Subject: [PATCH v3 04/12] ss_add_info_dir: don't zap the info->info_dirs and check whether
Date:   Wed, 28 Jul 2021 09:56:45 +0800
Message-ID: <20210728015648.284588-2-wuguanghao3@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210728015648.284588-1-wuguanghao3@huawei.com>
References: <20210728015648.284588-1-wuguanghao3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wu Guanghao <wuguanghao3@huawei.com>

In ss_add_info_dir(), don't zap the info->info_dirs. At the same time, it is necessary
to check whether dirs[n_dirs] is a null pointer, otherwise a segmentation
fault will occur.

Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Reviewed-by: Wu Bo <wubo40@huawei.com>
---
 lib/ss/help.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/ss/help.c b/lib/ss/help.c
index 5204401b..b4465bfe 100644
--- a/lib/ss/help.c
+++ b/lib/ss/help.c
@@ -148,13 +148,16 @@ void ss_add_info_dir(int sci_idx, char *info_dir, int *code_ptr)
     dirs = (char **)realloc((char *)dirs,
 			    (unsigned)(n_dirs + 2)*sizeof(char *));
     if (dirs == (char **)NULL) {
-	info->info_dirs = (char **)NULL;
 	*code_ptr = errno;
 	return;
     }
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
2.27.0

