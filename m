Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4240132EBE8
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Mar 2021 14:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhCENKd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Mar 2021 08:10:33 -0500
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:40269 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCENKP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Mar 2021 08:10:15 -0500
Received: from [192.168.111.113] (p4fd97aad.dip0.t-ipconnect.de [79.217.122.173])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.1/8.16.1) with ESMTPSA id 125DA9IM027367
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Fri, 5 Mar 2021 14:10:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1614949810;
        bh=gXsJ1fKl5lxPdzGuegoK8ZfZEm1Ox2xsolt/E9FEeJM=;
        h=Subject:From:To:References:Date:In-Reply-To;
        b=RtrzW8vxvWZHsPDtGBFNWMF3veXLstbgvGX+DtKo3uiZFzXKTNPawPey7FjaG/Sa9
         V+Q8jBIXjgiMLCp+FTrp2G7cO6cMhPp8NiqGK6XlArTg/bACYmbBfMZzrdZkEIFTn2
         k8P6k2nPJTzwKYEYVke58jamPz9RFtl1vZbX+4Zs=
Subject: [RFC] inode.i_opflags - Usage of two different locking schemes
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To:     Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <f63dd495-defb-adc4-aa91-6aacd7f441c7@tu-dortmund.de>
Message-ID: <a4709bc4-ee62-2cdc-0628-32e8fa73e8f9@tu-dortmund.de>
Date:   Fri, 5 Mar 2021 14:10:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <f63dd495-defb-adc4-aa91-6aacd7f441c7@tu-dortmund.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qrtpaYptFGrAgmI252USJoKEQABELtY0k"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qrtpaYptFGrAgmI252USJoKEQABELtY0k
Content-Type: multipart/mixed; boundary="FtGpcBLiEc5Gzv1QqGCccAfWVGElCO9UF";
 protected-headers="v1"
From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
 Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
 Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <a4709bc4-ee62-2cdc-0628-32e8fa73e8f9@tu-dortmund.de>
Subject: [RFC] inode.i_opflags - Usage of two different locking schemes
References: <f63dd495-defb-adc4-aa91-6aacd7f441c7@tu-dortmund.de>
In-Reply-To: <f63dd495-defb-adc4-aa91-6aacd7f441c7@tu-dortmund.de>

--FtGpcBLiEc5Gzv1QqGCccAfWVGElCO9UF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hi folks,

I've stumbled across an interesting locking scheme. It's related to=20
struct inode, more precisely it is an mqueue inode.
Our results show that inode:mqueue.i_opflags is read with i_rwsem being=20
hold.
In d_flags_for_inode, and do_inode_permission the i_lock is used to read =

and write i_opflags.
Is this a real locking scheme? Is a lock needed to access i_opflags at al=
l?
What is the magic behind this contradiction?

I've put the report of the counterexamples on our webserver:=20
https://ess.cs.tu-dortmund.de/lockdoc-bugs/cex-inode-mqueue.html.
It contains the stacktraces leading to those accesses, and the locks=20
that were actually held.

Regards,
Alex

--=20
Technische Universit=C3=A4t Dortmund
Alexander Lochmann                PGP key: 0xBC3EF6FD
Otto-Hahn-Str. 16                 phone:  +49.231.7556141
D-44227 Dortmund                  fax:    +49.231.7556116
http://ess.cs.tu-dortmund.de/Staff/al


--FtGpcBLiEc5Gzv1QqGCccAfWVGElCO9UF--

--qrtpaYptFGrAgmI252USJoKEQABELtY0k
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEElhZsUHzVP0dbkjCRWT7tBbw+9v0FAmBCLbEFAwAAAAAACgkQWT7tBbw+9v3x
ixAAwAOFV/Y+InVztS7YfL0LBxZlDpU5WAgDgqbi3vRK3nvi5IwSlHPzRTFb1E6nxYLCEWaT3cn5
2e/xX5wdmwkQGMAEnga3oUCBCp/+1212fF71FG23eXxH0QuYEYPDCbs26QOn97OUEa1HH0HcRc9G
7oiN58RbBBrqgHGqqchKI/dl638C0zL0SsRIXBueNw7mC8bOInDt7FHnIcPgKpHBqQkqbEyclkI6
ewh893N/TdRVMbOGsTJgJNJpToX0/DQhN6tghL94Xh2u0lEg/QYu3nO7w9nmMVPL3TgZaXV0/IZh
mGp4+uPR09ejkXxpJlj3IiXI8SRCON3TZ3NN6M+ym5afKP3dL+Mjy2BSTRr97KKyNKJ1cTrdQiNS
Vwl9/yLok5PaeUOKjqyavCDZYAQ+Hu/yAv993qGlJ3hE/MWkcVooWB2vdTwIg+A7lW4nP9/fYgP9
Ee9RnoC5EDy637EhBO5noIz3zbCy6egsFL0SIK5w9gQOmoh5gugIbxTNjXYgWMTNsOxxTW0E6VW6
G3uNECotVSjjr1ZiM7O/6hEu9GA3FlxXdI840Qfc10MxRHEz5fudG/nqglQ4eJ0jC3ZbDJI2Tuzd
9MrOSSiReoNlHZXUs2cS4XV8VHVr9nqV+10RWYpeHJidM2ypauKBommEPCR6o7kII7JX0UBMGLAb
UYA=
=BAR3
-----END PGP SIGNATURE-----

--qrtpaYptFGrAgmI252USJoKEQABELtY0k--
