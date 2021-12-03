Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6904671DB
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Dec 2021 07:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378573AbhLCG3n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Dec 2021 01:29:43 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32870 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhLCG3m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Dec 2021 01:29:42 -0500
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J52rx1Tq0zcbJx;
        Fri,  3 Dec 2021 14:26:09 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 14:26:17 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 14:26:17 +0800
Message-ID: <622dc317-a9cb-2541-b357-a868d31a9605@huawei.com>
Date:   Fri, 3 Dec 2021 14:26:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: [PATCH 1/6] e2fsck: set s->len=0 if malloc() fails in alloc_string()
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

In alloc_string(), when malloc fails, len in the
string structure should be 0.

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
  e2fsck/logfile.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/e2fsck/logfile.c b/e2fsck/logfile.c
index 63e9a12f..f2227ad5 100644
--- a/e2fsck/logfile.c
+++ b/e2fsck/logfile.c
@@ -32,6 +32,8 @@ static void alloc_string(struct string *s, int len)
  {
      s->s = malloc(len);
  /* e2fsck_allocate_memory(ctx, len, "logfile name"); */
+    if (s->s == NULL)
+        s->len = 0;
      s->len = len;
      s->end = 0;
  }
-- 
2.23.0
