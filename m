Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162CA387BCB
	for <lists+linux-ext4@lfdr.de>; Tue, 18 May 2021 16:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244591AbhERO7Q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 May 2021 10:59:16 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46697 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1344163AbhERO7K (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 May 2021 10:59:10 -0400
Received: from callcc.thunk.org (c-73-8-226-230.hsd1.il.comcast.net [73.8.226.230])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 14IEvinR005090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 May 2021 10:57:46 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2C8E6420119; Tue, 18 May 2021 10:57:44 -0400 (EDT)
Date:   Tue, 18 May 2021 10:57:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: get discard out of jbd2 commit kthread
Message-ID: <YKPV6FZWfoUD3bgL@mit.edu>
References: <53146e54-af36-0c32-cad8-433460461237@gmail.com>
 <YKLXev4cjeRuGRqd@mit.edu>
 <c7c00420-ed5c-0f5d-23c1-1c64b1800778@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7c00420-ed5c-0f5d-23c1-1c64b1800778@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 18, 2021 at 09:19:13AM +0800, Wang Jianchao wrote:
> > That way we don't need to move all of this to a kworker context.
> 
> The submit_bio also needs to be out of jbd2 commit kthread as it may be
> blocked due to blk-wbt or no enough request tag. ;)

Actually, there's a bigger deal that I hadn't realized, about why we
is why are currently using submit_bio_wait().  We *must* wait until
discard has completed before we call ext4_free_data_in_buddy(), which
is what allows those blocks to be reused by the block allocator.

If the discard happens after we reallocate the block, there is a good
chance that we will end up corrupting a data or metadata block,
leading to user data loss.

There's another corollary to this; if you use blk-wbt, and you are
doing lots of deletes, and we move this all to a writeback thread,
this *significantly* increases the chance that the user will see
ENOSPC errors in the case where they are with a very full (close to
100% used) file system.

I'd argue that this is a *really* good reason why using mount -o
discard is Just A Bad Idea if you are running with blk-wbt.  If
discards are slow, using fstrim is a much better choice.  It's also
the case that for most SSD's and workloads, doing frequent discards
doesn't actually help that much.  The write endurance of the device is
not compromised that much if you only run fs-trim and discard unused
blocks once a day, or even once a week --- I only recommend use of
mount -o discard in cases where the discard operation is effectively
free.  (e.g., in cases where the FTL is implemented on the Host OS, or
you are running with super-fast flash which is PCIe or NVMe attached.)

Cheers,

					- Ted
