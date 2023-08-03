Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C7276F5BF
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Aug 2023 00:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjHCWeH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 18:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHCWeH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 18:34:07 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC3235A8
        for <linux-ext4@vger.kernel.org>; Thu,  3 Aug 2023 15:34:05 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a38953c928so1140719b6e.1
        for <linux-ext4@vger.kernel.org>; Thu, 03 Aug 2023 15:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20221208.gappssmtp.com; s=20221208; t=1691102045; x=1691706845;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Il7sF5m7oHPCYbM1sIW0/Ql0c7lH57Ga/1AsJBYpWMk=;
        b=wxeR9Pee7rdbNHisS3bhVrmlEQu8BpPF+I66d0+CCBD+66bmQTprUZaGUaWh63vw2/
         WoMVb85QPXM9d0zBt8Nv2jSE7tsOeHVXWS37Ls+OPyJ5gk7K6UVXS2+wMIWBvBHqfe7M
         pNYnbe7M3N62Cw1rUUz/0M65jFStCKr9tWkAlb55bvnUVmoo+2t50/sgJ+sFR16aG1QD
         Sk4smJE3JOMt3LAIDf9i/Y6XEIphXtXv4nS9OZElctuCJsnXpUr6PCcudatomp0++/qZ
         MJxBsJrDApsCA4OoGjtT9AIIMDX/7WwB8QtIWs/wV32aCphX+omjP5b5E9CnSCkfXD3Z
         mIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691102045; x=1691706845;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Il7sF5m7oHPCYbM1sIW0/Ql0c7lH57Ga/1AsJBYpWMk=;
        b=cEsKWuwIUjitsN/+/+YGUtf/KkGQ3ZUFaFuc5UHe7g9pszR9nv/YkJip1QkqZBvq04
         5kskBl8CBtZtfVrAH2sQ0n7b4nEAi3dlJx7LPtnV2p0oHXBWS+DstGGnLwO59mnTBuQP
         djvGTBqkK7o3ceJ0lQyv80AHcencyiwyM4X+bl6TyvAPCYE41+5MhoWprOJwXpkd53yS
         g6bj/qOVirpUp92Bo88fIXsQe4Xx6AUWS47yHguZcvhfJDivTlJA6XChsRfgdk/LNf0o
         3m3D17Jd0mQhtfs75uHykgVxpJa2xCGrXXeETe1Z1xc7AW3+479JiI2ZfreDlv+CnODQ
         L9Zw==
X-Gm-Message-State: AOJu0YxM/ExCBd26+EVTlLt9i+nHtuLzShP7nYIqSS9lFgTt2zLF6QeU
        /wLUkZp3QNDFEpTxQw4EKToRCw==
X-Google-Smtp-Source: AGHT+IH+LHaygAelFy7PSG0dGkpYt99Q2zFOkLKufIdpZk7vjGLzunBz16NwVvHBtuiHLqlqoJQNBw==
X-Received: by 2002:a05:6358:8a7:b0:139:d5b9:87d3 with SMTP id m39-20020a05635808a700b00139d5b987d3mr62523rwj.5.1691102044911;
        Thu, 03 Aug 2023 15:34:04 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id a15-20020a63704f000000b005649cee408fsm316556pgn.0.2023.08.03.15.34.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Aug 2023 15:34:04 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <12CFFD6D-ED0E-4D36-A7B7-ACCFB698A177@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C8462E92-ED49-4BD8-8977-EF791E645AF1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3] ext4: Fix rec_len verify error
Date:   Thu, 3 Aug 2023 16:34:02 -0600
In-Reply-To: <20230803030903.GK11377@frogsfrogsfrogs>
Cc:     Stephen Zhang <starzhangzsd@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Zhang Yi <yi.zhang@huawei.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zhangshida@kylinos.cn, stable@kernel.org
To:     "Darrick J. Wong" <djwong@kernel.org>
References: <20230801112337.1856215-1-zhangshida@kylinos.cn>
 <20230801151828.GB11332@frogsfrogsfrogs>
 <A9ECDF14-95A1-4B1E-A815-4B6ABF4916C6@dilger.ca>
 <CANubcdUsDfiuGimNXjzoAF5ki8waCoFW31mg4vjpm073rS6+dw@mail.gmail.com>
 <20230803030903.GK11377@frogsfrogsfrogs>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_C8462E92-ED49-4BD8-8977-EF791E645AF1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Aug 2, 2023, at 9:09 PM, Darrick J. Wong <djwong@kernel.org> wrote:
>=20
> On Thu, Aug 03, 2023 at 09:52:53AM +0800, Stephen Zhang wrote:
>> Andreas Dilger <adilger@dilger.ca> =E4=BA=8E2023=E5=B9=B48=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=B8=89 14:07=E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> Not all of these cases are actual bugs.  The =
ext4_rec_len_from_disk()
>>> function is only different for rec_len >=3D 2^16, so if it is =
comparing
>>> rec_len against "12" or "sizeof(struct ...)" then the inequality =
will
>>> be correct regardless of how it is decoded.
>>>=20
>>> That said, it makes sense to use ext4_rec_len_from_disk() to access
>>> rec_len consistently throughout the code, since that avoids =
potential
>>> bugs in the future.  We know the code will eventually will be copied
>>> some place where rec_len >=3D 2^16 is actually important, and we may =
as
>>> well avoid that bug before it happens.
>>>=20
>>>=20
>>> One thing this discussion *does* expose is that =
ext4_rec_len_from_disk()
>>> is hard-coded at compile time to differentiate between PAGE_SIZE > =
64k
>>> and PAGE_SIZE =3D 4K, because it was never possible to have =
blocksize >
>>> PAGE_SIZE, so only ARM/PPC ever had filesystems with blocksize=3D64KiB=

