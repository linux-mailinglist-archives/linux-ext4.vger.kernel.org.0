Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1002769D1
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Sep 2020 08:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgIXG4v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Sep 2020 02:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgIXG4v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Sep 2020 02:56:51 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350F7C0613CE
        for <linux-ext4@vger.kernel.org>; Wed, 23 Sep 2020 23:56:51 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id ay8so2245041edb.8
        for <linux-ext4@vger.kernel.org>; Wed, 23 Sep 2020 23:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aHEEtD3IZzBq/PXhmH7tIDonEKDdzP/7nOZEZaIrWgw=;
        b=o4U+BfovFM57rbaROm05wxS29K6U2DmBOlrJrbsyqkz5LRTOyYGbdFxKA28ON639S9
         WohP9iGPIi7cb2IorfQY0xKabPAR5Qv2Q9IL3cGi++9IUJ9qI6efM6izNGkoMg179+5y
         vGJiGO0Y0pngw3GI0mhKK+36VIpuMx/vmifYVQvjn0PZ9k384onunr7YB+GV+Hvc7JyO
         FM00hTEgG/umEw5Yz6JNAGgBGI3D1GVWgPlRQfovxQgSqeq70jjNaKkU3+Gkjkssq8/n
         x+1JG3Zgh4GYIyTDNipOzF4BT5wVnyAM+XWzYvCB++1v1oBEqJYRZ4vah2o7H4YLdvmJ
         Fwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHEEtD3IZzBq/PXhmH7tIDonEKDdzP/7nOZEZaIrWgw=;
        b=Uz4BUr9FZS+uVg5T6ZxlXUf5qE1hNILWU2j4SYXr06+ei4vYt7gBnXqhUR9uPfs9vg
         EgxfaQYzSG8jRUe81DwkLNOmdp6t3yEf6u+cw9jEoqHvtDL5l8/ilJfPl7XVgyl1Iati
         mPEAN1Aa6goCAbXyjsV+TuLk7UaafIGUwowp5brzvxlp1FdogkCo5Z4KGw9U3f3E040T
         MJBUP765m5mQk4bK45iJ/qdfmT5jpUEUyl83YGGbKVLEUQJ4slSKY5gC5qnI/ImrGoTh
         GTeBk3vblSiB/QiSGtMBWWMNxysPfC1jjieppbSXgFTtTlxe+3BL2mGo3FrULAL/PDAI
         0vJA==
X-Gm-Message-State: AOAM532apecnMAxTG+yS3rcGq9U1jlgDtnp8LqxJ/PvaB+3VkR6zFP40
        polFfRfliwcvFsE90U5iplm298ZEeDXmVgCeCVYKrS7PCMo=
X-Google-Smtp-Source: ABdhPJxtw4dQSGoVsIBoOegxqpfaGQbJfEB5YKhhRbkzR169QtEKmKp5HYLyx/TWr1VHvZ2vJKSohZTX6PQ+j+egULQ=
X-Received: by 2002:a05:6402:2c3:: with SMTP id b3mr3093928edx.213.1600930609623;
 Wed, 23 Sep 2020 23:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
 <20200919005451.3899779-2-harshadshirwadkar@gmail.com> <20200922175001.GB7948@magnolia>
In-Reply-To: <20200922175001.GB7948@magnolia>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Wed, 23 Sep 2020 23:56:38 -0700
Message-ID: <CAD+ocbx6Tpp93jZoA+M0fum-776aoLdOnJV6Xha3=Ge9=6NCCw@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] doc: update ext4 and journalling docs to include
 fast commit feature
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Darrick for the comments. Responses inlined below:

On Tue, Sep 22, 2020 at 10:52 AM Darrick J. Wong
<darrick.wong@oracle.com> wrote:
>
> On Fri, Sep 18, 2020 at 05:54:43PM -0700, Harshad Shirwadkar wrote:
> > This patch adds necessary documentation for fast commits.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > ---
> >  Documentation/filesystems/ext4/journal.rst | 66 ++++++++++++++++++++++
> >  Documentation/filesystems/journalling.rst  | 28 +++++++++
> >  2 files changed, 94 insertions(+)
> >
> > diff --git a/Documentation/filesystems/ext4/journal.rst b/Documentation/filesystems/ext4/journal.rst
> > index ea613ee701f5..c2e4d010a201 100644
> > --- a/Documentation/filesystems/ext4/journal.rst
> > +++ b/Documentation/filesystems/ext4/journal.rst
> > @@ -28,6 +28,17 @@ metadata are written to disk through the journal. This is slower but
> >  safest. If ``data=writeback``, dirty data blocks are not flushed to the
> >  disk before the metadata are written to disk through the journal.
> >
> > +In case of ``data=ordered`` mode, Ext4 also supports fast commits which
> > +help reduce commit latency significantly. The default ``data=ordered``
> > +mode works by logging metadata blocks tothe journal. In fast commit
>
> "to the journal"
ack
>
> > +mode, Ext4 only stores the minimal delta needed to recreate the
> > +affected metadata in fast commit space that is shared with JBD2.
> > +Once the fast commit area fills in or if fast commit is not possible
> > +or if JBD2 commit timer goes off, Ext4 performs a traditional full commit.
> > +A full commit invalidates all the fast commits that happened before
> > +it and thus it makes the fast commit area empty for further fast
> > +commits. This feature needs to be enabled at compile time.
>
> And mkfs time too, I would hope?
Haha, thanks for catching this, yeah I meant mkfs time :)
>
> > +
> >  The journal inode is typically inode 8. The first 68 bytes of the
> >  journal inode are replicated in the ext4 superblock. The journal itself
> >  is normal (but hidden) file within the filesystem. The file usually
> > @@ -609,3 +620,58 @@ bytes long (but uses a full block):
> >       - h\_commit\_nsec
> >       - Nanoseconds component of the above timestamp.
> >
> > +Fast commits
> > +~~~~~~~~~~~~
> > +
> > +Fast commit area is organized as a log of tag tag length values. Each TLV has
> > +a ``struct ext4_fc_tl`` in the beginning which stores the tag and the length
> > +of the entire field. It is followed by variable length tag specific value.
>
> "The fast commit area is organized as a log of tagged variable-length
> values.  Each value begins with a ``struct ext4_fc_tl`` tag that
> identifies the type of the value and its length, and is followed by the
> value itself." ?
>
> I would've called that struct "ext4_fc_tag" or something, since "tl"
> isn't really a word... ah well.
Ack, ext4_fc_tag is good, ideally I would have liked a name that
somehow conveys that there's tag and length in there. But, I get it
"tl" doesn't mean anything, so unless we find a better name, I can use
ext4_fc_tag.
>
> > +Here is the list of supported tags and their meanings:
> > +
> > +.. list-table::
> > +   :widths: 8 20 20 32
> > +   :header-rows: 1
> > +
> > +   * - Tag
> > +     - Meaning
> > +     - Value struct
> > +     - Description
> > +   * - EXT4_FC_TAG_HEAD
> > +     - Fast commit area header
> > +     - ``struct ext4_fc_head``
> > +     - Stores the TID of the transaction after which these fast commits should
> > +       be applied.
>
> So I guess log recovery is supposed to apply the transaction TID, then
> apply these fast commits, and then move on to the next transaction?
So, the log recovery should apply all the transactions in the journal
first. Let's say the last transaction was TID. Log recovery should
only apply fast commits if the head tag in fast commit has the
transaction ID as TID. Since a full commit invalidates all the
previous fast commits, there is no need to replay any fast commits <
TID.

