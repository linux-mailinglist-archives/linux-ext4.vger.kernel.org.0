Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD901136A3B
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jan 2020 10:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgAJJuO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Jan 2020 04:50:14 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:42266 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbgAJJuO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Jan 2020 04:50:14 -0500
Received: by mail-wr1-f43.google.com with SMTP id q6so1142280wro.9
        for <linux-ext4@vger.kernel.org>; Fri, 10 Jan 2020 01:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2Noafxiusi7PCsOfWo8Y/1x+/oBM2ujtAQJWGslvpLc=;
        b=jp43IsbWedRxswb3piTyjq6AWeCrOxGhjRmVxq6fo9N3VCFHI7lsuDO6I+xmNE+LyD
         zxxWEzpfLf+2GyOwS6KSVZBGvsXKzAVMfAPijHC5WP10m3Fi2R76T351JXlrY99okhIq
         cEXz3SndGV9P5TPPNqu1lDy2mWuNA7pgDnw+mdKwhc5lsxfqjifMDf1tPg4Rrs51m4yC
         t36NQZ4gyuBtdkcXsOiRc1XzR2VXyuK6BuON3g3bblhe+sQQkS5IRlaOFhCLybe1ACM2
         xBjmw91qMGF47rw0RZ9TJ1FfqMoG6Pdn8xEpbaBYsGcY2YphBc3If1hTvcHIdB16Uzea
         6dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2Noafxiusi7PCsOfWo8Y/1x+/oBM2ujtAQJWGslvpLc=;
        b=HKsNlyOc1j2gU6WtBSo/zn76uVcx9s6WRc5z9iC3tEaBreJFVIaP2tHLxRvVXG7ThN
         ShjznamQX4fQ6PCYEw4mffh0UyS+DTU29Q3xlQAYBRrBgQbPedovw3ROMYXFXSGI2/iH
         1EzRr6Zfm5oNwK7nlRBS9wPPozxsVCIG/rsZYrmmXH/vWvUpv0shznMdlN3hrlwjUpPq
         4C02StTnuaNRvC6cwK2g/BZELd43nIYi8fzEJy9vCd05CJAgea68k8V+0lhaPcjO7vvM
         cKTIPsyxEAJxPI0aCkJ72J2g5BkC5cTOoUf+1DLsxEEZgJnNOIfqbrAEGJepyI+lufZH
         ASxw==
X-Gm-Message-State: APjAAAU/anw87DHP9gspB/qMkq9OJNPNauXHADxDfPJdnFQZyUUXn84e
        RSBrcwoAlUlkXBdoL5foAJ/TlGiG+xL/xkWpQQC+gNHSNH4=
X-Google-Smtp-Source: APXvYqzNTXXculHYnpOd/6C4bSEK8R2PY/IiWCsNQd0YC131ygmygeIfK3ICDoX6UiT5CV+PDydAWpFxXUhxg55OGcs=
X-Received: by 2002:adf:b605:: with SMTP id f5mr2420986wre.383.1578649809051;
 Fri, 10 Jan 2020 01:50:09 -0800 (PST)
MIME-Version: 1.0
References: <20191224081324.95807-1-harshadshirwadkar@gmail.com> <CAAJeciV7bVN9HKz=FTQ1eSLXX_7E2ccuH9Za3vzBWHsgHuZEiw@mail.gmail.com>
In-Reply-To: <CAAJeciV7bVN9HKz=FTQ1eSLXX_7E2ccuH9Za3vzBWHsgHuZEiw@mail.gmail.com>
From:   xiaohui li <lixiaohui1@xiaomi.corp-partner.google.com>
Date:   Fri, 10 Jan 2020 17:49:56 +0800
Message-ID: <CAAJeciUqNmZdVbFhCsLO+3FLqhRjhtVh1NB5yr0ET=GYvzGPtQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/20] ext4: update docs for fast commit feature
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

hi Harshad=EF=BC=9A

I apologize for my some direct and improper speaking in my last email.

what i want to say in my last email is that maybe an iterative
software development method can be better for patches application.
for the first release version, we can not do everything. it is good
enough if we can have finished just one major function in ext4 fast
commit field.

I have known that develop work of this fast commit function is more
difficult and more complex.
so i am very grateful for your work on field of ext4 fast commit developmen=
t. :)

