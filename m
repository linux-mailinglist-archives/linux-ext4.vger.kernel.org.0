Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF51132EEFD
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Mar 2021 16:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhCEPgO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Mar 2021 10:36:14 -0500
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:39583 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhCEPf4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Mar 2021 10:35:56 -0500
Received: from [192.168.111.113] (p4fd97aad.dip0.t-ipconnect.de [79.217.122.173])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.1/8.16.1) with ESMTPSA id 125FZmBZ001461
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Fri, 5 Mar 2021 16:35:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1614958549;
        bh=d6p0+N+Br3mUr1EhlB2lPjwz95lJMYCofM7C8HA6eHw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=oH+gAJPRzzu1/K9HBFVvJx+DBSSmqoZSuRnSsedcFSqjqEaNbO90EbYVfwxLLtj/2
         uGhTgfh7OKQleIP/CEMTZbMpkWdWNVrZ4VJENJJ6V6vuT1R1GhLjBGU+ufS5LF5ydz
         6SOcJXJGMWfJSfFcAsTQ3pJ8IyC2LS+ukguQ70sU=
Subject: Re: [RFC] inode.i_opflags - Usage of two different locking schemes
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f63dd495-defb-adc4-aa91-6aacd7f441c7@tu-dortmund.de>
 <a4709bc4-ee62-2cdc-0628-32e8fa73e8f9@tu-dortmund.de>
 <YEJLuP6+Zy8/dq+D@mit.edu>
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Message-ID: <667b3ec3-a522-05a9-31e8-87d8bfaa7adb@tu-dortmund.de>
Date:   Fri, 5 Mar 2021 16:35:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEJLuP6+Zy8/dq+D@mit.edu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pg4Tc08beKHQUhmaa9jbDOOBarYm7CmHr"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pg4Tc08beKHQUhmaa9jbDOOBarYm7CmHr
Content-Type: multipart/mixed; boundary="sq9ts7eumJ1CwXQJOkfsR3ADT0IGvtnph";
 protected-headers="v1"
From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
 Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <667b3ec3-a522-05a9-31e8-87d8bfaa7adb@tu-dortmund.de>
Subject: Re: [RFC] inode.i_opflags - Usage of two different locking schemes
References: <f63dd495-defb-adc4-aa91-6aacd7f441c7@tu-dortmund.de>
 <a4709bc4-ee62-2cdc-0628-32e8fa73e8f9@tu-dortmund.de>
 <YEJLuP6+Zy8/dq+D@mit.edu>
In-Reply-To: <YEJLuP6+Zy8/dq+D@mit.edu>

--sq9ts7eumJ1CwXQJOkfsR3ADT0IGvtnph
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable



On 05.03.21 16:18, Theodore Ts'o wrote:
> 1)  I don't see where i_opflags is being read in ipc/mqueue.c at all,
> either with or without i_rwsem.
>=20
It is read in fs/dcache.c
> 2)  I'm not sure what this has to do with ext4?
>=20
>          	    	      	       	  - Ted
>=20
Yeah. You're right. That was my fault. Sry.
I should have sent it to linux-kernel@... only.

- Alex

--=20
Technische Universit=C3=A4t Dortmund
Alexander Lochmann                PGP key: 0xBC3EF6FD
Otto-Hahn-Str. 16                 phone:  +49.231.7556141
D-44227 Dortmund                  fax:    +49.231.7556116
http://ess.cs.tu-dortmund.de/Staff/al


--sq9ts7eumJ1CwXQJOkfsR3ADT0IGvtnph--

--pg4Tc08beKHQUhmaa9jbDOOBarYm7CmHr
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEElhZsUHzVP0dbkjCRWT7tBbw+9v0FAmBCT9QFAwAAAAAACgkQWT7tBbw+9v3Q
qw//ep75+yIDVG2+Q6bmfQmmnvnrfhRkJ1XCq07AF4HYAcbMHw0ELMw4rj4fCEpHVtMkehgDxxCT
/QexI0TPGoWgfMUVPfjndyfRmuuqQuqDuvO9Wvi4eId3sDddoRYnA9c7vlP6x8kDEFjvbLbVVkYu
t6psHUxN6Hkyy2akr1pjXvOmY3BhoZGy/T/PpIKgfwPmgZRxRBh8Gisri6Pl6JlkMnnr4wjjbriR
qbvYqapEJJttPVHmOBKScWjIme5+TDjLUkbu56jkhM124THPNzrNrmLGBS+sYEzzRLQVXbhGvvne
mbF8sq5yXTAJ+n8hIhYQd3sEgxjASSp5RoiRs+HN7k14KwLNcD5BjklDnRrMHWOsPLT+QLKKqyFJ
gX0EJUQpNTojxNNaSC0Hydq4Eo5EsC4eHcbQ2DQsWH5No/t6P1OvxeyBBRePnubxGs/TM14HuzBR
1ofglKQywpDMobObtbit+eSkvkwHOl3h1TnwtwCHE6uxOjdGtxigtC+W0sw5pFy4J7eUP9c+uPHO
f70vera66yeTybme8Ecrtlolz2u8+Jdem4ESpIS8HStMxtj2tf74CO1zBNB06IPaTr7pLkK701Fu
9s53LmKxVhwyCRuzz3jt2RA525SEOjK0ZT2xWPKOy5K9bKzuwMg3/XwIJb/1UMo6mJkAOsLK0cYI
XWU=
=FfwE
-----END PGP SIGNATURE-----

--pg4Tc08beKHQUhmaa9jbDOOBarYm7CmHr--
