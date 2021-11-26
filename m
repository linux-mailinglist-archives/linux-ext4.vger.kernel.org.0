Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF9A45F4B4
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Nov 2021 19:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239794AbhKZSi4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Nov 2021 13:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbhKZSg4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 26 Nov 2021 13:36:56 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D50C07E5F4
        for <linux-ext4@vger.kernel.org>; Fri, 26 Nov 2021 10:10:11 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id z26so12383235iod.10
        for <linux-ext4@vger.kernel.org>; Fri, 26 Nov 2021 10:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w7CM3ybXkX6FdnmkDgtC04LvePrjVXFwUyZ4uxrkvxw=;
        b=P8Ix0b+8pqLzJ0JCQMU2IsK8LUujjsUrb3I7IY1MpjfctmRfdlJ4p5tQIRJzkm1aOz
         NEkeOe/Fpw0bltwzcwIBsjrvsMFs+atSgWqaJBoi1ve+1El4o+XCYCZk7ONPmcUPhr0Q
         VY2Y363OEpPx+MVKPTIo7svhG2nMbqSLtYfjGO7290AYp504mY/rhBkFJqwLmxNGmdCC
         IR6hV7/8/Ng6R2bTvHJ81I08OFXyRyKS6gBHjJKWfVSk5khiZDKwJlCNGwfwUBkXrYO0
         yr6CtDeMftUyZMd+0437LW51xaN8/Ora/MppBtTIvenEiWXu06d1T0X1om2tC4k/M9DP
         NNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w7CM3ybXkX6FdnmkDgtC04LvePrjVXFwUyZ4uxrkvxw=;
        b=aCkgUlS/nUVNvjo2GcWi6dN391Qo8Wm+walgtcwZiw4Evjm5NofMb5fRebGXX38rlv
         UgvjUjYnldq+pi6rdWE1Rzh+7hiqdYHVmHHPfhLUpSNiO3DRN3q69alTRsyeRz3LwHEP
         oZ9lq4FXZzqfUhZMGFjtxKTmI5EhijCYRNUWFOu//hnGLzoh8F5wqbeinRq4Av9c6mRH
         ZBmYzUu4qgTg7nU0XQINbDASHuK6370TqyhuOhXzcFmaZc+vWPUEuzbGsqwHrer+7fl7
         MmbXD73jWVJIVZQkO9VrWse/StHIDR10JGHv8Awr2pAzJmcmmbODSLGFcB/i65M/2mU8
         fPUg==
X-Gm-Message-State: AOAM532DUPrSD4VHcNTOy/C9kJFdTzKWEvPPDRvufpF6TEnfRUUWxBpF
        d8/csuWZikFR5R6lveFDnjNXMg==
X-Google-Smtp-Source: ABdhPJxGCB354MvIlJjaIRBZzlJPUUDQyfSJlCoz2hhDCkTQKLQVSnsDHVTgVFm+cuSMnozo2m/8Xw==
X-Received: by 2002:a05:6638:3014:: with SMTP id r20mr20589348jak.146.1637950211126;
        Fri, 26 Nov 2021 10:10:11 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id d137sm3510617iof.16.2021.11.26.10.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 10:10:10 -0800 (PST)
Subject: Re: Write I/O queue hangup at random on recent Linus' kernels
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nvme@lists.infradead.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
 <b9c2681f-e63a-4d3b-913d-d8a75e2c2ea0@kernel.dk>
 <be6a783-97db-c3bf-b16f-e8c62b14755d@panix.com>
 <17206ea6-506d-b1de-09e8-c935ff308bd6@kernel.dk>
 <903be817-4118-f34e-1b35-a0108045590f@kernel.dk>
 <986e942b-d430-783b-5b1c-4525d4a94e48@panix.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ddc41b84-c414-006a-0840-250281caf1e5@kernel.dk>
Date:   Fri, 26 Nov 2021 11:10:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <986e942b-d430-783b-5b1c-4525d4a94e48@panix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 11/26/21 10:58 AM, Kenneth R. Crudup wrote:
> 
> On Fri, 26 Nov 2021, Jens Axboe wrote:
> 
>> Can you apply this on top of 5.16-rc2 or current -git and see if it fixes
>> it for you?
> 
> Since it's related to writeback throttling, is there anything I can try to
> taunt it? I was thinking "iozone" or "bonnie++", but if there's something
> better, let me know.

I'd just do what you usually do, that's usually the best way to gain
confidence in the fix. But it's related to writeback throttling _and_
racing with eg iostats grabbing a reference to the request, so it would
be more likely to trigger with a heavier combination of those two.

That said, I'm pretty confident in the fix, so if you'd just use it for
a day or two, then with the previous amount of hangs you saw on -rc2 it
should provide a good level of confidence in it.

-- 
Jens Axboe

