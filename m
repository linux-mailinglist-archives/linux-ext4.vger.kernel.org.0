Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9867C1C6078
	for <lists+linux-ext4@lfdr.de>; Tue,  5 May 2020 20:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgEESvD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 May 2020 14:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbgEESvD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 May 2020 14:51:03 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC845C061A0F
        for <linux-ext4@vger.kernel.org>; Tue,  5 May 2020 11:51:02 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t16so1193708plo.7
        for <linux-ext4@vger.kernel.org>; Tue, 05 May 2020 11:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=m0biPtljwd17SXU4/ykUmFZD5rj5n19P6bLx4Aanu70=;
        b=X/1+rJj5HbxUDQ7CQ2x2eP0K87bsBbKcasXBK5DLiquCo68mn8xwOwSQw/dVfroQ/3
         T00RII4b6Lq03ppPihb6Mdyo0naD3Hu0Fga+qvf8tTycgn+Ah+iBo7515qRKFCfqqJ0c
         gcUvCpuRwTVmn+N1EypMe1yPn2TsI8g3CSmnVCBkO+B8JNvb+VIaBNpOr7qdVXxxanUS
         SjEaQwya+FbRLkEa/l0vUUxWaeRdGvccfmDW7SUv2txRyTbUDPogqbz6PcUac5cN1e9a
         K5LPsZ/8XpHF+ytSpbOPMzTJ0j4/Uxj4JlgL1gnSbbgpGE1vEFhY5NkzEqmqX+vlTlnc
         Ko9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=m0biPtljwd17SXU4/ykUmFZD5rj5n19P6bLx4Aanu70=;
        b=e7GXhdaTyTbOTP2Md1CNs3XniFiKxbJ72tD0c2FE0YZ1xN2KLZ2Yc3t1qhxgzTDP/q
         Z79M/UCshXMqpzqHpg4bBOxYPIQ2qNbMv16JdnGt3s8StB+eyf9iJyYDwUpf5W0fcP2z
         s0i6tFoSKfQLYQzG2isqHLnBrI4i/yuP+F/XF29z4PwnI7ld5AUqirGDQNVh57NbWWt8
         /3hafZDNq1SqrH6NU7IqB/0LjgtMbTUnD2uvjRzHb9C9QSf+NWVAaj8VgW3KvuNIUE1X
         wUp4BUWmyQSHeYUuCndHHOOwQj13ko+GrAkVIvpLN4XbI8MTNqxZfJebp58HJGv/HsRW
         qROA==
X-Gm-Message-State: AGi0PuYxCS+pa5GglNmZWG8Ea5scwQsekUmh/U3xerLqd5psUxhdl7xZ
        aQU4deARY9g1Xrf3a5uc+EE4cBjwNeOFchFx
X-Google-Smtp-Source: APiQypK3JYp10mus8i7Dr6EdJKBVqH7EBeniUy8iZ9ZtXLAdQxgQsGxD6R/fjPStvLanQumDSiUitA==
X-Received: by 2002:a17:902:ac89:: with SMTP id h9mr4456753plr.266.1588704662273;
        Tue, 05 May 2020 11:51:02 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id o9sm2637257pjp.4.2020.05.05.11.51.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 11:51:01 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <1AB6A7B0-245F-4951-A2BC-E6EA1495D505@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_4F7F1D8D-16D2-475B-938A-22C6114C710E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: /fs/ext4/namei.c ext4_find_dest_de()
Date:   Tue, 5 May 2020 12:50:56 -0600
In-Reply-To: <f1d8d13f-1605-a19c-e75c-1ecdb8c42fcf@jguk.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
To:     Jonny Grant <jg@jguk.org>
References: <2edc7d6a-289e-57ad-baf1-477dc240474d@jguk.org>
 <20200504015122.GB404484@mit.edu>
 <b518357b-4c79-910a-94dc-b6f0125309bc@jguk.org>
 <20200504195255.GC404484@mit.edu>
 <f1d8d13f-1605-a19c-e75c-1ecdb8c42fcf@jguk.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_4F7F1D8D-16D2-475B-938A-22C6114C710E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On May 5, 2020, at 12:07 PM, Jonny Grant <jg@jguk.org> wrote:
