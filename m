Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1631238E553
	for <lists+linux-ext4@lfdr.de>; Mon, 24 May 2021 13:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbhEXLYs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 May 2021 07:24:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3978 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbhEXLYo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 May 2021 07:24:44 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FpZX80cG1zmZk7
        for <linux-ext4@vger.kernel.org>; Mon, 24 May 2021 19:20:56 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:23:15 +0800
Received: from [10.174.179.184] (10.174.179.184) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:23:15 +0800
Subject: [PATCH 06/12] append_pathname: check the value returned by realloc to
 avoid segfault
From:   Wu Guanghao <wuguanghao3@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
References: <266bc52e-e279-ce84-0e1f-1405b9bc6174@huawei.com>
Message-ID: <07fe127f-3814-7d12-dea6-b84d9ab4410e@huawei.com>
Date:   Mon, 24 May 2021 19:23:15 +0800
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

In append_pathname(), we need to add a new path to save the value returned by realloc,
otherwise the name->path may be NULL, causing segfault

Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 contrib/fsstress.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/contrib/fsstress.c b/contrib/fsstress.c
index 2a983482..530bd920 100644
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
+		chadir(homedir);
+		abort();
+	}
+	name->path = path;
 	strcpy(&name->path[name->len], str);
 	name->len += len;
 }
-- 
