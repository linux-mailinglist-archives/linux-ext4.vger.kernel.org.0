Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4646A196A22
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Mar 2020 01:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgC2ABM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Mar 2020 20:01:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45000 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgC2ABM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 Mar 2020 20:01:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so5093749plr.11
        for <linux-ext4@vger.kernel.org>; Sat, 28 Mar 2020 17:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=mWXtXtL502HJHyzW4MhJ9r6dl2Z9mR2Bq5fN8vK9W3U=;
        b=kfSOQZSecpiBSCJJgPUWZqOp0gROvwnXMoDTYpb2coCgzIzHFcwXGeYBc5XAKmMsFI
         ix6y3SzQm4koMYxJZ0rN3MJdKrdqZfCGPjpn/n2hzjURf+qmi8tgDCjyopBQYlscQ9JH
         NaBGLPBF5yuRHCVI07wViygeb/B86mLCxaQ0J6q24d84wj8slv6x3M8W/Wg3hdZ7TxW3
         uEgynz+O/vWF5m0N73nV3eJlcVf+RCjHD/1OFuZ78/BO/GbQ9vGxqCGksDiKNKuM9tg3
         lKUZprlDLDwT5DKjjOn8ZxT4txeebSMQn8p2R5aq4Wuex2w3qQx2sGGo7ltjnkYi5cKp
         vA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=mWXtXtL502HJHyzW4MhJ9r6dl2Z9mR2Bq5fN8vK9W3U=;
        b=UnvTMoRRNWP0Jyr0kHQAyw8KjLtoS2QDn4NQGqq4KAQLrX9LiIVfT6mQdlIX7IK779
         tYKptpMRhQoYG/Agu4q9zSWh/BnjjysMPDWthrFSCFCq4/7BSfhV/BO2vtgYu5P+dsgh
         +CwV8zMokoSydOq3VyRVZh0sXXMjIsMo1xS+Kwsk/kVk9QTzt5f6WsieJzlHAsjsP9iz
         0syNxx9DFJUaZdmoJqwAJmxXOGRKlogl30XkgZJBpFJk+Us7UIu4jKRv1nWOnUZgJCcx
         K75OJxwT1Z+Jga5h+zQbGfurGaLb1i3YLFN7VOeJrp3FE/rMRA+1E6bjX2dz7YkHG5K0
         TM1g==
X-Gm-Message-State: ANhLgQ3CJEf5B/9F1rLdWck1/KfE+Z1wQMWMlAuU9v6U0hNZNqSJXFO/
        ZcIS23dkBT3Vh5VvYYmT4wJODg==
X-Google-Smtp-Source: ADFU+vvb9k69zRiXVVXE5zmBEDY60uyPOW0ryyBjQYG7afbpxqUj846sX5p/uHbrHdK1vJHHl7eADg==
X-Received: by 2002:a17:90a:1784:: with SMTP id q4mr7183910pja.174.1585440069310;
        Sat, 28 Mar 2020 17:01:09 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id 189sm6597898pgh.58.2020.03.28.17.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2020 17:01:08 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <C2D84F9E-374E-4B3C-8E2E-30A7CD5A0A0C@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_4A375A78-71CC-44FF-B87E-660AABFACABB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/2] ext4: shrink directories on dentry delete
Date:   Sat, 28 Mar 2020 18:01:05 -0600
In-Reply-To: <20200325093728.204211-2-harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20200325093728.204211-1-harshadshirwadkar@gmail.com>
 <20200325093728.204211-2-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_4A375A78-71CC-44FF-B87E-660AABFACABB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 25, 2020, at 3:37 AM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> This patch adds shrinking support for htree based directories. The
