Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E7B3953AE
	for <lists+linux-ext4@lfdr.de>; Mon, 31 May 2021 03:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhEaBcH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 May 2021 21:32:07 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6079 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhEaBcG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 May 2021 21:32:06 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ftd2Q5N1BzYmkL
        for <linux-ext4@vger.kernel.org>; Mon, 31 May 2021 09:27:42 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 09:30:25 +0800
Received: from [10.174.179.184] (10.174.179.184) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 09:30:24 +0800
Subject: [PATCH V2 06/12] append_pathname: check the value returned by realloc
 to avoid segfault
From:   Wu Guanghao <wuguanghao3@huawei.com>
To:     <linux-ext4@vger.kernel.org>,
        =?UTF-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
References: <00ad4a90-8a40-24c1-98d9-eb5f0da42436@huawei.com>
Message-ID: <892d9908-2346-f410-3e25-87bd0b458a2e@huawei.com>
Date:   Mon, 31 May 2021 09:30:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <00ad4a90-8a40-24c1-98d9-eb5f0da42436@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.184]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
+		chdir(homedir);
+		abort();
+	}
+	name->path = path;
 	strcpy(&name->path[name->len], str);
 	name->len += len;
 }
-- 
