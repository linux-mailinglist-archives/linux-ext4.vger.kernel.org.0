Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC752189EB
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jul 2020 16:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgGHORI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jul 2020 10:17:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:37002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729477AbgGHORI (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 8 Jul 2020 10:17:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7B24DAE2D;
        Wed,  8 Jul 2020 14:17:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D59451E12BF; Wed,  8 Jul 2020 16:17:06 +0200 (CEST)
Date:   Wed, 8 Jul 2020 16:17:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: RWF_NOWAIT writes not failing when writing to a range with holes
Message-ID: <20200708141706.GB5288@quack2.suse.cz>
References: <CAL3q7H4boq-Rsm+OSK5bSBJhu-ywugOdwWfHRQkyuyDC_RoRZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4boq-Rsm+OSK5bSBJhu-ywugOdwWfHRQkyuyDC_RoRZA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi!

On Mon 15-06-20 18:53:11, Filipe Manana wrote:
> I found out a bug in btrfs where a RWF_NOWRITE does not fail if we
> write to a range that starts with an extent followed by holes (since
> it requires allocating extent(s)).
> 
> When writing a test case for fstests I noticed xfs fails with -EAGAIN
> as expected, but ext4 succeeds just like btrfs currently does:
> 
> mkfs.ext4 -F /dev/sdb
> mount /dev/sdb /mnt
> 
> xfs_io -f -d -c "pwrite -S 0xab -b 256K 0 256K" /mnt/bar
> xfs_io -c "fpunch 64K 64K" /mnt/bar
> sync
> xfs_io -d -c "pwrite -N -V 1 -b 128K -S 0xfe 0 128K" /mnt/bar
> 
> Is this a known bug? Or is there a technical reason that makes it too
> expensive to check no extents will need to be allocated?

Thanks for report! This is actually a fallout of the conversion of ext4
direct IO code to iomap (commit 378f32bab37 "ext4: introduce direct I/O
write using iomap infrastructure"). I'll send a fix.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
