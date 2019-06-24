Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61D4950B7C
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2019 15:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbfFXNHw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Jun 2019 09:07:52 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59950 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728927AbfFXNHw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Jun 2019 09:07:52 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5OD7V3V003440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 09:07:31 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E484742002B; Mon, 24 Jun 2019 09:07:30 -0400 (EDT)
Date:   Mon, 24 Jun 2019 09:07:30 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eryu Guan <guaneryu@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
Subject: Re: Removing the shared class of tests
Message-ID: <20190624130730.GD1805@mit.edu>
References: <20190612184033.21845-1-krisman@collabora.com>
 <20190612184033.21845-2-krisman@collabora.com>
 <20190616144440.GD15846@desktop>
 <20190616200154.GA7251@mit.edu>
 <20190620112903.GF15846@desktop>
 <20190620162116.GA4650@mit.edu>
 <20190620175035.GA5380@magnolia>
 <20190624071610.GA10195@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190624071610.GA10195@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 24, 2019 at 12:16:10AM -0700, Christoph Hellwig wrote:
> 
> As for the higher level question?  The shared tests always confused the
> heck out of me.  generic with the right feature checks seem like a much
> better idea.

Agreed.  I've sent out a patch series to bring the number of patches
in shared down to four.  Here's what's left:

shared/002 --- needs a feature test to somehow determine whether a
	file system supports thousads of xattrs in a file (currently
	on btrfs and xfs)

shared/011 --- needs some way of determining that a file system
	supports cgroup-aware writeback (currently enabled only for
	ext4 and btrfs).  Do we consider lack of support of
	cgroup-aware writeback a bug?  If so, maybe it doesn't need a
	feature test at all?

shared/032 --- needs a feature test to determine whether or not a file
	system's mkfs supports detection of "foreign file systems".
	e.g., whether or not it warns if you try overwrite a file
	system w/o another file system.  (Currently enabled by xfs and
	btrfs; it doesn't work for ext[234] because e2fsprogs, because
	I didn't want to break existing shell scripts, only warns when
	it is used interactively.  We could a way to force it to be
	activated it points out this tests is fundamentally testing
	implementation choices of the userspace utilities of a file
	system.  Does it belong in xfstests?   : ¯\_(ツ)_/¯ )

shared/289 --- contains ext4, xfs, and btrfs mechanisms for
	determining blocks which are unallocated.  Has hard-coded
	invocations to dumpe2fs, xfs_db, and /bin/btrfs.

These don't have obvious solutions.  We could maybe add a _notrun if
adding the thousands of xattrs fails with an ENOSPC or related error
(f2fs uses something else).

Maybe we just move shared/011 and move it generic/ w/o a feature test.

Maybe we remove shared/032 altogether, since for e2fsprogs IMHO
the right place to put it is the regression test in e2fsprogs --- but
I know xfs has a different test philosophy for xfsprogs; and tha begs
the question of what to do for mkfs.btrfs.

And maybe we just split up shared/289 to three different tests in
ext4/, xfs/, and btrfs/, since it would make the test script much
simpler to understand?

What do people think?

						- Ted
