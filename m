Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5967DD95B
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Nov 2023 00:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376889AbjJaXr1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Oct 2023 19:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376331AbjJaXr1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 Oct 2023 19:47:27 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09B1F3
        for <linux-ext4@vger.kernel.org>; Tue, 31 Oct 2023 16:47:23 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso6227739b3a.2
        for <linux-ext4@vger.kernel.org>; Tue, 31 Oct 2023 16:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1698796043; x=1699400843; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LL8tYW50Kf6aNPlxTNrj3Zv6ugWw5JL8Pwwf5RV47qU=;
        b=zIBHlVEKP/FjOQzFg2UuJA/Q5DNFbiT+htmYaqlFA20JCJ5QrCBQm6N3xXgWoeLwds
         4SsbXX+92XauhZQ+7rfUccSjn/3kypQEjdTpK5l9B8YrqXokQqrBDHEqOSWKJlO55vBQ
         4bR5Hdf4rku9hz3U4PGPN6uR3/Zh230hxT3lYbq+yb/2sxawBAO8wp5Yb0TeekVEoSdj
         TbR0PlszfLIFEz9xTE5RyZYcUv+gEEpmDFEUZ7UruPnGcfjDPEQpAtkJnd9V6iXcHEEl
         sQeTAQb+P0hU9u/zveee1e0iZ3rZzIpnA4DpSzeY6fJRe5HYNgDhg4ejwBgtaaSdO+NL
         uERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698796043; x=1699400843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LL8tYW50Kf6aNPlxTNrj3Zv6ugWw5JL8Pwwf5RV47qU=;
        b=q82bVdKU7VJ/K+25flihNWsMEzmgFMdzKfEqO14CESNMuZKgu1I5WgWbt+PsRsYn6W
         9YcjGZu6HoClVILY+ZktjrJyT2a0BirhvEf52Ve8vWJbkJ30Lx3taQ4e/J+mykpJDJgl
         RTEPxudMizuojeDaPhekT5Q/DvxWo4CTJL3VA3X5U1tSlol+7kSvBO9EqHRXSpiXwPTE
         YNEcltiiPUMQw721kBjw+UB8EQdpR9r1ihoBO+xcMVnpRsb0oM850V6KWwLBxVif000Y
         hBz3NFragWs/YQYx8CQodeX57ucDV8HGH5gimZrhGTUMcCToS9+3TGOHin6T9FrTY7q/
         owdw==
X-Gm-Message-State: AOJu0YzmgqTDjS6qzOOQcIPbCW2robMPCC7rvp+1SiMCL7gTgYNuytkH
        X4p9cmoHFgS+OA1lKopXnhNUww==
X-Google-Smtp-Source: AGHT+IG0Ny9Z2Xdu0995f1HPr5AykcrHAfoUPqFEd6JDhsfJl5wm1cwFJ4giSGoazkZucS2Diz+3Eg==
X-Received: by 2002:a05:6a21:78a4:b0:16b:846a:11b1 with SMTP id bf36-20020a056a2178a400b0016b846a11b1mr17455016pzc.32.1698796043058;
        Tue, 31 Oct 2023 16:47:23 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id c25-20020a637259000000b0058a9621f583sm1537767pgn.44.2023.10.31.16.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 16:47:22 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qxyS7-006YqP-22;
        Wed, 01 Nov 2023 10:47:19 +1100
Date:   Wed, 1 Nov 2023 10:47:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
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
Message-ID: <ZUGSB4DhY4mNazz6@dread.disaster.area>
References: <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
 <ZTnNCytHLGoJY9ds@dread.disaster.area>
 <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
 <ZUAwFkAizH1PrIZp@dread.disaster.area>
 <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
 <ZUBbj8XsA6uW8ZDK@dread.disaster.area>
 <CAOQ4uxgSRw26J+MPK-zhysZX9wBkXFRNx+n1bwnQwykCJ1=F4Q@mail.gmail.com>
 <3d6a4c21626e6bbb86761a6d39e0fafaf30a4a4d.camel@kernel.org>
 <ZUF4NTxQXpkJADxf@dread.disaster.area>
 <20231031230242.GC1205143@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231031230242.GC1205143@frogsfrogsfrogs>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 31, 2023 at 04:02:42PM -0700, Darrick J. Wong wrote:
