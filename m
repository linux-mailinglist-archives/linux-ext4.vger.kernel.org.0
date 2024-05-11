Return-Path: <linux-ext4+bounces-2466-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF2F8C33D0
	for <lists+linux-ext4@lfdr.de>; Sat, 11 May 2024 23:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AAD0B20FB7
	for <lists+linux-ext4@lfdr.de>; Sat, 11 May 2024 21:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6DB21A04;
	Sat, 11 May 2024 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="fSy1J64E"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4607617BAB
	for <linux-ext4@vger.kernel.org>; Sat, 11 May 2024 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715461887; cv=none; b=FyP9PHG6Q4mh1DgWO/O+wUXT1Gv1h2s0hefbXI8nwx5yiiCFzq6fIWEimdyLB1VFlBYePlp3eN0BjMYs5gVUFp14VHUC3F74UyLP2bRz8lsiaghMWE4rZ9a6yCmGXeEo7ALjxsTRRT2gD93KzdYZccY+Rfa3cAFJ+WRdNoUHG7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715461887; c=relaxed/simple;
	bh=kJVDLALZidCmgSbZPHhXzlhchHYLkjc0AlkX4pIv4f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+TJG1FphdhsDc5IRjJAybuo3Hk/QU5NlErEurk9LJGw8V7d86ED5IV2dWnfslRH88tzhAcz2bXCg8XBhz7T+EqLm2oT34MMf91JvJMKaNB00h9fXJFEfJWmzvFkYrXzMhwZ2rT3VxD0QPqYgJ9BGPmSRW7L2ihUgdDcWRJauE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=fSy1J64E; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-33.bstnma.fios.verizon.net [108.26.156.33])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44BLBBXR014486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 May 2024 17:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715461873; bh=dIyxdzXTrRQaKLhsuF0q8Wg2Yo1YioB5EW7AUHS/oMI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=fSy1J64EU62iUA2PNfCbfl65mAebKWoK7763qtxLZrJKcyEjfF00jxQfBvS9x1r1a
	 2vVkVPk7UC4xrdxPSNMkgXuFI6xeZ+tJEhE6MlehMhHm7zcNWLaQU+2lSazaE+n5Kv
	 OuLR1V43BQiN+KUwJE0U6N1p+aVai17AhvCdKZFkkYczIOWGkIDP6TC0JMIqo7zDQV
	 AGz8lQkHBkKzxNjVSeoWUwiolmYwYO0U7p6Yay9Iqphifs6Cu4qzONZmEq14x+tMMj
	 FLD4IkiD02cVGiqY0ozJnVa3d5yjdbsEO4iiHE8IT+OWe6t2jNXCBfFj8bk5uRZU7j
	 4FK0QfJsTNhcg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A2AD315C026D; Sat, 11 May 2024 17:11:11 -0400 (EDT)
Date: Sat, 11 May 2024 17:11:11 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Johannes Schauer Marin Rodrigues <josch@mister-muffin.de>
Cc: linux-ext4@vger.kernel.org
Subject: Re: created ext4 disk image differs depending on the underlying
 filesystem
Message-ID: <20240511211111.GA8330@mit.edu>
References: <171483317081.2626447.5951155062757257572@localhost>
 <171484520952.2626447.2160419274451668597@localhost>
 <20240505001020.GA3035072@mit.edu>
 <171540568260.2626447.10970955416649779876@localhost>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171540568260.2626447.10970955416649779876@localhost>

On Sat, May 11, 2024 at 07:34:42AM +0200, Johannes Schauer Marin Rodrigues wrote:
>  2. allow resetting fs->super->s_kbytes_written to zero. This patch worked for
>     me:
> 
> Would you be happy about a patch for (2.)? If yes, I can send something over
> once I find some time. :)
> 

I'm currently going back and forth about whether we should just (a)
unconditionally set s_kbytes_writes to zero before we write out the
superblock, or (b) whether we add a new extended operation, or (c) do
a hack where if SOURCE_DATE_EPOCH is set, use that as implied "set
s_kbytes_written to zero since the user is probably caring about a
reproducible file system".

