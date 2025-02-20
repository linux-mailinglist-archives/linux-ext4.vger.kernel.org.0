Return-Path: <linux-ext4+bounces-6512-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54409A3CEF4
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2025 02:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE1DD7A48A1
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2025 01:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228501C9DC6;
	Thu, 20 Feb 2025 01:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="LMj3AjWc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A38F1C3C1C
	for <linux-ext4@vger.kernel.org>; Thu, 20 Feb 2025 01:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740016691; cv=none; b=ZzNAQ57ydTVTIepqVbA03rQuX1R+Yrzq+pKTGRcMzw83pxQ+eh4E82ZkkPzWi5U4kMP1M7xlm70PYFD8q+6vOSUlEmigyRSYN6WgLNjK7SYS8FkNJ8C/aUZCko2u1T2i9wh01s2CSHWRJOoZiybVzV9okU+Y9Nzm5HSM2OV1zXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740016691; c=relaxed/simple;
	bh=T4VbV8R452H4c8sn/sfHDxR/L5M8AG4h6j+RqhjO9ng=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=ApSVfTG/a0lnWZXvRhvNHSeGQUe0E17y6CBFVyonYxawFLdZ1Wx1KYJ290VfDyzoQnGGHr1SLt/qtTKd8TOeFNG3Dw341BOLP4EYg7jQBq3Nc+3vQhhhCBvI/Kqm1eSn9rHzGHNcTKAWEKAcsifnNNJKUbqEzmswxbcCJ6UgZDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=LMj3AjWc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22128b7d587so6382735ad.3
        for <linux-ext4@vger.kernel.org>; Wed, 19 Feb 2025 17:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1740016687; x=1740621487; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=USvqQDkNIqdC675OK3K8CeB4xM5di4JLVBj/3kWuQvQ=;
        b=LMj3AjWcwZa5dKFM6daKhq18DQo6GgwIRLA5R/rhAHOFwtcsTh+Ba1APe/wWLGxxfj
         R6gWOzkBAGW7QvKj5fvEMbyMvG0SKfUEZ8roM8GSlO9j5p8hhMbYKY1c4cCClssMct2r
         djYVWjOVgrSpLT7dkCafgPOqZPgAeLZEgoyuEn5OU83TLgtE316milIEJADpEL+yOwaF
         69SpJyap19TFAfhFsX4MAqZwiYbN13bdfhAgH9YS2ZfoLFMuXgn4jfhhxH0AWpGH5sX7
         axTuuht62HXg9kmPRMlcpKz5F0EaxZAC5R2u2k7WP5o1qBAC3XU7QqxhUAh25aGa7Kcg
         zOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740016687; x=1740621487;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USvqQDkNIqdC675OK3K8CeB4xM5di4JLVBj/3kWuQvQ=;
        b=w6DQzZ47HhSGB5Sz6jcpSQBzafJ81Qm+oyoR504tRexXCcapFUb747GwfoDj5tiVTv
         iaxdF91dI38e4UktbS53VLGeDiv1/voH0OvTfuTQSIwznJkBhbOQ5wYR+yfgXBSFl8gd
         KIgaXR/1SKKtw0a+4HYni25A8KZokevzNYoZiBQ1QIhs22PFYn+rdK4hlHNOWBNLMAhD
         mmtnJfXQQmjHRD00XNhqTCx7SPmZdu6o/ceTorggRS9+QkadXoDnLylgWCmpOu6O6+zw
         vlYYF+/WNMJ5Q0JUA29Yu2no74fUJl2REMAKisP55Fm0Th88hXcEMlMQMjVUuR4XO0x0
         Biyg==
X-Forwarded-Encrypted: i=1; AJvYcCVL+x/g4plsaLlvA1k5gFyUEpxZdYveWIhB9nZjRMHauDLBirduN30PzcferxCO79cYwotlrWLj8MRn@vger.kernel.org
X-Gm-Message-State: AOJu0YyniIj7eAZmqbQUkR7IfhGWLIkyb5cfaatsPl4KRLD67WgKMf5k
	pam5SyBXHHEi0rm/FVzx3q6GZ0RmU9SswpujvMjHOyi1cueLwDw8ea1dO9bGjDhOSxXalmNy70h
	V
