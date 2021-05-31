Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7A63953AB
	for <lists+linux-ext4@lfdr.de>; Mon, 31 May 2021 03:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhEaBaE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 May 2021 21:30:04 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2792 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhEaBaD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 May 2021 21:30:03 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ftcxq6SCxzWq5x
        for <linux-ext4@vger.kernel.org>; Mon, 31 May 2021 09:23:43 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 09:28:23 +0800
Received: from [10.174.179.184] (10.174.179.184) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 09:28:23 +0800
Subject: [PATCH V2 04/12] ss_add_info_dir: fix memory leak and check
 whether,NULL pointer
From:   Wu Guanghao <wuguanghao3@huawei.com>
To:     <linux-ext4@vger.kernel.org>,
        =?UTF-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
References: <00ad4a90-8a40-24c1-98d9-eb5f0da42436@huawei.com>
Message-ID: <03398446-66ea-01cb-e21a-b4841f325254@huawei.com>
Date:   Mon, 31 May 2021 09:28:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <00ad4a90-8a40-24c1-98d9-eb5f0da42436@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.184]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
+    if (dirs[n_dirs] == (char *)NULL) {
+        *code_ptr = errno;
+        return;
+    }
     strcpy(dirs[n_dirs], info_dir);
     *code_ptr = 0;
 }
-- 
