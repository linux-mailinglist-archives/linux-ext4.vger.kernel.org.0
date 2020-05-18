Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573F21D6F87
	for <lists+linux-ext4@lfdr.de>; Mon, 18 May 2020 06:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgEREB1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 May 2020 00:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgEREB1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 May 2020 00:01:27 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBD1C061A0C
        for <linux-ext4@vger.kernel.org>; Sun, 17 May 2020 21:01:27 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 23so4337476pfy.8
        for <linux-ext4@vger.kernel.org>; Sun, 17 May 2020 21:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=oSM6k6MPYHg8TaOQL2KcO2tWU/vza68MG2sHoYScApo=;
        b=sC/mbmrK5Myvy4PPXL6gso7xOZ0iUmcLpfmikyWfhPGCaUb5B2/Zt6zCW4cWx/eFiF
         2rbCdvH7fexB1usl79Yk9aWNJ2GrLXmd8KhEa8/3td65gaZng2sqjPNrRa6387DoqE5U
         XNu+In20BelURjdn6IBOL3s2H88KEllp4Or2hDCUfoqApGlq6Zzp5KVPBXNRjZU7QLRm
         8pFt1usMrDvA9LmO5v5dPcwvciEn8U4gMIJO7dFNUNa1ulaROvrzddEri5r6wu8ac89W
         eRnLn+6jir5sLHphePNNd5Fo7wG2s9Xou75FsjlYyn34imoAeJ/7/s+9o+G61OKemLmi
         tH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=oSM6k6MPYHg8TaOQL2KcO2tWU/vza68MG2sHoYScApo=;
        b=OsIYpBNqa9qYIuSI4NZJXk9TRwDcyn4KuliPH4zPmgI8YnPedGfFgCGNt8SJKMXR56
         kGvrDsZrB1KcsnukFDvJxULsTLfMWV2tqw1FYi3Cc93BcwWlE32w8k+6OFnU3xNFTUYB
         b/4GEMVADsYcscqhAjy7e/w2v66GW5VBb8pBoCO8Ue5eF8ZRho0/8B8WVAZJOOtRh+xU
         1XHet78ldKzYxpbVzLF+z2vfHRlhuocZtd8lcNtOY6ZfVBLSMjvRHMM3e/9UslGVzzVb
         TdPlfGUyb2ImY+cjKNm7rO37hg0wWppqysGvW7dUsx7toEviUxr6/xGGBocKRY4LTS2j
         MFqw==
X-Gm-Message-State: AOAM53144Jz0VgB2UIKO1oxyVqAdr3VynZuOiN7kK3MssNkFRQtnKqZN
        qLTFKd1/H0HjmQUAGqMtNMGSHprSRggVwQ==
X-Google-Smtp-Source: ABdhPJzcAtPNRDpk+geG+5yQ4CTgFTxQTRFCiIoS4+yWm4Wb8B6uguaTgzghpfgYq1DcH6pW22p73g==
X-Received: by 2002:a63:1845:: with SMTP id 5mr13250781pgy.69.1589774486450;
        Sun, 17 May 2020 21:01:26 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id h4sm6599383pfo.3.2020.05.17.21.01.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 May 2020 21:01:25 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <5D529C63-44EA-4E49-9052-00B5FF97117C@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_DF1BEA4B-CDBB-4730-BA40-9E12FE537C71";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] /fs/ext4/ext4.h add a comment to ext4_dir_entry_2
Date:   Sun, 17 May 2020 22:01:22 -0600
In-Reply-To: <d7f22961-2fb2-d69a-28cc-073b735c6907@jguk.org>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Jonny Grant <jg@jguk.org>
References: <5b9bc322-fe02-72cc-9aa7-a27b26894ce0@jguk.org>
 <3DF89355-488D-47F5-857B-3B75D4E89AD3@dilger.ca>
 <d7f22961-2fb2-d69a-28cc-073b735c6907@jguk.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_DF1BEA4B-CDBB-4730-BA40-9E12FE537C71
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 17, 2020, at 4:39 PM, Jonny Grant <jg@jguk.org> wrote:
>=20
>=20
>=20
> On 11/05/2020 21:19, Andreas Dilger wrote:
>> On May 8, 2020, at 2:36 PM, Jonny Grant <jg@jguk.org> wrote:
>>>=20
>>> Please find attached patch for review.
>>>=20
>>> 2020-05-08  Jonny Grant  <jg@jguk.org>
>>>=20
>>> 	tests: comment ext4_dir_entry_2 file_type member
>>>=20
>>> Cheers, Jonny
>>>=20
>> Hi Jonny,
>> thanks for your patch.  The patch itself looks reasonable, but can
>> you please submit it as inline text next time.  To avoid issues with
>> whitespace formatting, you can use "git send-email" directly from
>> the command-line after making a commit with this change in it.
>> Also, the subject line of the patch should just have "ext4:" as the
>> subsystem, you don't need the whole pathname for the file, like:
>>     ext4: add comment for ext4_dir_entry_2 file_type member
>> Finally, you should add a line:
>>     Signed-off-by: Jonny Grant <jg@jguk.org>
>> to indicate that you wrote the patch and you are OK with others using =
it.
>> See Documentation/process/submitting-patches.rst for full details.
>> Cheers, Andreas
>=20
>=20
> Many thanks for your reply Andreas. I will follow your that patch =
guide, thank you for the link.
>=20
> Could I check, did you submit, or shall I submit via git send-email ?

I didn't submit it.  Best if you do so with the appropriate changes.

Cheers, Andreas






--Apple-Mail=_DF1BEA4B-CDBB-4730-BA40-9E12FE537C71
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl7CCJMACgkQcqXauRfM
H+AhBA//Xo7Ny+Ha+WDsj8XB0N2/HRlR8uChE2UWaaYhycKvNcWRD3AC4d7inng4
QXXffPiH0B+GDOa0fDskEqxbaExDsryjAiUMw4jPwhGCKk3kxZpmfqafp+RQxpAY
nd4TtjuKH91pfvzh8xWxJRwhU/fHJdNtSXoSPtpt+9WUPbjkVUurdEOtkaH0Z2U3
+4feC8cCU0BLPkqW+ROcpslgE3mzZRMA/wiy9vHPS+o0WTIwbyhp3lfd+fQ8c8M9
YMC+10c2/f5p2VjBrMwTQUvyypboROSO9w0rFUTIMfxBghnF4U/3Z1T6J0CXNjaS
IuYKwcIzzI2a6fhJmOyJYpCrgc8HovxFrFO13NjucHbX/hAnj1dfpeEyjqK/9SUR
BSwiFb6jBkoOJWacQQbdnC9qqwD3uKU6tEtNgZK1f8Xp4a5wgVZLoAgBgvIStsoq
C1hTuTwcNe4NIElAeQwO1DWiJxHUs5H8elimCHFsrU77JJsATdGmx4VRiYLZ5wt/
FqulXV3AOzwGLWSAiSd9/RR6gRX4VoeBAjJGJH/Qb2mVo9F96qtpddKnPY9ZK8BH
wGLEOher994+ZEuW0h0MOmQj18GnINQJ0FeZ+s7Q0syvfkhbGRWOyW87cYGNvDLt
V1mh9QC0IGPvcq62XUBVML7uh6QntyKZPlsaTTQMVQVddFwQnTw=
=An3B
-----END PGP SIGNATURE-----

--Apple-Mail=_DF1BEA4B-CDBB-4730-BA40-9E12FE537C71--
