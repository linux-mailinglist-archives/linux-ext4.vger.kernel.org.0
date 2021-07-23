Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6853D3B08
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jul 2021 15:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbhGWMol (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Jul 2021 08:44:41 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:12246 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbhGWMol (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Jul 2021 08:44:41 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GWVK74zd0z1CL8L;
        Fri, 23 Jul 2021 21:19:23 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 23 Jul 2021 21:25:13 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 23 Jul 2021 21:25:12 +0800
Subject: Re: [PATCH] ext4: flush s_error_work before journal destroy in
 ext4_fill_super
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <jack@suse.cz>, <linux-ext4@vger.kernel.org>, <yukuai3@huawei.com>
References: <20210720062409.960734-1-yangerkun@huawei.com>
 <YPqx2hPUuTkJo/sj@mit.edu>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <eb962c26-b013-957b-7931-feda7f8bf5b5@huawei.com>
Date:   Fri, 23 Jul 2021 21:25:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YPqx2hPUuTkJo/sj@mit.edu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



在 2021/7/23 20:11, Theodore Ts'o 写道:
> On Tue, Jul 20, 2021 at 02:24:09PM +0800, yangerkun wrote:
>> 'commit c92dc856848f ("ext4: defer saving error info from atomic
>> context")' and '2d01ddc86606 ("ext4: save error info to sb through journal
>> if available")' add s_error_work to fix checksum error problem. But the
>> error path in ext4_fill_super can lead the follow BUG_ON.
> 
> Can you share with me your test case?  Your patch will result in the
> shrinker potentially not getting released in some error paths (which
> will cause other kernel panics), and in any case, once the journal is

Hi Ted,

The only logic we have changed is that we move the flush_work before we 
call jbd2_journal_destory. I have not seen the problem you describe... 
Can you help to explain more...

Thanks,
Kun.

> destroyed here:
> 
>> @@ -5173,15 +5173,15 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>>   
>>   	ext4_xattr_destroy_cache(sbi->s_ea_block_cache);
>>   	sbi->s_ea_block_cache = NULL;
>> +failed_mount3a:
>> +	ext4_es_unregister_shrinker(sbi);
>> +failed_mount3:
>> +	flush_work(&sbi->s_error_work);
>>   
>>   	if (sbi->s_journal) {
>>   		jbd2_journal_destroy(sbi->s_journal);
>>   		sbi->s_journal = NULL;
>>   	}
>> -failed_mount3a:
>> -	ext4_es_unregister_shrinker(sbi);
>> -failed_mount3:
>> -	flush_work(&sbi->s_error_work);
> 
> sbi->s_journal is set to NULL, which means that in
> flush_stashed_error_work(), journal will be NULL, which means we won't
> call start_this_handle and so this change will not make a difference
> given the kernel stack trace in the commit description.
> 
> Thanks,
> 
> 						- Ted
> .
> 
