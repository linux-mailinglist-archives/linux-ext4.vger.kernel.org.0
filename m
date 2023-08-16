Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED2A77E530
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 17:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344081AbjHPPb0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Aug 2023 11:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344087AbjHPPa6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Aug 2023 11:30:58 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFEA2102
        for <linux-ext4@vger.kernel.org>; Wed, 16 Aug 2023 08:30:56 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bdb3ecd20dso8742505ad.0
        for <linux-ext4@vger.kernel.org>; Wed, 16 Aug 2023 08:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692199856; x=1692804656;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8FAroCm/x/V+kCSERRsXoQnOWxNJEuoINbdKbSDokX0=;
        b=N997JOw8RanRWoU/w4WqlW5HHkU6YTHzuSXsY9VPhj0kozw7LvhdbDWwFOIjxIl8sc
         dHu3epc4ZGArHgJUh1niGoKCXHolAEnl0Pi3F0P5XjDbA8hV8kTOyjbs4sNo0WqwlZgY
         ky2T6FGMUIRIPEjSVVIFfkEvogzeTAKoJHYHoKHn/+sf5WWJGy0C+QB/rHPBNIyRv0b8
         2Dpe+grhiE5AnFT1yT8fvJPrFD/MF/W1ac6KA7Yj67h94kn3D/2TyiuARTTogE2NKvH7
         9MrrO/qaWHbVwIqwskakgOwaHPXqP1MyGYktqhvFmOMQDC/nKYwwBKaY8UbogGC2DAGd
         AdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692199856; x=1692804656;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FAroCm/x/V+kCSERRsXoQnOWxNJEuoINbdKbSDokX0=;
        b=cQSUPGST6ocJmm1UEArPcEm6JXzleV/Cuw84GPDEswbyJ2UEDzGEcTOXIEo4CL+oes
         I1eoZq4HjXlMPDYIUQ/tFlo9blHXSzuOYuTElaia/SIDFefurlMEv7dZ5/HsjWxZAZPm
         aakxcS3RF12SdHyJsvSMq7vnzENHYTA5WnVyOKngT5QtSR3KUnkJJvI3ET7+m6ZGP7ei
         MMgQVVMC4T9sSNoh6eysNC+Z9hbKkjpZbTHvNlMiDNpESEAVEtsbnWjN6+EpuXKKrFhz
         57IDEavgDwAOQBfd4JT91uIic+7bgTPvpgumK3s7ISZq0jI1EL2CDhaisNYeqApsiTrd
         48xg==
X-Gm-Message-State: AOJu0YxmuRzhzbE+Cu+TEtgtWIxRMH9uqSvjhFjxWKZwBiisxAV/UWkE
        /zpNjvQnalH7p7UKqgOA4oFaLw==
X-Google-Smtp-Source: AGHT+IH5RUhyB9ZLzvA+kszEEebVshT+QZzQ+UeEWfqPTJD+ti5AAkxFboEWjXeu0PY40WQp5XJMVg==
X-Received: by 2002:a17:902:d48e:b0:1b1:9272:55e2 with SMTP id c14-20020a170902d48e00b001b1927255e2mr2594377plg.3.1692199855792;
        Wed, 16 Aug 2023 08:30:55 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902d50100b001bc445e249asm13278741plg.124.2023.08.16.08.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 08:30:55 -0700 (PDT)
Message-ID: <f9074f2c-9d31-4ead-a99f-4c4b6ae5a24d@kernel.dk>
Date:   Wed, 16 Aug 2023 09:30:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.5.0rc5 fs hang - ext4? raid?
Content-Language: en-US
To:     "Dr. David Alan Gilbert" <dave@treblig.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, hch@lst.de,
        adilger.kernel@dilger.ca, song@kernel.org,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <ZNqWfQPTScJDkmpX@gallifrey> <20230815125146.GA1508930@mit.edu>
 <ZNt11WbPn7LCXPvB@gallifrey> <ZNu668KGiNcwCSVe@gallifrey>
 <ZNwm7Mo9yv7uIkno@gallifrey> <324fc71c-dead-4418-af81-6817e1f41c39@kernel.dk>
 <ZNzg1/zhxYV2EkBX@gallifrey> <ZNzl2Sq9UJ3FiTgV@gallifrey>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZNzl2Sq9UJ3FiTgV@gallifrey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 8/16/23 9:06 AM, Dr. David Alan Gilbert wrote:
>>> Can you try and pull in:
>>>
>>> https://git.kernel.dk/cgit/linux/commit/?h=block-6.5&id=5ff3213a5387e076af2b87f796f94b36965e8c3a
>>>
>>> and see if that helps?
>>
>> <testing....>
> 
> Yes it seems to fix it - thanks!

OK good, it'll be going upstream before the next -rc.

-- 
Jens Axboe

