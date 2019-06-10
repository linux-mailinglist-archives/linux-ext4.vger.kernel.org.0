Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1433AD9F
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Jun 2019 05:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387475AbfFJDZu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 9 Jun 2019 23:25:50 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:35822 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387459AbfFJDZu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 9 Jun 2019 23:25:50 -0400
Received: by mail-pg1-f171.google.com with SMTP id s27so4248235pgl.2
        for <linux-ext4@vger.kernel.org>; Sun, 09 Jun 2019 20:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QTp70SR6gw5luO4qwO9Q4BOFgC1sG9o0voZpmUPLgDE=;
        b=VxziN7GBfWQ65qoQEeX+W6vCG1o8jQH5FBnvDXNrgeN98z0nih8WK79KByFLqiVFVI
         13NKw1YQIdTtHC1cr+nr6b/Oz1ldbwYXodMF/cuAXlfQyccHr0J0BX7XCLAVUIuqksks
         VqpAUzrOh+nVq7DwUgOuS3B7qtdLJhu9xNHsPGlmWkeIsvfqQhCpaEo9vRme9Rc0XyRd
         EXDRetybj4HP2Svp3VmL+6pKuwY7ZwD1nWrB0hTNTJWSjEnvVdhKZ/Vw2egcGOo2neP5
         AthKYvEzAbjVDMNrWJ0idfg3DtjxsEK8o4qfo+j5SDlOsUEODb750xxLtRXG7Gu72LP6
         v76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QTp70SR6gw5luO4qwO9Q4BOFgC1sG9o0voZpmUPLgDE=;
        b=SiHknSm85yNRrIMBxiGCezm5GhvU1ClLdAiW/AoUWSrBjdkDZ0GAqcOGZy1oZ5J1H6
         YywalZFUqEHbTottNSKa/zWlk9KuO8wdq6r1kQ9w7V8GrWGQdY7MPLJhCvHov1ESl4eG
         9HHSwiZNp0RUoOIH/3An5dmYBmlGBGhVzDSqpvPve7aluYnwm+yqhcB97o9Gphhk70IN
         HM4inxJXJm/FH/y1PVZuVbYO0MTenSSu5JyfQErZMh+dofzummxIMmPIvi17p9halno4
         SoTSiL8iOVX3YMbPUj7UUZtl2dNWXQfV/dDUlWJvb68QgViIrMQoyWuPRcSajM44gGd8
         xolA==
X-Gm-Message-State: APjAAAVMuo63HFiyLzf+kWtfiRURCkWjZVEZC62eqjMh2VpLlO5i6o7e
        hbKFtVaj7iKJegxy7yzlrPHLmgRS
X-Google-Smtp-Source: APXvYqwAKhK4rLPFEJsN9TFqFgU2qYLS7A+EP1li6RuT0VREZgtS6sjHTA4j8HtJWW8zT5JOywEOIg==
X-Received: by 2002:a63:610d:: with SMTP id v13mr13636845pgb.341.1560137149744;
        Sun, 09 Jun 2019 20:25:49 -0700 (PDT)
Received: from [0.0.0.0] ([47.244.216.228])
        by smtp.gmail.com with ESMTPSA id k8sm8318937pfk.177.2019.06.09.20.25.48
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 20:25:49 -0700 (PDT)
Subject: Re: [HELP] What are the allocated blocks on a newly created ext4 fs ?
To:     Artem Blagodarenko <artem.blagodarenko@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca
References: <b64110a4-8112-a230-2179-5095aa943af9@gmail.com>
 <7FD3148B-1E27-4BFA-965C-9FDC7FC8FD96@gmail.com>
From:   Jianchao Wang <jianchao.wan9@gmail.com>
Message-ID: <22ccd72a-8926-0d12-0fbe-8ad5604d1584@gmail.com>
Date:   Mon, 10 Jun 2019 11:25:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <7FD3148B-1E27-4BFA-965C-9FDC7FC8FD96@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Artem 

Thanks so much for your help.

On 2019/6/6 20:32, Artem Blagodarenko wrote:
> Hello Jianchao,
> 
> Not enought input data to give an answer. It depends on mkfs options. For example, if flex_bg option is enabled, then several block groups are tied together as one logical block group; the bitmap spaces and the inode table space in the first block group, so some groups are not totally free just after FS creating.

In my environment, there are 16 bgs per flex_bg.
The bitmaps and inode table .etc should lay on the first bg of every flex_bg.
So I can see there are about 8223 blocks allocated in the 1st bg of every flex_bg.

But as you can see in the output of mb_groups, there are some bgs which get allocated about 1024 blocks.

I have out figured out what are they for.

Thanks
Jianchao

> 
>> On 6 Jun 2019, at 13:41, Jianchao Wang <jianchao.wan9@gmail.com> wrote:
>>
>> Dear all
>>
>> After I newly created a ext4 fs and check the mb_group,
>>
>>       #group: free  frags first [ 2^0   2^1   2^2   2^3   2^4   2^5   2^6   2^7   2^8   2^9   2^10  2^11  2^12  2^13  ]
>>       #0    : 23513 1     9255  [ 1     0     0     1     1     0     1     1     1     1     0     1     1     2     ]
>>       #1    : 31743 1     1025  [ 1     1     1     1     1     1     1     1     1     1     0     1     1     3     ]
>>                           ^^^^
>>       #2    : 32768 1     0     [ 0     0     0     0     0     0     0     0     0     0     0     0     0     4     ]
>>       #3    : 31743 1     1025  [ 1     1     1     1     1     1     1     1     1     1     0     1     1     3     ]
>>       #4    : 32768 1     0     [ 0     0     0     0     0     0     0     0     0     0     0     0     0     4     ]
>>       #5    : 31743 1     1025  [ 1     1     1     1     1     1     1     1     1     1     0     1     1     3     ]
>>       #6    : 32768 1     0     [ 0     0     0     0     0     0     0     0     0     0     0     0     0     4     ]
>>       #7    : 31743 1     1025  [ 1     1     1     1     1     1     1     1     1     1     0     1     1     3     ]
>>       #8    : 32768 1     0     [ 0     0     0     0     0     0     0     0     0     0     0     0     0     4     ]
>>       #9    : 31743 1     1025  [ 1     1     1     1     1     1     1     1     1     1     0     1     1     3     ]
>>       #10   : 32768 1     0     [ 0     0     0     0     0     0     0     0     0     0     0     0     0     4     ]
>>       #11   : 32768 1     0     [ 0     0     0     0     0     0     0     0     0     0     0     0     0     4     ]
>>
>> There are some bgs that have 1024 blocks allocated. What are they for ?
>>
> BTW, I don’t see from mb_group output why 1024 blocks allocated in group #1
>> Many thanks in advance
>> Jianchao
> 
> Best regards,
> Artem Blagodarenko.
> 

