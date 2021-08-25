Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEBD3F7E42
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Aug 2021 00:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhHYWOY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Aug 2021 18:14:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38918 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhHYWOX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Aug 2021 18:14:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7623222086;
        Wed, 25 Aug 2021 22:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629929616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PL8/sa50lPcD9NXgxqY9RP6u6OPcGt+88iEuM5SvaHI=;
        b=erAD1tEQ70Cie+ysxS+8hLZIv3vNk8SWBm5R4ZlI1GJHUvFSyh4AIozWDq4rDDomIYt8fZ
        bN6Gm4LEDt1ug8BI2RIupTmv0cGJlexnTTVDb784qOdr+4FOo1kCg5Y8X2VjgUanJSOUwb
        GkKOc7AA8FcRbfRLy23edYt/NOMNSQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629929616;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PL8/sa50lPcD9NXgxqY9RP6u6OPcGt+88iEuM5SvaHI=;
        b=KMwQfpzb+wOKTevIsUmwguInyayBmRddfczU1UFopbn6foLv/eoUfr5l7DRo0ELx6BJjXz
        PVgGXqPsBg6X5TBQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 5E5D7A3B89;
        Wed, 25 Aug 2021 22:13:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2D4951E0A8B; Thu, 26 Aug 2021 00:13:36 +0200 (CEST)
Date:   Thu, 26 Aug 2021 00:13:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/5 v7] ext4: Speedup orphan file handling
Message-ID: <20210825221336.GA27926@quack2.suse.cz>
References: <20210816093626.18767-1-jack@suse.cz>
 <YSUo4TBKjcdX7N/q@mit.edu>
 <20210825113016.GB14620@quack2.suse.cz>
 <20210825161331.GA14270@quack2.suse.cz>
 <YSaCYmnIIvGb+f/t@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSaCYmnIIvGb+f/t@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 25-08-21 13:48:18, Theodore Ts'o wrote:
> On Wed, Aug 25, 2021 at 06:13:31PM +0200, Jan Kara wrote:
> > 
> > So I had a look into the other failures... So ext4/044 works for me after
> > fixing e2fsck (both in 1k and 4k cases). ext4/033, ext4/045, generic/273
> > fail for me in the 1k case even without orphan file patches so I don't
> > think they are a regression caused by my changes (specifically ext4/045 is
> > a buggy test - I think the directory h-tree is not able to hold that many
> > directories for 1k block size). Interestingly, I couldn't make generic/476
> > fail for me either with or without my patches so that may be some random
> > failure. I'm now running that test in a loop to see whether the failure
> > will reproduce to investigate.
> 
> Oh, you're right.  I had forgotten I had the following in my
> 1k.exclude file, and I hadn't copied them over when I set up the
> orphan_file_1k config.
> 
> # The test fails due to too many block group descriptors when the
> # block size is 1k
> ext4/033
> 
> # This test uses dioread_nolock which currently isn't supported when
> # block_size != PAGE_SIZE.
> ext4/034
> 
> # This test tries to create 65536 directories, and with 1k blocks,
> # and long names, we run out of htree depth
> ext4/045
> 
> # This test creates too many inodes on when the block size is 1k
> # without using special mkfs.ext4 options to change the inode size.
> # This test is a bit bogus anyway, and uses a bunch of magic calculations
> # where it's not clear what it was originally trying to test in the
> # first place.  So let's just skip it for now.
> generic/273
> 
> # This test creates too many extended attributes to fit in a 1k block
> generic/454
> 
> # Normal configurations don't support dax
> -g dax
> 
> (We can drop ext4/034 from the exclude list since we now *do* support
> dioread_nolock when block_size < page_size.)
> 
> Thanks for the investigating, and apologies for not the reason why I
> hadn't seen the failures in the 1k case was because they had been
> suppressed.

No problem. Glad this is cleared out. I've sent out next version of the
e2fsprogs patches with fixed e2fsck bug you've found.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
