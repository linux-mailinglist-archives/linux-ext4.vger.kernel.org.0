Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7E0797E96
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Aug 2019 17:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfHUPWL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Aug 2019 11:22:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46524 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfHUPWL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Aug 2019 11:22:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LFM3B0152366;
        Wed, 21 Aug 2019 15:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=CEWc2/57ajaaKryQUmo+Ix2Pck5UxG2uqy9ILedc5AI=;
 b=fzazy3qvO5xFvzT0+vG5btxRFABjIpgUJqVW+6rRx70NtatqCUg0vqI1nDbd63bHsT2Y
 dd2tku34yQkw9gnWBzzhcdKt43SxtXjuFNZrQGOebMpquk8XHJlPsUg6xVGcD+kuoHZR
 bZ4tWgFFMhICJs0VdxdvzjStOREDP/MZy842ao3fKnH9jQrHmQVReVCjvU0prnGZKSpT
 Ae7nKVVu0F/LmvwwAT+cYf7/KM+If+ALkOevYViAO2rbaM6CAk+WwyTTfgZsbabEZMIz
 5Yl/uUvBiA7+ES8sqKkhynBuGus52E4DflKZRbp65Nrh7Ba44DCmQkHV3JUgGL9H0zkI Gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2ue9hpp8tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 15:22:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LFIhHM165953;
        Wed, 21 Aug 2019 15:21:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2ugj7qjdqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 15:21:22 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7LFLMEf010689;
        Wed, 21 Aug 2019 15:21:22 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 08:21:22 -0700
