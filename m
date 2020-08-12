Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A952A242F6B
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Aug 2020 21:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgHLTgP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Aug 2020 15:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgHLTgP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Aug 2020 15:36:15 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5167AC061383
        for <linux-ext4@vger.kernel.org>; Wed, 12 Aug 2020 12:36:15 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id l60so1633366pjb.3
        for <linux-ext4@vger.kernel.org>; Wed, 12 Aug 2020 12:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=qF083KBLV8usb2cBgAHxfO4POcfb7xqP3KHR5T5OhZg=;
        b=wwtXCf/fxsux83EVdcsLvJ73jD+FsHpotkfNXY0VeB3iFIg0JQ756/fWUMSmPNRfgK
         Gq2sWFkly8/n4VKicy3rwmUWgwt9GOlSUpZdyuonKlCowAy8GmEY+D9cxsQndhUo13wV
         G8HZ7TXCSAEpp5i4q/P+a31dqHV5LlMIyI6WvWGgcxSFwaUdY88wMjLbAONh5+DbxK0k
         ufCkyQZ4WMSpXHQ8IW37oTGvTb3HFf3gRUl1TaBHJwfeqa0whQb/tAeBpwP0qLBku80F
         ULpzdKLveXveJAAEzrbVx+i/zQCUj3Ip2LdHIbCDMC8pwd0xndDBQ7EsM1fY1dxI4Ae7
         CPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=qF083KBLV8usb2cBgAHxfO4POcfb7xqP3KHR5T5OhZg=;
        b=pyDrNteZZAYZvTmDY2sJQ/4OVPBezJ6j8/aePz/m6J/nxP/KLXr/tjWewAGeWColr4
         Tq4kxXhwMRPTKgTCnrpxrcE/0l+fRGMm3nQaQOxzk76hf4nsbU7M7Klh0sygHELYpJuh
         DNOADgcQ88hLBm/qjHYYdGpTfdIg2h/atcX0QYWI8dC0HSo8tdBAnAh7lG88ER/2mjjz
         TtpBtfLMBQ6NtKkwbVvt5KzwLiGp7FGvibEM+BPlSPFyq4yilop5dqTcG8y8HvRdOXFP
         w6Cf0z9uqPlPIVU4Z3QC55Tm5+BoywIYggsIx6DdbZHuqEYc5/DxOe3bJE8D43l8l7id
         yZCA==
X-Gm-Message-State: AOAM532TB0dcfvZW7q7ktqAf4zVso0xXwKWWNo8bH9Hktuaqk3NLCIK1
        Nedtg0DhTj0tjJvzUVsavj1aBA==
X-Google-Smtp-Source: ABdhPJzOHYqNdCJ44HkgOQIPOViViCQnoCam2XbQXVWkeW1I/fdUzogakf+bDgUyGl4i2tY6Hae0Tw==
X-Received: by 2002:a17:902:7205:: with SMTP id ba5mr813971plb.230.1597260974774;
        Wed, 12 Aug 2020 12:36:14 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id a6sm3025660pje.8.2020.08.12.12.36.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2020 12:36:13 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <8A79C6DA-5C0F-4B4F-9EEE-E272993AD0FC@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_8ECA6D81-89C8-4F81-8EA4-7D1B55830A09";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: fix log printing of ext4_mb_regular_allocator()
Date:   Wed, 12 Aug 2020 13:36:08 -0600
In-Reply-To: <131a608b-0c8a-1a2d-57ee-4263cfcdd5a2@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
References: <131a608b-0c8a-1a2d-57ee-4263cfcdd5a2@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_8ECA6D81-89C8-4F81-8EA4-7D1B55830A09
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Aug 7, 2020, at 8:01 AM, brookxu <brookxu.cn@gmail.com> wrote:
>=20
> Fix log printing of ext4_mb_regular_allocator()=EF=BC=8Cit may be an
> unintentional behavior.
>=20
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

The debug message would probably be more useful if it included some
actual information (PID, status, fe_group, fe_start, fe_len), but
that isn't necessarily a problem with this patch itself.

Reviewed-by: Andreas Dilger <adilger@diger.ca>


> ---
> fs/ext4/mballoc.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 5d4a1be..b0da525 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2324,15 +2324,14 @@ static int ext4_mb_good_group_nolock(struct =
ext4_allocation_context *ac,
> 		 * We've been searching too long. Let's try to allocate
> 		 * the best chunk we've found so far
> 		 */
> -
> 		ext4_mb_try_best_found(ac, &e4b);
> 		if (ac->ac_status !=3D AC_STATUS_FOUND) {
> 			/*
> 			 * Someone more lucky has already allocated it.
> 			 * The only thing we can do is just take first
> 			 * found block(s)
> -			printk(KERN_DEBUG "EXT4-fs: someone won our =
chunk\n");
> 			 */
> +			mb_debug(sb, "EXT4-fs: someone won our =
chunk\n");
> 			ac->ac_b_ex.fe_group =3D 0;
> 			ac->ac_b_ex.fe_start =3D 0;
> 			ac->ac_b_ex.fe_len =3D 0;
> --
> 1.8.3.1


Cheers, Andreas






--Apple-Mail=_8ECA6D81-89C8-4F81-8EA4-7D1B55830A09
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl80RKgACgkQcqXauRfM
H+CCPhAAlCchW92sNG3fhRqE5jqNi2Wl7sUe1mfZzMHj9xdpTTDhFtF9acusQYi0
CkVQovCazH+z2vWOM+2Vp3IrLaVk0QD4+4fd72zS5MamsSv7mnNe+Ku/a8LdUBcl
hkpRPdZiL5XxJ5FetkhgFABoX9Ab8b1zpbxUsmskX3nl4WkrE9POrcX/5o1YvDNE
U4+N6oDnhDWOG9WR/VZRIw+RQjjyPUKSKeeZWE0F7Cfdzmaja9zF7ca8svVy5xQI
ozytCbFFsqbaw9uyRHEZDEqEaC8ePE2HNX2zgWf6XyyGLZutnIYmySIVX6BF9pbH
+PbuzPin2PSEc419oiqxbAvx9uomGT56I3DyD0vmfsZ24+Z9V/jdhILtm1RFa2LG
E30s3bmu4hzpgGYmKOFlEsZjYTPWafP9y5UK2hykpsH/79zVJEhwqvmhBg2P9Zdd
0DrRwjWZ515dZgieOdLoa56c3X+R0OQig1ESIh1zpEN/SY1J0C/vVeDGZLL5/T39
MlPpzLZVwzOlFq6VMXV5SXlYCGhxucKjnZG1Ou8DQolDF2SEC9y3PizAA3mW5QTM
41fF/De9d52asdWtcCWwomeNxxUEQPjO/CZzRzRqMYICSCjhLS+7ceVq4XeQA0zY
P07Oo/Pa+TY5JKMbNxlfB+JvGqUDzJjslEO0oAMNDJRFibuEYFo=
=br5h
-----END PGP SIGNATURE-----

--Apple-Mail=_8ECA6D81-89C8-4F81-8EA4-7D1B55830A09--
