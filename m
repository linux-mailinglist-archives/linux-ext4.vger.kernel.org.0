Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083B13CC08C
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jul 2021 03:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbhGQBnN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jul 2021 21:43:13 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7380 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbhGQBm5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jul 2021 21:42:57 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GRW0l6NH0z7v44;
        Sat, 17 Jul 2021 09:36:23 +0800 (CST)
Received: from dggema765-chm.china.huawei.com (10.1.198.207) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 17 Jul 2021 09:39:59 +0800
Received: from [127.0.0.1] (10.174.177.249) by dggema765-chm.china.huawei.com
 (10.1.198.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 17
 Jul 2021 09:39:59 +0800
Subject: Re: [PATCH v2 11/12] misc/lsattr: check whether path is NULL in
 lsattr_dir_proc()
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        wuguanghao <wuguanghao3@huawei.com>
CC:     <linux-ext4@vger.kernel.org>, <artem.blagodarenko@gmail.com>,
        <linfeilong@huawei.com>, <liuzhiqiang26@huawei.com>
References: <20210630082724.50838-2-wuguanghao3@huawei.com>
 <20210630082724.50838-12-wuguanghao3@huawei.com> <YPED9XnrrHFaC11p@mit.edu>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <08a0c82a-9771-3b9e-04a8-4cede7d5d576@huawei.com>
Date:   Sat, 17 Jul 2021 09:39:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <YPED9XnrrHFaC11p@mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.249]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema765-chm.china.huawei.com (10.1.198.207)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 2021/7/16 11:58, Theodore Y. Ts'o wrote:
> On Wed, Jun 30, 2021 at 04:27:23PM +0800, wuguanghao wrote:
>> diff --git a/misc/lsattr.c b/misc/lsattr.c
>> index 0d954376..f3212069 100644
>> --- a/misc/lsattr.c
>> +++ b/misc/lsattr.c
>> @@ -144,6 +144,12 @@ static int lsattr_dir_proc (const char * dir_name, struct dirent * de,
>>  	int dir_len = strlen(dir_name);
>>  
>>  	path = malloc(dir_len + strlen (de->d_name) + 2);
>> +	if (!path) {
>> +		fprintf(stderr, "%s",
>> +			_("Couldn't allocate path variable "
>> +			  "in lsattr_dir_proc"));
>> +		return -1;
>> +	}
> The string is missing a closing newline.  Also, why not?
>
> 		fputs(_("Couldn't allocate path variable in lsattr_dir_proc"),
> 		      stderr);
>
> 					- Ted
>
> .

Thanks for your suggestion.

We will resend the v3 patch as your suggestion.



