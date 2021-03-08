Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096D733105C
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Mar 2021 15:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCHOFz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Mar 2021 09:05:55 -0500
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:35720 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhCHOFp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Mar 2021 09:05:45 -0500
Received: from [192.168.111.113] (p4fd97bae.dip0.t-ipconnect.de [79.217.123.174])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.1/8.16.1) with ESMTPSA id 128E5YG9001571
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Mon, 8 Mar 2021 15:05:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1615212334;
        bh=zRi/ax+YMjPGtr1+UjlQMw8tthe6i1Knja7s0lBnSts=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To;
        b=K5LrqzYxFf61VDYBx7jLF7mA6lAhQUBFWasEdgnF1c8hmDT0zCqar/epfxhslAR7N
         UALpcQbAaiA1JZFXa5sa5xqZeBGuzBmG+ZqiD56U8lynNW6DpPGNPI8MFx5Y6mDUtW
         PK7fmEEhwfxTWOcH0Zq8+Lgbb9UiF1IMf8l3q2I4=
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f63dd495-defb-adc4-aa91-6aacd7f441c7@tu-dortmund.de>
 <a4709bc4-ee62-2cdc-0628-32e8fa73e8f9@tu-dortmund.de>
 <YEJLuP6+Zy8/dq+D@mit.edu>
 <667b3ec3-a522-05a9-31e8-87d8bfaa7adb@tu-dortmund.de>
 <YEJWiXaZ+9H+2nBx@mit.edu>
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Subject: Re: [RFC] inode.i_opflags - Usage of two different locking schemes
Message-ID: <0f387f5b-a516-af45-856d-f38d1adfadf5@tu-dortmund.de>
Date:   Mon, 8 Mar 2021 15:05:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEJWiXaZ+9H+2nBx@mit.edu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ttm8mGlNMVfe7nbCbsCMw4KHu2VqQcARX"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ttm8mGlNMVfe7nbCbsCMw4KHu2VqQcARX
Content-Type: multipart/mixed; boundary="YjAJKbPSRDIAWGreUOUzkTD1cIcg201Xm";
 protected-headers="v1"
From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
 Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <0f387f5b-a516-af45-856d-f38d1adfadf5@tu-dortmund.de>
Subject: Re: [RFC] inode.i_opflags - Usage of two different locking schemes
References: <f63dd495-defb-adc4-aa91-6aacd7f441c7@tu-dortmund.de>
 <a4709bc4-ee62-2cdc-0628-32e8fa73e8f9@tu-dortmund.de>
 <YEJLuP6+Zy8/dq+D@mit.edu>
 <667b3ec3-a522-05a9-31e8-87d8bfaa7adb@tu-dortmund.de>
 <YEJWiXaZ+9H+2nBx@mit.edu>
In-Reply-To: <YEJWiXaZ+9H+2nBx@mit.edu>

--YjAJKbPSRDIAWGreUOUzkTD1cIcg201Xm
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 05.03.21 17:04, Theodore Ts'o wrote:
> On Fri, Mar 05, 2021 at 04:35:47PM +0100, Alexander Lochmann wrote:
>>
>>
>> On 05.03.21 16:18, Theodore Ts'o wrote:
>>> 1)  I don't see where i_opflags is being read in ipc/mqueue.c at all,=

>>> either with or without i_rwsem.
>>>
>> It is read in fs/dcache.c
>=20
> So why is this unique to the mqueue inode then?  It might be helpful
> to have explicit call stacks in the e-mail, in text form, when you
> resend to LKML.
It is unique to mqeue inode, because the control flow goes through=20
ipc/mqueue.c where almost always the i_rwsem is taken.
Hence, we see more memory accesses to an mqueue inode with the i_rwsem.
The i_lock is less often hold compared to the i_rwsem.
We conclude the i_rwsem is needed. So it might not be a contradiction at =

all. It rather could be a flaw in our approach. :-/

Besides from our current discussion:
Does the i_lock protect i_opflags for both reading and writing?

Cheers,
Alex

>=20
> That's because the HTML file is ***huge*** (1.7Meg), and I'm having
> trouble with my browser properly rendering it.  In any case, the html
> claims to be showing the counter examples and I'm still stuck on the
> *example*?
>=20
> Cheers,
>=20
> 					- Ted
>=20

--=20
Technische Universit=C3=A4t Dortmund
Alexander Lochmann                PGP key: 0xBC3EF6FD
Otto-Hahn-Str. 16                 phone:  +49.231.7556141
D-44227 Dortmund                  fax:    +49.231.7556116
http://ess.cs.tu-dortmund.de/Staff/al


--YjAJKbPSRDIAWGreUOUzkTD1cIcg201Xm--

--Ttm8mGlNMVfe7nbCbsCMw4KHu2VqQcARX
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEElhZsUHzVP0dbkjCRWT7tBbw+9v0FAmBGLy0FAwAAAAAACgkQWT7tBbw+9v2A
nRAAv957o36uDHSxDcTJtcqRTzX3QfhBHX9KZa8lLm22BniXZj7NkZY9qW842/BXQ3BYpgeCf2g+
Qi5OuyEOsq7SfjQmFII3uHkdtbzcOyaRShO+InNKBK2t9hPWUNiwGqYV3/+UO2vtHMqTvFtkXrlq
cbN7TBVrE8SII9ZMmLaAR0d6HSntFlXwpCcjylpmgWlcQGQi94jYra74OTvfGVd0xaiPmM1csmWN
Oczopm268D1qatn4AkffCF4HDuATBuLMxLt4/ZMxi2bC/z6WQ7t8db6oMgu2IeprK2dhC12yOeNz
/IlMTLFtMC/7IHEz2g4GalRfzDLRMVZWXpEYwEJwZhcqkaHhiYvlkxrF0reZ2ltiJbO4kxaIU0al
jaNEyhcFiyLr19c0mbja54bKur8irM/FoBj0UOpUpfydEvQFKjuyMGGYCRwaNyoF+VFE903CY5yG
K7T7KUcHkaSepGDLg91wtLTlh7bf3mXkNixkiQPkjC70s4F/HS8WxHF5lk8ANZehFTvYxtSPT/BI
gECPuo/7qGlFWVVcKp7x7YOEnkD48WDryUTX71Qn/viJ9CR8OvGBaQG/Vagjw8OrGL8b7xDGLLep
4ydqHDiPLBmgbOKV90W/N7SfSc6bJJSmMcnFDG2qOGMq7sfZ98gD9CPPV2JxCDtVQsM9B+xFa1eQ
adY=
=qEGQ
-----END PGP SIGNATURE-----

--Ttm8mGlNMVfe7nbCbsCMw4KHu2VqQcARX--
