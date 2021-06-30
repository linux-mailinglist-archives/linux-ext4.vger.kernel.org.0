Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71DD3B7EEE
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 10:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbhF3IaM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 04:30:12 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6028 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbhF3IaL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Jun 2021 04:30:11 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GFDq252C3zXmpQ
        for <linux-ext4@vger.kernel.org>; Wed, 30 Jun 2021 16:22:22 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 16:27:35 +0800
Received: from huawei.com (10.175.104.170) by dggpemm500014.china.huawei.com
 (7.185.36.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 30 Jun
 2021 16:27:34 +0800
From:   wuguanghao <wuguanghao3@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <artem.blagodarenko@gmail.com>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>,
        <wuguanghao3@huawei.com>
Subject: [PATCH v2 11/12] misc/lsattr: check whether path is NULL in lsattr_dir_proc()
Date:   Wed, 30 Jun 2021 16:27:23 +0800
Message-ID: <20210630082724.50838-12-wuguanghao3@huawei.com>
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
2.19.1

