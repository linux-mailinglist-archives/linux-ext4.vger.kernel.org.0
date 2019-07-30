Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A46379E01
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2019 03:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbfG3Ber (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Jul 2019 21:34:47 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41759 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729221AbfG3Ber (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 Jul 2019 21:34:47 -0400
Received: by mail-ot1-f67.google.com with SMTP id o101so64591446ota.8
        for <linux-ext4@vger.kernel.org>; Mon, 29 Jul 2019 18:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yqbOvv5+RVFDatXbu+9VaKNcbmnxhKKhVA039vocC6g=;
        b=CFUP9PSQyUTa4dYoXGJ6YIq+0NIVATEtlv/sGUy6fqezMQgpdUGGeHW2G60llLO3Mx
         SozoyiGtiAdJAGS8vZdiFWzSq+9WYX2KXbXIVqNzIJoCJnPXgBjlvI0MR3LPNBBythJo
         MjGo/Z8YBqldgAxkAmWzcceb2EiMe6LKOGk5m7qoRaoynaLEeKWUYCA8QFUdsb8ijzGj
         5c1cRV1VwAdfCarRLlZesopzWgbCsH9XvR1apaz6jCZx2ByqFNniOqKSfMewPZMzO2kw
         dJEWxUXrBIWHBLq96/NPT7+tzCyRbb/epHF8YKfgqwopZe1vhrH/YGxvfIGoyD3ME6E3
         5AvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yqbOvv5+RVFDatXbu+9VaKNcbmnxhKKhVA039vocC6g=;
        b=jXeZ5mUF8x82Fyu6tgtNy53hokxUpabQy+6aCxPeYbalwel4X2AzX0sF4chDZ6DACF
         Di2i6FcXGCwRcbo3R+/9N2dFmm66c1uBq6iyWLUXXqz2HQWQ9wE8qpb/nUzEmjr3kf7U
         JQGTrfa9OeKi6V/Ki6lWQ9cciVPn0OuwsoO3RQcij0hnhZK5p+r4sGNAePy252NiXMwO
         k7El5bm47sU7gISd/8l3O+2yywR93du4+f9WXCRxSLvhywL6MDZy9WXKKSTaRWUflc8H
         qE9Bo69cALAnEN/ZPfsFbv7KFtSq/7LDd8cnSRQrXsCk3lGnqeijW1Y/eLaK2vyjE/85
         8mVg==
X-Gm-Message-State: APjAAAUBPatuVrxEzfqmP+DXI6kAx7OqtC50i9DeeHDFQfPmoLCdDgLv
        2QLphBXTRgQYavZVf0CZtKI=
X-Google-Smtp-Source: APXvYqzitU6A+d+m1YtF6eesDDCxcyl/8J8EkDRmYWuTsSYYg6eNCRAjh7bsF8Vyu0tN83KOESldSg==
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr66497894oti.50.1564450486595;
        Mon, 29 Jul 2019 18:34:46 -0700 (PDT)
Received: from JosephdeMacBook-Pro.local ([205.204.117.23])
        by smtp.gmail.com with ESMTPSA id m21sm20222138otl.70.2019.07.29.18.34.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 18:34:45 -0700 (PDT)
Subject: Re: [RFC] performance regression with "ext4: Allow parallel DIO
 reads"
To:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
References: <ab7cf51b-6b52-d151-e22c-6f4400a14589@linux.alibaba.com>
 <29d50d24-f8e7-5ef4-d4d8-3ea6fb1c6ed3@gmail.com>
 <6DADA28C-542F-45F6-ADB0-870A81ABED23@dilger.ca>
 <15112e38-94fe-39d6-a8e2-064ff47187d5@linux.alibaba.com>
 <20190728225122.GG7777@dread.disaster.area>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <960bb915-20cc-26a0-7abc-bfca01aa39c0@gmail.com>
Date:   Tue, 30 Jul 2019 09:34:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190728225122.GG7777@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 19/7/29 06:51, Dave Chinner wrote:
> On Fri, Jul 26, 2019 at 09:12:07AM +0800, Joseph Qi wrote:
>>
>>
>> On 19/7/26 05:20, Andreas Dilger wrote:
>>>
>>>> On Jul 23, 2019, at 5:17 AM, Joseph Qi <jiangqi903@gmail.com> wrote:
>>>>
>>>> Hi Ted & Jan,
>>>> Could you please give your valuable comments?
>>>
>>> It seems like the original patches should be reverted?  There is no data
>>
>> From my test result, yes.
>> I've also tested libaio with iodepth 16, it behaves the same. Here is the test
>> data for libaio 4k randrw:
>>
>> -------------------------------------------------------------------------------------------
>> w/ parallel dio reads | READ 78313KB/s, 19578, 1698.70us  | WRITE 78313KB/s, 19578, 4837.60us
>> -------------------------------------------------------------------------------------------
>> w/o parallel dio reads| READ 387774KB/s, 96943, 1009.73us | WRITE 387656KB/s，96914, 308.87us
>> -------------------------------------------------------------------------------------------
>>
>> Since this commit went into upstream long time ago，to be precise, Linux
>> 4.9, I wonder if someone else has also observed this regression, or
>> anything I missed?
> 
> I suspect that the second part of this set of mods that Jan had
> planned to do (on the write side to use shared locking as well)
> did not happen and so the DIO writes are serialising the workload.
> 

Thanks for the inputs, Dave.
Hi Jan, Could you please confirm this?
If so, should we revert this commit at present?

Thanks,
Joseph

