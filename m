Return-Path: <linux-ext4+bounces-219-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEA37FD244
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Nov 2023 10:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601F31C21129
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Nov 2023 09:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB681401E;
	Wed, 29 Nov 2023 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="wXZkUyYe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74623120
	for <linux-ext4@vger.kernel.org>; Wed, 29 Nov 2023 01:19:14 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cfd04a6e49so5481585ad.0
        for <linux-ext4@vger.kernel.org>; Wed, 29 Nov 2023 01:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701249554; x=1701854354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kDIfQHNjH7C+lwoxAktiRL7yGqqoT1qjb9J4O7HkJOI=;
        b=wXZkUyYeznRVMjwuh4aGZhZR6uc+8mYJlPZzrcDHmX99Pexr4wCAZAJHsjO8GlxGRc
         xwl0RBU9nKfUCx1wrHuKWp5JeHhjdKwmMb4QXjjvJLPYye8XyPy7ePN1BFH/N4KbHR0J
         y2h9N1HpkvzsJsbgzEIceHAPZm+U9NHhfyuvySwMyTkIh6ZG+oSJBk0beGux6Bqx940H
         ZdKyRS1DiqWHDTl4E+d4GLEEr8UMmwc1sjCnmt0Bw6IWZqdvH43oCvoGKg4iGFADv7uh
         6FG/uMHDnBlq/SUyi/Am1DhKR0aWEMkuP6adckMhdcirNuU0KCHTXHYz/XjKn2os78fA
         xDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701249554; x=1701854354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDIfQHNjH7C+lwoxAktiRL7yGqqoT1qjb9J4O7HkJOI=;
        b=vjVt8INxj2zaW2hGTFgMA7n0AltTLxS9QbV3WwJ6xkAsl6uXk88BG2JIbOs9y6/Niv
         wgLeXY5kauPqXCLzf8y+U3TMhqSHDjP2aoBZlgpaavt/vAw7LOnekZtsQWn6dm4E/0F0
         h5VSQdU5a7w4Ev1zzUnEU7ltiB6chUj9R77Pw/eLm1a46RYyduTmRNExmDxS7S4x5LyX
         lDQFMPyco25hkBUi6For75y0idPrjcKk0ZxB9WQAEqMPe56ikW6ns9IF2etEXs+mPMkn
         HRLm0e12fugmuz7MV3EzRzPxoF20gR0dXRAxZJSm7wWo4Ke1FkhfSYhl9zo5vHEFClnn
         wzEw==
X-Gm-Message-State: AOJu0YyGCj+kqMw8jWAKZmDfWY4oPqjhnqypvrtOvEuvTbQ2Hz65Q5Yq
	kCl/D+a5z793chmYfkYoxL+vBw==
X-Google-Smtp-Source: AGHT+IH+Q9Mk2zZ/hM6RFOvU0zp9PSaPLYSma7jinE3WVBm+C1dzY+D7KkWBqgw0SxkehtA8p0BOng==
X-Received: by 2002:a17:902:db0d:b0:1cf:cb80:3fa5 with SMTP id m13-20020a170902db0d00b001cfcb803fa5mr15125946plx.23.1701249553908;
        Wed, 29 Nov 2023 01:19:13 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id jb1-20020a170903258100b001cfbe348ca5sm7142503plb.187.2023.11.29.01.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 01:19:13 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1r8Git-001Rpe-0n;
	Wed, 29 Nov 2023 20:19:11 +1100
Date: Wed, 29 Nov 2023 20:19:11 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use
 iomap
Message-ID: <ZWcCDymE4YBrsRUz@dread.disaster.area>
References: <cover.1700506526.git.ritesh.list@gmail.com>
 <f5e84d3a63de30def2f3800f534d14389f6ba137.1700506526.git.ritesh.list@gmail.com>
 <20231122122946.wg3jqvem6fkg3tgw@quack3>
 <ZV399sCMq+p57Yh3@infradead.org>
 <ZV6AJHd0jJ14unJn@dread.disaster.area>
 <20231123040944.GB36168@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123040944.GB36168@frogsfrogsfrogs>

On Wed, Nov 22, 2023 at 08:09:44PM -0800, Darrick J. Wong wrote:
> On Thu, Nov 23, 2023 at 09:26:44AM +1100, Dave Chinner wrote:
> > On Wed, Nov 22, 2023 at 05:11:18AM -0800, Christoph Hellwig wrote:
> > > On Wed, Nov 22, 2023 at 01:29:46PM +0100, Jan Kara wrote:
> > > > writeback bit set. XFS plays the revalidation sequence counter games
> > > > because of this so we'd have to do something similar for ext2. Not that I'd
> > > > care as much about ext2 writeback performance but it should not be that
> > > > hard and we'll definitely need some similar solution for ext4 anyway. Can
> > > > you give that a try (as a followup "performance improvement" patch).
> > > 
> > > Darrick has mentioned that he is looking into lifting more of the
> > > validation sequence counter validation into iomap.
> > 
> > I think that was me, as part of aligning the writeback path with
> > the ->iomap_valid() checks in the write path after we lock the folio
> > we instantiated for the write.
> > 
> > It's basically the same thing - once we have a locked folio, we have
> > to check that the cached iomap is still valid before we use it for
> > anything.
> > 
> > I need to find the time to get back to that, though.
> 
> Heh, we probably both have been chatting with willy on and off about
> iomap.
> 
> The particular idea I had is to add a u64 counter to address_space that
> we can bump in the same places where we bump xfs_inode_fork::if_seq
> right now..  ->iomap_begin would sample this address_space::i_mappingseq
> counter (with locks held), and now buffered writes and writeback can
> check iomap::mappingseq == address_space::i_mappingseq to decide if it's
> time to revalidate.

Can't say I'm a great fan of putting filesystem physical extent map
state cookies in the page cache address space.

One of the primary architectural drivers for iomap was to completely
separate the filesystem extent mapping information from the page
cache internals and granularities, so this kinda steps over an
architectural boundary in my mind.

Also, filesystem mapping operations move further away from the VFS
structures into deep internal filesystem - they do not interact with
the page cache structures at all. Hence requiring physical extent
mapping operations have to poke values in the page cache address
space structure just seems like unnecessarily long pointer chasing
to me.

That said, I have no problesm with extent sequence counters in the
VFS inode, but I just don't think it belongs in the page cache
address space....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

