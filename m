Return-Path: <linux-ext4+bounces-6509-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6762BA3C93B
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Feb 2025 20:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 129597A6C4C
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Feb 2025 19:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5740A22DFFC;
	Wed, 19 Feb 2025 19:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="REeHwPfD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E7622DFA2
	for <linux-ext4@vger.kernel.org>; Wed, 19 Feb 2025 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739995145; cv=none; b=V84AxcxqKbkrYELJ4+a6Sdtl7zPODDlWdlqI+Sm1RpbRBydJNbm4/CMHCMWRrnZqVQoR1XcKVyIdknoqPQk4+5anSS5za8tC0O4YrigzZ6G0vQ45omE981b1dNUXOTamEc0E6oTKrY5M1WMz49JKZw4qx4aYlalstdvXy0K++MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739995145; c=relaxed/simple;
	bh=sl1bIWgT+Ny49IGc4wlAHncanjuH1thPIN26emCkc5I=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=K79KAyTgceRL7jVMco6dAP8fmvMTjGqcDhLaatm3pGwCc6ctwk0fzYKX/QbKwYas5vPuwoVwDpG56yiYLLTftu/vWqoM7tcKlA5eLXhGr1BUUx9ozj98bGRC25qBDYhKcG/wLRoHsxhEknF9q46UkSmaXWSBJ/qJff5N7Ry16YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=REeHwPfD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220bff984a0so2116215ad.3
        for <linux-ext4@vger.kernel.org>; Wed, 19 Feb 2025 11:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1739995141; x=1740599941; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mhkSe9/RtvN6t41icYUJStk3QJC1BJGcc6ZtRYyq2WI=;
        b=REeHwPfDOWGiIBF8OaO4sYgCYEAqRNQYVM41MO4z6vUrkfFS+L08e5MYz5e+5aHqrE
         836yFYosf0/KEYPdqLCmwWbm7vDINTh8w7iTV1V6elcep6uRXY1v13VoOLqxYYzy9U2/
         iQxyDDd28fgAv9EEAcx1yHphgxbOKmAseYrrTedfSvKLzynOCVD2Z/nxYeCsPvWQQNMm
         WN7P6hhlsuFbEf0SIcwIYuMTZgHFLIgk27HAtX4d871ZNJF+OkdYf1jkwThCbvRLNEke
         eDef0l1rcqKMikKF/bGZKMq5W1WJ6+5cB5w3mVvCtkjnQNQw8ZNsTH/CdlX6VqwrYhMT
         dE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739995141; x=1740599941;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mhkSe9/RtvN6t41icYUJStk3QJC1BJGcc6ZtRYyq2WI=;
        b=jQSb5v8QTTeeoJtgFbZ1ndTL0Z2RLT0Kx/h3uVM8nHerPTrh8rKUeXSRdsQObbh0gt
         XMjudG78WKaqpim+s8FYkWvFiAs4WUVozGauSroE6K2hE6VamNueZxfXNgOqyYekTHsf
         p5k9VcSO3hcPLR8TI41I6z7uiRutueV/dlZfAVz31LyZaW9BFrFJiH7YsfmfXa3oabFs
         9PPmu9z+eO5heJEeMq5zKc0SolqGn4NaqFbnZKq06MQAw1Y5UjIp2FV796wbmITfA1cl
         EWxQkIDZ7VsXavJrC2Y7NnA2cXoEuhobcBdn2sSaHaWqR9ZsJORxegJ4WT84M5ok6wPL
         ofoQ==
X-Gm-Message-State: AOJu0YwAMaGzgcEDCxcqWNgL8+y3rIzSZ4k+NC+UtecYy1a/q6unOCLt
	7tfwkxR45taaBtVBlp8ul3bpsanPhelywLGfC+ZMtp8C6bb5eLMLKpJEGtJ27Ro=
X-Gm-Gg: ASbGncvS97uBlgKREevY1lOnRhBw6sTJxpe3TWjMbR1xzY/4mB21d/xwP6WKne22zli
	zkOJjyMVfBZ9JMjOwgIWbaDwGpQyPT5bVvf0T+6WW8fwqH8EAgWqvdjRZwrv6r6R/4TDzSGlU2U
	vXJzU9jzEFVREFFGsoXslq5FaicjvyFWuo1nQ38KY7Nkce6d/pGRNzvMP9uFeVjFWwPoF7rkw+S
	bbxcqGBVJ1op8aC4irBaXrpT/pDvJmiBey5YoMCMRYI2webYEQ9MQZNwBLu5XPl1EnLAtMEgW56
	8wkL7Km/Dajjy8in8bd5RpYiIIQJMmOnxRDhSUyPMHnavIstDTvekCgjfkh60BGJ
X-Google-Smtp-Source: AGHT+IHi2i2eBZD7/TQKnajO8d4jx59kJINUOC7ofYSnVQv6/vrNlABb0PItpB1YbfBR1EBCYKDf1A==
X-Received: by 2002:a17:902:e841:b0:21f:564:80a4 with SMTP id d9443c01a7336-221040a9a0emr316198805ad.33.1739995141372;
        Wed, 19 Feb 2025 11:59:01 -0800 (PST)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545c9bbsm107022545ad.127.2025.02.19.11.58.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2025 11:59:00 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <21C92625-5A8E-430C-8359-A07CE698DE42@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_CA5CE96B-F53D-42EE-9782-E6A60D430A9C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Is it possible to make ext4 images reproducible even after
 filesystem operations ?
