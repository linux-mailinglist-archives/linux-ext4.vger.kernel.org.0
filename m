Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0853238E56A
	for <lists+linux-ext4@lfdr.de>; Mon, 24 May 2021 13:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhEXL10 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 May 2021 07:27:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5754 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbhEXL1Z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 May 2021 07:27:25 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpZYp0QCszmkp3
        for <linux-ext4@vger.kernel.org>; Mon, 24 May 2021 19:22:22 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:25:56 +0800
Received: from [10.174.179.184] (10.174.179.184) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:25:56 +0800
Subject: [PATCH 11/12] misc/lsattr: check whether path is NULL in,
 lsattr_dir_proc()
From:   Wu Guanghao <wuguanghao3@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
References: <266bc52e-e279-ce84-0e1f-1405b9bc6174@huawei.com>
Message-ID: <33b89334-78cc-a7a3-941f-9576fbd24291@huawei.com>
Date:   Mon, 24 May 2021 19:25:56 +0800
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

In lsattr_dir_proc(), if malloc() return NULL, it will cause
a segmentation fault problem.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
---
 misc/lsattr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/misc/lsattr.c b/misc/lsattr.c
index 0d954376..f3212069 100644
--- a/misc/lsattr.c
+++ b/misc/lsattr.c
@@ -144,6 +144,12 @@ static int lsattr_dir_proc (const char * dir_name, struct dirent * de,
 	int dir_len = strlen(dir_name);

 	path = malloc(dir_len + strlen (de->d_name) + 2);
+	if (!path) {
+		fprintf(stderr, "%s",
+			_("Couldn't allocate path variable "
+			  "in lsattr_dir_proc"));
+		return -1;
+	}

 	if (dir_len && dir_name[dir_len-1] == '/')
 		sprintf (path, "%s%s", dir_name, de->d_name);
-- 
