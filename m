Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61472B537A
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 18:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfIQQ6i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 12:58:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37705 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbfIQQ6i (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 12:58:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id l21so2573865lje.4;
        Tue, 17 Sep 2019 09:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZxseUfGUT7lR28mMaJFGK08sT8RFFqc4TvNx55nS9bM=;
        b=GfZ889I+nNwhtnYnwPXV8s9GTQpvEdi97b3YaW0OxyG3w2aJyIe5Te0352+PgFzoe+
         XbJhcIClElzvA4jrJWfZTrFjdgvsR7HrgGT2PJjNbwm3Tm+HBLHK5wx+dbMLejO3+Gkg
         du0jTCRxSkZZ1UDGYcqH7ptQ8O3etqyW1yrPv5GyYrk1/+lUkrW0W+Ij1f0h6b9rhnkE
         56jPfGD2IM9M/I7uE764NBEfqYqfKDauSuCOQvzlLKSYk8pJwSkXqNnjfJotcE3HCBhD
         mk+Lf6Y+T1UNIhNhr1m943tPsVeie/RESKPDdOuZQBzxKSxqsVU7QzomudiP9RNVYjHR
         0wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZxseUfGUT7lR28mMaJFGK08sT8RFFqc4TvNx55nS9bM=;
        b=uXPNaQPVA/QWbZI63RjL0sXUqVJOZeB8GMuG5SOXJEne8Mz5yjzHzb90IRcxGEn27M
         WsKQwyyqZtjQeG1EIVn+i/kZo1Jyv0Xqfiwgco2ep0laWgwSw2SJlJMz5QJyPJVzLJ//
         g8xuvlYMJt9LIdtr/daHqaLwiKSvMCCU3SHZeskIEqP2SjzUub15+ldSHRxxzMTUOuPY
         D8faBWmzxpFeUc/d+obbaEcdG1/eVFnlLKobzTXYoshOPgtAG+ey81QsS+iJo1ePchLd
         wLMQqCLRiiQ8Gd5whya+YXKKuWRCoeZ40cBwwY2YwxVYNCOcbwOSFl/DWPYpB11lx//d
         tIcw==
X-Gm-Message-State: APjAAAUQX590uZ1Z3U/RA4TUtg81YFgdBJs2yA6vVl0CzinpBLpG+2tL
        filOK5ZfBlG8gZ0x4zVep/8tvaiWYLfbIw==
X-Google-Smtp-Source: APXvYqwxcvqXEFTyaqGGLUtlbthV4jlWLdFAR4bze9ACQhpMi9Bjs/MzAs3t4+FT1t4WAKnKyBFf3w==
X-Received: by 2002:a2e:5c09:: with SMTP id q9mr2575449ljb.4.1568739513537;
        Tue, 17 Sep 2019 09:58:33 -0700 (PDT)
Received: from ?IPv6:2a02:17d0:4a6:5700::72c? ([2a02:17d0:4a6:5700::72c])
        by smtp.googlemail.com with ESMTPSA id b10sm441921lji.48.2019.09.17.09.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 09:58:32 -0700 (PDT)
Subject: Re: Linux 5.3-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Steigerwald <martin@lichtvoll.de>
Cc:     Willy Tarreau <w@1wt.eu>, Matthew Garrett <mjg59@srcf.ucam.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vito Caputo <vcaputo@pengaru.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
 <20190917052438.GA26923@1wt.eu> <2508489.jOnZlRuxVn@merkaba>
 <CAHk-=wiGg-G8JFJ=R7qf0B+UtqA_Weouk6v+McmfsLJLRq6AKA@mail.gmail.com>
From:   "Alexander E. Patrakov" <patrakov@gmail.com>
Message-ID: <6ae36cda-5045-6873-9727-1d36bf45b84e@gmail.com>
Date:   Tue, 17 Sep 2019 21:58:31 +0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiGg-G8JFJ=R7qf0B+UtqA_Weouk6v+McmfsLJLRq6AKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-PH
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

17.09.2019 21:27, Linus Torvalds пишет:
> On Tue, Sep 17, 2019 at 12:33 AM Martin Steigerwald <martin@lichtvoll.de> wrote:
>>
>> So yes, that would it make it harder to abuse the API, but not
>> impossible. Which may still be good, I don't know.
> 
> So the real problem is not people abusing the ABI per se. Yes, I was a
> bit worried about that too, but it's not the cause of the immediate
> issue.
> 
> The real problem is that "getrandom(0)" is really _convenient_ for
> people who just want random numbers - and not at all the "secure"
> kind.
> 
> And it's convenient, and during development and testing, it always
> "just works", because it doesn't ever block in any normal situation.
> 
> And then you deploy it, and on some poor users machine it *does*
> block, because the program now encounters the "oops, no entropy"
> situation that it never ever encountered on the development machine,
> because the testing there was mainly done not during booting, but the
> developer also probably had a much more modern machine that had
> rdrand, and that quite possibly also had more services enabled at
> bootup etc so even without rdrand it got tons of entropy.
> 
> That's why
> 
>   (a) killing the process is _completely_ silly.  It misses the whole
> point of the problem in the first place and only makes things much
> worse.
> 
>   (b) we should just change getrandom() and add that GRND_SECURE flag
> instead. Because the current API is fundamentally confusing. If you
> want secure random numbers, you should really deeply _know_ about it,
> and think about it, rather than have it be the "oh, don't even bother
> passing any flags, it's secure by default".
> 
>   (c) the timeout approach isn't wonderful, but it at least helps with
> the "this was never tested under those circumstances" kind of problem.
> 
> Note that the people who actually *thought* about getrandom() and use
> it correctly should already handle error returns (even for the
> blocking version), because getrandom() can already return EINTR. So
> the argument that we should cater primarily to the secure key people
> is not all that strong. We should be able to return EINTR, and the
> people who *thought* about blocking and about entropy should be fine.
> 
> And gdm and other silly random users that never wanted entropy in the
> first place, just "random" random numbers, wouldn't be in the
> situation they are now.
> 
> That said - looking at some of the problematic traces that Ahmed
> posted for his bootup problem, I actually think we can use *another*
> heuristic to solve the problem. Namely just looking at how much
> randomness the caller wants.
> 
> The processes that ask for randomness for an actual secure key have a
> very fundamental constraint: they need enough randomness for the key
> to be secure in the first place.
> 
> But look at what gnome-shell and gnome-session-b does:
> 
>      https://lore.kernel.org/linux-ext4/20190912034421.GA2085@darwi-home-pc/
> 
> and most of them already set GRND_NONBLOCK, but look at the
> problematic one that actually causes the boot problem:
> 
>      gnome-session-b-327   4.400620: getrandom(16 bytes, flags = 0)
> 
> and here the big clue is: "Hey, it only asks for 128 bits of randomness".
> 
> Does anybody believe that 128 bits of randomness is a good basis for a
> long-term secure key? Even if the key itself contains than that, if
> you are generating a long-term secure key in this day and age, you had
> better be asking for more than 128 bits of actual unpredictable base
> data. So just based on the size of the request we can determine that
> this is not hugely important.
> 
> Compare that to the case later on for something that seems to ask for
> actual interesting randomness. and - just judging by the name -
> probably even has a reason for it:
> 
>        gsd-smartcard-388   51.433924: getrandom(110 bytes, flags = 0)
>        gsd-smartcard-388   51.433936: getrandom(256 bytes, flags = 0)
> 
> big difference.
> 
> End result: I would propose the attached patch.
> 
> Ahmed, can you just verify that it works for you (obviously with the
> ext4 plugging reinstated)? It looks like it should "obviously" fix
> things, but still...

I have looked at the patch, but have not tested it.

I am worried that the getrandom delays will be serialized, because 
processes sometimes run one after another. If there are enough 
chained/dependent processes that ask for randomness before it is ready, 
the end result is still a too-big delay, essentially a failed boot.

In other words: your approach of adding delays only makes sense for 
heavily parallelized boot, which may not be the case, especially for 
embedded systems that don't like systemd.

-- 
Alexander E. Patrakov
