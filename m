Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F8B318790
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Feb 2021 10:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhBKJ5M (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Feb 2021 04:57:12 -0500
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:36104 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhBKJzL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Feb 2021 04:55:11 -0500
Received: from [192.168.111.113] (p4fd971d4.dip0.t-ipconnect.de [79.217.113.212])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.1/8.16.1) with ESMTPSA id 11B9rpY7010928
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Thu, 11 Feb 2021 10:53:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1613037232;
        bh=hEny8mHNdB5omE4FqgLpGkOemODjAlaz9MQDbNDOuec=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dTBbDs5s2y2XfvCMZ+7qGnOL17EizipLyeD3HGWiyD3ozTYJHTdVO+ZBBnXpslzpg
         wKfAdlkMhLMfP29RU2Q2RQgukK5276up5IrV+wdZUTmOZ8z94kSI4YC4yQwrAFKrGc
         KK1rk0SjCG878UEMgR/924yv/PJUxPvZ2G5zf6XE=
Subject: Re: [PATCH 1/2] Updated locking documentation for transaction_t
To:     Jan Kara <jack@suse.cz>
Cc:     Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210210095740.54881-1-alexander.lochmann@tu-dortmund.de>
 <20210210095740.54881-2-alexander.lochmann@tu-dortmund.de>
 <20210211093027.GI19070@quack2.suse.cz>
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Message-ID: <1803ac43-d6fc-4de8-78a0-7fc807f9c036@tu-dortmund.de>
Date:   Thu, 11 Feb 2021 10:53:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210211093027.GI19070@quack2.suse.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xR6At3BscXEfQMytnEQ6uJIgWbuzasC1X"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xR6At3BscXEfQMytnEQ6uJIgWbuzasC1X
Content-Type: multipart/mixed; boundary="b63HI2vDGUjw0rmQ83RumwUtZ7tnYQBbd";
 protected-headers="v1"
From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To: Jan Kara <jack@suse.cz>
Cc: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
 Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1803ac43-d6fc-4de8-78a0-7fc807f9c036@tu-dortmund.de>
Subject: Re: [PATCH 1/2] Updated locking documentation for transaction_t
References: <20210210095740.54881-1-alexander.lochmann@tu-dortmund.de>
 <20210210095740.54881-2-alexander.lochmann@tu-dortmund.de>
 <20210211093027.GI19070@quack2.suse.cz>
In-Reply-To: <20210211093027.GI19070@quack2.suse.cz>

--b63HI2vDGUjw0rmQ83RumwUtZ7tnYQBbd
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable



On 11.02.21 10:30, Jan Kara wrote:
>>   	 */
>>   	unsigned long		t_log_start;
>>  =20
>> -	/* Number of buffers on the t_buffers list [j_list_lock] */
>> +	/* Number of buffers on the t_buffers list [j_list_lock, no lock for=
 quick racy checks] */
>>   	int			t_nr_buffers;
>=20
> So this case is actually somewhat different now that I audited the uses=
=2E
> There are two types of users - commit code (fs/jbd2/commit.c) and other=
s.
> Other users properly use j_list_lock to access t_nr_buffers. Commit cod=
e
> does not use any locks because committing transaction is fully in
> ownership of the jbd2 thread and all other users need to check & wait f=
or
> commit to be finished before doing anything with the transaction's buff=
ers.
Mhm I see.
What about '[..., no locks needed for jbd2 thread]'?

How do the others wait for the commit to be finished?

- Alex

--=20
Technische Universit=C3=A4t Dortmund
Alexander Lochmann                PGP key: 0xBC3EF6FD
Otto-Hahn-Str. 16                 phone:  +49.231.7556141
D-44227 Dortmund                  fax:    +49.231.7556116
http://ess.cs.tu-dortmund.de/Staff/al


--b63HI2vDGUjw0rmQ83RumwUtZ7tnYQBbd--

--xR6At3BscXEfQMytnEQ6uJIgWbuzasC1X
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEElhZsUHzVP0dbkjCRWT7tBbw+9v0FAmAk/q8FAwAAAAAACgkQWT7tBbw+9v3Z
ChAAhoUoJXxPDqGorG3wSL5TocAPktm+zk4lWB1iSWFFSnIW9tHPIt3BU3TU/3WNP59XGRPy52Qv
uPY16Es7Newbojhiay3+ImfAJjWjepm6+F0On4QHzQO/vMw+1n8s03V32V6fVB10EbV59rsjD9TJ
uDtSSNaogT8E9q5dQe/xDlmmPQGrN/J35YdPowYC7qof1gRQLBJfpHyQyzWb06lvt6mBNg75fC7l
7LfMnn6EqM5RdNva4DyfHPY7JaEkE9ktG3YnuPU5F3KvpE74luogqz5fC/CdZ7Kdv0Jv1Wi2X7AA
/8dYb+d/zSLxtkndHKoCaXfWfL0A2X4hw2Nnpd+2C8nnRIO1q2CV8r+FILgatIPq1wgvovskmhQA
fbGm4vh0Bw2gfMGGVtjGGgoLzT93XUMWQ7uD9VstQvchOB0vKfKy/Nzv4LLPRFS4lTWtVvZtJfQR
rwD6KHQn7thgiVjgEoh9LAdtg7/FsvznOjcuOL+fPYA6acMkF+5aCemtel/fkrrbPP8QZk+eJj/O
DkRSjSfBmnw6RSPkrolZ3y9kVzZFjqO7sUGCTVtey/URABPQb+VjtLS+1mJ7+QvnMSuDpd5aKAJH
azfVgwCPrcopu+i7KYsTWzKpR4eENDmOWhUvzFvoko4dUVvU/N90H7Aelp/k1CUfvYEgJ4TlhJ/G
CWc=
=hu8m
-----END PGP SIGNATURE-----

--xR6At3BscXEfQMytnEQ6uJIgWbuzasC1X--
