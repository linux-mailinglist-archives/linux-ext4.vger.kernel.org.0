Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D152D6C66
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Dec 2020 01:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbgLKANM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Dec 2020 19:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgLKAMx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Dec 2020 19:12:53 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF699C0613CF
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 16:12:12 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id w5so5104819pgj.3
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 16:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=WYDJZVbThdXQfrBzR+eMOGuuygTLyl3ki+j/4nHYbFo=;
        b=eobUz9Nc2Z5I6Xtg26lvDfhkDY6xK1B2lw5qBzcMuSCB8NbSWLs0+df004OaKqZcWt
         SXHSsI8hzMGO2lEBp3U9Ujv3u36Z5SZvXlRaW0eOsWMidx+XbWx2YPInESQ/vycy7mqu
         v0+jRrM1dGmyCju1o5l1U8obsdhAgcEQBmEAgAoO0TmoN5emYBjJCItewXShyRdNl4Sj
         LIS7wxY5+3PnckZVodb0zBAE0lUGnbFwotcpzUjFuysZeV+IOx+fMawwxxlUjn3soS00
         xeSC/l4t9Wbre3VvX5rDIeKEXD109JkJlUwbjmqkz0SEa9fr+h+WGZln0yDA0duLcJq+
         Jkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=WYDJZVbThdXQfrBzR+eMOGuuygTLyl3ki+j/4nHYbFo=;
        b=KT3YSiwIgloaRnbYynQ8WrFXtyDsXE5kO8WZMm4dwT0los4ZgNdObz3jfYlRIn6DOq
         aNNN79rlpax+jZZPL6ZGpeTYlcy3rj4uRSzKe7Mw2WfqiRL80J+7rfGPiDvAlslDVEbk
         Yl+iAXtDPhMbTcuDwXe8Ti3v/TyBziZa2vNgUPAWN+OumT+pnzTkVLUuOdh3ByEIPv+R
         QCcm3MzWgYs/Hsqe7HUv85zHhYsDVRdc8ycYKaCcSLYNahbk3FmicxON1xLJvslQBCX/
         2NfN2sKMyGAbBaKOUAbnwmxAylN7tlt0N2dy2DpZ4q3A7Ba6OKhV0vl6bcaj/vl3upL4
         +2QQ==
X-Gm-Message-State: AOAM531jcFuJ0iKhlOdM6u6Kp0C0gsMwR+DBkV/i/c/VlbsIuqP9bZkX
        B75soCfwR4VukNFOnYwm4HNpYw==
X-Google-Smtp-Source: ABdhPJzb08Tz/bVOY7kwEI3Qp9dyj28Q8y9dMY2mMqRfsx3CAlbw6gIbXCmyK2o4pYwIugKZ3yv7ww==
X-Received: by 2002:a62:1716:0:b029:19d:b78b:ef02 with SMTP id 22-20020a6217160000b029019db78bef02mr8926187pfx.11.1607645532329;
        Thu, 10 Dec 2020 16:12:12 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id mr7sm7222379pjb.31.2020.12.10.16.12.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 16:12:11 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <4F169AE8-BFD2-4EE3-8741-7C75B8764583@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_FB2FB66E-266E-4B42-9615-DD34F3568521";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH RFC 4/5] ext2fs: parallel bitmap loading
Date:   Thu, 10 Dec 2020 17:12:09 -0700
In-Reply-To: <20201205045856.895342-5-tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Saranya Muruganandam <saranyamohan@google.com>,
        Wang Shilong <wshilong@ddn.com>
To:     Theodore Ts'o <tytso@mit.edu>
References: <20201205045856.895342-1-tytso@mit.edu>
 <20201205045856.895342-5-tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_FB2FB66E-266E-4B42-9615-DD34F3568521
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Dec 4, 2020, at 9:58 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> From: Wang Shilong <wshilong@ddn.com>
>=20
> In our benchmarking for PiB size filesystem, pass5 takes
> 10446s to finish and 99.5% of time takes on reading bitmaps.
>=20
> It makes sense to reading bitmaps using multiple threads,
> a quickly benchmark show 10446s to 626s with 64 threads.
>=20
> [ This has all of many bug fixes for rw_bitmaps.c from the original
>  luster patch set collapsed into a single commit.   In addition it has
>  the new ext2fs_rw_bitmaps() api proposed by Ted. ]
>=20
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

The patch looks generally good.  Unfortunately, I don't have a large
system available to verify the performance at this time, but it looks
close enough to the original code that I don't think there is much
risk of breakage.

One potential cross-platform build issue below, and some cosmetic
suggestions, but you could add:

Reviewed-by: Andreas Dilger <adilger@whamcloud.com>

> @@ -329,12 +369,20 @@ static errcode_t read_bitmaps(ext2_filsys fs, =
int do_inode, int do_block)
> 				}
> 				if (!bitmap_tail_verify((unsigned char =
*) block_bitmap,
> 							block_nbytes, =
fs->blocksize - 1))
> -					tail_flags |=3D =
EXT2_FLAG_BBITMAP_TAIL_PROBLEM;
> +					*tail_flags |=3D =
EXT2_FLAG_BBITMAP_TAIL_PROBLEM;
> 			} else
> 				memset(block_bitmap, 0, block_nbytes);
> 			cnt =3D block_nbytes << 3;
> +#ifdef HAVE_PTHREAD
> +			if (mutex)
> +				pthread_mutex_lock(mutex);
> +#endif
> 			retval =3D =
ext2fs_set_block_bitmap_range2(fs->block_map,
> 					       blk_itr, cnt, =
block_bitmap);
> +#ifdef HAVE_PTHREAD
> +			if (mutex)
> +				pthread_mutex_unlock(mutex);
> +#endif

