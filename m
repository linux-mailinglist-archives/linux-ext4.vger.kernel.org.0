Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E713946F8EB
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Dec 2021 03:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhLJCHO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Dec 2021 21:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbhLJCHO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Dec 2021 21:07:14 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5250FC061746;
        Thu,  9 Dec 2021 18:03:40 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id k4so5274761plx.8;
        Thu, 09 Dec 2021 18:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jVLTcGZ/b50WBIIZiq+RM8D9NcbJZ+0giWVxc/gopOQ=;
        b=FnffvwfX2jEByd6zOARdmwiS3gC2Ik8bp6dxntd66hZaYIRLCSNFkqcJ+aHOh18xii
         0w9ecwz3xCiFTuPefZv/JQ9KmSOzrojlZq+8u8R3tISFtswtMmz/jA2xmC5vepK1Spo4
         C7rNPZnX29SnpkXKSXTi6l8XeRBARUoXgpTtiXchkUttxfq/Ovaqtldp6y8Dky7amkJ8
         dDFB2ZQuiXe+WCrk36KrjjXNUWFbD441Z9C+n8rYCD7xx9jB3Ts3IRgnASjp2qlnw3K6
         G/Gw/ngSGhDKJD0lygwn1a3jb0D0FPZ9yNo1t+yLbk34baMosA8WiRNI2Od4NmV7bwPZ
         Fpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jVLTcGZ/b50WBIIZiq+RM8D9NcbJZ+0giWVxc/gopOQ=;
        b=GZJhwoRoplntiMwAHAmpZPqzeZQXRR+wO8E9VFfpAAIQl5eDZqnRAsce24EBCKjdj/
         tolIPmPw1rpNzycYWm3ZM+w1x53r73TtWCu6jrLr88cQ8+zmP+oD660IyA4worNSJgR0
         pPgkqvgMGfev1+03ZeilS0dLtOk7yBcrlgqPQ+Hx63bbC/0Qmut31N7zTWO3WaxN4mpB
         zvZYO5RokJnedsMsk/JWjbOnu68gcuIykpG7LoBRlz6LZU5g/DwVWutubAPfcgqgWmbE
         fHqDBOYyzX+Atp2gNtS6TiEN/SkwTeLEz7fZwJfVflLT+a+cKr4ahLH85lrBklqxikRx
         Zi8w==
X-Gm-Message-State: AOAM532Qxvd18TfKDQSM2jb5ffRldFQbuTB/5p/07mdrhKYSNOFpnz3O
        ZLkXfIqPrgiH4PROVzkrnTIlIOmcXpE=
X-Google-Smtp-Source: ABdhPJx7dWC9mSZKMKwQvCVSKOBCbf7sR7YEKYTC/CEb8tLX3PwmrfubOylQvi1n1ehH+B7T8OrAFQ==
X-Received: by 2002:a17:90a:be0f:: with SMTP id a15mr19980782pjs.243.1639101819775;
        Thu, 09 Dec 2021 18:03:39 -0800 (PST)
Received: from [183.173.151.43] ([183.173.151.43])
        by smtp.gmail.com with ESMTPSA id 16sm759404pgu.93.2021.12.09.18.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 18:03:39 -0800 (PST)
Subject: Re: [BUG] fs: ext4: possible ABBA deadlock in
 ext4_inline_data_truncate() and ext4_punch_hole()
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <03a92134-ce74-f586-59a0-baed436b275a@gmail.com>
 <YbI2IEzCVo+A6GTi@mit.edu>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <c9f25d5a-0963-5b2d-b1f0-e7c7454f7153@gmail.com>
Date:   Fri, 10 Dec 2021 10:03:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <YbI2IEzCVo+A6GTi@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2021/12/10 1:00, Theodore Y. Ts'o wrote:
> On Thu, Dec 09, 2021 at 07:10:44PM +0800, Jia-Ju Bai wrote:
>> Hello,
>>
>> My static analysis tool reports a possible ABBA deadlock in the ext4 module
>> in Linux 5.10:
>>
>> ext4_inline_data_truncate()
>>    down_write(&EXT4_I(inode)->i_data_sem); --> Line 1895 (Lock A)
>>    ext4_xattr_ibody_get()
>>      ext4_xattr_inode_get()
>>        ext4_xattr_inode_iget()
>>          inode_lock(inode); --> Line 427 (Lock B)
>>
>> ext4_punch_hole()
>>    inode_lock(inode); --> Line 4018 (Lock B)
>>    ext4_update_disksize_before_punch()
>>      ext4_update_i_disksize()
>>        down_write(&EXT4_I(inode)->i_data_sem); --> Line 3248 (Lock A)
>>
>> When ext4_inline_data_truncate() and ext4_punch_hole() are concurrently
>> executed, the deadlock can occur.
>>
>> I am not quite sure whether this possible deadlock is real and how to fix it
>> if it is real.
> Hi,
>
> Thanks for the report.  I don't believe this is deadlock is possible,
> because the first thing ext4_punch_hole() does is to check to see if
> the inode has inline data --- and if so, it calls
> ext4_convert_inline_data() to convert it to a normal file.  In
> ext4_convert_inline_data(), we take the xattr lock, and then do the
> conversion, and then drop the xattr lock.  So by the time
> ext4_punch_hole() starts doing its work, the inode is not an inline
> data file.
>
> In ext4_inline_data_truncate(), we take the xattr lock, and once we
> have the xattr lock, we check to see if inode is still an inline data
> file.  If it has been converted, we then bail out.
>
> Hence, the ABBA deadlock that your static analysis tool has pointed
> shouldn't happen in practice.

Hi Ted,

Thank you very much for the detailed explanation!
I will improve my static analysis tool for this point.


Best wishes,
Jia-Ju Bai

