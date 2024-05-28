Return-Path: <linux-ext4+bounces-2663-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DDC8D1541
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2024 09:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4D41C21C06
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2024 07:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982197317C;
	Tue, 28 May 2024 07:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="GbNgOD7+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GxrPz8mC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F134F201
	for <linux-ext4@vger.kernel.org>; Tue, 28 May 2024 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880929; cv=none; b=Rr3x6t1NuQ5Qie7nA3XPa4sMJujVfMCtxee/OFH9bSKz9ph/4twnSt8ZUCQ9rTZenXqS6F2iGCyij2YzQdMhYSprjCpIzMzzD8YMXleDDdLU6495A8KbIzSKGbPKltuMC6qwxFBxXl394ea/U0T9de++nEkMRTPGY10pp+ORjJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880929; c=relaxed/simple;
	bh=6POq/yNF2NeHKtqqteLx+vxQ0MJRnno63kaLBUzwNvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mKQ7Ur+aR1b8pDfg5SmbAwWyCVqkdLb+Ao8q+B0/FSuMof8nJODxaA7kezMjvgkVKQkCmqlfTZ9/Z6aRsSiRFux6CQwaPLaLcEwFj4mGfncQfEJgDWxnXjXCFl7fVt0X/U6GUflHzTdfEo+G4vlaN26foXQj3wqGpEf1lnQBcRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=GbNgOD7+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GxrPz8mC; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D84F711400CD;
	Tue, 28 May 2024 03:22:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 28 May 2024 03:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1716880925; x=1716967325; bh=3hoxrDK/6T
	JL189QfPAFPqqJOrRkhWbibZDX6COGJrI=; b=GbNgOD7+v2LpS+/McCfXo/E4YY
	+A8UyjBCgf2VVJngK6XBEf/qfipqwZb4zOv0fBfaWMBSZ8Ig617rL4PBJL+Mjyuv
	mqdUiLdU3fEvK3Aos4fbvukYVqvjgIwTGywt0BPsAZ49MZahZA2A+NtyCFrVwpn5
	wnrsVZf8Nzkyq4D07OLStfNwLzvwUQKZmuINGK2YsVhDVWr/9rb8+HEaTebl911W
	qHY1PbsHOmgaiXlULgsHiVXnnzwpVWnoq1a+qBrx+sePboZ25iaLqBB5JgZruGx+
	mCurgkD+sj5Pdb2LVrlfe89kepVsSFXyqwlYFNP3qAV54aMp1fl50OZBk6zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716880925; x=1716967325; bh=3hoxrDK/6TJL189QfPAFPqqJOrRk
	hWbibZDX6COGJrI=; b=GxrPz8mCOI1aCGyO68xw3nlNd0f3HQ2Jdxqj1dwvJ+RY
	1DqfLL/2lF7/Vv0Y+HbntlehdvHfNeVNeb+0JtnSiolKbpG+A790m5RLGbWD8vBD
	KDcqbxT0tax5V6Q9bALKcO3emeky+fh/LwmgBM5IysyB8jwioE/afkazo1ZpWqaV
	KqbCPx8oFP8pTqMYmEtSoa4d2/IKYP3pmVqTBIdgO8oKJoHh2ZM7vIFU+f6ui0nE
	X5Jd+bfoqNd9zTaVV3+7EuMq50WdanNj0/rNjrveSK9O7Udl3zQbC/qRCI3Jrq+P
	Ehr/whiiNqwqmWdkp2O2Y3oTPVSanHu/HeKQDwYdKw==
X-ME-Sender: <xms:HYZVZmFFfat1_DqSCimeL59CPtz0BLybvms_5-rFP15AZW-YeGc1ww>
    <xme:HYZVZnXMDeyJ2hp0qZRKTrnSzLpvJgooReafHCb3-W0Jzfh8cabmduCmllNgCN9pH
    oY9Z-PvKxn_PYqsPQ>
X-ME-Received: <xmr:HYZVZgKEzdAU_-T2317HjMJz9odXJqEdVrMh5qsclVu1socuB-CQuLxXVoAjd9q4Uh_fbkbIhwz0I35-G1nUpx8YSrTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkgggtsehgtd
    erredttdejnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdr
    ihhsqeenucggtffrrghtthgvrhhnpedugefgvdfgudekveduvdekudehffejlefgueegie
    duteeggfdttefgtdethfdvfeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhmrghk
    vghfihhlvgdrrghmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhephhhisegrlhihshhsrgdrihhs
X-ME-Proxy: <xmx:HYZVZgFt1j6VxRkC_hsAE7NkqkEj7y4bykRyOoEKx3vyPxPLd5hY6A>
    <xmx:HYZVZsUTa_5_2Yg2lt29cvnhNr9Vw3kkaaBTTVwm2yreVp37We_qbg>
    <xmx:HYZVZjMF3ReneXyqrU-rMiMnabUmrOS8V25x9u2U_gjoL9oF9zao5g>
    <xmx:HYZVZj2aaDN55EPlJJ7qZXXXqfr-rhkrBW-vOJVagYB_gUXEBfPgEQ>
    <xmx:HYZVZpj0WEDHn1vJKNUka4KASBLQyHZIl-GeZsfqHswfFfe4-IRrDhHv>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 03:22:05 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 0842451A; Tue, 28 May 2024 09:22:02 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH] libext2fs: fix unused parameter warnings/errors
