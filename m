Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4CFB104312
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Nov 2019 19:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfKTSOA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Nov 2019 13:14:00 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42309 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727671AbfKTSOA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Nov 2019 13:14:00 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-103.corp.google.com [104.133.8.103] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xAKIDscE021502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Nov 2019 13:13:55 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id EAFBB4202FD; Wed, 20 Nov 2019 13:13:53 -0500 (EST)
Date:   Wed, 20 Nov 2019 13:13:53 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Alex Zhuravlev <azhuravlev@whamcloud.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [RFC] improve malloc for large filesystems
Message-ID: <20191120181353.GG4262@mit.edu>
References: <8738E8FF-820F-48A5-9150-7FF64219ED42@whamcloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8738E8FF-820F-48A5-9150-7FF64219ED42@whamcloud.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Alex,

A couple of comments.  First, please separate this patch so that these
two separate pieces of functionality can be reviewed and tested
separately:

> 1) mballoc tries too hard to find the best chunk which is
>  counterproductive - it makes sense to limit this process

> 2) during scanning the bitmaps are loaded one by one, synchronously
>  - it makes sense to prefetch few groups at once

As far the prefetch is concerned, please note that the bitmap is first
read into the buffer cache via read_block_bitmap_nowait(), but then it
needs to be copied into buddy bitmap pages where it is cached along
side the buddy bitmap.  (The copy in the buddy bitmap is a combination
of the on-disk block allocation bitmap plus any outstanding
preallocations.)  From that copy of block bitmap, we then generate the
buddy bitmap and as a side effect, initialize the statistics
(grp->bb_first_free, grp->bb_largest_free_order, grp->bb_counters[]).

It is these statistics that we need to be able to make allocation
decisions for a particular block group.  So perhaps we should drive
the readahead of the bitmaps from ext4_mb_init_group() /
ext4_mb_init_cache(), and make sure that we actually initialize the
ext4_group_info structure, and not just read the bitmap into buffer
cache and hope it gets used before memory pressure pushes it out of
the buddy cache.

Andreas has suggested going even farther, and perhaps storing this
derived information from the allocation bitmaps someplace convenient
on disk.  This is an on-disk format change, so we would want to think
very carefully before going down that path.  Especially since if we're
going to go this far, perhaps we should consider using an on-disk
b-tree to store the allocation information, which could be more
efficient than using allocation bitmaps plus buddy bitmaps.

Cheers,

							- Ted
