Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 059D518A7BA
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Mar 2020 23:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCRWJQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Mar 2020 18:09:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44297 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRWJQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Mar 2020 18:09:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id b72so212258pfb.11
        for <linux-ext4@vger.kernel.org>; Wed, 18 Mar 2020 15:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=id7t3gYleu/TUFM1UniKmKpWIwsJg9ZoWGiBooGyILA=;
        b=DoqT9pdQSbtVTRX2yT53n+i9Kmt6qKLM08UaFbUisqE8unQcuR3ozBjF8X6WnyEikW
         EtkmlCbrd//X3+1sb2T+WmaEyBUtW91d+j3M0meGSgs8n+hYtqKd6A7y6jAlugw6wxpv
         Ceejq6RHdDgzQmT1mgibwWW9+qRHdvZRj25x7YGrW+SP0Jz+UC3pNJESjRq4GMZxtlus
         Gk5A+rhTruXRdnN+CkDn13SiNNI5Jho44fQd5tY6RP/uM+E4c5ka5kNjiA5br7x373CA
         ygxTWHjUxXQ5M5aICz4I5Zf466fl1VD/D7Cv+jf4tknWmsgqu4rRguW1p1JPwolkHXSz
         dTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=id7t3gYleu/TUFM1UniKmKpWIwsJg9ZoWGiBooGyILA=;
        b=GgPYmx3Tlz0aI2yl84LYKjNUxHTWc/MoxeG6hyaDVbXT+ruNbCJ8BE0AQTTCT+eT8W
         88aiUs4qz/DyoDuwYGD8hH3bHzQ2UXXK9OouyBg21tN83tx5RP+nIgbjCHIB5CZdQYdw
         b6K+Bu/nMueo4L66sSXaNKN7GjP73l+Qlz0Zcn67Iu6YbB2deWmBmZm7kNZiPjcnydud
         ECTDR8bnV+qB+1ouQyt4o7qLYahjKMR8pAZ7w5lK7ocgetffNLddRMHfdu18Yy+n+pd9
         xxc7QdXrJwmIt/0Q+axiaWyYWOg4nUy74R3hu6XAQfpGGce2zLooUpq/pifB0/g4rVqF
         xBcw==
X-Gm-Message-State: ANhLgQ1Ctwjr7SiY3xhQ8qest0qZvRYDgSOXCQJfzGtH0fBy554dda6G
        imw4/avVnUQWgM8spy9aByYGPfRti+s=
X-Google-Smtp-Source: ADFU+vtBIfGuY8rop+SHMoGGo8T+BFBL6hSRvdBN4yvx4u9eCXzM3CYmhQd6f5H01iYYIxNmRa2QDA==
X-Received: by 2002:a63:2b54:: with SMTP id r81mr6998039pgr.453.1584569353442;
        Wed, 18 Mar 2020 15:09:13 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id e26sm46087pfj.61.2020.03.18.15.09.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 15:09:12 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <934F58B9-2275-4AFB-9244-895A26249141@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_AF7EAAC6-8BA4-4AF3-8E33-9E2F1B5B03D5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: do not commit super on read-only bdev
Date:   Wed, 18 Mar 2020 16:09:11 -0600
In-Reply-To: <4b6e774d-cc00-3469-7abb-108eb151071a@sandeen.net>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
To:     Eric Sandeen <sandeen@sandeen.net>
References: <4b6e774d-cc00-3469-7abb-108eb151071a@sandeen.net>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_AF7EAAC6-8BA4-4AF3-8E33-9E2F1B5B03D5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 18, 2020, at 1:19 PM, Eric Sandeen <sandeen@sandeen.net> wrote:
>=20
> From: Eric Sandeen <sandeen@redhat.com>
>=20
> Under some circumstances we may encounter a filesystem error on a
> read-only block device, and if we try to save the error info to the
> superblock and commit it, we'll wind up with a noisy error and
> backtrace, i.e.:
>=20
> [ 3337.146838] EXT4-fs error (device pmem1p2): =
ext4_get_journal_inode:4634: comm mount: inode #0: comm mount: iget: =
illegal inode #
> ------------[ cut here ]------------
> generic_make_request: Trying to write to read-only block-device =
pmem1p2 (partno 2)
> WARNING: CPU: 107 PID: 115347 at block/blk-core.c:788 =
generic_make_request_checks+0x6b4/0x7d0
> ...
>=20
> To avoid this, commit the error info in the superblock only if the
> block device is writable.
>=20
> Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
>=20
> (compile-tested only FWIW)
> (also, not sure if the bdev test in __save_error_info should be =
removed?)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 0c7c4adb664e..55392903bda5 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -372,7 +372,8 @@ static void save_error_info(struct super_block =
*sb, const char *func,
> 			    unsigned int line)
> {
> 	__save_error_info(sb, func, line);
> -	ext4_commit_super(sb, 1);
> +	if (!bdev_read_only(sb->s_bdev))
> +		ext4_commit_super(sb, 1);
> }
>=20
> /*


Cheers, Andreas






--Apple-Mail=_AF7EAAC6-8BA4-4AF3-8E33-9E2F1B5B03D5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5ynAcACgkQcqXauRfM
H+DerQ//e63nMw490wsP2rH3qG1Hsar7ebbs2YMI8zmytRhZ8x4e68HD1EWJHWlX
0b0XiVTJe2Rbe4J/UVs3IfzJPKixE8x9T2j0WlHGJwg2tYwJSCdMSWiy61tf8yMh
eiTGRJ+k5KCsRDTIjs1GxtDVQE2gnFYdNBcXnjR/hsCt7t0L9Pd1OTQTgFVtQR4I
SAHAA4mKIWF0xQZzDDPN4fCwKbYK7aoDvWgRS7yYUawapevTmf115eO+A955upxv
y/2C1SrZ/wW9BTon94DJEUFtB9M6B+Bc9NBQmAKU5TOb22VcxEklwAKLsgmcgRBX
u+Fx9ojxkfAj1jTn3mzKkfYNOgn/d7oxJHbfFs8KvjHImdtwdqmhbwYebRsr7+WO
zUkLuG9kPEz0XLT+8/ZitUq0W4GsV23lMupU/kIvrI7KteQDgDV8su3vSsALh/lN
LNEtc2OU6wdQ3VwUaMGjErTp4P2zpAww2rlluibvgtITsEcWyxoLVwbC9OWicDZH
iqtQcHH/hva2+0YDyyvw7WubsklKL5OjeDa65IQq9PwZMM/PtWtRoZaVav9OpAD1
cmlolnWCPFqXEQpvzTaq7tCI0AUpS8Bqcyufp39rklam4foX3L4re+az06x47R1m
u+W/yzM+A5xHMOTmVC5JJiaeKPtVz70KWjCkvTVd0fBAPSP8QLY=
=KXoF
-----END PGP SIGNATURE-----

--Apple-Mail=_AF7EAAC6-8BA4-4AF3-8E33-9E2F1B5B03D5--
