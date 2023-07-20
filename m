Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CB275B7FD
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jul 2023 21:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjGTTa7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jul 2023 15:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjGTTa6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jul 2023 15:30:58 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD78171D;
        Thu, 20 Jul 2023 12:30:57 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666eba6f3d6so779553b3a.3;
        Thu, 20 Jul 2023 12:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689881457; x=1690486257;
        h=content-transfer-encoding:mime-version:in-reply-to:subject:cc:to
         :from:message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0kJT8UdZo4RMICIP5pYgVCCOmIKLtgXe9oZtHxttH3o=;
        b=VGPzHzhi9pH3HopFLJI5TfRruM3ZZVQFOwbtJ4WIxDuJpZDyxfha586FfplFQmHJCq
         gj10+wu23XgfRgjUIpvTAKZDnAqPWlK0Uh7jPMcoLMQCX5dKhe9ZxSathKVSb3Okzh1T
         7np4FKkAXPi0mjH6O6ZH3jfzOGdJceASmIv7tBb+3K/AAAPkutA0WFSEiJS/c32H2r7g
         Ek95UNJGPJkcD4ouifK0xtAmgF8LgiCpkDf9wlmgdmHjnfgPdihrX1pPvc3o/giWa1GC
         Vw1Azh8Cjaz7VIegXG7zhFMZs7PHJJ7BZ1FNzvEBPGMkJ+zom6tOrtLO0k8M6uSQexfH
         Ox4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689881457; x=1690486257;
        h=content-transfer-encoding:mime-version:in-reply-to:subject:cc:to
         :from:message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kJT8UdZo4RMICIP5pYgVCCOmIKLtgXe9oZtHxttH3o=;
        b=LFF80nhfqO4FyqE1ZpwajtSdq3JFPJmF0m8kl9sWKyFDL6d5efnTwVnltOaA1RlZH+
         oR7xmuCa4NUQ5PiSJDStGsUZD3NUDa9p2jPfAyy2XNilxSA23+qfEL+cYByvxC9YJvEx
         NZPSYM8rcNkqQd5WWQzV588ohSpMCjsbKaxsXiKzwa73Mghnmsn6qHfdhS4vU95ZDREZ
         bk/AJxW/9qDyBaaMtR2NvflrxkFL6nRGYmIyaWf5FDNrQr9lAn1Fncrh+u6NOX2fVe75
         vG/pWxxAs0ZKQidr18MFXfyViO0aw4TRhN4YQd49b2m6Myhz4wcMXK4VDqNy78jsceCh
         n0EQ==
X-Gm-Message-State: ABy/qLYre4PQ5fEBu88qz+mdL6uBH1zl4bf8WEl5QHP4CeymD2MEtkle
        z1RZg5pSqKyHUddcTEskC3c=
X-Google-Smtp-Source: APBJJlHzDhNQjGCxwLUAUrJJYOo/guCzBZ0qC+XRiKaR+C7V17FWb+qyxpObS3ugn7EUlBMIKIz2vg==
X-Received: by 2002:a05:6a20:508:b0:133:f5c1:57bb with SMTP id 8-20020a056a20050800b00133f5c157bbmr148855pzp.20.1689881456806;
        Thu, 20 Jul 2023 12:30:56 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id j21-20020aa78dd5000000b00682a61fa525sm1609779pfr.91.2023.07.20.12.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 12:30:55 -0700 (PDT)
Date:   Fri, 21 Jul 2023 01:00:51 +0530
Message-Id: <87zg3qmlck.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 2/4] ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow
In-Reply-To: <d75562f3-62fc-c54b-967b-0c2e9571b914@huawei.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Baokun Li <libaokun1@huawei.com> writes:

