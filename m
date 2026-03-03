Return-Path: <linux-ext4+bounces-14552-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDjENS/hpmnFYQAAu9opvQ
	(envelope-from <linux-ext4+bounces-14552-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 14:25:03 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA131F026C
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 14:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E0CA310335D
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2026 13:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75889426694;
	Tue,  3 Mar 2026 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqFg1JSx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B32C39D6CF;
	Tue,  3 Mar 2026 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544004; cv=none; b=aWc/W6B+ntnfQGZTQJ3rnK+8IwaW2GwNqdHHhKdaZwRJ8rQD6spJgrPSupog8bFbGWtUmawygb2iBu94Tqr9/GnFRNpSzLHODpdvi8wr2H2LGb37XbEpHhDo7JTSPCawlIJNndJwbZRWjQYTvs1rVnwAtvea18oknf+AZ9rWhT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544004; c=relaxed/simple;
	bh=EevoioCXPDnDw9Dx0CTLNigeicoSZ+92kk+jyNLVd/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfeDrw5BREDhERC/wuPQX6iH6ONWt3rj5tPsPVmj16CnjGYWKmERaL8wS+KdX/APzBr/bGhPZZZRZ+9V/6lVfnT0Q08k9SgKhtwbv4Jv/gooKYgVDkBWYKdiQccQSAVwt14ySp9/FpJQgpXZSeAv+uwdQc4DM5M5sHWnepj8mbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqFg1JSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645A5C116C6;
	Tue,  3 Mar 2026 13:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772544003;
	bh=EevoioCXPDnDw9Dx0CTLNigeicoSZ+92kk+jyNLVd/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uqFg1JSx1lMKdyVNGeIg8uWY7xV3rKZnCWIlCf2pGD2yqnLwC7IWp8ndWogir/Xdr
	 3eBDmqdXcQ93qaEkOOkBL7447yN+4rrFx+tIn6DYuDFbJVQXwEAByTflNY4RJDCqA7
	 j7AUTVLqp3itaTaGvOGxOx2BwCXb1eWLZhOEk7WTkSPMiX5WB8FEW6k4MtJjXdx3He
	 iVHU2tRQ2vEgyg7JPUhGumsU/Eyg01dzU6JLaSS+hifP6dUORURe7uIJlzjzYUHNeS
	 EkX09pTsv80S8omK8KYRYbBoRGRofjOHzXRkq+nsYyQqsxClRqSoNeZnzHSXtyAgmZ
	 +I/kicco9PpZA==
Date: Tue, 3 Mar 2026 14:19:59 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Andreas Dilger <adilger@dilger.ca>, 
	Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-man@vger.kernel.org
Subject: Re: Writing more than 4096 bytes with O_SYNC flag does not persist
 all previously written data if system crashes
Message-ID: <aabdQf-gsEprJoFp@devuan>
References: <3d8f73f4-3a64-4a86-8fc9-d910d4fa3be1@gmail.com>
 <174A8D06-B9B6-4546-A528-7A814D538208@dilger.ca>
 <20260219133244.GB69183@macsyma-wired.lan>
 <aZxLxum4WFYKbx2O@devuan>
 <20260223193238.GA63263@macsyma-wired.lan>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cwylalky2hmunx5a"
Content-Disposition: inline
In-Reply-To: <20260223193238.GA63263@macsyma-wired.lan>
X-Rspamd-Queue-Id: 7CA131F026C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14552-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[dilger.ca,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alx@kernel.org,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alejandro-colomar.es:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


--cwylalky2hmunx5a
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
Message-ID: <aabdQf-gsEprJoFp@devuan>
References: <3d8f73f4-3a64-4a86-8fc9-d910d4fa3be1@gmail.com>
 <174A8D06-B9B6-4546-A528-7A814D538208@dilger.ca>
 <20260219133244.GB69183@macsyma-wired.lan>
 <aZxLxum4WFYKbx2O@devuan>
 <20260223193238.GA63263@macsyma-wired.lan>
MIME-Version: 1.0
In-Reply-To: <20260223193238.GA63263@macsyma-wired.lan>

Hi Ted,

On 2026-02-23T14:32:38-0500, Theodore Tso wrote:
[...]
> The text in VERSIONS is not incorrect, in that it is talking about the
> distinction of O_SYNC and O_DSYNC in terms of which kinds of metadata
> will be persisted.
>=20
> However, the reason why all of this information regarding Synchronized
> I/O is in VERSIONS is describing the historic behaviour of Linux
> version 2.6.33 versus more modern versions of Linux.  But 2.6.33 dates
> from February 24, 2010 --- 16 years ago.  So it might be simpler if we
> simply dropped this kind of historical information.

I prefer keeping it, but I agree with moving it to a place where it
doesn't distract (maybe even a separate page).

> But if you do
> want to keep it, we should move the bulk of that inforamtion into
> O_SYNC and O_DSYNC.
>=20
> So maybe:
>=20
>        O_DSYNC
>               Write  operations  on the file will complete according to t=
he re=E2=80=90
>               quirements of synchronized I/O data integrity completion.
>=20
>               By the time write(2) (and similar) return, the  output  dat=
a  has
>               been  transferred to the underlying hardware, along with an=
y file
>               metadata that would be required to retrieve that data.
>=20
> 	      See VERSIONS for a description of how historial versions
> 	      of the Linux kernes from 2010 behaved.
>=20
>        O_SYNC Write  operations  on the file will complete according to t=
he re=E2=80=90
>               quirements of synchronized I/O file integrity completion (b=
y con=E2=80=90
>               trast with the synchronized I/O data  integrity  completion=
  pro=E2=80=90
>               vided by O_DSYNC.)
>=20
>               By the time write(2) (or similar) returns, the output
>               data and all file metadata associated inode for the
>               opened file have been transferred to the underlying
>               hardware.
> 	     =20
> 	      See VERSIONS for a description of how historial versions
> 	      of the Linux kernes from 2010 behaved.

LGTM.

>=20
>     VERSIONS
>        Before Linux 2.6.33, Linux implemented only the O_SYNC flag for
>        open().  However, when that flag was specified, most
>        filesystems actually pro=E2=80=90 vided the equivalent of synchron=
ized
>        I/O data integrity completion (i.e., O_SYNC was actually
>        implemented as the equivalent of O_DSYNC).
>=20
> I'd suggest dropping everything else in VERSIONS, including the
> discussion of O_RSYNC.  All of that is much more appropriate for a
> tutorial.

How about having an O_RSYNC(2const) manual page that talks in detail
about it?

>=20
> If you really want to keep all of that text, perhaps it could be moved
> into a synchronized-io man page in section 7.

Yes, a syncronized-io(7) page would make sense.

>  In that we can talk
> about the difference of fsync() and fdatasync(), which is interesting
> as a conceptual model, and conceptually it is similar to the O_SYNC
> and O_DSYNC.  But the difference of what data will be written back
> (the data that was written in the file descriptor where the
> O_SYNC/O_DSYNC flag was set, eitehr via open or fcntl, versus all
> buffered data in the buffer cache).  The synchronized-io man page
> could also have more of the information around O_DIRECT in one place.

I like the idea of a chapter 7 manual page, or separate 2const pages for
each different macro.  Whatever you consider more useful/readable.

>=20
> > If you'd write a patch, I'd appreciate that.
>=20
> Well, there's a question of what's the minimal change that is needed
> to fix out-and-out inaccuracies, and we can just delete some
> parenthetical comments.

Yup; I strongly prefer many minimal patches.  If you (or anyone) start
by removing parentheticals that are unnecessary or incorrect, that'd be
good.

I would do that, but I wouldn't be able to write the commit messages, or
decide how to group them.  I'd need someone expert in those APIs to
write the patches.  I can then amend them editorially if they have any
minor issues.

> BTW, if we want to delete inaccurate information, I'd also suggest
> deleting the following text in the O_DIRECT section of the man page:
>=20
>       A semantically similar (but deprecated) interface for block
>       devices is described in raw(8).
>=20
> ----
>=20
> Then there's trying to rearrange the tutorial-style information for
> people who want to implement code which needs data persistence
> guarantees.  That's quite a lot more work, and while I'm happy to
> review or assist someone to write that more expansive tutorial
> material, it's not something I'm willing to sign up to do.

Okay.  While I can't do the removal of inaccurate text, I can reorganize
correct text.  If you do the former, I can do this afterwards.  I'll CC
you in such patches.

> ----
>=20
> Finally, there are some philosophical questions about what the goals
> of the Linux kernel man pages --- how important is having historical
> information (for exmaple O_DIRECT has a "since 2.4.10", which is 25
> years ago --- really)? and how important is there to have tutorial
> infomation and where should that information should be organized in
> the man page.

Michael Kerrisk wanted to keep everything after Linux 2.6.  Moving it to
HISTORY, and reducing less important details, is appropriate, but
removing it all is not so much.

I more or less keep that guideline, although I'm slightly more prone to
removals, but not too much.

> My personal opinion is that the primary priority of the Linux man page
> is to document the specification of the kernel interfaces that we
> expose to user space.  Things like tutorial material and a descriptive
> of historical versions are of secondary importance.

Yup.  I've been moving a lot of text to separate pages or HISTORY
sections, or removing unnecessary details.

> I'd also advocate dropping historical information for kernel versions
> which are older than say, 7 years.  Curretly the oldest LTS kernel
> which is supported upstream is 5.10, which was originally released in
> 2020, and will EOL by end of 2026.  The Linux kernel 5.0 was released
> on March 3, 2019, so using a 7 year lookback means that explanation
> about how the Linux kernel in 2.4.x, 2.6.y, 3.x, 4.x, etc. can be
> dropped from the man pages, since IMHO it will reduces a lot of noise
> that will likely confuse readers.
>=20
> But that's a call for Alex and the man pages project to make.


Have a lovely day!
Alex

>=20
> Cheers,
>=20
> 					- Ted

--=20
<https://www.alejandro-colomar.es>

--cwylalky2hmunx5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmmm3/kACgkQ64mZXMKQ
wqmQ5xAAilOVkKnvEPkeVJsvbf7Eq7vmSaIm9PU8wsbwEH1sgTagIsPbzTPaEMZc
OEfSO4Xpz4fO8UwGALHpnNgf6xySDujKNmJOkNQLsFjJaJFRIK1Z3urDK67VQ3Uy
5u8ltUW41HcPuhBNlyx7Tlx7OY2+qdp/9aNsDH5yuyN8kVkX3sJtMAK0XK4KRjo/
cFU/09ytvdDI9gCk9tYZqaW8Cis1UjaQgdUEas7BxV+CTu5OlruOy+KTN3yzlJKI
XfkIO1tgp+e7CbJCqy7H+5XkanQvzQCsutpiyf90ixojiTO9dzKENHrl0Jj8x6gq
1kW31TG7plLdqD006UyVmbGKJOyYPmpwI76sFIld2hgzaFRvic/UidqquRdWfx+X
relshs71ME3WAG8tISIZItcyjuPj/eCdx3XTiXdBR96m4T0HoYrh2b5xYxIbxZjT
SXKS2KOXZQ/Bbm1PASrw3RcR6/SP49p+9CBdPnXGaJCwk5EgXaAwYyIF+3LsWHdp
uNWsl2RoHt8YJx0qzLuk/+O77+Ti/7wqVxPzRxmK2kRYE/+myElirisPKSNJcTFb
aDLf1TQ8/IQbiNpZq+S2oASeHcv8FY2A05X4ouJRMNOEmb+fzYE8nPajeA3fHKWk
eUT9urM3bF3WADye02uGDJIBd2C996r2MbGa+2FdwWoZKqZahHM=
=J8OC
-----END PGP SIGNATURE-----

--cwylalky2hmunx5a--

