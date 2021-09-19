Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C047A410B2A
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Sep 2021 12:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhISKk3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Sep 2021 06:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhISKk3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Sep 2021 06:40:29 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79674C061574
        for <linux-ext4@vger.kernel.org>; Sun, 19 Sep 2021 03:39:04 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t1so14498050pgv.3
        for <linux-ext4@vger.kernel.org>; Sun, 19 Sep 2021 03:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=sokKKqLIFykRwgGsFkcNrpwhRGs7rc8L2c81Si9DfNI=;
        b=zfasSYVrSbH4O/xAtA+7SCbuR1VnJHhhtBxSIHvSrGsnFp1KiunoKpWoXLK0XusNFU
         ckyfiPGzBGqn+PZM74CflZIzXzCnD/CZSvmpkw99FC160Y/i2RlTnf0BixjKOe+8H0QJ
         Fgej1oGAXlEOwIoHQLB3XMDleFvH5+E0PvCapCFSwCWyBCaagG0+mBUQgcRXoosAuJkg
         bhBbm4i4C3P+AHB58FluWWrSHzKGXTgmjiy4quIDS4eYj0BR28Afk1eAP/pKtW+AeHAa
         xavVXqhhIrHrwTJ6DOBpDTGutlnYbV05sHVHnYMNhgjKcPPbUgz1pg6xjSnfAExSb59J
         yfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=sokKKqLIFykRwgGsFkcNrpwhRGs7rc8L2c81Si9DfNI=;
        b=8O4DtpdNvPaQlP+QEWlkf1YnylnZ8DXOjC73hUdxrC/GuqPorVcaQ0gOA7L/6hcg+a
         NyVMnK3lNppIf2VsdGSclyzOYZ5wv+0VSoZ6go6SR/6ElDLskO2sMd6iT3WHMzUMoCk8
         IazKCD/yP3HjurF5gwOKORu44/r0PhuAoAmihXxJz7/76f3Xt+LObQfLk977kTNj2jfQ
         kkfOfRpmUtrkq2hlPU3Hs7oRVpOx7wQ97y3yWx2cmBgTvZ870dintxm77Z4nkfA24pwS
         ieofhaA77DvqcBPS90AjJcP5deekknTOtins19pIqIAg6yLkawzCfskxSOZTpkaQsk6M
         pWrA==
X-Gm-Message-State: AOAM530cxQ8vckpo8uglkTg0dvMS5B7U1b4vxveSSRih4Y08SmvBeDMm
        0bCoRM/KIwQiCG+v0pb28zqTqY7F02skBmFE
X-Google-Smtp-Source: ABdhPJw8rsGecfOG6lysW1CLYAHReY+1Fvy6RP5pJTn12Ho2D7G5ta2JMqbgNtZ5qS3pzGK1xpUNfA==
X-Received: by 2002:aa7:9a51:0:b0:43d:f0b0:532a with SMTP id x17-20020aa79a51000000b0043df0b0532amr19690550pfj.76.1632047943552;
        Sun, 19 Sep 2021 03:39:03 -0700 (PDT)
