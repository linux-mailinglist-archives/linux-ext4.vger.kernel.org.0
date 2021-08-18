Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87D63F0460
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Aug 2021 15:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbhHRNMM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Aug 2021 09:12:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43494 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236703AbhHRNML (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Aug 2021 09:12:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CE0BF22026;
        Wed, 18 Aug 2021 13:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629292295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pNbTNiD1STQNtLbP9HJspWxqkG24aw+poMP8uBkD5EA=;
        b=JpxnbxmJc8Q8bj8ui0+ohiQcr1jguQuOWqNRcNNodb1EQuz+uGAoT6qcACQ2a6T0Yfzi7U
        26JbNo28e+4sCW5WH+4bI2lWogq7D4lzF5lX2Ay2bSUID2K25uyMG+9tJHBvblh/BBHQJP
        xE4pAAakAGRa+nsRd3ed5LOmVcaH1oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629292295;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pNbTNiD1STQNtLbP9HJspWxqkG24aw+poMP8uBkD5EA=;
        b=TFPsG4IX03oZ9HwIWE02KnVuAa/ccf0yh612e3dHMvmH1/bAnf2gbN8Sy2LzhCncCtpIVO
        CfRZVa+4K0p4IcDA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id BE7C4A3B97;
        Wed, 18 Aug 2021 13:11:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7A9521E14B9; Wed, 18 Aug 2021 15:11:32 +0200 (CEST)
Date:   Wed, 18 Aug 2021 15:11:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yukuai3@huawei.com
Subject: Re: [PATCH 3/3] ext4: prevent getting empty inode buffer
Message-ID: <20210818131132.GE28119@quack2.suse.cz>
References: <20210810142722.923175-1-yi.zhang@huawei.com>
 <20210810142722.923175-4-yi.zhang@huawei.com>
 <20210813134440.GE11955@quack2.suse.cz>
 <ab186083-8c08-2d74-dd63-673e918e6fa0@huawei.com>
 <20210816171457.GL30215@quack2.suse.cz>
 <268a052a-e288-2e11-ec54-7210a47e44e2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <268a052a-e288-2e11-ec54-7210a47e44e2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 18-08-21 20:15:59, Zhang Yi wrote:
> On 2021/8/17 1:14, Jan Kara wrote:
> > On Mon 16-08-21 22:29:01, Zhang Yi wrote:
> >> On 2021/8/13 21:44, Jan Kara wrote:
> >>> On Tue 10-08-21 22:27:22, Zhang Yi wrote:
> >>>> In ext4_get_inode_loc(), we may skip IO and get an zero && uptodate
> >>>> inode buffer when the inode monopolize an inode block for performance
> >>>> reason. For most cases, ext4_mark_iloc_dirty() will fill the inode
> >>>> buffer to make it fine, but we could miss this call if something bad
> >>>> happened. Finally, __ext4_get_inode_loc_noinmem() may probably get an
> >>>> empty inode buffer and trigger ext4 error.
> >>>>
> >>>> For example, if we remove a nonexistent xattr on inode A,
> >>>> ext4_xattr_set_handle() will return ENODATA before invoking
> >>>> ext4_mark_iloc_dirty(), it will left an uptodate but zero buffer. We
> >>>> will get checksum error message in ext4_iget() when getting inode again.
> >>>>
> >>>>   EXT4-fs error (device sda): ext4_lookup:1784: inode #131074: comm cat: iget: checksum invalid
> >>>>
> >>>> Even worse, if we allocate another inode B at the same inode block, it
> >>>> will corrupt the inode A on disk when write back inode B.
> >>>>
> >>>> So this patch clear uptodate flag and mark buffer new if we get an empty
> >>>> buffer, clear it after we fill inode data or making read IO.
> >>>>
> >>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> >>>
> >>> Thanks for the fix! Really good catch! The patch looks correct but
> >>> honestly, I'm not very happy about the special buffer_new handling. It
> >>> looks correct but I'm a bit uneasy that e.g. the block device code can
> >>> access this buffer and manipulate its state. Cannot we instead e.g. check
> >>> whether the buffer is uptodate in ext4_mark_iloc_dirty(), if not, lock it,
> >>> if still not uptodate, zero it, mark as uptodate, unlock it and then call
> >>> ext4_do_update_inode()? That would seem like a bit more foolproof solution
> >>> to me. Basically the fact that the buffer is not uptodate in
> >>> ext4_mark_iloc_dirty() would mean that nobody else is past
> >>> __ext4_get_inode_loc() for another inode in that buffer and so zeroing is
> >>> safe.
> >>>
> >>
> >> Thanks for your suggestion! I understand what you're concerned and your
> >> approach looks fine except mark buffer uptodate just behind zero buffer
> >> in ext4_mark_iloc_dirty(). Because I think (1) if ext4_do_update_inode()
> >> return error before filling the inode, it will still left an uptodate
> >> but zero buffer, and it's not easy to handle the error path. (2) it is
> >> still not conform the semantic of buffer uptodate because it it not
> >> contain an uptodate inode information. How about move mark as uptodate
> >> into ext4_do_update_inode(), something like that（not tested）？
> > 
> > OK, but this way could loading of buffer from the disk race with
> > ext4_do_update_inode() and overwrite its updates? You have to have buffer
> > uptodate before you start modifying it or you have to keep the buffer
> > locked all the time while you are updating it to avoid such races.
> 
> Indeed.
> 
> > 
> > Luckily the only place where ext4_do_update_inode() can fail before copying
> > data to the buffer is due to ext4_inode_blocks_set() which should never
> > happen because we set s_maxsize so that i_blocks cannot overflow. So maybe
> > we can just get rid of that case and keep the uptodate setting with the
> > zeroing?
> > 
> 
> It's fine, Let's fix it this way now.(But I guess it's fragile because we
> have to prevent modify ext4_do_update_inode() return before filling data
> into inode buffer cautiously in the future.)

I guess can have "bring buffer uptodate" code in ext4_do_update_inode() to
have it closer to the code filling the buffer with correct data and comment
there that once we mark the buffer as uptodate, we rely on filling in the
correct information.

> BTW, could we also add a patch to just remove the
> ext4_has_feature_huge_file() check in ext4_inode_blocks_set() or move it
> to ext4_mark_iloc_dirty() before ext4_mark_iloc_dirty()? Or else we may
> get confused and have to add comments to explain it.

Yes, I would transform that check to WARN_ON_ONCE() with a comment that
sb->s_maxbytes should not have allowed this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
