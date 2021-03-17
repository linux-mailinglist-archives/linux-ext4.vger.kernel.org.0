Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77FA33F642
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Mar 2021 18:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhCQRGP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Mar 2021 13:06:15 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44665 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229591AbhCQRGE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 17 Mar 2021 13:06:04 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 12HH5xxj031661
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Mar 2021 13:06:00 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A6E9F15C39C8; Wed, 17 Mar 2021 13:05:59 -0400 (EDT)
Date:   Wed, 17 Mar 2021 13:05:59 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Shashidhar Patil <shashidhar.patil@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: jbd2 task hung in jbd2_journal_commit_transaction
Message-ID: <YFI299oMXylsG9kB@mit.edu>
References: <CADve3d51po2wh6rmgrzM8-k9h=JzE9+mC57Y5V2BxfFkKPFMsw@mail.gmail.com>
 <YEtjuGZCfD+7vCFd@mit.edu>
 <CADve3d7bioEAMwQ=i8KZ=hjrBDMk7gJK8kTUu2E5Q=W_KbUMPg@mail.gmail.com>
 <YE2FOTpWOaidmT52@mit.edu>
 <CADve3d4h7QmxJUCe8ggHtSb41PbDnvZoj4_m74hHgYD96xjZNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADve3d4h7QmxJUCe8ggHtSb41PbDnvZoj4_m74hHgYD96xjZNw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 17, 2021 at 08:30:56PM +0530, Shashidhar Patil wrote:
> Hi Theodore,
>       Thank you for the details about the journalling layer and
> insight into the block device layer.
>  I think Good luck might have clicked. The swap file in our case is
> attached to a loop block device before enabling swap using swapon.
> Since loop driver processes its IO requests by calling
> vfs_iter_write() the write requests re-enter the ext4
> filesystem/journalling code.
> Is that right ? There seems to be a possibility of cylic dependency.

If that hypothesis is correct, you should see an example of that in
one of your stack traces; do you?  The loop device creates struct file
where the file is opened using O_DIRECT.  In the O_DIRECT code path,
assuming the file was fully allocate and initialized, it shouldn't
involve starting a journal handle.

That being said, why are you using a loop device for a swap device at
all?  Using a swap file directly is going to be much more efficient,
and decrease the stack depth and CPU cycles needed to do a swap out if
nothing else.  If you can reliably reproduce the problem, what happens
if you use a swap file directly and cut out the loop device as a swap
device?   Does it make the problem go away?

					- Ted
