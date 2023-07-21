Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6776175C179
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 10:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjGUIYV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jul 2023 04:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjGUIYT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Jul 2023 04:24:19 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC88ED;
        Fri, 21 Jul 2023 01:24:17 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-676f16e0bc4so1132308b3a.0;
        Fri, 21 Jul 2023 01:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689927857; x=1690532657;
        h=content-transfer-encoding:mime-version:in-reply-to:subject:cc:to
         :from:message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5eCjY1ccOsJZekR1LZ1wDvCgsHXjpOKnCMfkzSh5Qo=;
        b=malwDP5+gMrfljI4kNLzqp1t6z20KhKN26Q9T1EqhsZ1KTgeAHB4YNh2e0Ph68p9Fu
         39kYX6Ye2DkzgLDRgV34opAHRHamYq29sTHqtSJ+BmkTjw9l6c7Yi6YYUkKUYHCUE7ts
         pau4QfLML8X4onjT640fqNNOgmeffkahCWHArjK+pe3dpzdY4YvQtYzzq43UAtK6lFv+
         8USr8iN7KxjFf68YSZJcNFvJLqjyySxCtYtBnEDRArkyChGvRd34ci4XQgo0lHYuqBJh
         vQSeNuEJXAZBWdrpR6awYBjiVR5EVt3ySIVJIUw/ozgSSmqq+FjCSXnN8ShMWZIM0kym
         aGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689927857; x=1690532657;
        h=content-transfer-encoding:mime-version:in-reply-to:subject:cc:to
         :from:message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5eCjY1ccOsJZekR1LZ1wDvCgsHXjpOKnCMfkzSh5Qo=;
        b=PnESjojryAADafee0rnFC+Go7yYyTtW/Mr21OZquibwDGaEUG4ICXIzL2CdSjeblm4
         YPRKijPiZ5flDr9NfqszUzdmi2d5bw7Vb7gld47sGF0p4R8NT+j4Pqaoci3JBHAq6w7h
         j7Stm8xDN8VF3rF1F4EkCa6xD9KRMXFXJ95AUjZkMeOfRcCNDjynZFyLGohgr0QgPHlp
         l/Dw7vQSx7LjCpCTZCsP8fXEZQ1FfUnVDmuvUnFKoXPBoHqcRufd4C+68ECRC3LFvk8m
         VvfA4NRlUXWSJUVaHtYyERCJzWZ+nbanK+q/cDItMZOE6yQ7wp3iyl3xTiSwOsSLduZ1
         mnuw==
X-Gm-Message-State: ABy/qLaQkmCJOHJor9rH7k/9TIIQB1BXbh8uw5xYfqNlP+DPCHf5vhQw
        UKUUjtz51/5Qz6iPhuLhlrNtDhpt4Nc=
X-Google-Smtp-Source: APBJJlGUlVCfqNHdoEk3BWg5wlLbqp11T8VM3lwRvm3REUlO658pBRrp/zkCS85+3VB4tmgHBONqDw==
X-Received: by 2002:a05:6a20:8425:b0:130:46ea:29cb with SMTP id c37-20020a056a20842500b0013046ea29cbmr1307797pzd.25.1689927856843;
        Fri, 21 Jul 2023 01:24:16 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id ja13-20020a170902efcd00b001b9ce2c3baesm2812508plb.143.2023.07.21.01.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 01:24:16 -0700 (PDT)
Date:   Fri, 21 Jul 2023 13:54:06 +0530
Message-Id: <87lef9lljt.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
        Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 2/4] ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow
In-Reply-To: <5bd0a3a3-f38a-bd63-21e7-d649b2fb47b0@huawei.com>
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