X-Gm-Gg: ASbGnct3UrERpsWXXKI+jWCiu//yejAt400P0v8FlVWEjHMD50qytMdzsiwQbC4+pbx
	mhcTAoXrzSuuuveefd41JuhEsvF+a3TRUQiPlSmpMFBjlfoCwmUBFwCbcQxClFdtlIVkP4s7nLx
	HrDVy/5+ujKQ14lWviH4dKj56ttRCF/UTrg7N85oTK2qZ8+OU6tS1CQeCEl3rCzd6x/9SFsovAI
	+koTciLfilsPYhxkrG82sotZCT5MBWHeR7ZPLUh1zDunFb63orlF6p6w7X/JQeBJ+3qL6mgxZCH
	mlx8mUaKHDwAJMdloNjEAHNnsjxiUD963uKy0awKG4rLNEMkcyfwt+12N29pJGey
X-Google-Smtp-Source: AGHT+IF4aCMjGSvZV4KGG8KxRgbPyXcEK3sslQ6oyzuxmVdiquM6qFMo4MmcZ+LOdRh215i3nrWkAw==
X-Received: by 2002:a05:6a21:62c9:b0:1ee:60fc:a1ba with SMTP id adf61e73a8af0-1eed4e3f1f1mr11730466637.3.1740016685968;
        Wed, 19 Feb 2025 17:58:05 -0800 (PST)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73276f20c30sm7062122b3a.21.2025.02.19.17.58.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2025 17:58:04 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <007522B4-E6F6-4DCA-9355-B1FBB1C1A6AF@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_29BEA282-9319-4098-AD69-77C299457FA6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH -v2] ext4: introduce linear search for dentries
Date: Wed, 19 Feb 2025 18:58:00 -0700
In-Reply-To: <87cyfdvcdc.fsf@mailhost.krisman.be>
Cc: Theodore Ts'o <tytso@mit.edu>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 drosen@google.com
To: Gabriel Krisman Bertazi <krisman@suse.de>
References: <20250212164448.111211-1-tytso@mit.edu>
 <20250213201021.464223-1-tytso@mit.edu>
 <9ED1B796-23FE-422A-B6C9-5BEAE4FAA912@dilger.ca>
 <87cyfdvcdc.fsf@mailhost.krisman.be>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_29BEA282-9319-4098-AD69-77C299457FA6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Feb 19, 2025, at 2:43 PM, Gabriel Krisman Bertazi <krisman@suse.de> =