> On 2023/7/20 20:44, Ritesh Harjani (IBM) wrote:
>> Baokun Li <libaokun1@huawei.com> writes:
>>
>>> When we calculate the end position of ext4_free_extent, this position may
>>> be exactly where ext4_lblk_t (i.e. uint) overflows. For example, if
>>> ac_g_ex.fe_logical is 4294965248 and ac_orig_goal_len is 2048, then the
>>> computed end is 0x100000000, which is 0. If ac->ac_o_ex.fe_logical is not
>>> the first case of adjusting the best extent, that is, new_bex_end > 0, the
>>> following BUG_ON will be triggered:
>> Nice spotting.
>>
>>> =========================================================
>>> kernel BUG at fs/ext4/mballoc.c:5116!
>>> invalid opcode: 0000 [#1] PREEMPT SMP PTI
>>> CPU: 3 PID: 673 Comm: xfs_io Tainted: G E 6.5.0-rc1+ #279
>>> RIP: 0010:ext4_mb_new_inode_pa+0xc5/0x430
>>> Call Trace:
>>>   <TASK>
>>>   ext4_mb_use_best_found+0x203/0x2f0
>>>   ext4_mb_try_best_found+0x163/0x240
>>>   ext4_mb_regular_allocator+0x158/0x1550
>>>   ext4_mb_new_blocks+0x86a/0xe10
>>>   ext4_ext_map_blocks+0xb0c/0x13a0
>>>   ext4_map_blocks+0x2cd/0x8f0
>>>   ext4_iomap_begin+0x27b/0x400
>>>   iomap_iter+0x222/0x3d0
>>>   __iomap_dio_rw+0x243/0xcb0
>>>   iomap_dio_rw+0x16/0x80
>>> =========================================================
>>>
>>> A simple reproducer demonstrating the problem:
>>>
>>> 	mkfs.ext4 -F /dev/sda -b 4096 100M
>>> 	mount /dev/sda /tmp/test
>>> 	fallocate -l1M /tmp/test/tmp
>>> 	fallocate -l10M /tmp/test/file
>>> 	fallocate -i -o 1M -l16777203M /tmp/test/file
>>> 	fsstress -d /tmp/test -l 0 -n 100000 -p 8 &
>>> 	sleep 10 && killall -9 fsstress
>>> 	rm -f /tmp/test/tmp
>>> 	xfs_io -c "open -ad /tmp/test/file" -c "pwrite -S 0xff 0 8192"
>>
>> Could you please also add it into xfstests?
> Sure！I'll try to push this test case to xfstests.

Thanks that would be great!

>> I think it's a nice test which can check the boundary conditions for
>> start and end of data types used in mballoc. I think it should even work
>> if you don't do fsstress but instead just fallocate some remaining space
>> in filesystem, so that when you open and try to write it to 0th offset,
>> if automatically hits this error in ext4_mb_new_inode_pa().
> Yes, the fsstress here is just to fill up the remaining space on the disk.
>>
>>> We declare new_bex_start and new_bex_end as correct types and use fex_end()
>>> to avoid the problems caused by the ext4_lblk_t overflow above.
>>>
>>> Fixes: 93cdf49f6eca ("ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()")
>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>> ---
>>>   fs/ext4/mballoc.c | 11 +++++------
>>>   1 file changed, 5 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>>> index eb7f5d35ef96..2090e5e7ba58 100644
>>> --- a/fs/ext4/mballoc.c
>>> +++ b/fs/ext4/mballoc.c
>>> @@ -5076,8 +5076,8 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>>>   	pa = ac->ac_pa;
>>>   
>>>   	if (ac->ac_b_ex.fe_len < ac->ac_orig_goal_len) {
>>> -		int new_bex_start;
>>> -		int new_bex_end;
>>> +		ext4_lblk_t new_bex_start;
>>> +		loff_t new_bex_end;
>>>   
>>>   		/* we can't allocate as much as normalizer wants.
>>>   		 * so, found space must get proper lstart
>>> @@ -5096,8 +5096,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>>>   		 *    still cover original start
>>>   		 * 3. Else, keep the best ex at start of original request.
>>>   		 */
>>> -		new_bex_end = ac->ac_g_ex.fe_logical +
>>> -			EXT4_C2B(sbi, ac->ac_orig_goal_len);
>>> +		new_bex_end = fex_end(sbi, &ac->ac_g_ex, &ac->ac_orig_goal_len);
>>>   		new_bex_start = new_bex_end - EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
>>>   		if (ac->ac_o_ex.fe_logical >= new_bex_start)
>>>   			goto adjust_bex;
>>> @@ -5117,8 +5116,8 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>>>   
>>>   		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
>>>   		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
>>> -		BUG_ON(new_bex_end > (ac->ac_g_ex.fe_logical +
>>> -				      EXT4_C2B(sbi, ac->ac_orig_goal_len)));
>> Ok so the right hand becomes 0 (because then end can go upto 1<<32 which
>> will be 0 for unsigned int). And the left (new_bex_end) might be
>> negative due to some operations above as I see it.
>> And comparing an int with unsigned int, it will promote new_bex_end to
>> unsigned int which will make it's value too large and will hit the
>> bug_on.
> Exactly!
>>
>> I would like to carefully review all such paths. I will soon review and
>> get back.
> Okay, thank you very much for your careful review.
> The 2nd and 3rd cases of adjusting the best extent are impossible to 
> overflow,
> so only the first case is converted here.

I noticed them too during review. I think it would be safe to make the
changes in other two places as well such that in future we never
trip over such overlooked overflow bugs.

>>
>>
>>> +		BUG_ON(new_bex_end >
>>> +			fex_end(sbi, &ac->ac_g_ex, &ac->ac_orig_goal_len));
>> I am not sure whether using fex_end or pa_end is any helpful.
>> I think we can just typecast if needed and keep it simple rather
>> than adding helpers functions for addition operation.
>> (because of the fact that fex_end() can take a third parameter which
>> sometimes you pass as NULL. Hence it doesn't look clean, IMO)
> I added the helper functions here for two reasons:
> 1. restricting the type of the return value.
> 2. This avoids the ugly line breaks in most cases.
>
> The fex_end() indeed doesn't look as clean as the pa_end(), because we 
> might use
> the start of the free extent plus some other length to get a new end, 
> like right in
> ext4_mb_new_inode_pa(), which makes me have to add another extra length
> argument, but I think it's worth it, and even with the addition of a 
> parameter
> that will probably be unused, it still looks a lot shorter than the 
> original code.

IMO, we don't need pa_end() and fex_end() at all. In several places in
ext4 we always have taken care by directly typecasting to avoid
overflows. Also it reads much simpler rather to typecast in place than
having a helper function which is also not very elegant due to a third
parameter. Hence I think we should drop those helpers.

Thanks once again for catching the overflows and coming up with a
easy reproducer. I am surprised that this bug was never caught with LTP,
fstests, smatch static checker.
How did you find it? :)

-ritesh
