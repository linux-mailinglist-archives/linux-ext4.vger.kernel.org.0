Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CF254DA51
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jun 2022 08:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358998AbiFPGJc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Jun 2022 02:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359008AbiFPGJa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Jun 2022 02:09:30 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EFA2A732
        for <linux-ext4@vger.kernel.org>; Wed, 15 Jun 2022 23:09:26 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so880194pjm.2
        for <linux-ext4@vger.kernel.org>; Wed, 15 Jun 2022 23:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=0wP+cMH+Uc8nndXud5ubhnBWs0aIbuoS+iQdIEaJNiI=;
        b=j3pNVhiqRfcJsT5F+t4Xia4CIwJMeKOYOmX0EX/ojefR78yfC+MYC+A80po+5TVvTt
         z7NflypW4GI0b1aWqcCJkcXYb3Ael0//cXPkFG2CjZoPhgbLGtpK0nzmbTNC+mpmoMUm
         BTyo3acf/YQkGq0VZpwV3o0xGP6N9s+1MwAafGgGULeobIlnCYONxNuPqyqt54/r4ki9
         pHf0uRhX+CE1QHTzNDIOEVdpc8/SoKxIwvJnp50YHna9qXhKVQ+pw6GH/Vy7POwpJRNK
         SZI4fY0AmrHkd7HcPTAKBeLTvGNmtX2R2RDADYIzxZPBTRXzFK6rYEk1+yR78csXkcOC
         /8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0wP+cMH+Uc8nndXud5ubhnBWs0aIbuoS+iQdIEaJNiI=;
        b=ypgp8NzlI149D+mgdzKSopgSvzVmHJ97kws7yOMKzqB6GK7hJfS19dLhqt5IpPUNHj
         6dN4YZ8kCCHcWlop0aBb0bL+9+/uaou/6Y400wFrGYZOQ5iSOIrtkaMhpMC+oOIJ5pZp
         ARKrgJl/hdrkuLdHkliiTomz5ihLIQB56JrtVT7xTkoYem0SmbkgDeFkF467fjQZtH/3
         Vciaz9WRmCKndvBh77j3u+Dt4gHTCePjjZe0sBEa/yZwSoIRT53VWZx4o1nsHOPHTzhE
         /wT8aBXU6j9dZji+TUjGQtjKCNV88clHyfFdcIp0nL9rtS4PFmCUIJp/d1JTvMo6D7kt
         h6Lw==
X-Gm-Message-State: AJIora8IDF658KgBBf4lM1tTWzgktATcfbkA2OTwIxn46J8kkcdKbw/m
        B1UYKZHNexeWecKEVmxJFRIM1g==
X-Google-Smtp-Source: AGRyM1vXN4pBq4tJYBrUoaqp9fFqKxyIt0So1hcfx92hSBOT96m8/K5gDXj9amAFYWhcO6+K6k6BFw==
X-Received: by 2002:a17:90a:bd89:b0:1e3:50de:5ccf with SMTP id z9-20020a17090abd8900b001e350de5ccfmr3376576pjr.104.1655359765668;
        Wed, 15 Jun 2022 23:09:25 -0700 (PDT)
Received: from [10.5.8.36] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id d16-20020a637350000000b003fdd2aa9811sm704365pgn.60.2022.06.15.23.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 23:09:25 -0700 (PDT)
Message-ID: <29b3bbe6-24dc-d0ee-8426-7cb3b6cfbc1e@bytedance.com>
Date:   Thu, 16 Jun 2022 14:09:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] Re: [PATCH] ext4: fix trim range leak
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220614044647.21846-1-hanjinke.666@bytedance.com>
 <20220615084017.xwexup5ckrrpevhe@fedora>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <20220615084017.xwexup5ckrrpevhe@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

hi

thanks for your reply.

Your point mentioned in the last email is very useful to me.

I also think performance gains should be based on impeccable logic and 
the semantic of trim should be promised too.

Can I send a patch v2 based on your suggestion ?

Jinke

在 2022/6/15 下午4:40, Lukas Czerner 写道:
> On Tue, Jun 14, 2022 at 12:46:47PM +0800, Jinke Han wrote:
>> From: hanjinke <hanjinke.666@bytedance.com>
>>
>> When release group lock, a large number of blocks may be alloc from
>> the group(e.g. not from the rest of target trim range). This may
>> lead end of the loop and leave the rest of trim range unprocessed.
> 
> Hi,
> 
> you're correct. Indeed it's possible to miss some of the blocks this
> way.
> 
> But I wonder how much of a problem this actually is? I'd think that the
> optimization you just took out is very usefull, especially with larger
> minlen and more fragmented free space it'll save us a lot of cycles.
> Do you have any performance numbers for this change?
> 
> Perhaps we don't have to remove it completely, rather zero the
> free_count every time bb_free changes? Would that be worth it?
> 
> -Lukas
> 
>>
>> Signed-off-by: hanjinke <hanjinke.666@bytedance.com>
>> ---
>>   fs/ext4/mballoc.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 9f12f29bc346..45eb9ee20947 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -6345,14 +6345,13 @@ static int ext4_try_to_trim_range(struct super_block *sb,
>>   __acquires(ext4_group_lock_ptr(sb, e4b->bd_group))
>>   __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
>>   {
>> -	ext4_grpblk_t next, count, free_count;
>> +	ext4_grpblk_t next, count;
>>   	void *bitmap;
>>   
>>   	bitmap = e4b->bd_bitmap;
>>   	start = (e4b->bd_info->bb_first_free > start) ?
>>   		e4b->bd_info->bb_first_free : start;
>>   	count = 0;
>> -	free_count = 0;
>>   
>>   	while (start <= max) {
>>   		start = mb_find_next_zero_bit(bitmap, max + 1, start);
>> @@ -6367,7 +6366,6 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
>>   				break;
>>   			count += next - start;
>>   		}
>> -		free_count += next - start;
>>   		start = next + 1;
>>   
>>   		if (fatal_signal_pending(current)) {
>> @@ -6381,8 +6379,6 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
>>   			ext4_lock_group(sb, e4b->bd_group);
>>   		}
>>   
>> -		if ((e4b->bd_info->bb_free - free_count) < minblocks)
>> -			break;
>>   	}
>>   
>>   	return count;
>> -- 
>> 2.20.1
>>
> 
