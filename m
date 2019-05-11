Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 604711A9A6
	for <lists+linux-ext4@lfdr.de>; Sun, 12 May 2019 00:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfEKWHK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 11 May 2019 18:07:10 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45539 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726043AbfEKWHK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 11 May 2019 18:07:10 -0400
Received: from callcc.thunk.org (rrcs-67-53-55-100.west.biz.rr.com [67.53.55.100])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4BM6x67031652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 May 2019 18:07:02 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 558B3420024; Sat, 11 May 2019 18:06:59 -0400 (EDT)
Date:   Sat, 11 May 2019 18:06:59 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Arthur Marsh <arthur.marsh@internode.on.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org
Subject: Re: ext3/ext4 filesystem corruption under post 5.1.0 kernels
Message-ID: <20190511220659.GB8507@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Arthur Marsh <arthur.marsh@internode.on.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org
References: <48BA4A6E-5E2A-478E-A96E-A31FA959964C@internode.on.net>
 <CAFLxGvwnKKHOnM2w8i9hn7LTVYKh5PQP2zYMBmma2k9z7HBpzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLxGvwnKKHOnM2w8i9hn7LTVYKh5PQP2zYMBmma2k9z7HBpzw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, May 11, 2019 at 02:43:16PM +0200, Richard Weinberger wrote:
> [CC'in linux-ext4]
> 
> On Sat, May 11, 2019 at 1:47 PM Arthur Marsh
> <arthur.marsh@internode.on.net> wrote:
> >
> >
> > The filesystem with the kernel source tree is the root file system, ext3, mounted as:
> >
> > /dev/sdb7 on / type ext3 (rw,relatime,errors=remount-ro)
> >
> > After the "Compressing objects" stage, the following appears in dmesg:
> >
> > [  848.968550] EXT4-fs error (device sdb7): ext4_get_branch:171: inode #8: block 30343695: comm jbd2/sdb7-8: invalid block
> > [  849.077426] Aborting journal on device sdb7-8.
> > [  849.100963] EXT4-fs (sdb7): Remounting filesystem read-only
> > [  849.100976] jbd2_journal_bmap: journal block not found at offset 989 on sdb7-8

This indicates that the extent tree blocks for the journal was found
to be corrupt; so the journal couldn't be found.

> > # fsck -yv
> > fsck from util-linux 2.33.1
> > e2fsck 1.45.0 (6-Mar-2019)
> > /dev/sdb7: recovering journal
> > /dev/sdb7 contains a file system with errors, check forced.

But e2fsck had no problem finding the journal.

> > Pass 1: Checking inodes, blocks, and sizes
> > Pass 2: Checking directory structure
> > Pass 3: Checking directory connectivity
> > Pass 4: Checking reference counts
> > Pass 5: Checking group summary information
> > Free blocks count wrong (4619656, counted=4619444).
> > Fix? yes
> >
> > Free inodes count wrong (15884075, counted=15884058).
> > Fix? yes

And no other significant problems were found.  (Ext4 never updates or
relies on the summary number of free blocks and free inodes, since
updating it is a scalability bottleneck and these values can be
calculated from the per block group free block/inodes count.  So the
fact that e2fsck needed to update them is not an issue.)

So that implies that we got one set of values when we read the journal
inode when attempting to mount the file system, and a *different* set
of values when e2fsck was run.  Which makes means that we need
consider the possibility that the problem is below the file system
layer (e.g., the block layer, device drivers, etc.).


> > /dev/sdb7: ***** FILE SYSTEM WAS MODIFIED *****
> >
> > Other times, I have gotten:
> >
> > "Inodes that were part of a corrupted orphan linked list found."
> > "Block bitmap differences:"
> > "Free blocks sound wrong for group"
> >

This variety of issues also implies that the issue may be in the data
read by the file system, as opposed to an issue in the file system.

Arthur, can you give us the full details of your hardware
configuration and your kernel config file?  Also, what kernel git
commit ID were you testing?

					- Ted