(c) is a bit hacky, but it's the most convenient for users, and adding
Yet Another extended operation.

Related to this is the design question about whether SOURCE_DATE_EPOCH
should imply using a fixed value for s_uuid and s_hash_seed.  Again,
it's a little weird to overload SOURCE_DATE_EPOCH to setting the uuid
and hash_seed to some fixed value, which might be a time-based UUID
with the ethernet address set to all zeroes, or some other fixed
value.  But it's a pretty good proxy of what the user wants, and if
this is this is the default, the user can always override it via an
extended option if they really want something different.

If it weren't for the fact that I'm considering have SOURCE_DATE_EPOCH
provide default values for s_uuid and s_hash_seed, I'd be tempted to just
unconditionally set the s_kbytes_written to zero.

I'm curious what your opinions might be on this, as someone who might
want to use this feature.

> As an end-user I am very interested in keeping the functionality of mke2fs
> which keeps track of which parts are actually sparse and which ones are not.
> This functionality can be used with tools like "bmaptool" (a more clever dd) to
> only copy those parts of the image to the flash drive which are actually
> supposed to contain data.

If the file system where the image is created supports either the
FIEMAP ioctl or fallocate SEEK_HOLE, then "bmaptool create" can figure
out which parts of the file is sparse, so we don't need to make any
changes to e2fsprogs.  If the file system doesn't support FIEMAP or
SEEK_HOLE, one could imagine that bmaptool could figure out which
parts of the file could be sparse simply by looking for blocks that
are all zeroes.  This is basically what "cp --sparse=always" or what
the attached make-sparse.c file does to determine where the holes could be.

Yes, I could imagine adding a new io_manager much like test_io and
undo_io which tracked which blocks had been written, and then would
write out a BMAP file.  However, the vast majority of constructed file
systems are quite small, so simply reading all of the blocks to
determine which blocks were all zeroes ala cp --sparse=always isn't
going to invole all that much overhead.  And I'd argue the right thing
to do would be to teach bmaptool how to do what cp --sparse=always so
that the same interface regardless of whether bmaptool is running on a
modern file system that supports FIEMAP or SEEK_HOLE, or some legacy
file system like FAT16 or FAT32.

Cheers,

						- Ted
/*
 * make-sparse.c --- make a sparse file from stdin
 * 
 * Copyright 2004 by Theodore Ts'o.
 *
 * %Begin-Header%
 * This file may be redistributed under the terms of the GNU Public
 * License.
 * %End-Header%
 */

#define _LARGEFILE_SOURCE
#define _LARGEFILE64_SOURCE

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>

int full_read(int fd, char *buf, size_t count)
{
	int got, total = 0;
	int pass = 0;

	while (count > 0) {
		got = read(fd, buf, count);
		if (got == -1) {
			if ((errno == EINTR) || (errno == EAGAIN)) 
				continue;
			return total ? total : -1;
		}
		if (got == 0) {
			if (pass++ >= 3)
				return total;
			continue;
		}
		pass = 0;
		buf += got;
		total += got;
		count -= got;
	}
	return total;
}

int main(int argc, char **argv)
{
	int fd, got, i;
	int zflag = 0;
	char buf[1024];

	if (argc != 2) {
		fprintf(stderr, "Usage: make-sparse out-file\n");
		exit(1);
	}
	fd = open(argv[1], O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0777);
	if (fd < 0) {
		perror(argv[1]);
		exit(1);
	}
	while (1) {
		got = full_read(0, buf, sizeof(buf));
		if (got == 0)
			break;
		if (got == sizeof(buf)) {
			for (i=0; i < sizeof(buf); i++) 
				if (buf[i])
					break;
			if (i == sizeof(buf)) {
				lseek(fd, sizeof(buf), SEEK_CUR);
				zflag = 1;
				continue;
			}
		}
		zflag = 0;
		write(fd, buf, got);
	}
	if (zflag) {
		lseek(fd, -1, SEEK_CUR);
		buf[0] = 0;
		write(fd, buf, 1);
	}
	return 0;
}
		