wrote:
>=20
> Andreas Dilger <adilger@dilger.ca> writes:
>=20
>> On Feb 13, 2025, at 1:10 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>>>=20
>>> This patch addresses an issue where some files in case-insensitive
>>> directories become inaccessible due to changes in how the kernel
>>> function, utf8_casefold(), generates case-folded strings from the
>>> commit 5c26d2f1d3f5 ("unicode: Don't special case ignorable code
>>> points").
>>>=20
>>> There are good reasons why this change should be made; it's actually
>>> quite stupid that Unicode seems to think that the characters =E2=9D=A4=
 and =E2=9D=A4=EF=B8=8F
>>> should be casefolded.  Unfortimately because of the backwards
>>> compatibility issue, this commit was reverted in 231825b2e1ff.
>>>=20
>>> This problem is addressed by instituting a brute-force linear =
fallback
>>> if a lookup fails on case-folded directory, which does result in a
>>> performance hit when looking up files affected by the changing how
>>> thekernel treats ignorable Uniode characters, or when attempting to
>>> look up non-existent file names.  So this fallback can be disabled =
by
>>> setting an encoding flag if in the future, the system administrator =
or
>>> the manufacturer of a mobile handset or tablet can be sure that =
there
>>> was no opportunity for a kernel to insert file names with =
incompatible
>>> encodings.
>>=20
>> I don't have the full context here, but falling back to a full =
directory
>> scan for every failed lookup in a casefolded directory would be =
*very*
>> expensive for a large directory.
>=20
> The context is that I made a change in unicode that caused a change in
> the filename hash of case-insensitive dirents, which are calculated =
from
> the casefolded form of the name.  While that change was reverted, =
users
> have created files with the broken kernels and there are reports of
> files inaccessible.
>=20
>> This could be made conditional upon a much narrower set of =
conditions:
>> - if the filename has non-ASCII characters (already uncommon)
>> - if the filename contains characters that may be case folded
>> (normalized?)
>=20
> It could be even simpler, by only doing it to filenames that have
> zero-length characters before normalization.  We can easily check it
> with utf8nlen or utf8ncursor.  I'm very wary of differentiating ASCII
> from other characters if we can avoid it.

Sure, my suggestions are aimed at minimizing the impact of this extra
(and very expensive) fallback mechanism.  If there is a direct way to
determine which filenames were impacted by the earlier bug, and then
do only two lookups (one with the "buggy" casefolded name, one with the
"good" casefolded name) then this would be (at worst) a 2x slowdown for
the lookup, instead of a 1000x slowdown (or whatever, for large =
directories).

Also, since the number of users affected by this bug is relatively small
(only users running kernels >=3D v6.12-rc2-1-g5c26d2f1d3f5 where the =
broken
patch landed and v6.13-rc2-36-g231825b2e1ff when it was reverted), but =
the
workaround by default affects everyone using the casefold feature, it
behooves us to minimize the performance impact of the workaround.

>=20
>> This avoids a huge performance hit for every name lookup in very =
common
>> workloads that do not need it (i.e. most computer-generated filenames =
are
>> still only using ASCII characters).
>=20
> Right.  But this also only affects case-insensitive filesystems, which
> have very specific and controlled applications and hardly thousands of
> files in the same directory.

I think this is a generalization that does not hold true in all cases.

We have been looking at adding casefold support to Lustre, in order to
improve Samba export performance (which also has a "scan all entries"
fallback), and we cannot control how many files are in a single =
directory.

It seems likely that systems have been using casefold directly on ext4
for Samba as well.  If the performance impact of "scan all entries" is
noticeable for Samba, then it would be noticeable for this fallback.

> If we really need it, I'd suggest we don't differentiating ASCII from
> utf8, but only filenames with those sequences.

Even better if the fallback can be limited to the subset of affected =
names.

> IMO, Ted's patch seems fine as a temporary stopgap to recover those
> filesystems.

Sure, but it is enabled by default and affects anyone using the casefold
feature forever into the future, unless the plan is not to land this =
patch
and only deploy it in the specific distros where the broken kernel was =
used?

One option would be to have the kernel re-hash any entries that it finds
with the old filename, so that the directories repair themselves, and =
the
workaround could be removed after some time.  Also, have e2fsck re-hash
the filenames in this case, so that there is a long-term solution after
the kernel workaround is removed.

Cheers, Andreas

>> Also, depending on the size of the directory vs. the number of =
case-folded
>> (normalized?) characters in the filename, it might be faster to do
>> 2^(ambiguous_chars) htree lookups instead of a linear scan of the =
whole dir.
>>=20
>> That could be checked easily whether 2^(ambiguous_chars) < dir =
blocks, since
>> the htree leaf blocks will always be fully scanned anyway once found. =
 That
>> could be a big win if there are only a few remapped characters in a =
filename.
>>=20
>> Cheers, Andreas
>>=20
>>>=20
>>> Fixes: 5c26d2f1d3f5 ("unicode: Don't special case ignorable code =
points")
>>> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>>> Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
>>> ---
>>> v2:
>>>  * Fix compile failure when CONFIG_UNICODE is not enabled
>>>  * Added reviewed-by from Gabriel Krisman
>>>=20
>>> fs/ext4/namei.c    | 14 ++++++++++----
>>> include/linux/fs.h | 10 +++++++++-
>>> 2 files changed, 19 insertions(+), 5 deletions(-)
>>>=20
>>> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
>>> index 536d56d15072..820e7ab7f3a3 100644
>>> --- a/fs/ext4/namei.c
>>> +++ b/fs/ext4/namei.c
>>> @@ -1462,7 +1462,8 @@ static bool ext4_match(struct inode *parent,
>>> 		 * sure cf_name was properly initialized before
>>> 		 * considering the calculated hash.
>>> 		 */
>>> -		if (IS_ENCRYPTED(parent) && fname->cf_name.name &&
>>> +		if (sb_no_casefold_compat_fallback(parent->i_sb) &&
>>> +		    IS_ENCRYPTED(parent) && fname->cf_name.name &&
>>> 		    (fname->hinfo.hash !=3D EXT4_DIRENT_HASH(de) ||
>>> 		     fname->hinfo.minor_hash !=3D =
EXT4_DIRENT_MINOR_HASH(de)))
>>> 			return false;
>>> @@ -1595,10 +1596,15 @@ static struct buffer_head =
*__ext4_find_entry(struct inode *dir,
>>> 		 * return.  Otherwise, fall back to doing a search the
>>> 		 * old fashioned way.
>>> 		 */
>>> -		if (!IS_ERR(ret) || PTR_ERR(ret) !=3D ERR_BAD_DX_DIR)
>>> +		if (IS_ERR(ret) && PTR_ERR(ret) =3D=3D ERR_BAD_DX_DIR)
>>> +			dxtrace(printk(KERN_DEBUG "ext4_find_entry: dx =
failed, "
>>> +				       "falling back\n"));
>>> +		else if (!sb_no_casefold_compat_fallback(dir->i_sb) &&
>>> +			 *res_dir =3D=3D NULL && IS_CASEFOLDED(dir))
>>> +			dxtrace(printk(KERN_DEBUG "ext4_find_entry: =
casefold "
>>> +				       "failed, falling back\n"));
>>> +		else
>>> 			goto cleanup_and_exit;
>>> -		dxtrace(printk(KERN_DEBUG "ext4_find_entry: dx failed, "
>>> -			       "falling back\n"));
>>> 		ret =3D NULL;
>>> 	}
>>> 	nblocks =3D dir->i_size >> EXT4_BLOCK_SIZE_BITS(sb);
>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>> index 2c3b2f8a621f..aa4ec39202c3 100644
>>> --- a/include/linux/fs.h
>>> +++ b/include/linux/fs.h
>>> @@ -1258,11 +1258,19 @@ extern int send_sigurg(struct file *file);
>>> #define SB_NOUSER       BIT(31)
>>>=20
>>> /* These flags relate to encoding and casefolding */
>>> -#define SB_ENC_STRICT_MODE_FL	(1 << 0)
>>> +#define SB_ENC_STRICT_MODE_FL		(1 << 0)
>>> +#define SB_ENC_NO_COMPAT_FALLBACK_FL	(1 << 1)
>>>=20
>>> #define sb_has_strict_encoding(sb) \
>>> 	(sb->s_encoding_flags & SB_ENC_STRICT_MODE_FL)
>>>=20
>>> +#if IS_ENABLED(CONFIG_UNICODE)
>>> +#define sb_no_casefold_compat_fallback(sb) \
>>> +	(sb->s_encoding_flags & SB_ENC_NO_COMPAT_FALLBACK_FL)
>>> +#else
>>> +#define sb_no_casefold_compat_fallback(sb) (1)
>>> +#endif
>>> +
>>> /*
>>> *	Umount options
>>> */
>>> --
>>> 2.45.2
>>>=20
>>>=20
>>=20
>>=20
>> Cheers, Andreas
>>=20
>>=20
>>=20
>>=20
>>=20
>=20
> --
> Gabriel Krisman Bertazi


Cheers, Andreas






--Apple-Mail=_29BEA282-9319-4098-AD69-77C299457FA6
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAme2jCgACgkQcqXauRfM
H+C/4w/+JlefQjODfg+Nm6M/Rirq8T10s9QDOSQQch6T2XBL2YfbuH11z/DmxT1c
5PiYoSTxLwBfrLR0RqH8jYIm0oxTSV6VF3cUstI6ZMRu2TPQlpXXHui/rp0AtJ1X
Pt28PuXJYVamNAypnQCuxvqx6qafcGrMW9xVsufQoLr7Tdj7g49XMVZK9SMl8LeJ
5KyU31SIAP3/th2L8ya2E6uQEvE4fzsEUV7pCmEmDRDp6kIBA+Iw0Lw+bxzjva1p
VgCHhK83f5fsCkZQxKFQZD7sTOrOKBnZj++1Ut6Q7UNgw3mYmcosBMvq6wdznATN
8/ynXRDFDAudf4Upl03stwRD6vc/HziQRvOAND5D9LDl17UhuL0BX2YgijHDkP4i
lr6Hix1EXxUeMfYSQf4Wib8j8F1LpGnzcHlDgZ752YAaKw1CRN+blut5OrLrtrcb
Hsllfc3bzu8G2ROOuS1kkZLw1kjLXInL/B0CT4cV7G7M32W2K0wzIl20u4AGrYtN
NWRn5kYDr4ZGxprqbUeVNr0EhfWXs0z2eOkCTSHQnO6htoQr2l2/CtbmdP3gKBYI
LSxT5ug6rz3/zYSYcBvG0Fse174kgctN86VKWETHMEi54fUjYu6Iopwft8Xt1LXj
Jx+RlAP8Ci5z2FDLMb/td7GNWFjcRC9sSmLKKXTKRUHv4wFWCRM=
=FDVD
-----END PGP SIGNATURE-----

--Apple-Mail=_29BEA282-9319-4098-AD69-77C299457FA6--

