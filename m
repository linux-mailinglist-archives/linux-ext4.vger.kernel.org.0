Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A0A42FC5D
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Oct 2021 21:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242802AbhJOTpx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Oct 2021 15:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242779AbhJOTpx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Oct 2021 15:45:53 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D9AC061570
        for <linux-ext4@vger.kernel.org>; Fri, 15 Oct 2021 12:43:46 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 5so11890633edw.7
        for <linux-ext4@vger.kernel.org>; Fri, 15 Oct 2021 12:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deitcher-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XXMKBuIHghjtitisIwjGVLbsrDX4NfctIZnmuUhZY0Q=;
        b=ce/SORKgkpRi17400I310Se3OiQpUI7pCDvpt6C9T1pmSBe9CFIj7KCEIGGm65vn4n
         BC9kvvXL9sFilHrtmgAPTCJrE1fz9COGr8vJuoTHF679r9m1YUz7xCUojzvn3svw8CWG
         UyHXq8BwsKd9vew8tnA+c+gKUnsibVtdyVSuR2p/UBw8zs+zu6jA2+eAuqXSapPzVdud
         82p3s7lvfHja7pyB38GwL3Sse7Tnw17iKG4SirnaSALKuoPqmBDp6dNZAVSTv1F5j2RK
         D1ZFdQjBG+rt8O63+0T8ZA8n0FFWOtyWaOmikbu+pN0SpHUm6g2qIvk70vxWWwq/+HiE
         TeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XXMKBuIHghjtitisIwjGVLbsrDX4NfctIZnmuUhZY0Q=;
        b=hUizakScY9K37j7f7j0KE65QYNMCW3MN7YKZzwcbfl6kqbnbWHeaHqYkeiOCJgaOPw
         LZIw13FTKWgrwH9uDNmKG50bcBXCQSqvTpdio+PkzZ4iK4WQAKrGW8TgnHPOxutqMR7O
         XLIIvG/heMaWdqHFXMP4OR9ivXSXT5bF94CD5O51diccWvlfJfIcHkoE7ZEcMbddqluz
         nBdoEgEVubfe1uq3shClFEI5CwB9mWTJBzu8PCz/Gb9CKRsAtCErBFbPjCAo65tG7H9T
         CuCaPr9Qpbacxc7ddmrmNTIWME7+mZVSwRrswDFcLGMft1fAyEetUZi4OXwBDkm0LrGu
         TE7A==
X-Gm-Message-State: AOAM5318nmKoXJdYIkF9WEKt+5UZ1ziDqMNVUfcBF2X5iuU2ER3/79Lk
        8NiX6/5dlTUGHGX8ipGcem3me15r7ro6yyNwRqEz4WjEc5E=
X-Google-Smtp-Source: ABdhPJxF46DvgoQH9XGs+yrzgeq2hF/z3PAIQnlc2I/wEykvw5uElvSim9mHWeYMXDfibNMBZC21S60gUCcOsk2zNHM=
X-Received: by 2002:a17:907:3e0b:: with SMTP id hp11mr309436ejc.549.1634327024943;
 Fri, 15 Oct 2021 12:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAF1vpkgPAy3FJ9mN22OVQ41jQAYoRdoCdqzYwRYYPXD4uucdpg@mail.gmail.com>
 <3A493D20-568A-4D63-A575-5DEEBFAAF41A@dilger.ca> <CAF1vpkigHMdKphnNjDm7=rR6TTxViHGGHi3bb64rsHG7KbqYzQ@mail.gmail.com>
 <CAF1vpkhwSOfGfErUUrp0YU5hSt58TtykTECiJXTcgqDtG0WVVg@mail.gmail.com>
 <YWSck57bsX/LqAKr@mit.edu> <CAF1vpkiKx3jArgjNBrid9-MSHBweGsFL0zu0UgDX_dq_hrkUgw@mail.gmail.com>
 <YWXGRgfxJZMe9iut@mit.edu> <CAF1vpkggQpYrg7Z2VVK69pPBo0rSjDUsm8nB8dyES27cmDEf2g@mail.gmail.com>
 <YWnSMXcR5anaYTEU@mit.edu>
In-Reply-To: <YWnSMXcR5anaYTEU@mit.edu>
From:   Avi Deitcher <avi@deitcher.net>
Date:   Fri, 15 Oct 2021 12:43:33 -0700
Message-ID: <CAF1vpki7HqHgXxWsTwMEo4yz592agzZ9c=F09o-1py+jtJpLSw@mail.gmail.com>
Subject: Re: algorithm for half-md4 used in htree directories
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks, Ted, I will try yours and step through it to figure out what is off.

