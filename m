Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A654E25DC3B
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Sep 2020 16:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbgIDOvb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Sep 2020 10:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730388AbgIDOv2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Sep 2020 10:51:28 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A61C061244
        for <linux-ext4@vger.kernel.org>; Fri,  4 Sep 2020 07:51:27 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p37so4455945pgl.3
        for <linux-ext4@vger.kernel.org>; Fri, 04 Sep 2020 07:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YCwuwpY2wU3kaylQ/MILMMrzNaUrce3uBcy3VjkPLcA=;
        b=rkg1fR0CBytwyrhRc4EikmMXthCT3N5jfBxjoYC1f2Aijxq260yyTxXzm4b5D4xdJM
         ZKVT4z4WQErwkMaE8ZMEF5kV387p5w953ELxaWyRrcMcFaNIMd/pIHu2vTc6ka8IbldA
         hN1HxRbl5w7Z+gn4dkdZqlZAWTXUcG4djEmjya3a1sZ9Cq7ik4SB9lfsBjPa4Du9VzzR
         GSHooiSDCvBgzteocraC5W3zyoGKt6Eb9G1iJGLMUy/Rjv/q321puyjCYvdy4Biaet7b
         58DB32pESS8ttLBfPtoF7SL2V2YnOQqyNBaMln7yqA4Y7deRnKGQywEeZRxmxcBN5/0T
         YIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YCwuwpY2wU3kaylQ/MILMMrzNaUrce3uBcy3VjkPLcA=;
        b=btQexoCayE/YSKmT4+0Q7UFc4WyF0oVxt2omKMpVPSYSulVIGaf36fHbSQpo4XV4HH
         qMJD1G64cYa0U7kOnLYgjfh/3pEsZlh4v8hgqmO1KInrDCcQiUv6XE7SMQpbrx3X2yKQ
         0PmZ7f5bcxyybakuy1oEjg4r/hRmvPnKIz0x2frjUUDwPwKJ1+tDdjQzAsNvpCjaMZjN
         O6kCQaksdZGtTWXOgAtSmsiEmwkPALLzHWfqGMDXO0Ys+MWwmkv8JxRI9UZ8e15KQVAE
         rFalchAbO753ES7feybVfvfQPplDyRv4EUS1/CkeNIuvIjU94fXw7JWs8GgJA3qrl1bF
         JoiQ==
X-Gm-Message-State: AOAM530dpuAXdzjZ6hCsjKsKSwA0xnDWNLJhRApG0QllViynrh0zhLnX
        8FjhrtDfWvXUx4LV/eAT8px0sQ==
X-Google-Smtp-Source: ABdhPJxbjl6x1jMUJXR8dYxxNsseOtmG1Vat/jx5qrNmxoLcT6SMRBzHwskY4FsPWRMLYnN5B3Nviw==
X-Received: by 2002:a63:e249:: with SMTP id y9mr7554359pgj.117.1599231087194;
        Fri, 04 Sep 2020 07:51:27 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21cf::1188? ([2620:10d:c090:400::5:1a09])
        by smtp.gmail.com with ESMTPSA id 82sm6041681pgd.6.2020.09.04.07.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 07:51:26 -0700 (PDT)
Subject: Re: [PATCH] ext4: flag as supporting buffered async reads
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <fb90cc2d-b12c-738f-21a4-dd7a8ae0556a@kernel.dk>
 <20200818181117.GA34125@mit.edu>
 <990cc101-d4a1-f346-fe78-0fb5b963b406@kernel.dk>
 <20c844c8-b649-3250-ff5b-b7420f72ff38@kernel.dk>
 <20200822143326.GC199705@mit.edu>
 <aff250ad-4c31-15c2-fa1d-3f3945cb7aa5@kernel.dk>
 <7f0e2d99-5da2-237e-a894-0afddc0ace1e@kernel.dk>
 <049a97db-c362-bcfb-59e5-4b1d2df59383@kernel.dk>
 <5140ba6c-779c-2a71-b7f2-3c3220cdf19c@kernel.dk>
 <68510957-c887-8e26-4a1a-a7a93488586a@kernel.dk>
 <20200904035528.GE558530@mit.edu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <73f14124-e660-de0d-95ad-7fb21f18cdef@kernel.dk>
Date:   Fri, 4 Sep 2020 08:51:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904035528.GE558530@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 9/3/20 9:55 PM, Theodore Y. Ts'o wrote:
> Hi Jens,
> 
> Sorry, the past few months have been *crazy* insane.  Between Linux
> Plumbers Conference organizing, having to deal with some interns at
> $WORK, performance reviews, etc.., etc., it's been a perfect storm.
> As a result, I was late getting the primary ext4 pull request to
> Linus, and he's already yelled at me for a late pull request.
> 
> As a result, I'm being super paranoid about asking Linus for anything,
> even a one-time change, if it's not a bug fix.  And what you are
> asking for isn't a bug fix, but enabling a new feature.

That's fine, we blew past the 5.9 window long ago imho. As mentioned,
back in May we could have solved this by just adding your acked-by
or reviewed-by to the patch like we did for xfs/btrfs. That removes the
ext4 tree dependency. Obviously that's no longer a concern for 5.10, but
I need to know if we're going one of two routes:

a) I'm queueing this up, in which case I'll still need that ack/review
b) you're queueing it up, in which case you can just grab it

I just don't want to end up in the same situation for 5.10, and then
we're pushing this out 2 releases at that point...

> Worse, right now, -rc1 and -rc2 is causing random crashes in my
> gce-xfstests framework.  Sometimes it happens before we've run even a
> single xfstests; sometimes it happens after we have successfully
> completed all of the tests, and we're doing a shutdown of the VM under
> test.  Other times it happens in the middle of a test run.  Given that
> I'm seeing this at -rc1, which is before my late ext4 pull request to
> Linus, it's probably not an ext4 related bug.  But it also means that
> I'm partially blind in terms of my kernel testing at the moment.  So I
> can't even tell Linus that I've run lots of tests and I'm 100%
> confident your one-line change is 100% safe.
> 
> Next week after Labor Day, I should be completely done with the
> performance review writeups that are on my plate, and I will hopefully
> have a bit more time to try to debug these mysterious failures.  Or
> maybe someone else will be able to figure out what the heck is going
> wrong, and perhaps -rc3 will make all of these failures go away.
> 
> I'm sorry your frustrated; I'm frustrated too!  But until I can find
> the time to do a full bisect (v5.8 works just fine.  v5.9-rc1 is
> flakey as hell when booting my test config in a GCE VM), I'm not in a
> position to send anything to Linus.

That looks nasty, good luck! Hopefully the bisect will be helpful. FWIW,
in the testing I've done (with this patch) on ext4 and with XFS, I
haven't seen anything odd. That's using real hardware though, and qemu
on the laptop, no GCE.

-- 
Jens Axboe

