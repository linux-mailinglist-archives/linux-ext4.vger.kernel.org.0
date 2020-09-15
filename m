Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0217926ADC0
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Sep 2020 21:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgIOTjU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Sep 2020 15:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgIOTin (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Sep 2020 15:38:43 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0568C061351
        for <linux-ext4@vger.kernel.org>; Tue, 15 Sep 2020 12:38:41 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p9so6726469ejf.6
        for <linux-ext4@vger.kernel.org>; Tue, 15 Sep 2020 12:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s8T/xfdPgHNj8zUD8Dev4ytzaOaIL61Me0jC59/f6ng=;
        b=egkRtBub72A0udarXLyx7kPiMFbZwxsdamaVoFNk6fnra45xH6+b1qu08DA4H5P14q
         xetyyxN5sf5gqn/2H/HatglN6yEKyZ42U6+lhqC/pnGz5T70MrjHENkX2vz7X41W3+JW
         alpjHNCximjdVxjju4pceLFUdI5o+mVhSE8ZH78vFtpdOQH4MPkuH6h1xDLvqb4zKOrv
         bXDk2fgNXtneCIfn7EbycNR+/brHucmInUL/jFy/EpsPw6Q/niRK2ggnlDZZiT84cgrt
         Oyg38QnQ7HMZ1Klg3HsGoWjySJ0wjMjVd7+Su+bnbpgFbS85diBrzIWBW3LcqMeyUDsb
         aceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s8T/xfdPgHNj8zUD8Dev4ytzaOaIL61Me0jC59/f6ng=;
        b=UiliPvaEjAKvI50dq9Cjm1arhVePZKz0ENVoEZUB12tvNFE0/5XTmIKb2v31tamJCg
         ja+FLKNxnPoBtxzeHRJHejAOMuvXeop05120OyVUN2ZabvvtXA9OJQi+lDuyuZsQ0V8k
         ADflZwgwmW1QTVIo4Q5i7npvyxm4a/HvUsAhINaeanRCMJFW/vF5csHFFBEVrokiEwDc
         xUM1I3LNUlekJ3fQeXsf6k7osY0uhH5o2W35c0dyr18+VdqHvao88j7Q1DsFzSoDxp3K
         7klB6xk32VmZfvI17kDWAifLlW/Y8y9Ue9E4LaJXju4AoFDNySGvl4uUH9KJ2cU4iKRG
         u91g==
X-Gm-Message-State: AOAM531lvlmhN0CVIA+iGO6vn4Fif9itgICqMzxWGq8U0smkVdcaA8aR
        09Wu9zFhvFwsW2w+JO9bldVX1w==
X-Google-Smtp-Source: ABdhPJwf98cQYg59nWOxTJOT2LYyBb716h5ZTzsJtSJJboypj0hXqlJsypquvfCfPTpmlCY7mUhmDQ==
X-Received: by 2002:a17:906:2752:: with SMTP id a18mr8819405ejd.350.1600198720550;
        Tue, 15 Sep 2020 12:38:40 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:ec32:668e:7a20:c1cd])
        by smtp.gmail.com with ESMTPSA id z18sm11038113ejw.94.2020.09.15.12.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 12:38:39 -0700 (PDT)
Subject: Re: Kernel Benchmarking
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Larabel <Michael@michaellarabel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
 <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
 <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com>
 <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com>
 <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <c560a38d-8313-51fb-b1ec-e904bd8836bc@tessares.net>
 <CAHk-=wgZEUoiGoKh92stUh3sBA-7D24i6XqQN2UMm3u4=XkQkg@mail.gmail.com>
 <9550725a-2d3f-fa35-1410-cae912e128b9@tessares.net>
 <CAHk-=wimdSWe+GVBKwB0_=ZKX2ZN5JEqK5yA99toab4MAoYAsg@mail.gmail.com>
 <9a92bf16-02c5-ba38-33c7-f350588ac874@tessares.net>
 <CAHk-=wihcYiKwZQjwGd8eHLqMm=sL23a=fyzJ_u1YiFNsKN2AQ@mail.gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <b6f8df30-4fbe-a440-b205-dc90583097a7@tessares.net>
Date:   Tue, 15 Sep 2020 21:38:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wihcYiKwZQjwGd8eHLqMm=sL23a=fyzJ_u1YiFNsKN2AQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 15/09/2020 21:24, Linus Torvalds wrote:
> On Tue, Sep 15, 2020 at 12:01 PM Matthieu Baerts
> <matthieu.baerts@tessares.net> wrote:
 >
>> I forgot one important thing, I was on top of David Miller's net-next
>> branch by reflex. I can redo the traces on top of linux-next if needed.
> 
> Not likely an issue.
> 
> I'll go stare at the page lock code again to see if I've missed
> anything. I still suspect it's a latent ABBA deadlock that is just
> much *much* easier to trigger with the synchronous lock handoff, but I
> don't see where it is.
> 
> I guess this is all fairly theoretical since we apparently need to do
> that hybrid "limited fairness" patch anyway, and it fixes your issue,
> but I hate not understanding the problem.

I understand :)
Thank you again for looking at this issue!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
