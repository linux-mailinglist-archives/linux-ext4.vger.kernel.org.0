Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856AE2FCB3D
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Jan 2021 08:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbhATG62 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Jan 2021 01:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbhATG6U (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Jan 2021 01:58:20 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CCAC061575;
        Tue, 19 Jan 2021 22:57:39 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id p72so20149462iod.12;
        Tue, 19 Jan 2021 22:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Bzkf7Ld2rxa9FcnXEU6RIP9KlVPZQPWVVVy1sBXrxc=;
        b=D6owGlKuLWuHRp6fVEbwbq/7wQS31AaZL+rfslaqriM91tGkiPPt+U83dCNDagIo1E
         XC1cJUdLxIwtPrZkd++CRg9NhTLlF5gAZ8Uy7Zt/FZmLz84yCtH+z+J400cosgm9swG9
         bH+m52U+YKVuFJ4fO+bhJI3iTdr+3Rv4Jl+l2x2g+yD8XZhmGbjT+dDIx3j9R/FyRQbd
         SIQv0OvdqsbhAKPJ7vpvfRX8cuK7p454226X3OoIl3UHaWEPmGqqEtqDY+J3LHcdVJgo
         i62imdLUTtFI/X3tgtQVs7/ufkuL8LHEhXgh1Ix5K9bCPCw51W5w169V+nUHXmUysFPV
         Tc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Bzkf7Ld2rxa9FcnXEU6RIP9KlVPZQPWVVVy1sBXrxc=;
        b=XmsXIIA5EYVqUycJFYdFSXGsAjoHRRjnsH+oJAFFui1LFnU7kPbLKsslRkr+HQgx61
         VFo13FtU6+BN/2ClGyuF2a0yKjWIRYdJjA1WX/O5PQjEk5XSkEXuV8b1P0zIGKNZPYBo
         DQNzj01vWrgWeM6/vlRtR/jq8D0NsMm7InD5cX6TlzZwrezu/+pORhZkwDYZ/aYMWsVF
         3XWp3lRU7fIrKOC4xgW6AAp3F5xxam889gVqIfRI7XWDbzqjndzXebS+48Zl28s/ADR3
         VoFRF5FjdO8QzpeH1X6DC09dQsVMVq/E8mOLvMCEsIjhEuKQCmgZiDJFgpIxQ5F5H0vO
         mZmg==
X-Gm-Message-State: AOAM5302705afKx3xg0SkfqfsjQAAXe1jq1j2CA8Lqt2jNOpYzv/Jx7D
        yxZUYp6AJi8+4/oUjSCKkfCaWtFEoN6PVtfVUy8=
X-Google-Smtp-Source: ABdhPJwsqxZP9Ik77Oi4FzXkuY+RChRCD1RWmoEAQ4BWZiKI7oWwdcJuKkQ6hr4p2rVsoNx4sTPjj4FO/rOjLBPwMgM=
X-Received: by 2002:a02:b0dc:: with SMTP id w28mr6527528jah.123.1611125859315;
 Tue, 19 Jan 2021 22:57:39 -0800 (PST)
MIME-Version: 1.0
References: <20210105062857.3566-1-yangerkun@huawei.com> <X/+/3ui/TQ9LjtNZ@mit.edu>
In-Reply-To: <X/+/3ui/TQ9LjtNZ@mit.edu>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 20 Jan 2021 08:57:28 +0200
Message-ID: <CAOQ4uxh2V6LF_t8ZaAOr=CbDrY3A5d0qSR7XWVX8dStR9mME5w@mail.gmail.com>
Subject: Re: [PATCH v3] ext4: fix bug for rename with RENAME_WHITEOUT
To:     "Theodore Ts'o" <tytso@mit.edu>,
        harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     yangerkun <yangerkun@huawei.com>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, "zhangyi (F)" <yi.zhang@huawei.com>,
        lihaotian9@huawei.com, lutianxiong@huawei.com,
        linfeilong@huawei.com, fstests <fstests@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 14, 2021 at 5:53 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Jan 05, 2021 at 02:28:57PM +0800, yangerkun wrote:
> > We got a "deleted inode referenced" warning cross our fsstress test. The
> > bug can be reproduced easily with following steps:
> >
> >   cd /dev/shm
> >   mkdir test/
> >   fallocate -l 128M img
> >   mkfs.ext4 -b 1024 img
> >   mount img test/
> >   dd if=/dev/zero of=test/foo bs=1M count=128
> >   mkdir test/dir/ && cd test/dir/
> >   for ((i=0;i<1000;i++)); do touch file$i; done # consume all block
> >   cd ~ && renameat2(AT_FDCWD, /dev/shm/test/dir/file1, AT_FDCWD,
> >     /dev/shm/test/dir/dst_file, RENAME_WHITEOUT) # ext4_add_entry in
> >     ext4_rename will return ENOSPC!!
> >   cd /dev/shm/ && umount test/ && mount img test/ && ls -li test/dir/file1
> >   We will get the output:
> >   "ls: cannot access 'test/dir/file1': Structure needs cleaning"
> >   and the dmesg show:
> >   "EXT4-fs error (device loop0): ext4_lookup:1626: inode #2049: comm ls:
> >   deleted inode referenced: 139"
> >
> > ext4_rename will create a special inode for whiteout and use this 'ino'
> > to replace the source file's dir entry 'ino'. Once error happens
> > latter(the error above was the ENOSPC return from ext4_add_entry in
> > ext4_rename since all space has been consumed), the cleanup do drop the
> > nlink for whiteout, but forget to restore 'ino' with source file. This
> > will trigger the bug describle as above.
> >
> > Signed-off-by: yangerkun <yangerkun@huawei.com>
>

Apropos RENAME_WHITEOUT, it seems to be missing __ext4_fc_track_link().
I guess test coverage of RENAME_WHITEOUT in fstests is not much.
I have been seeing trickles of bug fixes for RENAME_WHITEOUT for almost
every filesystem that supports it.

But I must say it would have been very hard to catch missing ext4_fc_track_*
without specialized fs fuzzer such as the CrashMonkey generated tests.

And as long as I am ranting, I'd like to point out that it is a shame
that whiteout
was not implemented as a special (constant) inode whose nlink is irrelevant
(or a special dirent with d_ino 0 and d_type DT_WHT for that matter).
It would have been a rather small RO_COMPAT on-disk change for ext4.
It could also be implemented in slightly more backward compat manner by
maintaining a valid nlink and postpone setting the RO_COMPAT flag until
EXT4_LINK_MAX is reached.

As things stand now, overlayfs makes an effort to maintain a singleton
hardlinked whiteout inode, without being able to use it with RENAME_WHITEOUT
and filesystems have to take special care to journal the metadata of all
individual whiteout inodes, without any added value to the only user
(overlayfs).

But I guess that train has left the station long ago...

Thanks,
Amir.
