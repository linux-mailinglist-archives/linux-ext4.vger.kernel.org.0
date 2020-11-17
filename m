Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E85A2B68B1
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Nov 2020 16:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgKQPaV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Nov 2020 10:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbgKQPaU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Nov 2020 10:30:20 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F311C0613CF
        for <linux-ext4@vger.kernel.org>; Tue, 17 Nov 2020 07:30:20 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id w8so8868233ilg.12
        for <linux-ext4@vger.kernel.org>; Tue, 17 Nov 2020 07:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0PAzhtJj5OEDlloqRuj3DKn1NzW/0i6I5r8x6sW5ivQ=;
        b=FSRwP1uVA7V4/MEnzFj0t7fbbWIT9mkdXziLVHq9CNJb3cY1pW1qbH/qXnCFdcTgNq
         onYpSGZ3hcRI9If2fiC2p+PD1K8GeKGuJ8v42Vx8v82tbOWAHNeWLzXehPs30QFneya4
         TS9oqBIi20XFARthnsMrQtXzykzzcXplwQNhfNkcElDWyiI5r3yRchHHoqsP4k7O3neQ
         BL7OB0FsxTCwFDeVqjTEROtv4aIdkTLRP66aMz5DbVanFz0U6j6Vj2X84i5bC9N2PHwa
         5fr5hT9n9NKwQn905iUp0hEvFcVSOHK/a9S1tj02IiFG2LoFFZP8P5kH8VgPuTOcgrF0
         Evsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0PAzhtJj5OEDlloqRuj3DKn1NzW/0i6I5r8x6sW5ivQ=;
        b=R4vLLIv7cKX3VsSElkmBl0SYG/TIS6GOO2EN6W/oH+4XTJmQ6KvOkc7Hz19W0fqaGF
         cd63TgKRirBwm7av51fiWueBjPNn7A08BPgQuv3QUmZ+iFIzM3URAZGg+01RgvE+ZNnr
         lc90Ki5Y6gW1BFC2YwmJnpWDJ+VbkBeRm3gQ427DtOAnR/6NJ6n0w+DOQNU23RN1kj0M
         CV2Wg1ptDp4+wo+6fFkp/b18r30B3MlJfvdxrf+KWdUTGi9pcf6LDbgSBtU2hLJ7x40j
         as75lVWOe3apMzwiezWXdE85zJ26MUjYi/EBOiAkURtFoSys3h8pK5Jt9Ugy8dBHBYYi
         qJNQ==
X-Gm-Message-State: AOAM531fg74DqauUm8Nf5OOV4CTONEj3Ejbu6D4gqjBKVe1aKw9igNTE
        rPa5+xw+EMjFk5pTDhZOsAE2JBeFysNfywPZ
X-Google-Smtp-Source: ABdhPJym8mpO/FmC0sRya+AWj5RvF5kNdOVJ4oZaXQ5dKUGZemWGwDEuckWbAeaVQ1BPsPjkeAH0dQ==
X-Received: by 2002:a05:6e02:ec9:: with SMTP id i9mr12625576ilk.56.1605627019216;
        Tue, 17 Nov 2020 07:30:19 -0800 (PST)
Received: from [172.25.17.194] ([136.162.66.1])
        by smtp.gmail.com with ESMTPSA id c89sm14014474ilf.26.2020.11.17.07.30.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2020 07:30:18 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: [PATCH] libfs: Fix DIO mode aligment
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <20201023112659.1559-1-artem.blagodarenko@gmail.com>
Date:   Tue, 17 Nov 2020 18:30:11 +0300
Cc:     adilger.kernel@dilger.ca,
        Alexey Lyashkov <alexey.lyashkov@hpe.com>,
        Theodore Tso <tytso@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <19A3D721-93C0-42F3-ACBA-DE15B4685F9F@gmail.com>
References: <20201023112659.1559-1-artem.blagodarenko@gmail.com>
To:     linux-ext4@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.17)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

Any thoughts about this change? Thanks.

Best regards,
Artem Blagodarenko.

