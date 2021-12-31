Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539B548229D
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Dec 2021 08:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242745AbhLaHnN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 31 Dec 2021 02:43:13 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:29313 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhLaHnM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 31 Dec 2021 02:43:12 -0500
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JQHDK0kjNzbjmY;
        Fri, 31 Dec 2021 15:42:41 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 31 Dec 2021 15:43:11 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 31 Dec 2021 15:43:10 +0800
Message-ID: <9a9c6658-a8b3-794a-85df-c3bdf0470111@huawei.com>
Date:   Fri, 31 Dec 2021 15:43:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: [PATCH v2 5/6] e2fsck: check whether ldesc is null before accessing,
 it in end_problem_latch()
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
+	if (!ldesc)
+		return answer;
  	if (ldesc->end_message && (ldesc->flags & PRL_LATCHED)) {
  		clear_problem_context(&pctx);
  		answer = fix_problem(ctx, ldesc->end_message, &pctx);
-- 
2.27.0

