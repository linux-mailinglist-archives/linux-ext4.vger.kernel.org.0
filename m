Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0897140B8B8
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Sep 2021 22:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhINUKX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Sep 2021 16:10:23 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33563 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232545AbhINUKW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Sep 2021 16:10:22 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 18EK92pX015580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 16:09:02 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1460E15C3424; Tue, 14 Sep 2021 16:09:02 -0400 (EDT)
Date:   Tue, 14 Sep 2021 16:09:02 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 3/3] resize2fs: optimize
 resize2fs_calculate_summary_stats()
Message-ID: <YUEBXuE56KCPWOoy@mit.edu>
References: <20210914191104.2283033-1-tytso@mit.edu>
 <20210914191104.2283033-3-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914191104.2283033-3-tytso@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 14, 2021 at 03:11:04PM -0400, Theodore Ts'o wrote:
> Speed up an off-line resize of a 10GB file system to 64TB located on
> tmpfs from 90 seconds to 16 seconds by extracting block group bitmaps
> using a population count function to count the blocks in use instead
> checking each bit in the block bitmap.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  resize/resize2fs.c | 74 ++++++++++++++--------------------------------
>  1 file changed, 23 insertions(+), 51 deletions(-)
> 
> diff --git a/resize/resize2fs.c b/resize/resize2fs.c
> +		retval = ext2fs_get_block_bitmap_range2(fs->block_map,
> +			C2B(blk), fs->super->s_clusters_per_group, bitmap_buf);

Whoops, this should be B2C to convert a block number to a cluster
number.

Hmm, I note that this wasn't picked up by our regression tests.
Mental note to self --- we need to add more regression tests to better
exercise bigalloc resizes.  Currently we have a big warning which gets
printed about off-line resizes of bigalloc file systems being
experimentlal, but we should aim to do better.  :-)

	       	      	     	    - Ted
