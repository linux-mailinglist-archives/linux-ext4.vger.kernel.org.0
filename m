Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F40524FC14
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Aug 2020 12:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHXK5H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Aug 2020 06:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgHXK45 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Aug 2020 06:56:57 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93172C061573
        for <linux-ext4@vger.kernel.org>; Mon, 24 Aug 2020 03:56:57 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t11so4039925plr.5
        for <linux-ext4@vger.kernel.org>; Mon, 24 Aug 2020 03:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z54R/s6uMsDWzUS53s/G9ocW9lyB/9MCHiqT4Fujs1M=;
        b=MbPLk0GF2VALuhyb+FAiqlyj4VFVeLiAAlMDn9DaYmOcvX5E9Oni3eOmrClFcXI/Ks
         ajzV08FNYLNzJ3yESZzqBXKrv0HluC6546D03wRze/HTsbtBf8PU/511L+LjorpK5jPf
         MK4CSIFcoLudq5kZx+tLhpDb3HqzUD6CCbUUrHBrDdXyMlunP41nAEJu04E/LsjU7w3O
         Miv+pL/TUa+bxFZz21E7eoJivHT2DElG2qUtqy+NgjbkXBcvbYSaleyHzh8uhluxN/ko
         cKKXcB5zaIDd1yrPbV7I98EhNe7DLIbnAZx1OFR3JUV4O9YF51Ki/lwXhS7jfSZmWCo8
         HSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z54R/s6uMsDWzUS53s/G9ocW9lyB/9MCHiqT4Fujs1M=;
        b=QoPW2s9Ay2nkzqILnlOjalSU/NeiXSLK9XmdxBJfn3/bj4+4HAHYcELCbYldkW0oqZ
         enMBHOTjW8wB7N29SpMxyiGsKByRc7gAr7jmCx32cs/09e3OVEzFfNb4MtJ/FMaD7V15
         gx/fc1kRNSHLyyp4qWAFRIn96qb3yrq5qf/8kcOEF/1Bnfh97yg2OhOADQXmioQe0XoO
         1nwoLMz0WQdwqz4jnk7g4CxEw3eki7W97mbG+iGvzdnwdYEHYvVVBN3Nq4Xjk67a+sDA
         2/FRG+61WViLWhLeaRB0/olxO0BcJB6SJsKm67AA8fk3AEtpNMk4HPJoEHYXTpog0uQm
         6aDg==
X-Gm-Message-State: AOAM532cjQrsaCkjr9ZJSPP4R9RixSDyf37k4k2EExhaaeZmVIwk/VNT
        gs6NyE9XlZVn4UOk2Hp/WxVaPQ==
X-Google-Smtp-Source: ABdhPJzqz11Bl2B+DB7NGIOUm0RL1MR7hanoZ3I5snxSwLxf1+Cp2Jn3E07PURpIppC2A28/bBeZjw==
X-Received: by 2002:a17:90a:4e8f:: with SMTP id o15mr4076043pjh.220.1598266617084;
        Mon, 24 Aug 2020 03:56:57 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id x18sm11505562pfq.124.2020.08.24.03.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 03:56:56 -0700 (PDT)
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
Message-ID: <7f0e2d99-5da2-237e-a894-0afddc0ace1e@kernel.dk>
Date:   Mon, 24 Aug 2020 04:56:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <aff250ad-4c31-15c2-fa1d-3f3945cb7aa5@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 8/22/20 9:48 AM, Jens Axboe wrote:
> On 8/22/20 8:33 AM, Theodore Y. Ts'o wrote:
>> On Fri, Aug 21, 2020 at 03:26:35PM -0600, Jens Axboe wrote:
>>>>>> Resending this one, as I've been carrying it privately since May. The
>>>>>> necessary bits are now upstream (and XFS/btrfs equiv changes as well),
>>>>>> please consider this one for 5.9. Thanks!
>>>>>
>>>>> The necessary commit only hit upstream as of 5.9-rc1, unless I'm
>>>>> missing something?  It's on my queue to send to Linus once I get my
>>>>> (late) ext4 primary pull request for 5.9.
>>>>
>>>> Right, it went in at the start of the merge window for 5.9. Thanks Ted!
>>>
>>> Didn't see it in the queue that just sent in, is it still queued up?
>>
>> It wasn't in the queue which I queued up because that was based on
>> 5.8-rc4.  Linus was a bit grumpy (fairly so) because it was late, and
>> that's totally on me.
>>
>> He has said that he's going to start ignoring pull requests that
>> aren't fixes only if this becomes a pattern, so while I can send him
>> another pull request which will just have that one change, there are
>> no guarantees he's going to take it at this late date.
>>
>> Sorry, when you sent me the commit saying that the changes that were
>> needed were already upstream on August 3rd, I thought that meant that
>> they were aready in Linus's tree.  I should have checked and noticed
>> that that in fact "ext4: flag as supporting buffered async reads"
>> wasn't compiling against Linus's upstream tree, so I didn't realize
>> this needed to be handled as a special case during the merge window.
> 
> Well to be honest, this kind of sucks. I've been posting it since May,
> and the ideal approach would have been to just ack it and I could have
> carried it in my tree. That's what we did for btrfs and XFS, both of
> which have it.
> 
> The required patches *were* upstreamed on August 3rd, which is why I
> mentioned that. But yes, not in 5.8 or earlier, of course.
> 
> So I suggest that you either include it for the next pull request for
> Linus, or that I put it in with your ack. Either is fine with me. I'd
> consider this a "dropping the ball" kind of thing, it's not like the
> patch hasn't been in linux-next or hasn't been ready for months. This
> isn't some "oh I wrote this feature after the merge window" event. It'd
> be a real shame to ship 5.9 and ext4 not have support for the more
> efficient async buffered reads, imho, especially since the two other
> major local file systems already have it.
> 
> Let me know what you think.

Ted, can you make a call on this, please? It's now post -rc2. Let's
get this settled and included, one way or another.


-- 
Jens Axboe

