Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EB26545D1
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Dec 2022 19:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiLVSJG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Dec 2022 13:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLVSJE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Dec 2022 13:09:04 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6656817E2A;
        Thu, 22 Dec 2022 10:09:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7DF73CE1BBF;
        Thu, 22 Dec 2022 18:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888A8C433EF;
        Thu, 22 Dec 2022 18:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671732539;
        bh=NRWCSSJiKT9ebsO+yFv6XlrvJQ8lw4SJc9ho5RGZ8kQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O+/8KgAVud6rfrWzxP+YdfiPHcK/C2uyvMeKfRTVp5GXnfxlTSw2YhTIZ1suPtB+g
         qa1Vzj6th9MaT9J68NdAap/uY2YFhNb9CDl8F+pbqazkGKHMAvfEN9QGorEiWYuoYo
         kZ9KpbK36As7+rEwBKrmzRQCVBbcStXbYsyvXzGD3V6P5Ko5M6V5MMlDH/io2lavKm
         661bNCMaBttnvQON6e1pMcKeusaf8/flZELGwfrMk/AmoRnUmtRvl7jbqa34tbYgUN
         ACHf1U0EU019/dPcX+GligpopT/J76AsClKBhd0wc+vLwlyA7Kue72tCQdaVxE+pQ+
         BJsffRUwMiLGA==
Date:   Thu, 22 Dec 2022 10:08:59 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jun Nie <jun.nie@linaro.org>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix underflow in group bitmap calculation
Message-ID: <Y6SdOzSr5CW5nQl/@magnolia>
References: <20221222020244.1821308-1-jun.nie@linaro.org>
 <Y6SW5s/jFY1oWFe2@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6SW5s/jFY1oWFe2@mit.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 22, 2022 at 12:41:58PM -0500, Theodore Ts'o wrote:
> On Thu, Dec 22, 2022 at 10:02:44AM +0800, Jun Nie wrote:
> > There is case that s_first_data_block is not 0 and block nr is smaller than
> > s_first_data_block when calculating group bitmap during allocation. This
> > underflow make index exceed es->s_groups_count in ext4_get_group_info()
> > and trigger the BUG_ON.
> > 
> > Fix it with protection of underflow.
> 
> When was this happening, and why?  If blocknr is less than
> s_first_data_block, this is either a insufficient input validation,
> insufficient validation to detection file system corruption. or some
> other kernel bug.
> 
> Looking quickly at the code and the repro, it appears that issue is
> that FS_IOC_GETFSMAP is getting passed a stating physical block of 0
> in fmh_keys[0] when on a file system with a blocksize of 1k (in which
> case s_first_data_block is 1).  It's unclear to me what

Question -- on a 1k-block filesystem, are the first 1024 bytes of the
device *reserved* by ext4 for whatever bootloader crud goes in there?
Or is that space undefined in the filesystem specification?

I never did figure that out when I was writing the ondisk specification
that's in the kernel, but maybe you remember?

> FS_IOC_GETFSMAP should *do* when passed a value which requests that it
> provide a mapping for a block which is out of bounds (either too big,
> or too small)?.  Should it return an error?  Should it simply not
> return a mapping?  The map page for ioctl_getfsmap() doesn't shed any
> light on this question.
> 
> Darrick, you designed the interface and wrote most of fs/ext4/fsmap.c.
> Can you let us know what is supposed to happen in this case?  Many
> thanks!!

If those first 1024 bytes are defined to be reserved in the ondisk
format, then you could return a mapping for those bytes with the owner
code set to EXT4_FMR_OWN_UNKNOWN.

If, however, the space is undefined, then going off this statement in
the manpage:

"For example, if the low key (fsmap_head.fmh_keys[0]) is set to (8:0,
36864, 0, 0, 0), the filesystem  will  only  return  records for extents
starting at or above 36 KiB on disk."

I think the 'at or above' clause means that ext4 should not pass back
any mapping for the byte range 0-1023 on a 1k-block filesystem.

If the low key is set to (8:0, 0, 0, 0, 0) and high key is set to (8:0,
1023, 0, 0, 0) then ext4 shouldn't return any mapping at all, because
there's no space usage defined for that region of the disk.

If the low key is set to (8:0, 0, 0, 0, 0) and high key is set to all
ones, then ext4 can return mappings for the primary superblock at offset
1024.

--D

> 
> > Fixes: 72b64b594081ef ("ext4 uninline ext4_get_group_no_and_offset()")
> 
> This makes ***no*** sense; the commit in question is from 2006, which
> means that in some jourisdictions it's old enough to drive a car.  :-)
> Futhermore, all it does is move the function from an inline function
> to a C file (in this case, balloc.c).  It also long predates
> introduction of FS_IOC_GETFSMAP support, which was in 2017.  
> 
> I'm guessing you just did a "git blame" and blindly assumed that
> whatever commit last touched the C code in question was what
> introduced the problem?
> 
> Anyway, please try to understand what is going on instead of doing the
> moral equivalent of taking a sledgehammer to the code until the
> reproducer stops triggering a BUG.  It's not enough to shut up the
> reproducer; you should understand what is happening, and why, and then
> strive to find the best fix to the problem.  Papering over problems in
> the end will result in more fragile code, and the goal of syzkaller is
> to improve kernel quality.  But syzkaller is just a tool and used
> wrongly, it can have the opposite effect.
> 
> Regards,
> 
> 					- Ted