You ask a fair question: other than madness, why would someone want to
recreate the exact algorithm?

I have had a number of cases where I have needed to manipulate disks,
filesystems, partition tables, etc. from within a non-C-source
program. The options have been: fork/exec to some external program;
run a VM where I can mount the fs and manipulate content as needed.
Those both work, but have had issues in various environments.

I made the mistake of saying, "well, all of this is just manipulating
bytes on a disk image or block device; how hard could it be?" :-)
So understanding the algorithm actually becomes important.

I probably could link the library in if I am working on languages that
support it (go, rust), but not all do, and there are reasons that is
more difficult for the target use case.

I was long hoping to finish with go and move onto Rust by now, then
possibly some others, but this is not what I get paid for, so catch as
catch can.

Does that answer? Feel free to say, "madness" too; I won't disagree.
Avi

On Fri, Oct 15, 2021 at 12:10 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Oct 15, 2021 at 11:43:07AM -0700, Avi Deitcher wrote:
> > I am absolutely stumped. I tried the seed as four u32 as is on disk
> > (i.e. big-endian); four u32 little-endian; one long little-endian
> > array of bytes (I have no idea why that would make sense, but worth
> > trying); zeroed out so it gets the default. No one gives a consistent
> > solution.
> >
> > As far as I can tell: hash tells you which intermediate block to look
> > in, minor hash tells you which leaf block to look in, and then you
> > scan. So it is pretty easy to see in what range the minor and major
> > hash should be, but no luck.
> >
> > I put up a gist with debugfs and source and output.
> > https://gist.github.com/deitch/53b01a90635449e7674babfe7e7dd002
> >
> > Anyone who feels like a look-see, I would much appreciate it (and if
> > they figure it out, owe a beer if ever in the same city).
>
> I'm really curious *why* you are trying to reverse engineer the
> implementation.  What are you trying to do?
>
> In any case, you're mostly right about what hash and minor_hash are
> for.  The 32-bit hash value is only thing that we use in the hashed B+
> tree which is used for hash directories.  The 32-bit minor hash is
> used to form a 64-bit number that gets used when we need to support
> things like NFSv3 directory cursors, and POSIX telldir/seekdir (which
> is a massive headache for modern file system, since it assumes that a
> 64-bit "offset" is all you get to reliably provide the POSIX
> telldir/seekdir/readdir guarantees even when the directory is getting
> large number of directory entries added and deleted without limit
> between the telldir and the seekdir call).
>
> As far as what you are doing wrong, I'll point out that *this* program
> (attached below) provides the correct result.  Running this through a
> debugger and comparing it with your implrementation is left as an
> exercise for the reader --- but why do you want to try to make your
> own implementation, when you could just pull down e2fsprogs, compile
> it, and then *use* the provided ext2_fs library for whatever the heck
> you are trying to do?
>
>                                        - Ted
>
> #include <stdio.h>
> #include <stdlib.h>
>
> #include <et/com_err.h>
> #include <uuid/uuid.h>
> #include <ext2fs/ext2_fs.h>
> #include <ext2fs/ext2fs.h>
>
> int main(int argc, char **argv)
> {
>         uuid_t  buf;
>         unsigned int *p;
>         int i;
>         ext2_dirhash_t hash, minor_hash;
>         errcode_t retval;
>
>         uuid_parse("d64563bc-ea93-4aaf-a943-4657711ed153", buf);
>         p = (unsigned int *) buf;
>         for (i=0; i < 4; i++) {
>                 printf("buf[%d] = 0x%08x\n", i, p[i]);
>         }
>
>         retval = ext2fs_dirhash(1, "dir478", strlen("dir478"), p,
>                                 &hash, &minor_hash);
>         printf("dirhash results: retval=%u, hash=0x%08x, minor_hash=0x%08x\n",
>                i, hash, minor_hash);
>
>         exit(0);
> }
>
> % gcc -g -o /tmp/foo /tmp/foo.c -luuid -lext2fs -lcom_err
> % /tmp/foo
> buf[0] = 0xbc6345d6
> buf[1] = 0xaf4a93ea
> buf[2] = 0x574643a9
> buf[3] = 0x53d11e71
> dirhash results: retval=4, hash=0x012225e2, minor_hash=0x3f08755d



-- 
Avi Deitcher
avi@deitcher.net
Follow me http://twitter.com/avideitcher
Read me http://blog.atomicinc.com
