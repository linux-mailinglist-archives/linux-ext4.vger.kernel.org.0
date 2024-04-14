Return-Path: <linux-ext4+bounces-2079-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A69B8A3FDC
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Apr 2024 03:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0B51C20AD1
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Apr 2024 01:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E4917547;
	Sun, 14 Apr 2024 01:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="t3cl+miR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F3F125C9
	for <linux-ext4@vger.kernel.org>; Sun, 14 Apr 2024 01:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713059171; cv=none; b=Wof7yApL25HtwiROF9Q+Px1+GGhE5HgZoLIKxnA1gw/E1CEDGNY5hH+5wGpborEi4Eth8m7+AMo+cJs41Ar7UlITJj9Tj45up5KZY7SosgSRG52I8/bh2dvyHl15wZRCfE63e8++kcBBZHkDRRTnKDJuW2cGRhzVjD2+yeu7YoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713059171; c=relaxed/simple;
	bh=+8tdVAHdyRe586JIf5zkE3LSCRnS6emafZYVjF4wESM=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=ch2iLXB1cwWBLKMiGFQ1PUTUmd3QwQcc+lPsWAdoMxGpF5Cc25YQiauDYc21a/bapioKg1RUzwBsRewAergZXee84eT32RmQ40OJlPmeysV2IOdi1GkWLRWnz2FcFdFOe+DyMZqrzZmSzrwfzA3B+xTyv3C/2BqbyWBaXBqVKVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=t3cl+miR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e5715a9ebdso16631545ad.2
        for <linux-ext4@vger.kernel.org>; Sat, 13 Apr 2024 18:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1713059166; x=1713663966; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jK3qiz2r/OxwhMERN3JhjvI7Srg7jJofsmQrWbh37ew=;
        b=t3cl+miRqa1B3JrtNs3Y4JNNFlrr0W6fj4jtoyOHJhaAzoLDz1MoKhOCCuRWM45aP8
         eC6XQOwnrZ1mtF4hcbhfoLm7fNva3XKJc0Ke03OvD26psK2uyb1XjJfvTu98sxA6k0DP
         EGVBAmocBL9NCO8/72kpI6UdXhUJTGNFERIySY6WFuZVhdStp7bSg1l4Mqls5RxLc2Q3
         N6KFrmqK1OS8yH5cSWc9yr5hUhh7pdGiTRWotWFEHqC9chMoOAxT8sNe9UajvkoMeXnH
         csjyYonTNDD7B23KJxtvLMyFgJ1ySTovYRYHcCDPIL5DVAB7KMzA3RSD2g9TT/huCNkL
         zaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713059166; x=1713663966;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jK3qiz2r/OxwhMERN3JhjvI7Srg7jJofsmQrWbh37ew=;
        b=pEJXS3X2/sLdpkbOEJrCMNsDiazkfTQ4d9s46LaGHmqwQhwZrndczdUVYHNacHTdtp
         OgiISLJfa07kILlW5fBFobugLnZo7CC8AwDqpcY+o1kBaWJL/CWm558Sf1iaBLu8HVAc
         alK4jSK8Ch1lo9v17aC5WfMxkfsxherLI6fcWRIw3QXUuMMucnmPvo+uQj68ZVfax91N
         dK8SSd0m5fs7/B6AAAbKlFoS2bmUaTHFE6j6/YCPngFosPn3gxBpCGMSMtVGo4q2Zi2j
         K24Ay84JMWpLDBSVctv4VJkW1aQ+u8WAxHsakrvrSPkZ1gAAdv6loaHL6U+HydPvSt3r
         OfTA==
X-Forwarded-Encrypted: i=1; AJvYcCVdMHderzVE6YpJ6eQeUmXbHX89HmfvXgLQcPORhqbok/Ry0YspKmVkfc40C7bMsdXGo1OZHeOojcUaoxz4bIZXP3zNtSDkpqK9AQ==
X-Gm-Message-State: AOJu0YyhZ/D5Il66c+1OotH/WScBV06OUlBjHw4E/FNFWRnx/TpE0C4z
	vVnFTdDOgE3jCuglHrYW2/3v/cVLES2qB/mpGL9Bj4NZMrPKlUijW49B4LIMkUk=
X-Google-Smtp-Source: AGHT+IHdW/LfRd0o4v+xgM9KCMXsKzpKd3isC0kgIw4+5k0gu/O6pWkbnzReWjH33pfl4aYHZExlRw==
X-Received: by 2002:a17:903:2c7:b0:1e3:e295:3f47 with SMTP id s7-20020a17090302c700b001e3e2953f47mr7106397plk.69.1713059166307;
        Sat, 13 Apr 2024 18:46:06 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903244500b001e5d0e3b049sm2624548pls.225.2024.04.13.18.46.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2024 18:46:05 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <22E65CA5-A2C0-44A3-AB01-7514916A18FC@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_7C671C3E-4468-48AE-8BCA-0F78F2D6442B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
Date: Sat, 13 Apr 2024 19:46:03 -0600
In-Reply-To: <20240413164318.7260c5ef@namcao>
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv@lists.infradead.org,
 Theodore Ts'o <tytso@mit.edu>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Conor Dooley <conor@kernel.org>
