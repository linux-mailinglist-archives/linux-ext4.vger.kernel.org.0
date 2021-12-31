Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC014482299
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Dec 2021 08:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242734AbhLaHlo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 31 Dec 2021 02:41:44 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:34864 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhLaHlo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 31 Dec 2021 02:41:44 -0500
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JQHBc3V2czcc4Y;
        Fri, 31 Dec 2021 15:41:12 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 31 Dec 2021 15:41:42 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 31 Dec 2021 15:41:41 +0800
Message-ID: <6d2844c7-0fd2-e432-3c7e-bb8de8c8a186@huawei.com>
Date:   Fri, 31 Dec 2021 15:41:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: [PATCH v2 1/6] e2fsck: set s->len=0 if malloc() fails in,
 alloc_string()
From:   zhanchengbin <zhanchengbin1@huawei.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, <wubo40@huawei.com>
References: <52a2a39d-617f-2f27-a8a4-34da6103e44c@huawei.com>
In-Reply-To: <52a2a39d-617f-2f27-a8a4-34da6103e44c@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100004.china.huawei.com (7.185.36.247) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In alloc_string(), when malloc fails, len in the
string structure should be 0.

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
---
  e2fsck/logfile.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/e2fsck/logfile.c b/e2fsck/logfile.c
index 63e9a12f..7bdeae19 100644
--- a/e2fsck/logfile.c
+++ b/e2fsck/logfile.c
@@ -32,7 +32,7 @@ static void alloc_string(struct string *s, int len)
  {
  	s->s = malloc(len);
  /* e2fsck_allocate_memory(ctx, len, "logfile name"); */
-	s->len = len;
+	s->len = s->s ? len : 0;
  	s->end = 0;
  }

-- 
2.27.0

