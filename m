Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BC57DC285
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Oct 2023 23:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjJ3WhT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Oct 2023 18:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjJ3WhS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Oct 2023 18:37:18 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC7310B
        for <linux-ext4@vger.kernel.org>; Mon, 30 Oct 2023 15:37:14 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6ba172c5f3dso4457612b3a.0
        for <linux-ext4@vger.kernel.org>; Mon, 30 Oct 2023 15:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1698705434; x=1699310234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s3l/lL5wYf4n3GthHM0NoG2tR/ievkKXd51rX7QyzCg=;
        b=YZJJRKmpYSheU+R2mseNAMbeGSdPJLFe40wCupbHYAd3o4QvZNI/n7SGn2r5cooFgq
         2TEcO78mRTQJBTq7k2LqUtVvJres5aMQhj3nULXOrrdnw3Gj9/WT+z7z2ABtzED7KsbV
         ekC9YAJYeG7FVFi/CvzzPWQPOAWd7xX/xs+NjEVXTta0c+tu9fOv2E6WvTvGDYo0G3A3
         nk/n2nXjoAIwMY394rKnbmnbD9xeR0wGUW/4HzwyTv9RhbV1nF/lk2rhXLia5gW1lDor
         Xwl91GIsakdFQ/xOsemb/k2wPINm34d+665mfEqcz2YTJlkO8PHNhrdA0s286qBDrOO7
         /l3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698705434; x=1699310234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3l/lL5wYf4n3GthHM0NoG2tR/ievkKXd51rX7QyzCg=;
        b=BPBEr0wE+n8um5/CobWONHeVlZFewQHUFABKQel42kdxJrFUQu/aD67+67aTPJ+CqK
         2AmDoP7CNrPOirLASfg9Gg9pdBrEUIBXFq9x2+gkYrPy4pmUpQDsklgVD2drfy7d8xZi
         lT5kygCu407g71fajlgjA53K9iHWo4insmPb41dEPf57yQ9ZF4N/BYF08YfptfQl3WC2
         Bxatb8ifhQGZj04W8QcfsJmqh02mKmn2qFG9EcHRt5H94tAm174yFxt1m4SEGDNyD0Cc
         2MTlmeTaFkMCIa4MvlXQPR0jpPI6X+K54xGOeO55FXcl4TArFe5EiMxX1NQm97TDT430
         M22g==
X-Gm-Message-State: AOJu0YwzON9FALBVry+Y11Xj0IFfX+bVqMRzaRHm6btbL0fsqpTdc42t
        lwx5/wViIAuRn5ajnyJ50bWZeA==
X-Google-Smtp-Source: AGHT+IH220teegvrDu5BQvWXj+pfKEIBe9mpI/qNDn7XBuC5Q1LlqBFVtPwA3Li0K8x18IiaaOOLaQ==
X-Received: by 2002:a05:6a21:6da1:b0:175:7085:ba18 with SMTP id wl33-20020a056a216da100b001757085ba18mr9996599pzb.58.1698705434041;
        Mon, 30 Oct 2023 15:37:14 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id p11-20020a17090a2d8b00b002774d7e2fefsm2932pjd.36.2023.10.30.15.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 15:37:13 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qxasg-0066We-2r;
        Tue, 31 Oct 2023 09:37:10 +1100
Date:   Tue, 31 Oct 2023 09:37:10 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.de>, David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
Message-ID: <ZUAwFkAizH1PrIZp@dread.disaster.area>
References: <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
 <ZTcBI2xaZz1GdMjX@dread.disaster.area>
 <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
 <ZTc8tClCRkfX3kD7@dread.disaster.area>
 <CAOQ4uxhJGkZrUdUJ72vjRuLec0g8VqgRXRH=x7W9ogMU6rBxcQ@mail.gmail.com>
 <d539804a2a73ad70265c5fa599ecd663cd235843.camel@kernel.org>
 <ZTjMRRqmlJ+fTys2@dread.disaster.area>
 <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
 <ZTnNCytHLGoJY9ds@dread.disaster.area>
 <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 27, 2023 at 06:35:58AM -0400, Jeff Layton wrote:
