Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390D14343A0
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Oct 2021 04:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhJTCz6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Oct 2021 22:55:58 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14831 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhJTCz6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Oct 2021 22:55:58 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HYw6R1pfXz90FP;
        Wed, 20 Oct 2021 10:48:47 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 dggeme754-chm.china.huawei.com (10.3.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Wed, 20 Oct 2021 10:53:42 +0800
Subject: Re: [PATCH -next v4 3/3] ext4: simplify read_mmp_block fucntion
To:     Jan Kara <jack@suse.cz>
References: <20211019123931.1545295-1-yebin10@huawei.com>
 <20211019123931.1545295-4-yebin10@huawei.com>
 <20211019134952.GJ3255@quack2.suse.cz>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   yebin <yebin10@huawei.com>
Message-ID: <616F84B6.4040307@huawei.com>
Date:   Wed, 20 Oct 2021 10:53:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20211019134952.GJ3255@quack2.suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2021/10/19 21:49, Jan Kara wrote:
> On Tue 19-10-21 20:39:31, Ye Bin wrote:
>> This patch is according to Jan Kara's suggestion:
>> I guess I would just get rid of sb_getblk() in read_mmp_block() and always
>> expect valid bh passed. The only place that passes NULL bh after this
>> patch is one case in ext4_multi_mount_protect() and that can call
>> sb_getblk() on its own. That way we can also simplify read_mmp_block()
>> prototype to:
>>
>> static int read_mmp_block(struct super_block *sb, struct buffer_head *bh);
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> Reviewed-by: Jan Kara <jack@suse.cz>
> ...
>
>> @@ -289,7 +279,11 @@ int ext4_multi_mount_protect(struct super_block *sb,
>>   		goto failed;
>>   	}
>>   
>> -	retval = read_mmp_block(sb, &bh, mmp_block);
>> +	bh = sb_getblk(sb, mmp_block);
>> +	if (bh)
> 	^^^^^^
>
> !bh here, please.
Sorry，it's my fault. I will fix it and test  this patch set base on 
linux mainline.
>
> 								Honza
>