Received: from smtpclient.apple (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id gp11sm14965871pjb.2.2021.09.19.03.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Sep 2021 03:39:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: e2fsprogs concurrency questions
Date:   Sun, 19 Sep 2021 04:39:01 -0600
Message-Id: <24A05FA3-F618-4469-BC0A-E19A425A0E36@dilger.ca>
References: <YUazQg9TtlZZm10H@mit.edu>
Cc:     Eric Blake <eblake@redhat.com>, linux-ext4@vger.kernel.org,
        libguestfs@redhat.com
In-Reply-To: <YUazQg9TtlZZm10H@mit.edu>
To:     Theodore Ts'o <tytso@mit.edu>
X-Mailer: iPhone Mail (18H17)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

What I don't understand here is why not just use a network filesystem that i=
s explicitly designed for this task (eg. NFS or Ganesha on to of ext4)?

Cheers, Andreas

> On Sep 18, 2021, at 21:49, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> =EF=BB=BFOn Fri, Sep 17, 2021 at 04:06:55PM -0500, Eric Blake wrote:
>> TL;DR summary: is there documented best practices for parallel access
>> to the same inode of an ext2 filesystem from multiple threads?
>>=20
>> First, a meta-question: is there a publicly archived mailing list for
>> questions on e2fsprogs?  The README merely mentions Ted's email
>> address, and http://e2fsprogs.sourceforge.net/ is silent on contact
>> information, although with some googling, I found at least
>> https://patchwork.ozlabs.org/project/linux-ext4/patch/20201205045856.8953=
42-6-tytso@mit.edu/
>> which suggests linux-ext4@vger.kernel.org as a worthwhile list to
>> mention on the web page.
>=20
> Yes, discussions and patches relating to e2fsprogs take place on
> linux-ext4@vger.kernel.org.  (Just as xfsprogs patches and discussions
> are sent to linux-xfs@vger.kernel.org.)
>=20
>> Now, on to my real reason for writing.  The nbdkit project is using
>> the ext2fs library to provide an ext2/3/4 filter on top of any data
>> being served over NBD (Network Block Device protocol) in userspace:
>> https://libguestfs.org/nbdkit-ext2-filter.1.html
>>=20
>> Searching for the word 'thread' or 'concurrent' in libext2fs.info came
>> up with no hits, so I'm going off of minimal documentation, and mostly
>> what I can ascertain from existing examples (of which I'm not seeing
>> very many).
>=20
> Historically, libext2fs and e2fsprogs had no pthreads or concurrency
> access at all.  This is because e2fsprogs predates Linux having
> pthreads support at all.
>=20
> This is _starting_ to change, but more on that in a little.
>=20
>> Right now, the nbdkit filter forces some rather strict serialization
>> in order to be conservatively safe: for every client that wants to
>> connect, the nbdkit filter calls ext2fs_open(), then eventually
>> ext2fs_file_open2(), then exposes the contents of that one extracted
>> file over NBD one operation at a time, then closes everything back
>> down before accepting a second client.  But we'd LOVE to add some
>> parallelization; the NBD protocol allows multiple clients, as well as
>> out-of-order processing of requests from a single client.
>>=20
>> Right away, I already know that calling ext2fs_open() more than once
>> on the same file system is a recipe for disaster (it is equivalent to
>> mounting the same block device at once through more than one bare
>> metal OS, and won't work).  So I've got a proposal for how to rework
>> the nbdkit code to open the file system exactly once and share that
>> handle among multiple NBD clients:
>> https://listman.redhat.com/archives/libguestfs/2021-May/msg00028.html
>=20
> So you are apparently calling ext2fs_open() before forking, and then
> you want to use the ext2fs handle from separate processes.  Is that
> correct?
>=20
> That's not going to work if you are going to try to modify the file
> system from different processes simultaneously.  That's because the
> libext2fs using a writeback cache.  After the fork, each process has
> its own copy of the wrteiback cache.
>=20
> If you are using threads, older versions of libext2fs don't do any
> locking before modifying data structures internal to the ext2_fs file
> handle.  So if two threads simultaneously try to use the "ext2_fs fs"
> handle, they might try to access the block allocation bitmap (for
> example) at the same time, without locking, and so bad things will
> happen.
>=20
> You can do your own locking to make sure only one thread is trying to
> use the fs handle at a time, at which point you should be fine.  So
> you can have multiple clients accessing the file system without having
> to open the file system, open a file, and then close the file and
> close the file system before accepting the next client.  But only one
> client can be using the ext2_fs handle at a time, and if you want to
> share any libext2fs data structure across multiple threads,
> appropriate read/write locking would be needed.
>=20
>> Is it okay to have two concurrent handles open to the same inode, or
>> do I need to implement a hash map on my end so that two NBD clients
>> requesting access to the same file within the ext2 filesystem share a
>> single inode?  If concurrent handles are supported, what mechanism can
>> I use to ensure that a flush performed on one handle will be visible
>> for reading from the other handle, as ext2fs_file_flush does not seem
>> to be strong enough?
>=20
> You could have two threads sharing the same file handle, with locking
> so that only one thread is using a file handle at a time.  Also, since
> we don't have an analogue for pread(2) and pwrite(2), each thread
> would have to assume that the fseek position may have changed by some
> other thread, so after it grabbed the file system lock, and then the
> per-file lock, it would need to call ext2fs_file_llseek() to make sure
> file's position is at a known location before calling
> ext2fs_file_read() or ext2fs_file_write().
>=20
> (The reason why ext2fs_file_flush() is not strong enough is because
> that will force writeback, but it doesn't invaludate any cached
> information about the file's inode or extent tree structure.  So if
> the file inode or extent tree is getting modified by some other thread
> out from under it, you're going to have a bad time.)
>=20
>> Finally, I see with
>> https://patchwork.ozlabs.org/project/linux-ext4/patch/20201205045856.8953=
42-6-tytso@mit.edu/
>> that you recently added EXT2_FLAG_THREADS, as well as
>> CHANNEL_FLAGS_THREADS.  I think it should be fairly straightforward to
>> tweak my nbdkit custom IO manager to advertise CHANNEL_FLAGS_THREADS
>> (as the NBD protocol really DOES support parallel outstanding IO
>> requests), and then add EXT2_FLAG_THREADS into the flags I pss to
>> ext2fs_file_open2(), to try and get ext2fs to take advantage of
>> parallel access to the underlying storage (regardless of whether the
>> clients are parallel coming into ext2fs).  Are there any concurrency
>> issues I should be aware of on that front when updating my code?
>=20
> So this is the _beginning_ of adding threaded support into libext2fs.
> At the moment, we now have locking for the unix_io.c data structures.
> This allows multiple threads to safely do read-only operations in
> parallel.  But this is *all* that it allows.
>=20
> This was implemented as part of preparatory work to do parallel
> e2fsck.  The strategy is that we will have several different threads
> reading from disjoint parts of the file system.  So for example, one
> thread might be reading from block groups 0 -- 100.  Another thread
> might be reading from block groups 101 -- 200.  And so on.  Each
> thread will have its own copy of struct e2fsck_struct, and when they
> are done they will merge their data to the global e2fsck_struct.  If
> there are any inconsistencies that need to be fixed, such that the
> file system needs to be modified, this will require waiting until all
> of the threads are done, or other specialized locking inside e2fsck.
> Of course, in the "happy path", where the file system does not need
> any repairs, we won't need to do any special locking or waiting, since
> the workload will be read-only.
>=20
> So we do not have any concurrency support for allocating inodes, or
> allocating blocks, or assigning blocks to an inode's extent tree, etc.
> Nor do we currently have any plans to add more concureency support to
> libext2fs.
>=20
> To do this would require a huge amount of effort, and it would also
> require making a lot of changes to the underlying data structures.
> For example, even if we added locking to all of the various data
> structures hanging off of the ext2_fs handle, if two threads tried to
> open the same inode using ext2fs_file_open(), the two file handles are
> completely independent, and there is no way for one thread to do any
> kind of cache invalidation of another thread's file handle after it
> has modified the inode.  The same is true if one thread is using a
> directory iterator while another process tries to modify that
> directory.
>=20
>> Obviously, when the kernel accesses an ext2/3/4 file system, it DOES
>> support full concurrency (separate user space processes can open
>> independent handles to the same file....
>=20
> Yes, and that's because the kernel was designed with that in mind from
> the beginning.  The ext2fs library was originally designed to support
> programs like e2fsck, mke2fs, and debugfs.  None of these tools
> required concurrency, and as I've mentioned, at the time when
> libext2fs was first implemented, Linux didn't even *have* threads
> support.  So concurrency wasn't even possible, even if it had been
> needed at that time.
>=20
>> process must be observed from another).  But nbdkit is all about
>> accessing the data of an ext2 filesystem from userspace, without any
>> kernel bio involvement, and is thus reliant on whatever concurrency
>> guarantees the ext2progs library has (or lacks).
>=20
> The e2fsprogs library pretty much doesn't have any concurrency
> guarantees, sorry.  I suspect you could create a layer on top of
> libext2fs which actually implemented a global inode cache ala the
> kernel, so that when two threads call something like ext2fs_iget()
> function, it works like the kernel's iget() function and they get the
> same inode structure, which is reference counted.  Things like the
> directory iterator would have to be changed into something more like
> the functions exported by the kernel VFS layer, which would make this
> layer useless for e2fsck, but it would be more useful for a threaded
> client that wanted concurrent read/write access to the filesystem from
> mulitple threads.
>=20
> Cheers,
>=20
>                        - Ted
