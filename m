Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D872442AF
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Aug 2020 03:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgHNBQ7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Aug 2020 21:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgHNBQ7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Aug 2020 21:16:59 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FDEC061757
        for <linux-ext4@vger.kernel.org>; Thu, 13 Aug 2020 18:16:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c10so4955286pjn.1
        for <linux-ext4@vger.kernel.org>; Thu, 13 Aug 2020 18:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=lyx+yxmst/EK+rstxShOkDRXFXNxfSAC8RAJZZD/tqE=;
        b=h66iCMhK7uvXfQ1yS2htNXhMaSotBNfIilNTU7MN8c1Fm6KR9PDJeXyGXM5M1kD5UO
         rr/4uKGyCXX58rH6T3w0/u5mYKon/XZeK7b2gp6IdvcsAHiPOYaKw8lmbx9Xs7sUgSa/
         UI44bHNQwrQGaVdB+hzFwhGrfwBE2Y8evJbQ23oDU8QhkwhyYhTxhbz54Pay1bt4FHID
         h8izJOFWBpGba7hyFfk1L0+OXKcM/3NBwTgbTGh3fMt8QkqGCR0B0FcQ5roypV5ADduf
         qfycb0cXnw9HrCWLfMuXJR3YivxvGvsgwf7mY9bpz0mP0wTpMAx1J+SP089Jxq2Uku9S
         xTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lyx+yxmst/EK+rstxShOkDRXFXNxfSAC8RAJZZD/tqE=;
        b=HV1YCz9k5+spvg+oxl6E2U8P0b0ItyJfE2MGLh2JEbA3aWNKMY1rWgVDoX9ABEV/Io
         EOfVuyteGM4GmxneNKNJ9HHBpkgrTDgAdU9FczGpPkdKsMCpd7IjaB7QM9P7y/yXj52B
         zmacLEmMEaMvY6kD86IpLBurz4Bkv7+8eqnvlo1BPV5CWRiumXFd/towJ/0D4DmnbI22
         y9+NsVhJY1faTDbRNlLJ1xZBbXCX+5RYL9hA5UkTMxjo5GRYtSuxhwGNqZtaB5rpsojJ
         ttokEsK5wWdcE2L32FpWyzZFkcUDSwPR3YeWnNnTVbINYCnhjSw4aqqduuxYL/zZh1Kn
         iFsg==
X-Gm-Message-State: AOAM5319moS0ig15mXNqX1k3/gn+wZLVbhUPQxgrexkybVJ8x2dxgRxV
        Xy1MzW1fodLt+qjdugHmFjvQD41I
X-Google-Smtp-Source: ABdhPJxupFT9i9ZW1+Gs2acx66SnAHzERnsTeaIvpddL7V9+LyLWHiRdzUwTHtAq66bbsDSuoJL2GA==
X-Received: by 2002:a17:902:6b05:: with SMTP id o5mr352622plk.173.1597367817807;
        Thu, 13 Aug 2020 18:16:57 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.44])
        by smtp.gmail.com with ESMTPSA id c10sm7062862pfc.62.2020.08.13.18.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 18:16:57 -0700 (PDT)
Subject: Re: [PATCH] ext4: fix log printing of ext4_mb_regular_allocator()
To:     Ritesh Harjani <riteshh@linux.ibm.com>, adilger.kernel@dilger.ca,
        tytso@mit.edu, linux-ext4@vger.kernel.org
References: <131a608b-0c8a-1a2d-57ee-4263cfcdd5a2@gmail.com>
 <20200813140453.8B3F4A404D@d06av23.portsmouth.uk.ibm.com>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <1f96509b-ac2c-bbc4-687f-9793ba7a5e6b@gmail.com>
Date:   Fri, 14 Aug 2020 09:16:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813140453.8B3F4A404D@d06av23.portsmouth.uk.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This maybe a problem, I try to update it in the next version, thank you.

Ritesh Harjani wrote on 2020/8/13 22:04:
> 
> 
> On 8/7/20 7:31 PM, brookxu wrote:
>> Fix log printing of ext4_mb_regular_allocator()，it may be an
>> unintentional behavior.
>>
>> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
>> ---
>>   fs/ext4/mballoc.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 5d4a1be..b0da525 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -2324,15 +2324,14 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
>>            * We've been searching too long. Let's try to allocate
>>            * the best chunk we've found so far
>>            */
>> -
>>           ext4_mb_try_best_found(ac, &e4b);
>>           if (ac->ac_status != AC_STATUS_FOUND) {
>>               /*
>>                * Someone more lucky has already allocated it.
>>                * The only thing we can do is just take first
>>                * found block(s)
>> -            printk(KERN_DEBUG "EXT4-fs: someone won our chunk\n");
>>                */
>> +            mb_debug(sb, "EXT4-fs: someone won our chunk\n");
> 
> mb_debug() already adds "EXT4-fs" string. So we need not add that here.
> but maybe we can add "sbi->s_mb_lost_chunks" in this msg, which may be
> helpful debug msg if too many lost chunks.
> 
> 
>>               ac->ac_b_ex.fe_group = 0;
>>               ac->ac_b_ex.fe_start = 0;
>>               ac->ac_b_ex.fe_len = 0;
>>
