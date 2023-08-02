Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB5D76C228
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Aug 2023 03:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjHBBZ1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Aug 2023 21:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjHBBZ1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Aug 2023 21:25:27 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00771BFD;
        Tue,  1 Aug 2023 18:25:26 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so4770105a12.1;
        Tue, 01 Aug 2023 18:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690939526; x=1691544326;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BxNJlgj61wAL83WKuXKHyWeqhkRYePIZP/mMM4t8+5M=;
        b=N70MdiCBzAWSrBPXWejxCvDNVVadWhBfdwqyyrdTpqdrHb7IFc6lD/YBaalbKE2xDv
         n4UZu/eUlZf+e3JiXGa1rvIXZDr88r2bsffBRUl41digc8t2HBMNElxkUdnIsw9V7+dp
         u26VeI2F8rUw/GabKjCdJJKJotxb/IlkhNICN1PYxLE18oLEK0bfkzCj6zyvnrWGUMPS
         YEsKYZgzIF5jpR+ZNrlwoiSKJbkQFM/4gKOjvPzYnhqPtnhJmvxnhx0D83UlY9zS5bhK
         1qHYCJSvPPdRpHePBZ0agTjZQKQFXCnBMj5qcPfhyQAwmZmE7A803PUt73AfhOYzbpBQ
         NERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690939526; x=1691544326;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BxNJlgj61wAL83WKuXKHyWeqhkRYePIZP/mMM4t8+5M=;
        b=HC9hmEC9AjRTKeDng9FxTVH8Jm2zAOazNpl3PRBbwX9SvVbB0xAZLx8L9QJNZiqhrY
         l28YcxtpqgrF8DUkTa8GWQNn3KVgXoRWFIZSKEEztXAHtsv9MUepuPQY+Xd4neEw8GRM
         26Pd2STpawBSoR20IcxFifO4KIqf2xTamlCBzwl1XJ93TJzqkN6cHnPljZIeen/qQBVl
         Ncd8502wOg1MjLJMbjDIH5wIrS9fPyu6kl5lxeC98jXirU3+TXndBd2w71Mym/Ykcp9o
         HroE2WSKnLwKBh3zoDY1ui4kI1tbyIz6o8U1Mfzmf8Upi70L+VNQ9ZYNEd1av2ZCYcK7
         OwMQ==
X-Gm-Message-State: ABy/qLaccsWTcS6cmoSLyCmmxpbMlpiujbL7KJSDeF+gIwbcUazCLB2d
        0H1aS8dVQzGO+UBhVW1kFqg=
X-Google-Smtp-Source: APBJJlHIvu5PSU4JoVq+ynuIVA4p4cApLpvnFCJqUjoSQjMJRAH1bqNnfDtzqamgr5DCp9rqIvo1Ng==
X-Received: by 2002:a05:6a21:a103:b0:134:5c75:3d23 with SMTP id aq3-20020a056a21a10300b001345c753d23mr13848009pzc.18.1690939525840;
        Tue, 01 Aug 2023 18:25:25 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902ceca00b001b9df74ba5asm11015171plg.210.2023.08.01.18.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 18:25:25 -0700 (PDT)
Date:   Wed, 02 Aug 2023 06:55:21 +0530
Message-Id: <87sf92w7zy.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: Re: [PATCH v3 10/10] ext4: correct some stale comment of criteria
In-Reply-To: <87v8dyw8ar.fsf@doe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> Kemeng Shi <shikemeng@huaweicloud.com> writes:
>
>> We named criteria with CR_XXX, correct stale comment to criteria with
>> raw number.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/ext4/mballoc.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index bfaab173a3f4..1e8ce0ece47a 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -2782,8 +2782,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>>  
>>  	/*
>>  	 * ac->ac_2order is set only if the fe_len is a power of 2
>> -	 * if ac->ac_2order is set we also set criteria to 0 so that we
>> -	 * try exact allocation using buddy.
>> +	 * if ac->ac_2order is set we also set criteria to CR_POWER2_ALIGNED
>> +	 * so that we try exact allocation using buddy.
>>  	 */
>>  	i = fls(ac->ac_g_ex.fe_len);
>>  	ac->ac_2order = 0;
>> @@ -2840,8 +2840,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>>  			/*
>>  			 * Batch reads of the block allocation bitmaps
>>  			 * to get multiple READs in flight; limit
>> -			 * prefetching at cr=0/1, otherwise mballoc can
>> -			 * spend a lot of time loading imperfect groups
>> +			 * prefetching at inexpensive CR, otherwise mballoc
>> +			 * can spend a lot of time loading imperfect groups
>>  			 */
>>  			if ((prefetch_grp == group) &&
>>  			    (ext4_mb_cr_expensive(cr) ||
> Is this function defined at any place ^^^

aah ok got it. Here [1]

...which you have also mentioned in your cover letetr. So your patch series
currently is depenedent of above patch [1]

[1]: https://lore.kernel.org/linux-ext4/20230630085927.140137-1-ojaswin@linux.ibm.com/


Feel free to add - 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


>
> -ritesh
