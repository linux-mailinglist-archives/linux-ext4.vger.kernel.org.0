Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3B77B11A7
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Sep 2023 06:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjI1Emn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Sep 2023 00:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1Emn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Sep 2023 00:42:43 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D868E121;
        Wed, 27 Sep 2023 21:42:41 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-53fa455cd94so8367794a12.2;
        Wed, 27 Sep 2023 21:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695876161; x=1696480961; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aPa0SZbYfyUdg5R72MYeA2gmPecpyPjsen6bmTHE94w=;
        b=GuQe5iw84Mtna0JGCThAnoq2VC+VM/58geP/x8br9zA+17wuK+Ws+0o0qOvVAG8AUm
         xu8p/WIUwVA9d8yajoInfn6qXoRvZuSJiiAG/qPb9gBMJsCKbdPPAF3VCArOBIjiPLB5
         oEaSpUJEIlFqGqYNmw1sm3+N3vLF+hKqpifbeuttY3RR7+MIuGsHSzNL8RQoR2QXwv9i
         5VbetuhjAvTHbITTw4xYzLpHqO/ZiLlFk3LeSVBz2518XfdXQtmOajWOWM0p41uwBN1H
         XipKuwATJyzHbatbYjJY4oK9YoxxBB1zzrZsrhcsY1ZW41ewC4KuyUiT63hcnzdkAmuu
         SdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695876161; x=1696480961;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aPa0SZbYfyUdg5R72MYeA2gmPecpyPjsen6bmTHE94w=;
        b=DGUIaot8cF/rp37Omgqb1iauO/0l0/ZUp0/VOpNHZCr31TtfReKZKekZHolpajZg2a
         4NCc8yl8/l2C6o3f+Pe1XOlEnGACVJr0spw63bBbEMNg79/KmmIyuQz/ePNYuV3JuZ6e
         wmQ1LKsixVe2P1SglwBl4Ll5O6fe6Dj3ZgMmKFZvMb1PBAy2F35PJkJ7AO/4VLvIIfvS
         2cOI+jDoNSJQosV1u/E6fJjenN9C8osu/mFpNN9NagKHnmQKLP8gNUIRNDbEKJ+Gh9rn
         fpNckitbCirPf2mFJf/axZHqdqxb3QRruhSZ1BXzsfavbIZI9zas54/Hjvb9YagG4syr
         7Qkg==
X-Gm-Message-State: AOJu0YyS5unw105wyamWcGQDXQcHBAa1srv1yRBArAw99AjrC24H2Ip4
        HR5numIj7enmS1JhqyllYWCoAFON0L8=
X-Google-Smtp-Source: AGHT+IEkXLB7SLarwB05QYdH4aG1mKn0t8M5gFVefBN4XqRwHuJMiTAYHsqtCOGLFT5gvJckTnutaA==
X-Received: by 2002:a05:6a20:13da:b0:15a:592c:131a with SMTP id ho26-20020a056a2013da00b0015a592c131amr174463pzc.30.1695876160706;
        Wed, 27 Sep 2023 21:42:40 -0700 (PDT)
Received: from dw-tp ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d31200b001b03a1a3151sm2819742plc.70.2023.09.27.21.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 21:42:39 -0700 (PDT)
Date:   Thu, 28 Sep 2023 10:12:29 +0530
Message-Id: <87sf6yrjre.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/12] ext4: factor out codes to update block bitmap and group descriptor on disk from ext4_mb_mark_bb
In-Reply-To: <309d082f-45b9-9dac-9921-6c3d44de17a7@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kemeng Shi <shikemeng@huaweicloud.com> writes:

> on 9/27/2023 4:49 PM, Ritesh Harjani wrote:
>> Kemeng Shi <shikemeng@huaweicloud.com> writes:
>> 
>>> There are several reasons to add a general function ext4_mb_mark_context
>>> to update block bitmap and group descriptor on disk:
>>> 1. pair behavior of alloc/free bits. For example,
>>> ext4_mb_new_blocks_simple will update free_clusters in struct flex_groups
>>> in ext4_mb_mark_bb while ext4_free_blocks_simple forgets this.
>>> 2. remove repeat code to read from disk, update and write back to disk.
>>> 3. reduce future unit test mocks to catch real IO to update structure
>>> on disk.
>>>
>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>> ---
>>>  fs/ext4/mballoc.c | 147 ++++++++++++++++++++++++----------------------
>>>  1 file changed, 77 insertions(+), 70 deletions(-)
>>>
>>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>>> index cf09adfbaf11..e1320eea46e9 100644
>>> --- a/fs/ext4/mballoc.c
>>> +++ b/fs/ext4/mballoc.c
>>> @@ -3953,6 +3953,80 @@ void ext4_exit_mballoc(void)
>>>  	ext4_groupinfo_destroy_slabs();
>>>  }
>>>  
>>> +static int
>>> +ext4_mb_mark_context(struct super_block *sb, bool state, ext4_group_t group,
>>> +		     ext4_grpblk_t blkoff, ext4_grpblk_t len)
>> 
>> 
>> ext4_grpblk_t is defined as int.
>>     /* data type for block offset of block group */
>>     typedef int ext4_grpblk_t;
>> 
>> I think len should be unsigned int (u32) here. 
>> 
> Hi Ritesh, thanks for reply and a lot suggestions to this patch and other
> patches in this series.
> I define len as ext4_grpblk_t as I think ext4_grpblk_t is supposed to fit
> block or cluster number of single group.
>

At different places the use of datatype for no. of blocks/clusters within
a group gets very confusing :(

However, IMO ext4_grpblk_t should be fine for using len argument here.
I did respond about that while reviewing in some later patches [1]

[1]: https://lore.kernel.org/linux-ext4/87r0mkey45.fsf@doe.com/

So, I don't think we need any changes to this patch. 
    Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Also overall the series looks good. There are just some minor
changes suggested in 1st patch and some commit msg updates suggested for
other changes. If you send a v8, then I think that looks good to be
picked up :) 

Thanks a lot for working on it & the suggested changes!

-ritesh
