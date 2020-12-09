Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A632D39A7
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Dec 2020 05:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbgLIEfG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Dec 2020 23:35:06 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48626 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726303AbgLIEfF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Dec 2020 23:35:05 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B94YFxV011102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Dec 2020 23:34:17 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B2BC5420136; Tue,  8 Dec 2020 23:34:15 -0500 (EST)
Date:   Tue, 8 Dec 2020 23:34:15 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH RESEND 4/8] ext4: add the gdt block of meta_bg to
 system_zone
Message-ID: <20201209043415.GG52960@mit.edu>
References: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
 <1604764698-4269-4-git-send-email-brookxu@tencent.com>
 <20201203150841.GM441757@mit.edu>
 <4770d6b2-bb9f-7bc5-4fbd-2104bfeba7c2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4770d6b2-bb9f-7bc5-4fbd-2104bfeba7c2@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 04, 2020 at 09:26:49AM +0800, brookxu wrote:
> 
> Theodore Y. Ts'o wrote on 2020/12/3 23:08:
> > On Sat, Nov 07, 2020 at 11:58:14PM +0800, Chunguang Xu wrote:
> >> From: Chunguang Xu <brookxu@tencent.com>
> >>
> >> In order to avoid poor search efficiency of system_zone, the
> >> system only adds metadata of some sparse group to system_zone.
> >> In the meta_bg scenario, the non-sparse group may contain gdt
> >> blocks. Perhaps we should add these blocks to system_zone to
> >> improve fault tolerance without significantly reducing system
> >> performance.
> 
> Thanks, in the large-market scenario, if we deal with all groups,
> the system_zone will be very large, which may reduce performance.
> I think the previous method is good, but it needs to be changed
> slightly, so that the fault tolerance in the meta_bg scenario
> can be improved without the risk of performance degradation.

OK, I see.   But this is not actually reliable:

> >> +		if ((i < 5) || ((i % flex_size) == 0)) {

This only works if the flex_size is less than or equal to 64 (assuming
a 4k blocksize).  That's because on 64-bit file systems, we can fit 64
block group descripters in a 4k block group descriptor block, so
that's the size of the meta_bg.  The default flex_bg size is 16, but
it's quite possible to create a file system via "mke2fs -t ext4 -G
256".  In that case, the flex_size will be 256, and we would not be
including all of the meta_bg groups.  So i % flex_size needs to be
replaced by "i % meta_bg_size", where meta_bg_size would be
initialized to EXT4_DESC_PER_BLOCK(sb).

Does that make sense?

						- Ted
