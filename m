Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EEC314CAE
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Feb 2021 11:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhBIKCB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Feb 2021 05:02:01 -0500
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:54573 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhBIJ7x (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Feb 2021 04:59:53 -0500
Received: from [192.168.111.113] (p4fd97768.dip0.t-ipconnect.de [79.217.119.104])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.1/8.16.1) with ESMTPSA id 1199wmDD018818
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Tue, 9 Feb 2021 10:58:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1612864729;
        bh=eKHpRXdlv4G54jtZWS0dN3DU8Sy2lKh+7cbg3MyI2mA=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To;
        b=Y2IONlX3ss++LgMqnbxvI07iiCVJPoyHb9WONhtOuLJaDQpZrF2LbnGYGGfYogPnn
         oLNYJRAsfiq/2U/snXquUcsRZAe6qFSBBvcdEbOuCi5Q+eZNGYNbJWk12UpbRozLgJ
         nKNRrUiJNkatr6KVxBgxZFsQ/U4YkDm2eKsEOlXg=
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, Jan Kara <jack@suse.com>,
        Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        linux-ext4@vger.kernel.org
References: <20190408083500.66759-1-alexander.lochmann@tu-dortmund.de>
 <7827d153-f75c-89a2-1890-86e85f86c704@tu-dortmund.de>
 <14dbc946-b0c5-4165-3e6a-3cbe3c6a74b4@tu-dortmund.de>
 <20210208152750.GD30081@quack2.suse.cz>
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Subject: Re: [RFC] Fine-grained locking documentation for jbd2 data structures
Message-ID: <02643d06-0066-a7c3-b6dd-2d190c8e0c41@tu-dortmund.de>
Date:   Tue, 9 Feb 2021 10:58:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210208152750.GD30081@quack2.suse.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pZyjPCUqXaCogtT1Gjbu9HDPm0BGoRiVQ"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pZyjPCUqXaCogtT1Gjbu9HDPm0BGoRiVQ
Content-Type: multipart/mixed; boundary="9EfLAzihF6kWLjAqRmLEVQu8XYAkRS5yx";
 protected-headers="v1"
From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To: Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, Jan Kara <jack@suse.com>,
 Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
 linux-ext4@vger.kernel.org
Message-ID: <02643d06-0066-a7c3-b6dd-2d190c8e0c41@tu-dortmund.de>
Subject: Re: [RFC] Fine-grained locking documentation for jbd2 data structures
References: <20190408083500.66759-1-alexander.lochmann@tu-dortmund.de>
 <7827d153-f75c-89a2-1890-86e85f86c704@tu-dortmund.de>
 <14dbc946-b0c5-4165-3e6a-3cbe3c6a74b4@tu-dortmund.de>
 <20210208152750.GD30081@quack2.suse.cz>
In-Reply-To: <20210208152750.GD30081@quack2.suse.cz>

--9EfLAzihF6kWLjAqRmLEVQu8XYAkRS5yx
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable



On 08.02.21 16:27, Jan Kara wrote:
> Hi Alexander!
>=20
> On Fri 05-02-21 16:31:54, Alexander Lochmann wrote:
>> have you had the chance to review our results?
>=20
> It fell through the cracks I guess. Thanks for pinging. Let me have a l=
ook.
>=20
>> On 15.10.20 15:56, Alexander Lochmann wrote:
>>> Hi folks,
>>>
>>> when comparing our generated locking documentation with the current
>>> documentation
>>> located in include/linux/jbd2.h, I found some inconsistencies. (Our
>>> approach: https://dl.acm.org/doi/10.1145/3302424.3303948)
>>> According to the official documentation, the following members should=
 be
>>> read using a lock:
>>> journal_t
>>> - j_flags: j_state_lock
>>> - j_barrier_count: j_state_lock
>>> - j_running_transaction: j_state_lock
>>> - j_commit_sequence: j_state_lock
>>> - j_commit_request: j_state_lock
>>> transactiont_t
>>> - t_nr_buffers: j_list_lock
>>> - t_buffers: j_list_lock
>>> - t_reserved_list: j_list_lock
>>> - t_shadow_list: j_list_lock
>>> jbd2_inode
>>> - i_transaction: j_list_lock
>>> - i_next_transaction: j_list_lock
>>> - i_flags: j_list_lock
>>> - i_dirty_start: j_list_lock
>>> - i_dirty_start: j_list_lock
>>>
>>> However, our results say that no locks are needed at all for *reading=
*
>>> those members.
>>>  From what I know, it is common wisdom that word-sized data types can=
 be
>>> read without any lock in the Linux kernel.
>=20
> Yes, although in last year, people try to convert these unlocked reads =
to
> READ_ONCE() or similar as otherwise the compiler is apparently allowed =
to
> generate code which is not safe. But that's a different story.
Is this ongoing work?
Using such a macro would a) make our work much easier as we can=20
instrument them, and b) would tell less experienced developers that no=20
locking is needed.
Does the usage of READ_ONCE() imply that no lock is needed?
Otherwise, one could introduce another macro for jbd2, such as #define=20
READ_UNLOCKED() READ_ONCE(), which is more precise.
  Also note