> On 23 Oct 2020, at 14:26, Artem Blagodarenko =
<artem.blagodarenko@gmail.com> wrote:
>=20
> From: Alexey Lyashkov <alexey.lyashkov@hpe.com>
>=20
> Bounce buffer must be extended to hold a whole disk block size.
> Read/write operations with unaligned offsets is prohobined
> in the DIO mode, so read/write blocks should be adjusted to
> reflect it.
>=20
> Change-Id: Ic573c9ff0d476028dd2293f8b814c6112705db0e
> Signed-off-by: Alexey Lyashkov <alexey.lyashkov@hpe.com>
> HPE-bug-id: LUS-9241
> ---
> lib/ext2fs/io_manager.c |   5 +-
> lib/ext2fs/unix_io.c    | 296 +++++++++++++++++++++++++---------------
> 2 files changed, 190 insertions(+), 111 deletions(-)
>=20
> diff --git a/lib/ext2fs/io_manager.c b/lib/ext2fs/io_manager.c
> index c395d615..84399a12 100644
> --- a/lib/ext2fs/io_manager.c
> +++ b/lib/ext2fs/io_manager.c
> @@ -20,6 +20,9 @@
> #include "ext2_fs.h"
> #include "ext2fs.h"
>=20
> +#define max(a, b) ((a) > (b) ? (a) : (b))
> +
> +
> errcode_t io_channel_set_options(io_channel channel, const char *opts)
> {
> 	errcode_t retval =3D 0;
> @@ -128,7 +131,7 @@ errcode_t io_channel_alloc_buf(io_channel io, int =
count, void *ptr)
> 	size_t	size;
>=20
> 	if (count =3D=3D 0)
> -		size =3D io->block_size;
> +		size =3D max(io->block_size, io->align);
> 	else if (count > 0)
> 		size =3D io->block_size * count;
> 	else
> diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
> index 628e60c3..53647a22 100644
> --- a/lib/ext2fs/unix_io.c
> +++ b/lib/ext2fs/unix_io.c
> @@ -154,46 +154,30 @@ static char *safe_getenv(const char *arg)
> /*
>  * Here are the raw I/O functions
>  */
> -static errcode_t raw_read_blk(io_channel channel,
> +static errcode_t raw_aligned_read_blk(io_channel channel,
> 			      struct unix_private_data *data,
> -			      unsigned long long block,
> -			      int count, void *bufv)
> +			      ext2_loff_t location,
> +			      ssize_t size, void *bufv,
> +			      int *asize)
> {
> -	errcode_t	retval;
> -	ssize_t		size;
> -	ext2_loff_t	location;
> 	int		actual =3D 0;
> +	errcode_t	retval;
> 	unsigned char	*buf =3D bufv;
> -	ssize_t		really_read =3D 0;
> -
> -	size =3D (count < 0) ? -count : (ext2_loff_t) count * =
channel->block_size;
> -	data->io_stats.bytes_read +=3D size;
> -	location =3D ((ext2_loff_t) block * channel->block_size) + =
data->offset;
>=20
> -	if (data->flags & IO_FLAG_FORCE_BOUNCE) {
> -		if (ext2fs_llseek(data->dev, location, SEEK_SET) !=3D =
location) {
> -			retval =3D errno ? errno : =
EXT2_ET_LLSEEK_FAILED;
> -			goto error_out;
> -		}
> -		goto bounce_read;
> -	}
> +#ifdef ALIGN_DEBUG
> +	printf("raw_aligned_read_blk: %p %lu<>%lu\n", buf,
> +		location, (unsigned long) size);
> +#endif
>=20
> #ifdef HAVE_PREAD64
> 	/* Try an aligned pread */
> -	if ((channel->align =3D=3D 0) ||
> -	    (IS_ALIGNED(buf, channel->align) &&
> -	     IS_ALIGNED(size, channel->align))) {
> -		actual =3D pread64(data->dev, buf, size, location);
> -		if (actual =3D=3D size)
> -			return 0;
> -		actual =3D 0;
> -	}
> +	actual =3D pread64(data->dev, buf, size, location);
> +	if (actual =3D=3D size)
> +		return 0;
> +	actual =3D 0;
> #elif HAVE_PREAD
> 	/* Try an aligned pread */
> -	if ((sizeof(off_t) >=3D sizeof(ext2_loff_t)) &&
> -	    ((channel->align =3D=3D 0) ||
> -	     (IS_ALIGNED(buf, channel->align) &&
> -	      IS_ALIGNED(size, channel->align)))) {
> +	if (sizeof(off_t) >=3D sizeof(ext2_loff_t)) {
> 		actual =3D pread(data->dev, buf, size, location);
> 		if (actual =3D=3D size)
> 			return 0;
> @@ -205,47 +189,100 @@ static errcode_t raw_read_blk(io_channel =
channel,
> 		retval =3D errno ? errno : EXT2_ET_LLSEEK_FAILED;
> 		goto error_out;
> 	}
> +
> +	actual =3D read(data->dev, buf, size);
> +	if (actual !=3D size) {
> +		if (actual < 0) {
> +			retval =3D errno;
> +			actual =3D 0;
> +		} else {
> +			retval =3D EXT2_ET_SHORT_READ;
> +		}
> +	}
> +
> +error_out:
> +	*asize =3D actual;
> +	return retval;
> +}
> +
> +
> +/*
> + * Here are the raw I/O functions
> + */
> +static errcode_t raw_read_blk(io_channel channel,
> +			      struct unix_private_data *data,
> +			      unsigned long long block,
> +			      int count, void *bufv)
> +{
> +	errcode_t	retval;
> +	ssize_t		size;
> +	ext2_loff_t	location;
> +	int		actual =3D 0;
> +	unsigned char	*buf =3D bufv;
> +	unsigned int	align =3D channel->align;
> +	ssize_t		really_read =3D 0;
> +	blk64_t		blk;
> +	loff_t		offset;
> +
> +	size =3D (count < 0) ? -count : count * channel->block_size;
> +	data->io_stats.bytes_read +=3D size;
> +	location =3D ((ext2_loff_t) block * channel->block_size) + =
data->offset;
> +
> +	if (data->flags & IO_FLAG_FORCE_BOUNCE) {
> +		align =3D channel->block_size;
> +		goto bounce_read;
> +	}
> +
> 	if ((channel->align =3D=3D 0) ||
> -	    (IS_ALIGNED(buf, channel->align) &&
> +	    (IS_ALIGNED(location, channel->align) &&
> +	     IS_ALIGNED(buf, channel->align) &&
> 	     IS_ALIGNED(size, channel->align))) {
> -		actual =3D read(data->dev, buf, size);
> -		if (actual !=3D size) {
> -		short_read:
> -			if (actual < 0) {
> -				retval =3D errno;
> -				actual =3D 0;
> -			} else
> -				retval =3D EXT2_ET_SHORT_READ;
> +		retval =3D raw_aligned_read_blk(channel, data, location,
> +						size, bufv, &actual);
> +		if (retval !=3D 0)
> 			goto error_out;
> -		}
> -		return 0;
> +
> +		return retval;
> 	}
>=20
> +bounce_read:
> #ifdef ALIGN_DEBUG
> -	printf("raw_read_blk: O_DIRECT fallback: %p %lu\n", buf,
> -	       (unsigned long) size);
> +	printf("raw_read_blk: O_DIRECT fallback: %p %lu<>%lu\n", buf,
> +		location, (unsigned long) size);
> #endif
> -
> 	/*
> 	 * The buffer or size which we're trying to read isn't aligned
> 	 * to the O_DIRECT rules, so we need to do this the hard way...
> +	 * read / write must be aligned to the block device sector size
> 	 */
> -bounce_read:
> +
> +	blk =3D location / align;
> +	offset =3D location % align;
> +
> +	if (lseek(data->dev, blk * align, SEEK_SET) < 0)
> +		return errno;
> +
> 	while (size > 0) {
> -		actual =3D read(data->dev, data->bounce, =
channel->block_size);
> -		if (actual !=3D channel->block_size) {
> +		actual =3D read(data->dev, data->bounce, align);
> +		if (actual !=3D align) {
> 			actual =3D really_read;
> 			buf -=3D really_read;
> 			size +=3D really_read;
> -			goto short_read;
> +			retval =3D EXT2_ET_SHORT_READ;
> +			goto error_out;
> 		}
> 		actual =3D size;
> -		if (size > channel->block_size)
> -			actual =3D channel->block_size;
> -		memcpy(buf, data->bounce, actual);
> +		if ((actual + offset) > align)
> +			actual =3D align - offset;
> +		if (actual > size)
> +			actual =3D size;
> +
> +		memcpy(buf, data->bounce + offset, actual);
> 		really_read +=3D actual;
> 		size -=3D actual;
> 		buf +=3D actual;
> +		offset =3D 0;
> +		blk++;
> 	}
> 	return 0;
>=20
> @@ -258,6 +295,58 @@ error_out:
> 	return retval;
> }
>=20
> +static errcode_t raw_aligned_write_blk(io_channel channel,
> +			       struct unix_private_data *data,
> +			       ext2_loff_t  location,
> +			       ssize_t size, const void *bufv,
> +			       int *asize)
> +
> +{
> +	int		actual =3D 0;
> +	errcode_t	retval;
> +	const unsigned char *buf =3D (void *)bufv;
> +
> +#ifdef ALIGN_DEBUG
> +	printf("raw_aligned_write_blk: %p %lu %lu\n", buf,
> +	       location, (unsigned long) size);
> +#endif
> +
> +#ifdef HAVE_PWRITE64
> +	/* Try an aligned pwrite */
> +	actual =3D pwrite64(data->dev, buf, size, location);
> +	if (actual =3D=3D size)
> +		return 0;
> +#elif HAVE_PWRITE
> +	/* Try an aligned pwrite */
> +	if ((sizeof(off_t) >=3D sizeof(ext2_loff_t)) {
> +		actual =3D pwrite(data->dev, buf, size, location);
> +		if (actual =3D=3D size)
> +			return 0;
> +	}
> +#endif /* HAVE_PWRITE */
> +
> +	if (ext2fs_llseek(data->dev, location, SEEK_SET) !=3D location) =
{
> +		retval =3D errno ? errno : EXT2_ET_LLSEEK_FAILED;
> +		goto error_out;
> +	}
> +
> +	actual =3D write(data->dev, buf, size);
> +	if (actual < 0) {
> +		retval =3D errno;
> +		goto error_out;
> +	}
> +	if (actual !=3D size) {
> +		retval =3D EXT2_ET_SHORT_WRITE;
> +		goto error_out;
> +	}
> +	retval =3D 0;
> +error_out:
> +	*asize =3D actual;
> +	return retval;
> +
> +}
> +
> +
> static errcode_t raw_write_blk(io_channel channel,
> 			       struct unix_private_data *data,
> 			       unsigned long long block,
> @@ -268,6 +357,9 @@ static errcode_t raw_write_blk(io_channel channel,
> 	int		actual =3D 0;
> 	errcode_t	retval;
> 	const unsigned char *buf =3D bufv;
> +	unsigned int	align =3D channel->align;
> +	blk64_t		blk;
> +	loff_t		offset;
>=20
> 	if (count =3D=3D 1)
> 		size =3D channel->block_size;
> @@ -282,95 +374,79 @@ static errcode_t raw_write_blk(io_channel =
channel,
> 	location =3D ((ext2_loff_t) block * channel->block_size) + =
data->offset;
>=20
> 	if (data->flags & IO_FLAG_FORCE_BOUNCE) {
> -		if (ext2fs_llseek(data->dev, location, SEEK_SET) !=3D =
location) {
> -			retval =3D errno ? errno : =
EXT2_ET_LLSEEK_FAILED;
> -			goto error_out;
> -		}
> +		align =3D channel->block_size;
> 		goto bounce_write;
> 	}
>=20
> -#ifdef HAVE_PWRITE64
> -	/* Try an aligned pwrite */
> 	if ((channel->align =3D=3D 0) ||
> -	    (IS_ALIGNED(buf, channel->align) &&
> +	    (IS_ALIGNED(location, channel->align) &&
> +	     IS_ALIGNED(buf, channel->align) &&
> 	     IS_ALIGNED(size, channel->align))) {
> -		actual =3D pwrite64(data->dev, buf, size, location);
> -		if (actual =3D=3D size)
> -			return 0;
> -	}
> -#elif HAVE_PWRITE
> -	/* Try an aligned pwrite */
> -	if ((sizeof(off_t) >=3D sizeof(ext2_loff_t)) &&
> -	    ((channel->align =3D=3D 0) ||
> -	     (IS_ALIGNED(buf, channel->align) &&
> -	      IS_ALIGNED(size, channel->align)))) {
> -		actual =3D pwrite(data->dev, buf, size, location);
> -		if (actual =3D=3D size)
> -			return 0;
> -	}
> -#endif /* HAVE_PWRITE */
> +		retval =3D raw_aligned_write_blk(channel, data, =
location,
> +						size, bufv, &actual);
> +		if (retval !=3D 0)
> +			goto error_out;
>=20
> -	if (ext2fs_llseek(data->dev, location, SEEK_SET) !=3D location) =
{
> -		retval =3D errno ? errno : EXT2_ET_LLSEEK_FAILED;
> -		goto error_out;
> +		return retval;
> 	}
>=20
> -	if ((channel->align =3D=3D 0) ||
> -	    (IS_ALIGNED(buf, channel->align) &&
> -	     IS_ALIGNED(size, channel->align))) {
> -		actual =3D write(data->dev, buf, size);
> -		if (actual < 0) {
> -			retval =3D errno;
> -			goto error_out;
> -		}
> -		if (actual !=3D size) {
> -		short_write:
> -			retval =3D EXT2_ET_SHORT_WRITE;
> -			goto error_out;
> -		}
> -		return 0;
> -	}
>=20
> +bounce_write:
> #ifdef ALIGN_DEBUG
> 	printf("raw_write_blk: O_DIRECT fallback: %p %lu\n", buf,
> 	       (unsigned long) size);
> #endif
> +
> +	/* logical offset may don't aligned with block device block size =
*/
> +	blk =3D location / align;
> +	offset =3D location % align;
> +
> +	if (lseek(data->dev, blk * align, SEEK_SET) !=3D blk * align) {
> +		retval =3D errno ? errno : EXT2_ET_LLSEEK_FAILED;
> +		goto error_out;
> +	}
> +
> 	/*
> 	 * The buffer or size which we're trying to write isn't aligned
> 	 * to the O_DIRECT rules, so we need to do this the hard way...
> 	 */
> -bounce_write:
> 	while (size > 0) {
> -		if (size < channel->block_size) {
> -			actual =3D read(data->dev, data->bounce,
> -				      channel->block_size);
> -			if (actual !=3D channel->block_size) {
> -				if (actual < 0) {
> -					retval =3D errno;
> -					goto error_out;
> -				}
> -				memset((char *) data->bounce + actual, =
0,
> -				       channel->block_size - actual);
> +		int actual_w;
> +
> +		memset((char *) data->bounce, 0, align);
> +		if (offset || (size < align)) {
> +			actual =3D read(data->dev, data->bounce, align);
> +			if (actual < 0) {
> +				retval =3D errno;
> +				goto error_out;
> 			}
> 		}
> 		actual =3D size;
> -		if (size > channel->block_size)
> -			actual =3D channel->block_size;
> -		memcpy(data->bounce, buf, actual);
> -		if (ext2fs_llseek(data->dev, location, SEEK_SET) !=3D =
location) {
> +		if ((actual + offset) > align)
> +			actual =3D align - offset;
> +		if (actual > size)
> +			actual =3D size;
> +		memcpy(((char *)data->bounce) + offset, buf, actual);
> +
> +		if (lseek(data->dev, blk * align, SEEK_SET) !=3D blk * =
align) {
> 			retval =3D errno ? errno : =
EXT2_ET_LLSEEK_FAILED;
> 			goto error_out;
> 		}
> -		actual =3D write(data->dev, data->bounce, =
channel->block_size);
> -		if (actual < 0) {
> +
> +		actual_w =3D write(data->dev, data->bounce, align);
> +		if (actual_w < 0) {
> 			retval =3D errno;
> 			goto error_out;
> 		}
> -		if (actual !=3D channel->block_size)
> -			goto short_write;
> +		if (actual_w !=3D align) {
> +			retval =3D EXT2_ET_SHORT_WRITE;
> +			goto error_out;
> +		}
> 		size -=3D actual;
> 		buf +=3D actual;
> 		location +=3D actual;
> +		blk ++;
> +		offset =3D 0;
> 	}
> 	return 0;
>=20
> --=20
> 2.18.4
>=20

