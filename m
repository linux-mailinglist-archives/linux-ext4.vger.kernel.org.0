Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658BB721D0D
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Jun 2023 06:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjFEEPi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Jun 2023 00:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjFEEPh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Jun 2023 00:15:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7716FC7;
        Sun,  4 Jun 2023 21:15:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B2DC61DF3;
        Mon,  5 Jun 2023 04:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAD5C433EF;
        Mon,  5 Jun 2023 04:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685938535;
        bh=RCpGITTe3Be7awtsoscomvF5veMxjwbVqOhW9GvvtOk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=puSErfaNESzJhZAK8/c5lzcGt7bLpKeohShaobbbBQTI3O52d1H3LkwH6lXQfmmw0
         h8z0Wcv192HgoOQTr8Sj119OxtT3sH1YxhjmqV7lpATHNUOWoNgtals0fugh2yXPjv
         TUsrZKCqfh2dBQ2GRdUYhgjzxXzrwM5HDH37IP97SeBAl75fmG/+O9KJZKV2Kfd2Gl
         jRCCqR9uIFHt6ufB5BDPrcD+idq7fSiZvTxUFedz+qaPOW73ST+AfSJR4DwPALClY5
         MvCW00UBLkbnmxDS4P0P0H6zkXHFDO/fRru5NK60n6LLkrgRLixL5YU7v4XF3Iikd6
         oAI151zy15elg==
Message-ID: <b83ddb0e-0411-1ca8-dd76-238db056b710@kernel.org>
Date:   Mon, 5 Jun 2023 12:15:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ext4: fix wrong calculation of minlen in ext4_trim_fs()
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
References: <20230406150621.3854298-1-chao@kernel.org>
 <20230421093502.n4x3c773udaapksl@quack3>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230421093502.n4x3c773udaapksl@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ping,

On 2023/4/21 17:35, Jan Kara wrote:
> On Thu 06-04-23 23:06:21, Chao Yu wrote:
>> As Ted pointed out as below:
>>
>> "
>> However the minlen variable in ext4_trim_fs is in units of *clusters*.
>> And so it gets rounded up two places.  The first time is when it is
>> converted into units of a cluster:
>>
>> 	minlen = EXT4_NUM_B2C(EXT4_SB(sb),
>> 			      range->minlen >> sb->s_blocksize_bits);
>>
>> Oh, and by the way, that first conversion is not correct as currently
>> written in ext4_fs_trim().   It should be
>>
>> 	minlen = (range->minlen + EXT4_CLUSTER_SIZE(sb) - 1) >>
>> 		(sb->s_blocksize_bits + EXT4_CLUSTER_BITS(sb));
>> "
>>
>> The reason is if range->minlen is smaller than block size of ext4,
>> original calculation "range->minlen >> sb->s_blocksize_bits" may
>> return zero, but since EXT4_NUM_B2C() expects a non-zero in-parameter,
>> so it needs to round up range->minlen to cluster size directly as above.
>>
>> Link: https://lore.kernel.org/lkml/20230311031843.GF860405@mit.edu/
>> Suggested-by: Theodore Ts'o <tytso@mit.edu>
>> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> Looks good to me. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza
> 
>> ---
>>   fs/ext4/mballoc.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 5b2ae37a8b80..d8b9d6a83d1e 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -6478,8 +6478,8 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
>>   
>>   	start = range->start >> sb->s_blocksize_bits;
>>   	end = start + (range->len >> sb->s_blocksize_bits) - 1;
>> -	minlen = EXT4_NUM_B2C(EXT4_SB(sb),
>> -			      range->minlen >> sb->s_blocksize_bits);
>> +	minlen = (range->minlen + EXT4_CLUSTER_SIZE(sb) - 1) >>
>> +			(sb->s_blocksize_bits + EXT4_CLUSTER_BITS(sb));
>>   
>>   	if (minlen > EXT4_CLUSTERS_PER_GROUP(sb) ||
>>   	    start >= max_blks ||
>> -- 
>> 2.25.1
>>
