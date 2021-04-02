Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A79352725
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Apr 2021 09:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbhDBH6f (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Apr 2021 03:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbhDBH6e (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Apr 2021 03:58:34 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DB2C0613E6
        for <linux-ext4@vger.kernel.org>; Fri,  2 Apr 2021 00:58:33 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v8so2189482plz.10
        for <linux-ext4@vger.kernel.org>; Fri, 02 Apr 2021 00:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=gpCMzVdWbrHuasE6eRXY7/GQNXSossxKf/i91VgAGG0=;
        b=ZPmhidweTgdFClEGVrlQzth8MmfgDmY+lWEgEkeBpWR2N25iDzNn13Q7BNjjbiTAbZ
         6UeZ+CPHx38xcIQKy7W5MMHUtV3JqltFDo+tFt8rEKXlbLQEGqIWIkVhuE8CPQMFUm83
         5At/vJTOFTrvzbIOgGy2WT3U/p/PmC1rfas0xRl5wN/4nzpt3w6xMgO8nTdN757lvZLa
         SzrZt2FnwN0ry/jM25Mi2LZFWO9fZhD+CPr11ftHMrlBqA1mgZunwW+5a+yj3Jz4Unib
         5ndPvGDEO9xk6aXTmozFxx/GjXJOwggYN0TtOInZevKrz+Wa1WOjwfkUAho5m7Qx8dZB
         hgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=gpCMzVdWbrHuasE6eRXY7/GQNXSossxKf/i91VgAGG0=;
        b=hoD9QfNr9Tz8XUajhNsdsDeasQwdLM96poYx8fd8/YyrjxRmFuziqN9NQ4thtfyL7y
         x4BBFTicDiBNaBzH5o06Ozo1kci6DvGJG2GzPXzLMG3QgjMIsLTfM3YbWBV6N2P0HHaY
         DXvwaXlk0elORhYE9sLc+N9RhukgLOG96yKC3cLo5r0/tZTM6ciM3uVRHa9vzwYaQ4un
         clyAUDCOxrIsqd90U/99cPrzh/UVEUpz7IfAcZiDNA7s582Jv0QtqEyx66i6nVag5914
         sdL1yJduSc0FGo0/gMVsBFvpqt+wJGZXihKQaY7N6oSmkJk4kR1s3CLznAdevNwHxERB
         pTWw==
X-Gm-Message-State: AOAM530j0kKbsbeAbAVWL6a3zRnQ+WreJ3GkUUt6BpaXF6Me/o6xktmi
        loa+1peJprUdtRsdoSab2PKw+P/ZNQrnD0pj
X-Google-Smtp-Source: ABdhPJyDTDx75F7nhurrUixrWzPV91rzxpt0mtkW+2UhRODJ9lTTQtg2YH0Wyp3+uIqb4SVh+V+gjw==
X-Received: by 2002:a17:90b:1490:: with SMTP id js16mr12343839pjb.131.1617350313426;
        Fri, 02 Apr 2021 00:58:33 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id w7sm2760095pff.208.2021.04.02.00.58.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Apr 2021 00:58:32 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <C68A6772-93DE-49E4-8C33-0AF480B4DC3F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_A73C6F95-DB40-4964-B1F2-A7E2D3067B9E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: fix error code in ext4_commit_super
Date:   Fri, 2 Apr 2021 01:58:29 -0600
In-Reply-To: <000801d72770$d3f4b890$7bde29b0$@vivo.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     changfengnan@vivo.com
References: <20210329035800.648-1-changfengnan@vivo.com>
 <000801d72770$d3f4b890$7bde29b0$@vivo.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_A73C6F95-DB40-4964-B1F2-A7E2D3067B9E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Apr 1, 2021, at 9:32 PM, <changfengnan@vivo.com> =
<changfengnan@vivo.com> wrote:
>=20
> Is there any problem with this patch? I did not see a reply, please =
let me
> know if there is a problem. Thanks

It's only been a few days since the patch was first posted, so nobody =
has
had a chance to review it yet.  The patch looks "obviously correct" at
first glance, but often changing code is not as obvious as first =
expected.
Also, is "-EINVAL" the best code here?  For "block_device_ejected()" it
might be more clear to return "-ENODEV" so that it prints "No such =
device"
instead of "Invalid argument" in userspace.

> =E5=8F=91=E4=BB=B6=E4=BA=BA: Fengnan Chang <changfengnan@vivo.com>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2021=E5=B9=B43=E6=9C=8829=E6=97=A5=
 11:58
> =E6=94=B6=E4=BB=B6=E4=BA=BA: tytso@mit.edu; adilger.kernel@dilger.ca; =
linux-ext4@vger.kernel.org
>=20
> We should set the error code when ext4_commit_super check argument =
failed.

It would be useful if this also described how this problem was hit, or
what caused this issue to be seen/fixed.  "Found while reviewing code"
is OK, if that is the case, or "crashed during mount when ejecting a
floppy disk", or whatever.  That makes it more clear how important the
bug fix is to be landed and backported.

It would also be useful to include a "Fixes:" label to show which patch
caused the problem, and help decide which stable kernels need this =
patch.
=46rom running "git blame fs/ext4/super.c" appears that commit =
2d01ddc86606
("ext4: save error info to sb through journal if available") introduced
the problem, but it seems like that patch only copied it from older =
code.
However, further digging shows commit c4be0c1dc4cdc ("filesystem freeze:
add error handling of write_super_lockfs/unlockfs") added this =
particular
code (error =3D 0; return error).  Before that time, no error was =
returned
from this function at all, so the commit message should include:

Fixes: c4be0c1dc4cdc ("filesystem freeze: add error handling of =
write_super_lockfs/unlockfs")

Cheers, Andreas

> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
> ---
> fs/ext4/super.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c index
> 03373471131c..5440b8ff86a8 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5501,7 +5501,7 @@ static int ext4_commit_super(struct super_block =
*sb,
> int sync)
> 	int error =3D 0;
>=20
> 	if (!sbh || block_device_ejected(sb))
> -		return error;
> +		return -EINVAL;
>=20
> 	/*
> 	 * If the file system is mounted read-only, don't update the
> --
> 2.29.0
>=20
>=20
>=20


Cheers, Andreas






--Apple-Mail=_A73C6F95-DB40-4964-B1F2-A7E2D3067B9E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmBmzqYACgkQcqXauRfM
H+B3MRAAmeCTB5/V2hxFbg4+Idq7wokrp1EQQcCPAyO98d81lS6tK06cz1cteAAL
vF22qfIH/SfHcCmUO9BhB0EHDesWfSCREzxA4FpLijJAY43G2RXuDXMGWsELJAxQ
Pi9tAO/+veZzy/zbLPH9oFE95RR4CEQV8qpS9hgjt8qYKe/1zRHnrZXpreaDhdfx
wvbGEG3nxolgJSLl7EIMiX7mK+zrbIjRWXw8GGS1t/sXuNevWmHhkpGwedHnl/Um
xftDU9k9e1lTu+4P04aZDWYCZzqfgfKq2zJCRqVXAo8Paj5hmGBZ6dahEBvNJOCq
DASxgaXIf3Q8pJHGsg6sfoV2AUPMKXeFakUYW5AZRS1axFKDiab9T8KpfeGnxvv5
jjSi2GRLXj5XXMdMDI0xTD25qHE7jBgLAqrGIfKgkequT/JSWON06OVflGd+2I1J
8L0mYSxHljVsuzfiza2EQxCZKj2Qh6uOQ5UHb8yRpgVCKojicFQRX6il7P/8/Bv3
3f8o25i9AcDXx8TdkDVWfamQUzh3Ox2mUFQpRnXHPfeKbi5vjeEPLyU3iQ1ydG8d
HUuNNvaiWwnIzmktg++Hzetbaadj1UVJsbG9Y9WGpaGezCjPYvcD1FXSAkIepAtn
QUSJv0boAcQGd/CEvxvSRjPz/yWNCum/qx/XoASlxcNaQ9uis9o=
=fr+K
-----END PGP SIGNATURE-----

--Apple-Mail=_A73C6F95-DB40-4964-B1F2-A7E2D3067B9E--
