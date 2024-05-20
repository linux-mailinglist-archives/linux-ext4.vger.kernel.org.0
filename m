Return-Path: <linux-ext4+bounces-2610-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 693FB8CA20C
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 20:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7D21C2102B
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 18:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2111384A2;
	Mon, 20 May 2024 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSi2OFwW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B42137939;
	Mon, 20 May 2024 18:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716230246; cv=none; b=ffaRUtIt5Pm8qoAHMsg2d7vqnTT86BOeahUTOrxEqkJhS2aNbXN80F7Teh+hlcPudrJe/hUHKZQjcO/sycu62f0Z3MH9Dy/ZC9a05UxzMyZfyce+5mE7Gtkf6EvVIZYHYd/mt3gIPCK/XLI9nMJRIYsTxI0zibv3d30PBBVyxi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716230246; c=relaxed/simple;
	bh=TWekRrD9aIuqDsXAFgW2YpmZs5gfRZ8eOab4s6z4HFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wiom21ZPZvmFR6wDUtIv7TbGFNxxtX2BRAWGZlpRCgln0tuqRerZyWmFv36YTotLsEe2IQ9vb7t26yPx+o+QxDfkHyIkoC1CJ+y2CB0FT//dmRp8QZ0B29dYixEtMvTthT2uL3xEv5hPaXcT25Sk2KecKd7Ck11Qr49DKHH3kOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSi2OFwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFCFC2BD10;
	Mon, 20 May 2024 18:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716230245;
	bh=TWekRrD9aIuqDsXAFgW2YpmZs5gfRZ8eOab4s6z4HFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dSi2OFwW+blr4CiuJTu35ynkI9++bLu/85orAwRbpKaZH8BnlpQu0hrsHRoqr9mjw
	 dVE1dQ0ymNTAY+GQVsoI6izpL9jTlise991loVpFiu7/M3cUJZHEULyyTsLicmMeNC
	 afZRQD5BHWN2TyqhGTCFpMEqrn5M7X2L7ESoymvKNf1RtA2C8b6yX4v3bafEF8TxLL
	 LA5HfNdwXVplC1IsMo5rhWSHPB578AMatJKs7jkUZeWWwsFGrH6fvlg8A7spWpWENv
	 Ve2WUV6aCg+3ssXSMi47w8qUbFEAAqmRrc/+SywXdEp5JjjmEbZ19Cxb0ZiBLTCrx4
	 gyPitSUBJBUmg==
Date: Mon, 20 May 2024 11:37:24 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
	hch@infradead.org, brauner@kernel.org, david@fromorbit.com,
	chandanbabu@kernel.org, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 3/3] xfs: correct the zeroing truncate range
Message-ID: <20240520183724.GJ25518@frogsfrogsfrogs>
References: <20240517111355.233085-1-yi.zhang@huaweicloud.com>
 <20240517111355.233085-4-yi.zhang@huaweicloud.com>
 <20240517175900.GC360919@frogsfrogsfrogs>
 <fc050e5c-cdc5-9e3d-2787-ce09ec3b888e@huaweicloud.com>
 <20240518192602.GD360919@frogsfrogsfrogs>
 <7c388db6-f2fa-9ac1-2a0b-30bd28f3aeeb@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c388db6-f2fa-9ac1-2a0b-30bd28f3aeeb@huaweicloud.com>

