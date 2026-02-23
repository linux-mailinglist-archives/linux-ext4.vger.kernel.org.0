Return-Path: <linux-ext4+bounces-13776-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNL3EblMnGnYDQQAu9opvQ
	(envelope-from <linux-ext4+bounces-13776-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Feb 2026 13:48:57 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B645A176700
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Feb 2026 13:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A0013054229
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Feb 2026 12:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B77366059;
	Mon, 23 Feb 2026 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQM1l7+Y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BA434E746;
	Mon, 23 Feb 2026 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850818; cv=none; b=Lq8OpOrylDao0FjhxfFU7pVjEcamQ0m8uApN9kLq0Bxu3S8BuqIOMi2W8RCIuTftaDIoywLNvSjLRTEsI9xTVwNtAd3a8T/fDPJZJHThaRs6nv5Aj5nIgqfiBg3cBdgtNUeyK8xUiKARfhi3swXi8ehZYXScEJnpKRcJxuYFoFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850818; c=relaxed/simple;
	bh=vrDf41zTUi7dFIl6BT5+CkOFJTsjrMPk+DAhmB5nBvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeMU/LFFv8+zJtZpV+1FftnqrAkdGjPui8UWvI8WlvvRP/ryAjYde0EnIRvDUE+E1cvX6IQwi2lykedsHeWpoE5xg6ur1tFFu0FJVIzh9XWudSvtaxXWH/5a8zC6ogDwTUj0QfXd2UBCt7AeZZ4JKUFhioMd/erc0IeBDT245hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQM1l7+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E0AC116C6;
	Mon, 23 Feb 2026 12:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771850817;
	bh=vrDf41zTUi7dFIl6BT5+CkOFJTsjrMPk+DAhmB5nBvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQM1l7+YpOa+YQMjzzR8yGEIYuyv0pDvTeORswXyHDdxxj9kNdRnCRVozEfcStKHU
	 Aitjh161C/N9xScX5a0f9nyyGw4r2CdwQWMgZW8kWM40mRscuLLrPEkz5DXKNxFjv4
	 JOzZzHOZol40j3ooXEpBUQ6g7J3EcTZ7UWMTU/IEbvV4pkG5vGfiGSRR5R89Urc0ZN
	 jUnPUGOhs2xVHk3a2FbTb0Aap4lOQ2aGoz5QC2tlzxvVNuEmkCyIQYzJ7s9sP/You4
	 Gpcvhuch0slPkSVfedXdS/WZJQkIy9KhAMYwQkjJnym50Oy/UkLJUDrLdTaTc+KhMU
	 UwgK4Sx8t8abw==
Date: Mon, 23 Feb 2026 13:46:54 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Andreas Dilger <adilger@dilger.ca>, 
	Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-man@vger.kernel.org
Subject: Re: Writing more than 4096 bytes with O_SYNC flag does not persist
 all previously written data if system crashes
Message-ID: <aZxLxum4WFYKbx2O@devuan>
References: <3d8f73f4-3a64-4a86-8fc9-d910d4fa3be1@gmail.com>
 <174A8D06-B9B6-4546-A528-7A814D538208@dilger.ca>
 <20260219133244.GB69183@macsyma-wired.lan>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tx7lxkblhrx3j765"
Content-Disposition: inline
In-Reply-To: <20260219133244.GB69183@macsyma-wired.lan>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13776-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[dilger.ca,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alx@kernel.org,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alejandro-colomar.es:url]
X-Rspamd-Queue-Id: B645A176700
X-Rspamd-Action: no action


--tx7lxkblhrx3j765
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Andreas Dilger <adilger@dilger.ca>, 
	Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-man@vger.kernel.org
Subject: Re: Writing more than 4096 bytes with O_SYNC flag does not persist
 all previously written data if system crashes
Message-ID: <aZxLxum4WFYKbx2O@devuan>
References: <3d8f73f4-3a64-4a86-8fc9-d910d4fa3be1@gmail.com>
 <174A8D06-B9B6-4546-A528-7A814D538208@dilger.ca>
 <20260219133244.GB69183@macsyma-wired.lan>
MIME-Version: 1.0
In-Reply-To: <20260219133244.GB69183@macsyma-wired.lan>

Hi Ted, Andreas,

On 2026-02-19T08:32:44-0500, Theodore Tso wrote:
> +linux-man
>=20
> On Wed, Feb 18, 2026 at 02:55:13PM -0700, Andreas Dilger wrote:
> > If anything, the man page should be updated to be more concise, like:
> >=20
> >     "the *just written* output data *on that file descriptor* and assoc=
iated
> >      file metadata have been transferred to the underlying hardware (i.=
e.
> >      as though each write(2) was followed by a call to sync_file_range(=
2)
> >      for the corresponding file offset(s))"
>=20
> Yeah, this is an inaccuracy in the man page; the definition of O_SYNC
> from the Single Unix Specification states:
>=20
>     O_SYNC    Write I/O operations on the file descriptor shall complete
>                                    ^^^^^^^^^^^^^^^^^^^^^^
>               as defined by synchronized I/O file integrity completion.
>=20
> Compare and contrast this to what's in the Linux manpage:
>=20
>        O_SYNC Write  operations  on the file will complete according to t=
he re=E2=80=90
>               quirements of synchronized I/O file integrity completion (b=
y con=E2=80=90
>               trast with the synchronized I/O data  integrity  completion=
  pro=E2=80=90
>               vided by O_DSYNC.)
>=20
>               By  the  time  write(2) (or similar) returns, the output da=
ta and
>               associated file metadata have been transferred to the  unde=
rlying
>               hardware (i.e., as though each write(2) was followed by a c=
all to
>               fsync(2)).  See VERSIONS.
>=20
> The parenthetical comment in the second paragraph needs to be removed,
> since fsync specifices that all dirty information in the page cache
> will be flushed out.

Would you mind checking the text in VERSIONS (since there's a reference
to it right next to the text you're proposing to remove)?  I suspect it
will also need to be updated accordingly.  I don't feel qualified to
touch that text by myself.

If you'd write a patch, I'd appreciate that.


Have a lovely day!
Alex

>  From the fsync man page:
>=20
>        fsync() transfers ("flushes") all modified in-core data of (i.e., =
 modi=E2=80=90
>        fied buffer cache pages for) the file referred to by the file desc=
riptor
>        fd  to  the  disk device (or other permanent storage device) so th=
at all
>        changed information can be retrieved even if the system  crashes  =
or  is
>        rebooted.   This  includes  writing  through or flushing a disk ca=
che if
>        present.  The call blocks until the device reports that the transf=
er has
>        completed.
>=20
> I'll also mention that the fsync man page doesn't really talk about
> its interaction with O_DIRECT writes.  This is mentioned in the
> open(2) man page, and in general, people who use O_DIRECT are
> generally expected to know what they are doing.  But in the context of
> O_DIRECT writes, the fsync(2) call is also used to make sure that a
> CACHE FLUSH or equivalent command is sent to the storage device, such
> that the O_DIRECT write is guaranteed to persist after a power
> failure.
>=20
> Cheers,
>=20
> 					- Ted
>=20

--=20
<https://www.alejandro-colomar.es>

--tx7lxkblhrx3j765
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmmcTDcACgkQ64mZXMKQ
wqnrlBAAu5NZNff14U6pUIrsFi7/6PYuwl1sP2z/WfCpvVo0PPdybWTSk+aNfz5W
N2vIFG2iAuZeuwlAjmqBSG5Pqp0OniT//rgOfQNb+DsI9698RVWU78czkYFII0Gy
NH0sRwyC+8BR0pLZV+Ic4UGvAySvS2UDbrl3B4UcBEDUjzn/YsjoH74foZJgwwBG
j3n08eozaWKFcHQJ8ar4VLpMEu4mHUQmtKUwGcxFIkYDaORAgv3aQSazpZWRq0hG
wLqgVwxLBzv/kRfqOwrHeR7JrCZIs6Te7V5+19jUBo3qjZBtPXwgR+QUzX5y8hdZ
tmho3Syfc5jURZ+CS/nmGFMD9GA4vyucC9QdR+yNa+LLoGVKHcUAEwZC+VGOnByL
ThCMOsaUIo7yYeqhLs2dtxwBayWBgvcs8Y1wXPyq5hTr4YO89E9xq/u4rEDnIIm5
axeVf8sbB2Rnx9j418TJhLWTjrHHx6h4YnRktgryJZf02gj98EHo46eOZ9Nl/i4q
9eYAW/N8ysXzuIrzh3jS0zvqJ8Uvj8Y+KPtPRg1oflGCGIvDriTQ6Rytl3lVrpMV
imeRFQPauUokQwJ6bsaANsYYFR1PyeuW6tLWJvYM4QURKgi7t6gbYqhUGaJdfMhV
QcC+scUbHUDLZgbjQGofPo4znP/ck3q1hkEtZOFovRiX2tbQjIQ=
=/TnD
-----END PGP SIGNATURE-----

--tx7lxkblhrx3j765--

