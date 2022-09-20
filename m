Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414565BECBF
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Sep 2022 20:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiITS0K (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 20 Sep 2022 14:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiITS0K (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 20 Sep 2022 14:26:10 -0400
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE74D5E67D;
        Tue, 20 Sep 2022 11:26:06 -0700 (PDT)
Received: from [192.168.103.121] (unknown [88.163.97.197])
        by smtp6-g21.free.fr (Postfix) with ESMTPS id EAECD780333;
        Tue, 20 Sep 2022 20:25:59 +0200 (CEST)
Message-ID: <d49a38ed-5523-8339-e1e8-d52b0ab41fdf@partition-saving.com>
Date:   Tue, 20 Sep 2022 20:25:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next 1/2] ext4: fix potential memory leak in
 ext4_fc_record_regions()
Content-Language: en-US
To:     yebin <yebin10@huawei.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz
References: <20220919144021.2162295-1-yebin10@huawei.com>
 <20220919144021.2162295-2-yebin10@huawei.com>
 <02fc228b-7cc5-b470-9b5c-8ad726b18158@partition-saving.com>
 <6329126D.8060704@huawei.com>
From:   Damien Guibouret <damien.guibouret@partition-saving.com>
In-Reply-To: <6329126D.8060704@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

Le 20/09/2022 à 03:07, yebin a écrit :
> 
> 
> On 2022/9/20 2:40, Damien Guibouret wrote:
>> Hello,
>>
>> Le 19/09/2022 à 16:40, Ye Bin a écrit :
>>> As krealloc may return NULL, in this case 'state->fc_regions' may not be
>>> freed by krealloc, but 'state->fc_regions' already set NULL. Then will
>>> lead to 'state->fc_regions' memory leak.
>>>
>>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>>> ---
>>>   fs/ext4/fast_commit.c | 14 ++++++++------
>>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
>>> index 9217a588afd1..cc8c8db075ba 100644
>>> --- a/fs/ext4/fast_commit.c
>>> +++ b/fs/ext4/fast_commit.c
>>> @@ -1677,15 +1677,17 @@ int ext4_fc_record_regions(struct super_block 
>>> *sb, int ino,
>>>       if (replay && state->fc_regions_used != state->fc_regions_valid)
>>>           state->fc_regions_used = state->fc_regions_valid;
>>>       if (state->fc_regions_used == state->fc_regions_size) {
>>> +        struct ext4_fc_alloc_region *fc_regions;
>>> +
>>>           state->fc_regions_size +=
>>>               EXT4_FC_REPLAY_REALLOC_INCREMENT;
>>> -        state->fc_regions = krealloc(
>>> -                    state->fc_regions,
>>> -                    state->fc_regions_size *
>>> -                    sizeof(struct ext4_fc_alloc_region),
>>> -                    GFP_KERNEL);
>>> -        if (!state->fc_regions)
>>> +        fc_regions = krealloc(state->fc_regions,
>>> +                      state->fc_regions_size *
>>> +                      sizeof(struct ext4_fc_alloc_region),
>>> +                      GFP_KERNEL);
>>> +        if (!fc_regions)
>>
>> Would it not be safer to restore state->fc_regions_size to its 
>> previous value in that case to keep consistency between size value and 
>> allocated size (or to update state->fc_regions_size only after 
>> allocation as it is done in second part of this patch) ?
>>
> Actually, If   'ext4_fc_record_regions()' return -ENOMEM, then will stop 
> replay journal.
> 'state->fc_regions_size' will not be used any more, so it's safe.

There are at least two calls in ext4_ext_clear_bb (ext4/extents.c) that 
do not check for return code of ext4_fc_record_regions. But perhaps 
these are these calls that should be fixed.

>>>               return -ENOMEM;
>>> +        state->fc_regions = fc_regions;
>>>       }
>>>       region = &state->fc_regions[state->fc_regions_used++];
>>>       region->ino = ino;
>>

Regards,

Damien

