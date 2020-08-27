Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C0F253BA1
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Aug 2020 03:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgH0By1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Aug 2020 21:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgH0By0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Aug 2020 21:54:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4739DC06135D
        for <linux-ext4@vger.kernel.org>; Wed, 26 Aug 2020 18:54:26 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q93so1861524pjq.0
        for <linux-ext4@vger.kernel.org>; Wed, 26 Aug 2020 18:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hyLe4hee3vtVCzirvuHp6PgMD4R34otWBPNM+BASlsw=;
        b=NA6kck1KA7GwZuUn5utMNHcXhtBd0cJJgzc4S/+XvOEEBQ8k1jlz0vnoJsVEobW4S5
         06KbDXlGb83uh4zEIVVuADYwJ7JyDXSVgCnnYq03dV28+1A4XMG1hz88UJa990gSDabA
         GvGArsBtWQam/c0Yjr3yWn8wYjp4n2t6EToJ0aZgrPVRxLW7pK2gs9rdrtpkgfw/OQrb
         YoJ8M3hFrZkwKXWLUUNWBjagaLW4Zwr8YdqBpst4kfy4kP+eeJefVi4OmzDjTUKUWySp
         wRZbqzrP7siMbVGECu6BNMg7SAMzAFdoN/p2VKmhQioPz0c8GTIghvebKVCTrOJml5un
         CG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hyLe4hee3vtVCzirvuHp6PgMD4R34otWBPNM+BASlsw=;
        b=LdZiX4LOK1NCYQYLqipIb+NGx7o+h2tzXw7P3FlHWAO/9E0poQxmy5wjtunsTL+O63
         icrTc+7jmVtNpU0/nXsea9e8yKPiXh8k2nt5tjMatpbe2pH9x/YB/xK8jCOw0ia+r6A7
         qimS6CGI49bNHQK4qiqzKnQ9I/93PBMDAGRqSyvBHqBY9MbYxCK+hb/SoGIAiosza93i
         wleJRDg+zYPPbaqZOSWitkOoJ5qPYZEaUHMtU4qtWn2RLoonrZ7AEDj8ufzkFr44OZae
         03+6G95YyVgRrALh+oCyXM0Ga4RAwEx+DXm7h5yVbIWPVv/lDfIZo8gOMNjkAG2wWtMR
         syvA==
X-Gm-Message-State: AOAM531boXWKZY7wE6EdPfD6U4+mWhf6L8Eio5JijDYkjDvxFUkQJJrv
        aBBWWDQo9vyrOe0byY+N7XhGDQ==
X-Google-Smtp-Source: ABdhPJyZHfyUujfteOaUNdFhFycqKuTH8UUTtO70E2mGEP7BE/Xyer0abzMjsLC/xIcxq2jjIv0ZFg==
X-Received: by 2002:a17:90a:4ec6:: with SMTP id v6mr8178037pjl.12.1598493265664;
        Wed, 26 Aug 2020 18:54:25 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21cf::15ba? ([2620:10d:c090:400::5:13e3])
        by smtp.gmail.com with ESMTPSA id ft11sm351758pjb.13.2020.08.26.18.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 18:54:25 -0700 (PDT)
Subject: Re: [PATCH] ext4: flag as supporting buffered async reads
From:   Jens Axboe <axboe@kernel.dk>
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
Message-ID: <5140ba6c-779c-2a71-b7f2-3c3220cdf19c@kernel.dk>
Date:   Wed, 26 Aug 2020 19:54:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <049a97db-c362-bcfb-59e5-4b1d2df59383@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 8/25/20 8:18 AM, Jens Axboe wrote:
> On 8/24/20 4:56 AM, Jens Axboe wrote:
>> On 8/22/20 9:48 AM, Jens Axboe wrote:
>>> On 8/22/20 8:33 AM, Theodore Y. Ts'o wrote:
>>>> On Fri, Aug 21, 2020 at 03:26:35PM -0600, Jens Axboe wrote:
>>>>>>>> Resending this one, as I've been carrying it privately since May. The
>>>>>>>> necessary bits are now upstream (and XFS/btrfs equiv changes as well),
>>>>>>>> please consider this one for 5.9. Thanks!
>>>>>>>
>>>>>>> The necessary commit only hit upstream as of 5.9-rc1, unless I'm
>>>>>>> missing something?  It's on my queue to send to Linus once I get my
>>>>>>> (late) ext4 primary pull request for 5.9.
>>>>>>
>>>>>> Right, it went in at the start of the merge window for 5.9. Thanks Ted!
>>>>>
>>>>> Didn't see it in the queue that just sent in, is it still queued up?
>>>>
>>>> It wasn't in the queue which I queued up because that was based on
>>>> 5.8-rc4.  Linus was a bit grumpy (fairly so) because it was late, and
>>>> that's totally on me.
>>>>
>>>> He has said that he's going to start ignoring pull requests that
>>>> aren't fixes only if this becomes a pattern, so while I can send him
>>>> another pull request which will just have that one change, there are
>>>> no guarantees he's going to take it at this late date.
>>>>
>>>> Sorry, when you sent me the commit saying that the changes that were
>>>> needed were already upstream on August 3rd, I thought that meant that
>>>> they were aready in Linus's tree.  I should have checked and noticed
>>>> that that in fact "ext4: flag as supporting buffered async reads"
>>>> wasn't compiling against Linus's upstream tree, so I didn't realize
>>>> this needed to be handled as a special case during the merge window.
>>>
>>> Well to be honest, this kind of sucks. I've been posting it since May,
>>> and the ideal approach would have been to just ack it and I could have
>>> carried it in my tree. That's what we did for btrfs and XFS, both of
>>> which have it.
>>>
>>> The required patches *were* upstreamed on August 3rd, which is why I
>>> mentioned that. But yes, not in 5.8 or earlier, of course.
>>>
>>> So I suggest that you either include it for the next pull request for
>>> Linus, or that I put it in with your ack. Either is fine with me. I'd
>>> consider this a "dropping the ball" kind of thing, it's not like the
>>> patch hasn't been in linux-next or hasn't been ready for months. This
>>> isn't some "oh I wrote this feature after the merge window" event. It'd
>>> be a real shame to ship 5.9 and ext4 not have support for the more
>>> efficient async buffered reads, imho, especially since the two other
>>> major local file systems already have it.
>>>
>>> Let me know what you think.
>>
>> Ted, can you make a call on this, please? It's now post -rc2. Let's
>> get this settled and included, one way or another.
> 
> Daily ping on this one...

And again. Ted, not sure how to make any progress with this, to be
honest, it's like pounding sand.

-- 
Jens Axboe

