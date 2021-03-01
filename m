Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FD6328356
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Mar 2021 17:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbhCAQQt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Mar 2021 11:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237617AbhCAQOw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Mar 2021 11:14:52 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6A1C061756
        for <linux-ext4@vger.kernel.org>; Mon,  1 Mar 2021 08:14:09 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id n132so6492127iod.0
        for <linux-ext4@vger.kernel.org>; Mon, 01 Mar 2021 08:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=A7HIX2NBN3/R8zTjeWbDo3TdoxzfmpVRPsjASa0C0JM=;
        b=iG49/1NF5a2lOjckxEwVnHrqR+Z5q9nylHr43OAAQAAuDSXkIkiOZK7J26qxpTdwr6
         4Zq3TJerlUZJG9eBEhHhhvn86BJk+Uc64v5L106rGHlNICldx7oG4xsGl5Sdl6VZe5JO
         hDPxRJgArl2b2OkrAzfjcORoi6uDtMqXwrlrXwWvBI7my7J2vSOirwCuMsk+cvBU4ajK
         ufLCZkY/km8KLLSSw9ZoiE+F2tISV+yS1sTe98ooz231NqusyWQz8/glMA8v/OlHuBeG
         zQ5h5gAD+cuB6uoZ6mtISVT0Lm7AKAHVfKuL15cBnVv2eA9ct6oxpdxJN5m0F2u3SoNo
         REyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=A7HIX2NBN3/R8zTjeWbDo3TdoxzfmpVRPsjASa0C0JM=;
        b=fi5rvhyJe4zr1fUQp5aZXVtcLNdDB9EaGPppl45IgEhcnhuZ2bgn/hcXmXaCROHvU7
         UG/Yiy5GK8h94ifOg+jMB8IpYGbLDUNv7Hl78kmiEEe7chMbvH3j/DHiFn49UbAWFaFW
         ZmFSP8t0YezqZyuRkvS6paeUYva8IrhIHdj5gsEUzzMugu7z5infL6lWyhbmVmwXbSVh
         3zzglDbHiAkapVn82b0gmso7d800NF1zUe+ErQvC8YRwpaRps3YKVq0h6IR4vc5f1wBW
         qGdqQHIC1K5HFZPWx9FHjwWp+p5jEdyxSV7KhVxxAv8zODfAMbPNNdLLHyOm55bokHeg
         B89g==
X-Gm-Message-State: AOAM531svJ8+c3PDwRfYR+pm8iNZ1hwTwecyd10DRgB8SHxvViRf9tD/
        pQcBONr1gUM4S4TyP0rK0lM=
X-Google-Smtp-Source: ABdhPJx6mCAet8Soh3m8qTZbOLXE0xLAR09Wnb2JgAtIgAR3X/WPlslnlAZDCllca1ZUuzb6mWPP4w==
X-Received: by 2002:a5e:8416:: with SMTP id h22mr8898353ioj.119.1614615249183;
        Mon, 01 Mar 2021 08:14:09 -0800 (PST)
Received: from [172.25.17.251] ([136.162.66.10])
        by smtp.gmail.com with ESMTPSA id h23sm8814024ila.15.2021.03.01.08.14.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Mar 2021 08:14:08 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: [PATCH] libfs: Fix DIO mode aligment
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <YDmBmE159JOG8gRk@mit.edu>
Date:   Mon, 1 Mar 2021 19:14:00 +0300
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Alexey Lyashkov <alexey.lyashkov@hpe.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <77366B06-6C34-4515-A630-01534133E92A@gmail.com>
References: <20201023112659.1559-1-artem.blagodarenko@gmail.com>
 <YDmBmE159JOG8gRk@mit.edu>
To:     Theodore Ts'o <tytso@mit.edu>
X-Mailer: Apple Mail (2.3445.104.17)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Ted!

Thank you very much for the new version of the fix.

The problem can be easily reproduced, using loop device.

Here is how I reproduced it originally (without the patch)

# truncate -s 512MB /tmp/lustre-ost
# losetup -b 4096 /dev/loop0 /tmp/lustre-ost
# mkfs.ext4 /dev/loop0
mke2fs 1.45.6.wc1 (20-Mar-2020)
detected raid stride 4096 too large, use optimum 512
Discarding device blocks: done                           =20
Creating filesystem with 125000 4k blocks and 125056 inodes
Filesystem UUID: 541ad524-556a-45be-84fe-5b68c1ca4562
Superblock backups stored on blocks:
    32768, 98304
=20
Allocating group tables: done                           =20
Writing inode tables: done                           =20
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done

# git rev-parse HEAD
0f880f553dfa09dabe4cb03752b97a07b66eb998

