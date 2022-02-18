Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675394BB02F
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Feb 2022 04:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbiBRDSg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Feb 2022 22:18:36 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiBRDSg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Feb 2022 22:18:36 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB1D1CFD3
        for <linux-ext4@vger.kernel.org>; Thu, 17 Feb 2022 19:18:19 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V4nDTNG_1645154295;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V4nDTNG_1645154295)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 18 Feb 2022 11:18:17 +0800
Date:   Fri, 18 Feb 2022 11:18:14 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Shyam Prasad N <nspmangalore@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Steve French <smfrench@gmail.com>, linux-ext4@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com
Subject: Re: Regarding ext4 extent allocation strategy
Message-ID: <Yg8P9uvExJ2B/J3T@B-P7TQMD6M-0146.local>
References: <CANT5p=o3i4kWQuMFF5zKQp04JnWEQnYuo+cvyH8asGMvTVBBkw@mail.gmail.com>
 <YO17ZNOcq+9PajfQ@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YO17ZNOcq+9PajfQ@mit.edu>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted and David,

On Tue, Jul 13, 2021 at 07:39:16AM -0400, Theodore Y. Ts'o wrote:
> On Tue, Jul 13, 2021 at 12:22:14PM +0530, Shyam Prasad N wrote:
> > 
> > Our team in Microsoft, which works on the Linux SMB3 client kernel
> > filesystem has recently been exploring the use of fscache on top of
> > ext4 for caching the network filesystem data for some customer
> > workloads.
> > 
> > However, the maintainer of fscache (David Howells) recently warned us
> > that a few other extent based filesystem developers pointed out a
> > theoretical bug in the current implementation of fscache/cachefiles.
> > It currently does not maintain a separate metadata for the cached data
> > it holds, but instead uses the sparseness of the underlying filesystem
> > to track the ranges of the data that is being cached.
> > The bug that has been pointed out with this is that the underlying
> > filesystems could bridge holes between data ranges with zeroes or
> > punch hole in data ranges that contain zeroes. (@David please add if I
> > missed something).
> > 
> > David has already begun working on the fix to this by maintaining the
> > metadata of the cached ranges in fscache itself.
> > However, since it could take some time for this fix to be approved and
> > then backported by various distros, I'd like to understand if there is
> > a potential problem in using fscache on top of ext4 without the fix.
> > If ext4 doesn't do any such optimizations on the data ranges, or has a
> > way to disable such optimizations, I think we'll be okay to use the
> > older versions of fscache even without the fix mentioned above.
> 
> Yes, the tuning knob you are looking for is:
> 
> What:		/sys/fs/ext4/<disk>/extent_max_zeroout_kb
> Date:		August 2012
> Contact:	"Theodore Ts'o" <tytso@mit.edu>
> Description:
> 		The maximum number of kilobytes which will be zeroed
> 		out in preference to creating a new uninitialized
> 		extent when manipulating an inode's extent tree.  Note
> 		that using a larger value will increase the
> 		variability of time necessary to complete a random
> 		write operation (since a 4k random write might turn
> 		into a much larger write due to the zeroout
> 		operation).
> 
> (From Documentation/ABI/testing/sysfs-fs-ext4)
> 
> The basic idea here is that with a random workload, with HDD's, the
> cost of writing a 16k random write is not much more than the time to
> write a 4k random write; that is, the cost of HDD seeks dominates.
> There is also a cost in having a many additional entries in the extent
> tree.  So if we have a fallocated region, e.g:
> 
>     +-------------+---+---+---+----------+---+---+---------+
> ... + Uninit (U)  | W | U | W |   Uninit | W | U | Written | ...
>     +-------------+---+---+---+----------+---+---+---------+
> 
> It's more efficient to have the extent tree look like this
> 
>     +-------------+-----------+----------+---+---+---------+
> ... + Uninit (U)  |  Written  |   Uninit | W | U | Written | ...
>     +-------------+-----------+----------+---+---+---------+
> 
> And just simply write zeros to the first "U" in the above figure.
> 
> The default value of extent_max_zeroout_kb is 32k.  This optimization
> can be disabled by setting extent_max_zeroout_kb to 0.  The downside
> of this is a potential degredation of a random write workload (using
> for example the fio benchmark program) on that file system.
> 

As far as I understand what cachefile does, it just truncates a sparse
file with a big hole, and do direct IO _only_ all the time to fill the
holes.

But the description above is all around (un)written extents, which
already have physical blocks allocated, but just without data
initialization. So we could zero out the middle extent and merge
these extents into one bigger written extent.

However, IMO, it's not the case of what the current cachefiles
behavior is... I think rare local fs allocates blocks with direct
i/o due to real holes, zero out and merge extents since at least it
touches disk quota.

David pointed this message yesterday since we're doing on-demand read
feature by using cachefiles as well. But I still fail to understand why
the current cachefile behavior is wrong.

Could you kindly leave more hints about this? Many thanks!

Thanks,
Gao Xiang

> Cheers,
> 
> 						- Ted
