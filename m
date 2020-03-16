Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C15A21867E9
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Mar 2020 10:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbgCPJau (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Mar 2020 05:30:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:35140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730025AbgCPJat (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 16 Mar 2020 05:30:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C7462AD2A;
        Mon, 16 Mar 2020 09:30:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8836F1E10DA; Mon, 16 Mar 2020 10:30:48 +0100 (CET)
Date:   Mon, 16 Mar 2020 10:30:48 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/7] e2fsck: Fix indexed dir rehash failure with
 metadata_csum enabled
Message-ID: <20200316093048.GD12783@quack2.suse.cz>
References: <20200213101602.29096-1-jack@suse.cz>
 <20200213101602.29096-3-jack@suse.cz>
 <20200307231719.GE99899@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307231719.GE99899@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 07-03-20 18:17:19, Theodore Y. Ts'o wrote:
> On Thu, Feb 13, 2020 at 11:15:57AM +0100, Jan Kara wrote:
> > E2fsck directory rehashing code can fail with ENOSPC due to a bug in
> > ext2fs_htree_intnode_maxrecs() which fails to take metadata checksum
> > into account and thus e.g. e2fsck can decide to create 1 indirect level
> > of index tree when two are actually needed. Fix the logic to account for
> > metadata checksum.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Applied with a minor change; I didn't want to make this change:
> 
> > -_INLINE_ int ext2fs_htree_intnode_maxrecs(ext2_filsys fs, int blocks)
> > +static inline int ext2fs_htree_intnode_maxrecs(ext2_filsys fs, int blocks)
> 
> ... because it would make ext2fs_htree_intmode_maxrecs disappear from
> libext2fs.so.

Aha! I was wondering what's going on with those strange inline
statements...

> So I changed this:
> 
> > +	if (ext2fs_has_feature_metadata_csum(fs->super))
> 
> to this:
> 
> +       if ((EXT2_SB(fs->super)->s_feature_ro_compat &
> +            EXT4_FEATURE_RO_COMPAT_METADATA_CSUM) != 0)
> 
> to fix the inline related compilation errors.

Thanks for fixing this!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