[root@CO82 e2fsprogs-hpe]# misc/e2image /dev/loop0 /tmp/ost-image
e2image 1.45.2.cr2 (09-Apr-2020)
misc/e2image: Attempt to read block from filesystem resulted in short =
read while trying to open /dev/loop0
Couldn't find valid filesystem superblock.


With your patch e2image works fine.


[root@CO82 e2fsprogs-kernel]# truncate -s 512MB /tmp/lustre-ost
[root@CO82 e2fsprogs-kernel]# losetup -b 4096 /dev/loop0 /tmp/lustre-ost
[root@CO82 e2fsprogs-kernel]# mkfs.ext4 /dev/loop0
mke2fs 1.45.6.wc1 (20-Mar-2020)
detected raid stride 4096 too large, use optimum 512
Discarding device blocks: done                           =20
Creating filesystem with 125000 4k blocks and 125056 inodes
Filesystem UUID: 42f6fc7d-382a-4681-99b8-79f3fcd2b4bf
Superblock backups stored on blocks:=20
	32768, 98304

Allocating group tables: done                           =20
Writing inode tables: done                           =20
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done

[root@CO82 e2fsprogs-kernel]# git rev-parse HEAD
67f2b54667e65cf5a478fcea8b85722be9ee6e8d
[root@CO82 e2fsprogs-kernel]# misc/e2image /dev/loop0 /tmp/ost-image
e2image 1.46.1 (9-Feb-2021)

Thanks again.
Best regards,
Artem Blagodarenko.


