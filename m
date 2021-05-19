Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1C7389015
	for <lists+linux-ext4@lfdr.de>; Wed, 19 May 2021 16:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347142AbhESOOw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 May 2021 10:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347100AbhESOOu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 May 2021 10:14:50 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD6DC061761
        for <linux-ext4@vger.kernel.org>; Wed, 19 May 2021 07:13:29 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id u4-20020a05600c00c4b02901774b80945cso3531322wmm.3
        for <linux-ext4@vger.kernel.org>; Wed, 19 May 2021 07:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=F1uHj1sY3bif8fDQ1vUSxLLQOsCnGsqmIKuxItWP5SE=;
        b=SDA0dOzGVO+57kjNrjJvQNP1xKWe1BPMgFM9LOB60TBGNsZruo26eZNVXQqHe09Wyh
         t3YEDBwQS7nNB1xn9iJx8liHXnOFRK2JiAxiWSDZmd0y2ICBe0XzbJMM27m7C4SUQ3mu
         vTwkFi8o8/S48uFCjBnplHtzTETQR9EHC8t3XNRux0bH+1PsALWdCxh/yfztwXYCDoKj
         4vfbQDwTnryp2WQTliveGOceQ94Hg4RgVC2Z5C9umWFF3RgOi+xYwuw2KRaukYTlDn8q
         5EcLldNa9cFNt2eOyYdEbGWwfhZhm6l/gvIk70K66a+C3/1G3PH9v28xbGCgNBSLKwPX
         ISNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=F1uHj1sY3bif8fDQ1vUSxLLQOsCnGsqmIKuxItWP5SE=;
        b=r9LeT8Wf7xnxifpGzm1cB6hK2mQeKymRJOm3SSeDt8ILX45cMmCjKP/dln1mbosN9U
         FgpN9lUPKVNnqbpjVci7sEDJJ/MG7fHXjqMsJ9YMQHxG9MLRRwapZdO8T3Xz6K8mrMP2
         bjMwoHWUU4l9j9zh/RpWqG6/9vea4M+ddg2+Ix184vhfCa65XmZM5KaU0zd93Fmn6G6t
         aXfNQmcmQf4zqy9n0ddg5wWk4b980Zptu7Oc559TgAo0+wg+dZOktrCA+wtjn+iWCQ6H
         GCmnLSoO6bBpFDXLz652gvjCCI1QJlcN9hptGnpB474ySxekiLTcfp/iw1cJejgYMf7B
         2qQw==
X-Gm-Message-State: AOAM53288YmwW8Wt14CXzOvvsd08TGor4vvwJI4b39wsu7frPr9lWiOk
        I3fHrfrel0VJrkwykZzP7L89Ww==
X-Google-Smtp-Source: ABdhPJxk+UI+VUW6asY9NMngA528APjLs2XsUer7iCT6Z9lvFyaeGL+Kw3GXszS2nh/Snl9Wx61CBA==
X-Received: by 2002:a05:600c:19cc:: with SMTP id u12mr7608624wmq.178.1621433607809;
        Wed, 19 May 2021 07:13:27 -0700 (PDT)
Received: from avi.scylladb.com (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id h9sm20842196wmb.35.2021.05.19.07.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 07:13:27 -0700 (PDT)
Subject: Re: How capacious and well-indexed are ext4, xfs and btrfs
 directories?
To:     Dave Chinner <david@fromorbit.com>
Cc:     David Howells <dhowells@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
References: <206078.1621264018@warthog.procyon.org.uk>
 <20210517232237.GE2893@dread.disaster.area>
 <ad2e8757-41ce-41e3-a22e-0cf9e356e656@scylladb.com>
 <20210519125743.GP2893@dread.disaster.area>
From:   Avi Kivity <avi@scylladb.com>
Organization: ScyllaDB
Message-ID: <c5d83b86-321e-349b-303c-b6027bcd9ae1@scylladb.com>
Date:   Wed, 19 May 2021 17:13:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519125743.GP2893@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 19/05/2021 15.57, Dave Chinner wrote:
> On Wed, May 19, 2021 at 11:00:03AM +0300, Avi Kivity wrote:
>> On 18/05/2021 02.22, Dave Chinner wrote:
>>>> What I'd like to do is remove the fanout directories, so that for each logical
>>>> "volume"[*] I have a single directory with all the files in it.  But that
>>>> means sticking massive amounts of entries into a single directory and hoping
>>>> it (a) isn't too slow and (b) doesn't hit the capacity limit.
>>> Note that if you use a single directory, you are effectively single
>>> threading modifications to your file index. You still need to use
>>> fanout directories if you want concurrency during modification for
>>> the cachefiles index, but that's a different design criteria
>>> compared to directory capacity and modification/lookup scalability.
>> Something that hit us with single-large-directory and XFS is that
>> XFS will allocate all files in a directory using the same
>> allocation group.  If your entire filesystem is just for that one
>> directory, then that allocation group will be contended.
> There is more than one concurrency problem that can arise from using
> single large directories. Allocation policy is just another aspect
> of the concurrency picture.
>
> Indeed, you can avoid this specific problem simply by using the
> inode32 allocator - this policy round-robins files across allocation
> groups instead of trying to keep files physically local to their
> parent directory. Hence if you just want one big directory with lots
> of files that index lots of data, using the inode32 allocator will
> allow the files in the filesytsem to allocate/free space at maximum
> concurrency at all times...


Perhaps a directory attribute can be useful in case the filesystem is 
created independently of the application (say by the OS installer).


>
>> We saw spurious ENOSPC when that happened, though that
>> may have related to bad O_DIRECT management by us.
> You should not see spurious ENOSPC at all.
>
> The only time I've recall this sort of thing occurring is when large
> extent size hints are abused by applying them to every single file
> and allocation regardless of whether they are needed, whilst
> simultaneously mixing long term and short term data in the same
> physical locality.


Yes, you remember well.


>   Over time the repeated removal and reallocation
> of short term data amongst long term data fragments the crap out of
> free space until there are no large contiguous free spaces left to
> allocate contiguous extents from.
>
>> We ended up creating files in a temporary directory and moving them to the
>> main directory, since for us the directory layout was mandated by
>> compatibility concerns.
> inode32 would have done effectively the same thing but without
> needing to change the application....


It would not have helped the installed base.


>> We are now happy with XFS large-directory management, but are nowhere close
>> to a million files.
> I think you are conflating directory scalability with problems
> arising from file allocation policies not being ideal for your data
> set organisation, layout and longevity characteristics.


Probably, but these problems can happen to others using large 
directories. The XFS list can be very helpful in resolving them, but 
better to be warned ahead.


