Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55D22C1B22
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Nov 2020 03:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgKXCA2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 21:00:28 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38663 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727089AbgKXCA2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Nov 2020 21:00:28 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0AO20Lwf029306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 21:00:21 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E3C65420136; Mon, 23 Nov 2020 21:00:20 -0500 (EST)
Date:   Mon, 23 Nov 2020 21:00:20 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Wang Shilong <wshilong@ddn.com>, Li Xi <lixi@ddn.com>
Subject: Re: [RFC PATCH v3 14/61] e2fsck: merge bitmaps after thread completes
Message-ID: <20201124020020.GL132317@mit.edu>
References: <20201118153947.3394530-1-saranyamohan@google.com>
 <20201118153947.3394530-15-saranyamohan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118153947.3394530-15-saranyamohan@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 18, 2020 at 07:39:00AM -0800, Saranya Muruganandam wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> A new method merge_bmap has been added to bitmap operations. But
> only red-black bitmap has that operation now.
> 
> Signed-off-by: Li Xi <lixi@ddn.com>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>

There are hacks to deal with the fact that only the read-block bitmap
backend supports merge_bmap in this patch series.  Why not implement
that for *all* of the back ends, along with some unit tests; it's
going to be less work than working around failures due to partial
implementation of merge_bmap --- and the workarounds weren't complete
in any case; you can force the use of a particular back-end via
/etc/e2fsck.conf --- see the function
e2fsck_allocate_{block,inode}_bmap() in e2fsck/util.c.

This was mainly way of forcing additional testing of the backend
implementations, and also so we could test/tune whether certain
backends were preferable for certain file systems for different ways
in which block/inode bitmaps are used by e2fsck --- but it's possible
for an sysadmin / SRE to explicitly set them on a production e2fsck,
and it would be preferable if things didn't blow up because we took a
shortcut and didn't implement merge_bmap for all of the bitmap
backends.   (It's *really* not that hard, anyway....)

> +static void e2fsck_pass1_free_bitmap(ext2fs_generic_bitmap *bitmap)
> +{
> +	if (*bitmap) {
> +		ext2fs_free_generic_bmap(*bitmap);
> +		*bitmap = NULL;
> +	}
> +
> +}

I'm not sure why this is needed?  ext2fs_free_Generic_bmap() will
already return if NULL is passed into it.

Also, by the end of the patch series, there are no callers of this
function....

And again, please separate out the libext2fs changes from the e2fsck
changes, do the libext2fs changes first, and there should really be
some unit tests of merge_bmap so we can validate that it works
correctly before we drop it into use with e2fsck.

There should also be better documentation of what dup and dup_allowed
in merge_bmap().

	  	    	    	     - Ted