> On 27 Feb 2021, at 02:17, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> I've rewritten the patch because it was simplest way to review the
> code.  The resulting code is simpler and has a smaller number of lines
> of code.  I don't have any 4k advanced format disks handy, so I'd
> appreciate it if someone can test it.  It passes the existing
> regression tests, and I've run a number of manual tests to simulate a
> advanced format HDD, with the tests being run with clang and UBSAN and
> ADDRSAN enabled.
>=20
> If someone with access to an advanced format disk can test running
> debugfs -D on an advanced format disk, that would be great, thanks.
>=20
> 	      	 	  	       - Ted
>=20
> commit c001596110e834a85b01a47a20811b318cb3b9e4
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Fri Feb 26 17:41:06 2021 -0500
>=20
>    libext2fs: fix unix_io's Direct I/O support
>=20
>    The previous Direct I/O support worked on HDD's with 512 byte =
logical
>    sector sizes, and on FreeBSD which required 4k aligned memory =
buffers.
>    However, it was incomplete and was not correctly working on HDD's =
with
>    4k logical sector sizes (aka Advanced Format Disks).
>=20
>    Based on a patch from Alexey Lyashkov <alexey.lyashkov@hpe.com> but
>    rewritten to work with the latest e2fsprogs and to minimize changes =
to
>    make it easier to review.
>=20
>    Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>    Reported-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>
>=20
> diff --git a/lib/ext2fs/io_manager.c b/lib/ext2fs/io_manager.c
> index c395d615..996c31a1 100644
> --- a/lib/ext2fs/io_manager.c
> +++ b/lib/ext2fs/io_manager.c
> @@ -134,9 +134,11 @@ errcode_t io_channel_alloc_buf(io_channel io, int =
count, void *ptr)
> 	else
> 		size =3D -count;
>=20
> -	if (io->align)
> +	if (io->align) {
> +		if (io->align > size)
> +			size =3D io->align;
> 		return ext2fs_get_memalign(size, io->align, ptr);
> -	else
> +	} else
> 		return ext2fs_get_mem(size, ptr);
> }
>=20
> diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
> index 73f5667e..8965535c 100644
> --- a/lib/ext2fs/unix_io.c
> +++ b/lib/ext2fs/unix_io.c
> @@ -218,6 +218,8 @@ static errcode_t raw_read_blk(io_channel channel,
> 	int		actual =3D 0;
> 	unsigned char	*buf =3D bufv;
> 	ssize_t		really_read =3D 0;
> +	unsigned long long aligned_blk;
> +	int		align_size, offset;
>=20
> 	size =3D (count < 0) ? -count : (ext2_loff_t) count * =
channel->block_size;
> 	mutex_lock(data, STATS_MTX);
> @@ -226,7 +228,7 @@ static errcode_t raw_read_blk(io_channel channel,
> 	location =3D ((ext2_loff_t) block * channel->block_size) + =
data->offset;
>=20
> 	if (data->flags & IO_FLAG_FORCE_BOUNCE) {
> -		if (ext2fs_llseek(data->dev, location, SEEK_SET) !=3D =
location) {
> +		if (ext2fs_llseek(data->dev, location, SEEK_SET) < 0) {
> 			retval =3D errno ? errno : =
EXT2_ET_LLSEEK_FAILED;
> 			goto error_out;
> 		}
> @@ -237,6 +239,7 @@ static errcode_t raw_read_blk(io_channel channel,
> 	/* Try an aligned pread */
> 	if ((channel->align =3D=3D 0) ||
> 	    (IS_ALIGNED(buf, channel->align) &&
> +	     IS_ALIGNED(location, channel->align) &&
> 	     IS_ALIGNED(size, channel->align))) {
> 		actual =3D pread64(data->dev, buf, size, location);
> 		if (actual =3D=3D size)
> @@ -248,6 +251,7 @@ static errcode_t raw_read_blk(io_channel channel,
> 	if ((sizeof(off_t) >=3D sizeof(ext2_loff_t)) &&
> 	    ((channel->align =3D=3D 0) ||
> 	     (IS_ALIGNED(buf, channel->align) &&
> +	      IS_ALIGNED(location, channel->align) &&
> 	      IS_ALIGNED(size, channel->align)))) {
> 		actual =3D pread(data->dev, buf, size, location);
> 		if (actual =3D=3D size)
> @@ -256,12 +260,13 @@ static errcode_t raw_read_blk(io_channel =
channel,
> 	}
> #endif /* HAVE_PREAD */
>=20
> -	if (ext2fs_llseek(data->dev, location, SEEK_SET) !=3D location) =
{
> +	if (ext2fs_llseek(data->dev, location, SEEK_SET) < 0) {
> 		retval =3D errno ? errno : EXT2_ET_LLSEEK_FAILED;
> 		goto error_out;
> 	}
> 	if ((channel->align =3D=3D 0) ||
> 	    (IS_ALIGNED(buf, channel->align) &&
> +	     IS_ALIGNED(location, channel->align) &&
> 	     IS_ALIGNED(size, channel->align))) {
> 		actual =3D read(data->dev, buf, size);
> 		if (actual !=3D size) {
> @@ -286,23 +291,39 @@ static errcode_t raw_read_blk(io_channel =
channel,
> 	 * to the O_DIRECT rules, so we need to do this the hard way...
> 	 */
> bounce_read:
> +	if ((channel->block_size > channel->align) &&
> +	    (channel->block_size % channel->align) =3D=3D 0)
> +		align_size =3D channel->block_size;
> +	else
> +		align_size =3D channel->align;
> +	aligned_blk =3D location / align_size;
> +	offset =3D location % align_size;
> +
> +	if (ext2fs_llseek(data->dev, aligned_blk * align_size, SEEK_SET) =
< 0) {
> +		retval =3D errno ? errno : EXT2_ET_LLSEEK_FAILED;
> +		goto error_out;
> +	}
> 	while (size > 0) {
> 		mutex_lock(data, BOUNCE_MTX);
> -		actual =3D read(data->dev, data->bounce, =
channel->block_size);
> -		if (actual !=3D channel->block_size) {
> +		actual =3D read(data->dev, data->bounce, align_size);
> +		if (actual !=3D align_size) {
> 			mutex_unlock(data, BOUNCE_MTX);
> 			actual =3D really_read;
> 			buf -=3D really_read;
> 			size +=3D really_read;
> 			goto short_read;
> 		}
> -		actual =3D size;
> -		if (size > channel->block_size)
> -			actual =3D channel->block_size;
> -		memcpy(buf, data->bounce, actual);
> +		if ((actual + offset) > align_size)
> +			actual =3D align_size - offset;
> +		if (actual > size)
> +			actual =3D size;
> +		memcpy(buf, data->bounce + offset, actual);
> +
> 		really_read +=3D actual;
> 		size -=3D actual;
> 		buf +=3D actual;
> +		offset =3D 0;
> +		aligned_blk++;
> 		mutex_unlock(data, BOUNCE_MTX);
> 	}
> 	return 0;
> @@ -326,6 +347,8 @@ static errcode_t raw_write_blk(io_channel channel,
> 	int		actual =3D 0;
> 	errcode_t	retval;
> 	const unsigned char *buf =3D bufv;
> +	unsigned long long aligned_blk;
> +	int		align_size, offset;
>=20
> 	if (count =3D=3D 1)
> 		size =3D channel->block_size;
> @@ -342,7 +365,7 @@ static errcode_t raw_write_blk(io_channel channel,
> 	location =3D ((ext2_loff_t) block * channel->block_size) + =
data->offset;
>=20
> 	if (data->flags & IO_FLAG_FORCE_BOUNCE) {
> -		if (ext2fs_llseek(data->dev, location, SEEK_SET) !=3D =
location) {
> +		if (ext2fs_llseek(data->dev, location, SEEK_SET) < 0) {
> 			retval =3D errno ? errno : =
EXT2_ET_LLSEEK_FAILED;
> 			goto error_out;
> 		}
> @@ -353,6 +376,7 @@ static errcode_t raw_write_blk(io_channel channel,
> 	/* Try an aligned pwrite */
> 	if ((channel->align =3D=3D 0) ||
> 	    (IS_ALIGNED(buf, channel->align) &&
> +	     IS_ALIGNED(location, channel->align) &&
> 	     IS_ALIGNED(size, channel->align))) {
> 		actual =3D pwrite64(data->dev, buf, size, location);
> 		if (actual =3D=3D size)
> @@ -363,6 +387,7 @@ static errcode_t raw_write_blk(io_channel channel,
> 	if ((sizeof(off_t) >=3D sizeof(ext2_loff_t)) &&
> 	    ((channel->align =3D=3D 0) ||
> 	     (IS_ALIGNED(buf, channel->align) &&
> +	      IS_ALIGNED(location, channel->align) &&
> 	      IS_ALIGNED(size, channel->align)))) {
> 		actual =3D pwrite(data->dev, buf, size, location);
> 		if (actual =3D=3D size)
> @@ -370,13 +395,14 @@ static errcode_t raw_write_blk(io_channel =
channel,
> 	}
> #endif /* HAVE_PWRITE */
>=20
> -	if (ext2fs_llseek(data->dev, location, SEEK_SET) !=3D location) =
{
> +	if (ext2fs_llseek(data->dev, location, SEEK_SET) < 0) {
> 		retval =3D errno ? errno : EXT2_ET_LLSEEK_FAILED;
> 		goto error_out;
> 	}
>=20
> 	if ((channel->align =3D=3D 0) ||
> 	    (IS_ALIGNED(buf, channel->align) &&
> +	     IS_ALIGNED(location, channel->align) &&
> 	     IS_ALIGNED(size, channel->align))) {
> 		actual =3D write(data->dev, buf, size);
> 		if (actual < 0) {
> @@ -400,40 +426,59 @@ static errcode_t raw_write_blk(io_channel =
channel,
> 	 * to the O_DIRECT rules, so we need to do this the hard way...
> 	 */
> bounce_write:
> +	if ((channel->block_size > channel->align) &&
> +	    (channel->block_size % channel->align) =3D=3D 0)
> +		align_size =3D channel->block_size;
> +	else
> +		align_size =3D channel->align;
> +	aligned_blk =3D location / align_size;
> +	offset =3D location % align_size;
> +
> 	while (size > 0) {
> +		int actual_w;
> +
> 		mutex_lock(data, BOUNCE_MTX);
> -		if (size < channel->block_size) {
> +		if (size < align_size || offset) {
> +			if (ext2fs_llseek(data->dev, aligned_blk * =
align_size,
> +					  SEEK_SET) < 0) {
> +				retval =3D errno ? errno : =
EXT2_ET_LLSEEK_FAILED;
> +				goto error_out;
> +			}
> 			actual =3D read(data->dev, data->bounce,
> -				      channel->block_size);
> -			if (actual !=3D channel->block_size) {
> +				      align_size);
> +			if (actual !=3D align_size) {
> 				if (actual < 0) {
> 					mutex_unlock(data, BOUNCE_MTX);
> 					retval =3D errno;
> 					goto error_out;
> 				}
> 				memset((char *) data->bounce + actual, =
0,
> -				       channel->block_size - actual);
> +				       align_size - actual);
> 			}
> 		}
> 		actual =3D size;
> -		if (size > channel->block_size)
> -			actual =3D channel->block_size;
> -		memcpy(data->bounce, buf, actual);
> -		if (ext2fs_llseek(data->dev, location, SEEK_SET) !=3D =
location) {
> +		if ((actual + offset) > align_size)
> +			actual =3D align_size - offset;
> +		if (actual > size)
> +			actual =3D size;
> +		memcpy(((char *)data->bounce) + offset, buf, actual);
> +		if (ext2fs_llseek(data->dev, aligned_blk * align_size, =
SEEK_SET) < 0) {
> 			retval =3D errno ? errno : =
EXT2_ET_LLSEEK_FAILED;
> 			goto error_out;
> 		}
> -		actual =3D write(data->dev, data->bounce, =
channel->block_size);
> +		actual_w =3D write(data->dev, data->bounce, align_size);
> 		mutex_unlock(data, BOUNCE_MTX);
> -		if (actual < 0) {
> +		if (actual_w < 0) {
> 			retval =3D errno;
> 			goto error_out;
> 		}
> -		if (actual !=3D channel->block_size)
> +		if (actual_w !=3D align_size)
> 			goto short_write;
> 		size -=3D actual;
> 		buf +=3D actual;
> 		location +=3D actual;
> +		aligned_blk++;
> +		offset =3D 0;
> 	}
> 	return 0;
>=20

