Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 586C5992C5
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2019 14:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733015AbfHVMAZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Aug 2019 08:00:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40662 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbfHVMAZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Aug 2019 08:00:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id h3so3346444pls.7
        for <linux-ext4@vger.kernel.org>; Thu, 22 Aug 2019 05:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d5lwnucT/goOERbwcr+nMNokkaJEYrH6ff8I2mYa9Hg=;
        b=jg6H0OFlGUlZblzORqlZKMjqL8twEnQJr3mqtrqMZXZthnH52Z53Y5gCeCfvcNM26c
         HZqiB48pJhxw3j/5T6RpZJvIS8kR2gAMAAY2tDEQzMVcEW7cy+NX9wLI17iT0/MnwU5n
         hO+h9cjuXEOw0ozmHUTFGm7ufwXfQ9mk9qMV+tZJsseqTlBVF3+aBB9L/iPf3XHqJJ/w
         zYijFvpwLqeajKk6S1u1y/67XIyKO6RbBOk9zGauzEMbr15q76K+DYrQ6RkwIh0wMw5O
         wJG+yd77Qgbn+wiT2dOefiSIbHufSa8ZqtW0QpHr0MRvGxzOwQbXVVhQEHuFzLSWIs/l
         jsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d5lwnucT/goOERbwcr+nMNokkaJEYrH6ff8I2mYa9Hg=;
        b=qqRMSKJCKO030PSgN/4cFHgf9VFHFRHSDOrx4iisaryA9gbfIp1OXEMgnveO2UcT6R
         Vbf32bqM2++rudQV8ubQBqfNOz3ti+v2p0SoZdNYzrE5Aw5C0riqdzxFPZpreqQeec7G
         20ZHUJChLPyCKKFQFz2CJrxqnjrqJWSiAhotmW+a4WzZiXov8JOdPVPb4gngz3ShaV7D
         R6NhHG9aPLfhYcn3bHClwfLD9fOJyp/id2k7OgoBU51WK1iJLePS8rnvVHC0ciElfIOv
         Z2vA3B2qdvRkwlQW5X7jYqNwgN8wQUTU62N0c2ZT79p4U5Bu+ita52Qiem6D2A8qM/Ze
         Iqpw==
X-Gm-Message-State: APjAAAUfZU3Mo6hwqAXyiK4Smv6TydVr0ZCCSQZoUqmLd5Jd1mCgHgb0
        wESv5g+9BuSY/tPjOhN9u+ID
X-Google-Smtp-Source: APXvYqw9rMIFwwqdxrvuBXR2v8TtRdN01FhpwJvilCA3YK65zchcK4BySx9O0xF+Ja9+rLA9jGausw==
X-Received: by 2002:a17:902:543:: with SMTP id 61mr38996508plf.20.1566475223827;
        Thu, 22 Aug 2019 05:00:23 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id a6sm3252534pjv.30.2019.08.22.05.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 05:00:23 -0700 (PDT)
Date:   Thu, 22 Aug 2019 22:00:17 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        riteshh@linux.ibm.com, hch@infradead.org
Subject: Re: [PATCH 0/5] ext4: direct IO via iomap infrastructure
Message-ID: <20190822120015.GA3330@poseidon.bobrowski.net>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <20190812173150.AF04F5204F@d06av21.portsmouth.uk.ibm.com>
 <20190813111004.GA12682@poseidon.bobrowski.net>
 <20190813122723.AE6264C040@d06av22.portsmouth.uk.ibm.com>
 <20190821131405.GC24417@poseidon.bobrowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821131405.GC24417@poseidon.bobrowski.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 21, 2019 at 11:14:07PM +1000, Matthew Bobrowski wrote:
