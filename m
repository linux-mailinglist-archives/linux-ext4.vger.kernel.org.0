Return-Path: <linux-ext4+bounces-4568-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D346999ECD
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Oct 2024 10:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDDB81F23807
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Oct 2024 08:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5B220ADC2;
	Fri, 11 Oct 2024 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mister-muffin.de header.i=@mister-muffin.de header.b="Y8CCWLdA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mister-muffin.de (mister-muffin.de [144.76.155.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09A720A5C8
	for <linux-ext4@vger.kernel.org>; Fri, 11 Oct 2024 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.155.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728634629; cv=none; b=LrALIr7HrwEP3k4+r1Fq5VpmhXYYTKFSPtV0g9s2AG3wERTJuUC8Parznp+UFDYnXb1gZa1LcM+jaZGvn8sWZfv3lb/YOg8TLUyCe64VhVAwy+PzKagztkg6NEU2GgCaujsVYbBhLwYCKKxgR7q301irZ0Ver4Fq/LYrJ3rKqhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728634629; c=relaxed/simple;
	bh=3CL1t07wiaWMz+nG3WT4pCxAlsVCLWyExS5DBigLxRI=;
	h=Content-Type:MIME-Version:Content-Disposition:From:To:Subject:
	 Date:Message-ID; b=P+pLKPBcXBxdfg2qGdfcS9kmw7w/DeMZ5mhXGCbl4Zy83bPO7p6CXgayTH6Sjl0F+jxK29Nt9KKgUVOrdn1ij4f8xEruI0sOjPe7t3dceZipE7n5y208MDKjkwApekd7qLQyhh7vrJEkLXJYbh8I94UrA60hUTS/B74WXBEIIJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mister-muffin.de; spf=pass smtp.mailfrom=mister-muffin.de; dkim=pass (1024-bit key) header.d=mister-muffin.de header.i=@mister-muffin.de header.b=Y8CCWLdA; arc=none smtp.client-ip=144.76.155.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mister-muffin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mister-muffin.de
Received: from localhost (unknown [37.4.230.225])
	by mister-muffin.de (Postfix) with ESMTPSA id 8693BBE
	for <linux-ext4@vger.kernel.org>; Fri, 11 Oct 2024 10:10:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mister-muffin.de;
	s=mail; t=1728634245;
	bh=3CL1t07wiaWMz+nG3WT4pCxAlsVCLWyExS5DBigLxRI=;
	h=From:To:Subject:Date:From;
	b=Y8CCWLdAPnhRIGtoRTjxbwCpZFOy/JNAG5O5iTO9bV1aJknJpWJh2jx6kXPB3ZwK7
	 Kac8h7HZZDUk5+Q0L8LOSzpdZXAs9be7ER28kJCR5TivEQX2IZ1byY9gp5ytaSKgWg
	 yJWh5zzO1RW5QF1WBhqRZZIipYdFPo/LRAVnaTGY=
Content-Type: multipart/signed; micalg="pgp-sha512"; protocol="application/pgp-signature"; boundary="===============4024423085673654895=="
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
From: Johannes Schauer Marin Rodrigues <josch@mister-muffin.de>
To: linux-ext4@vger.kernel.org
Subject: misc/create_inode_libarchive.c: also allow gnu.translator xattrs
Date: Fri, 11 Oct 2024 10:10:44 +0200
Message-ID: <172863424488.2407118.13900202892540655392@localhost>
User-Agent: alot/0.10

--===============4024423085673654895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello ext4 folks,

in my recent patch to allow e2fsprogs to create filesystems from tarballs v=
ia
libarchive I restricted the allowed xattrs to "security.capability". My
intention was probably to not allow any random xattr from the tarball onto =
the
filesystem.

This now creates a problem as GNU Hurd started using xattrs to store Hurd
translators in the "gnu.translator" extended attribute. With the following
patch I'm able to create a bootable GNU Hurd filesystem from a tarball:


--- a/misc/create_inode_libarchive.c
+++ b/misc/create_inode_libarchive.c
@@ -442,7 +442,7 @@ static errcode_t set_inode_xattr_tar(ext
 	dl_archive_entry_xattr_reset(entry);
 	while (dl_archive_entry_xattr_next(entry, &name, &value, &value_size) =3D=
=3D
 	       ARCHIVE_OK) {
-		if (strcmp(name, "security.capability") !=3D 0)
+		if (strcmp(name, "security.capability") !=3D 0 && strcmp(name, "gnu.tran=
slator"))
 			continue;
=20
 		retval =3D ext2fs_xattr_set(handle, name, value, value_size);

Would that change be a good idea? I also submitted my patch as a pull reque=
st
to Ted's github repo here: https://github.com/tytso/e2fsprogs/pull/194

Or would it be a better idea to drop the sanity check for extended attribute
names? What do you think?

Thanks!

cheers, josch
--===============4024423085673654895==
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Description: signature
Content-Type: application/pgp-signature; name="signature.asc"; charset="us-ascii"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElFhU6KL81LF4wVq58sulx4+9g+EFAmcI3YQACgkQ8sulx4+9
g+Eq+w//XJveIfv4nYHMrwchOuvJW2g1OlEMCvb1jdTIY48uXTrLCyikC6bri/WM
P64tXoiWzTHbFXOrDHXRBQBoa+XiGuWKaKtxr5cDJOL40rECY/eHbuTd+kgFy0jM
DlJFTcpH3suyBXqxugZAuTEkwiZYBad7gI44ofidpK4q68Xe71mAgnNt+ijGMPD2
edeOeByQJEF9iZ/KKf6lc2nFNxwLxcjekLkW7tkdRhTlbUVd4nEuhqJWkOjsdRlw
n2pXAaEICrBWIco9U7ixC0hnfeiow80QdTyNFvdH+N/AbdMiOzuf42GyS3YdquXn
eoVw7mupaWknUC8xcou8EwcNoDrn4WfOeDOaZOQccsersXZz9E+VW3DEa+X4XHad
SHmqlDuSatT5Zb7xpwOLJ5zcZ06yEaJcFKsnM20Ek2kuIRv8Us7uXazocYPx6Bn6
vStENKOvOOpQU+xA0Xf+K9WWdDoXAi4s38GCb5YyQEX5Q6GCACx/vZajCslQbSmO
BgP2yDhrxsDdBLvCL6Pv0t0pvzSsnNYe3uHWtI/KjWSxVuuarF1KpiRgd3YKRtMc
TaIxRYXw+SwgRBQdi0dO9BMsmU7oo32XBavutWqSvG6cmnDeDNfc31O6IfyFxISl
7bkRd9p4h1on9nBuHnopru64aH4Au1LNMIyuKjSp0RaoMYTMK2o=
=5QTa
-----END PGP SIGNATURE-----

--===============4024423085673654895==--

