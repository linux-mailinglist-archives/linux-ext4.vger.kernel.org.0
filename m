Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007FF4CB2D6
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Mar 2022 00:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiCBXsW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Mar 2022 18:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiCBXsU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Mar 2022 18:48:20 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D7D12D20A
        for <linux-ext4@vger.kernel.org>; Wed,  2 Mar 2022 15:47:21 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id w4so3726430vsq.1
        for <linux-ext4@vger.kernel.org>; Wed, 02 Mar 2022 15:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=8YT+5Tuu3gutAxola1C4EJ30kzkV+xH/3+gyS4OqC4g=;
        b=iTOOgdYB6yxg1D0ivofQEXlxyBi4W/UFtUwTl21Y49/Qn3OBZATzTxRH7EuSXEW8w3
         npQt2t7kUwuYb0stnVDW122/7nLRPri9+VkYEQrPiJ/2jcYhiIKOWbeV+Iiqa6kYcsuM
         6MfRCyr1uhTNRmwyBWsrIlJe9PPrGQYNf4zrjq0T2URmI6y/jF200ux/Q8RMq10RXI9y
         MSJrkBba5ti/lB0SsqpqQpDj9+wnng2esGFn24FBwd22UMvHtQNDmuBVi2rs0lgXlEbI
         V99Aa8Uq+/GnWjcn6DyKv9pUxTU856EfQuPDKfcwkcIcyALLzSUufp4B5/hsmuFhqg/c
         FZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=8YT+5Tuu3gutAxola1C4EJ30kzkV+xH/3+gyS4OqC4g=;
        b=U0/P9oRJX1RzLdLBlUX0GqV3f86LVW03zmYvtzENgYvzgZ7GnIj9EloVmdORVwH5gE
         9Gi8jGYmJPM3ShoFL8KaQug4XugppFfEJzjh2PcHNN2Amp/5hleRvSc66UngXc1znUnW
         PG0CDyhQERUVMmstQodcWVsRQyjedCKDUD66yIAY6Cl0DvqKTWDdVr2+SyYhcjj0iDUe
         xFXyueGO0wTiYI+t3PVR5cPvs9ErQUHwcHFbVyPJe+90PY4pyRWNdB83zo8dJHPGGFFq
         cvM3aDYISJNajP7th5nZLuWvmuGtAjWAIUr6lZZqdvoqIkSoJ3Cv7Be0vpwRWjx4qXXW
         dxog==
X-Gm-Message-State: AOAM531dM0b8LuPbpcQjZzakHvllzijFOlTi8cfZNaYCiOB2BITgA7ad
        Ihs35LN8N/q/lKQxB7huvgXE3d8V18gU1Q==
X-Google-Smtp-Source: ABdhPJxVOiRVynKEu7q0zu6Y5MmQT50vzebW/Yvvr/JNqdWV4W4ljgp/Bes5bzBSILzM1xLX3AV8MA==
X-Received: by 2002:a05:6a00:139e:b0:4f1:37e5:c350 with SMTP id t30-20020a056a00139e00b004f137e5c350mr35598521pfg.27.1646262892979;
        Wed, 02 Mar 2022 15:14:52 -0800 (PST)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id rm8-20020a17090b3ec800b001bb82a67816sm120433pjb.52.2022.03.02.15.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 15:14:52 -0800 (PST)
Message-ID: <346904fd-112a-8d57-9221-b5c729ea6056@linaro.org>
Date:   Wed, 2 Mar 2022 15:14:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: BUG in ext4_ind_remove_space
Content-Language: en-US
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
References: <48308b02-149b-1c47-115a-1a268dac6e24@linaro.org>
 <20220225171016.zwhp62b3yzgewk6l@riteshh-domain>
 <25749d7d-7036-0b71-3dd8-7b04dcc430e4@linaro.org>
In-Reply-To: <25749d7d-7036-0b71-3dd8-7b04dcc430e4@linaro.org>
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

On 2/25/22 11:19, Tadeusz Struk wrote:
>> I can verify this sometime next week when I get back to it.
>> But thanks for reporting the issue :)
> 
> Next week is perfectly fine. Thanks for looking into it.

Hi Ritesh,
Did you have chance to look into this?
If you want I can send a patch that fixes the off by 1 calculation error.

-- 
Thanks,
Tadeusz
