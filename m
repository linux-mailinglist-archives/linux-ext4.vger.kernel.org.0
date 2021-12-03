Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C634671E1
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Dec 2021 07:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbhLCGcS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Dec 2021 01:32:18 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32871 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhLCGcS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Dec 2021 01:32:18 -0500
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J52vx1Pwxzcbp2;
        Fri,  3 Dec 2021 14:28:45 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 14:28:53 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 14:28:53 +0800
Message-ID: <71ed1c9e-7e23-9f73-e7b9-55810963f4f3@huawei.com>
Date:   Fri, 3 Dec 2021 14:28:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: [PATCH 3/6] lib/support: check whether inump is null before accessing
 it in quota_set_sb_inum()
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

In quota_set_sb_inum(), we should check whether inump is null before 
accessing it,
otherwise the null potinter dereference error may occur.

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
  lib/support/mkquota.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/support/mkquota.c b/lib/support/mkquota.c
index 6f4a0b90..482e3d91 100644
--- a/lib/support/mkquota.c
+++ b/lib/support/mkquota.c
@@ -99,7 +99,8 @@ void quota_set_sb_inum(ext2_filsys fs, ext2_ino_t ino, 
enum quota_type qtype)

      log_debug("setting quota ino in superblock: ino=%u, type=%d", ino,
           qtype);
-    *inump = ino;
+    if (inump != NULL)
+        *inump = ino;
      ext2fs_mark_super_dirty(fs);
  }

-- 
2.23.0
