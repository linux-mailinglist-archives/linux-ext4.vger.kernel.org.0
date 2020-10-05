Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5298F28338E
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Oct 2020 11:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgJEJqD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Oct 2020 05:46:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:43622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgJEJqD (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 5 Oct 2020 05:46:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 67430AE02;
        Mon,  5 Oct 2020 09:46:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 191E51E12EF; Mon,  5 Oct 2020 11:46:01 +0200 (CEST)
Date:   Mon, 5 Oct 2020 11:46:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: Re: ext4 regression in v5.9-rc2 from e7bfb5c9bb3d on ro fs with
 overlapped bitmaps
Message-ID: <20201005094601.GB4225@quack2.suse.cz>
References: <CAHk-=wj-H5BYCU_kKiOK=B9sN3BtRzL4pnne2AJPyf54nQ+d=w@mail.gmail.com>
 <20201005081454.GA493107@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005081454.GA493107@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Josh!

On Mon 05-10-20 01:14:54, Josh Triplett wrote:
> Ran into an ext4 regression when testing upgrades to 5.9-rc kernels:
> 
> Commit e7bfb5c9bb3d ("ext4: handle add_system_zone() failure in
> ext4_setup_system_zone()") breaks mounting of read-only ext4 filesystems
> with intentionally overlapping bitmap blocks.
> 
> On an always-read-only filesystem explicitly marked with
> EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS, prior to that commit, it's safe to
> point all the block and inode bitmaps to a single block of all 1s,
> because a read-only filesystem will never allocate or free any blocks or
> inodes.
> However, after that commit, the block validity check rejects such
> filesystems with -EUCLEAN and "failed to initialize system zone (-117)".
> This causes systems that previously worked correctly to fail when
> upgrading to v5.9-rc2 or later.
> 
> This was obviously a bugfix, and I'm not suggesting that it should be
> reverted; it looks like this effectively worked by accident before,
> because the block_validity check wasn't fully functional. However, this
> does break real systems, and I'd like to get some kind of regression fix
> in before 5.9 final if possible. I think it would suffice to make
> block_validity default to false if and only if
> EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS is set.
> 
> Does that seem like a reasonable fix?

Well, but EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS is your internal feature
that's not present in current upstream kernel AFAICS. So if you have out of
tree (even disk format incompatible) filesystem feature and upstream kernel
changes in a way that breaks you, I'd say it's your problem to keep the
pieces together?

So IMO you need to change implementation of your
EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS feature to work with more paranoid
block validity checking. Whether you'll do that by disabling block validity
or by properly teaching block validity code about that feature is up to you
but I don't think that belongs to the upstream kernel since that is correct
as is...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