(style) It wouldn't be terrible to have wrappers around these functions
instead of inline #ifdef in the few places they are used, like:

#ifdef HAVE_PTHREAD
static void unix_pthread_mutex_lock(pthread_mutex_t *mutex)
{
	if (mutex)
		pthread_mutex_lock(mutex);
}
static void unix_pthread_mutex_unlock(pthread_mutex_t *mutex)
{
	if (mutex)
		pthread_mutex_unlock(mutex);
}
#else
#define unix_pthread_mutex_lock(mutex) do {} while (0)
#define unix_pthread_mutex_unlock(mutex) do {} while (0)
#endif


> @@ -365,63 +413,229 @@ static errcode_t read_bitmaps(ext2_filsys fs, =
int do_inode,					memset(inode_bitmap, 0, =
inode_nbytes);
> 			cnt =3D inode_nbytes << 3;
> +			if (mutex)
> +				pthread_mutex_lock(mutex);
> 			retval =3D =
ext2fs_set_inode_bitmap_range2(fs->inode_map,
> 					       ino_itr, cnt, =
inode_bitmap);
> +			if (mutex)
> +				pthread_mutex_unlock(mutex);

(minor) These two pthread calls need #ifdef HAVE_PTHREAD or use =
wrappers.

> +errcode_t ext2fs_rw_bitmaps(ext2_filsys fs, int flags, int =
num_threads)
> +{
> +#ifdef HAVE_PTHREAD
> +	if (((fs->io->flags & CHANNEL_FLAGS_THREADS) =3D=3D 0) ||
> +	    (num_threads =3D=3D 1) || (fs->flags & =
EXT2_FLAG_IMAGE_FILE))
> +		goto fallback;
> +
> +	if (num_threads < 0) {
> +#if defined(HAVE_SYSCONF) && defined(_SC_NPROCESSORS_CONF)
> +		num_threads =3D sysconf(_SC_NPROCESSORS_CONF);
> +#else
> +		/*
> +		 * Guess for now; eventually we should probably define
> +		 * ext2fs_get_num_cpus() and teach it how to get this =
info on
> +		 * MacOS, FreeBSD, etc.
> +		 * ref: https://stackoverflow.com/questions/150355
> +		 */
> +		num_threads =3D 4;
> +#endif

(style) this #endif wouldn't hurt to have a /* HAVE_SYSCONF */ comment,
but currently isn't too far from the #ifdef though it looks like it may
become further away and harder to track in the future.

> +		if (num_threads <=3D 1)
> +			goto fallback;
> +	}

[snip]

> +	/* XXX should save and restore cache setting */
> +	io_channel_set_options(fs->io, "cache=3Don");
> 	return retval;
> +fallback:
> +#endif

(style) this would definitely benefit from a /* HAVE_PTHREAD */ comment,
since it is so far from the original #ifdef.

Cheers, Andreas






--Apple-Mail=_FB2FB66E-266E-4B42-9615-DD34F3568521
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/SuVkACgkQcqXauRfM
H+BnkRAArPq+YRXBUn6SNbFhNAf3abdbzT6AOednBotzcSwKK6qdqUA12lXS0BH8
AbN0Nee72UaHJ33LVj9QOtNBtK782LanWm4dpm3x3zoWg63QhcFA8VxZ82yObEGC
PQDa4/v46qlnV7eXfKc+QhZu3Xc5g9iCSgkIgFKP5Xd1xqZ+CYsAXLd2Mojx8d+V
x/HTZJSDK4H2IMZQy5W631W2pAZKONcVVbBbGC2C97tVRcFLPFdnvuGmrvhBkh8p
z2XIcc6ZK9Vn9gk/FstBp4++zN+kvd2Aljk682DI3RgsugfVdkPKGOjzGPjVIYe8
Z2POrP+22HrOL7d0AY+IIkVIQic322IOcTmsLJcsrknkQHtE3NNfoyi3X9dfpxWE
auLK4AtYjB+YHAdXBLiojnWF+UPlgVR/oLSpWG35uNza6e3jChzFhR17tyyCH5LP
aWby5S5rQLNbGuLv9ynclk6iBHulgGeidREgaYOxu1AAx99eaQxjzUrSkIqu5arF
KzBdJwUuw5K2kri3EzIi6RumkBqvDAV5K1resrD+RakVWGrEFdIPc29inRpTP1Ks
izpgxDno51elXEOGHZuMqclMJm00TWGufKmzmw3aStg4rWFdDpk/28pb/nPHpwW4
HErUxGE8DVn0zyUIqO1GTzRJGK8xuojH5c08n9KSMB+zzog08SU=
=VUFx
-----END PGP SIGNATURE-----

--Apple-Mail=_FB2FB66E-266E-4B42-9615-DD34F3568521--