> high level algorithm is as follows:
>=20
> * If after dentry removal the dirent block (let's call it B) becomes
>  empty, then remove its references in its dx parent.
> * Swap its contents with that of the last block (L) in directory.
> * Update L's parents to point to B instead.
> * Remove L
> * Repeat this for all the ancestors of B.
>=20
> We add variants of dx_probe that allow us perform reverse lookups from
> a logical block to its dx parents.
>=20
> Ran kvm-xfstests smoke and verified that no new failures are
> introduced. Ran shrinking for directories with following number of
> files and then deleted files one by one:
> * 1000 (size before deletion 36K, after deletion 4K)
> * 10000 (size before deletion 196K, after deletion 4K)
> * 100000 (size before deletion 2.1M, after deletion 4K)
> * 200000 (size before deletion 4.2M, after deletion 4K)
>=20
> In all cases directory shrunk significantly. We fallback to linear
> directories if the directory becomes empty.
>=20
> But note that most of the shrinking happens during last 1-2% deletions
> in an average case. Therefore, the next step here is to merge dx nodes
> when possible. That can be achieved by storing the fullness index in
> htree nodes. But that's an on-disk format change. We can instead build
> on tooling added by this patch to perform reverse lookup on a dx
> node and then reading adjacent nodes to check their fullness.
>=20
> This patch supersedes the other directory shrinking patch sent in Aug
> 2019 ("ext4: attempt to shrink directory on dentry removal").
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
> fs/ext4/ext4_jbd2.h |   7 +
> fs/ext4/namei.c     | 355 ++++++++++++++++++++++++++++++++++++++++++--
> 2 files changed, 353 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index d567b9589875..b78c6f9a6eba 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
>=20
> +/*
> + * dx_probe with relaxed checks. This function is used in the =
directory
> + * shrinking code since we can run into intermediate states where we =
have
> + * internal dx nodes with count =3D 0.
> + */
> +static inline struct dx_frame *
> +dx_probe_relaxed(struct ext4_filename *fname, struct inode *dir,
> +		struct dx_hash_info *hinfo, struct dx_frame *frame_in)
> +{
> +	return __dx_probe(fname, dir, hinfo, frame_in, 0, false);
> +}
> +
> +/*
> + * Perform only a parttial dx_probe until we find block end_lblk.

(typo) "partial"

> +static inline struct dx_frame *
> +dx_probe_partial(struct ext4_filename *fname, struct inode *dir,
> +		 struct dx_hash_info *hinfo, struct dx_frame *frame_in,
> +		 ext4_lblk_t end_lblk)
> +{
> +	return __dx_probe(fname, dir, hinfo, frame_in, end_lblk, false);
> +}
> +
[snip]
> +/*
> + * This function tries to remove the entry of a dirent block (which =
was just
> + * emptied by the caller) from the dx frame. It does so by reducing =
the count by
> + * 1 and left shifting all the entries after the deleted entry.
> + */
> +int
> +ext4_remove_dx_entry(handle_t *handle, struct inode *dir,
> +		     struct dx_frame *dx_frame)
> +{
> +	err =3D ext4_journal_get_write_access(handle, dx_frame->bh);
> +	if (err) {
> +		ext4_std_error(dir->i_sb, err);
> +		return -EINVAL;
> +	}
> +
> +	for (; i < count - 1; i++)
> +		entries[i] =3D entries[i + 1];

It would be more efficient to do this with "memmove()" rather than =
copying
each entry separately.

> +	/*
> +	 * If i was 0 when we began above loop, we would have =
overwritten count
> +	 * and limit values since those values live in dx_entry->hash of =
the
> +	 * first entry. We need to update count but we should set limit =
as well.
> +	 */
> +	dx_set_count(entries, count - 1);
> +	dx_set_limit(entries, limit);

How hard is it to avoid clobbering these fields in the first place?
I'm just thinking that "clobber + fixup" is subject to race conditions
at various times in the past, and may become an issue in the future
(e.g. with parallel directory operations).

> static inline bool is_empty_dirent_block(struct inode *dir,
> +					 struct buffer_head *bh)
> +{

This should be combined with ext4_empty_dir() to avoid code duplication.

> +	struct ext4_dir_entry_2 *de =3D (struct ext4_dir_entry_2 =
*)bh->b_data;
> +	int	csum_size =3D 0;
> +
> +	if (ext4_has_metadata_csum(dir->i_sb) && is_dx(dir))
> +		csum_size =3D sizeof(struct ext4_dir_entry_tail);
> +
> +	return ext4_rec_len_from_disk(de->rec_len, =
dir->i_sb->s_blocksize) =3D=3D
> +			dir->i_sb->s_blocksize - csum_size && de->inode =
=3D=3D 0;
> +}

This looks like a low cost way to determine the leaf block is empty,
but checking this for every unlink likely has a non-zero cost.

> @@ -2530,6 +2864,9 @@ static int ext4_delete_entry(handle_t *handle,
> 	if (unlikely(err))
> 		goto out;
>=20
> +	if (is_dx(dir))
> +		ext4_try_dir_shrink(handle, dir, lblk, bh);
> +
> 	return 0;

It would be useful to run a comparison benchmark between the patched =
ext4
and unpatched when deleting a large number of entries that checks both =
CPU
usage and performance.  That will give us an idea of how much this costs
to be checked for every entry.

Also, rather than calling ext4_try_dir_shrink() and =
is_empty_dirent_block()
for every entry, couldn't this be returned from =
ext4_generic_delete_entry(),
since it has that information already.

Cheers, Andreas






--Apple-Mail=_4A375A78-71CC-44FF-B87E-660AABFACABB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5/5UEACgkQcqXauRfM
H+CPcRAAs5paI4YWetY8z5M7c7JvjEkvlpAv5A9GVmzVIwUZ6NXnhyjGbC1g24mt
sURpZucW2bUszfmjNZicR4dsMmj/iKfkxY5euh3NBTv1tvL7rV1CLmKMPoIKE7So
3LsHzqzQZERQvwc+X5PcVwSP6U2DS0HqMqKxO4bbUnJIsS2ePuypUpyIBRyZn42J
g82YY36/yrJbZ95gTGqNa9JJz4OFrycglqkg7+fMjXHZNEy5p7K8uDvBiv/9eaaO
UiA7JufKf2xFwf+rEPEyPHunCGk0pbg3wH7tA8D1QHea2Pign9TTf3EFPMY0J89T
cL4nnsKmfTw4mbChTOFWhepAuu9sJ8lQ2cHxOuWyW6EdbO2ExV8P8TkmbrbzknYl
0t3CVzNUZ7q5Wk8GfpEmLA/ZrAq5tJPXhxhV6H4thyjbASh+42HEYb0xcnoNr1iJ
rCcJfidw5F4WG0N2p+965ADbjchT+bC2IbABiM+2VMeSRyhyutFbKEIWPwYfkJgj
3gAEcZjgM+0Y6rAMdm13Plone1cHX3NH/f161tLYR8Lk/FOAjGJhrsqhivOpcjas
3CHttv/0eBkbHalRWL5BScqDsLusA4Pmd6ER5K9itQIxN2XzJ5TXkxekBT312LgN
pM739MlP4g42ywQn9DQsSTrDoxookDknCblF5YotZWOsB7vePMo=
=KC7q
-----END PGP SIGNATURE-----

--Apple-Mail=_4A375A78-71CC-44FF-B87E-660AABFACABB--