> On 04/05/2020 20:52, Theodore Y. Ts'o wrote:
>> On Mon, May 04, 2020 at 08:38:33AM +0100, Jonny Grant wrote:
>>>>> I noticed that mkdir() returns EEXIST if a directory already =
exists.
>>>>> strerror(EEXIST) text is "File exists"
>>>>>=20
>>>>> Can ext4_find_dest_de() be amended to return EISDIR if a directory =
already
>>>>> exists? This will make the error message clearer.
>>>>=20
>>>> No; this will confuse potentially a large number of existing =
programs.
>>>> Also, the current behavior is required by POSIX and the Single Unix
>>>> Specification standards.
>>>>=20
>>>> 	https://pubs.opengroup.org/onlinepubs/009695399/
>>>>=20
>>> Is it likely POSIX would introduce this change? It's a shame we're =
still
>>> constrained by old standards (SVr4, BSD), but it's fine if they can =
be
>>> updated.
>> No, because it has the potential to break existing =
Unix/Linux/Posix-compliant
>> programs.  There may very well be C programs doing the following....
>> 	   if (mkdir(filename) < 0) {
>> 	   	if (errno !=3D EEXIST) {
>> 			perror(filename);
>> 			exit(1);
>> 		}
>> 	}
>> For example, there may very well be implementations of "mkdir -p" =
that
>> do precisely this.
>> If we change the error returned by the mkdir system call as you
>> propose, it would break these innocent, unsuspecting programs.  =
That's
>> not something which will be allowed, because it falls into the
>> category of a Bad Thing.
>=20
> Thank you for your reply.
>=20
> What's an appropriate solution to this problem?
>=20
> To achieve the desired output. when a directory exists.
>=20
> $ mkdir test
> $ mkdir: cannot create directory =E2=80=98test=E2=80=99: Is a =
directory

I don't think it is reasonable to change the EEXIST return code just
to make you happy.  However, it may be within your purview to change
the mkdir(1) code to improve the error message:

	rc =3D mkdir(name, mode);
	if (rc < 0) {
		if (errno =3D=3D EEXIST)
			errmsg =3D _("File or directory already =
exists");
                else
                        errmsg =3D strerror(errno);
		fprintf(stderr, "%s: cannot create directory '%s': =
%s\n",
			progname, name, errmsg);
        }

or whatever you want.  If you are really keen, you could try to change
the string that strerror(EEXIST) provides to be more generic, but that
may also break programs that parse the output of mkdir(1) for some =
reason.

I would *not* recommend to change this to stat() the target name to
determine the file type just to print the error message, as that is just
useless overhead, of which there is too much in GNU fileutils already.

On the flip side, what is the driver for making this change?  The =
existing
error message has been OK for users for 40 years already?

Cheers, Andreas






--Apple-Mail=_4F7F1D8D-16D2-475B-938A-22C6114C710E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl6xtZAACgkQcqXauRfM
H+AhMxAAlrCnqIndoKnLScNUllBTiQWoWhHA634cQPRfjmUOqFVP0YsmDz4AIQln
buWgichwWXO9UU/8tv7t95Ah5eaayn7TI2NSPrul9TIgJx6j4uBX39qSNwUqC5yC
Bft8otTk8kNSwQ0SE4xqoIeKlcGldvblfUjL72P/igJ0/Lvezd6dbOPD0OuSLhbI
NecJJiz+g+v5r10IEJVUCG1FX5PFGAKNKtmNo+Zpry0ow7pFe++UnGOdj166EhAS
luyT2W6nfCu9OmqmqaQikMI+0yiMBYXfO2jajz2jKj3uO5E0bFFP14mYXNaCIdYu
wuEF3DXOmMdRxWGrTObDaa2H4Ne8t+MV51YHshRcZ/lCCN3IygL8yxinSGaFNKe5
D/NA5j+Kuk6Opy1QSs2R0rPQ6zyiP1CSS8S9wMtBSVD8wQTOAGJ8+7UwMZtX1/KW
H8mkJJzRyrUPrFgGDVCOdSoP1XY6Cv6uP0+CKSZn/eWn8EVvov1leEZsOjtpF+vc
uE6R1JgIEcE2h/q8vzhF0VhlkPLwtHPt+NF9PKqSbWRhjfFDR4avlN46ACNBNen4
pFGVBLIPUECAln0lNcjUtkmVyZk8DBBzqVj0R9zaTWd8u4QiYdZ8QLlA3Xu0atQf
FVb4IzASSSd/232/Ibm4c7VnBqa7ZXmZQxT63Z5mOjy2rZU3v6w=
=x2D3
-----END PGP SIGNATURE-----

--Apple-Mail=_4F7F1D8D-16D2-475B-938A-22C6114C710E--
