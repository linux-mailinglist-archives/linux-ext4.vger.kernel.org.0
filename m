Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC837DA1B1
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Oct 2019 00:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393306AbfJPWpS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Oct 2019 18:45:18 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52205 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726417AbfJPWpS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Oct 2019 18:45:18 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9GMjC6I026587
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Oct 2019 18:45:12 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AE6F2420458; Wed, 16 Oct 2019 18:45:11 -0400 (EDT)
Date:   Wed, 16 Oct 2019 18:45:11 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 09/13] ext4: fast-commit commit path changes
Message-ID: <20191016224511.GI11103@mit.edu>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
 <20191001074101.256523-10-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001074101.256523-10-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 01, 2019 at 12:40:58AM -0700, Harshad Shirwadkar wrote:
> This patch implements the actual commit path for fast commit. Based on
> inodes tracked and their respective changes remembered, this
> patch adds code to create a fast commit block that stores extents
> added as well as dentrys created for the inode. We use new JBD2
> interfaces added in previous patches in this series. The fast commit
> blocks that are created have extents that _should_ be present in the
> file. It doesn't yet support removing of extents, making operations
> such as truncate, delete fast commit incompatible.

This affects some of the earlier patches, but I didn't realize this
until now.  Right now, what we're doing is when initiate an fast
commit, we are writing out all fast-commit eligible inodes (and
flushing out any associated data blocks needed to maintain
data=ordered guarantees).

We don't actually have to do this.  Strictly speaking, we only have to
write out the specific inode being fsync'ed, or the specific inode for
which ext4_nfs_commit_metdata() has been called.  For an fsync()
workload, especially one where for example, we might have hundreds of
modified inodes, all of which are fc-eligible --- for example, because
a kernel build is happening in the background, and a single file which
is being fsync'ed --- for example because the programmer has just
saved a source file in emacs ---- we only need to include that single
inode in the fast commit.  Including *all* of the inodes in the
i_fc_list in the fast commit, is wasted effort, especially since the
inodes in question will be committed within the next 5 seconds.

Now, in the case of ext4_nfs_commit_metadata(), we know that NFS is
*very* aggressive at calling commit_metadata, and so writing out all
of the FC-eligible commit is probably a good thing to do.  So we might
want to do different things depending on whether the FC is being
initiated via fsync() or fdatasync() versus commit_metadata().

The other reason why it's better to only do this for
ext4_nfs_commit_metadata() is because if we only write out the inode
which is being fsync'ed, we don't have worry about fairness concerned,
since the I/O will be charged to the process/cgroup who requested the
fsync.  If we write out *all* the fc-eligible inodes in the FC commit,
then they will get charged to the process doing the fsync(2).  Whereas
for an NFS server, we don't care about cgroups, since they can all be
charged to the NFS server.


> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index 0bb8de2139a5..fd7740372438 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -4,6 +4,7 @@
> +static void ext4_end_buffer_io_sync(struct buffer_head *bh, int uptodate)
> +{
> +	struct buffer_head *orig_bh = bh->b_private;
> +
> +	BUFFER_TRACE(bh, "");
> +	if (uptodate) {
> +		ext4_debug("%s: Block %lld up-to-date",
> +			   __func__, bh->b_blocknr);
> +		set_buffer_uptodate(bh);
> +	} else {
> +		ext4_debug("%s: Block %lld not up-to-date",
> +			   __func__, bh->b_blocknr);
> +		clear_buffer_uptodate(bh);
> +	}
> +	if (orig_bh) {
> +		clear_bit_unlock(BH_Shadow, &orig_bh->b_state);
> +		/* Protect BH_Shadow bit in b_state */
> +		smp_mb__after_atomic();
> +		wake_up_bit(&orig_bh->b_state, BH_Shadow);
> +	}

We don't need to deal with BH_Shadow handling here.  This is needed
when we are writing out buffer heads correspond to ext4 metadata
(e.g., an inode table block, a block group descriptor block).  We're
only writing out bh's corresponding to the journal, so the BH_Shadow
bit should never be set on such bh's.

> +static inline u8 *fc_add_tag(u8 *dst, u16 tag, u16 len, u8 *val)

Can you add some documentation for this function?  In particular, what
does it return?  I also tend to prefer to pass in the pointer to the
buffer (val) first, followed then by the length (len), but that's more
of a personal preference.

> +int ext4_fc_write_inode(journal_t *journal, struct buffer_head *bh,
> +			struct inode *inode, tid_t tid, tid_t subtid,
> +			int is_last, struct dentry *dentry)
> +{

  ...
> +
> +	memcpy(&fc_hdr->inode, ext4_raw_inode(&iloc), EXT4_INODE_SIZE(sb));

So this is a bit problematic.  In the structure definition,
fc_hdr->inode is not at the end of the structure

struct ext4_fc_commit_hdr {
	/* Fast commit magic, should be EXT4_FC_MAGIC */
	__le32 fc_magic;
	...	
	/* ext4 inode on disk copy */
	struct ext4_inode inode;
	/* Csum(hdr+contents) */
	__le32 fc_csum;
};

... and the size of struct ext4_inode is just the fixed portion of the
inode, and is almost always smaller than EXT4_INODE_SIZE(sb) ---
except in the case of 128 byte inodes, in which case the fields
i_extra_isize and beyond going to be beyond the 128 byte limit.

So this isn't going to work.  I'm guessing you didn't test with
extended attributes, because the checksum would have overwritten the
beginning of the in-inode xattrs?

Also, note that EXT4_INODE_SIZE(sb) can be set to the block size.
It's super-rare, but that is legal.  Which means we need to test for
that case somewhere, and either (a) disable fast commits when the
inode size == blocksize, or (b) support a fast commit log which is
larger than a single block.  (This is doable, since there is a
checksum field to protect against partial writes.)

> +struct ext4_fc_commit_hdr {
> +	/* Fast commit magic, should be EXT4_FC_MAGIC */
> +	__le32 fc_magic;
> +	/* Sub transaction ID */
> +	__le32 fc_subtid;
> +	/* Features used by this fast commit block */
> +	__u8 fc_features;
> +	/* Flags for this block. */
> +	__u8 fc_flags;

What fs_features and fc_flags are you thinking we would need?  I can't
think of a good reasons to have per-fc block features.  But I can
think of reasons why we might want to support a small number of blocks
in an fc entry.  So maybe repurpose fc_features with some limit, such
as say, 4 blocks, and on the replay side we can just kmalloc 4 *
blocksize worth of space to read in that number of blocks if
necessary?

> +	/* Number of TLVs in this fast commmit block */
> +	__le16 fc_num_tlvs;
> +	/* Inode number */
> +	__le32 fc_ino;
> +	/* ext4 inode on disk copy */
> +	struct ext4_inode inode;
> +	/* Csum(hdr+contents) */
> +	__le32 fc_csum;

I'd suggest putting the checksum at the very end of the fc entry.
e.g., at offset 4092 if there is only a single block in the fc commit
entry.  Also, I'd make sure that we explicitly zero all of the bytes
at the end of the TLV section and the checksum, and specify that the
checksum is calculated including the must-be-zero padding, just to
keep things simple.

						- Ted
