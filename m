Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03454671E7
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Dec 2021 07:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378592AbhLCGfB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Dec 2021 01:35:01 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32873 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378582AbhLCGfA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Dec 2021 01:35:00 -0500
Received: from kwepemi100001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J52z3037bzcbdx;
        Fri,  3 Dec 2021 14:31:26 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi100001.china.huawei.com (7.221.188.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 14:31:35 +0800
Received: from [127.0.0.1] (10.174.177.249) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 3 Dec
 2021 14:31:34 +0800
Subject: Re: [PATCH 1/6] e2fsck: set s->len=0 if malloc() fails in
 alloc_string()
To:     zhanchengbin <zhanchengbin1@huawei.com>,
        Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <linfeilong@huawei.com>
References: <37c58382-9714-7e99-6c4d-01b78cfdbd26@huawei.com>
 <622dc317-a9cb-2541-b357-a868d31a9605@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <49d00447-8c98-1b95-6194-6944405d8203@huawei.com>
Date:   Fri, 3 Dec 2021 14:31:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <622dc317-a9cb-2541-b357-a868d31a9605@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.249]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2021/12/3 14:26, zhanchengbin wrote:
> In alloc_string(), when malloc fails, len in the
> string structure should be 0.
>
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>  e2fsck/logfile.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/e2fsck/logfile.c b/e2fsck/logfile.c
> index 63e9a12f..f2227ad5 100644
> --- a/e2fsck/logfile.c
> +++ b/e2fsck/logfile.c
> @@ -32,6 +32,8 @@ static void alloc_string(struct string *s, int len)
>  {
>      s->s = malloc(len);
>  /* e2fsck_allocate_memory(ctx, len, "logfile name"); */
> +    if (s->s == NULL)
> +        s->len = 0;

we should add 'else' branch here.

+    if (s->s == NULL)
+        s->len = 0;
+    else
+       s->len = len;


please correct that in the v2 patches.


>     
>      s->end = 0;
>  }

