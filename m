Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5493953AF
	for <lists+linux-ext4@lfdr.de>; Mon, 31 May 2021 03:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhEaBdN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 May 2021 21:33:13 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6080 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhEaBdL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 May 2021 21:33:11 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ftd3h5DkzzYmyV
        for <linux-ext4@vger.kernel.org>; Mon, 31 May 2021 09:28:48 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 09:31:31 +0800
Received: from [10.174.179.184] (10.174.179.184) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 09:31:30 +0800
Subject: [PATCH V2 07/12] argv_parse: check return value of malloc in
 argv_parse()
From:   Wu Guanghao <wuguanghao3@huawei.com>
To:     <linux-ext4@vger.kernel.org>,
        =?UTF-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
References: <00ad4a90-8a40-24c1-98d9-eb5f0da42436@huawei.com>
Message-ID: <40063d0f-09dd-c7e6-fbd4-19b4438284ee@huawei.com>
Date:   Mon, 31 May 2021 09:31:30 +0800
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

In argv_parse(), return value of malloc should be checked
whether it is NULL, otherwise, it may cause a segfault error.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
---
 lib/support/argv_parse.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/support/argv_parse.c b/lib/support/argv_parse.c
index d22f6344..1ef9c014 100644
--- a/lib/support/argv_parse.c
+++ b/lib/support/argv_parse.c
@@ -116,6 +116,8 @@ int argv_parse(char *in_buf, int *ret_argc, char ***ret_argv)
 	if (argv == 0) {
 		argv = malloc(sizeof(char *));
 		free(buf);
+		if (!argv)
+			return -1;
 	}
 	argv[argc] = 0;
 	if (ret_argc)
-- 
