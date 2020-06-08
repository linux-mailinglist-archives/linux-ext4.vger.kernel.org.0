Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08691F111B
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Jun 2020 03:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgFHBj4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 7 Jun 2020 21:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgFHBj4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 7 Jun 2020 21:39:56 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B917BC08C5C3
        for <linux-ext4@vger.kernel.org>; Sun,  7 Jun 2020 18:39:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l17so2569976wmj.0
        for <linux-ext4@vger.kernel.org>; Sun, 07 Jun 2020 18:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jguk.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hc+ccXW71+qNr4G7lwCMMXSLLdx8mR+aqwaHOWDLr14=;
        b=Bkzyd7gM1jXtBwZ4MNFf7OxQClsi2BPivyPNGfi2yDpZOTZPs/4p6bIlJdVh7TF7WI
         41y1luJ7ivkk9R3LWfaZk+aeT69tLtsj12NX7H45ygsqqQXtQVvcKNIz2hoEakS9gN/h
         vP7azpsDk2E/ShpJxTcqvl7xNdvr+9wd3hbX0ljB481m9CZBycRQ8SDbNVhmu9S+tDv8
         fg3YcpQC7/APbszCJ97wuAtOBC7vOS9fH0xyIzZnUKcw6/m0KnfMvI/worBXkQvr2CSa
         UF2XnOjRgcsWBYjZWiC+85vwXOetI8deqnQrK/K0I/O7eAMn4fNGozzPO3jK3DfNEiLj
         ou/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hc+ccXW71+qNr4G7lwCMMXSLLdx8mR+aqwaHOWDLr14=;
        b=Wx77kGMyPbm5nGhhWJViORXGNvKdNYdkD/MSIdpi0i7TuE4FTtq/JSjXBCQ6W/6Fu2
         oLyVbJz03D+6aGdTNc7sweckRqZ0lmy/LIvm/DFXfZ8HxDcqYugL4KaaQSj0bfcqkGSb
         +lGrpQSg16qVnSQ7c18hQbVVZnEqit/IVTmbT5nxv3FZHrYgnDmf7H6C5kLhrKxAxY+8
         5V/KIwGNXQTdrinbLBX6u6CwXbvd68BcoFzMT8hBZyzAULZ7DEvHaVRmymOXNFRP0ugP
         sWO1ltQKdxYiAYQyD4rQJ0lPBVashcP0GuWhta6mQtjf+DOKfMoCAlVdy2N3uZFuWtw7
         2DOQ==
X-Gm-Message-State: AOAM532ORhk0rWeJI2rt1mGlJqqJ+sjUEMgnde/Xo7Vh+XNngKnghp0t
        8gAfhr2spP6TUcnhspPsk8bL2+ci9cQ=
X-Google-Smtp-Source: ABdhPJxpZnuO9M/OnjeCs8H7cLQ4TZvmo6yAimcBwOyXXeHRs5XeQhBfwzA8R369+YOYOKqUF0FwQQ==
X-Received: by 2002:a1c:9e13:: with SMTP id h19mr14430757wme.107.1591580392955;
        Sun, 07 Jun 2020 18:39:52 -0700 (PDT)
Received: from [192.168.0.12] (cpc87281-slou4-2-0-cust47.17-4.cable.virginm.net. [92.236.12.48])
        by smtp.gmail.com with ESMTPSA id h188sm21693820wmh.2.2020.06.07.18.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 18:39:51 -0700 (PDT)
From:   Jonny Grant <jg@jguk.org>
Subject: Re: /fs/ext4/namei.c ext4_find_dest_de()
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <2edc7d6a-289e-57ad-baf1-477dc240474d@jguk.org>
 <20200504015122.GB404484@mit.edu>
 <e6e172ae-ba19-f303-3aa9-a388adba8cb0@jguk.org>
 <20200528011221.GC228632@mit.edu>
Message-ID: <fea0b424-cdb4-b6f8-ec0a-3aae8d66233e@jguk.org>
Date:   Mon, 8 Jun 2020 02:39:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528011221.GC228632@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 28/05/2020 02:12, Theodore Y. Ts'o wrote:
> On Wed, May 27, 2020 at 10:25:43PM +0100, Jonny Grant wrote:
>>
>>
>> How about adding an improved mkdir to POSIX and the Linux kernel? Let's call it mkdir2()
>>
>> It has one more error, for EISDIR
>>
>> [EEXIST]
>> The named file exists.
>>
>> [EISDIR]
>> Directory with that name exists.
> 
> It's *really* not worth it.

You're right.

> You seem to really care about this; why don't you just keep your own
> version of shellutils which calls stat(1) if you get EEXIST and to
> distinguish between these two cases?
> 
> I know the shellutils maintainers has rejected this.  But that's OK,
> you can have your own copy on your systems.  You might want to reflect
> that if the shellutils maintainer refused to add the stat(1) on the
> error path, what makes you think they will accept a change to use a
> non-standard mkdir2() system call?

You're right, it's unlikely.

> If you want to try to convince Austin Common Standards Revision Group
> that it's worth it to mandate a whole new system call *just* for a new
> error code, you're welcome to try.  I suspect you will not get a good
> reception, and even if you did, Linux VFS maintainer may well very
> well deride the proposal as silly, and refuse to follow the lead of
> the Austin group.  In fact, Al Viro is very likely not to be as
> politic as I have been.  (It's likely the response would have included
> things like "idiotic idea" and "stupid".)
> 
>> I'm tempted to suggest this new function mkdir2() returns 0 on success, or
>> an error number directly number. That would do away with 'errno' for this as
>> well.
> 
> This is not going to get a good reception from either Al or the Austin
> Group, I predict.  If you really have strong ideas of what you think
> an OS and its interfaces should look like, perhaps you should just
> design your own OS from scratch.

Yes, I agree, no one would want to change anything.
I recall other APIs like pthread_setname_np return 0 on success, and the error code directly, so there is some trend in 
that direction. That's part of POSIX.1


Hmm designing an OS, could be fun as a hobby, but wouldn't be big and professional like linux is on x86 x64 these days. 
I'd probably seek feedback on things people like/dislike in POSIX, as any OS would resemble it somewhat anyway, at least 
due to practical reasons compiling common tools. It would end up with a POSIX wrapper, on top of any APIs I designed, 
and then there would be no reason to use my APIs anyway. It's more fun to contribute to something with global appeal 
than a hobby project.

Regards, Jonny