> On Tue, Aug 13, 2019 at 05:57:22PM +0530, RITESH HARJANI wrote:
> > But what I meant was this (I may be wrong here since I haven't
> > really looked into it), but for my understanding I would like to
> > discuss this -
> > 
> > So earlier with this flag(EXT4_STATE_DIO_UNWRITTEN) we were determining on
> > whether a newextent can be merged with ex1 in function
> > ext4_extents_can_be_merged. But now since we have removed that flag we have
> > no way of knowing that whether this inode has any unwritten extents or not
> > from any DIO path.
> > 
> > What I meant is isn't this removal of setting/unsetting of
> > flag(EXT4_STATE_DIO_UNWRITTEN) changing the behavior of this func -
> > ext4_extents_can_be_merged?
> 
> OK, I'm stuck and looking for either clarity, revalidation of my
> thought process, or any input on how to solve this problem for that
> matter.
> 
> In the current ext4 direct IO implementation, the dynamic state flag
> EXT4_STATE_DIO_UNWRITTEN is set/unset for synchronous direct IO
> writes. On the other hand, the flag EXT4_IO_END_UNWRITTEN is set/unset
> for ext4_io_end->flag, and the value of i_unwritten is
> incremented/decremented for asynchronous direct IO writes. All
> mechanisms by which are used to track and determine whether the inode,
> or an IO in flight against a particular inode have any pending
> unwritten extents that need to be converted after the IO has
> completed. In addition to this, we have ext4_can_extents_be_merged()
> performing explicit checks against both EXT4_STATE_DIO_UNWRITTEN and
> i_unwritten and using them to determine whether it can or cannot merge
> a requested extent into an existing extent.
> 
> This is all fine for the current direct IO implementation. However,
> while switching the direct IO code paths over to make use of the iomap
> infrastructure, I believe that we can no longer simply track whether
> an inode has unwritten extents needing to be converted by simply
> setting and checking the EXT4_STATE_DIO_UNWRITTEN flag on the
> inode. The reason being is that there can be multiple direct IO
> operations to unwritten extents running against the inode and we don't
> particularly distinguish synchronous from asynchronous writes within
> ext4_iomap_begin() as there's really no need. So, the only way to
> accurately determine whether extent conversion is deemed necessary for
> an IO operation whether it'd be synchronous or asynchronous is by
> checking the IOMAP_DIO_UNWRITTEN flag within the ->end_io()
> callback. I'm certain that this portion of the logic is correct, but
> we're still left with some issues when it comes to the checks that I
> previously mentioned in ext4_can_extents_be_merged(), which is the
> part I need some input on.
> 
> I was doing some thinking and I don't believe that making use of the
> EXT4_STATE_DIO_UNWRITTEN flag is the solution at all here. This is not
> only for reasons that I've briefly mentioned above, but also because
> of the fact that it'll probably lead to a lot of inaccurate judgements
> while taking particular code paths and some really ugly code that
> creeps close to the definition of insanity. Rather, what if we solve
> this problem by continuing to just use i_unwritten to keep track of
> all the direct IOs to unwritten against running against an inode?
> Within ext4_iomap_begin() post successful creation of unwritten
> extents we'd call atomic_inc(&EXT4_I(inode)->i_unwritten) and
> subsequently within the ->end_io() callback whether we take the
> success or error path we'd call
> atomic_dec(&EXT4_I(inode)->i_unwritten) accordingly? This way we can
> still rely on this value to be used in the check within
> ext4_can_extents_be_merged(). Open for alternate suggestions if anyone
> has any...

Actually, no...

I've done some more thinking and what I suggested above around the use
of i_unwritten will also not work properly. Using iomap
infrastructure, there is the possibility of calling into the
->iomap_begin() more than once for a single direct IO operation. This
means that by the time we even get to decrementing i_unwritten in the
->end_io() callback after converting the unwritten extents we're
already running the possibility of i_unwritten becoming unbalanced
really quickly and staying that way. This also means that the
statement checking i_unwritten in ext4_can_extents_be_merged() will be
affected and potentially result in it being evaluated incorrectly. I
was thinking that we could just decrement i_unwritten in
->iomap_end(), but that seems to me like it would be racy and also
lead to incorrect results. At this point I'm out of ideas on how to
solve this, so any other ideas would be appreciated!

--M
