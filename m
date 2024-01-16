Return-Path: <linux-ext4+bounces-826-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0EB82EFB0
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jan 2024 14:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7326F285B47
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jan 2024 13:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157221BC55;
	Tue, 16 Jan 2024 13:26:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from server.interlinx.bc.ca (mail.interlinx.bc.ca [69.165.217.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73910EEAB
	for <linux-ext4@vger.kernel.org>; Tue, 16 Jan 2024 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=interlinx.bc.ca
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=interlinx.bc.ca
Received: from pc.interlinx.bc.ca (pc.interlinx.bc.ca [IPv6:fd31:aeb1:48df:0:3b14:e643:83d8:7017])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by server.interlinx.bc.ca (Postfix) with ESMTPSA id 3C4502ABB1
	for <linux-ext4@vger.kernel.org>; Tue, 16 Jan 2024 08:26:15 -0500 (EST)
Message-ID: <42bc44533e997531baa79c73867a942504122886.camel@interlinx.bc.ca>
Subject: Protecting lost+found from rmdir by directory owner?
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: linux-ext4@vger.kernel.org
Date: Tue, 16 Jan 2024 08:26:14 -0500
Autocrypt: addr=brian@interlinx.bc.ca; prefer-encrypt=mutual;
 keydata=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
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-AvpWgjlYzZShx7dJKyXD"
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-AvpWgjlYzZShx7dJKyXD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Let's say I create a new ext4 filesystem for exclusive use by alice and
when I mount it, say, on /mnt/alice I set the permissions so that alice
can work in that directory:

# mkfs.ext4 /dev/foo
# mount /dev/foo /mnt/alice
# chown alice:alice /mnt/alice
# chmod 775 /mnt/alice

But now /mnt/alice/lost+found is at the mercy of alice since she has
write permission for /mnt/alice.

[How] can I protect /mnt/alice/lost+found from removal by alice?

Thoughts?

b.


--=-AvpWgjlYzZShx7dJKyXD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEE8B/A+mOVz5cTNBuZ2sHQNBbLyKAFAmWmg/YACgkQ2sHQNBbL
yKCecAgAmQW3eoI7vJn8/Bdl0T1OZxTMzYsoIL1zwS/7Awn/K+n9Pdt7ZvRrFIFU
rP1r0q4k0KzfG1MlwA/g4DwRwky+BjCGvWzcRquCTRfsxyfZxusqlglZov6wQ33j
VQQ2Kq0VyONisOmSBJw5sS6ob1ZBHMKBYXQHmC02LHORkPIRcBmwuDRgHkykzbSE
/IP0eYRn7VEubfPefjh7GHE5BI4+R5WEg10YGSj1bDcraLpWQbZhPYy0pxg5tkQh
FujL+xa5LgHczzGW6iZvmYSKdEKqfHETmmtzMax2kxE2Wz/P2twLcFU9MCdXdlsL
MfWpeP+EX+jKK3qpeTLi4WgeNlEOtA==
=93rX
-----END PGP SIGNATURE-----

--=-AvpWgjlYzZShx7dJKyXD--

