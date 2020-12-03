Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24D22CDA2C
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Dec 2020 16:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgLCPgc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Dec 2020 10:36:32 -0500
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:43799 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgLCPgc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Dec 2020 10:36:32 -0500
X-Greylist: delayed 3419 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Dec 2020 10:36:27 EST
Received: from [192.168.111.113] (p4fd978de.dip0.t-ipconnect.de [79.217.120.222])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.1/8.16.1) with ESMTPSA id 0B3Ece7L010499
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Thu, 3 Dec 2020 15:38:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1607006321;
        bh=m06X/TIPZ3EDC1a7eYVn2cS1BRtNtu07ZviF30nWP28=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To;
        b=X/EJBPNUl7EqRHEHhu3LHxLr00diFcJHPGS7oo4yW7NFtZ0e2vKHBLilU/fpMdUzO
         QsgztSQ8GNP9EaqiecZEaPYiAmtnc9AH/7k17mVbEhHZSFfJI4OEEQwLqxpxsYQdKB
         CDv1D7hn3N+W2logSlvZOoP/TPatp8c85WEDIaBc=
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190408083500.66759-1-alexander.lochmann@tu-dortmund.de>
 <10cfbef1-994c-c604-f8a6-b1042fcc622f@tu-dortmund.de>
 <20201203140405.GC441757@mit.edu>
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Subject: Re: [PATCH v3] Updated locking documentation for transaction_t
Message-ID: <29d6de5d-4abc-e836-7b14-bb67d782a752@tu-dortmund.de>
Date:   Thu, 3 Dec 2020 15:38:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201203140405.GC441757@mit.edu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0E02t77jjvJL2pXwjrDHLaZHwny6ypUXx"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0E02t77jjvJL2pXwjrDHLaZHwny6ypUXx
Content-Type: multipart/mixed; boundary="K5UZ4T9vvmf0OGeuXP2VHmznWhaznB3Iz";
 protected-headers="v1"
From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
 Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <29d6de5d-4abc-e836-7b14-bb67d782a752@tu-dortmund.de>
Subject: Re: [PATCH v3] Updated locking documentation for transaction_t
References: <20190408083500.66759-1-alexander.lochmann@tu-dortmund.de>
 <10cfbef1-994c-c604-f8a6-b1042fcc622f@tu-dortmund.de>
 <20201203140405.GC441757@mit.edu>
In-Reply-To: <20201203140405.GC441757@mit.edu>

--K5UZ4T9vvmf0OGeuXP2VHmznWhaznB3Iz
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable



On 03.12.20 15:04, Theodore Y. Ts'o wrote:
> On Thu, Oct 15, 2020 at 03:26:28PM +0200, Alexander Lochmann wrote:
>> Hi folks,
>>
>> I've updated the lock documentation according to our finding for
>> transaction_t.
>> Does this patch look good to you?
>=20
> I updated the annotations to match with the local usage, e.g:
>=20
> 	 * When commit was requested [journal_t.j_state_lock]
>=20
> became:
>=20
> 	 * When commit was requested [j_state_lock]What do you mean by local u=
sage?
The annotations of other members of transaction_t?

Shouldn't the annotation look like this?
[t_journal->j_state_lock]
It would be more precise.
>=20
> Otherwise, looks good.  Thanks for the patch!
Thanks!

- Alex
>=20
> 	   	 	       	       - Ted
>=20

--=20
Technische Universit=C3=A4t Dortmund
Alexander Lochmann                PGP key: 0xBC3EF6FD
Otto-Hahn-Str. 16                 phone:  +49.231.7556141
D-44227 Dortmund                  fax:    +49.231.7556116
http://ess.cs.tu-dortmund.de/Staff/al


--K5UZ4T9vvmf0OGeuXP2VHmznWhaznB3Iz--

--0E02t77jjvJL2pXwjrDHLaZHwny6ypUXx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEElhZsUHzVP0dbkjCRWT7tBbw+9v0FAl/I+HAFAwAAAAAACgkQWT7tBbw+9v3H
4RAApa649SmusVXmkjHe8wcmOyq1Da9GgieaQextJ0bvYvG1BGIL3aN9/5AZs+LWeMtybtEY52tx
95Ywqa+rGlBgJTXsQvQiMun8ra/N8D2V3QRvJLfN8opiZv/yvPZf3mV0ySYxpNNJHcMZUF0hZFlP
HuaBpyfLKshVDA5gKLqwEF83pQRhFeDYxDh6EiaspT7NX44SNJeHHGaeVl9HxeWgv7yF8uKap/61
SKOm5+QiGJA93MXCO1vap6FyfoKA5xLwU5VqMpm5SF/oqNSyx8c/lW/wZmjc1nJU3ma51q57OlS8
Fa2B1FaSL3LbFNqKYDWn1MuCc5Y85Xsod2zFWfH2lzrHqRMOoc/8v2qu6h3p4HwwKIDUeF5BBbdI
Tz84I/aSezbV9gi+6vY5CvIypCbZ+NERikH2AtJeT/cpEQ9W0sPEANYY7VjkVQXRnyNEl9PD6ji9
FoC9Lw8k0lJibkTN/sp0c6XekTz+QGjWXctroBFHpRjW5TvwQ7aCKiCN8Yq0iehPYPMxYAYigNtn
+hpucH2wgvpYoIdqFn5sKuMeBiOmVlwkmNeDbQdYEKd8PoydXAcuBdgF1hmglJJbzwJvJioTeAEB
vo9ULMTmT8DCdionZjEya4tm9NdeOWl94X+z+huDb6Ga8ByVsCehESCsd8xfRBZktA0tK472D9aQ
+KI=
=aT3U
-----END PGP SIGNATURE-----

--0E02t77jjvJL2pXwjrDHLaZHwny6ypUXx--
