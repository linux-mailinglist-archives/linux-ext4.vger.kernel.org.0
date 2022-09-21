Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F555C048C
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Sep 2022 18:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiIUQrY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Sep 2022 12:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiIUQq7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Sep 2022 12:46:59 -0400
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6F252DF7;
        Wed, 21 Sep 2022 09:38:58 -0700 (PDT)
Received: from [192.168.103.121] (unknown [88.163.97.197])
        by smtp6-g21.free.fr (Postfix) with ESMTPS id C8BD4780368;
        Wed, 21 Sep 2022 18:38:50 +0200 (CEST)
Message-ID: <b5fa5156-fc9d-a83e-4e8d-bc3d329903c2@partition-saving.com>
Date:   Wed, 21 Sep 2022 18:38:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next v2 3/3] ext4: update 'state->fc_regions_size' after
 successful memory allocation
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220921064040.3693255-1-yebin10@huawei.com>
 <20220921064040.3693255-4-yebin10@huawei.com>
 <20220921113227.g3zfv474tmpzfw75@quack3>
From:   Damien Guibouret <damien.guibouret@partition-saving.com>
In-Reply-To: <20220921113227.g3zfv474tmpzfw75@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

That's fine for me.

Regards,

Damien

Le 21/09/2022 à 13:32, Jan Kara a écrit :
> On Wed 21-09-22 14:40:40, Ye Bin wrote:
>> To avoid to 'state->fc_regions_size' mismatch with 'state->fc_regions'
>> when fail to reallocate 'fc_reqions',only update 'state->fc_regions_size'
>> after 'state->fc_regions' is allocated successfully.
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
> 
> Looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza
> 
>> ---
>>   fs/ext4/fast_commit.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
>> index f5b0fc50ed47..694ab0627395 100644
>> --- a/fs/ext4/fast_commit.c
>> +++ b/fs/ext4/fast_commit.c
>> @@ -1681,14 +1681,15 @@ int ext4_fc_record_regions(struct super_block *sb, int ino,
>>   	if (state->fc_regions_used == state->fc_regions_size) {
>>   		struct ext4_fc_alloc_region *fc_regions;
>>   
>> -		state->fc_regions_size +=
>> -			EXT4_FC_REPLAY_REALLOC_INCREMENT;
>>   		fc_regions = krealloc(state->fc_regions,
>> -				      state->fc_regions_size *
>> -				      sizeof(struct ext4_fc_alloc_region),
>> +				      sizeof(struct ext4_fc_alloc_region) *
>> +				      (state->fc_regions_size +
>> +				       EXT4_FC_REPLAY_REALLOC_INCREMENT),
>>   				      GFP_KERNEL);
>>   		if (!fc_regions)
>>   			return -ENOMEM;
>> +		state->fc_regions_size +=
>> +			EXT4_FC_REPLAY_REALLOC_INCREMENT;
>>   		state->fc_regions = fc_regions;
>>   	}
>>   	region = &state->fc_regions[state->fc_regions_used++];
>> -- 
>> 2.31.1
>>
