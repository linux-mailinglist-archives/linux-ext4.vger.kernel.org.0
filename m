Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E031538F836
	for <lists+linux-ext4@lfdr.de>; Tue, 25 May 2021 04:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhEYCdz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 May 2021 22:33:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3990 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhEYCdz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 May 2021 22:33:55 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fpyj91xXVzmZtc
        for <linux-ext4@vger.kernel.org>; Tue, 25 May 2021 10:30:05 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 10:32:25 +0800
Received: from [10.174.179.184] (10.174.179.184) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 10:32:24 +0800
Subject: Re: [PATCH 07/12] argv_parse: check return value of malloc in
 argv_parse()
From:   Wu Guanghao <wuguanghao3@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
References: <266bc52e-e279-ce84-0e1f-1405b9bc6174@huawei.com>
 <5d711bbc-50bb-c8a5-a118-e22a691c0d7f@huawei.com>
Message-ID: <c9894a08-c676-2700-7069-de1ec083fb74@huawei.com>
Date:   Tue, 25 May 2021 10:32:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <5d711bbc-50bb-c8a5-a118-e22a691c0d7f@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.184]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There is a problem with this patch. "argv" is spelled as "arcv".
This problem will be resolved in the v2 version.

ÔÚ 2021/5/24 19:23, Wu Guanghao Ð´µÀ:
> In argv_parse(), return value of malloc should be checked
> whether it is NULL, otherwise, it may cause a segfault error.
> 
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
> ---
>  lib/support/argv_parse.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/support/argv_parse.c b/lib/support/argv_parse.c
> index d22f6344..1ef9c014 100644
> --- a/lib/support/argv_parse.c
> +++ b/lib/support/argv_parse.c
> @@ -116,6 +116,8 @@ int argv_parse(char *in_buf, int *ret_argc, char ***ret_argv)
>  	if (argv == 0) {
>  		argv = malloc(sizeof(char *));
>  		free(buf);
> +		if (!arcv)
> +			return -1;
>  	}
>  	argv[argc] = 0;
>  	if (ret_argc)
> 
