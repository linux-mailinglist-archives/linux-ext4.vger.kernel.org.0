Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B552D21F142
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jul 2020 14:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgGNMbY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jul 2020 08:31:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:47640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728193AbgGNMbX (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 14 Jul 2020 08:31:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 362BFAD85;
        Tue, 14 Jul 2020 12:31:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 66B541E12C9; Tue, 14 Jul 2020 14:31:22 +0200 (CEST)
Date:   Tue, 14 Jul 2020 14:31:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org,
        Wolfgang Frisch <wolfgang.frisch@suse.com>
Subject: Re: [PATCH] ext4: catch integer overflow in ext4_cache_extents
Message-ID: <20200714123122.GG23073@quack2.suse.cz>
References: <20200713125818.21918-1-jack@suse.cz>
 <20200713134448.4CFA3A4051@d06av23.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713134448.4CFA3A4051@d06av23.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 13-07-20 19:14:47, Ritesh Harjani wrote:
> 
> 
> On 7/13/20 6:28 PM, Jan Kara wrote:
> > From: Wolfgang Frisch <wolfgang.frisch@suse.com>
> > 
> > When extent tree is corrupted we can hit BUG_ON in
> > ext4_es_cache_extent(). Check for this and abort caching instead of
> > crashing the machine.
> 
> Was it intentionally made corrupted by crafting a corrupted disk image?

I'm not sure how Wolfgang hit the issue. I'd expect some fs image
fuzzing... Wolfgang?

> Are there more such logic in place which checks for such corruption at other
> places?

That's a good question. But now that I'm looking at it ext4_ext_check()
should actually catch a corruption like this. It is only the path in
ext4_find_extent()->ext4_cache_extents() that can face the issue so
probably instead of a fix in ext4_cache_extents() we should rather add more
careful extent info checks for the extents contained directly in the inode.
I'll look into it.

> Maybe a background over the issue which you saw may help.
> Also how did it recover out of it?

e2fsck I suppose :)

> Do you think it make sense to still emit a WARN_ON() here and then
> return which warns that this could possibly a corrupted extent
> entry? (maybe WARN_ON_ONCE() or via some ratelimiting if multiple extent
> entries are corrupted for that inode).

No, WARN is definitely wrong in this case. We could call ext4_error() if we
wanted. That would make sence although I've decided not to add it to
the original Wolfgang's fix since this is more like a failing readahead.
But OTOH it's metadata corruption that's unlikely to go away so I can be
easily convinced to put ext4_error() there :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
