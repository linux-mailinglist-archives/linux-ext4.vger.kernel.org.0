Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250E94671DF
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Dec 2021 07:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhLCGbR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Dec 2021 01:31:17 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:29084 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhLCGbQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Dec 2021 01:31:16 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J52ql6FqWz1DJlq;
        Fri,  3 Dec 2021 14:25:07 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 14:27:51 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 14:27:51 +0800
Message-ID: <10e7ffbc-2d79-f970-a55a-a219ebd32f24@huawei.com>
Date:   Fri, 3 Dec 2021 14:27:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: [PATCH 2/6] lib/ss: check whether argp is null before accessing it in
 ss_execute_command()
From:   zhanchengbin <zhanchengbin1@huawei.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>
References: <37c58382-9714-7e99-6c4d-01b78cfdbd26@huawei.com>
In-Reply-To: <37c58382-9714-7e99-6c4d-01b78cfdbd26@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml500001.china.huawei.com (7.185.36.227) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In ss_execute_command(), we should check whether argp is null before 
accessing it,
otherwise the null potinter dereference error may occur.

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
  lib/ss/execute_cmd.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/lib/ss/execute_cmd.c b/lib/ss/execute_cmd.c
index d443a468..b6e4a5dc 100644
--- a/lib/ss/execute_cmd.c
+++ b/lib/ss/execute_cmd.c
@@ -171,6 +171,8 @@ int ss_execute_command(int sci_idx, register char 
*argv[])
      for (argp = argv; *argp; argp++)
          argc++;
      argp = (char **)malloc((argc+1)*sizeof(char *));
+    if (argp == NULL)
+        return (SS_ET_COMMAND_NOT_FOUND);
      for (i = 0; i <= argc; i++)
          argp[i] = argv[i];
      i = really_execute_command(sci_idx, argc, &argp);
-- 
2.23.0
