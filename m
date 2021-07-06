Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3453BDCD7
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jul 2021 20:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhGFSRc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jul 2021 14:17:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229954AbhGFSRc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 6 Jul 2021 14:17:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2590961C20;
        Tue,  6 Jul 2021 18:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625595293;
        bh=UZMM8Y8Z6fhjs4wjGHdR3p/4ajEpQpEWWwEDHVieS90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hpjdxhsot0KEDIHWVOqJZfWNu0uLjrmHWDWKY9gCvvZzY1ItivT3bP8Z5g+RgGoa2
         tll5HwtxvxTycXhqUE/7f6/9gEuwh4M1Wtt/0mnSRVNh1Mlr2Ugw4GHW1Kiyv8azlh
         tcHjZ7ZKjPyST29JhsRlTyhqRBsqgQda4LjYzuRgPmq9tYTtk4XJ2AEyomZ4oHIMN9
         1v5wiIkFlxPorP3V7uzIVkYwBttPJwf0WerB1LrXw4PUOS247Tvj0cQ4Nw+xV94ZsH
         O9qnwCGxjT5CRemIHE0M3lZ0+btSeHmR2dtJ2PCLT30g6BhvwseaKE6r/0eB8JcnnY
         cq1axKw82nOWA==
Date:   Tue, 6 Jul 2021 11:14:52 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     jefflexu@linux.alibaba.com
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [RFC,2/2] xfstests: common/rc: add cluster size support for ext4
Message-ID: <20210706181452.GB11571@locust>
References: <0939cdf0-895c-7287-569a-2a9b4269b1ca@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0939cdf0-895c-7287-569a-2a9b4269b1ca@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 05, 2021 at 02:58:51PM +0800, JeffleXu wrote:
> 
> Sorry for digging this really old post [1]. The overall background is
> that, @offset and @len need to be aligned with cluster size when doing
> fallocate(), or several xfstests cases calling fsx will fail if the
> tested filesystem enabling 'bigalloc' feature.
> 
> On April 27, 2020, 5:33 p.m. UTC Darrick J. Wong wrote:
> 
> > On Fri, Apr 24, 2020 at 05:33:50PM +0800, Jeffle Xu wrote:
> >> Inserting and collapsing range on ext4 with 'bigalloc' feature will
> >> fail due to the offset and size should be alligned with the cluster
> >> size.
> >> 
> >> The previous patch has add support for cluster size in fsx. Detect and
> >> pass the cluster size parameter to fsx if the underlying filesystem
> >> is ext4 with bigalloc.
> >> 
> >> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> >> ---
> >>  common/rc | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >> 
> >> diff --git a/common/rc b/common/rc
> >> index 2000bd9..71dde5f 100644
> >> --- a/common/rc
> >> +++ b/common/rc
> >> @@ -3908,6 +3908,15 @@ run_fsx()
> >>  {
> >>  	echo fsx $@
> >>  	local args=`echo $@ | sed -e "s/ BSIZE / $bsize /g" -e "s/ PSIZE / $psize /g"`
> >> +
> >> +	if [ "$FSTYP" == "ext4" ]; then
> >> +		local cluster_size=$(tune2fs -l $TEST_DEV | grep 'Cluster size' | awk '{print $3}')
> >> +		if [ -n $cluster_size ]; then
> >> +			echo "cluster size: $cluster_size"
> >> +			args="$args -u $cluster_size"
> >> +		fi
> >> +	fi
> > 
> > Computing the file allocation block size ought to be a separate helper.
> > 
> > I wonder if there's a standard way to report cluster sizes, seeing as
> > fat, ext4, ocfs2, and xfs can all have minimum space allocation units
> > that are larger than the base fs block size.
> 
> In fact only for insert_range and collapse range of ext4 and xfs (in
> realtime mode), @offset and @len need to be aligned with cluster size.
> 
> Though fat and ocfs2 also support cluster size, ocfs2 only supports
> preallocate and punch_hole, and fat only supports preallocate, in which
> case @offset and @len needn't be aligned with cluster size.
> 
> 
> So we need to align @offset and @len with cluster size only for ext4 and
> xfs (in realtime mode) at a minimum cost, to fix this issue. But the
> question is, there's no standard programming interface exporting cluster
> size. For both ext4 and xfs, it's stored as a binary data in disk
> version superblock, e.g., tune2fs could detect the cluster size of ext4.
> 
> 
> Any idea on how to query the cluster size?

xfs and ocfs2 return the rt extent size in stat.st_blksize.

In fstestsland you could use _get_file_block_size to figure out the
allocation unit.

Alternately, I've been testing a more permanent fix for the blocksize
issues[1]; perhaps that will fix the problem?

(Note that the series is at the end of my dev tree, so it's likely to
have apply errors for the tests that exist in djwong-dev but aren't
upstream.)

--D

[1] https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=check-blocksize-congruency

> 
> 
> [1]
> https://patchwork.kernel.org/project/fstests/cover/1587720830-11955-1-git-send-email-jefflexu@linux.alibaba.com/
> 
> -- 
> Thanks,
> Jeffle
