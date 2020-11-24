Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE912C293B
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Nov 2020 15:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388254AbgKXORv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Nov 2020 09:17:51 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36772 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730508AbgKXORu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Nov 2020 09:17:50 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0AOEHUsm019840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 09:17:31 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 26D5B420136; Tue, 24 Nov 2020 09:17:30 -0500 (EST)
Date:   Tue, 24 Nov 2020 09:17:30 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Li Xi <lixi@ddn.com>, Wang Shilong <wshilong@ddn.com>
Subject: Re: [RFC PATCH v3 08/61] e2fsck: open io-channel when copying fs
Message-ID: <20201124141730.GP132317@mit.edu>
References: <20201118153947.3394530-1-saranyamohan@google.com>
 <20201118153947.3394530-9-saranyamohan@google.com>
 <20201123223856.GH132317@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123223856.GH132317@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 23, 2020 at 05:38:56PM -0500, Theodore Y. Ts'o wrote:
> On Wed, Nov 18, 2020 at 07:38:54AM -0800, Saranya Muruganandam wrote:
> > From: Li Xi <lixi@ddn.com>
> > 
> > This patch also add writethrough flag to the thread io-channel.
> > When multiple threads write the same disk, we don't want the
> > data being saved in memory cache. This will be useful in the
> > future, but even without that flag, the tests can be passed too.
> > 
> > This patch also cleanup the io channel cache of the global
> > context. Otherwise, after pass1 step, the next steps would use
> > old data saved in the cache. And the cached data might have
> > already been overwritten in pass1.

Thinking about this so more, what I'd suggest is the following.

1) We define a new flag, IO_FLAG_THREADED, which instructs the
io_manager that it should provide thread-safety.  For all io managers
defined in libext2fs, if they do not support the flag, they will
return a newly defined error code, EXT2_ET_IO_CHANNEL_NO_SUPPORT_FLAG.
Ideally, all of them should support IO_FLAG_THREADED, even undo_io,
even if that means just throwing a pthread rwlock around all of its
read/write operations.  

2) We also define a two options which can be set via
io_channel_set_option(), so that the "writethrough" and "cache"
options can be set to on or off via "writethrough=on", "cache=off",
"cache=on", etc.  This allows parallel reads to the unix io manager to
avoid needing any locks --- since pthread doesn't support spinlocks,
and mutexes are going to be rather expensive for highly contended
operations such as parallel read operations when reading bitmaps.

(In fact, some of the bugs that I saw when playing with the parallel
bitmap reading was probably cacused by the fact that there were
multiple threads trying to play with unix_io's cache without any
locking protection; and there's no real benefit to having any kind of
caching when reading the block bitmaps, and if we spin off separate
io_channels for each thread while reading the block bitmaps, the cache
will be *purely* useless.  The cache also doesn't do us much good when
we are reading the bitmaps, or during pass 1, even if we aren't
multi-threading, so having a way to turn off the cache is probably a
mild performance improvement even in the non-threaded case.)

And as I think I mentioned earlier, let's do some of these preparatory
changes to support parallel fsck *first*, since it'll be a lot easier
to review a bunch of shorter, patch series which are less than, say,
3-6 patches at a time, and once those get in, we can do with the next
step --- as opposed to a monster set of 61 commits.

     	    	       	 	 - Ted

P.S.  Finally, if we use a single shared io_manager which is threading
aware, I don't think we'll need the flush_cleanup() operation proposed
in this patch, since the cache will always be consistent.