To: Nam Cao <namcao@linutronix.de>
References: <878r1ibpdn.fsf@all.your.base.are.belong.to.us>
 <20240413164318.7260c5ef@namcao>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_7C671C3E-4468-48AE-8BCA-0F78F2D6442B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Apr 13, 2024, at 8:43 AM, Nam Cao <namcao@linutronix.de> wrote:
>=20
> On 2024-04-12 Bj=C3=B6rn T=C3=B6pel wrote:
>>=20
>> What I see in ext4_search_dir() is that search_buf is 0xfffff000, and =
at
>> some point the address wraps to zero, and boom. I doubt that =
0xfffff000
>> is a sane address.
>=20
> I have zero knowledge about file system, but I think it's an integer
> overflow problem. The calculation of "dlimit" overflow and dlimit =
wraps
> around, this leads to wrong comparison later on.
>=20
> I guess that explains why your bisect and Conor's bisect results are
> strange: the bug has been here for quite some time, but it only =
appears
> when "dlimit" happens to overflow.
>=20
> It can be fixed by re-arrange the comparisons a bit. Can you give the
> below patch a try?
>=20
> Best regards,
> Nam
>=20
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 05b647e6bc19..71b88b33b676 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1532,15 +1532,13 @@ int ext4_search_dir(struct buffer_head *bh, =
char *search_buf, int buf_size,
> 		    unsigned int offset, struct ext4_dir_entry_2 =
**res_dir)
> {
> 	struct ext4_dir_entry_2 * de;
> -	char * dlimit;
> 	int de_len;
>=20
> 	de =3D (struct ext4_dir_entry_2 *)search_buf;
> -	dlimit =3D search_buf + buf_size;
> -	while ((char *) de < dlimit - EXT4_BASE_DIR_LEN) {
> +	while ((char *) de - search_buf < buf_size - EXT4_BASE_DIR_LEN) =
{
> 		/* this code is executed quadratically often */
> 		/* do minimal checking `by hand' */
> -		if (de->name + de->name_len <=3D dlimit &&
> +		if (de->name + de->name_len - search_buf <=3D buf_size =
&&
> 		    ext4_match(dir, fname, de)) {
> 			/* found a match - just to be sure, do
> 			 * a full check */

This looks like a straight-forward mathematical substitution of "dlimit"
with "search_buf + buf_size" and rearranging of the terms to make the
while loop offset "zero based" rather than "address based" and would
avoid overflow if "search_buf" was within one 4kB block of overflow:

   dlimit =3D search_buf + buf_size =3D 0xfffff000 + 0x1000 =3D =
0x00000000

If (char *)de is signed then this loop would run for a long time.

It doesn't look like it would have any issues with *underflow* (since
"de =3D=3D search_buf" at the start and is only incremented, and there =
is
no valid filesystem where "buf_size < EXT4_BASE_DIR_LEN".

As such, I think this change would likely address the issue.

As to whether the 0xfffff000 address itself is valid for riscv32 is
outside my realm, but given that RAM is cheap it doesn't seem unlikely
to have 4GB+ of RAM and want to use it all.  The riscv32 might consider
reserving this page address from allocation to avoid similar issues in
other parts of the code, as is done with the NULL/0 page address.

If you submit this as a proper patch you could add my:

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Cheers, Andreas






--Apple-Mail=_7C671C3E-4468-48AE-8BCA-0F78F2D6442B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYbNVsACgkQcqXauRfM
H+AK5Q//QbC+ePTcnzq7IXWpTH8Xglce/mu5s1AdjdqqeMB2rmYxAKkK5a4ngScC
AH4bFT8nPG34bNT95oZu0R0BOrsVj+K40JulHjHaOePH+qlRAlq4RvHFFRJ4BY4I
P+Ec5I587w72rrWaPTyBfyq/O5ylBH4V8sXJBXJvuCDbgOJRBxQG35f8plmWOPxn
vOX86TRauoBf30k2vg2f/U/zz0FhzAdrFB8R+/KVHcfj6Ch5HzDbXGF8vQhl4t1P
xlgJYOJrVPdeTPgB3b41Y3rFwFNI/ZLSPBkIBCPi7ytY57XxyB/ddQHg7q45AkRm
zxuug2hE16TvA7aNcaMqlEElmrIrU6wnuQ8WGOPxEPZwfklDJbmPTHkBI2dN6KBi
xxMaxPNB6xVWEsDtwXSTgTROfxLLElNWyXLKMRKMNwwdB+FrsOMRmBhOeKz0Kkef
ScAswy7giDHK3hs0cFuXdCxAHB7f9OoxrC5SITPwbvMqkmOMvhwhF6BjdlF8qpt9
XPciHAtUa5H1hf5KZ1EuwS/wdyoyjPf97VprjZSfGhupS4DO+uVdR5cMl0LMm45U
Ba1lpxXOLUDHAG7NI/i6R9WmLInKPkENBXj69PeRTi8HsT6fidACJ6iVPqoy4te4
KKTy+EV0NI87Z6Exu5nqamdHpsoP+NAeZWAtH57AcSIDm0AWPcE=
=gGOA
-----END PGP SIGNATURE-----

--Apple-Mail=_7C671C3E-4468-48AE-8BCA-0F78F2D6442B--

