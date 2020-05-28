Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC281E52B4
	for <lists+linux-ext4@lfdr.de>; Thu, 28 May 2020 03:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgE1BM0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 May 2020 21:12:26 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59460 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725294AbgE1BM0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 May 2020 21:12:26 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04S1CLnC022045
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 21:12:21 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 15279420304; Wed, 27 May 2020 21:12:21 -0400 (EDT)
Date:   Wed, 27 May 2020 21:12:21 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jonny Grant <jg@jguk.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: /fs/ext4/namei.c ext4_find_dest_de()
Message-ID: <20200528011221.GC228632@mit.edu>
References: <2edc7d6a-289e-57ad-baf1-477dc240474d@jguk.org>
 <20200504015122.GB404484@mit.edu>
 <e6e172ae-ba19-f303-3aa9-a388adba8cb0@jguk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6e172ae-ba19-f303-3aa9-a388adba8cb0@jguk.org>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 27, 2020 at 10:25:43PM +0100, Jonny Grant wrote:
> 
> 
> How about adding an improved mkdir to POSIX and the Linux kernel? Let's call it mkdir2()
> 
> It has one more error, for EISDIR
> 
> [EEXIST]
> The named file exists.
> 
> [EISDIR]
> Directory with that name exists.

It's *really* not worth it.

You seem to really care about this; why don't you just keep your own
version of shellutils which calls stat(1) if you get EEXIST and to
distinguish between these two cases?

I know the shellutils maintainers has rejected this.  But that's OK,
you can have your own copy on your systems.  You might want to reflect
that if the shellutils maintainer refused to add the stat(1) on the
error path, what makes you think they will accept a change to use a
non-standard mkdir2() system call?

If you want to try to convince Austin Common Standards Revision Group
that it's worth it to mandate a whole new system call *just* for a new
error code, you're welcome to try.  I suspect you will not get a good
reception, and even if you did, Linux VFS maintainer may well very
well deride the proposal as silly, and refuse to follow the lead of
the Austin group.  In fact, Al Viro is very likely not to be as
politic as I have been.  (It's likely the response would have included
things like "idiotic idea" and "stupid".)

> I'm tempted to suggest this new function mkdir2() returns 0 on success, or
> an error number directly number. That would do away with 'errno' for this as
> well.

This is not going to get a good reception from either Al or the Austin
Group, I predict.  If you really have strong ideas of what you think
an OS and its interfaces should look like, perhaps you should just
design your own OS from scratch.

Best regards,

						- Ted
