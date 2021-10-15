Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F24442FBBD
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Oct 2021 21:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbhJOTMx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Oct 2021 15:12:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48835 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232055AbhJOTMx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Oct 2021 15:12:53 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19FJAf6L026185
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Oct 2021 15:10:41 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3093315C00CA; Fri, 15 Oct 2021 15:10:41 -0400 (EDT)
Date:   Fri, 15 Oct 2021 15:10:41 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Avi Deitcher <avi@deitcher.net>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: algorithm for half-md4 used in htree directories
Message-ID: <YWnSMXcR5anaYTEU@mit.edu>
References: <CAF1vpkgPAy3FJ9mN22OVQ41jQAYoRdoCdqzYwRYYPXD4uucdpg@mail.gmail.com>
 <3A493D20-568A-4D63-A575-5DEEBFAAF41A@dilger.ca>
 <CAF1vpkigHMdKphnNjDm7=rR6TTxViHGGHi3bb64rsHG7KbqYzQ@mail.gmail.com>
 <CAF1vpkhwSOfGfErUUrp0YU5hSt58TtykTECiJXTcgqDtG0WVVg@mail.gmail.com>
 <YWSck57bsX/LqAKr@mit.edu>
 <CAF1vpkiKx3jArgjNBrid9-MSHBweGsFL0zu0UgDX_dq_hrkUgw@mail.gmail.com>
 <YWXGRgfxJZMe9iut@mit.edu>
 <CAF1vpkggQpYrg7Z2VVK69pPBo0rSjDUsm8nB8dyES27cmDEf2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF1vpkggQpYrg7Z2VVK69pPBo0rSjDUsm8nB8dyES27cmDEf2g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 15, 2021 at 11:43:07AM -0700, Avi Deitcher wrote:
> I am absolutely stumped. I tried the seed as four u32 as is on disk
> (i.e. big-endian); four u32 little-endian; one long little-endian
> array of bytes (I have no idea why that would make sense, but worth
> trying); zeroed out so it gets the default. No one gives a consistent
> solution.
> 
> As far as I can tell: hash tells you which intermediate block to look
> in, minor hash tells you which leaf block to look in, and then you
> scan. So it is pretty easy to see in what range the minor and major
> hash should be, but no luck.
> 
> I put up a gist with debugfs and source and output.
> https://gist.github.com/deitch/53b01a90635449e7674babfe7e7dd002
> 
> Anyone who feels like a look-see, I would much appreciate it (and if
> they figure it out, owe a beer if ever in the same city).

I'm really curious *why* you are trying to reverse engineer the
implementation.  What are you trying to do?

In any case, you're mostly right about what hash and minor_hash are
for.  The 32-bit hash value is only thing that we use in the hashed B+
tree which is used for hash directories.  The 32-bit minor hash is
used to form a 64-bit number that gets used when we need to support
things like NFSv3 directory cursors, and POSIX telldir/seekdir (which
is a massive headache for modern file system, since it assumes that a
64-bit "offset" is all you get to reliably provide the POSIX
telldir/seekdir/readdir guarantees even when the directory is getting
large number of directory entries added and deleted without limit
between the telldir and the seekdir call).

As far as what you are doing wrong, I'll point out that *this* program
(attached below) provides the correct result.  Running this through a
debugger and comparing it with your implrementation is left as an
exercise for the reader --- but why do you want to try to make your
own implementation, when you could just pull down e2fsprogs, compile
it, and then *use* the provided ext2_fs library for whatever the heck
you are trying to do?

    	     	      	  	       - Ted

#include <stdio.h>
#include <stdlib.h>

#include <et/com_err.h>
#include <uuid/uuid.h>
#include <ext2fs/ext2_fs.h>
#include <ext2fs/ext2fs.h>

int main(int argc, char **argv)
{
	uuid_t	buf;
	unsigned int *p;
	int i;
	ext2_dirhash_t hash, minor_hash;
	errcode_t retval;

	uuid_parse("d64563bc-ea93-4aaf-a943-4657711ed153", buf);
	p = (unsigned int *) buf;
	for (i=0; i < 4; i++) {
		printf("buf[%d] = 0x%08x\n", i, p[i]);
	}

	retval = ext2fs_dirhash(1, "dir478", strlen("dir478"), p,
				&hash, &minor_hash);
	printf("dirhash results: retval=%u, hash=0x%08x, minor_hash=0x%08x\n",
	       i, hash, minor_hash);

	exit(0);
}

% gcc -g -o /tmp/foo /tmp/foo.c -luuid -lext2fs -lcom_err
% /tmp/foo
buf[0] = 0xbc6345d6
buf[1] = 0xaf4a93ea
buf[2] = 0x574643a9
buf[3] = 0x53d11e71
dirhash results: retval=4, hash=0x012225e2, minor_hash=0x3f08755d