On Thu, Jan 9, 2020 at 12:29 PM xiaohui li
<lixiaohui1@xiaomi.corp-partner.google.com> wrote:
>
> hi Harshad
> cc ted
>
> sorry, but i have some idea about this fast commit which i want to
> share with you.
>
> there are nearly 20 patches about this v4 fast commit , so many patches.
> I wonder if necessary to make this fast commit function so complexly.
>
> maybe i have not understand the difficulty of the fast commit coding work=
.
> so I appreciate it very much if you give some more detailed
> descriptions about the patches correlationship of v4 fast commit,
> especially the reason why need have so many patches.
>
> from my viewpoint, the purpose of doing this fast commit function is
> to resolve the ext4 fsync time-cost-so-much problem.
> firstly we need to resolve some actual customer problems which exist
> in ext4 filesystems when doing this fast commit function.
>
> so the first release version of fast commit is just only to accomplish
> the goal of reducing the time cost of fsync because of jbd2 order
> shortcoming described in ijournal paper from my opinion.
> it need not do so many other unnecessary things.
>
> if i have free time , I will review these patches continually.
>  thank you for your reply.
>
>
>
>
>
> On Tue, Dec 24, 2019 at 4:14 PM Harshad Shirwadkar
> <harshadshirwadkar@gmail.com> wrote:
> >
> > This patch series adds support for fast commits which is a simplified
> > version of the scheme proposed by Park and Shin, in their paper,
> > "iJournaling: Fine-Grained Journaling for Improving the Latency of
> > Fsync System Call"[1]. The basic idea of fast commits is to make JBD2
> > give the client file system an opportunity to perform a faster
> > commit. Only if the file system cannot perform such a commit
> > operation, then JBD2 should fall back to traditional commits.
> >
> > Because JBD2 operates at block granularity, for every file system
> > metadata update it commits all the changed blocks are written to the
> > journal at commit time. This is inefficient because updates to some
> > blocks that JBD2 commits are derivable from some other blocks. For
> > example, if a new extent is added to an inode, then corresponding
> > updates to the inode table, the block bitmap, the group descriptor and
> > the superblock can be derived based on just the extent information and
> > the corresponding inode information. So, if we take this relationship
> > between blocks into account and replay the journalled blocks smartly,
> > we could increase performance of file system commits significantly.
> >
> > Fast commits introduced in this patch have two main contributions:
> >
> > (1) Making JBD2 fast commit aware, so that clients of JBD2 can
> >     implement fast commits
> >
> > (2) Add support in ext4 to use JBD2's new interfaces and implement
> >     fast commits.
> >
> > Ext4 supports two modes of fast commits: 1) fast commits with hard
> > consistency guarantees 2) fast commits with soft consistency guarantees
> >
> > When hard consistency is enabled, fast commit guarantees that all the
> > updates will be committed. After a successful replay of fast commits
> > blocks in hard consistency mode, the entire file system would be in
> > the same state as that when fsync() returned before crash. This
> > guarantee is similar to what jbd2 gives with full commits.
> >
> > With soft consistency, file system only guarantees consistency for the
> > inode in question. In this mode, file system will try to write as less
> > data to the backend as possible during the commit time. To be precise,
> > file system records all the data updates for the inode in question and
> > directory updates that are required for guaranteeing consistency of the
> > inode in question.
> >
> > In our evaluations, fast commits with hard consistency performed
> > better than fast commits with soft consistency. That's because with
> > hard consistency, a fast commit often ends up committing other inodes
> > together, while with soft consistency commits get serialized. Future
> > work can look at creating hybrid approach between the two extremes
> > that are there in this patchset.
> >
> > Testing
> > -------
> >
> > e2fsprogs was updated to set fast commit feature flag and to ignore
> > fast commit blocks during e2fsck.
> >
> > https://github.com/harshadjs/e2fsprogs.git
> >
> > After applying all the patches in this series, following runs of
> > xfstests were performed:
> >
> > - kvm-xfstest.sh -g log -c 4k
> > - kvm-xfstests.sh smoke
> >
> > All the log tests were successful and smoke tests didn't introduce any
> > additional failures.
> >
> > Performance Evaluation
> > ----------------------
> >
> > Ext4 file system performance was tested with full commits, with fast
> > commits with soft consistency and with fast commits with hard
> > consistency. fs_mark benchmark showed that depending on the file size,
> > performance improvement was seen up to 50%. Soft fast commits performed
> > slightly worse than hard fast commits. But soft fast commits ended up
> > writing slightly lesser number of blocks on disk.
> >
> > Changes since V3:
> >
> > - Removed invocation of fast commits from the jbd2 thread.
> >
> > - Removed sub transaction ID from journal_t.
> >
> > - Added rename, truncate, punch hole support.
> >
> > - Added soft consistency mode and hard consistency mode.
> >
> > - More bug fixes and refactoring.
> >
> > - Added better debugging support: more tracepoints and debug mount
> >   options.
> >
> > Harshad Shirwadkar(20):
> >  ext4: add debug mount option to test fast commit replay
> >  ext4: add fast commit replay path
> >  ext4: disable certain features in replay path
> >  ext4: add idempotent helpers to manipulate bitmaps
> >  ext4: fast commit recovery path preparation
> >  jbd2: add fast commit recovery path support
> >  ext4: main commit routine for fast commits
> >  jbd2: add new APIs for commit path of fast commits
> >  ext4: add fast commit on-disk format structs and helpers
> >  ext4: add fast commit track points
> >  ext4: break ext4_unlink() and ext4_link()
> >  ext4: add inode tracking and ineligible marking routines
> >  ext4: add directory entry tracking routines
> >  ext4: add generic diff tracking routines and range tracking
> >  jbd2: fast commit main commit path changes
> >  jbd2: disable fast commits if journal is empty
> >  jbd2: add fast commit block tracker variables
> >  ext4, jbd2: add fast commit initialization routines
> >  ext4: add handling for extended mount options
> >  ext4: update docs for fast commit feature
> >
> >  Documentation/filesystems/ext4/journal.rst |  127 ++-
> >  Documentation/filesystems/journalling.rst  |   18 +
> >  fs/ext4/acl.c                              |    1 +
> >  fs/ext4/balloc.c                           |   10 +-
> >  fs/ext4/ext4.h                             |  127 +++
> >  fs/ext4/ext4_jbd2.c                        | 1484 ++++++++++++++++++++=
+++++++-
> >  fs/ext4/ext4_jbd2.h                        |   71 ++
> >  fs/ext4/extents.c                          |    5 +
> >  fs/ext4/extents_status.c                   |   24 +
> >  fs/ext4/fsync.c                            |    2 +-
> >  fs/ext4/ialloc.c                           |  165 +++-
> >  fs/ext4/inline.c                           |    3 +
> >  fs/ext4/inode.c                            |   77 +-
> >  fs/ext4/ioctl.c                            |    9 +-
> >  fs/ext4/mballoc.c                          |  157 ++-
> >  fs/ext4/mballoc.h                          |    2 +
> >  fs/ext4/migrate.c                          |    1 +
> >  fs/ext4/namei.c                            |  172 ++--
> >  fs/ext4/super.c                            |   72 +-
> >  fs/ext4/xattr.c                            |    6 +
> >  fs/jbd2/commit.c                           |   61 ++
> >  fs/jbd2/journal.c                          |  217 +++-
> >  fs/jbd2/recovery.c                         |   67 +-
> >  include/linux/jbd2.h                       |   83 +-
> >  include/trace/events/ext4.h                |  208 +++-
> >  25 files changed, 3037 insertions(+), 132 deletions(-)
> > ---
> >  Documentation/filesystems/ext4/journal.rst | 127 ++++++++++++++++++++-
> >  Documentation/filesystems/journalling.rst  |  18 +++
> >  2 files changed, 139 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/filesystems/ext4/journal.rst b/Documentation=
/filesystems/ext4/journal.rst
> > index ea613ee701f5..f94e66f2f8c4 100644
> > --- a/Documentation/filesystems/ext4/journal.rst
> > +++ b/Documentation/filesystems/ext4/journal.rst
> > @@ -29,10 +29,10 @@ safest. If ``data=3Dwriteback``, dirty data blocks =
are not flushed to the
> >  disk before the metadata are written to disk through the journal.
> >
> >  The journal inode is typically inode 8. The first 68 bytes of the
> > -journal inode are replicated in the ext4 superblock. The journal itsel=
f
> > -is normal (but hidden) file within the filesystem. The file usually
> > -consumes an entire block group, though mke2fs tries to put it in the
> > -middle of the disk.
> > +journal inode are replicated in the ext4 superblock. The journal
> > +itself is normal (but hidden) file within the filesystem. The file
> > +usually consumes an entire block group, though mke2fs tries to put it
> > +in the middle of the disk.
> >
> >  All fields in jbd2 are written to disk in big-endian order. This is th=
e
> >  opposite of ext4.
> > @@ -42,22 +42,74 @@ NOTE: Both ext4 and ocfs2 use jbd2.
> >  The maximum size of a journal embedded in an ext4 filesystem is 2^32
> >  blocks. jbd2 itself does not seem to care.
> >
> > +Fast Commits
> > +~~~~~~~~~~~~
> > +
> > +Ext4 also implements fast commits and integrates it with JBD2 journall=
ing.
> > +Fast commits store metadata changes made to the file system as inode l=
evel
> > +diff. In other words, each fast commit block identifies updates made t=
o
> > +a particular inode and collectively they represent total changes made =
to
> > +the file system.
> > +
> > +A fast commit is valid only if there is no full commit after that part=
icular
> > +fast commit. Because of this feature, fast commit blocks can be reused=
 by
