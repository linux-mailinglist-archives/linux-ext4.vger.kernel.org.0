Return-Path: <linux-ext4+bounces-13742-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEFbOoQ1lmkkcQIAu9opvQ
	(envelope-from <linux-ext4+bounces-13742-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Feb 2026 22:56:20 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E23615A741
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Feb 2026 22:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A57D3036D55
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Feb 2026 21:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0D832BF4B;
	Wed, 18 Feb 2026 21:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="MEK9q3kk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CE4324B1F
	for <linux-ext4@vger.kernel.org>; Wed, 18 Feb 2026 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771451728; cv=none; b=pbeg+yxEWlqqCpfoWeSVh2P4By++OdZtOmuf5SqYAJeOwsQ4Ly68vED9dUmpgww2ZopX+HXXaO74QV7Wk8GfQZbNCctYBu4YGs4yLuA07xaUre/d/P3q+YQTTW1kcOvZn8K6XAYJVGh0YgZJGMG7EObtIYsNVxnN2jB2xjjr4Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771451728; c=relaxed/simple;
	bh=Kx2AaXgaj3rQv+JA68P1eMLG1NNOf74Luz9qW6wfM4I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RpHcr3GV5B65R0Zf4vFE4Slp5xCLKM2EYxm0PwwY/cMsVum6VnoXBOVzksKu476SclfFmy2zU8ftLw9369D0a32GkXl5jsZ5ihxj7yVTAb9JLI/6waayOdLTADUUY1PSfSD6ZAfVlHUGF+Ai7uuwxu5rYcvIem5vmqREzO4qc2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=MEK9q3kk; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a91215c158so1759015ad.0
        for <linux-ext4@vger.kernel.org>; Wed, 18 Feb 2026 13:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1771451726; x=1772056526; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRG4xP26nKbDvnlyjY+547RwecNljgQyfG7S2lbj+nY=;
        b=MEK9q3kkTeQqFc6mpZQ/ynze1f1oeh4UEtrXZsmDrpWJSdR0f3Zh0Jz/lXoqtWlWHB
         7EzJ6dSkwd6N1nNkoazNLx3aD9l/d2dDJk65SW8ouknjQg0gPhfI52g471R6p+aevgts
         z9tpB7q1MI5h6ad8snngOVsD2G+a1713DYSn3TiJ1A5RaI98rNqNS6wWON4JFJmQF1i6
         wiHebvyZlviSC9PWALdvcvUEzP3nE4VM07qoBrOJ9liD3DQRQc6w2j22036JQrKJl1wo
         JHAEMISsYLHEkzPh4uFXO4aTFI00rgr79BgGl85de//p5OwX+iKcug7dc72jRgyERzA9
         VCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771451726; x=1772056526;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iRG4xP26nKbDvnlyjY+547RwecNljgQyfG7S2lbj+nY=;
        b=gNJG/Q1b60RxYR+fwGremTPa8YFQjaTFoNAVAavCgTfJH+aq20xnm4my4hz1ketF/k
         kw2WHuTFBRqsM88t1mLiDYm2FhWmZiqudJPWOiFMMytCeGDhT6kY+06F9NaPDt2QNfDN
         7pE1Eu20MSjeJEuY68DBgcfHisYGh86ppv2ruNzPzqFEKGr20PexBWh2YRZeasXtsHmM
         gmdEMJadJ0CCXfntpejK+aHH7uDf+hKRCqC70/41cJrSQvuPDkxrarFoAqRFw1SFJSDx
         DKonjmRjcqlWXG4aOBmBn6zCaqdb1cNyj6JQ3c8sYpXFp0nh/41E5pmQJfCMytLZBOlh
         ZBUA==
X-Forwarded-Encrypted: i=1; AJvYcCUeehNwCsYSHAEj9DBxAZ6lk1Pa8JuyyUnyvsIUor4txAMkLJqE/OGNP/HQWYFADl6qjshB15sIKbO3@vger.kernel.org
X-Gm-Message-State: AOJu0YyA5/MXx23qPjARzXhbtxU9hKIsWZ9+MuP3dZDL/JlwOjkgZ9Y5
	8JFL2qTcZw0335zzt7P/Ct68nGhIdtQk5GzBAupOAvHxvHG361b0TMR3Ku1EK2kU8CXxp9Ft41k
	gRZHKadU=
X-Gm-Gg: AZuq6aKbLh2gQFZd5owOVSp25yLPucw8jUh3SMBl1iMssUlVMzIDUqYoU0WSEcKZa1w
	o3FwrcDpLBxi/kRw61LqNVZj7lNZVS1spQ8R/Jz0u0xu2xMT9lexwvxIcyYtPuN5LMKmudgSLwF
	z4QQ9KG4BBpEhUhKWr+j2rrWqHqmZW7i5ViAs//Ehg853Yo3Bjwia0M1KhaNZyq59WWfnTE2PjL
	cKOVrIN5IxikRHgd9u+wfyJ7/TB8ry634JPUoNSAsQCleXgsLmg5rDKZpi8eJg5kxQigd3aZ3m7
	Rp1Qr1xhJ0F05FZIt3Ec6fJaJiNNSbCNXADjclzOGPbd8QQvAKEASuj18M+OucI39/tIIwvrNRf
	QDX5vDxKqYUB5vGUqEXO82QUeICnvTNreZfGId46DfKM2wwdc1hYNkmf7fn4+YRuSYzPFCj9LA/
	FvjmLa9DZgC4Q556e6Qd9CyVvlNqtBZmwKswY3W1pKNeJdWShsq3txlCa8j+HYCBLAMhRFDTPyy
	OBJkg==
X-Received: by 2002:a17:903:2282:b0:2aa:daf7:84ea with SMTP id d9443c01a7336-2ad50f93ed5mr31942085ad.45.1771451725628;
        Wed, 18 Feb 2026 13:55:25 -0800 (PST)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1aaddc46sm143053935ad.73.2026.02.18.13.55.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Feb 2026 13:55:25 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: Writing more than 4096 bytes with O_SYNC flag does not persist
 all previously written data if system crashes
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <3d8f73f4-3a64-4a86-8fc9-d910d4fa3be1@gmail.com>
Date: Wed, 18 Feb 2026 14:55:13 -0700
Cc: tytso@mit.edu,
 linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <174A8D06-B9B6-4546-A528-7A814D538208@dilger.ca>
References: <3d8f73f4-3a64-4a86-8fc9-d910d4fa3be1@gmail.com>
To: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[dilger-ca.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13742-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dilger.ca];
	DKIM_TRACE(0.00)[dilger-ca.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adilger@dilger.ca,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4E23615A741
X-Rspamd-Action: no action

On Feb 18, 2026, at 06:29, Vyacheslav Kovalevsky =
<slava.kovalevskiy.2014@gmail.com> wrote:
>=20
> Detailed description
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Hello, there seems to be an issue with ext4 crash behavior:
>=20
> 1. Create and sync a new file.
> 2. Open the file and write some data (must be more than 4096 bytes).
> 3. Close the file.
> 4. Open the file with O_SYNC flag and write some data.
>=20
> After system crash the file will have the wrong size and some =
previously written data will be lost.
>=20
> According to Linux manual =
<https://man7.org/linux/man-pages/man2/open.2.html> O_SYNC can replaced =
with fsync() call after each write operation:
>=20
> ```
> By the time write(2) (or similar) returns, the output data
> and associated file metadata have been transferred to the
> underlying hardware (i.e., as though each write(2) was
> followed by a call to fsync(2)).
> ```
>=20
> In this case it is not true, using O_SYNC does not persist the data =
like fsync() does (see test below).
>=20
> Notes:
> - This also seems to affect XFS in the same way.

Well, the O_SYNC flag has to be on the file descriptor where writes are =
done.
In your case, the "write some data" at the start is done on a file =
descriptor
that does *not* have O_SYNC, so the semantics of that flag do not apply =
to
those initial writes.  It is the same as O_TRUNC or O_DIRECT or other =
flags
only affecting the file descriptor where it is used, not some earlier or =
later
file descriptor.

Either the "write some data" phase must also use O_SYNC, or call fsync() =
on
that file descriptor before closing it, or call fsync() on the later =
file
descriptor (assuming persistence of the initial writes do not matter =
until
the later writes are done).

If anything, the man page should be updated to be more concise, like:

    "the *just written* output data *on that file descriptor* and =
associated
     file metadata have been transferred to the underlying hardware =
(i.e.
     as though each write(2) was followed by a call to =
sync_file_range(2)
     for the corresponding file offset(s))"


Cheers, Andreas

>=20
> System info
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Linux version 6.19.2
>=20
>=20
> How to reproduce
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> ```
> #include <errno.h>
> #include <fcntl.h>
> #include <stdio.h>
> #include <string.h>
> #include <sys/stat.h>
> #include <sys/types.h>
> #include <unistd.h>
>=20
> #define BUFFER_LEN 5000 // should be at least ~ 4096+1
>=20
> int main() {
>   int status;
>   int file_fd0;
>   int file_fd1;
>   int file_fd2;
>=20
>   char buffer[BUFFER_LEN + 1] =3D {};
>   for (int i =3D 0; i <=3D BUFFER_LEN; ++i) {
>     buffer[i] =3D (char)i;
>   }
>=20
>   status =3D creat("file", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
>   printf("CREAT: %d\n", status);
>   file_fd0 =3D status;
>=20
>   status =3D close(file_fd0);
>   printf("CLOSE: %d\n", status);
>=20
>   sync();
>=20
>   status =3D open("file", O_WRONLY);
>   printf("OPEN: %d\n", status);
>   file_fd1 =3D status;
>=20
>   status =3D write(file_fd1, buffer, BUFFER_LEN);
>   printf("WRITE: %d\n", status);
>=20
>   status =3D close(file_fd1);
>   printf("CLOSE: %d\n", status);
>=20
>   status =3D open("file", O_WRONLY | O_SYNC);
>   printf("OPEN: %d\n", status);
>   file_fd2 =3D status;
>=20
>   status =3D write(file_fd2, "Test data!", 10);
>   printf("WRITE: %d\n", status);
>=20
>   status =3D close(file_fd2);
>   printf("CLOSE: %d\n", status);
> }
> // after crash file size is 4096 instead of 5000
> ```
>=20
> Output:
>=20
> ```
> CREAT: 3
> CLOSE: 0
> OPEN: 3
> WRITE: 5000
> CLOSE: 0
> OPEN: 3
> WRITE: 10
> CLOSE: 0
> ```
>=20
> File content after crash:
>=20
> ```
> $ xxd file
> 00000000: 5465 7374 2064 6174 6121 0a0b 0c0d 0e0f  Test data!......
> 00000010: 1011 1213 1415 1617 1819 1a1b 1c1d 1e1f ................
> 00000020: 2021 2223 2425 2627 2829 2a2b 2c2d 2e2f  !"#$%&'()*+,-./
>=20
> .........
>=20
> 00000ff0: f0f1 f2f3 f4f5 f6f7 f8f9 fafb fcfd feff ................
> ```
>=20
> Steps:
>=20
> 1. Create and mount new ext4 file system in default configuration.
> 2. Change directory to root of the file system and run the compiled =
test.
> 3. Cause hard system crash (e.g. QEMU `system_reset` command).
> 4. Remount file system after crash.
> 5. Observe that file size is 4096 instead of 5000.
>=20
> Notes:
>=20
> - This also seems to affect XFS in the same way.
>=20


