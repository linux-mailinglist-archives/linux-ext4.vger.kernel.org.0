Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463CE3A443D
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Jun 2021 16:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhFKOmX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Jun 2021 10:42:23 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47659 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231518AbhFKOmW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Jun 2021 10:42:22 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15BEeJBN022279
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jun 2021 10:40:19 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id F145F15C3CD5; Fri, 11 Jun 2021 10:40:18 -0400 (EDT)
Date:   Fri, 11 Jun 2021 10:40:18 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Parallel fsck current status
Message-ID: <YMN10sXgoTR/IPxr@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Parallel FSCK Project current status 
Written by harshads@ and further updated by tytso@

Background
==========

Ext4 fsck has traditionally been a single threaded program. On large
(and especially fragmented) disks, fsck has resulted in performance
degradation. On large disks, this single threaded fsck takes a long
time to complete.

Fortunately, upstream has seen some action for parallelizing fsck
[1]. However, as you can see the patchset is very long (with around
50~ patches) and it didn’t completely make it through to e2fsck. Ted
added threading support to e2fsprogs [3] that added following
features:

* The patchset made libext2fs thread-aware
* The patchset added parallel bitmap loading

However, the upstream changes added by Ted only parallelize bitmap
loading. File system checking is still single threaded.  Reviewing and
merging massive patchset is extremely hard and that’s why Ted
suggested on the mailing list[4] that we first add support for
multithreading to libext2fs. This will allow us to add unit tests for
parallelizing libext2fs independently of parallel e2fsck. Once that
goes in, we can rebase the rest of the patches on top of libext2fs
changes.

Saranya spent some effort cleaning up Wang Shilong's patches, and
there is a working version of those patches which are based on a
recent version of e2fsprogs (just before fast_commit support was
integrated) at [2].  However, when we looked more closely at that
patch, a fundamental issue of that patch is that the changes to e2fsck
to enable multithreaded access to the internal data structures of the
libext2fs library made the patches extremely fragile, since it exposed
the internal data abstractions of libext2fs into e2fsck.


Problem Definition
==================

The top level object holding critical information in e2fsprogs is
called ext2fil_sys. Every application that links against libext2fs,
allocates, updates and frees this struct using libext2fs API [5]. For
making any libext2fs application thread-aware, we first need to add
the ability in libext2fs to clone this structure so that multiple
threads can make progress parallely. Once all the threads finish,
we’ll need to add the ability to merge these structures back. So, in
other words, we’ll need to add following APIs in libext2fs:

/* Clone fs object into dest based on flags */
errcode_t ext2fs_clone_fs(ext2_filsys fs, ext2_filsys *dest, int flags);

/* Try to free the FS object. If this object is a clone, merge it with the parent. */
errcode_t ext2fs_free_fs(ext2_filsys fs);


Saranya was working on this project; the commit [6] is a work in
progress to implement this design. We can either take that code and
modify or start from scratch and use that code as a reference.

Outcome and Future Direction
============================

At the end of this project, we’ll have an upstream ready
patchset.  Once these changes are in, the next step would be to drop
some patches from Wang’s original e2fsck patchset[1] and rebase the
rest of the series on top of the patchset. 



REFERENCES
==========

[1] Wang Shilong’s original parallel e2fsck patchset:
	http://patchwork.ozlabs.org/project/linux-ext4/list/?series=169193

[2] Wang Shilong's patches rebased and cleaned up versus a relatively
recent version of e2fsprogs:
       https://github.com/tytso/e2fsprogs/tree/pfsck
       git fetch https://github.com/tytso/e2fsprogs.git pfsck
       
[3] Patches sent by Ted that add parallel bitmap support:
	https://www.spinics.net/lists/linux-ext4/msg75716.html

[4] Ted’s suggested next steps:
	http://patchwork.ozlabs.org/project/linux-ext4/patch/20201118153947.3394530-11-saranyamohan@google.com/#2584340

[5] libext2fs API
	https://github.com/tytso/e2fsprogs/blob/master/lib/ext2fs/ext2fs.h

[6] Saranya’s WIP commit that adds clonefs support:
	https://github.com/srnym/e2fsprogs/commit/3007ba6c47a5caf2e2346d4eb2e05f1333663c2f