>>> (and the Fujitsu Fugaku SPARC system with blocksize=3D256KiB).
>>>=20
>>> However, with the recent advent of the VM and IO layers allowing
>>> blocksize > PAGE_SIZE this function will need to be changed to allow
>>> the same on x86 PAGE_SIZE=3D4KiB systems.  Instead of checking
>>>=20
>>>  #if PAGE_SIZE >=3D 65536
>>>=20
>>> it should handle this based on the filesystem blocksize at runtime:
>>>=20
>>> static inline
>>> unsigned int ext4_rec_len_from_disk(__le16 dlen, unsigned blocksize)
>>> {
>>>        unsigned len =3D le16_to_cpu(dlen);
>>>=20
>>>        if (blocksize < 65536)
>>>                return len;
>>>=20
>>>        if (len =3D=3D EXT4_MAX_REC_LEN || len =3D=3D 0)
>>>                return blocksize;
>>>=20
>>>        return (len & 65532) | ((len & 3) << 16);
>>> }
>>>=20
>>> Strictly speaking, ((len & 65532) | ((len & 3) << 16) should equal =
"len"
>>> for any filesystem with blocksize < 65536, but IMHO it is more clear =
if
>>> the code is written this way.
>>>=20
>>> Similarly, the encoding needs to be changed to handle large records =
at
>>> runtime for when we eventually allow ext4 with blocksize > =
PAGE_SIZE.
>>>=20
>>> static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned =
blocksize)
>>> {
>>>        BUG_ON(len > blocksize);
>>>        BUG_ON(blocksize > (1 << 18));
>>>        BUG_ON(len & 3);
>>>=20
>>>        if (len < 65536) /* always true for blocksize < 65536 */
>>>                return cpu_to_le16(len);
>>>=20
>>>        if (len =3D=3D blocksize) {
>>>                if (blocksize =3D=3D 65536)
>>>                        return cpu_to_le16(EXT4_MAX_REC_LEN);
>>>=20
>>>                return cpu_to_le16(0);
>>>        }
>>>=20
>>>        return cpu_to_le16((len & 65532) | ((len >> 16) & 3));
>>> }
>>>=20
>>=20
>> Hmm, at least it sounds reasonable to me based on my limited
>> knowledge. However, I am not sure whether you want me to incorporate
>> these changes into this particular commit or another patch within =
this
>> submission.
>>=20
>> By default, I will simply leave it for further discussion. Please let
>> me know if you have any ideas.
>=20
> ext4 doesn't support blocksize > PAGE_SIZE yet.  Don't worry about =
this
> for now.

I agree it doesn't need to be merged into the current patch.

It's something that could be fixed in a follow-on patch, to have one =
less
bug to fix in the future when ext4 *does* support blocksize > PAGE_SIZE,
which isn't so far away anymore.

Cheers, Andreas






--Apple-Mail=_C8462E92-ED49-4BD8-8977-EF791E645AF1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmTMK1oACgkQcqXauRfM
H+A7sBAAhXmLZ/oDD73vpfMHTdJmdWe0rB/SirU1fQ/f7WZsmyMqMN9gqMI7Fhpq
sxjn2ML1P9cLUgyjTCf5usJ743ewZX77Jv8y0+J3T6yd5/aFB0e4rqHR9coxN4L9
sO/3j9r0f+ZPJ4Wl7QHlPr2COjAAEDz0O4KtSKMk/+doGvsitB2oiB9x8Vj/BPBD
xU6a8OjmLotHzpR99pgVYb1whGTUeG5tFQTPBxAj9NBPQ3mr5wYZ5TfdkOtgpDAh
DeuKWGc6X1ByrLajuwybSTlxpNcKZr5aOmNuVPPkydBT89U6GdKXtCNYO6KS6ri0
Zv6LCPeL0A/cVApQ9KXLwJv6ckqMXnjJPoQZ7gceiSNR9kd0kTMGODPyITlo2pM5
CAcT778lWGWKiC6QyS/iewFXgrcaAyURclIwnckIrgzcEBvP6BLDkQXtQXeCx5D3
UIwM+MDHec0dTQXt25hVNr5sT6VUWVXGBJVCNt+cPhM5TIqecEYGYHuLS5p+AQhY
9VF2lisZTuUz/MThYGyzWY7j/kJfFYP1C3aN18VeA5xKLG8I7tHTC1ToWMIgrRk2
ci5kRUhbpL0ofioFSLSKN/kMNPJqlGoYps3KnC6nLnmlojwRUh9xp/VnxXBO44jd
gcTPcxOHAR09OiyQqkGMgq78+7zv05VMAIRKmySgpkbWxN1bWdo=
=1rAp
-----END PGP SIGNATURE-----

--Apple-Mail=_C8462E92-ED49-4BD8-8977-EF791E645AF1--
