Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA5715418F
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2020 11:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgBFKH4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Feb 2020 05:07:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:34650 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727543AbgBFKH4 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 6 Feb 2020 05:07:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4E635AF3F;
        Thu,  6 Feb 2020 10:07:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AEC4D1E0E31; Thu,  6 Feb 2020 11:07:53 +0100 (CET)
Date:   Thu, 6 Feb 2020 11:07:53 +0100
From:   Jan Kara <jack@suse.cz>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 2/3] ext2fs: Implement dir entry creation in htree
 directories
Message-ID: <20200206100753.GI14001@quack2.suse.cz>
References: <20200205100138.30053-1-jack@suse.cz>
 <20200205100138.30053-3-jack@suse.cz>
 <4182C838-A947-4BA7-939F-16624344D4C4@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4182C838-A947-4BA7-939F-16624344D4C4@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 05-02-20 10:50:16, Andreas Dilger wrote:
> On Feb 5, 2020, at 3:01 AM, Jan Kara <jack@suse.cz> wrote:
> > 
> > Implement proper creation of new directory entries in htree directories
> > in ext2fs_link(). So far we just cleared EXT2_INDEX_FL and treated
> > directory as unindexed however this results in mismatched checksums if
> > metadata checksums are in use because checksums are placed in different
> > places depending on htree node type.
> 
> I'm definitely not agains this, as I believe it will also speed up e2fsck
> for cases where a lot of entries are inserted into lost+found (sometimes
> many millions of files).  Currently e2fsck linearly scans the whole dir
> for each insert, rather than saving the offset of the last entry.  I have
> a patch to fix that, but it needed several API changes and got bogged down
> in performance testing and never made it out to the list.
> 
> One potential risk is that if a directory is corrupted in some way, then
> the htree index cannot always be trusted to do inserts during e2fsck, so
> it might still have to fall back to clearing the flag and doing a linear
> insertion.

Well, but pass 2 checks internal consistency of all directories so if htree
in lost+found is not usable, it will be detected and handled. So in pass 3
we should have usable lost+found (possibly without htree) to use.

Also note that I have not implemented conversion of directory into indexed
one so in the normal case lost+found will be just an ordinary linear
directory.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
