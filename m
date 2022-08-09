Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AC258D8C8
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 14:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242502AbiHIMgB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 08:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiHIMgA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 08:36:00 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D3DEB;
        Tue,  9 Aug 2022 05:35:59 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a7so21976638ejp.2;
        Tue, 09 Aug 2022 05:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=7WybJd0pGKQDe7CErki7Z8w7XG5ZeUO7EhKpAVO7rik=;
        b=2bf630qmqkBjLk/vwQ5wIPEMoz9Gc5okxFkjIljMhFKAnoMKmZcbtMaBFyxlSVGFdw
         a4eTOpkv+w3h+TZVzh/6kzKREslxvcghHsS++cgX+YXT79mTrJvrvnCfdzqpFJGK/uPZ
         M7RVoXhyCWARarqoOokD7tyYakLoAt+Wuqs40x6hbhvpjUcV+ESDhQUsDlZoRctFAnHT
         bnk2aweDE8JZzGurFxZqmbvjHGyGED1KfSwKesaYtObozTAfbV8mmlRJeHabfHhb/4ar
         WjVuND1A8dRP1q3kLYw0cMM3XTF1Gmm7kNCOocQsCWzadCoC/ejyVgcJds6u7bFn8x5P
         2MIw==
X-Gm-Message-State: ACgBeo0M3aWhwpKZdimjTFTYp2pPJ6pZpbMqEoN2J/EoNGmQZieXekjO
        oRUgLVGwzg8AgKUYfYQIySbyd3GdKVk=
X-Google-Smtp-Source: AA6agR4BtTt1/GK7n2daKc3PEBD7L48re6WImTbv0vGmQzXaGX2oBDgbELM0PesHTEqdHiwHWPoMPw==
X-Received: by 2002:a17:907:2e0d:b0:731:7afa:f14f with SMTP id ig13-20020a1709072e0d00b007317afaf14fmr4670017ejc.704.1660048558059;
        Tue, 09 Aug 2022 05:35:58 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id a20-20020aa7d914000000b0043e398c0534sm5910923edr.94.2022.08.09.05.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 05:35:57 -0700 (PDT)
Message-ID: <9fd860a8-4e4f-6a95-5c3f-1b3c4a76cf51@kernel.org>
Date:   Tue, 9 Aug 2022 14:35:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: ext2/zram issue [was: Linux 5.19]
Content-Language: en-US
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        minchan@kernel.org, ngupta@vflare.org, Jan Kara <jack@suse.com>,
        Ted Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        avromanov@sberdevices.ru, ddrokosov@sberdevices.ru
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
 <702b3187-14bf-b733-263b-20272f53105d@kernel.org>
 <c7c69f77-4ea2-3375-33f3-322a3d35def5@kernel.org>
 <8710b302-9415-458d-f8a2-b78cc3a96e49@kernel.org>
 <YvIeLHuEb9XDSp6N@google.com> <YvIk3SdC7wP3uItR@google.com>
 <YvImxBsHJcpNzC+i@google.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <YvImxBsHJcpNzC+i@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 09. 08. 22, 11:20, Sergey Senozhatsky wrote:
> On (22/08/09 18:11), Sergey Senozhatsky wrote:
>>>>> /me needs to confirm.
>>>>
>>>> With that commit reverted, I see no more I/O errors, only oom-killer
>>>> messages (which is OK IMO, provided I write 1G of urandom on a machine w/
>>>> 800M of RAM):
>>>
>>> Hmm... So handle allocation always succeeds in the slow path? (when we
>>> try to allocate it second time)
>>
>> Yeah I can see how handle re-allocation with direct reclaim can make it more
>> successful, but in exchange it oom-kills some user-space process, I suppose.
>> Is oom-kill really a good alternative though?
> 
> We likely will need to revert e7be8d1dd983 given that it has some
> user visible changes. But, honestly, failing zram write vs oom-kill
> a user-space is a tough choice.

Note that it OOMs only in my use case -- it's obviously too large zram 
on too low memory machine.

But the installer is different. It just creates memory pressure, yet, 
reclaim works well and is able to find memory and go on. I would say 
atomic vs non-atomic retry in the original (pre-5.19) approach makes the 
difference.

And yes, we should likely increase the memory in openQA to avoid too 
many reclaims...

PS the kernel finished building, now images are built, hence the new 
openQA run hasn't started yet. I will send the revert when it's complete 
and all green.

thanks,
-- 
js
suse labs

