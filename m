Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE5F116D46
	for <lists+linux-ext4@lfdr.de>; Tue,  7 May 2019 23:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfEGVkO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 May 2019 17:40:14 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42448 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726650AbfEGVkO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 May 2019 17:40:14 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x47Le9Bj013764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 May 2019 17:40:10 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1DD06420024; Tue,  7 May 2019 17:40:09 -0400 (EDT)
Date:   Tue, 7 May 2019 17:40:09 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Probir Roy <proy.cse@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Locality of extent status tree traversal
Message-ID: <20190507214009.GF5900@mit.edu>
References: <CALe4XzYNBKhtcYvcuME0A29LvPuZEuirD3DLtHnffObRCUU8Rg@mail.gmail.com>
 <20190507175921.GD5900@mit.edu>
 <CALe4XzZxzMaDACmrVHJZ6ronWMd9JC+1t6EetYUu39FitofqDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALe4XzZxzMaDACmrVHJZ6ronWMd9JC+1t6EetYUu39FitofqDg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 07, 2019 at 01:56:27PM -0500, Probir Roy wrote:
> > block number (e.g., the location on disk).  It's a cache; lookups are
> > fast, and is an in-memory lookup.  Well, it's a little more than a
> > cache, it also stores some information for delayed allocation buffered
> > writes.
> 
> For sequential access, it will traverse almost the same path of the
> tree. How deep the extent status tree be in general? If the tree is
> much deeper, the sequential accesses would have many repeated nodes
> traversal on the tree for the lookup. Have you observed significant
> bottleneck on "ext4_es_lookup_extent"? Can it be removed by caching
> the parent node?

You do realize that the extent status tree is separate from the
on-disk ext4 extent tree, right?

The extent status tree is an in-memory cache, and it caches logical
extents.  Which is to say, the on-disk physical extents are limited
(for historical reasons) to 32,767 blocks in an on-disk extent entry.
If you have a contiguous range of 128,000 blocks, it will require 4
on-disk extents in the ext4 extent tree.

The extent status tree, being an in-memory data structure, will
collapse those 4 on-disk extents (assuming they are physically and
logically contiguous) into a single in-memory entry in the extent
status tree.  So the depth of the extent status tree very much depends
on how fragmented the data blocks are for the file in question.  If
the file is 100% contiguous, and pre-allocated in advance, it could be
12TB long, and it would only take a single entry in the extent status
tree.  If the file is very highly fragmented, then of course, the size
of the extent status tree in memory and the on-disk extent tree can be
quite large.

It's true that if the tree is very deep, then you might have to do
many traversals of the red-black tree.  But that's because file is
super fragmented.  If we didn't have the extent status cache, then
we'd have to read in portions of the on-disk extent tree.  That tree
has a larger fanout, so it's wider, as well as being less deep.  But
if you are talking about the number of memory accesses needed to
traverse the extent tree, it's going to be roughly the same as the
read-block tree.  In either case, it's going to be O(log N) of the number
of extents in the highly fragmented file.

So let's back up.  Why are you so concerned about potential
bottle-necks on the ext4_es_lookup_extent()?  What is your workload?
How badly fragmented is your file?  And have you considered taking
measures (such as preallocating the file using fallocate, and possibly
pre-initializing the file) to improve things?  If you are doing
something nasty such as a random write workload using buffered writes,
without preallocating the file, then yeah, things can get pretty
nasty.  But the problem isn't going to be in the extent status tree;
it's going to be in many positions as well.

						- Ted
