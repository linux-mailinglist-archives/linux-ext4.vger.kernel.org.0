Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56578192517
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Mar 2020 11:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgCYKG7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Mar 2020 06:06:59 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:36430 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgCYKG6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Mar 2020 06:06:58 -0400
Received: by mail-pl1-f178.google.com with SMTP id g2so629203plo.3
        for <linux-ext4@vger.kernel.org>; Wed, 25 Mar 2020 03:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=KRNCzQB6WkPUCPthpkFikayCNQ1NpF9gUoPYJ7I7giQ=;
        b=kqtQhfK/3Zeq7i3Cqs9Pqx+Ja8s4R+xZzym3j0QdNcShQhWfzA8koPAUtAKEhB8FPl
         iSzpR4D6xi8SpJaEJybxdRMgGQISq9N6SXb8EgqOxMLFP+cDLwdLa7/VpHfDMlxkSTu/
         A82iDoUfD7EROpNOQWTuCncxdUztVLhoostM00DYfpE8UG1n16g2g1x0VdBfx00TNGZv
         MtJ7zXuHFrzhV31mk/9Y34r+kF4xdPpy/1B2d6wMD0vesRzO274sgIoU1+RKdxAYX17H
         4Gfqyfr/CcPqGcuu7UOn/BsKctY3uTu8I76LH/JvaQTsszVIztA4S9aK4+icX3lvTkgB
         4MTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=KRNCzQB6WkPUCPthpkFikayCNQ1NpF9gUoPYJ7I7giQ=;
        b=F2I/Y4Z4bAPlynWXsQXzQd7AzcbG6VrSNuJTs+3ujaux3w2yJL3wycvXLaAFYWF03K
         ofcB6cdC5T5w0sfFL0YAc1Floq2nCtXqVvDYKB1QjDSBVLzNsgAMRsc0QKjiBBgW0mYq
         usYy/jQHp4180CPAKTP3WtxGMw8eUj8X7Tb7471oK7Q1OY4Tzm0YAmPctg+ahKcPmWzC
         PpKonmiWAPVfVdfiBuxggncyMIbR+NepgLcm8RFCaiwPALbsHOq4xmnp7aeBdwH6som8
         WqK2tHtpqySg3trxc8pb4NhMzg466m+A8sRuVbW0jFYB+OuAZ1YTbHGZq2mUZ5m6dgd8
         4kIw==
X-Gm-Message-State: ANhLgQ2oQ9llQC01DO5LVBGhFK6JMvIrCc42AO0PCyK5jdHJ9nvEkLss
        9vxS5TZKYGVPaPWLTkrWzA4uvA==
X-Google-Smtp-Source: ADFU+vuBo6wJoagSn+H1r7WD0EUhH9fPDKb6mOzCyepWzerdex+zPhf9uA/sI//+apDe2bbRY7Ayyw==
X-Received: by 2002:a17:90a:aa86:: with SMTP id l6mr2926647pjq.30.1585130817256;
        Wed, 25 Mar 2020 03:06:57 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id v5sm11734125pfn.105.2020.03.25.03.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 03:06:56 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <04F44879-15DE-42EE-B87A-0690E9B13BB2@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_01895461-6364-4EFB-940F-A6D8C3D78409";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/2] ext4: shrink directories on dentry delete
Date:   Wed, 25 Mar 2020 04:06:52 -0600
In-Reply-To: <20200325093728.204211-2-harshadshirwadkar@gmail.com>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20200325093728.204211-1-harshadshirwadkar@gmail.com>
 <20200325093728.204211-2-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_01895461-6364-4EFB-940F-A6D8C3D78409
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 25, 2020, at 3:37 AM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
> But note that most of the shrinking happens during last 1-2% deletions
> in an average case. Therefore, the next step here is to merge dx nodes
> when possible. That can be achieved by storing the fullness index in
> htree nodes. But that's an on-disk format change. We can instead build
> on tooling added by this patch to perform reverse lookup on a dx
> node and then reading adjacent nodes to check their fullness.

Thank you for updating these patches again.  I haven't had a chance to =
look
at them yet, but I hope to review the patches in the near future.

As for storing the fullness on disk changing the on-disk format...  That =
is
true, but the original htree implementation anticipated this and =
reserved
space in the htree index to store the fullness, so it would not break =
the
ability of older kernels to access directories with the fullness =
information.

I think if you used just a few bits (maybe just 2) to store:
0 =3D unset (every directory today)
1 =3D under 20% full
2 =3D under 40% full
3 =3D under 60% full

or similar.  It doesn't matter if they are more full since they won't be
candidates for merging, and then lazily update the htree index fullness
as entries are removed, this will simplify the shrinking process, and =
will
avoid the need to repeatedly scan the leaf blocks to see if they are =
empty
enough for merging.  It wouldn't be any worse *not* to store these =
values
on disk after the first time a "0 =3D unset" entry was found and not =
merged,
or setting the fullness on the merged block if it is merged, and running
"e2fsck -D" can easily update the fullness values.

The benefit of using 20%, 40%, and 60% as the fullness markers is that =
it
is possible to either merge adjacent 60% and 40% blocks or alternately a
60% and two adjacent 20% blocks.  Also, since these values are very =
coarse
they would not need to be updated frequently.  If the values are =
slightly
outdated, then it is again not worse than the "always scan" model (one =
scan
and the fullness would be updated), but more efficient than repeat =
scanning.

Using only two bits for fullness also leaves two bits free for future =
use.

Cheers, Andreas






--Apple-Mail=_01895461-6364-4EFB-940F-A6D8C3D78409
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl57LT0ACgkQcqXauRfM
H+BuUBAAn8KVagRN08QANiqnAa9/6pTTlVRDQ9yq4eUqIaO+cXth9HMKnwpzQp+9
PY4duashMDWOeAaGXE9tW6MiMYlZaoINguECnrU1OZjwmTnJIfAIQEU2fzt0MoMb
l5IQKRQOBKQ7D/sslgzalQ0IOFaLLUlh9G6jEphX7FrpaKEe/qL7hEXb2HsGHHjj
q4lv4+x3Zr1iMlQyU1gJ572WOzfybyl0NfhJxRy6P2nE0VLo1fB5uGZVOLmG1aWG
KN9oYo3809fKcSm3pr7HNx/84mKyzHWCuW/Pz4IUqZR4gwnATQENmLqXCaJ7cgau
uNMU39XC+2MV6DsEgPvE46OPnmFX8FJddhKH+wE9X0oeDvRpOD8vPXFNGw+Uubw5
1FmraqRcRBGY3EJhTCyC9HGcwKg5cmb4k1LqcjfmCJMEfQEweRfUa0O0kbY0ml0f
aTtvTffMC0dY1B448nHcgdnJk8PUCQNx+tsDQucmZZqxCB1BpKLloIWnZ/avYe5z
Vid7BRcvSk3ahZmkAejnhf7kTH4NIbvixo7UGuAggamfIlwEtvzcVywVR0rjwheI
S3ACfMUcM3gzO/cTACOKU4aQio19ely6lwM/VYJgJV8Vmqe+iHnH0uvy0dGQ09Oh
hphMvLTWuznSmdA8BaTi5oofi1rVc7v7GxlZwFWsE7TOe8L6iY0=
=CMPI
-----END PGP SIGNATURE-----

--Apple-Mail=_01895461-6364-4EFB-940F-A6D8C3D78409--
