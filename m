Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9819C3B7EE8
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 10:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbhF3IaD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 04:30:03 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:9301 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbhF3IaD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Jun 2021 04:30:03 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GFDps6rhvz1BTPH
        for <linux-ext4@vger.kernel.org>; Wed, 30 Jun 2021 16:22:13 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 16:27:33 +0800
Received: from huawei.com (10.175.104.170) by dggpemm500014.china.huawei.com
 (7.185.36.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 30 Jun
 2021 16:27:32 +0800
From:   wuguanghao <wuguanghao3@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <artem.blagodarenko@gmail.com>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>,
        <wuguanghao3@huawei.com>
Subject: [PATCH v2 06/12] append_pathname: check the value returned by realloc
Date:   Wed, 30 Jun 2021 16:27:18 +0800
Message-ID: <20210630082724.50838-7-wuguanghao3@huawei.com>
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

In append_pathname(), we need to add a new path to save the value returned by realloc,
otherwise the name->path may be NULL, causing segfault

Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 contrib/fsstress.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/contrib/fsstress.c b/contrib/fsstress.c
index 2a983482..07433205 100644
--- a/contrib/fsstress.c
+++ b/contrib/fsstress.c
@@ -599,7 +599,7 @@ void add_to_flist(int ft, int id, int parent)
 void append_pathname(pathname_t * name, char *str)
 {
 	int len;
-
+	char *path; 
 	len = strlen(str);
 #ifdef DEBUG
 	if (len && *str == '/' && name->len == 0) {
@@ -609,7 +609,13 @@ void append_pathname(pathname_t * name, char *str)
 
 	}
 #endif
-	name->path = realloc(name->path, name->len + 1 + len);
+	path = realloc(name->path, name->len + 1 + len);
+	if (path == NULL) {
+		fprintf(stderr, "fsstress: append_pathname realloc failed\n");
+		chdir(homedir);
+		abort();
+	}
+	name->path = path;
 	strcpy(&name->path[name->len], str);
 	name->len += len;
 }
-- 
2.19.1

