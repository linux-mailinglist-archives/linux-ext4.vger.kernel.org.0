Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9352589B2F
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Aug 2022 13:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbiHDLru (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Aug 2022 07:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiHDLrt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Aug 2022 07:47:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC4061FCF9
        for <linux-ext4@vger.kernel.org>; Thu,  4 Aug 2022 04:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659613667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qtFxOvBRs9Gxhh1dvT6PmN0fYehN1Nj3ARoTBZDprNI=;
        b=Nfd6Pm9YW2cu6Bp8pMFPC1q5wESm0y8FcEy/3tRyxwBH7wS7gzBstMgFunWXQMWwot8XxR
        PFQ4iUG7E8GK5DoXJ7B0oi1vxW4KDsuLLFh0yw2jqziArbmTf4Pe9VxpNMgUVeE+Hr+t1H
        5famf4WV80uBxA9K8Hzyajz8NqIMiJs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-vnskG869PFaB1mUGaJgZZA-1; Thu, 04 Aug 2022 07:47:43 -0400
X-MC-Unique: vnskG869PFaB1mUGaJgZZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3EFD101A54E;
        Thu,  4 Aug 2022 11:47:42 +0000 (UTC)
Received: from fedora (unknown [10.40.193.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FD7C1410DDA;
        Thu,  4 Aug 2022 11:47:42 +0000 (UTC)
Date:   Thu, 4 Aug 2022 13:47:39 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     bugzilla-daemon@kernel.org
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [Bug 216322] Freezing of tasks failed after 60.004 seconds (1
 tasks refusing to freeze... task:fstrim  ext4_trim_fs - Dell XPS 13 9310
Message-ID: <20220804114739.mnmtm2l7r7x5pdi7@fedora>
References: <bug-216322-13602@https.bugzilla.kernel.org/>
 <bug-216322-13602-8CEcnRTAPy@https.bugzilla.kernel.org/>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-216322-13602-8CEcnRTAPy@https.bugzilla.kernel.org/>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 04, 2022 at 12:44:45AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=216322
> 
> Theodore Tso (tytso@mit.edu) changed:
> 
>            What    |Removed                     |Added
> ----------------------------------------------------------------------------
>                  CC|                            |tytso@mit.edu
> 
> --- Comment #2 from Theodore Tso (tytso@mit.edu) ---
> So the problem is that the FITRIM ioctl does not check if a signal is pending,
> and so if the fstrim program requests that the entire SSD (len=ULLONG_MAX),
> like the broomstick set off by Mickey Mouse in Fantasia's "Sorcerer's
> Apprentive", it will mindlessly send discard requests for any blocks not in use
> by the file system until it is done.   Or to put it another way, "Neither rain,
> nor snow, or a request to freeze the OS, shall stop the FITRIM ioctl from its
> appointed task."  :-)
> 
> The question is how to fix things.   The problem is that the FITRIM ioctl
> interface is pretty horrible.   The fstrim_range.len variable is an IN/OUT
> field where on the input it is the number of bytes that should be trimmed (from
> start to start+len) and when the ioctl returns fstrm_range.len is the number of
> bytes that were actually trimmed.   So this is not really amenable for
> -ERESTARTSYS.
> 
> Worse, the fstrim program in util-linux doesn't handle an EAGAIN error return
> code, so if it gets the EAGAIN after try_to_freeze_tasks send the fake signal
> to the process, fstrim will print to stderr "fstrim: FITRIM ioctl failed" and
> the rest of the file system trim operation will be aborted.
> 
> It might be that the only way we can fix this is to have FITRIM return EAGAIN,
> which will stop the fstrim in its tracks.  This is... not great, but typically
> fstrim is run out of crontab or a systemd timer once a month, so if the user
> tries to suspend right as the fstrim is running, hopefully we'll get lucky next
> month.    We can then try teach fstrim to do the right thing, and so this
> lossage mode would only happen in the combination of a new kernel and an older
> version of util-linux.
> 
> I'm not happy with that solution, but the alternative of creating a new FITRIM2
> ioctl that has a sane interface means that you need an new kernel and a new
> util-linux package, and if you don't, the user will have to deal with a hot
> laptop bag and a drained battery.   And not changing FITRIM's behaviour will
> have the same potential end result, if the user gets unlucky and tries to
> suspend the laptop when there is more than 60 seconds left before FITRIM to
> complete.   :-/
> 
> The other thing I'll note is that every file system has its own FITRIM
> implementation, and I suspect they all have this issue, because the FITRIM
> interface is fundamentally flawed.

I agree that the FITRIM interface is flawed in this way. But
ext4_try_to_trim_range() actually does have fatal_signal_pending() and
will return -ERESTARTSYS if that's true. Or did you have something else in
mind?

Also in that case, I see no reason why we would not be able to adjust
the fstrim_range to make it easier to re-start where we left off if
we're going to return -ERESTARTSYS. I am missing something?

I have not had time to look deeply into the traces, but are you actually
sure that we're not stuck in blkdev_issue_discard() instead?

-Lukas

