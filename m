Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F663E4C15
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Aug 2021 20:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhHIS1E (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Aug 2021 14:27:04 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48098 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234638AbhHIS1D (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Aug 2021 14:27:03 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 179IQWrP022654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Aug 2021 14:26:33 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8F68915C3DD0; Mon,  9 Aug 2021 14:26:32 -0400 (EDT)
Date:   Mon, 9 Aug 2021 14:26:32 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     ValdikSS <iam@valdikss.org.ru>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: ext4lazyinit reads HDD data on mount since 5.13
Message-ID: <YRFzWGkBOHcugxGD@mit.edu>
References: <015c7506-7f33-3967-772a-1285b0f1052f@valdikss.org.ru>
 <YRCKG1V/OBuble40@mit.edu>
 <c984528b-03ce-f9e5-2cf2-4ae92e812367@valdikss.org.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c984528b-03ce-f9e5-2cf2-4ae92e812367@valdikss.org.ru>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 09, 2021 at 10:43:08AM +0300, ValdikSS wrote:
> On 09.08.2021 04:51, Theodore Ts'o wrote:
> > It's a new feature which optimizes block allocations for very large
> > file systems.  The work being done by ext4lazyinit is to read the
> > block allocation bitmaps so we can cache the buddy bitmaps and how
> > fragmented (or not) various block groups are, which is used to
> > optimize the block allocator.
> 
> Thanks for the info. To revert old behavior, the filesystem should be
> mounted with -o no_prefetch_block_bitmaps
> 
> Is it safe to use this option with new optimizations? Should I expect only
> less optimal filesystem speed and no other issues?

It's not been tested, but it should be safe in terms that it shouldn't
lead to any file system corruption or data loss.  However, it may
result in non-optional block placement that might cause more file or
free-space fragmentation that might otherwise be the case.  (This was
true even before the latest optimizations, but it's more the case with
the new optimizations.)

Can you say something about why you want to disable to block
allocation prefetch?  How is it causing problems for you?

Cheers,

					- Ted
