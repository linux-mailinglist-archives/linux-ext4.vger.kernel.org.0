Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2A238274D
	for <lists+linux-ext4@lfdr.de>; Mon, 17 May 2021 10:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbhEQIpk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 May 2021 04:45:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3006 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbhEQIpi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 May 2021 04:45:38 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FkCL63WLxzmVbj;
        Mon, 17 May 2021 16:42:06 +0800 (CST)
Received: from dggeme759-chm.china.huawei.com (10.3.19.105) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 16:44:19 +0800
Received: from [127.0.0.1] (10.40.188.144) by dggeme759-chm.china.huawei.com
 (10.3.19.105) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 17
 May 2021 16:44:19 +0800
Subject: Re: [PATCH] ext4: remove set but rewrite variables
To:     =?UTF-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>, Tian Tao <tiantao6@hisilicon.com>
CC:     "Theodore Y. Ts'o" <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
References: <1621220165-11849-1-git-send-email-tiantao6@hisilicon.com>
 <B5603A0A-D24E-46A2-94B6-79451E39141C@gmail.com>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <c3e07a98-7eff-c761-4a99-78b8c5b73f7d@huawei.com>
Date:   Mon, 17 May 2021 16:44:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <B5603A0A-D24E-46A2-94B6-79451E39141C@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.144]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


在 2021/5/17 16:05, Благодаренко Артём 写道:
>
>> On 17 May 2021, at 05:56, Tian Tao <tiantao6@hisilicon.com> wrote:
>>
>> In line 2500 of the ext4_dx_add_entry function, the at variable is
>> assigned but not used, and it is reassigned in line 2449, so delete
>> the assignment of the at variable in line 2500.
>>
>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
>> ---
>> fs/ext4/namei.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
>> index afb9d05..18bbf15 100644
>> --- a/fs/ext4/namei.c
>> +++ b/fs/ext4/namei.c
>> @@ -2497,7 +2497,7 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
>>
>> 			/* Which index block gets the new entry? */
>> 			if (at - entries >= icount1) {
>> -				frame->at = at = at - entries - icount1 + entries2;
>> +				frame->at = at - entries - icount1 + entries2;
>> 				frame->entries = entries = entries2;
>> 				swap(frame->bh, bh2);
>> 			}
>> -- 
>> 2.7.4
>>
>
> Hello Tian,
>
> Thank you for the patch.
>
> Please, clarify, do you think the logic not changed after you patch if "while (frame > frames) {“ loop is not executed or terminated by “break:” in " if (dx_get_count((frame - 1)->entries) < ...“ block?

yes, it's reported by svace. and I check the code it's not change the 
logic. myabe I was wrong:-P

> Also I am not sure code lines numbers in the description are useful for future readers, because they can be changed.
I can update the commit message at v2.
>
> Thank you..
>