On Mon, May 20, 2024 at 02:56:22PM +0800, Zhang Yi wrote:
> On 2024/5/19 3:26, Darrick J. Wong wrote:
> > On Sat, May 18, 2024 at 02:35:02PM +0800, Zhang Yi wrote:
> >> On 2024/5/18 1:59, Darrick J. Wong wrote:
> >>> On Fri, May 17, 2024 at 07:13:55PM +0800, Zhang Yi wrote:
> >>>> From: Zhang Yi <yi.zhang@huawei.com>
> >>>>
> >>>> When truncating a realtime file unaligned to a shorter size,
> >>>> xfs_setattr_size() only flush the EOF page before zeroing out, and
> >>>> xfs_truncate_page() also only zeros the EOF block. This could expose
> >>>> stale data since 943bc0882ceb ("iomap: don't increase i_size if it's not
> >>>> a write operation").
> >>>>
> >>>> If the sb_rextsize is bigger than one block, and we have a realtime
> >>>> inode that contains a long enough written extent. If we unaligned
> >>>> truncate into the middle of this extent, xfs_itruncate_extents() could
> >>>> split the extent and align the it's tail to sb_rextsize, there maybe
> >>>> have more than one blocks more between the end of the file. Since
> >>>> xfs_truncate_page() only zeros the trailing portion of the i_blocksize()
> >>>> value, so it may leftover some blocks contains stale data that could be
> >>>> exposed if we append write it over a long enough distance later.
> > 
> > Hum.  Is this an appending write into the next rtextent?  For example,
> > if you start with a file like this:
> > 
> > WWWWWWWWWWWWWWWWWWWWWuuuuuuuuu
> >                     ^ old EOF
> > 
> > Then truncate it improperly like this:
> > 
> > WWWWWzWWWWWWWWWWWWWWWuuuuuuuuu
> >      ^ new EOF               
> > 
> > Then do an extending write like this:
> > 
> > WWWWWzWWWWWWWWWWWWWWWuuuuuuuuuuuuuuuuuuuuuuuuuuuWWWuuuuuuuuu
> >      ^ EOF                    ^ next rtx        ^ append here
> > 
> > And now the problem is that we've exposed stale data that should be
> > zeroes?
> > 
> > WWWWWzWWWWWWWWWWWWWWWuuuuuuuuuuuuuuuuuuuuuuuuuuuWWWuuuuuuuuu
> >       ^^^^^^^^^^^^^^^                             ^ new EOF
> >       should be zeroed
> > 
> 
> Yeah.
> 
> >>>
> >>> IOWs, any time we truncate down, we need to zero every byte from the new
> >>> EOF all the way to the end of the allocation unit, correct?
> >>
> >> Yeah.
> >>
> >>>
> >>> Maybe pictures would be easier to reason with.  Say you have
> >>> rextsize=30 and a partially written rtextent; each 'W' is a written
> >>> fsblock and 'u' is an unwritten fsblock:
> >>>
> >>> WWWWWWWWWWWWWWWWWWWWWuuuuuuuuu
> >>>                     ^ old EOF
> >>>
> >>> Now you want to truncate down:
> >>>
> >>> WWWWWWWWWWWWWWWWWWWWWuuuuuuuuu
> >>>      ^ new EOF      ^ old EOF
> >>>
> >>> Currently, iomap_truncate_blocks only zeroes up to the next i_blocksize,
> >>> so the truncate leaves the file in this state:
> >>>
> >>> WWWWWzWWWWWWWWWWWWWWWuuuuuuuuu
> >>>      ^ new EOF      ^ old EOF
> >>>
> >>> (where 'z' is a written block with zeroes after EOF)
> >>>
> >>> This is bad because the "W"s between the new and old EOF still contain
> >>> old credit card info or whatever.  Now if we mmap the file or whatever,
> >>> we can access those old contents.
> >>>
> >>> So your new patch amends iomap_truncate_page so that it'll zero all the
> >>> way to the end of the @blocksize parameter.  That fixes the exposure by 
> >>> writing zeroes to the pagecache before we truncate down:
> >>>
> >>> WWWWWzzzzzzzzzzzzzzzzuuuuuuuuu
> >>>      ^ new EOF      ^ old EOF
> >>>
> >>> Is that correct?
> >>>
> >>
> >> Yes, it's correct. However, not only write zeros to the pagecache, but
> >> also flush to disk, please see below for details.
> > 
> > <nod> iomap_truncate_page writes zeroes to any part of the pagecache
> > backed by written extents, and then xfs must call
> > filemap_write_and_wait_range to write the dirty (zeroed) cache out to
> > disk.
> > 
> >>> If so, then why don't we make xfs_truncate_page convert the post-eof
> >>> rtextent blocks back to unwritten status:
> >>>
> >>> WWWWWzuuuuuuuuuuuuuuuuuuuuuuuu
> >>>      ^ new EOF      ^ old EOF
> >>>
> >>> If we can do that, then do we need the changes to iomap_truncate_page?
> >>> Converting the mapping should be much faster than dirtying potentially
> >>> a lot of data (rt extents can be 1GB in size).
> >>
> >> Now that the exposed stale data range (should be zeroed) is only one
> >> rtextsize unit, if we convert the post-eof rtextent blocks to unwritten,
> >> it breaks the alignment of rtextent and the definition of "extsize is used
> >> to specify the size of the blocks in the real-time section of the
> >> filesystem", is it fine?
> > 
> > A written -> unwritten extent conversion doesn't change which physical
> > space extent is mapped to the file data extent; it merely marks the
> > mapping as unwritten.
> > 
> > For example, if you start with this mapping:
> > 
> > {startoff = 8, startblock 256, blockcount = 8, state = written}
> > 
> > and then convert blocks 13-15 to unwritten, you get:
> > 
> > {startoff = 8, startblock 256, blockcount = 5, state = written}
> > {startoff = 13, startblock 261, blockcount = 3, state = unwritten}
> > 
> > File blocks 8-15 still map to physical space 256-263.
> 
> Yeah, indeed.
> 
> > 
> > In xfs, the entire allocation unit is /always/ mapped to the file, even
> > if parts of it have to be unwritten.  Hole punching on rt, for example,
> > converts the punched region to unwritten.  This is (iirc) the key
> > difference between xfs rt and ext4 bigalloc.  xfs doesn't have or need
> > (or want) the implied cluster allocation code that ext4 has.
> > 
> 
> I checked the xfs_file_fallocate(), it looks like hole punching on realtime
> inode is still follow the rtextsize alignment, i.e. if we punch hole on a
> file that only contains one written extent, it doesn't split it and convet
> the punched range to unwritten. Please take a look at
> xfs_file_fallocate()->xfs_free_file_space(), it aligned the freeing range
> and zeroing out the whole unligned range in one reextsize unit, and
> FALLOC_FL_ZERO_RANGE is the same.
> 
>  836	/* We can only free complete realtime extents. */
>  837	if (xfs_inode_has_bigrtalloc(ip)) {
>  838		startoffset_fsb = xfs_rtb_roundup_rtx(mp, startoffset_fsb);
>  839 		endoffset_fsb = xfs_rtb_rounddown_rtx(mp, endoffset_fsb);
>  840	}
> ...
>  864	error = xfs_zero_range(ip, offset, len, NULL);
> 
> And I tested it on my machine, it's true that it doesn't do the convertion.
> 
>   # mkfs.xfs -f -rrtdev=/dev/nvme0n1 -f -m reflink=0,rmapbt=0, -d rtinherit=1 -r extsize=28k /dev/pmem2s
>   # mount -ortdev=/dev/nvme0n1 /dev/pmem2s /mnt/scratch
>   # xfs_io -f -c "pwrite 0 28k" -c "fsync" /mnt/scratch/foo
>   # xfs_io -c "fpunch 4k 24k" /mnt/scratch/foo
>   # umount /mnt/scratch
> 
>   # xfs_db -c "inode 131" -c "p u3.bmx" /dev/pmem2s
>    u3.bmx[0] = [startoff,startblock,blockcount,extentflag]
>    0:[0,0,7,0]
> 
> Am I missed something?

I think fpunch is broken here -- xfs definitely supports having
unwritten mappings in the middle of an allocation unit.  See below.

> > I can't tell if there's something that you see that I don't see such
> > that we really /do/ need to actually write zeroes to the entire tail of
> > the rtextent; or if you weren't sure that forcing all the post-eof
> > fsblocks in the rtextent to unwritten (and zapping the pagecache) would
> > actually preserve the rtextsize alignment.
> 
> I haven't found any restrictions yet, and I also noticed that a simple
> write is not guaranteed to align the extent to rtextsize, since the write
> back path doesn't zeroing out the extra blocks that align to the
> rtextsize.
> 
>   # #extsize=28k
>   # xfs_io -d -f -c  "pwrite 0 4k" -c "fsync" /mnt/scratch/foo
>   # xfs_db -c "inode 131" -c "p u3.bmx" /dev/pmem2s
>      u3.bmx[0-1] = [startoff,startblock,blockcount,extentflag]
>      0:[0,0,1,0]
>      1:[1,1,6,1]
> 
> So I guess convert the tail fsblocks of the rtextent to unwritten status
> could work. However, I'm a little confused, besides the write operation,
> other operations like above punch hold and zero range, they seem to be
> doing their best to follow the alignment rule since commit fe341eb151ec
> ("xfs: ensure that fpunch, fcollapse, and finsert operations are aligned
> to rt extent size") [1], it looks like this commit is to fix some issues,
> so I'm not sure that converting to unwritten would always preserve the
> rtextsize alignment.
> 
> [1]. https://lore.kernel.org/linux-xfs/159950168085.582172.4254559621934598919.stgit@magnolia/

Looking at commit fe341eb151ec0 ("xfs: ensure that fpunch, fcollapse,
and finsert operations are aligned to rt extent size"), I think the
logic in xfs_free_file_space is wrong.  If bunmapi is told to unmap a
partial rt extent, it will instead convert it to unwritten; it only
unmaps full rt extents.  For punch that's ok because punch
opportunistically removes blocks and zeroes the unaligned segments; for
zero that's ok because it will falloc the sparse holes and zero the
rest.

It's only collapse and insert that *require* alignment.  That's
something that should be checked during input validation, and I think
that got fixed by 25219dbfa734e ("xfs: fix fallocate functions when
rtextsize is larger than 1").

> > 
> > (Or if there's something else?)
> > 
> >>                          And IIUC, the upcoming xfs force alignment
> >> extent feature seems also need to follow this alignment, right?
> > 
> > Yes.
> > 
> >>>
> >>>> xfs_truncate_page() should flush, zeros out the entire rtextsize range,
> >>>> and make sure the entire zeroed range have been flushed to disk before
> >>>> updating the inode size.
> >>>>
> >>>> Fixes: 943bc0882ceb ("iomap: don't increase i_size if it's not a write operation")
> >>>> Reported-by: Chandan Babu R <chandanbabu@kernel.org>
> >>>> Link: https://lore.kernel.org/linux-xfs/0b92a215-9d9b-3788-4504-a520778953c2@huaweicloud.com
> >>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> >>>> ---
> >>>>  fs/xfs/xfs_iomap.c | 35 +++++++++++++++++++++++++++++++----
> >>>>  fs/xfs/xfs_iops.c  | 10 ----------
> >>>>  2 files changed, 31 insertions(+), 14 deletions(-)
> >>>>
> >>>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> >>>> index 4958cc3337bc..fc379450fe74 100644
> >>>> --- a/fs/xfs/xfs_iomap.c
> >>>> +++ b/fs/xfs/xfs_iomap.c
> >>>> @@ -1466,12 +1466,39 @@ xfs_truncate_page(
> >>>>  	loff_t			pos,
> >>>>  	bool			*did_zero)
> >>>>  {
> >>>> +	struct xfs_mount	*mp = ip->i_mount;
> >>>>  	struct inode		*inode = VFS_I(ip);
> >>>>  	unsigned int		blocksize = i_blocksize(inode);
> >>>> +	int			error;
> >>>> +
> >>>> +	if (XFS_IS_REALTIME_INODE(ip))
> >>>> +		blocksize = XFS_FSB_TO_B(mp, mp->m_sb.sb_rextsize);
> >>>
> >>> Don't opencode xfs_inode_alloc_unitsize, please.
> >>
> >> Ha, I missed the latest added helper, thanks for pointing this out.
> >>
> >>>
> >>>> +
> >>>> +	/*
> >>>> +	 * iomap won't detect a dirty page over an unwritten block (or a
> >>>> +	 * cow block over a hole) and subsequently skips zeroing the
> >>>> +	 * newly post-EOF portion of the page. Flush the new EOF to
> >>>> +	 * convert the block before the pagecache truncate.
> >>>> +	 */
> >>>> +	error = filemap_write_and_wait_range(inode->i_mapping, pos,
> >>>> +					     roundup_64(pos, blocksize));
> >>>> +	if (error)
> >>>> +		return error;pos_in_block
> >>>
> >>> Ok so this is hoisting the filemap_write_and_wait_range call from
> >>> xfs_setattr_size.  It's curious that we need to need to twiddle anything
> >>> other than the EOF block itself though?
> >>
> >> Since we planed to zero out the dirtied range which is ailgned to the
> >> extsize instead of the blocksize, ensure one block is not unwritten is
> >> not enough, we should also make sure that the range which is going to
> >> zero out is not unwritten, or else the iomap_zero_iter() will skip
> >> zeroing out the extra blocks.
> >>
> >> For example:
> >>
> >> before zeroing:
> >>            |<-    extszie   ->|
> >>         ...dddddddddddddddddddd
> >>         ...UUUUUUUUUUUUUUUUUUUU
> >>            ^                  ^
> >>         new EOF             old EOF    (where 'd' means the pagecache is dirty)
> >>
> >> if we only flush the new EOF block, the result becomes:
> >>
> >>            |<-    extszie   ->|
> >>            zddddddddddddddddddd
> >>            ZUUUUUUUUUUUUUUUUUUU
> >>            ^                  ^
> >>         new EOF             old EOF
> >>
> >>
> >> then the dirty extent range that between new EOF block and the old EOF
> >> block can't be zeroed sine it's still unwritten. So we have to flush the
> >> whole range before zeroing out.
> > 
> > "Z" on the second line of the second diagram is a written fsblock with
> > the tail zeroed, correct?
> 
> Yeah,
> 
> > 
> > truncate_setsize -> truncate_pagecache unmaps all the pagecache after
> > the eof folio and unconditionally zeroes the tail of the eof folio
> > without regard to the mappings.  Doesn't that cover us here?  After the
> > truncate_setsize finishes, won't we end up in this state:
> > 
> >            |<-   rextsize   ->|
> >            zzzzzzzz               
> >            ZUUUUUUUUUUUUUUUUUUU
> >            ^      ^           ^
> >         new EOF   |         old EOF
> >                   folio boundary
> > 
> 
> Yeah, this case is fine, but the below case is not fine.
> 
> truncate                          write back
> xfs_setattr_size()
>  xfs_truncate_page()
>   filemap_write_and_wait_range(newsize, newsize) <- A
>   iomap_zero_range() <- B
>                                   flush dirty pages <- C
>  truncate_setsize() <- D
> 
> Please assume if a concurrent write back happenes just before
> truncate_setsize(), the state of the file changes as below:
> 
> A:
>               |<-    extszie   ->|
>               wddddddddddddddddddd (pagecache)
>               WUUUUUUUUUUUUUUUUUUU (disk)
>               ^                  ^
>            (new EOF)           old EOF  (where 'd' means the pagecache is dirty)
>                                         (where 'x' means the pagecache contianes user data)

"W", not "x", as you noted.

> 
> B:
>               |<-    extszie   ->|
>               zddddddddddddddddddd
>               ZUUUUUUUUUUUUUUUUUUU
>               ^                  ^
>            (new EOF)           old EOF  (where 'z' means the pagecache is zero)
> 
> C:
>               |<-    extszie   ->|
>               zwwwwwwwwwwwwwwwwwww
>               ZWWWWWWWWWWWWWWWWWWW
>               ^                  ^
>            (new EOF)           old EOF
> 
> D:
>               |<-    extszie   ->|
>               zzzzzzzzz
>               ZWWWWWWWWWWWWWWWWWWW
>               ^       ^          ^
>             new EOF   |       (old EOF)
>                       folio boundary

Hmm.  At point D we still hold i_rwsem and the invalidate_lock, so could
we convert the underlying blocks to unwritten here instead of writing
them all out?  Once we reduce i_size, writeback will stop at EOF, right?

D:
              |<-    extszie   ->|
              zzzzzzzzz
              ZUUUUUUUUUUUUUUUUUUU
              ^       ^          ^
            new EOF   |       (old EOF)
                      folio boundary

--D

> 
> Thanks,
> Yi.
> 
> >>>
> >>>>  
> >>>>  	if (IS_DAX(inode))
> >>>> -		return dax_truncate_page(inode, pos, blocksize, did_zero,
> >>>> -					&xfs_dax_write_iomap_ops);
> >>>> -	return iomap_truncate_page(inode, pos, blocksize, did_zero,
> >>>> -				   &xfs_buffered_write_iomap_ops);
> >>>> +		error = dax_truncate_page(inode, pos, blocksize, did_zero,
> >>>> +					  &xfs_dax_write_iomap_ops);
> >>>> +	else
> >>>> +		error = iomap_truncate_page(inode, pos, blocksize, did_zero,
> >>>> +					    &xfs_buffered_write_iomap_ops);
> >>>> +	if (error)
> >>>> +		return error;
> >>>> +
> >>>> +	/*
> >>>> +	 * Write back path won't write dirty blocks post EOF folio,
> >>>> +	 * flush the entire zeroed range before updating the inode
> >>>> +	 * size.
> >>>> +	 */
> >>>> +	return filemap_write_and_wait_range(inode->i_mapping, pos,
> >>>> +					    roundup_64(pos, blocksize));
> >>>
> >>> ...but what is the purpose of the second filemap_write_and_wait_range
> >>> call?  Is that to flush the bytes between new and old EOF to disk before
> >>> truncate_setsize invalidates the (zeroed) pagecache?
> >>>
> >>
> >> The second filemap_write_and_wait_range() call is used to make sure that
> >> the zeroed data be flushed to disk before we updating i_size. If we don't
> >> add this one, once the i_size is been changed, the zeroed data which
> >> beyond the new EOF folio(block) couldn't be write back, because
> >> iomap_writepage_map()->iomap_writepage_handle_eof() skip that range, so
> >> the stale data problem is still there.
> >>
> >> For example:
> >>
> >> before zeroing:
> >>            |<-    extszie   ->|
> >>            wwwwwwwwwwwwwwwwwwww (pagecache)
> >>         ...WWWWWWWWWWWWWWWWWWWW (disk)
> >>            ^                  ^
> >>         new EOF               EOF   (where 'w' means the pagecache contains data)
> >>
> >> then iomap_truncate_page() zeroing out the pagecache:
> >>
> >>            |<-    extszie   ->|
> >>            zzzzzzzzzzzzzzzzzzzz (pagecache)
> >>            WWWWWWWWWWWWWWWWWWWW (disk)
> >>            ^                  ^
> >>         new EOF               EOF
> >>
> >> then update i_size, sync and drop cache:
> >>
> >>            |<-    extszie   ->|
> >>            ZWWWWWWWWWWWWWWWWWWW (disk)
> >>            ^
> >>            EOF
> > 
> > <nod> Ok, so this second call to filemap_write_and_wait_range flushes
> > the newly written pagecache to disk.  If it doesn't work to
> > force-convert the tail fsblocks of the rtextent to unwritten status,
> > then I suppose this is necessary if @blocksize != mp->m_sb.blocksize.
> > 
> > --D
> > 
> >> Thanks,
> >> Yi.
> >>
> >>>
> >>>>  }
> >>>> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> >>>> index 66f8c47642e8..baeeddf4a6bb 100644
> >>>> --- a/fs/xfs/xfs_iops.c
> >>>> +++ b/fs/xfs/xfs_iops.c
> >>>> @@ -845,16 +845,6 @@ xfs_setattr_size(
> >>>>  		error = xfs_zero_range(ip, oldsize, newsize - oldsize,
> >>>>  				&did_zeroing);
> >>>>  	} else {
> >>>> -		/*
> >>>> -		 * iomap won't detect a dirty page over an unwritten block (or a
> >>>> -		 * cow block over a hole) and subsequently skips zeroing the
> >>>> -		 * newly post-EOF portion of the page. Flush the new EOF to
> >>>> -		 * convert the block before the pagecache truncate.
> >>>> -		 */
> >>>> -		error = filemap_write_and_wait_range(inode->i_mapping, newsize,
> >>>> -						     newsize);
> >>>> -		if (error)
> >>>> -			return error;
> >>>>  		error = xfs_truncate_page(ip, newsize, &did_zeroing);
> >>>>  	}
> >>>>  
> >>>> -- 
> >>>> 2.39.2
> >>>>
> >>>>
> >>
> >>
> 
> 

