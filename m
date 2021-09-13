Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDD0409A5C
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Sep 2021 19:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242045AbhIMRJj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Sep 2021 13:09:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241817AbhIMRJg (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 13 Sep 2021 13:09:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07222610A2;
        Mon, 13 Sep 2021 17:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631552900;
        bh=bQqsBZbSEoBftgvvkgrkyNd5nWA/o1m4OMIgznQcjTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QT5lG+pkKYmv0eFa+AMROdYXzD+POKWXiFmTralCSxHFOZ8H9NPK+7PskwyvKbsHR
         mkEeoRMrQDKPD7r7TzsGvaZqkD1ZGW1Q6ybdURvMTXWXeHVZykTm9BN3rQdyMF0ez1
         //gtGJktwTYD++awEB+eX/vn+EgR7PYaV311JPbYPDazlhdewBA7glU6sxDTS1ZEmZ
         f9kHcxNA/T+QKPofLXnkkb+EgbmM8dYh765zaaoN6gGPbgReGtavc/LgXS92PHNXgJ
         frEBLkKWlfFW8r2uBoLQxPxnrd3IYxe94kL5rLWThipWaoyoNJAC3bAnISxK+d01hL
         RnMQqCkWBHM5w==
Date:   Mon, 13 Sep 2021 10:08:19 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eryu Guan <guan@eryu.me>
Cc:     Catherine Hoang <catherine.hoang@oracle.com>,
        linux-xfs@vger.kernel.org, fstests@vger.kernel.org,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 3/3] xfstests: Move *_dump_log routines to common/xfs
Message-ID: <20210913170819.GA638503@magnolia>
References: <20210909174142.357719-1-catherine.hoang@oracle.com>
 <20210909174142.357719-4-catherine.hoang@oracle.com>
 <YT22rajMLkNyhKyr@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YT22rajMLkNyhKyr@desktop>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

[add ext4 list to cc]

On Sun, Sep 12, 2021 at 04:13:33PM +0800, Eryu Guan wrote:
> On Thu, Sep 09, 2021 at 05:41:42PM +0000, Catherine Hoang wrote:
> > Move _scratch_remount_dump_log and _test_remount_dump_log from
> > common/inject to common/xfs. These routines do not inject errors and
> > should be placed with other xfs common functions.
> > 
> > Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
> > ---
> >  common/inject | 26 --------------------------
> >  common/xfs    | 26 ++++++++++++++++++++++++++
> >  2 files changed, 26 insertions(+), 26 deletions(-)
> > 
> > diff --git a/common/inject b/common/inject
> > index b5334d4a..6b590804 100644
> > --- a/common/inject
> > +++ b/common/inject
> > @@ -111,29 +111,3 @@ _scratch_inject_error()
> >  		_fail "Cannot inject error ${type} value ${value}."
> >  	fi
> >  }
> > -
> > -# Unmount and remount the scratch device, dumping the log
> > -_scratch_remount_dump_log()
> > -{
> > -	local opts="$1"
> > -
> > -	if test -n "$opts"; then
> > -		opts="-o $opts"
> > -	fi
> > -	_scratch_unmount
> > -	_scratch_dump_log
> 
> This function is a common function that could handle multiple
> filesystems, currently it supports xfs, ext4 and f2fs. So it's not a

I don't think it even works correctly for ext*.  *_dump_log() calls
dumpe2fs -h, which displays the superblock contents, not the journal
contents themselves, which is (I think) what this helper is supposed to
do.

It really ought to do something along the lines of:

	echo 'logdump -a' | debugfs $SCRATCH_DEV

Though fixing this is probably something the ext4 developers should look
at...

> xfs-specific function, and moving it to common/xfs doesn't seem correct.
> Perhaps we should move it to common/log.

Agreed. ;)

--D

> > -	_scratch_mount "$opts"
> > -}
> > -
> > -# Unmount and remount the test device, dumping the log
> > -_test_remount_dump_log()
> > -{
> > -	local opts="$1"
> > -
> > -	if test -n "$opts"; then
> > -		opts="-o $opts"
> > -	fi
> > -	_test_unmount
> > -	_test_dump_log
> 
> Same here.
> 
> Thanks,
> Eryu
> 
> > -	_test_mount "$opts"
> > -}
> > diff --git a/common/xfs b/common/xfs
> > index bfb1bf1e..cda1f768 100644
> > --- a/common/xfs
> > +++ b/common/xfs
> > @@ -1263,3 +1263,29 @@ _require_scratch_xfs_bigtime()
> >  		_notrun "bigtime feature not advertised on mount?"
> >  	_scratch_unmount
> >  }
> > +
> > +# Unmount and remount the scratch device, dumping the log
> > +_scratch_remount_dump_log()
> > +{
> > +	local opts="$1"
> > +
> > +	if test -n "$opts"; then
> > +		opts="-o $opts"
> > +	fi
> > +	_scratch_unmount
> > +	_scratch_dump_log
> > +	_scratch_mount "$opts"
> > +}
> > +
> > +# Unmount and remount the test device, dumping the log
> > +_test_remount_dump_log()
> > +{
> > +	local opts="$1"
> > +
> > +	if test -n "$opts"; then
> > +		opts="-o $opts"
> > +	fi
> > +	_test_unmount
> > +	_test_dump_log
> > +	_test_mount "$opts"
> > +}
> > -- 
> > 2.25.1
