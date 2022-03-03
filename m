Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27534CC187
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Mar 2022 16:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbiCCPiK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Mar 2022 10:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbiCCPiI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Mar 2022 10:38:08 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63471194165
        for <linux-ext4@vger.kernel.org>; Thu,  3 Mar 2022 07:37:23 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id e2so4858865pls.10
        for <linux-ext4@vger.kernel.org>; Thu, 03 Mar 2022 07:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=S6GwEiWawFVGXEKP9HgkfVlFyF83jg2EieSPr6ThFXk=;
        b=FP/+4u9ZWslnptfZ4P5JD4GvDA5ki4uAdWGK1DXQNPuAU31pPahTmKQsOnjQOOGSJ4
         tEimGZ9V2jz+pipxb6wgIOHa3dZ66vl5MijmGZ0Du1qBhY1h75RdWOrxSncUt5YAjWXF
         b28QyTW7zXOF63p5PRfxBwtADRDb2VsGJlmAoZ0ivQJ5rPT3LvVrGp0Q9vQtgnD5/gSo
         GRNI9KMwJNUVhxcoWeosiOFSS2HcFvVrGMw9eYn5Wvgu18xGWTeSuwH4OcN2SAOXM8w9
         XBgNuFlaPNS7k5Cj54H8tKQP7/duRwpF7GPeqTp/5rrWie8G2wp9P/Q5DXFijT7IaBxW
         nC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=S6GwEiWawFVGXEKP9HgkfVlFyF83jg2EieSPr6ThFXk=;
        b=mwViJC4ADeWQcthlKuFVm763P+m98/1Z6QcQFqFWqBwatRSX9U/zMtVUWjjwaCH4vb
         C+10e3zEjmKlPSQnE+S6eumgTkTe2rGfIZwetjK4qoO9LM9Tf9HvspM4dftd8HRhbVZS
         ulLYQrGybvB1CQjtPlrgr1SJX1bKUVSz42ijZPERUyEMTciBftAdxUkyE9I8Osn7oHa8
         /VnMyC9y4TZYU17rom+hvA+p98hDSpObMydWBQiw1g+oTo6NF71i2wZnZFLj1bbfQRUN
         eFxUrQIZSdh4lfWviGn83K/OhTuiaw5Hkbwx1tGTW5Iwal0f6YXsdimKHZ/5G9AdryrS
         kSwQ==
X-Gm-Message-State: AOAM532OJQIt4dAkCak0n7BEU8EDgANLCOX0jcngwPpZ34Z7PRa4Uh9T
        tP0tMsUaTy6PBgFR7lN7ohd6lQ==
X-Google-Smtp-Source: ABdhPJwkb26DXT4kKCNrrSW/I2fvfv56yg58mqWawMoyro9n0CDYTmRJpadEEti26Kawk7ta08j8WA==
X-Received: by 2002:a17:90a:9292:b0:1bd:1bf0:30e6 with SMTP id n18-20020a17090a929200b001bd1bf030e6mr5865952pjo.73.1646321842888;
        Thu, 03 Mar 2022 07:37:22 -0800 (PST)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id oa2-20020a17090b1bc200b001bcff056f09sm2545893pjb.13.2022.03.03.07.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 07:37:22 -0800 (PST)
Message-ID: <995d8b3c-44ee-e190-42ae-75f2562b8d6b@linaro.org>
Date:   Thu, 3 Mar 2022 07:37:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
References: <48308b02-149b-1c47-115a-1a268dac6e24@linaro.org>
 <20220225171016.zwhp62b3yzgewk6l@riteshh-domain>
 <25749d7d-7036-0b71-3dd8-7b04dcc430e4@linaro.org>
 <346904fd-112a-8d57-9221-b5c729ea6056@linaro.org>
 <20220303145651.ackek7wotphg26gm@riteshh-domain>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: BUG in ext4_ind_remove_space
In-Reply-To: <20220303145651.ackek7wotphg26gm@riteshh-domain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 3/3/22 06:56, Ritesh Harjani wrote:
> On 22/03/02 03:14PM, Tadeusz Struk wrote:
>> On 2/25/22 11:19, Tadeusz Struk wrote:
>>>> I can verify this sometime next week when I get back to it.
>>>> But thanks for reporting the issue :)
>>>
>>> Next week is perfectly fine. Thanks for looking into it.
>>
>> Hi Ritesh,
>> Did you have chance to look into this?
>> If you want I can send a patch that fixes the off by 1 calculation error.
> 
> Hi Tadeusz,
> 
> I wanted to look at that path a bit more before sending that patch.
> Last analysis by me was more of a cursory look at the kernel dmesg log which you
> had shared.
> 
> In case if you want to pursue that issue and spend time on it, then feel free to
> do it.
> 
> I got pulled into number of other things last week and this week. So didn't get
> a chance to look into it yet. I hope to look into this soon (if no one else
> picks up :))

I'm not familiar with the internals of ext4 implementation so I would rather
have someone who knows it look at it.
I will wait till the end of this week and if there will be fix for it by then
I will send a patch fixing the off by 1 issue to get the ball rolling.

-- 
Thanks,
Tadeusz