> On 2023/7/21 3:30, Ritesh Harjani (IBM) wrote:
>>
>>>> I would like to carefully review all such paths. I will soon review and
>>>> get back.
>>> Okay, thank you very much for your careful review.
>>> The 2nd and 3rd cases of adjusting the best extent are impossible to
>>> overflow,
>>> so only the first case is converted here.
>> I noticed them too during review. I think it would be safe to make the
>> changes in other two places as well such that in future we never
>> trip over such overlooked overflow bugs.
>>
>>>>
>>>>> +		BUG_ON(new_bex_end >
>>>>> +			fex_end(sbi, &ac->ac_g_ex, &ac->ac_orig_goal_len));
>>>> I am not sure whether using fex_end or pa_end is any helpful.
>>>> I think we can just typecast if needed and keep it simple rather
>>>> than adding helpers functions for addition operation.
>>>> (because of the fact that fex_end() can take a third parameter which
>>>> sometimes you pass as NULL. Hence it doesn't look clean, IMO)
>>> I added the helper functions here for two reasons:
>>> 1. restricting the type of the return value.
>>> 2. This avoids the ugly line breaks in most cases.
>>>
>>> The fex_end() indeed doesn't look as clean as the pa_end(), because we
>>> might use
>>> the start of the free extent plus some other length to get a new end,
>>> like right in
>>> ext4_mb_new_inode_pa(), which makes me have to add another extra length
>>> argument, but I think it's worth it, and even with the addition of a
>>> parameter
>>> that will probably be unused, it still looks a lot shorter than the
>>> original code.
>> IMO, we don't need pa_end() and fex_end() at all. In several places in
>> ext4 we always have taken care by directly typecasting to avoid
>> overflows. Also it reads much simpler rather to typecast in place than
>> having a helper function which is also not very elegant due to a third
>> parameter. Hence I think we should drop those helpers.
> I still think helper is useful, but my previous thinking is problematic. 
> I shouldn't
> make fex_end() adapt to ext4_mb_new_inode_pa(), but should make
> ext4_mb_new_inode_pa() adapt to fex_end(). After dropping the third argument
> of fex_end(), modify the ext4_mb_new_inode_pa() function as follows:

No. I think we are overly complicating it by doing this. IMHO we don't need
fex_end and pa_end at all here. With fex_end, pa_end, we are passing pointers,
updating it's members before and after sending it to these functions,
dereferencing them within those helpers.

e.g. with your change it will look like 
<snip>
		struct ext4_free_extent ex = {
			.fe_logical = ac->ac_g_ex.fe_logical;
			.fe_len = ac->ac_orig_goal_len;
		}

        loff_t orig_goal_end = fex_end(sbi, &ex);
		ex.fe_len = ac->ac_b_ex.fe_len;
		ex.fe_logical = orig_goal_end - EXT4_C2B(sbi, ex.fe_len);
		if (ac->ac_o_ex.fe_logical >= ex.fe_logical)
			goto adjust_bex;
</snip>

In above snip we introduced ex variable, updated it with
orig_goal_len, then called fex_end() to get orig_goal_end, then we again
updated ex.fe_len, but this time we didn't call fex_end instead we
needed it for getting ex.fe_logical. All of this is not needed at all. 

e.g. we should use just use (loff_t) wherever it was missed in the code.
<snip>
		ext4_lblk_t new_bex_start;
		loff_t new_bex_end;

		new_bex_end = (loff_t)ac->ac_g_ex.fe_logical +
			EXT4_C2B(sbi, ac->ac_orig_goal_len);
		new_bex_start = new_bex_end - EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
		if (ac->ac_o_ex.fe_logical >= new_bex_start)
			goto adjust_bex;
</snip>


In this we just update (loff_t) and it reads better in my opinion then
using ex, fex_end() etc.

In my opinion we should simply drop the helpers. It should be obvious
that while calculating logical end block for an inode in ext4 by doing
lstart + len, we should use loff_t.
Since it can be 1 more than the last block which a u32 can hold.
So wherever such calculations are made we should ensure the data
type of left hand operand should be loff_t and we should typecast the
right hand side operands such that there should not be any overflow
happening. We do at several places in ext4 already (also while doing
left-shifting (loff_t)map.m_lblk).

Doing this with helpers, IMO is not useful as we also saw above.

>
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index a2475b8c9fb5..7492ba9062f4 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5072,8 +5072,11 @@ ext4_mb_new_inode_pa(struct 
> ext4_allocation_context *ac)
>          pa = ac->ac_pa;
>
>          if (ac->ac_b_ex.fe_len < ac->ac_orig_goal_len) {
> -               int new_bex_start;
> -               int new_bex_end;
> +               struct ext4_free_extent ex = {
> +                       .fe_logical = ac->ac_g_ex.fe_logical;
> +                       .fe_len = ac->ac_orig_goal_len;
> +               }
> +               loff_t orig_goal_end = fex_end(sbi, &ex);
>
>                  /* we can't allocate as much as normalizer wants.
>                   * so, found space must get proper lstart
> @@ -5092,29 +5095,23 @@ ext4_mb_new_inode_pa(struct 
> ext4_allocation_context *ac)
>                   *    still cover original start
>                   * 3. Else, keep the best ex at start of original request.
>                   */
> -               new_bex_end = ac->ac_g_ex.fe_logical +
> -                       EXT4_C2B(sbi, ac->ac_orig_goal_len);
> -               new_bex_start = new_bex_end - EXT4_C2B(sbi, 
> ac->ac_b_ex.fe_len);
> -               if (ac->ac_o_ex.fe_logical >= new_bex_start)
> -                       goto adjust_bex;
> +               ex.fe_len = ac->ac_b_ex.fe_len;
>
> -               new_bex_start = ac->ac_g_ex.fe_logical;
> -               new_bex_end =
> -                       new_bex_start + EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
> -               if (ac->ac_o_ex.fe_logical < new_bex_end)
> +               ex.fe_logical = orig_goal_end - EXT4_C2B(sbi, ex.fe_len);
> +               if (ac->ac_o_ex.fe_logical >= ex.fe_logical)
>                          goto adjust_bex;
>
> -               new_bex_start = ac->ac_o_ex.fe_logical;
> -               new_bex_end =
> -                       new_bex_start + EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
> +               ex.fe_logical = ac->ac_g_ex.fe_logical;
> +               if (ac->ac_o_ex.fe_logical < fex_end(sbi, &ex))
> +                       goto adjust_bex;
>
> +               ex.fe_logical = ac->ac_o_ex.fe_logical;
>   adjust_bex:
> -               ac->ac_b_ex.fe_logical = new_bex_start;
> +               ac->ac_b_ex.fe_logical = ex.fe_logical;
>
>                  BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
>                  BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
> -               BUG_ON(new_bex_end > (ac->ac_g_ex.fe_logical +
> -                                     EXT4_C2B(sbi, ac->ac_orig_goal_len)));
> +               BUG_ON(fex_end(sbi, &ex) > orig_goal_end);
>          }
>
>          pa->pa_lstart = ac->ac_b_ex.fe_logical;
>
>
> What do you think of this modification?
>
>> Thanks once again for catching the overflows and coming up with a
>> easy reproducer. I am surprised that this bug was never caught with LTP,
>> fstests, smatch static checker.
>> How did you find it? :)
>>
>> -ritesh
> This problem is found in the internal test.

Ok.

>
> Thank you for your review!

Thanks for working on the fix.

-ritesh
