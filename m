Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8582D184B
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Dec 2020 19:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgLGSQP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Dec 2020 13:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgLGSQP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Dec 2020 13:16:15 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4ACC0617B0
        for <linux-ext4@vger.kernel.org>; Mon,  7 Dec 2020 10:15:35 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id h7so300638pjk.1
        for <linux-ext4@vger.kernel.org>; Mon, 07 Dec 2020 10:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=I22laTonniOYm56AJDD4l/ep2m8AR6HNj3JZm2b0dtA=;
        b=fo3+I0Ro/4hrTCbQg0lQEiIbe1j10JMzRj77FKLeM31h/bD3fH2rbF6D6iRK9WTocG
         aWScgn8J9wqyJBbog9YQ5dbv4YBWiUkYEZBfWlLQoOr1igwLFvHPVoY/MwFTp2eor/dm
         yBBoTbMLhN9SUN5V7If1lCqAuHtOzmS7UeYtozTffsiPLe5n0PSb5MSsWkibjVFQUD49
         SegFXFsmPmebDrjfgj+xx0TdERbohKzsqK80zA+HeF0/0WQB74LWioCN/DwD6UnNJg/U
         c534J7G3xvS5DrZTKsUX9Es2VBecZrYCmhuMjyOTIa185t0Xm5j7BqJzxO3sXi+WoBZm
         2+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=I22laTonniOYm56AJDD4l/ep2m8AR6HNj3JZm2b0dtA=;
        b=WKbottxm53JQt0v2wA/BdFduae7r6KgLiHPOu6sxDY5ZIulnYLEB8NpvDKknLswb0a
         8aHvY6YLOmPzgkl6OcIDgvcU2R1At3G+dS28KPLM4mYWW5vkMpz0LKwwgf7RKcU0rtUf
         EYbDvM7S2bmLJdzkfNqLakpnD29rrovzQanAWgSCOKz5OCqu9bMreYKYhgllpE7FWS5I
         xSYI/hZUg6zZ4sl8A0IukWX6qjnnGkprv+sVlgGnU/QyznFNR8oXwO/BdIvZNE9GZAMY
         v6z1B6K6aKXZtCgLW28A0QCkYvbGHkLDuCFCwedZSKC3cH+8pVS7V/GqZu+FiFfe2MxF
         jbEA==
X-Gm-Message-State: AOAM5315aulXH53BZexbiFOGkjU4dYLdnrWh4/hDxIcvuRnQ6QcpRjqw
        Qby0L3WSs3/M9/O/MYLCcdRvNA==
X-Google-Smtp-Source: ABdhPJxPzRnsrg8zUuO30Ewle7FrpII0fAwILpZPwPlTPWcOGInUHrteR9Sq+ix5/kIkD8bRtCE7hg==
X-Received: by 2002:a17:90a:eac5:: with SMTP id ev5mr48471pjb.65.1607364934460;
        Mon, 07 Dec 2020 10:15:34 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id fs12sm18342pjb.49.2020.12.07.10.15.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 10:15:33 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <2EFCA6FE-60CC-47BA-A403-592122D5FBCB@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_FCF84F7C-E5F6-4437-9128-B519BF773F79";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH RFC 2/5] libext2fs: add threading support to the I/O
 manager abstraction
Date:   Mon, 7 Dec 2020 11:15:30 -0700
In-Reply-To: <20201205045856.895342-3-tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Saranya Muruganandam <saranyamohan@google.com>,
        Wang Shilong <wshilong@ddn.com>
