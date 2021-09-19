Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DB7410B94
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Sep 2021 14:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhISMhD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Sep 2021 08:37:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33598 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229542AbhISMhC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 19 Sep 2021 08:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632054935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hAE8Mb//WlqA2i8r01zEdNLlhtUSnBWoMjbCZKttTd4=;
        b=iiBeJ34CAiVoxSYzNpwFGdYB8mbV7oXbrYziq91kflTUEO2dzZ3o9Tdw7LNznsNY+PtAd8
        Uyupp42RsPoiuXXWoGQFYa5pt5eCEqXm+mg2APO1QuVDQFAOWAdXlKmLZ8XfbRzcH/hU5X
        uwcLOgAOjQO9d8eSfRUuWNnqVpZALAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-0_TcCy9uNJaXZ9hOvRET9Q-1; Sun, 19 Sep 2021 08:35:34 -0400
X-MC-Unique: 0_TcCy9uNJaXZ9hOvRET9Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EE0481426E;
        Sun, 19 Sep 2021 12:35:33 +0000 (UTC)
Received: from localhost (unknown [10.39.194.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7C2C1017CF1;
        Sun, 19 Sep 2021 12:35:24 +0000 (UTC)
Date:   Sun, 19 Sep 2021 13:35:23 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Eric Blake <eblake@redhat.com>, linux-ext4@vger.kernel.org,
        libguestfs@redhat.com
Subject: Re: e2fsprogs concurrency questions
Message-ID: <20210919123523.GA15475@redhat.com>
References: <20210917210655.sjrqvd3r73gwclti@redhat.com>
 <YUazQg9TtlZZm10H@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUazQg9TtlZZm10H@mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Sat, Sep 18, 2021 at 11:49:22PM -0400, Theodore Ts'o wrote:
> On Fri, Sep 17, 2021 at 04:06:55PM -0500, Eric Blake wrote:
> > TL;DR summary: is there documented best practices for parallel access
> > to the same inode of an ext2 filesystem from multiple threads?
> > 
> > First, a meta-question: is there a publicly archived mailing list for
> > questions on e2fsprogs?  The README merely mentions Ted's email
> > address, and http://e2fsprogs.sourceforge.net/ is silent on contact
> > information, although with some googling, I found at least
> > https://patchwork.ozlabs.org/project/linux-ext4/patch/20201205045856.895342-6-tytso@mit.edu/
> > which suggests linux-ext4@vger.kernel.org as a worthwhile list to
> > mention on the web page.
> 
> Yes, discussions and patches relating to e2fsprogs take place on
> linux-ext4@vger.kernel.org.  (Just as xfsprogs patches and discussions
> are sent to linux-xfs@vger.kernel.org.)
> 
> > Now, on to my real reason for writing.  The nbdkit project is using
> > the ext2fs library to provide an ext2/3/4 filter on top of any data
> > being served over NBD (Network Block Device protocol) in userspace:
> > https://libguestfs.org/nbdkit-ext2-filter.1.html
> > 
> > Searching for the word 'thread' or 'concurrent' in libext2fs.info came
> > up with no hits, so I'm going off of minimal documentation, and mostly
> > what I can ascertain from existing examples (of which I'm not seeing
> > very many).
> 
> Historically, libext2fs and e2fsprogs had no pthreads or concurrency
> access at all.  This is because e2fsprogs predates Linux having
> pthreads support at all.
> 
> This is _starting_ to change, but more on that in a little.
> 
> > Right now, the nbdkit filter forces some rather strict serialization
> > in order to be conservatively safe: for every client that wants to
> > connect, the nbdkit filter calls ext2fs_open(), then eventually
> > ext2fs_file_open2(), then exposes the contents of that one extracted
> > file over NBD one operation at a time, then closes everything back
> > down before accepting a second client.  But we'd LOVE to add some
> > parallelization; the NBD protocol allows multiple clients, as well as
> > out-of-order processing of requests from a single client.
> > 
> > Right away, I already know that calling ext2fs_open() more than once
> > on the same file system is a recipe for disaster (it is equivalent to
> > mounting the same block device at once through more than one bare
> > metal OS, and won't work).  So I've got a proposal for how to rework
> > the nbdkit code to open the file system exactly once and share that
> > handle among multiple NBD clients:
> > https://listman.redhat.com/archives/libguestfs/2021-May/msg00028.html

I didn't see a link to the actual client code, so here it is:

  https://gitlab.com/nbdkit/nbdkit/-/tree/master/filters/ext2

Also this page explains the callback lifecycle and thread model of
nbdkit:

  https://libguestfs.org/nbdkit-plugin.3.html#Callback-lifecycle
  https://libguestfs.org/nbdkit-plugin.3.html#Threads

In the current filter, as Eric said above we're using the nbdkit
thread model NBDKIT_THREAD_MODEL_SERIALIZE_CONNECTIONS which basically
means we operate in the most conservative possible mode.  NBD clients
must queue up to connect one at a time, and requests from that single
client are handled one at a time.

> So you are apparently calling ext2fs_open() before forking, and then
> you want to use the ext2fs handle from separate processes.  Is that
> correct?

We call ext2fs_open once per client (when the client connects).  This
all happens after nbdkit has forked and is accepting connections.
nbdkit only ever uses a single process, and uses threads to handle the
different clients.

In the code the call happens in ext2_prepare() which isn't shown in
the lifecycle diagram (because nbdkit filters work slightly
differently from plugins), but happens just after the "open" step.

Really the question is if we can relax the thread model.

> That's not going to work if you are going to try to modify the file
> system from different processes simultaneously.  That's because the
> libext2fs using a writeback cache.  After the fork, each process has
> its own copy of the wrteiback cache.
>
> If you are using threads, older versions of libext2fs don't do any
> locking before modifying data structures internal to the ext2_fs file
> handle.  So if two threads simultaneously try to use the "ext2_fs fs"
> handle, they might try to access the block allocation bitmap (for
> example) at the same time, without locking, and so bad things will
> happen.
>
> You can do your own locking to make sure only one thread is trying to
> use the fs handle at a time, at which point you should be fine.  So
> you can have multiple clients accessing the file system without having
> to open the file system, open a file, and then close the file and
> close the file system before accepting the next client.  But only one
> client can be using the ext2_fs handle at a time, and if you want to
> share any libext2fs data structure across multiple threads,
> appropriate read/write locking would be needed.

Are there structures shared between ext2_fs handles?  I mean, if we
had two concurrent threads using different ext2_fs handles, but open
on the same file, is that going to be a problem?  (It sounds like it
would be, with conflicting access to the block allocation bitmap and
so on.)

> > Is it okay to have two concurrent handles open to the same inode, or
> > do I need to implement a hash map on my end so that two NBD clients
> > requesting access to the same file within the ext2 filesystem share a
> > single inode?  If concurrent handles are supported, what mechanism can
> > I use to ensure that a flush performed on one handle will be visible
> > for reading from the other handle, as ext2fs_file_flush does not seem
> > to be strong enough?
> 
> You could have two threads sharing the same file handle, with locking
> so that only one thread is using a file handle at a time.  Also, since
> we don't have an analogue for pread(2) and pwrite(2), each thread
> would have to assume that the fseek position may have changed by some
> other thread, so after it grabbed the file system lock, and then the
> per-file lock, it would need to call ext2fs_file_llseek() to make sure
> file's position is at a known location before calling
> ext2fs_file_read() or ext2fs_file_write().
> 
> (The reason why ext2fs_file_flush() is not strong enough is because
> that will force writeback, but it doesn't invaludate any cached
> information about the file's inode or extent tree structure.  So if
> the file inode or extent tree is getting modified by some other thread
> out from under it, you're going to have a bad time.)
> 
> > Finally, I see with
> > https://patchwork.ozlabs.org/project/linux-ext4/patch/20201205045856.895342-6-tytso@mit.edu/
> > that you recently added EXT2_FLAG_THREADS, as well as
> > CHANNEL_FLAGS_THREADS.  I think it should be fairly straightforward to
> > tweak my nbdkit custom IO manager to advertise CHANNEL_FLAGS_THREADS
> > (as the NBD protocol really DOES support parallel outstanding IO
> > requests), and then add EXT2_FLAG_THREADS into the flags I pss to
> > ext2fs_file_open2(), to try and get ext2fs to take advantage of
> > parallel access to the underlying storage (regardless of whether the
> > clients are parallel coming into ext2fs).  Are there any concurrency
> > issues I should be aware of on that front when updating my code?
> 
> So this is the _beginning_ of adding threaded support into libext2fs.
> At the moment, we now have locking for the unix_io.c data structures.
> This allows multiple threads to safely do read-only operations in
> parallel.  But this is *all* that it allows.
> 
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
> 
> So we do not have any concurrency support for allocating inodes, or
> allocating blocks, or assigning blocks to an inode's extent tree, etc.
> Nor do we currently have any plans to add more concureency support to
> libext2fs.
> 
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
> 
> > Obviously, when the kernel accesses an ext2/3/4 file system, it DOES
> > support full concurrency (separate user space processes can open
> > independent handles to the same file....
> 
> Yes, and that's because the kernel was designed with that in mind from
> the beginning.  The ext2fs library was originally designed to support
> programs like e2fsck, mke2fs, and debugfs.  None of these tools
> required concurrency, and as I've mentioned, at the time when
> libext2fs was first implemented, Linux didn't even *have* threads
> support.  So concurrency wasn't even possible, even if it had been
> needed at that time.
> 
> > process must be observed from another).  But nbdkit is all about
> > accessing the data of an ext2 filesystem from userspace, without any
> > kernel bio involvement, and is thus reliant on whatever concurrency
> > guarantees the ext2progs library has (or lacks).
> 
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

Interesting stuff, thanks.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org

