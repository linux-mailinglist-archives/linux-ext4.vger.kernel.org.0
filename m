Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B057533D64
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jun 2019 05:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfFDDGa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 Jun 2019 23:06:30 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50215 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726076AbfFDDGa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 3 Jun 2019 23:06:30 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5436PZH011043
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Jun 2019 23:06:26 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 64265420481; Mon,  3 Jun 2019 23:06:25 -0400 (EDT)
Date:   Mon, 3 Jun 2019 23:06:25 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ross Boylan <rossboylan@stanfordalumni.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: ext4 shows file system is 4G, df says 3G
Message-ID: <20190604030625.GA2712@mit.edu>
References: <CAK3NTRACxpsHNtPEz0xDMkQepV+5+zpf4Xv5=v3HpGbFOX99sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK3NTRACxpsHNtPEz0xDMkQepV+5+zpf4Xv5=v3HpGbFOX99sw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 03, 2019 at 10:30:24AM -0700, Ross Boylan wrote:
> 
> I can imagine that the metadata structures for 4TB ended up eating a
> huge fraction of the space after the resize but a) it seems quite a
> coincidence that would lead to exactly the size in step 3 and b) I
> don't see it in any of the reported info, e.g., reserved blocks,
> except for the fact that the blocks available is quite low given the
> size of the files on the file system.  Actually, maybe I do see it:
> the journal size is 1024M = 1G (if the units are bytes; if the units
> are blocks then the journal would be bigger than the whole filesystem)
> so that could account for the difference.

Yes, that's correct.  The journal size is most of the difference.
Mke2fs uses a hueristic to decide how big to make the journal, with
the maximum size being a gigabyte.  This is mainly because people
don't mind an overhead of 0.1% for the journal -- but they do mind an
overhead of 25%.

(In fact, with older versions of e2fsprogs, we used a max journal size
of 128M, but a graduate student who was working with me on an
unrelated file system feature, when we were trying to do benchmarks to
demonstrate the benefits of the feature he was working on, we
discovered that for certain metadata heavy workloads, it's possible
for the journal checkpointing overhead to be the bottleneck.
Increasing the journal to 1G avoids this --- although with a
sufficiently fast storage device, it's possible that the journal could
become the bottleneck again.

The simplest way to reset the journal for the default size is to
unmount the file system, then remove the journal, and then recreate it:

# mke2fs -t ext4 -q /tmp/foo.img 4T
# resize2fs /tmp/foo.img 4G
resize2fs 1.45.2 (27-May-2019)
Resizing the filesystem on /tmp/foo.img to 1048576 (4k) blocks.
The filesystem on /tmp/foo.img is now 1048576 (4k) blocks long.

# dumpe2fs -h /tmp/foo.img | grep "Journal size"
dumpe2fs 1.45.2 (27-May-2019)
Journal size:             1024M

# tune2fs -O ^has_journal /tmp/foo.img
tune2fs 1.45.2 (27-May-2019)
# tune2fs -O has_journal /tmp/foo.img
tune2fs 1.45.2 (27-May-2019)
Creating journal inode: done

# dumpe2fs -h /tmp/foo.img | grep "Journal size"
dumpe2fs 1.45.2 (27-May-2019)
Journal size:             64M

(There are some other differences; the number of reserved gdt blocks,
used for online resizing, will be larger if you start with a file
system which is 4T and the resize it down to 4G.  But that's only make
a difference of about 16M for the 4G file system.  There would also be
fewer inodes in the resulting file system.  But the big difference is
size of the journal.)

						- Ted
						
