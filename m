Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A8E3CB71A
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jul 2021 14:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhGPMHU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jul 2021 08:07:20 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:15028 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbhGPMHT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jul 2021 08:07:19 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GR8vx1k0lzZqgv;
        Fri, 16 Jul 2021 20:01:01 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 16 Jul 2021 20:04:19 +0800
Subject: Re: [PATCH v2 3/4] ext4: factor out write end code of inline file
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <yukuai3@huawei.com>
References: <20210715015452.2542505-1-yi.zhang@huawei.com>
 <20210715015452.2542505-4-yi.zhang@huawei.com>
 <20210715120818.GF9457@quack2.suse.cz>
 <eced292f-cdbe-ff0f-3d4d-d6e3a3c84520@huawei.com>
 <20210716100820.GF31920@quack2.suse.cz>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <bb1523ba-dbda-0e75-8767-5b91216fc245@huawei.com>
Date:   Fri, 16 Jul 2021 20:04:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20210716100820.GF31920@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2021/7/16 18:08, Jan Kara wrote:
> On Fri 16-07-21 11:56:06, Zhang Yi wrote:
>> On 2021/7/15 20:08, Jan Kara wrote:
>>> On Thu 15-07-21 09:54:51, Zhang Yi wrote:
>>>> Now that the inline_data file write end procedure are falled into the
>>>> common write end functions, it is not clear. Factor them out and do
>>>> some cleanup. This patch also drop ext4_da_write_inline_data_end()
>>>> and switch to use ext4_write_inline_data_end() instead because we also
>>>> need to do the same error processing if we failed to write data into
>>>> inline entry.
>>>>
>>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>>
>>> Just two small comments below.
>>>
>>>> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
>>>> index 28b666f25ac2..3d227b32b21c 100644
>>>> --- a/fs/ext4/inline.c
>>>> +++ b/fs/ext4/inline.c
>>> ...
>>>> +out:
>>>> +	/*
>>>> +	 * If we have allocated more blocks and copied less. We will have
>>>> +	 * blocks allocated outside inode->i_size, so truncate them.
>>>> +	 */
>>>> +	if (pos + len > inode->i_size && ext4_can_truncate(inode))
>>>> +		ext4_orphan_add(handle, inode);
>>>
>>> I don't think we need this error handling here. For inline data we never
>>> allocate any blocks so shorter writes don't need any cleanup.
>>>
>>>> -	return copied;
>>>> +	ret2 = ext4_journal_stop(handle);
>>>> +	if (!ret)
>>>> +		ret = ret2;
>>>> +	if (pos + len > inode->i_size) {
>>>> +		ext4_truncate_failed_write(inode);
>>>> +		/*
>>>> +		 * If truncate failed early the inode might still be
>>>> +		 * on the orphan list; we need to make sure the inode
>>>> +		 * is removed from the orphan list in that case.
>>>> +		 */
>>>> +		if (inode->i_nlink)
>>>> +			ext4_orphan_del(NULL, inode);
>>>> +	}
>>>
>>> And this can go away as well...
>>>
>>
>> Yeah, but if we don't call ext4_truncate_failed_write()->..->
>> ext4_inline_data_truncate(), it will lead to incorrect larger i_inline_size
>> and data entry. Although it seems harmless (i_size can prevent read zero
>> data), I think it's better to restore the data entry(the comments need
>> change later), or else it will occupy more xattr space. What do you think ?
> 
> Good point. I've found this out last time when I was reviewing your patches
> and then forgot again. So please leave the code there but fix this
> misleading comment:
> 
> /*
>  * If we have allocated more blocks and copied less. We will have
>  * blocks allocated outside inode->i_size, so truncate them.
>  */
> 
> Something like:
> 
> /*
>  * If we didn't copy as much data as expected, we need to trim back size of
>  * xattr containing inline data.
>  */
> 

OK.

Thanks,
Yi.
