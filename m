Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E438D34EF37
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Mar 2021 19:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhC3RTH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 Mar 2021 13:19:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232001AbhC3RSk (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 30 Mar 2021 13:18:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80ACD619CC;
        Tue, 30 Mar 2021 17:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617124720;
        bh=+XMjxrroXSwLBHtQFILYA5xE73A5AXjqXa7+B9Zzmxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gNK6IZN3p5ky1I8GTXE9RT6QRDn97f3hYopzvfWWLe+iBAIQBl/2aEuU3sPOeqC3X
         NIPfC2ehcXGIWfX9qACcYEBf7b6MxnnO15rtgdiIiQR3z35OPXwUPJOp6rcoM4hT51
         ktiPtJgh+a4xPQMl4d3ERRDWeTRXhWIxRoqZAqAnqXo9WgNvn4ebFAII1+7FOYu/jE
         PCEnZhZcRHckGGdotmuyjlGE0eWislirUYZ5IxuTtj5zjn7om90w6Yl92eHiYD7E0r
         zPyElUPCHk/V92Hijb5hrfnZqwW4PoTrB7DgXku3rortC8l/McXuS4zrlcYjldKe4t
         S4i3+/atIVDHA==
Date:   Tue, 30 Mar 2021 10:18:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 2/2] ext4: add ioctl EXT4_FLUSH_JOURNAL
Message-ID: <20210330171839.GF22091@magnolia>
References: <20210325181220.1118705-1-leah.rumancik@gmail.com>
 <20210325181220.1118705-2-leah.rumancik@gmail.com>
 <20210326012146.GB22091@magnolia>
 <YGHtC4vEWcRervi1@google.com>
 <CAD+ocbx-DZprEvzSQ2+rVFz6CPJy0iYbG60SGZHpi+ZX8ecqhg@mail.gmail.com>
 <20210330163223.GD22091@magnolia>
 <YGNcnJpqUqrwbMAH@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGNcnJpqUqrwbMAH@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Mar 30, 2021 at 01:15:08PM -0400, Theodore Ts'o wrote:
> On Tue, Mar 30, 2021 at 09:32:23AM -0700, Darrick J. Wong wrote:
> > Why not make discarding the journal part of FITRIM then?
> 
> Unfortunately, the fstrim_range structure doesn't have a place for a
> flags field, and FITRIM works by specifying a range of LBA's:
> 
> struct fstrim_range {
> 	__u64 start;
> 	__u64 len;
> 	__u64 minlen;
> };
> 
> I suppose we could do something where some combination of start/len
> means "also checkpoint and discard the journal", but that seems rather
> kludgy.
> 
> > It occurred to me overnight that another way to look at this ioctl
> > proposal is that it checkpoints the filesystem and has a flag to discard
> > the journal blocks too.  Given that we're now only two days away from
> > my traditional bootfs[1] drum-banging day, and there's real user
> > demand[2] for bootloaders to be able to force a journal checkpoint,
> 
> How about if we have an ioctl which is "checkpoint journal", which can
> be file system independent (e.g., defined in include/uapi/linux/fs.h)
> which takes a u32 flags field, where we define a flag bit to mean
> "also discard the unused part of the journal after the checkpoint"?
> 
> It seems that would also solve your bootfs() use case.

Yeah, that's where I was going with this.  I just sent a new review for
the other patch with that level of focus. :)

--D

>       	      	  	      	     - Ted
