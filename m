Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD77435056
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Oct 2021 18:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhJTQkr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Oct 2021 12:40:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38474 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhJTQko (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Oct 2021 12:40:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5305D1FD33;
        Wed, 20 Oct 2021 16:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634747908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OsuWH0d1GahoYrdrumAfM3YTdPeRP+sA8ZfG5OBSw9s=;
        b=AmrKiF9zab/7DT2fAGsQZdOigwUv7TNje/j96cyR3hx/Itg20MmD3fSNxxUCQJIKSLrKs2
        HPVnlAw2DJXXs9eriNLaFMQkULwtIxvJ9Pi6zJru5EdabB7LpEqBqDch7DuS//VRomu6Wo
        5R5AQcMOUPIHb346dQwZJyr0Codpcvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634747908;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OsuWH0d1GahoYrdrumAfM3YTdPeRP+sA8ZfG5OBSw9s=;
        b=TPq9r4Cgr8fG1rtv4NnG0vkLk4HHngm+1xkNgHruFDH1cg1my6Bla8swN2gH14RUE2GXHw
        enRjBJMX2KjROsDQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 2AC02A3B84;
        Wed, 20 Oct 2021 16:38:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E41451F2C7D; Wed, 20 Oct 2021 18:38:26 +0200 (CEST)
Date:   Wed, 20 Oct 2021 18:38:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: kernel BUG at fs/ext4/inode.c:1721!
Message-ID: <20211020163826.GD16460@quack2.suse.cz>
References: <YWANK0HchPv9m6hA@zn.tnic>
 <20211008173305.GA28198@localhost.localdomain>
 <YWCL2OXaz8/OnBiF@zn.tnic>
 <20211011231124.GB17897@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011231124.GB17897@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 11-10-21 19:11:24, Eric Whitney wrote:
> * Borislav Petkov <bp@alien8.de>:
> > Hi Eric,
> > 
> > On Fri, Oct 08, 2021 at 01:33:05PM -0400, Eric Whitney wrote:
> > > Hi, Boris - thanks very much for your report.
> > 
> > sure, np.
> > 
> > > Was your kernel configured with the CONFIG_FS_ENCRYPTION option?
> > 
> > $ grep CONFIG_FS_ENCRYPTION /boot/config-5.15.0-rc4+ 
> > # CONFIG_FS_ENCRYPTION is not set
> > 
> > > Could you please provide the output of the mount command for the affected
> > > file system?
> > 
> > Well, I can't figure out from dmesg - it's all I have from that run -
> > which fs it was. So lemme give you all ext4 ones:
> > 
> > $ mount | grep ext4
> > /dev/nvme0n1p2 on / type ext4 (rw,relatime,errors=remount-ro)
> > /dev/sdc1 on /home type ext4 (rw,noatime)
> > /dev/sda1 on /mnt/oldhome type ext4 (rw,noatime)
> > /dev/sdb1 on /mnt/smr type ext4 (rw,noatime)
> > /dev/nvme1n1p1 on /mnt/kernel type ext4 (rw,nosuid,nodev,noatime,user)
> > 
> > > Do you recall what sort of code might have been running on this system at
> > > the time of failure (for example, kernel build, desktop apps, etc.)?
> > 
> > Good question. I'm not sure. Kernel build is likely as I do those on
> > that workstation constantly.
> > 
> > Unfortunately, I don't have an exact reproducer. And I can't debug stuff
> > on that box since it is my workstation and I've reverted it to 5.14.
> > 
> > What I can do is, I can slap 5.15-rc4 or whichever version you'd want me
> > to, on a test box and try running kernel builds or some other load to
> > see whether it would fire. I have a similar box to my workstation.
> > 
> > Or if you have a better idea...
> 
> Hi, Boris:
> 
> I've tried numerous kernel builds with -rc4 and rerun the full set of xfstests
> we use when regressing ext4 each rc using a kernel that doesn't enable
> FS_ENCRYPTION (I normally run with that) without luck.  The code that caused
> the splat you saw is new and would run when an assertion is violated,
> suggesting that there may be an unsuspected bug elsewhere in ext4.
> 
> Do you recall having seen any evidence of ENOMEM or ENOSPC conditions prior
> to the failure?
> 
> If you're willing to share, please send along your kernel config file and I'll
> try working with that as well.
> 
> In the meantime, should this bug get in your way, just revert the following
> patch and you should be able to run without further trouble:
> 
> 948ca5f30e1d "ext4: enforce buffer head state assertion in ext4_da_map_blocks"
> 
> I'll likely be posting a patch to revert this shortly, since it's going to
> take some time to sort out what's going on without a reproducer.

Looking at this I can see that the assertion is 

BUG_ON(bh->b_blocknr != invalid_block);

and I suspect it is some kind of a race between ext4_da_map_blocks() and
writeback code? Writeback code holds only i_data_sem and page locks but
ext4_da_map_blocks() holds only page lock at that point. So page lock on
that particular page is the only thing that protects us from getting
outright out of date info from extent status tree. And I'm not sure all
extent status tree manipulations are careful enough to be also protected by
page locks of all pages that are inside given extent...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
