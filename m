Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8543F7BAC
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Aug 2021 19:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242258AbhHYRtK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Aug 2021 13:49:10 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40435 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241043AbhHYRtJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Aug 2021 13:49:09 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17PHmIFK024865
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Aug 2021 13:48:18 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 337E215C3DBB; Wed, 25 Aug 2021 13:48:18 -0400 (EDT)
Date:   Wed, 25 Aug 2021 13:48:18 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/5 v7] ext4: Speedup orphan file handling
Message-ID: <YSaCYmnIIvGb+f/t@mit.edu>
References: <20210816093626.18767-1-jack@suse.cz>
 <YSUo4TBKjcdX7N/q@mit.edu>
 <20210825113016.GB14620@quack2.suse.cz>
 <20210825161331.GA14270@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825161331.GA14270@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 25, 2021 at 06:13:31PM +0200, Jan Kara wrote:
> 
> So I had a look into the other failures... So ext4/044 works for me after
> fixing e2fsck (both in 1k and 4k cases). ext4/033, ext4/045, generic/273
> fail for me in the 1k case even without orphan file patches so I don't
> think they are a regression caused by my changes (specifically ext4/045 is
> a buggy test - I think the directory h-tree is not able to hold that many
> directories for 1k block size). Interestingly, I couldn't make generic/476
> fail for me either with or without my patches so that may be some random
> failure. I'm now running that test in a loop to see whether the failure
> will reproduce to investigate.

Oh, you're right.  I had forgotten I had the following in my
1k.exclude file, and I hadn't copied them over when I set up the
orphan_file_1k config.

# The test fails due to too many block group descriptors when the
# block size is 1k
ext4/033

# This test uses dioread_nolock which currently isn't supported when
# block_size != PAGE_SIZE.
ext4/034

# This test tries to create 65536 directories, and with 1k blocks,
# and long names, we run out of htree depth
ext4/045

# This test creates too many inodes on when the block size is 1k
# without using special mkfs.ext4 options to change the inode size.
# This test is a bit bogus anyway, and uses a bunch of magic calculations
# where it's not clear what it was originally trying to test in the
# first place.  So let's just skip it for now.
generic/273

# This test creates too many extended attributes to fit in a 1k block
generic/454

# Normal configurations don't support dax
-g dax

(We can drop ext4/034 from the exclude list since we now *do* support
dioread_nolock when block_size < page_size.)

Thanks for the investigating, and apologies for not the reason why I
hadn't seen the failures in the 1k case was because they had been
suppressed.

						- Ted