Date:   Wed, 21 Aug 2019 08:21:21 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 12/12] docs: Add fast commit documentation
Message-ID: <20190821152121.GD1037422@magnolia>
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
 <20190809034552.148629-13-harshadshirwadkar@gmail.com>
 <20190816010029.GA15175@magnolia>
 <CAD+ocbxDBeudogBdDaf5A-KRB9s5UiKCGq4uQFMnwAXybvzD1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbxDBeudogBdDaf5A-KRB9s5UiKCGq4uQFMnwAXybvzD1A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210162
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 19, 2019 at 11:38:42PM -0700, harshad shirwadkar wrote:
> On Thu, Aug 15, 2019 at 6:00 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> >
> > On Thu, Aug 08, 2019 at 08:45:52PM -0700, Harshad Shirwadkar wrote:
> > > This patch adds necessary documentation to
> > > Documentation/filesystems/journalling.rst and
> > > Documentation/filesystems/ext4/journal.rst.
> > >
> > > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > > ---
> > >  Documentation/filesystems/ext4/journal.rst | 96 ++++++++++++++++++++--
> > >  Documentation/filesystems/journalling.rst  | 15 ++++
> > >  2 files changed, 105 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/Documentation/filesystems/ext4/journal.rst b/Documentation/filesystems/ext4/journal.rst
> > > index ea613ee701f5..d6e4a698e208 100644
> > > --- a/Documentation/filesystems/ext4/journal.rst
> > > +++ b/Documentation/filesystems/ext4/journal.rst
> > > @@ -29,10 +29,14 @@ safest. If ``data=writeback``, dirty data blocks are not flushed to the
> > >  disk before the metadata are written to disk through the journal.
> > >
> > >  The journal inode is typically inode 8. The first 68 bytes of the
> > > -journal inode are replicated in the ext4 superblock. The journal itself
> > > -is normal (but hidden) file within the filesystem. The file usually
> > > -consumes an entire block group, though mke2fs tries to put it in the
> > > -middle of the disk.
> > > +journal inode are replicated in the ext4 superblock. The journal
> > > +itself is normal (but hidden) file within the filesystem. The file
> > > +usually consumes an entire block group, though mke2fs tries to put it
> > > +in the middle of the disk. Last 128 blocks in the journal are reserved
> > > +for fast commits. Fast commits store metadata changes to inodes in an
> > > +incremental fashion. A fast commit is valid only if there is no full
> > > +commit after that particular fast commit. That makes fast commit space
> > > +reusable after every full commit.
> > >
> > >  All fields in jbd2 are written to disk in big-endian order. This is the
> > >  opposite of ext4.
> > > @@ -48,16 +52,18 @@ Layout
> > >  Generally speaking, the journal has this format:
> > >
> > >  .. list-table::
> > > -   :widths: 16 48 16
> > > +   :widths: 16 48 16 18
> > >     :header-rows: 1
> > >
> > >     * - Superblock
> > >       - descriptor\_block (data\_blocks or revocation\_block) [more data or
> > >         revocations] commmit\_block
> > >       - [more transactions...]
> > > +     - [Fast commits...]
> > >     * -
> > >       - One transaction
> > >       -
> > > +     -
> > >
> > >  Notice that a transaction begins with either a descriptor and some data,
> > >  or a block revocation list. A finished transaction always ends with a
> > > @@ -76,7 +82,7 @@ The journal superblock will be in the next full block after the
> > >  superblock.
> > >
> > >  .. list-table::
> > > -   :widths: 12 12 12 32 12
> > > +   :widths: 12 12 12 32 12 12
> > >     :header-rows: 1
> > >
> > >     * - 1024 bytes of padding
> > > @@ -85,11 +91,13 @@ superblock.
> > >       - descriptor\_block (data\_blocks or revocation\_block) [more data or
> > >         revocations] commmit\_block
> > >       - [more transactions...]
> > > +     - [Fast commits...]
> > >     * -
> > >       -
> > >       -
> > >       - One transaction
> > >       -
> > > +     -
> > >
> > >  Block Header
> > >  ~~~~~~~~~~~~
> > > @@ -609,3 +617,79 @@ bytes long (but uses a full block):
> > >       - h\_commit\_nsec
> > >       - Nanoseconds component of the above timestamp.
> > >
> > > +Fast Commit Block
> > > +~~~~~~~~~~~~~~~~~
> > > +
> > > +The fast commit block indicates an append to the last commit block
> > > +that was written to the journal. One fast commit block records updates
> > > +to one inode. So, typically you would find as many fast commit blocks
> > > +as the number of inodes that got changed since the last commit. A fast
> > > +commit block is valid only if there is no commit block present with
> > > +transaction ID greater than that of the fast commit block. If such a
> > > +block a present, then there is no need to replay the fast commit
> > > +block.
> > > +
> > > +Multiple fast commit blocks are a part of one sub-transaction. To
> > > +indicate the last block in a fast commit transaction, fc_flags field
> > > +in the last block in every subtransaction is marked with "LAST" (0x1)
> > > +flag. A subtransaction is valid only if all the following conditions
> > > +are met:
> > > +
> > > +1) SUBTID of all blocks is either equal to or greater than SUBTID of
> > > +   the previous fast commit block.
> > > +2) For every sub-transaction, last block is marked with LAST flag.
> > > +3) There are no invalid blocks in between.
> > > +
> > > +.. list-table::
> > > +   :widths: 8 8 24 40
> > > +   :header-rows: 1
> > > +
> > > +   * - Offset
> > > +     - Type
> > > +     - Name
> > > +     - Descriptor
> > > +   * - 0x0
> > > +     - journal\_header\_s
> > > +     - (open coded)
> > > +     - Common block header.
> > > +   * - 0xC
> > > +     - \_\_le32
> > > +     - fc\_magic
> > > +     - Magic value which should be set to 0xE2540090. This identifies
> > > +       that this block is a fast commit block.
> > > +   * - 0x10
> > > +     - \_\_le32
> > > +     - fc\_subtid
> > > +     - Sub-transaction ID for this commit block
> > > +   * - 0x14
> > > +     - \_\_u8
> > > +     - fc\_features
> > > +     - Features used by this fast commit block.
> > > +   * - 0x15
> > > +     - \_\_u8
> > > +     - fc_flags
> > > +     - Flags. (0x1(Last) - Indicates that this is the last block in sub-transaction)
> > > +   * - 0x16
> > > +     - \_\_le16
> > > +     - fc_num_tlvs
> > > +     - Number of TLVs contained in this fast commit block
> > > +   * - 0x18
> > > +     - \_\_le32
> > > +     - \_\_fc\_len
> > > +     - Length of the fast commit block in terms of number of blocks
> > > +   * - 0x2c
> > > +     - \_\_le32
> > > +     - fc\_ino
> > > +     - Inode number of the inode that will be recovered using this fast commit
> > > +   * - 0x30
> > > +     - struct ext4\_inode
> > > +     - inode
> > > +     - On-disk copy of the inode at the commit time
> > > +   * - 0x34
> > > +     - struct ext4\_fc\_tl
> > > +     - Array of struct ext4\_fc\_tl
> > > +     - The actual delta with the last commit. Starting at this offset,
> > > +       there is an array of TLVs that indicates which all extents
> > > +       should be present in the corresponding inode. Currently, the
> > > +       only tag that is supported is EXT4\_FC\_TAG\_EXT. That tag
> > > +       indicates that the corresponding value is an extent.
> >
> > This is a good start, but what's the structure of struct ext4_fc_tl ?
> > It's written to disk, it should be here too.  Looks like it's mostly
> > just an array of ondisk extent structures?
> Thanks, I'll update this in next version. struct ext4_fc_tl is a
> generic tag-length-value container that currently holds only extents
> that were added to a file after last commit.

<nod> If they're the same format as the extent map records then I think
you can just reference that part of the documentation.

