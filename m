Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509F124E86B
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Aug 2020 17:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgHVPso (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 22 Aug 2020 11:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgHVPsm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 22 Aug 2020 11:48:42 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DEAC061574
        for <linux-ext4@vger.kernel.org>; Sat, 22 Aug 2020 08:48:42 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f193so2573774pfa.12
        for <linux-ext4@vger.kernel.org>; Sat, 22 Aug 2020 08:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WbL90IDwtnRtnzlD0xDGTdZ6FaQmNJQAGy53EB9XAHk=;
        b=0KZ+dqt5XN5ztFcChm8+ZeUl+GW8fXsEiliNI5SKcfdWype1tzUD3q0c4KCTXtTOWU
         jPdbj4EvlAV56xq5aGtoLWg72Lzki+lOYu5f2Dm2iO7hp2ipTTvWMfQ2DzwmGhOVTZmk
         tCnjKLnK3sU8J0nFYAJFV8EJrXyQuNj8nh9PwJ/h2SZBxKRJOcNaoKmSKlabujAeVLFy
         R1y+0QXCzY/yaBUIsAqVctnVCzCJ9d1s0ruzhX9nsDJwUd1to8WQXxgHh4AZrIPcR7lB
         GMY8IIx3nkVE0iyeqWc3ko//t77f0KAmDvW+XD37zLzd7hDX1clRQgikLtsDjrsHFNmP
         ZCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WbL90IDwtnRtnzlD0xDGTdZ6FaQmNJQAGy53EB9XAHk=;
        b=MgWqae+Sb1llHB/fqmwh9MctbG4H21s02E60Z9K72u7F1/p5wAahwCbVAFfRUaePNP
         nuxWRYiHzG/QSiScqUVDN1YbZUBiuVRhmUF5DNTUOFcQIXT6EyblG6oDFtecBzjk8Ru+
         +NXYEH8VWWWH8EP7DD7LFaeudPsuxCYU0FXg98jLGcj/kgU4S6/b1EfxQbwUF5CRcFMU
         AEl2fhSe0tFxt1uc3jPBKlV+T1ZpkRgp/B87ZfLFNYaEctM+xeatY4OCRERizl8Afbht
         05qWpQNETl9DRB0au9Y5tFhBtjq1BSnyP0qu2YsVhxIP6iVqWQ3XMPtQyoymJg01khVq
         2Jrw==
X-Gm-Message-State: AOAM530bksJ4AMTuopHc+yKugxL7Bu/hjLQtfO562f1S1uccJLFwnACb
        9lo3LQYWs08jG13AIg4Dhuk7ggqKR7Cjr+/x
X-Google-Smtp-Source: ABdhPJzHdhcG1OaTI4+z9SJEQ0YHL8LOWl5oPUh0GXHf9JvYJ0cQemZTDm7DiSpV3t68o+75tLmz2A==
X-Received: by 2002:aa7:9468:: with SMTP id t8mr6380356pfq.182.1598111320508;
        Sat, 22 Aug 2020 08:48:40 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b10sm721269pjd.51.2020.08.22.08.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2020 08:48:39 -0700 (PDT)
Subject: Re: [PATCH] ext4: flag as supporting buffered async reads
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <fb90cc2d-b12c-738f-21a4-dd7a8ae0556a@kernel.dk>
 <20200818181117.GA34125@mit.edu>
 <990cc101-d4a1-f346-fe78-0fb5b963b406@kernel.dk>
 <20c844c8-b649-3250-ff5b-b7420f72ff38@kernel.dk>
 <20200822143326.GC199705@mit.edu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aff250ad-4c31-15c2-fa1d-3f3945cb7aa5@kernel.dk>
Date:   Sat, 22 Aug 2020 09:48:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200822143326.GC199705@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 8/22/20 8:33 AM, Theodore Y. Ts'o wrote:
> On Fri, Aug 21, 2020 at 03:26:35PM -0600, Jens Axboe wrote:
>>>>> Resending this one, as I've been carrying it privately since May. The
>>>>> necessary bits are now upstream (and XFS/btrfs equiv changes as well),
>>>>> please consider this one for 5.9. Thanks!
>>>>
>>>> The necessary commit only hit upstream as of 5.9-rc1, unless I'm
>>>> missing something?  It's on my queue to send to Linus once I get my
>>>> (late) ext4 primary pull request for 5.9.
>>>
>>> Right, it went in at the start of the merge window for 5.9. Thanks Ted!
>>
>> Didn't see it in the queue that just sent in, is it still queued up?
> 
> It wasn't in the queue which I queued up because that was based on
> 5.8-rc4.  Linus was a bit grumpy (fairly so) because it was late, and
> that's totally on me.
> 
> He has said that he's going to start ignoring pull requests that
> aren't fixes only if this becomes a pattern, so while I can send him
> another pull request which will just have that one change, there are
> no guarantees he's going to take it at this late date.
> 
> Sorry, when you sent me the commit saying that the changes that were
> needed were already upstream on August 3rd, I thought that meant that
> they were aready in Linus's tree.  I should have checked and noticed
> that that in fact "ext4: flag as supporting buffered async reads"
> wasn't compiling against Linus's upstream tree, so I didn't realize
> this needed to be handled as a special case during the merge window.

Well to be honest, this kind of sucks. I've been posting it since May,
and the ideal approach would have been to just ack it and I could have
carried it in my tree. That's what we did for btrfs and XFS, both of
which have it.

The required patches *were* upstreamed on August 3rd, which is why I
mentioned that. But yes, not in 5.8 or earlier, of course.

So I suggest that you either include it for the next pull request for
Linus, or that I put it in with your ack. Either is fine with me. I'd
consider this a "dropping the ball" kind of thing, it's not like the
patch hasn't been in linux-next or hasn't been ready for months. This
isn't some "oh I wrote this feature after the merge window" event. It'd
be a real shame to ship 5.9 and ext4 not have support for the more
efficient async buffered reads, imho, especially since the two other
major local file systems already have it.

Let me know what you think.

-- 
Jens Axboe

