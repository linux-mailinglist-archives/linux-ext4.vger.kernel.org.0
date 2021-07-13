Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83063C6FDC
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jul 2021 13:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbhGMLmM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jul 2021 07:42:12 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45917 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235967AbhGMLmL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jul 2021 07:42:11 -0400
Received: from callcc.thunk.org (50-204-178-178-static.hfc.comcastbusiness.net [50.204.178.178])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16DBdGoY009254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 07:39:17 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 98D2A4202F5; Tue, 13 Jul 2021 07:39:16 -0400 (EDT)
Date:   Tue, 13 Jul 2021 07:39:16 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Shyam Prasad N <nspmangalore@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Steve French <smfrench@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: Regarding ext4 extent allocation strategy
Message-ID: <YO17ZNOcq+9PajfQ@mit.edu>
References: <CANT5p=o3i4kWQuMFF5zKQp04JnWEQnYuo+cvyH8asGMvTVBBkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANT5p=o3i4kWQuMFF5zKQp04JnWEQnYuo+cvyH8asGMvTVBBkw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 13, 2021 at 12:22:14PM +0530, Shyam Prasad N wrote:
> 
> Our team in Microsoft, which works on the Linux SMB3 client kernel
> filesystem has recently been exploring the use of fscache on top of
> ext4 for caching the network filesystem data for some customer
> workloads.
> 
> However, the maintainer of fscache (David Howells) recently warned us
> that a few other extent based filesystem developers pointed out a
> theoretical bug in the current implementation of fscache/cachefiles.
> It currently does not maintain a separate metadata for the cached data
> it holds, but instead uses the sparseness of the underlying filesystem
> to track the ranges of the data that is being cached.
> The bug that has been pointed out with this is that the underlying
> filesystems could bridge holes between data ranges with zeroes or
> punch hole in data ranges that contain zeroes. (@David please add if I
> missed something).
> 
> David has already begun working on the fix to this by maintaining the
> metadata of the cached ranges in fscache itself.
> However, since it could take some time for this fix to be approved and
> then backported by various distros, I'd like to understand if there is
> a potential problem in using fscache on top of ext4 without the fix.
> If ext4 doesn't do any such optimizations on the data ranges, or has a
> way to disable such optimizations, I think we'll be okay to use the
> older versions of fscache even without the fix mentioned above.

Yes, the tuning knob you are looking for is:

What:		/sys/fs/ext4/<disk>/extent_max_zeroout_kb
Date:		August 2012
Contact:	"Theodore Ts'o" <tytso@mit.edu>
Description:
		The maximum number of kilobytes which will be zeroed
		out in preference to creating a new uninitialized
		extent when manipulating an inode's extent tree.  Note
		that using a larger value will increase the
		variability of time necessary to complete a random
		write operation (since a 4k random write might turn
		into a much larger write due to the zeroout
		operation).

(From Documentation/ABI/testing/sysfs-fs-ext4)

The basic idea here is that with a random workload, with HDD's, the
cost of writing a 16k random write is not much more than the time to
write a 4k random write; that is, the cost of HDD seeks dominates.
There is also a cost in having a many additional entries in the extent
tree.  So if we have a fallocated region, e.g:

    +-------------+---+---+---+----------+---+---+---------+
... + Uninit (U)  | W | U | W |   Uninit | W | U | Written | ...
    +-------------+---+---+---+----------+---+---+---------+

It's more efficient to have the extent tree look like this

    +-------------+-----------+----------+---+---+---------+
... + Uninit (U)  |  Written  |   Uninit | W | U | Written | ...
    +-------------+-----------+----------+---+---+---------+

And just simply write zeros to the first "U" in the above figure.

The default value of extent_max_zeroout_kb is 32k.  This optimization
can be disabled by setting extent_max_zeroout_kb to 0.  The downside
of this is a potential degredation of a random write workload (using
for example the fio benchmark program) on that file system.

Cheers,

						- Ted
