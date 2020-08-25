Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E80251AAA
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Aug 2020 16:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgHYOSf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Aug 2020 10:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgHYOSa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Aug 2020 10:18:30 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5640AC061574
        for <linux-ext4@vger.kernel.org>; Tue, 25 Aug 2020 07:18:30 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id v2so10536689ilq.4
        for <linux-ext4@vger.kernel.org>; Tue, 25 Aug 2020 07:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4fa6CWJEUOwheO2MzeVtgbtKAJxehJpCdEllFRnoowQ=;
        b=aw1QWNf3nx90XJSzXYAZQe7F04hGPY8+Gb+qR8Ze+dP2vRW0I4JdU4Kyne2+ye13UW
         Zad39+dVzCW5d6cTcfiDt5+u3pyK0Gm1JhPyRny4A5LDMsB3f/zhEDDVTZndtWUW3Hfc
         njciB/DQ4eevRhkLmSrwx7364rKibGzFp/FtwIz693ca3qROabwT5HSB7/gHuD9AiwDg
         7SA0mVFQ44RaNI7rNK4T+AbFcWaIGoobuRvhnB7TvIkMgL/RaLdwUA9adq5hQ4ef+56i
         g8z5WEYqyxhctyOIRZpS1zKfyTKAsW0SdFeLOwmSEmjdsfBO0lVHaMeFCut9nTP+ABoL
         4+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4fa6CWJEUOwheO2MzeVtgbtKAJxehJpCdEllFRnoowQ=;
        b=tEFA6k3oQtG+AqyESQ4vQpvBISypohdg+0Sv0Y0R71AA/q8KWacyxso/BMsqIyLtg/
         8RezqkDTFowNMWp/mgOathx7SwBAkWd0UbipBgaV5WmPJGO9C6kOS8doPvg8aJc+tb4+
         7hDoFtdCpCyNrPp8yW5ExJBCl3/LDgH20t5SAlg4sXPqoaNtnZm5XZRR2dY+QFu2NB9Z
         S4tNcKvlaBNsYRUjSgS09D8EslPfX3iExmUS8xmA66ppPKkxwEvJ3xmlEzOrc7gRrJra
         GmN+36YiqqDfKqLrNx4FefAn9FxXkUFrCLxcnmwLMfRS26F1BJB+wec+Jsai9HN2wh2T
         lFkg==
X-Gm-Message-State: AOAM530W0mSuz0z4U/Wb3IUcUKmcoE/hWX3CpwJbTGY4zDFbEbnZTLTa
        OMJOaTVjHfuRqxu9/YnxN7srS8bVfTadYo+4
X-Google-Smtp-Source: ABdhPJyY1OaQ+Umotok2j2XLRxsZuzwhZJCnmSI1jN+NLrCYnTMyRkEaZpokELcBWo2CHRg0pa9f7w==
X-Received: by 2002:a92:6c09:: with SMTP id h9mr9815270ilc.46.1598365109513;
        Tue, 25 Aug 2020 07:18:29 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f18sm9350485ilj.24.2020.08.25.07.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 07:18:28 -0700 (PDT)
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
Message-ID: <049a97db-c362-bcfb-59e5-4b1d2df59383@kernel.dk>
Date:   Tue, 25 Aug 2020 08:18:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7f0e2d99-5da2-237e-a894-0afddc0ace1e@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 8/24/20 4:56 AM, Jens Axboe wrote:
> On 8/22/20 9:48 AM, Jens Axboe wrote:
>> On 8/22/20 8:33 AM, Theodore Y. Ts'o wrote:
>>> On Fri, Aug 21, 2020 at 03:26:35PM -0600, Jens Axboe wrote:
>>>>>>> Resending this one, as I've been carrying it privately since May. The
>>>>>>> necessary bits are now upstream (and XFS/btrfs equiv changes as well),
>>>>>>> please consider this one for 5.9. Thanks!
>>>>>>
>>>>>> The necessary commit only hit upstream as of 5.9-rc1, unless I'm
>>>>>> missing something?  It's on my queue to send to Linus once I get my
>>>>>> (late) ext4 primary pull request for 5.9.
>>>>>
>>>>> Right, it went in at the start of the merge window for 5.9. Thanks Ted!
>>>>
>>>> Didn't see it in the queue that just sent in, is it still queued up?
>>>
>>> It wasn't in the queue which I queued up because that was based on
>>> 5.8-rc4.  Linus was a bit grumpy (fairly so) because it was late, and
>>> that's totally on me.
>>>
>>> He has said that he's going to start ignoring pull requests that
>>> aren't fixes only if this becomes a pattern, so while I can send him
>>> another pull request which will just have that one change, there are
>>> no guarantees he's going to take it at this late date.
>>>
>>> Sorry, when you sent me the commit saying that the changes that were
>>> needed were already upstream on August 3rd, I thought that meant that
>>> they were aready in Linus's tree.  I should have checked and noticed
>>> that that in fact "ext4: flag as supporting buffered async reads"
>>> wasn't compiling against Linus's upstream tree, so I didn't realize
>>> this needed to be handled as a special case during the merge window.
>>
>> Well to be honest, this kind of sucks. I've been posting it since May,
>> and the ideal approach would have been to just ack it and I could have
>> carried it in my tree. That's what we did for btrfs and XFS, both of
>> which have it.
>>
>> The required patches *were* upstreamed on August 3rd, which is why I
>> mentioned that. But yes, not in 5.8 or earlier, of course.
>>
>> So I suggest that you either include it for the next pull request for
>> Linus, or that I put it in with your ack. Either is fine with me. I'd
>> consider this a "dropping the ball" kind of thing, it's not like the
>> patch hasn't been in linux-next or hasn't been ready for months. This
>> isn't some "oh I wrote this feature after the merge window" event. It'd
>> be a real shame to ship 5.9 and ext4 not have support for the more
>> efficient async buffered reads, imho, especially since the two other
>> major local file systems already have it.
>>
>> Let me know what you think.
> 
> Ted, can you make a call on this, please? It's now post -rc2. Let's
> get this settled and included, one way or another.

Daily ping on this one...

-- 
Jens Axboe

