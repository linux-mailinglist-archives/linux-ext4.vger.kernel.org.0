Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7F7B546E
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 19:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfIQRlk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 13:41:40 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:35370 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfIQRlk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 13:41:40 -0400
Received: by mail-lf1-f53.google.com with SMTP id w6so3591457lfl.2;
        Tue, 17 Sep 2019 10:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fx+sdLrbbMO3EWgs8sTQWDVcw7BxviYLKx2x+SxaOiQ=;
        b=UE7uJ0z3dchGQ5s2pw5h8c5mOBn3HzdG/7+5VHOfgUWXBZKF8c/3EMk5ve0IR5foXS
         LtYt39+luyTdw1z+xN8Ew/oqH9NS1n8JzUByPe9t4CPPfLC93kHIIilrKh0ZDcNTIOjH
         PzcGZ9ZXHoIGTdxZPvr8Xqe7zIjQ99pfDXfAZvUBoGfAkC7nXha2hvZ0M3E2OUU3+hQi
         QMuEWWuhhP/5qYkE3iZfGX0zYPV3td6Pv45OMVhKC6USE7FfEftA+TRntaJVYXM7DsR1
         TIfJb1pUMuAzayWJUfHZXGxS3FpbGZArIM13W0WpG82HulfZBCMC9jiINBD69WrKHdq6
         tfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fx+sdLrbbMO3EWgs8sTQWDVcw7BxviYLKx2x+SxaOiQ=;
        b=oYdZ78YVZkd2n3va//+magcfeN684aT6z9eZgkH/WIuGbxEaOH2HGn4NZBFCHTpKwo
         +i5dpbRYr/JEQIrtIEyXMrf/yuhpYZzkbp81L1bQ9JAnXaXlKEnZqq/BMq20ct43NgLV
         281UGKDvrNwKSEcZmfmqIfK7pDupzIeKPoIIk878pCA1ARNE85fbKfDEeWJTaumWfXFA
         evYtV4sIm6HRCPWeFqCB5GzhAcGg9rCJvRkP+hwoECY4rr6+3MmlpdV7PSFx0NOdTjcv
         /CFP3P0H61PPTS8HHUbyVxlDIxQ1fJPrWlSov8SMjCTvcxluMMHCqX+A0ymnDq3ss8GS
         bung==
X-Gm-Message-State: APjAAAUT6dJttGOh2XEMKlHtTuU5GisUYsKpHV2kx6DHr+2o/dqyE6mo
        +uzQMNWJuoKzKJXVjJ0fqzkR/NmRfUSZTQ==
X-Google-Smtp-Source: APXvYqySL4ftj8UHOFNjKvTL8adHecoW4HTmjHrzY0Ar4gDc87QZ8jiSrMjmOh4inm0eUBrMMvx4JA==
X-Received: by 2002:a19:f11c:: with SMTP id p28mr2714006lfh.44.1568742096338;
        Tue, 17 Sep 2019 10:41:36 -0700 (PDT)
Received: from ?IPv6:2a02:17d0:4a6:5700::72c? ([2a02:17d0:4a6:5700::72c])
        by smtp.googlemail.com with ESMTPSA id w13sm549636lfk.47.2019.09.17.10.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 10:41:35 -0700 (PDT)
Subject: Re: Linux 5.3-rc8
To:     Willy Tarreau <w@1wt.eu>, Lennart Poettering <mzxreary@0pointer.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
 <20190917052438.GA26923@1wt.eu> <2508489.jOnZlRuxVn@merkaba>
 <CAHk-=wiGg-G8JFJ=R7qf0B+UtqA_Weouk6v+McmfsLJLRq6AKA@mail.gmail.com>
 <6ae36cda-5045-6873-9727-1d36bf45b84e@gmail.com>
 <20190917173036.GC31798@gardel-login> <20190917173225.GE27999@1wt.eu>
From:   "Alexander E. Patrakov" <patrakov@gmail.com>
Message-ID: <69d8cabe-9285-a01e-ae78-57838e886c9a@gmail.com>
Date:   Tue, 17 Sep 2019 22:41:33 +0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190917173225.GE27999@1wt.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-PH
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

17.09.2019 22:32, Willy Tarreau пишет:
> On Tue, Sep 17, 2019 at 07:30:36PM +0200, Lennart Poettering wrote:
>> On Di, 17.09.19 21:58, Alexander E. Patrakov (patrakov@gmail.com) wrote:
>>
>>> I am worried that the getrandom delays will be serialized, because processes
>>> sometimes run one after another. If there are enough chained/dependent
>>> processes that ask for randomness before it is ready, the end result is
>>> still a too-big delay, essentially a failed boot.
>>>
>>> In other words: your approach of adding delays only makes sense for heavily
>>> parallelized boot, which may not be the case, especially for embedded
>>> systems that don't like systemd.
>>
>> As mentioned elsewhere: once the pool is initialized it's
>> initialized. This means any pending getrandom() on the whole system
>> will unblock at the same time, and from the on all getrandom()s will
>> be non-blocking.
> 
> He means that all process will experience this delay until there's enough
> entropy.
> 
> Willy

Indeed, my wording was not clear enough. Linus' patch has a 5-second 
timeout for small entropy requests, after which they get converted to 
the equivalent of urandom. However, in the following shell script:

#!/bin/sh
p1
p2

if both p1 and p2 ask for a small amount of entropy before crng is fully 
initialized, and do nothing that produces more entropy, the total delay 
will be 10 seconds.

-- 
Alexander E. Patrakov
