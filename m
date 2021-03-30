Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4AF34DD4E
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Mar 2021 03:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhC3BHV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Mar 2021 21:07:21 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51397 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230298AbhC3BHR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 Mar 2021 21:07:17 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 12U17Boq023364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Mar 2021 21:07:12 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B942815C39CD; Mon, 29 Mar 2021 21:07:11 -0400 (EDT)
Date:   Mon, 29 Mar 2021 21:07:11 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Leah Rumancik <leah.rumancik@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 1/2] ext4: wipe filename upon file deletion
Message-ID: <YGJ5vxW0eATilafN@mit.edu>
References: <20210325181220.1118705-1-leah.rumancik@gmail.com>
 <A08FAD7B-899F-4B40-9881-2ACD45399471@dilger.ca>
 <CAD+ocbxp5s5QfOKheftMMyd69RaZtS9z8RBnjUqZ3siOCdfFbg@mail.gmail.com>
 <20210327020823.GC22091@magnolia>
 <YGH6+VzYVVvbNn7r@google.com>
 <E6C89307-296F-4E91-A850-801CC527B3DE@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E6C89307-296F-4E91-A850-801CC527B3DE@dilger.ca>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 29, 2021 at 01:05:55PM -0600, Andreas Dilger wrote:
> >> I bet it wasn't done by design -- afaict all the recovery tools are
> >> totally opportunistic in that /if/ they find something that looks like a
> >> directory entry, /then/ it will pick that up.  The names will eventually
> >> get overwritten, so that's the best they can do.
> >> 
> >> (I would also wager that people don't like opt-out for new behaviors
> >> unless you're adding it as part of a new feature...)

It certainly wasn't deliberate, and I'll note that we've already
compromised recovery tools because of how deleted inodes were changed
when we added journalling to ext3.  Previously, we just zeroed
i_links_count and then updated all of the block allocation bitmaps and
block group descriptors' free block counts.

But there's the possibility, especially for very big files, that all
of the blocks that might need to be touched for a truncate might not
fit in a single transaction.  So we now handle the final iput of a
deleted files by doing a journalled truncate, which means that all of
the logical to physical mapping gets wiped after the delete is
commited.  You can see this if you execute the following series of
commands:

% mke2fs -F -q -t ext2 /tmp/foo.img 1G       
% sudo mount -o loop -t ext4 /tmp/foo.img /mnt
% sudo cp /etc/motd /mnt/motd
% sync
% debugfs /tmp/foo.img -R 'stat <12>'
% sudo rm /mnt/motd
% sudo umount /mnt
% debugfs /tmp/foo.img -R 'stat <12>'

... and compare the debugfs output before and after the file is
deleted.  Then try the same thing mounting with ext2 instead of ext4,
with a kernel that has ext2 compiled in (as opposed to using ext4 in
compatibility mode).

This has been true ever since ext3 was released in 2001, and people
have largely not noticed or complained.  It would be possible to do
better, if we wanted to better support the "Root Oops"[1] recovery
case; we could do a two-pass scan over the file, determine how many
block groups would need to be updated, and then try to open a handle
with the requisite number of credits.  If that succeeds, then we can
skip zapping the extent tree or indirect blocks.  Otherwise, we fall
back to the current truncate code path.  But it would slow down our
performance of unlinks, and over the last two decades, as far as I
know, no one has complained.

I was the person who suggested using a mount option, but on
reflection, given that we *already* pretty much make it impossible to
recover the contents of a deleted file, do we really care about
whether the file name can be recovered?  Hence, I'm beginning to think
that perhaps we shouldn't make it be a tunable at all.  After all,
zeroing the directory entry is not going to cause any kind of
performance penalty, and if we add a mount option, it's one more thing
mount option we need to support forever.

If we really must make it be a tunable, a lighter weight to do this
would be to assign a new EXT2_FLAGS_xxx bit in es->s_flags, and allow
tune2fs to be able to adjust the field.  But I think a strong case
could be made that even that is overkill.

Cheers,

						- Ted

[1] A friend of mine back in my undergraduate days once took a scanned
image of a Kellogs Froot Loops cereal box, and did some creative image
editing to make it read "root oops", and replaced the text "Sweetened
Multigrain Cereal" with "rm is forever".  I should really ask her if
she still has a copy of the image.  :-)