Date: Wed, 19 Feb 2025 12:58:57 -0700
In-Reply-To: <TYCPR01MB966943691EBB5DA3F5F85621C4E62@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Cc: linux-ext4@vger.kernel.org,
 Shivanand.Kunijadar@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp,
 nobuhiro1.iwamatsu@toshiba.co.jp
To: Adithya.Balakumar@toshiba-tsip.com
References: <TYCPR01MB966943691EBB5DA3F5F85621C4E62@TYCPR01MB9669.jpnprd01.prod.outlook.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_CA5CE96B-F53D-42EE-9782-E6A60D430A9C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 21, 2025, at 5:29 AM, Adithya.Balakumar@toshiba-tsip.com wrote:
> I am working towards reproducible builds for a project that I am =
involved in. We use a few ext4 partitions in our disk images and I am =
trying to make the ext4 filesystems reproducible.
>=20
> I understand that from e2fsprogs v1.47.1 onwards we can create a =
reproducible ext4 filesystem image. We can indeed create a reproducible =
ext4 filesystem image when we use the "-d" option in "mke2fs" command to =
pass the contents of the filesystem at the time of creation of the =
filesystem itself. I understand that there are a few other parameters =
that needs to passed to the "mke2fs" command like a deterministic UUID =
and hash_seed values to make the filesystem image reproducible.
>=20
> In the project that I am working on, there are some mount operations =
done on the filesystem to copy certain files into the file system. This =
updates the "Last mount" and "Last write" timestamps in the filesystem =
metadata (confirmed this with dumpe2fs) thereby making the images =
generated not reproducible.
>=20
> I would like to understand if its possible to make the ext4 images =
reproducible even after filesystem operations like mounting and =
unmounting the filesystem ?

It should be possible to use debugfs commands to change the timestamps =
(and other
fields) in the superblock to an arbitrary value, something like:

    {
        echo "ssv wtime 123456789"
        echo "ssv mtime 123456789"
    } | debugfs -w -F /dev/stdin $IMAGE_FILE

Depending on what changes are being made while the filesystem is =
mounted, you
may also need to modify the inode timestamps directly as well:

    {
        echo "sif $PATHNAME ctime 123456789"
        echo "sif $PATHNAME2 ctime 123456789"
        :
    } | debugfs -w -F /dev/stdin $IMAGE_FILE

The debugfs commands could all be combined into a single debugfs =
invocation,
and are just shown here as separate commands for clarity.  If the =
commands
are always the same, they could also be written into a command file =
instead
of read from stdin each time:

    debugfs -w -f $COMMANDS $IMAGE_FILE

but for scripting purposes it can be convenient to generate debugfs =
commands
on the fly (e.g. with looping, etc.) and pipe it to debugfs via stdin, =
and
this is not obvious, so I thought it would be good to show an example.

Cheers, Andreas






--Apple-Mail=_CA5CE96B-F53D-42EE-9782-E6A60D430A9C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAme2OAEACgkQcqXauRfM
H+CKfg/9E+ndtUQbzaqMVAJcugw6hlDA0l+umG23R/WKi3Ju9y9dQsz3y9w4ialL
fJ0lXstpwG4RT1cFQyUmtSZOXL1XXxTeEuLc2AzeNPdosnkyD7OGzvuhKs1ncMal
vy5gIPB2jdJI33ibiYxQZNDiL0APWXES7MKHCGBXyNQqtRqEZoxBfU2laXeJWOrp
647VEnxDg4fN9JkH14wFgqbYP6+hGh162m8L9Q2/SPd4gSYFvaN1OUdUP5MDHMKr
0tcOryJr6xxriTS5DTKJNdN/CWu20mOT9Fejt7l4puHrhZ1soAvAks2FIus9a8Ee
8Zu+CXozs9h/NYbek0qRrsrREDgwcANDQ1JozZQFZ+J60wD9Uv7xIfkwNLmMvO9N
oNgLQ0gRugAqL4xi0tztc1jAd4MNP+jXbVhNnhm3SKsYB1t1dzECXO+cjSrN2iRz
jDJJn2WlIhxo6loSk6H4vVjnBTyf0PBA+s8+v/z7B3uBHFYYcUBflJHzKN5UYVe7
X0tDczHltyfcxCdfzFIVPvGpN98vxVOOMZW1u/pGCFCvCdgG7Nmt3dTkDU7rhmg+
ZxdF9B+vWNnx3cTJ4fcDPb6sZ35pBNYzoVzQKxBUKVdZ77SVa2mcB/w+zCRQjtCc
gUO8SXGBxS2KPQ+hyr4vMqzW+KYxiAfiaTITAj2HBYMjZyrkV5Y=
=ffgp
-----END PGP SIGNATURE-----

--Apple-Mail=_CA5CE96B-F53D-42EE-9782-E6A60D430A9C--