To:     Theodore Ts'o <tytso@mit.edu>
References: <20201205045856.895342-1-tytso@mit.edu>
 <20201205045856.895342-3-tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_FCF84F7C-E5F6-4437-9128-B519BF773F79
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Dec 4, 2020, at 9:58 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> Add initial implementation support for the unix_io manager.
> Applications which want to use threading should pass in
> IO_FLAG_THREADS when opening the channel.  Channels which support
> threading (which as of this commit is unix_io and test_io if the
> backing io_manager supports threading) will set the
> CHANNEL_FLAGS_THREADS bit in io->flags.  Library code or applications
> can test if threading is enabled by checking this flag.
>=20
> Applications using libext2fs can pass in EXT2_FLAG_THREADS to
> ext2fs_open() or ext2fs_open2() to request threading support.
>=20
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>=20
> diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
> index 628e60c39..9385487d9 100644
> --- a/lib/ext2fs/unix_io.c
> +++ b/lib/ext2fs/unix_io.c
> @@ -232,8 +287,10 @@ static errcode_t raw_read_blk(io_channel channel,
> bounce_read:
> 	while (size > 0) {
> +		mutex_lock(data, BOUNCE_MTX);
> 		actual =3D read(data->dev, data->bounce, =
channel->block_size);
> 		if (actual !=3D channel->block_size) {
> +			mutex_unlock(data, BOUNCE_MTX);
> 			actual =3D really_read;
> 			buf -=3D really_read;
> 			size +=3D really_read;
> @@ -246,6 +303,7 @@ bounce_read:
> 		really_read +=3D actual;
> 		size -=3D actual;
> 		buf +=3D actual;
> +		mutex_unlock(data, BOUNCE_MTX);
> 	}
> 	return 0;

Do you know how often we get into the "bounce_read" IO path?  It seems =
like
locking around the read would kill parallelism, but this code path also
looks like a fallback, but maybe 100% used for blocksize !=3D PAGE_SIZE?

> @@ -341,11 +401,13 @@ static errcode_t raw_write_blk(io_channel =
channel,
> 	 */
> bounce_write:
> 	while (size > 0) {
> +		mutex_lock(data, BOUNCE_MTX);
> 		if (size < channel->block_size) {
> 			actual =3D read(data->dev, data->bounce,
> 				      channel->block_size);
> 			if (actual !=3D channel->block_size) {
> 				if (actual < 0) {
> +					mutex_unlock(data, BOUNCE_MTX);
> 					retval =3D errno;
> 					goto error_out;
> 				}
> @@ -362,6 +424,7 @@ bounce_write:
> 			goto error_out;
> 		}
> 		actual =3D write(data->dev, data->bounce, =
channel->block_size);
> +		mutex_unlock(data, BOUNCE_MTX);
> 		if (actual < 0) {
> 			retval =3D errno;
> 			goto error_out;

Ditto.

> @@ -703,6 +773,25 @@ static errcode_t unix_open_channel(const char =
*name, int fd,
> 			setrlimit(RLIMIT_FSIZE, &rlim);
> 		}
> 	}
> +#endif
> +#ifdef HAVE_PTHREAD
> +	if (flags & IO_FLAG_THREADS) {
> +		io->flags |=3D CHANNEL_FLAGS_THREADS;
> +		retval =3D pthread_mutex_init(&data->cache_mutex, NULL);
> +		if (retval)
> +			goto cleanup;
> +		retval =3D pthread_mutex_init(&data->bounce_mutex, =
NULL);
> +		if (retval) {
> +			pthread_mutex_destroy(&data->cache_mutex);
> +			goto cleanup;
> +		}
> +		retval =3D pthread_mutex_init(&data->stats_mutex, NULL);
> +		if (retval) {
> +			pthread_mutex_destroy(&data->cache_mutex);
> +			pthread_mutex_destroy(&data->bounce_mutex);
> +			goto cleanup;
> +		}
> +	}
> #endif

At one point you talked about using dlopen() or similar to link in the
pthread library only if it is actually needed?  Or is the linkage of
the pthread library avoided by these functions not being called unless
IO_FLAG_THREADS is set?

Cheers, Andreas






--Apple-Mail=_FCF84F7C-E5F6-4437-9128-B519BF773F79
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/OcUIACgkQcqXauRfM
H+C3Rg//TkCu3KUHGX8dPFy4ehyYDoHRlCpf8hPd8Z8Xoj41gdUp22FXVN58PRUZ
rBBMGw6kulqJTv/ZVT08zjoIgs4TNrlrdma8CNAj6ZGkHT1yUOV9EtTOJcCtl0fg
otR3ObTzfcELTwbgN33WrogrVTvIEFmN4nmK6tn9LTNf+ZhjK/2dRMSVQhmSHqa1
MJ/im8z4ROQ4Vd1W72QAV11+kphUNvXYTEjzLkxPw7xZ6ajp6IO+3Ef4nrw63ztV
1j6tEUOom+RuewNP1ol8peI6uOjQmsqDNCb9n1kKgTwp+sjpZhAbuU5M8oLG+Mji
oda6F5FVtRxkQG1GwNInc3jWPLZ902vE/Aj6ASs8nOlW3SDiQnPp7j4cw5eczR7y
1NmSh9EO5OQdgFCc9b4BSsmhC4WC8XBIOelwvH6YqVhX5Op3jlSLsgQ71lSGaTbi
wcOcsYLNcdUELxokKTsBQAcDFU1vPUkORdcY5X9aN71MSQP+fzTBiTo6j6FE+PTe
wkTVNrG5ofA8vTXGlLqZIW8Ii13AXXawKXORVLPRNWJWnumm1EpFCrAM74CYlwDZ
0OfO9UuIvXKDcn3Hcvn7aryWVZ1RwzAo3RupxnZ9WPlN2bm1JCxsnxTfGOhRZ3I1
i63JM41fqTTM7x9o55BMCdUwpCAQ3ZbtOB1d7Pmv7oyyAp+TbS0=
=y5I3
-----END PGP SIGNATURE-----

--Apple-Mail=_FCF84F7C-E5F6-4437-9128-B519BF773F79--