> > So if I read this right, this first fastcommit tag type seems to be an
> > inode core and an array of extents which ... I guess are the extents
> > that were allocated and mapped into the file?  So therefore journal
> > replay of this metadata update becomes a simple matter of logging the
> > new inode core, adding the associated fc extent records to the extent
> > map, and marking the corresponding parts of the block bitmap in use?
> >
> Yes, that's precisely what is done here.
> > I'm wondering why these fast commits aren't written inline with the
> > regular jbd2 transaction block stream?  i.e.
> >
> > [descriptors][blocks][commit][fastcommit][fastcommit][descriptor...]
> >
> After a full commit all previous fast commits are invalid. So, if we

All of them, fs-wide?  Or just the ones for that particular inode?

> inline fast commits with corresponding transactions, we'll end up
> wasting a whole lot of journal space. So, fast commit area is kept
> separate from the normal journaling area and after every transaction
> commit, fast commit space is reused. But, if we could overwrite fast
> commit blocks with the final commit then it's possible to inline fast
> commit blocks with the transaction stream without losing journal
> space. So, fast commit could just write a fast commit block after
> previous transaction and when next transaction commits, it could
> simply overwrite previous fast commit blocks.

<nod>

> > That way jbd2 replay just adds a case for a journal block with h_magic
> > == JBD2_FC_MAGIC where it checkpoints whatever it had staged at that
> > point, throws the fast commit block up to ext4 to do whatever, and then
> > continues on replaying regular transactions?  I get this feeling like
> > fastcommit is a journal that runs inside of/alongside jbd2 and wonder
> > why not just integrate it better with jbd2?
> Hmmm, I agree, we want fast commits to be as close to jbd2 as possible.

:)

--D

> >
> > > diff --git a/Documentation/filesystems/journalling.rst b/Documentation/filesystems/journalling.rst
> > > index 58ce6b395206..2e0d550b546c 100644
> > > --- a/Documentation/filesystems/journalling.rst
> > > +++ b/Documentation/filesystems/journalling.rst
> > > @@ -115,6 +115,21 @@ called after each transaction commit. You can also use
> > >  ``transaction->t_private_list`` for attaching entries to a transaction
> > >  that need processing when the transaction commits.
> > >
> > > +JBD2 also allows client file systems to implement file system specific
> > > +commits which are called as ``fast commits``. File systems that wish
> > > +to use this feature should first set
> > > +``journal->j_fc_commit_callback``. That function is called before
> > > +performing a commit. File system can call :c:func:`jbd2_map_fc_buf()`
> > > +to get buffers reserved for fast commits. If file system returns 0,
> > > +JBD2 assumes that file system performed a fast commit and it backs off
> > > +from performing a commit. Otherwise, JBD2 falls back to normal full
> >
> > Huh.  Ok, so the caller I guess grabs fastcommit blocks, writes the
> > intent to the fc block, and pushes it to disk, after which we can return
> > to userspace.  Some time later jbd2 gets around to committing things so
> > it calls back with ->j_fc_commit_callback at which point we say "Oh! I
> > already wrote that to disk as a fastcommit, so return 0" and jbd2
> > shrugs and moves on to the next transaction?
> I am sorry for the confusing wording here, let me fix it in the next
> version. So, either when fsync() is called or when jbd2 wakes up, in
> both case, journal->j_fc_commit_callback() is invoked by jbd2. In
> other words, journal->j_fc_commit_callback() is the main fastcommit
> "commit" routine. If j_fc_commit_callback() returns 0, jbd2 knows that
> file system was able to perform a fast commit and in that case a full
> commit is not needed. But, there are scenarios when file system thinks
> that it would rather do a full commit. File system can think that for
> a couple of reasons - accumulated work is too much to fit in fast
> commit region, accumulated work is too much to have any performance
> benefits, a complex operation (such as punch hole) was performed for
> which there's no fast commit support yet. In such cases,
> j_fc_commit_callback() can simply return a non-zero value to tell jbd2
> to perform a full traditional commit.
> 
> Thanks,
> Harshad
> >
> > --D
> >
> > > +commit. After performing either a fast or a full commit, JBD2 calls
> > > +``journal->j_fc_cleanup_cb`` to allow file systems to perform cleanups
> > > +for their internal fast commit related data structures. At the replay
> > > +time, JBD2 passes each and every fast commit block to the file system
> > > +via ``journal->j_fc_replay_cb``. Ext4 effectively uses this fast
> > > +commit mechanism to improve journal commit performance.
> > > +
> > >  JBD2 also provides a way to block all transaction updates via
> > >  :c:func:`jbd2_journal_lock_updates()` /
> > >  :c:func:`jbd2_journal_unlock_updates()`. Ext4 uses this when it wants a
> > > --
> > > 2.23.0.rc1.153.gdeed80330f-goog
> > >