> On Thu, 2023-10-26 at 13:20 +1100, Dave Chinner wrote:
> > On Wed, Oct 25, 2023 at 08:25:35AM -0400, Jeff Layton wrote:
> > > On Wed, 2023-10-25 at 19:05 +1100, Dave Chinner wrote:
> > > > On Tue, Oct 24, 2023 at 02:40:06PM -0400, Jeff Layton wrote:
> > > In earlier discussions you alluded to some repair and/or analysis tools
> > > that depended on this counter.
> > 
> > Yes, and one of those "tools" is *me*.
> > 
> > I frequently look at the di_changecount when doing forensic and/or
> > failure analysis on filesystem corpses.  SOE analysis, relative
> > modification activity, etc all give insight into what happened to
> > the filesystem to get it into the state it is currently in, and
> > di_changecount provides information no other metadata in the inode
> > contains.
> > 
> > > I took a quick look in xfsprogs, but I
> > > didn't see anything there. Is there a library or something that these
> > > tools use to get at this value?
> > 
> > xfs_db is the tool I use for this, such as:
> > 
> > $ sudo xfs_db -c "sb 0" -c "a rootino" -c "p v3.change_count" /dev/mapper/fast
> > v3.change_count = 35
> > $
> > 
> > The root inode in this filesystem has a change count of 35. The root
> > inode has 32 dirents in it, which means that no entries have ever
> > been removed or renamed. This sort of insight into the past history
> > of inode metadata is largely impossible to get any other way, and
> > it's been the difference between understanding failure and having no
> > clue more than once.
> > 
> > Most block device parsing applications simply write their own
> > decoder that walks the on-disk format. That's pretty trivial to do,
> > developers can get all the information needed to do this from the
> > on-disk format specification documentation we keep on kernel.org...
> > 
> 
> Fair enough. I'm not here to tell you that you guys that you need to
> change how di_changecount works. If it's too valuable to keep it
> counting atime-only updates, then so be it.
> 
> If that's the case however, and given that the multigrain timestamp work
> is effectively dead, then I don't see an alternative to growing the on-
> disk inode. Do you?

Yes, I do see alternatives. That's what I've been trying
(unsuccessfully) to describe and get consensus on. I feel like I'm
being ignored and rail-roaded here, because nobody is even
acknowledging that I'm proposing alternatives and keeps insisting
that the only solution is a change of on-disk format.

So, I'll summarise the situation *yet again* in the hope that this
time I won't get people arguing about atime vs i-version and what
constitutes an on-disk format change because that goes nowhere and
does nothing to determine which solution might be acceptible.

The basic situation is this:

If XFS can ignore relatime or lazytime persistent updates for given
situations, then *we don't need to make periodic on-disk updates of
atime*. This makes the whole problem of "persistent atime update bumps
i_version" go away because then we *aren't making persistent atime
updates* except when some other persistent modification that bumps
[cm]time occurs.

But I don't want to do this unconditionally - for systems not
running anything that samples i_version we want relatime/lazytime
to behave as they are supposed to and do periodic persistent updates
as per normal. Principle of least surprise and all that jazz.

So we really need an indication for inodes that we should enable this
mode for the inode. I have asked if we can have per-operation
context flag to trigger this given the needs for io_uring to have
context flags for timestamp updates to be added. 

I have asked if we can have an inode flag set by the VFS or
application code for this. e.g. a flag set by nfsd whenever it accesses a
given inode.

I have asked if this inode flag can just be triggered if we ever see
I_VERSION_QUERIED set or statx is used to retrieve a change cookie,
and whether this is a reliable mechanism for setting such a flag.

I have suggested mechanisms for using masked off bits of timestamps
to encode sub-timestamp granularity change counts and keep them
invisible to userspace and then not using i_version at all for XFS.
This avoids all the problems that the multi-grain timestamp
infrastructure exposed due to variable granularity of user visible
timestamps and ordering across inodes with different granularity.
This is potentially a general solution, too.

So, yeah, there are *lots* of ways we can solve this problem without
needing to change on-disk formats.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
