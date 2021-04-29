Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F4736EE92
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Apr 2021 19:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbhD2RGS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Apr 2021 13:06:18 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49865 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233622AbhD2RGR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Apr 2021 13:06:17 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13TH516P013438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Apr 2021 13:05:02 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A107115C39C4; Thu, 29 Apr 2021 13:05:01 -0400 (EDT)
Date:   Thu, 29 Apr 2021 13:05:01 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        akpm@linux-foundation.org, peterz@infradead.org, axboe@kernel.dk,
        pmladek@suse.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: fix memory leak in ext4_fill_super
Message-ID: <YIrnPXJo/n68NrQs@mit.edu>
References: <20210428172828.12589-1-paskripkin@gmail.com>
 <3c3877a4-fef2-9e24-f99f-2ecc46deb7e4@oracle.com>
 <20210429143354.418248a7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429143354.418248a7@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 29, 2021 at 02:33:54PM +0300, Pavel Skripkin wrote:
> 
> There is a chance, that kthread_stop() call will happen before
> threadfn call. It means, that kthread_stop() return value must be checked everywhere,
> isn't it? Otherwise, there are a lot of potential memory leaks,
> because some developers rely on the fact, that data allocated for the thread will
> be freed _inside_ thread function.

That's not the only potential way that we could leak memory.  Earlier
in kthread(), if this memory allocation fails,

	self = kzalloc(sizeof(*self), GFP_KERNEL);

we will exit with -ENOMEM.  So at the very least all callers of
kthread_stop() also need to check for -ENOMEM as well as -EINTR ---
or, be somehow sure that the thread function was successfully called
and started.  In this particular case, the ext4 mount code had just
started the kmmpd thread, and then detected that something else had
gone wrong, and failed the mount before the kmmpd thread ever had a
chance to run.

I think if we want to fix this more generally across the whole kernel,
we would need to have a variant of kthread_run which supplies two
functions --- one which is the thread function, and the other which is
a cleanup function.  The cleanup function could just be kfree, but
there will be other cases where the cleanup function will need to do
other work before freeing the data structure (e.g., brelse((struct
mmpd_data *)data->bh)).

Is it worth it to provide such a cleanup function, which if present
would be called any time the thread exits or is killed?  I dunno.
It's probably simpler to just strongly recommend that the cleanup work
should never be done in the thread function, but after kthread_stop()
is called, whether it returns an error or not.  That's probably the
right fix for ext4, I think.

(Although note that kthread_stop(sbi->s_mmp_task) is called in
multiple places in fs/ext4/super.c, not just in the single location
which this patch touches.)

						- Ted