In-Reply-To: <20240528064958.GB1294551@mit.edu>
References: <20240527091542.4121237-2-hi@alyssa.is>
 <20240528064958.GB1294551@mit.edu>
Date: Tue, 28 May 2024 09:21:58 +0200
Message-ID: <874jaih04p.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Mon, May 27, 2024 at 11:15:43AM +0200, Alyssa Ross wrote:
>> This fixes building dependent packages that use -Werror.
>>=20
>> Signed-off-by: Alyssa Ross <hi@alyssa.is>
>> ---
>> I'm assuming here that it is actually intentional that these variables=20
>> are unused!  I don't understand the code enough to know for sure =E2=80=
=94=20
>> I'm just trying to fix some build regressions after updating e2fsprogs. =
:)
>
> Well, note that you only get the warning at all if you use
> -Wunused-parameter, "-Wunused -Wextra", or "-Wall -Wextra".  The
> unused-parameter warning is not enabled unless you **really** go out
> of your way to enable it, because it has so many false positives.  The
> gcc maintainers do not enable this insanity even with -Wall, so
> someone really went out of their way to make your life miserable.  :-)

Yeah=E2=80=A6
https://github.com/storaged-project/libblockdev/blob/7cd19d14e61c8964187eac=
99cf276e6c999dc93e/src/plugins/fs/Makefile.am#L5

(In this case it /did/ end up with me having to look at the code and
notice the SIZEOF_SIZE_T bug I sent another patch for, so something
useful did actually come out of it this time=E2=80=A6)

> I generally think it's a really bad idea to turn on warnings as if
> they are overdone Christmas tree lights.  However, to accomodate this,
> the normal way to suppress this is via __attribute__(unused).  To do
> this in a portable way to avoid breaking compilers which don't
> understand said attribute:
>
> /* this is usually predfined in some header file like compiler.h */
> #ifdef __GNUC__
> #define EXT2FS_ATTR(x) __attribute__(x)
> #else
> #define EXT2FS_ATTR(x)
> #endif
>
> ...
> _INLINE_ errcode_t ext2fs_resize_mem(unsigned long EXT2FS_ATTR((unused)) =
old_size,
> 				     unsigned long size, void *ptr)
> ...

Okay, I'll send a v2 using this approach.

> You can also play this game if you really have a huge number of stupid
> gcc warnings that you want to suppress:
>
> /* this is usually predfined in some header file like compiler.h */
> #ifndef __GNUC_PREREQ
> #if defined(__GNUC__) && defined(__GNUC_MINOR__)
> #define __GNUC_PREREQ(maj, min) \
> 	((__GNUC__ << 16) + __GNUC_MINOR__ >=3D ((maj) << 16) + (min))
> #else
> #define __GNUC_PREREQ(maj, min) 0
> #endif
> #endif
>
> #if __GNUC_PREREQ (4, 6)
> #pragma GCC diagnostic push
> #pragma GCC diagnostic ignored "-Wunused-function"
> #pragma GCC diagnostic ignored "-Wunused-parameter"
> #endif
>
> ...
>
> #if __GNUC_PREREQ (4, 6)
> #pragma GCC diagnostic pop
> #endif
>
> I do this when I'm defining a lot of inline functions in a header
> file, and some stupid person thinks that -Wunused -Wextra is actually
> a good idea (hint: it's not), and I just want to shut up the
> completely unnecessary warnings.
>
> Cheers,
>
> 					- Ted

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmZVhhYACgkQ+dvtSFmy
ccCNvw//TnqxpUrZ5+5aRgqiVF39u1Snan3ksN/+3zm/CRPHtj0x8TCf2rlSyKwd
CMnGAMD/oroGUpo99+e1YNyOR39Iu7l1UIY1M1uzOIN6aSrKCpdo6O13XIwOq1PC
eKCJ4M+fT3XKFjtR62t1oqYblpcRQAFoLNHLITP1v3Vl7fSfDqBd99/F5lPLuuXW
3Ii8RBnA4O4Fgpfu+x1SMpQNHwXKR3r4kh8JDfkONmobKLyqLR4KC1yDQKyLIt2k
ANnC+kpgT1pNHYAGcxmo4p/KDHHmxx6kWZX2Y5dWI+IDxVOvKuBS0eyDoPiy6pig
qfZyuPn2UZxSB6cZt3OrnTkdwrjG7PaxllGDdaROj5PnpftKtnyHTFvbRi7dBmKa
UANTI65YCdQFRjP8WWpl+4n45Acjc9KEPrE8QF4WckmxVpvQAb89SJZAxgjt1XnC
gxslwPcMWtw23oTuatFJOYTm5zOf1Fwt5fzq5CQTRot7wNg49G6aYru1KjrSCYIJ
IPCQwq39/y5xik6lQphTBWnlDpo1/jiERRYXi/JrirKF0gENiXM2a0KV0vdyp1xy
4WV9kyEOwCcpV5g2PQqplfjLuOlW0P0NUwupXC0p+k+w0eJx+z15n5d4TMeiamDR
s3S/VQ1IDNo7LcyAI34woWesOdFQy8WI54LrfI3DpRj9INpsEgs=
=r9sh
-----END PGP SIGNATURE-----
--=-=-=--

