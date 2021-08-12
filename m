Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BEA3EA4DA
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Aug 2021 14:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbhHLMsM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Aug 2021 08:48:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59782 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbhHLMsM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Aug 2021 08:48:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 82F962224B;
        Thu, 12 Aug 2021 12:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628772466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xQPyVPUqB+5Gnvh0aihAKmjBNmedVfESzBrr040MKH4=;
        b=RpkZAt4jS2ia90yrrYYeG/ooamNmTIC+Om3QhUp0cJvx5Av2J1V8JVCzUQNvIy/TNi23gd
        vpEHmTXGLqVc7WAGMo5cb2ym1wzkQYgkrk21eA7nLQa+qoUK5HDS/ZTk1R28R3kZ1RceXs
        qgXUT5rNndTgHis7TFx9gMbDvUa6ECo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628772466;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xQPyVPUqB+5Gnvh0aihAKmjBNmedVfESzBrr040MKH4=;
        b=1zhH2HPY2FwecxlaKljSvaG9mjQ62sUi/oPyyIrEulkOfF1lue7iGEhT+vRtOgHG99C/hx
        ztHGxdMmUprmPzAg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 6EF85A3F07;
        Thu, 12 Aug 2021 12:47:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 466051F2AC2; Thu, 12 Aug 2021 14:47:46 +0200 (CEST)
Date:   Thu, 12 Aug 2021 14:47:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Boyang Xue <bxue@redhat.com>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>, tytso@mit.edu
Subject: Re: [kernel-5.11 regression] tune2fs fails after shutdown
Message-ID: <20210812124746.GA14675@quack2.suse.cz>
References: <CAHLe9YbqejLQJO-6-a0ETtNUitQtsYr3Q2b7xW4VV=6fXO6APw@mail.gmail.com>
 <CAHLe9YZN2LJHMzKPkA-g7C=fx-u-0Jw-2s6Ebyy-XUmv_5y-gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLe9YZN2LJHMzKPkA-g7C=fx-u-0Jw-2s6Ebyy-XUmv_5y-gg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Boyang,

On Thu 12-08-21 09:47:30, Boyang Xue wrote:
> (Adding the author of the commits)
> Hi Jan,
> 
> The commit
> 
> 81414b4dd48 ext4: remove redundant sb checksum recomputation
> 
> breaks the original reproducer of
> 
> 4274f516d4bc ext4: recalucate superblock checksum after updating free
> blocks/inodes
> 
> I'm wondering is it expected please?

Thanks for report! So for record the problem is not that superblock with
incorrect checksum would ever get to disk with my patches but the checksum
will be incorrect in the buffer cache until the moment we start writeout of
the superblock. And tune2fs accesses the buffer cache and sees the
incorrect (stale) checksum. It is impossible to fix this problem completely
(the tune2fs access is fundamentally racy) but yes, I guess returning the
checksum recalculation back will make the race window small and the cost is
small. I'll send a patch for this shortly.

Also can you perhaps make this sequence into a fstests testcase for ext4
filesystem so that we have it covered? Thanks!

								Honza

> On Thu, Aug 5, 2021 at 10:35 AM Boyang Xue <bxue@redhat.com> wrote:
> >
> > Hi,
> >
> > kernel commit
> >
> > 4274f516d4bc ext4: recalucate superblock checksum after updating free
> > blocks/inodes
> >
> > had been reverted by
> >
> > 81414b4dd48 ext4: remove redundant sb checksum recomputation
> >
> > since kernel-5.11-rc1. As a result, the original reproducer fails again.
> >
> > Reproducer:
> > ```
> > mkdir mntpt
> > fallocate -l 256M mntpt.img
> > mkfs.ext4 -Fq -t ext4 mntpt.img 128M
> > LPDEV=$(losetup -f --show mntpt.img)
> > mount "$LPDEV" mntpt
> > cp /proc/version mntpt/
> > ./godown mntpt # godown program attached.
> > umount mntpt
> > mount "$LPDEV" mntpt
> > tune2fs -l "$LPDEV"
> > ```
> >
> > tune2fs fails with
> > ```
> > tune2fs 1.46.2 (28-Feb-2021)
> > tune2fs: Superblock checksum does not match superblock while trying to
> > open /dev/loop0
> > Couldn't find valid filesystem superblock.
> > ```
> >
> > Tested on e2fsprogs-1.46.2 + kernel-5.14.0-0.rc3.29. I think it's a
> > regression. If this is the case, can we fix it again please?
> >
> > Thanks,
> > Boyang
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
