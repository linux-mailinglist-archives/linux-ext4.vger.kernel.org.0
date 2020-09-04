Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D3825CEB3
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Sep 2020 02:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgIDAKX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Sep 2020 20:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgIDAKW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Sep 2020 20:10:22 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18BEC061244
        for <linux-ext4@vger.kernel.org>; Thu,  3 Sep 2020 17:10:21 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 2so2334349pjx.5
        for <linux-ext4@vger.kernel.org>; Thu, 03 Sep 2020 17:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rw9pmQTQu6dvaQDKT0uSQScovZ5fpYHem+SmnvyvPmU=;
        b=FU9Grb4nh8gFbwKt44VFMMllrBQOnPfGq3/5Owyng816a3rX2+dwGqU1YD3ieFoz31
         0CDFOUZj+0ovoCpya3T5u3zUmfWm6E/Euca4qKBCRsrlX6mMCRtaWXNMYUFBpw2ArKDV
         HRRN9q4OY+n1Cpvfd2Xz53G+0NOzMjH1Nv4VhTcvDerEdjIfEZ9IdOSEVRxwj9akRH7r
         Q+2flUPhU1aF4u2JPPMXbWlMDOwKGyz2Yy4UjTkfnmtYSdgLgRL04QdOwEZyYVkTQvLt
         BbFqXVndcNMpqwoGBsqNNi5fvCD7lXVwswPotSlxMfKTpajohEBifM+TyceWF1YdxWf9
         BGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rw9pmQTQu6dvaQDKT0uSQScovZ5fpYHem+SmnvyvPmU=;
        b=q3y5l5pts9EGd/zHSo23R0jGZ5SfMpvOvGzKYDQA8LYThrU3X5Sgxf8UjPW9SJ4aBV
         7iQgHD67NS8qOsEKB244qzlEQff+9za32JehZXykRHAbdX+r9GN7usQ2H6FeXUI0WL1Y
         LnsNQt0FBcb4KIeT0K3VfktMOL8JJs5cS9DgN5A7trC4n4dV1yQBJELp9PKkXbCrA+Xp
         BdRov3+/olT8FjKS86xbaSqGBNXLiTl2Lmx5ZfJpQou0wcJzmbidwa1SBO1d0KNNxvVG
         JoWfXCi0ABBVg62ai+LiwZwWHabHEYz60bx0Fjry30guEO1ygt8UTqGzhDvJOrzFynpl
         pqCg==
X-Gm-Message-State: AOAM531BUrocN3D4xXQ8OJqYQ0KyquoqACOGcj44tVq276phoE0KvreH
        pkBCJdpVDohZ3xVpLcdQeElNqw==
X-Google-Smtp-Source: ABdhPJwYzWDKB3jLO3lPgnu1+einL1KUEDjZkKuhU01AKBm1PSHOGYqgt4sJF5+tp9mK0KQLrEEOUg==
X-Received: by 2002:a17:90a:ee16:: with SMTP id e22mr5084461pjy.81.1599178220874;
        Thu, 03 Sep 2020 17:10:20 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id e19sm4626659pfl.135.2020.09.03.17.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 17:10:20 -0700 (PDT)
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
 <5140ba6c-779c-2a71-b7f2-3c3220cdf19c@kernel.dk>
Message-ID: <68510957-c887-8e26-4a1a-a7a93488586a@kernel.dk>
Date:   Thu, 3 Sep 2020 18:10:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5140ba6c-779c-2a71-b7f2-3c3220cdf19c@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 8/26/20 7:54 PM, Jens Axboe wrote:
> On 8/25/20 8:18 AM, Jens Axboe wrote:
>> On 8/24/20 4:56 AM, Jens Axboe wrote:
>>> On 8/22/20 9:48 AM, Jens Axboe wrote:
>>>> On 8/22/20 8:33 AM, Theodore Y. Ts'o wrote:
>>>>> On Fri, Aug 21, 2020 at 03:26:35PM -0600, Jens Axboe wrote:
>>>>>>>>> Resending this one, as I've been carrying it privately since May. The
>>>>>>>>> necessary bits are now upstream (and XFS/btrfs equiv changes as well),
>>>>>>>>> please consider this one for 5.9. Thanks!
>>>>>>>>
>>>>>>>> The necessary commit only hit upstream as of 5.9-rc1, unless I'm
>>>>>>>> missing something?  It's on my queue to send to Linus once I get my
>>>>>>>> (late) ext4 primary pull request for 5.9.
>>>>>>>
>>>>>>> Right, it went in at the start of the merge window for 5.9. Thanks Ted!
>>>>>>
>>>>>> Didn't see it in the queue that just sent in, is it still queued up?
>>>>>
>>>>> It wasn't in the queue which I queued up because that was based on
>>>>> 5.8-rc4.  Linus was a bit grumpy (fairly so) because it was late, and
>>>>> that's totally on me.
>>>>>
>>>>> He has said that he's going to start ignoring pull requests that
>>>>> aren't fixes only if this becomes a pattern, so while I can send him
>>>>> another pull request which will just have that one change, there are
>>>>> no guarantees he's going to take it at this late date.
>>>>>
>>>>> Sorry, when you sent me the commit saying that the changes that were
>>>>> needed were already upstream on August 3rd, I thought that meant that
>>>>> they were aready in Linus's tree.  I should have checked and noticed
>>>>> that that in fact "ext4: flag as supporting buffered async reads"
>>>>> wasn't compiling against Linus's upstream tree, so I didn't realize
>>>>> this needed to be handled as a special case during the merge window.
>>>>
>>>> Well to be honest, this kind of sucks. I've been posting it since May,
>>>> and the ideal approach would have been to just ack it and I could have
>>>> carried it in my tree. That's what we did for btrfs and XFS, both of
>>>> which have it.
>>>>
>>>> The required patches *were* upstreamed on August 3rd, which is why I
>>>> mentioned that. But yes, not in 5.8 or earlier, of course.
>>>>
>>>> So I suggest that you either include it for the next pull request for
>>>> Linus, or that I put it in with your ack. Either is fine with me. I'd
>>>> consider this a "dropping the ball" kind of thing, it's not like the
>>>> patch hasn't been in linux-next or hasn't been ready for months. This
>>>> isn't some "oh I wrote this feature after the merge window" event. It'd
>>>> be a real shame to ship 5.9 and ext4 not have support for the more
>>>> efficient async buffered reads, imho, especially since the two other
>>>> major local file systems already have it.
>>>>
>>>> Let me know what you think.
>>>
>>> Ted, can you make a call on this, please? It's now post -rc2. Let's
>>> get this settled and included, one way or another.
>>
>> Daily ping on this one...
> 
> And again. Ted, not sure how to make any progress with this, to be
> honest, it's like pounding sand.

And 8 days later...

-- 
Jens Axboe