Thanks,
Harshad
>
> --D
>
> > +   * - EXT4_FC_TAG_ADD_RANGE
> > +     - Add extent to inode
> > +     - ``struct ext4_fc_add_range``
> > +     - Stores the inode number and extent to be added in this inode
> > +   * - EXT4_FC_TAG_DEL_RANGE
> > +     - Remove logical offsets to inode
> > +     - ``struct ext4_fc_del_range``
> > +     - Stores the inode number and the logical offset range that needs to be
> > +       removed
> > +   * - EXT4_FC_TAG_CREAT
> > +     - Create directory entry for a newly created file
> > +     - ``struct ext4_fc_dentry_info``
> > +     - Stores the parent inode numer, inode number and directory entry of the
> > +       newly created file
> > +   * - EXT4_FC_TAG_LINK
> > +     - Link a directory entry to an inode
> > +     - ``struct ext4_fc_dentry_info``
> > +     - Stores the parent inode numer, inode number and directory entry
> > +   * - EXT4_FC_TAG_UNLINK
> > +     - Unink a directory entry of an inode
> > +     - ``struct ext4_fc_dentry_info``
> > +     - Stores the parent inode numer, inode number and directory entry
> > +
> > +   * - EXT4_FC_TAG_PAD
> > +     - Padding (unused area)
> > +     - None
> > +     - Unused bytes in the fast commit area.
> > +
> > +   * - EXT4_FC_TAG_TAIL
> > +     - Mark the end of a fast commit
> > +     - ``struct ext4_fc_tail``
> > +     - Stores the TID of the commit, CRC of the fast commit of which this tag
> > +       represents the end of
> > +
> > diff --git a/Documentation/filesystems/journalling.rst b/Documentation/filesystems/journalling.rst
> > index 58ce6b395206..a9817220dc9b 100644
> > --- a/Documentation/filesystems/journalling.rst
> > +++ b/Documentation/filesystems/journalling.rst
> > @@ -132,6 +132,34 @@ The opportunities for abuse and DOS attacks with this should be obvious,
> >  if you allow unprivileged userspace to trigger codepaths containing
> >  these calls.
> >
> > +Fast commits
> > +~~~~~~~~~~~~
> > +
> > +JBD2 to also allows you to perform file-system specific delta commits known as
> > +fast commits. In order to use fast commits, you first need to call
> > +:c:func:`jbd2_fc_init` and tell how many blocks at the end of journal
> > +area should be reserved for fast commits. Along with that, you will also need
> > +to set following callbacks that perform correspodning work:
> > +
> > +`journal->j_fc_cleanup_cb`: Cleanup function called after every full commit and
> > +fast commit.
> > +
> > +`journal->j_fc_replay_cb`: Replay function called for replay of fast commit
> > +blocks.
> > +
> > +File system is free to perform fast commits as and when it wants as long as it
> > +gets permission from JBD2 to do so by calling the function
> > +:c:func:`jbd2_fc_start()`. Once a fast commit is done, the client
> > +file  system should tell JBD2 about it by calling :c:func:`jbd2_fc_stop()`.
> > +If file system wants JBD2 to perform a full commit immediately after stopping
> > +the fast commit it can do so by calling :c:func:`jbd2_fc_stop_do_commit()`.
> > +This is useful if fast commit operation fails for some reason and the only way
> > +to guarantee consistency is for JBD2 to perform the full traditional commit.
> > +
> > +JBD2 helper functions to manage fast commit buffers. File system can use
> > +:c:func:`jbd2_fc_get_buf()` and :c:func:`jbd2_fc_wait_bufs()` to allocate
> > +and wait on IO completion of fast commit buffers.
> > +
> >  Summary
> >  ~~~~~~~
> >
> > --
> > 2.28.0.681.g6f77f65b4e-goog
> >
