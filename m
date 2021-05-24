Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D556738E545
	for <lists+linux-ext4@lfdr.de>; Mon, 24 May 2021 13:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhEXLW3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 May 2021 07:22:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5752 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbhEXLWY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 May 2021 07:22:24 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpZS06t58zmkrl
        for <linux-ext4@vger.kernel.org>; Mon, 24 May 2021 19:17:20 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:20:54 +0800
Received: from [10.174.179.184] (10.174.179.184) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:20:54 +0800
Subject: [PATCH 03/12] zap_sector: fix memory leak
From:   Wu Guanghao <wuguanghao3@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
References: <266bc52e-e279-ce84-0e1f-1405b9bc6174@huawei.com>
Message-ID: <8ea5c607-54cc-ccaf-3e4b-ee2af0160a0b@huawei.com>
Date:   Mon, 24 May 2021 19:20:54 +0800
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

In zap_sector(), need free buf before return,
otherwise it will cause memory leak.

Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Reviewed-by: Wu Bo <wubo40@huawei.com>
---
 misc/mke2fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index afbcf486..94f81da9 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -586,6 +586,7 @@ static void zap_sector(ext2_filsys fs, int sect, int nsect)
 			magic = (unsigned int *) (buf + BSD_LABEL_OFFSET);
 			if ((*magic == BSD_DISKMAGIC) ||
 				(*magic == BSD_MAGICDISK))
+				free(buf);
 				return;
 		}
 	}
-- 
