Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7882119F371
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Apr 2020 12:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgDFKVu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Apr 2020 06:21:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:47766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbgDFKVu (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 6 Apr 2020 06:21:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4AAF5AD1E;
        Mon,  6 Apr 2020 10:21:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 619581E1244; Mon,  6 Apr 2020 12:21:48 +0200 (CEST)
Date:   Mon, 6 Apr 2020 12:21:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     "J. R. Okajima" <hooanon05g@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext2: Silence lockdep warning about reclaim under
 xattr_sem
Message-ID: <20200406102148.GC1143@quack2.suse.cz>
References: <20200225120803.7901-1-jack@suse.cz>
 <30602.1586151377@jrobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30602.1586151377@jrobl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 06-04-20 14:36:17, J. R. Okajima wrote:
> Jan Kara:
> > Lockdep complains about a chain:
> >   sb_internal#2 --> &ei->xattr_sem#2 --> fs_reclaim
> >
> > and shrink_dentry_list -> ext2_evict_inode -> ext2_xattr_delete_inode ->
> > down_write(ei->xattr_sem) creating a locking cycle in the reclaim path.
> > This is however a false positive because when we are in
> > ext2_evict_inode() we are the only holder of the inode reference and
> > nobody else should touch xattr_sem of that inode. So we cannot ever
> > block on acquiring the xattr_sem in the reclaim path.
> >
> > Silence the lockdep warning by using down_write_trylock() in
> > ext2_xattr_delete_inode() to not create false locking dependency.
> 
> v5.6 is released.
> But I cannot see this patch applied.  Sad.

It will go in for this merge window. Since this was just a problem with
lockdep reporting, there's no hurry in pushing it...

> Anyway I am wondering whether acquiring xattr_sem in
> ext2_xattr_delete_inode() is really necessary or not.
> It is necessary because this function refers and clears i_file_acl,
> right?
>
> But this function handles the removed (nlink==0) and unused inodes only.
> If nobody else touches xattr_sem as you wrote, then it is same to
> i_file_acl, isn't it?  Can we replace xattr_sem (only here) by memory
> barrier, or remove xattr_sem from ext2_xattr_delete_inode()?

It is not really necessary because the inode is completely private to the
process evicting it at that point. So any inode-local locking is not going
to serialize anything. But from a maintenance point of view it is better to
acquire the lock so that possible assertions that lock is held in some
helper functions don't barf or for the case the function gets used in a
different code path in the future.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
