Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC9D721D0B
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Jun 2023 06:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjFEEPU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Jun 2023 00:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjFEEPT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Jun 2023 00:15:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EE8A6;
        Sun,  4 Jun 2023 21:15:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C1A861DF3;
        Mon,  5 Jun 2023 04:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A317C433EF;
        Mon,  5 Jun 2023 04:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685938517;
        bh=iJ39RWeiHKTXkYUaE5+ijY3+twwWnAlDiMVKlAoRUck=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K872SEU+6YKR+UJDjfnvMCYQOVIAXkQh7BbvM3fP5AvF9eyhx24mNMgSNketAI8NJ
         hJb8UjAhBCWdYfmPYA/NpHaBk1IoJ9CmI6OkI5yKKoOAHsGGRcP/XQw5rmqliblcLn
         7dPkKZ/UNgDP0Y0+hIM82KoN6+gaSSCl7U8CEH5B67cFFFvRql+ep2DRtaHABo82X5
         buPskWqDb5Wvc7D3nYgIF5qzPilMr7YO9DSQqEVmgrXFeu9OoIGhu/fXD33g3XdH29
         U91d9aEZpaoiBnZ2LU2ruBcaoU9k/H5WGbxrpHl2YGlAQvVoUrgEzVNBWJt0J3J7al
         QxJISBkH7Oeyw==
Message-ID: <4f0d6bd4-f393-9879-37c2-2495db4506c9@kernel.org>
Date:   Mon, 5 Jun 2023 12:15:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] ext4: fix to report fstrim.minlen back to userspace
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
References: <20230406150410.3853001-1-chao@kernel.org>
 <20230421093940.k2crghkblpx2fqlv@quack3>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230421093940.k2crghkblpx2fqlv@quack3>
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

On 2023/4/21 17:39, Jan Kara wrote:
> On Thu 06-04-23 23:04:10, Chao Yu wrote:
>> Quoted from manual of fstrim(8):
>>
>> "-m, --minimum minimum-size
>> 	..., if it's smaller than the device's minimum, and report that
>> (fstrim_range.minlen) back to userspace."
>>
>> So this patch tries to report adjusted fstrim_range.minlen back to
>> userspace via FITRIM interface, if the value is smaller than device's
>> minimum discard granularity.
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> Looks good to me. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza
> 
>> ---
>> v2:
>> - fix the wrong calculation of range->minlen.
>>   fs/ext4/mballoc.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index d8b9d6a83d1e..4af51a16fc64 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -6491,6 +6491,10 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
>>   				discard_granularity >> sb->s_blocksize_bits);
>>   		if (minlen > EXT4_CLUSTERS_PER_GROUP(sb))
>>   			goto out;
>> +
>> +		/* Report adjusted minlen back to userspace */
>> +		range->minlen = EXT4_C2B(EXT4_SB(sb), minlen) <<
>> +						sb->s_blocksize_bits;
>>   	}
>>   	if (end >= max_blks - 1) {
>>   		end = max_blks - 1;
>> -- 
>> 2.25.1
>>