> > +the following transactions.
> > +
> > +Each fast commit block stores updates to 1 particular inode. Updates i=
n each
> > +fast commit block are one of the 2 types:
> > +- Data updates (add range / delete range)
> > +- Directory entry updates (Add / remove links)
> > +
> > +Fast commit blocks must be replayed in the order in which they appear =
on disk.
> > +That's because directory entry updates are written in fast commit bloc=
ks
> > +in the order in which they are applied on the file system before crash=
.
> > +Changing the order of replaying for directory entry updates may result
> > +in inconsistent file system. Note that only directory entry updates ne=
ed
> > +ordering, data updates, since they apply to only one inode, do not req=
uire
> > +ordered replay. Also, fast commits guarantee that file system is in co=
nsistent
> > +state after replay of each fast commit block as long as order of repla=
y has
> > +been followed.
> > +
> > +Note that directory inode updates are never directly recorded in fast =
commits.
> > +Just like other file system level metaata, updates to directories are =
always
> > +implied based on directory entry updates stored in fast commit blocks.
> > +
> > +Based on which directory entry updates are committed with an inode, fa=
st
> > +commits have two modes of operation:
> > +
> > +- Hard Consistency (default)
> > +- Soft Consistency (can be enabled by setting mount flag "fc_soft_cons=
istency")
> > +
> > +When hard consistency is enabled, fast commit guarantees that all the =
updates
> > +will be committed. After a successful replay of fast commits blocks
> > +in hard consistency mode, the entire file system would be in the same =
state as
> > +that when fsync() returned before crash. This guarantee is similar to =
what
> > +jbd2 gives.
> > +
> > +With soft consistency, file system only guarantees consistency for the
> > +inode in question. In this mode, file system will try to write as less=
 data
> > +to the backed as possible during the commit time. To be precise, file =
system
> > +records all the data updates for the inode in question and directory u=
pdates
> > +that are required for guaranteeing consistency of the inode in questio=
n.
> > +
> >  Layout
> >  ~~~~~~
> >
> >  Generally speaking, the journal has this format:
> >
> >  .. list-table::
> > -   :widths: 16 48 16
> > +   :widths: 16 48 16 18
> >     :header-rows: 1
> >
> >     * - Superblock
> >       - descriptor\_block (data\_blocks or revocation\_block) [more dat=
a or
> >         revocations] commmit\_block
> >       - [more transactions...]
> > +     - [Fast commits...]
> >     * -
> >       - One transaction
> >       -
> > +     -
> >
> >  Notice that a transaction begins with either a descriptor and some dat=
a,
> >  or a block revocation list. A finished transaction always ends with a
> > @@ -76,7 +128,7 @@ The journal superblock will be in the next full bloc=
k after the
> >  superblock.
> >
> >  .. list-table::
> > -   :widths: 12 12 12 32 12
> > +   :widths: 12 12 12 32 12 12
> >     :header-rows: 1
> >
> >     * - 1024 bytes of padding
> > @@ -85,11 +137,13 @@ superblock.
> >       - descriptor\_block (data\_blocks or revocation\_block) [more dat=
a or
> >         revocations] commmit\_block
> >       - [more transactions...]
> > +     - [Fast commits...]
> >     * -
> >       -
> >       -
> >       - One transaction
> >       -
> > +     -
> >
> >  Block Header
> >  ~~~~~~~~~~~~
> > @@ -609,3 +663,64 @@ bytes long (but uses a full block):
> >       - h\_commit\_nsec
> >       - Nanoseconds component of the above timestamp.
> >
> > +Fast Commit Block
> > +~~~~~~~~~~~~~~~~~
> > +
> > +The fast commit block indicates an append to the last commit block
> > +that was written to the journal. One fast commit block records updates
> > +to one inode. So, typically you would find as many fast commit blocks
> > +as the number of inodes that got changed since the last commit. A fast
> > +commit block is valid only if there is no commit block present with
> > +transaction ID greater than that of the fast commit block. If such a
> > +block a present, then there is no need to replay the fast commit
> > +block.
> > +
> > +.. list-table::
> > +   :widths: 8 8 24 40
> > +   :header-rows: 1
> > +
> > +   * - Offset
> > +     - Type
> > +     - Name
> > +     - Descriptor
> > +   * - 0x0
> > +     - journal\_header\_s
> > +     - (open coded)
> > +     - Common block header.
> > +   * - 0xC
> > +     - \_\_le32
> > +     - fc\_magic
> > +     - Magic value which should be set to 0xE2540090. This identifies
> > +       that this block is a fast commit block.
> > +   * - 0x10
> > +     - \_\_u8
> > +     - fc\_features
> > +     - Features used by this fast commit block.
> > +   * - 0x11
> > +     - \_\_le16
> > +     - fc_num_tlvs
> > +     - Number of TLVs contained in this fast commit block
> > +   * - 0x13
> > +     - \_\_le32
> > +     - \_\_fc\_len
> > +     - Length of the fast commit block in terms of number of blocks
> > +   * - 0x17
> > +     - \_\_le32
> > +     - fc\_ino
> > +     - Inode number of the inode that will be recovered using this fas=
t commit
> > +   * - 0x2B
> > +     - struct ext4\_inode
> > +     - inode
> > +     - On-disk copy of the inode at the commit time
> > +   * - <Variable based on inode size>
> > +     - struct ext4\_fc\_tl
> > +     - Array of struct ext4\_fc\_tl
> > +     - The actual delta with the last commit. Starting at this offset,
> > +       there is an array of TLVs that indicates which all extents
> > +       should be present in the corresponding inode. Currently,
> > +       following tags are supported: EXT4\_FC\_TAG\_EXT (extent that
> > +       should be present in the inode), EXT4\_FC\_TAG\_HOLE (extent
> > +       that should be removed from the inode), EXT4\_FC\_TAG\_ADD\_DEN=
TRY
> > +       (dentry that should be linked), EXT4\_FC\_TAG\_DEL\_DENTRY
> > +       (dentry that should be unlinked), EXT4\_FC\_TAG\_CREATE\_DENTRY
> > +       (dentry that for the file that should be created for the first =
time).
> > diff --git a/Documentation/filesystems/journalling.rst b/Documentation/=
filesystems/journalling.rst
> > index 58ce6b395206..1cb116ab27ab 100644
> > --- a/Documentation/filesystems/journalling.rst
> > +++ b/Documentation/filesystems/journalling.rst
> > @@ -115,6 +115,24 @@ called after each transaction commit. You can also=
 use
> >  ``transaction->t_private_list`` for attaching entries to a transaction
> >  that need processing when the transaction commits.
> >
> > +JBD2 also allows client file systems to implement file system specific
> > +commits which are called as ``fast commits``. Fast commits are
> > +asynchronous in nature i.e. file systems can call their own commit
> > +functions at any time. In order to avoid the race with kjournald
> > +thread and other possible fast commits that may be happening in
> > +parallel, file systems should first call
> > +:c:func:`jbd2_start_async_fc()`. File system can call
> > +:c:func:`jbd2_map_fc_buf()` to get buffers reserved for fast
> > +commits. Once a fast commit is completed, file system should call
> > +:c:func:`jbd2_stop_async_fc()` to indicate and unblock other
> > +committers and the kjournald thread.  After performing either a fast
> > +or a full commit, JBD2 calls ``journal->j_fc_cleanup_cb`` to allow
> > +file systems to perform cleanups for their internal fast commit
> > +related data structures. At the replay time, JBD2 passes each and
> > +every fast commit block to the file system via
> > +``journal->j_fc_replay_cb``. Ext4 effectively uses this fast commit
> > +mechanism to improve journal commit performance.
> > +
> >  JBD2 also provides a way to block all transaction updates via
> >  :c:func:`jbd2_journal_lock_updates()` /
> >  :c:func:`jbd2_journal_unlock_updates()`. Ext4 uses this when it wants =
a
> > --
> > 2.24.1.735.g03f4e72817-goog
> >
