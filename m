Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32814410092
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Sep 2021 23:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344217AbhIQVIX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Sep 2021 17:08:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28861 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344127AbhIQVIW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 17 Sep 2021 17:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631912820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=0yvzP5u6vw7QWAM99uYHiSDnv2v3jozEytcYkTkyW2g=;
        b=eM0Qwlb+pwNGvJHDCT/Plvjaqax4SkCPI+JySXAIymgOMqqSOtlKp87hooPCPsmUwH8o3L
        mpIFxuPprEA6wWOgbIgO0xIXG9RlImEqiXG9dwkWaHPAkd6gOOhgeHfmaBh3srl6VkTBM7
        XzKwQtcclj+IXh6TIJG/EBleVnKMWL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-uk7uAELbMTSeUrojF6j_UQ-1; Fri, 17 Sep 2021 17:06:58 -0400
X-MC-Unique: uk7uAELbMTSeUrojF6j_UQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 766231006AA3;
        Fri, 17 Sep 2021 21:06:57 +0000 (UTC)
Received: from redhat.com (ovpn-113-101.phx2.redhat.com [10.3.113.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23BE960C2B;
        Fri, 17 Sep 2021 21:06:57 +0000 (UTC)
Date:   Fri, 17 Sep 2021 16:06:55 -0500
From:   Eric Blake <eblake@redhat.com>
To:     tytso@mit.edu, linux-ext4@vger.kernel.org
Cc:     libguestfs@redhat.com
Subject: e2fsprogs concurrency questions
Message-ID: <20210917210655.sjrqvd3r73gwclti@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20210205-772-2b4c52
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

TL;DR summary: is there documented best practices for parallel access
to the same inode of an ext2 filesystem from multiple threads?

First, a meta-question: is there a publicly archived mailing list for
questions on e2fsprogs?  The README merely mentions Ted's email
address, and http://e2fsprogs.sourceforge.net/ is silent on contact
information, although with some googling, I found at least
https://patchwork.ozlabs.org/project/linux-ext4/patch/20201205045856.895342-6-tytso@mit.edu/
which suggests linux-ext4@vger.kernel.org as a worthwhile list to
mention on the web page.

Now, on to my real reason for writing.  The nbdkit project is using
the ext2fs library to provide an ext2/3/4 filter on top of any data
being served over NBD (Network Block Device protocol) in userspace:
https://libguestfs.org/nbdkit-ext2-filter.1.html

Searching for the word 'thread' or 'concurrent' in libext2fs.info came
up with no hits, so I'm going off of minimal documentation, and mostly
what I can ascertain from existing examples (of which I'm not seeing
very many).

Right now, the nbdkit filter forces some rather strict serialization
in order to be conservatively safe: for every client that wants to
connect, the nbdkit filter calls ext2fs_open(), then eventually
ext2fs_file_open2(), then exposes the contents of that one extracted
file over NBD one operation at a time, then closes everything back
down before accepting a second client.  But we'd LOVE to add some
parallelization; the NBD protocol allows multiple clients, as well as
out-of-order processing of requests from a single client.

Right away, I already know that calling ext2fs_open() more than once
on the same file system is a recipe for disaster (it is equivalent to
mounting the same block device at once through more than one bare
metal OS, and won't work).  So I've got a proposal for how to rework
the nbdkit code to open the file system exactly once and share that
handle among multiple NBD clients:
https://listman.redhat.com/archives/libguestfs/2021-May/msg00028.html

However, in my testing, I quickly found that while it would let me
visit two independent inodes at once through two separate clients, I
was seeing inconsistencies when trying to visit the SAME inode through
two independent clients.  That is, with (abbreviated code):

ext2fs_open(..., &fs);
ext2fs_namei(fs, ... "/foo", &ino);
ext2fs_file_open2(fs, ino, NULL, flags, &f1); // hand f1 to thread 1
ext2fs_file_open2(fs, ino, NULL, flags, &f2); // hand f2 to thread 2
// thread 1
ext2fs_file_read(f1, buf...);
// thread 2
ext2fs_file_write(f2, buf...);
ext2fs_file_flush(f2);
// thread 1
ext2fs_file_flush(f1);
ext2fs_file_read(f1, buf...);

the two open file handles carried independent buffering state - even
though thread 2 (tried to) flush everything, the handle f1 STILL
reports the data read prior to thread 2 doing any modification.

Is it okay to have two concurrent handles open to the same inode, or
do I need to implement a hash map on my end so that two NBD clients
requesting access to the same file within the ext2 filesystem share a
single inode?  If concurrent handles are supported, what mechanism can
I use to ensure that a flush performed on one handle will be visible
for reading from the other handle, as ext2fs_file_flush does not seem
to be strong enough?

Next, when using a single open ext2_ino_t, are there any concurrency
restrictions that I must observe when using that handle from more than
one thread at a time?  For example, is it safe to have two threads
both in the middle of a call to ext2_file_read() on that same handle,
or must I add my own mutex locking to ensure that a second thread
doesn't read data until the first thread is complete with its call?
Or put another way, are the ext2fs_* calls re-entrant?

Next, the nbdkit ext2 filter is using a custom io handler for
converting client requests as filtered through ext2fs back into raw
read/write/flush calls to pass to the real underlying NBD storage.
Among others, I implemented the io_flush(io_channel) callback, but in
debugging it, I see it only gets invoked during ext2fs_close(), and
not during ext2fs_file_flush().  Is this a symptom of me not calling
ext2fs_flush2() at points where I want to be sure actions on a single
file within the filesystem are flushed to persistant storage?

Finally, I see with
https://patchwork.ozlabs.org/project/linux-ext4/patch/20201205045856.895342-6-tytso@mit.edu/
that you recently added EXT2_FLAG_THREADS, as well as
CHANNEL_FLAGS_THREADS.  I think it should be fairly straightforward to
tweak my nbdkit custom IO manager to advertise CHANNEL_FLAGS_THREADS
(as the NBD protocol really DOES support parallel outstanding IO
requests), and then add EXT2_FLAG_THREADS into the flags I pss to
ext2fs_file_open2(), to try and get ext2fs to take advantage of
parallel access to the underlying storage (regardless of whether the
clients are parallel coming into ext2fs).  Are there any concurrency
issues I should be aware of on that front when updating my code?

Obviously, when the kernel accesses an ext2/3/4 file system, it DOES
support full concurrency (separate user space processes can open
independent handles to the same file, and the processes must
coordinate with well-timed fsync() or similar any time there is an
expectation of a happens-before relation where actions from one
process must be observed from another).  But nbdkit is all about
accessing the data of an ext2 filesystem from userspace, without any
kernel bio involvement, and is thus reliant on whatever concurrency
guarantees the ext2progs library has (or lacks).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