> that although reading that particular word may be safe without any othe=
r
> locks, the lock still may be needed to safely interpret the value in th=
e
> context of other fetched values (e.g., due to consistency among multipl=
e
> structure members).=20
Just a side quest: Do you have an example for such a situation?
So sometimes requiring the lock is just the least
> problematic solution - there's always the tradeoff between the speed an=
d
> simplicity.
>=20
>>> All of the above members have word size, i.e., int, long, or ptr.
>>> Is it therefore safe to split the locking documentation as follows?
>>> @j_flags: General journaling state flags [r:nolocks, w:j_state_lock]
>=20
> I've checked the code and we usually use unlocked reads for quick, poss=
ibly
> racy checks and if they indicate we may need to do something then take =
the
> lock and do a reliable check. This is quite common pattern, not sure ho=
w to
> best document this. Maybe like [j_state_lock, no lock for quick racy ch=
ecks]?
>=20
Yeah, I'm fine with that. Does this rule apply for the other members of=20
journal_t (and transaction_t?) listed above?
>>> The following members are not word-sizes. Our results also suggest th=
at
>>> no locks are needed.
>>> Can the proposed change be applied to them as well?
>>> transaction_t
>>> - t_chp_stats: j_checkpoint_sem
>=20
> Where do we read t_chp_stats outside of a lock? j_list_lock seems to be=

> used pretty consistently there. Except perhaps
> __jbd2_journal_remove_checkpoint() but there we know we are already the=

> only ones touching the transaction and thus its statistics.
>=20
I'm sorry. That's my mistake. There's no access without a lock.
>>> jbd2_inode:
>>> - i_list: j_list_lock
>=20
> And here as well. I would not complicate the locking description unless=
 we
> really have places that access these fields without locks...
>=20
Same here.

- Alex
> 								Honza
>=20

--=20
Technische Universit=C3=A4t Dortmund
Alexander Lochmann                PGP key: 0xBC3EF6FD
Otto-Hahn-Str. 16                 phone:  +49.231.7556141
D-44227 Dortmund                  fax:    +49.231.7556116
http://ess.cs.tu-dortmund.de/Staff/al


--9EfLAzihF6kWLjAqRmLEVQu8XYAkRS5yx--

--pZyjPCUqXaCogtT1Gjbu9HDPm0BGoRiVQ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEElhZsUHzVP0dbkjCRWT7tBbw+9v0FAmAiXNgFAwAAAAAACgkQWT7tBbw+9v3E
+RAA1KEf0ugELkZhSKI3JVwbRmvBYNZk5jEq23vpw73LBJCIvWTbkNsh1Fa2uKo2aXpUwm2yu/DH
GIjFnxNeNZQfxf5Y13hXCyPKO50l/WPfR8FQAE0pnIFTssGhQuEs9zvWUjNI2xrTJvJJJJrMZHup
3MYtmeWozwYbMfd//1TkPqgH4Xw+EuNlTBIzy+JquTO+bTc+s7LA+VnoGtMoj0P3Tzu898SftTzz
MvNb9e0sffR3O4fvxkakDoFzpcgBlwAQP3Z5JrSlIPk9InOzPm730urjhAjvwRIPFJzyRo9FR92s
yLm/31LyJ/Om60nMwH7vu7AinViu3c599AhrTOgxTVAAMsP2NlWrTgbJxdwX1RuC9AqhOvHVRsMx
CjL2HSBTRhxj8p0P7PotArt2syE31w8SG1RXtGcuN8stdswh9+7K3ZIA5pO/kfuty2dxfeuIXgUW
OwBHqfje6vnqWsle17NyB8UYq0FsOCduhL2o7K/o2EIkRXUFc11IXFa7oiAPBA4nM+5g8YNK74Xk
SxL8DFOdKTv04ryHtVBWDpIcew4eLGKbK+1vtVpueEXDEmqsg+sx+TkrPrEity1yTQRYTQ+kbUNd
cF3qtUXPxoEvYELn8ILOfsf5FXGJjl8PWr18SeAxoMd2NmZegGbGlcj0r9bLy9EMocD9dkb9TtaH
DG8=
=cD3I
-----END PGP SIGNATURE-----

--pZyjPCUqXaCogtT1Gjbu9HDPm0BGoRiVQ--
