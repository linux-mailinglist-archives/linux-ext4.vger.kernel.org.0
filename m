Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CAD32047A
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Feb 2021 09:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBTIm3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 20 Feb 2021 03:42:29 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12196 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhBTImX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 20 Feb 2021 03:42:23 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DjMM35CqVzlMjV;
        Sat, 20 Feb 2021 16:39:43 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.117) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Sat, 20 Feb 2021
 16:41:29 +0800
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        linfeilong <linfeilong@huawei.com>,
        lihaotian <lihaotian9@huawei.com>, <liuzhiqiang26@huawei.com>,
        "lijinlin (A)" <lijinlin3@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [PATCH] debugfs: fix memory leak problem in read_list()
Message-ID: <c6fb0951-a472-dbb4-1970-fe9cece5d182@huawei.com>
Date:   Sat, 20 Feb 2021 16:41:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


In read_list func, if strtoull() fails in while loop,
we will return the error code directly. Then, memory of
variable lst will be leaked without setting to *list.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Signed-off-by: linfeilong <linfeilong@huawei.com>
---
 debugfs/util.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/debugfs/util.c b/debugfs/util.c
index be6b550e..9e880548 100644
--- a/debugfs/util.c
+++ b/debugfs/util.c
@@ -530,12 +530,16 @@ errcode_t read_list(char *str, blk64_t **list, size_t *len)

 		errno = 0;
 		y = x = strtoull(tok, &e, 0);
-		if (errno)
-			return errno;
+		if (errno) {
+			retval = errno;
+			break;
+		}
 		if (*e == '-') {
 			y = strtoull(e + 1, NULL, 0);
-			if (errno)
-				return errno;
+			if (errno) {
+				retval = errno;
+				break;
+			}
 		} else if (*e != 0) {
 			retval = EINVAL;
 			break;
-- 
2.19.1