> On Wed, Nov 01, 2023 at 08:57:09AM +1100, Dave Chinner wrote:
> > On Tue, Oct 31, 2023 at 07:29:18AM -0400, Jeff Layton wrote:
> > > On Tue, 2023-10-31 at 09:03 +0200, Amir Goldstein wrote:
> > > > On Tue, Oct 31, 2023 at 3:42 AM Dave Chinner <david@fromorbit.com> wrote:
> > e.g. the current code flow for an atime update is:
> > 
> > touch_atime()
> >   atime_needs_update()
> >   <freeze/write protection>
> >   inode_update_time(S_ATIME)
> >     ->update_time(S_ATIME)
> >       <filesystem atime update>
> > 
> > I'd much prefer this to be:
> > 
> > touch_atime()
> >   if (->update_time(S_ATIME)) {
> >     ->update_time(S_ATIME)
> >       xfs_inode_update_time(S_ATIME)
> >         if (atime_needs_update())
> > 	  <filesystem atime update>
> >   } else {
> >     /* run the existing code */
> >   }
> > 
> > Similarly we'd turn file_modified()/file_update_time() inside out,
> > and this then allows the filesystem to add custom timestamp update
> > checks alongside the VFS timestamp update checks.
> > 
> > It would also enable us to untangle the mess that is lazytime, where
> > we have to implement ->update_time to catch lazytime updates and
> > punt them back to generic_update_time(), which then has to check for
> > lazytime again to determine how to dirty and queue the inode.
> > Of course, generic_update_time() also does timespec_equal checks on
> > timestamps to determine if times should be updated, and so we'd
> > probably need overrides on that, too.
> 
> Hmm.  So would the VFS update the incore timestamps of struct inode in
> whatever manner it wants?

That's kind of what I want to avoid - i want the filesystem to
direct the VFS as to the type of checks and modifications it can
make.

e.g. the timestamp comparisons and actions taken need to be
different for a timestamp-with-integrated-change-counter setup. It
doesn't fold neatly into inode_needs_update_time() - it becomes a
branchy, unreadable mess trying to handle all the different
situations.

Hence the VFS could provide two helpers - one for the existing
timestamp format and one for the new integrated change counter
timestamp. The filesystem can then select the right one to call.

And, further, filesystems that have lazytime enabled should be
checking that early to determine what to do. Lazytime specific
helpers would be useful here.

> Could that include incrementing the lower
> bits of i_ctime.tv_nsec for filesystems that advertise a non-1nsec
> granularity but also set a flag that effectively means "but you can use
> the lower tv_nsec bits if you want"?

Certainly. Similar to multi-grain timestamps, I don't see anything
filesystem specific about this mechanism. I think that anyone saying
"it's ok if it's internal to XFS" is still missing the point that
i_version as a VFS construct needs to die.

At most, i_version is only needed for filesystems that don't have
nanosecond timestamp resolution in their on-disk format and so need
some kind of external ctime change counter to provide fine-grained,
sub-timestamp granularity change recording.

> And perhaps after all that, the VFS should decide if a timestamp update
> needs to be persisted (e.g. lazytime/nodiratime/poniesatime) and if so,
> call ->update_time or __mark_inode_dirty?  Then XFS doesn't have to know
> about all the timestamp persistence rules, it just has to follow
> whatever the VFS tells it.

Sure. I'm not suggesting that the filesystem duplicate and encode
all these rules itself.

I'm just saying that it seems completely backwards that the VFS
encode all this generic logic to handle all these separate cases in
a single code path and then provides a callout that allows the
filesystem to override it's decisions (e.g. lazytime) and do
something else.

The filesystem already knows exactly what specific subset of checks
and updates need to be done so call ou tinto the filesystem first
and then run the VFS helpers that do exactly what is needed for
relatime, lazytime, using timestamps with integrated change
counters, etc.

> > Sorting the lazytime mess for internal change counters really needs
> > for all the timestamp updates to be handled in the filesystem, not
> > bounced back and forward between the filesystem and VFS helpers as
> > it currently is, hence I think we need to rework ->update_time to
> > make this all work cleanly.
> 
> (Oh, I guess I proposed sort of the opposite of what you just said.)

Not really, just seems you're thinking about how to code all the
VFS helpers we'd need a bit differently...

Cheers,

Dav.e
-- 
Dave Chinner
david@fromorbit.com
