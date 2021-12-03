Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF084671E3
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Dec 2021 07:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378576AbhLCGd5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Dec 2021 01:33:57 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32872 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhLCGd4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Dec 2021 01:33:56 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J52xq72VGzcbdx;
        Fri,  3 Dec 2021 14:30:23 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 14:30:32 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 14:30:32 +0800
Message-ID: <fe41fe45-0b3e-bac4-2d87-3241122b4730@huawei.com>
Date:   Fri, 3 Dec 2021 14:30:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: [PATCH 5/6] e2fsck: check whether ldesc is null before accessing it
 in end_problem_latch()
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

In end_problem_latch(), ldesc need check not NULL before dereference.

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
---
  e2fsck/problem.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/e2fsck/problem.c b/e2fsck/problem.c
index f454dcb7..fd814f9e 100644
--- a/e2fsck/problem.c
+++ b/e2fsck/problem.c
@@ -2394,6 +2394,8 @@ int end_problem_latch(e2fsck_t ctx, int mask)
      int answer = -1;

      ldesc = find_latch(mask);
+    if (!ldesc)
+        return answer;
      if (ldesc->end_message && (ldesc->flags & PRL_LATCHED)) {
          clear_problem_context(&pctx);
          answer = fix_problem(ctx, ldesc->end_message, &pctx);
-- 
2.23.0
