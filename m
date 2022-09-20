Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D087E5BD90B
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Sep 2022 03:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiITBIE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Sep 2022 21:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiITBID (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Sep 2022 21:08:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBC84DB35;
        Mon, 19 Sep 2022 18:08:01 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MWjw60G9CzMn3p;
        Tue, 20 Sep 2022 09:03:18 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 09:07:58 +0800
Subject: Re: [PATCH -next 1/2] ext4: fix potential memory leak in
 ext4_fc_record_regions()
To:     Damien Guibouret <damien.guibouret@partition-saving.com>,
        <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
References: <20220919144021.2162295-1-yebin10@huawei.com>
 <20220919144021.2162295-2-yebin10@huawei.com>
 <02fc228b-7cc5-b470-9b5c-8ad726b18158@partition-saving.com>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>
From:   yebin <yebin10@huawei.com>
Message-ID: <6329126D.8060704@huawei.com>
Date:   Tue, 20 Sep 2022 09:07:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <02fc228b-7cc5-b470-9b5c-8ad726b18158@partition-saving.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2022/9/20 2:40, Damien Guibouret wrote:
> Hello,
>
> Le 19/09/2022 à 16:40, Ye Bin a écrit :
>> As krealloc may return NULL, in this case 'state->fc_regions' may not be
>> freed by krealloc, but 'state->fc_regions' already set NULL. Then will
>> lead to 'state->fc_regions' memory leak.
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   fs/ext4/fast_commit.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
>> index 9217a588afd1..cc8c8db075ba 100644
>> --- a/fs/ext4/fast_commit.c
>> +++ b/fs/ext4/fast_commit.c
>> @@ -1677,15 +1677,17 @@ int ext4_fc_record_regions(struct super_block 
>> *sb, int ino,
>>       if (replay && state->fc_regions_used != state->fc_regions_valid)
>>           state->fc_regions_used = state->fc_regions_valid;
>>       if (state->fc_regions_used == state->fc_regions_size) {
>> +        struct ext4_fc_alloc_region *fc_regions;
>> +
>>           state->fc_regions_size +=
>>               EXT4_FC_REPLAY_REALLOC_INCREMENT;
>> -        state->fc_regions = krealloc(
>> -                    state->fc_regions,
>> -                    state->fc_regions_size *
>> -                    sizeof(struct ext4_fc_alloc_region),
>> -                    GFP_KERNEL);
>> -        if (!state->fc_regions)
>> +        fc_regions = krealloc(state->fc_regions,
>> +                      state->fc_regions_size *
>> +                      sizeof(struct ext4_fc_alloc_region),
>> +                      GFP_KERNEL);
>> +        if (!fc_regions)
>
> Would it not be safer to restore state->fc_regions_size to its 
> previous value in that case to keep consistency between size value and 
> allocated size (or to update state->fc_regions_size only after 
> allocation as it is done in second part of this patch) ?
>
Actually, If   'ext4_fc_record_regions()' return -ENOMEM, then will stop 
replay journal.
'state->fc_regions_size' will not be used any more, so it's safe.
>>               return -ENOMEM;
>> +        state->fc_regions = fc_regions;
>>       }
>>       region = &state->fc_regions[state->fc_regions_used++];
>>       region->ino = ino;
>
> Regards,
>
> Damien
>
> .
>

