Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5085A4C4E85
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Feb 2022 20:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiBYTT6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Feb 2022 14:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbiBYTT4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Feb 2022 14:19:56 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1895195336
        for <linux-ext4@vger.kernel.org>; Fri, 25 Feb 2022 11:19:21 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id x11so5589613pll.10
        for <linux-ext4@vger.kernel.org>; Fri, 25 Feb 2022 11:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9fbaEoyP6CTzGYQjVSR4Oe1Sa+YnNbvO8HACned25xo=;
        b=Q1Ic/oefqBXYMB526iJWxDsmybT4YHLeHBZn84OmKOrd1pnhb8fcZIpdsTjQ5V/EUL
         V5mJK0xGefy0kFZ74S/s3Zf03eZt7z2SLZDYymY7Mfw3bu1vUIawZokexDKolfGAYxTh
         ECY1QhQ9yNO+pjQBhXeRC+RXAYU5zCQ6h1tiGkdc96pNbvhJaJYtdoP8m6crTVIzfO7n
         sRI1bahjQuumvszPmgZYW058nhTGZGAlVIGFICGoVlwJzvSl7L+gftBX1wQQVAEOfvf2
         5H68Iq537pP2tjSY+2l/xbkVOjG49lnK82qRvpFjBs928/uDsckhSalQ2Ei9PqsM+lMc
         mqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9fbaEoyP6CTzGYQjVSR4Oe1Sa+YnNbvO8HACned25xo=;
        b=i+LCmTMQ48xH9m8DTZ+HUNhCq6JB05cNn8o3QhOwLd8/GYfiU8JRJTrfRtrVoZJ6dV
         fuis13U0v0xyRKRt7ddyMt22zAsgSXR1DdyU2fTQerSBevLVoljOuAk7xDf0uefNEQ9m
         WXY2/JgBTXLXEIYwGMja9l6wgbr+5P2enE93atomD5wxN7tfOpAOVFpSn8ezMx69LO8m
         rxhR5E9+w5yMB11vLAZUJAlVR6vvBt3Af9+OlMigfMuBEkWNCV4IPcgQbmBF4eiPexCx
         0jtsSaRVHtBEpV5ra/ovRaEf36fE/dGPBjJOYP7h6y7aBwmr758RxToIDEPTZbxYLUZ5
         hfeQ==
X-Gm-Message-State: AOAM530Go/d6BOALg5P36fjXcB0spi7uNOxoaAdwc+lej5uGhqaz3t9z
        beamSwr4b2zvwp3gu6wBDKZ1GU7BTwVyIQ==
X-Google-Smtp-Source: ABdhPJzE8/uGr1RhfhSg8oFoOW9jehHCQFXz0ws8GUYmdKEv+r7IW0ddAy8jxGuBYgtmgnD40TED3g==
X-Received: by 2002:a17:902:e945:b0:14e:b8d9:aa07 with SMTP id b5-20020a170902e94500b0014eb8d9aa07mr8740999pll.163.1645816761184;
        Fri, 25 Feb 2022 11:19:21 -0800 (PST)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id x42-20020a056a0018aa00b004e1bf2a3376sm4126644pfh.215.2022.02.25.11.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 11:19:20 -0800 (PST)
Message-ID: <25749d7d-7036-0b71-3dd8-7b04dcc430e4@linaro.org>
Date:   Fri, 25 Feb 2022 11:19:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: BUG in ext4_ind_remove_space
Content-Language: en-US
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
References: <48308b02-149b-1c47-115a-1a268dac6e24@linaro.org>
 <20220225171016.zwhp62b3yzgewk6l@riteshh-domain>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
In-Reply-To: <20220225171016.zwhp62b3yzgewk6l@riteshh-domain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2/25/22 09:10, Ritesh Harjani wrote:
> On 22/02/24 05:12PM, Tadeusz Struk wrote:
>>
>> Hi,
>> Syzbot found an issue [1] in fallocate() that looks to me like a loss of precision.
>> The C reproducer [2] calls fallocate() and passes the size 0xffeffeff000ul, and
>> offset 0x1000000ul, which is then used to calculate the first_block and
>> stop_block using ext4_lblk_t type (u32). I think this gets the MSB of the size
>> truncated and leads to invalid calculations, and eventually his BUG() in
>> https://elixir.bootlin.com/linux/v5.16.11/source/fs/ext4/indirect.c#L1244
>> The issue can be reproduced on 5.17.0-rc5, but I don't think it's a new
>> regression. I spent some time debugging it, but could spot anything obvious.
>> Can someone have a look please.
> 
> I did look into it a little. Below are some of my observations.
> If nobody gets to it before me, I can spend sometime next week to verify it's
> correctness.
> 
> So I think based on the warning log before kernel BUG_ON() [1], it looks like it
> has the problem with ext4_block_to_path() calculation with end offset.
> It seems it is not fitting into triple block ptrs calculation.
> 
> <log>
> ======
> EXT4-fs warning (device sda1): ext4_block_to_path:107: block 1074791436 > max in inode 1137
> 
> But ideally it should fit in (right?) since we do make sure if end >= max_block;
> then we set it to end = max_block.
> 
> Then looking at how we calculate max_block is below
> 	max_block = (EXT4_SB(inode->i_sb)->s_bitmap_maxbytes + blocksize-1) >> EXT4_BLOCK_SIZE_BITS(inode->i_sb);
> 
> So looking closely I think there _could be_ a off by 1 calculation error in
> above. So I think above calculation is for max_len and not max_end_block.
> 
> I think max_block should be max_end_block which should be this -
> 	max_end_block = ((EXT4_SB(inode->i_sb)->s_bitmap_maxbytes + blocksize-1) >> EXT4_BLOCK_SIZE_BITS(inode->i_sb))-1;
> 
> 
> But I haven't yet verified it completely. This is just my initial thought.
> Maybe others can confirm too. Or maybe there is more then one problem.
> But somehow above looks more likely to me.

I tried the above and it does help.

> 
> I can verify this sometime next week when I get back to it.
> But thanks for reporting the issue :)

Next week is perfectly fine. Thanks for looking into it.

-- 
Thanks,
Tadeusz
