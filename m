Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300742C1897
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Nov 2020 23:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbgKWWjG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 17:39:06 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37474 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731007AbgKWWjG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Nov 2020 17:39:06 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0ANMcuSH003238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 17:38:57 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 90E97420136; Mon, 23 Nov 2020 17:38:56 -0500 (EST)
Date:   Mon, 23 Nov 2020 17:38:56 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Li Xi <lixi@ddn.com>, Wang Shilong <wshilong@ddn.com>
Subject: Re: [RFC PATCH v3 08/61] e2fsck: open io-channel when copying fs
Message-ID: <20201123223856.GH132317@mit.edu>
References: <20201118153947.3394530-1-saranyamohan@google.com>
 <20201118153947.3394530-9-saranyamohan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118153947.3394530-9-saranyamohan@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 18, 2020 at 07:38:54AM -0800, Saranya Muruganandam wrote:
> From: Li Xi <lixi@ddn.com>
> 
> This patch also add writethrough flag to the thread io-channel.
> When multiple threads write the same disk, we don't want the
> data being saved in memory cache. This will be useful in the
> future, but even without that flag, the tests can be passed too.
> 
> This patch also cleanup the io channel cache of the global
> context. Otherwise, after pass1 step, the next steps would use
> old data saved in the cache. And the cached data might have
> already been overwritten in pass1.

See my previous comments about why io_managers will almost certainly
need to be thread-aware.  This commit modifies undo_io.c, but it can't
possibly work as-is, since you can't have multiple copies of the undo
manager from different threads trying to update a single undo file.
So these changes, by themselves, can't possibly be sufficient.

Instead of doing things incrementally, my suggestion is that we figure
out how to make io_managers thread-safe and we get it right *first*,
instead of making incremental changes throughout the patch series.
I'd also suggest that we figure out some kind of test framework so we
can test io_managers in isolation, so we can do stress tests, as well
as functional correctness tests as unit tests.

Once we have that, let's merge these changes in incrementally into
e2fsprogs, so we can have clean, well-designed and well-tested
low-level infrastructure, which will be easier for us to review.

> diff --git a/lib/ext2fs/ext2_io.h b/lib/ext2fs/ext2_io.h
> index 5540900a..4ad2fec8 100644
> --- a/lib/ext2fs/ext2_io.h
> +++ b/lib/ext2fs/ext2_io.h
> @@ -81,6 +81,7 @@ struct struct_io_manager {
>  	errcode_t (*write_blk)(io_channel channel, unsigned long block,
>  			       int count, const void *data);
>  	errcode_t (*flush)(io_channel channel);
> +	errcode_t (*flush_cleanup)(io_channel channel);
>  	errcode_t (*write_byte)(io_channel channel, unsigned long offset,
>  				int count, const void *data);
>  	errcode_t (*set_option)(io_channel channel, const char *option,

Please don't add new functions into the middle of struct_io_manager.
There is a long reserved[14] to add padding to the structure for a
reason.  Add a new function pointer just before the reserved[] array,
and then decrement the padding count.

The reason for this is that it's technically allowed for applications
to provide their own io_manager to the library, which may be stacked
on top of an some other io_manager (as is the case for undo
iomanager).  Or it might because the userspace application is
providing their own io manager to interface with some other OS ---
maybe Windows, or Fuschia in the future, who knows?

So if we add a new function pointer to the middle of
struct_io_manager, this breaks the ABI, and that's a Bad Thing, as it
may cause surprises in the future for applications which are using
shared libraries and we update with a newer version of the shared
library without doing a major version bump of the shared library.

		      	      	      	   - Ted
