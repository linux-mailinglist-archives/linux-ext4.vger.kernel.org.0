Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5937E75896
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2019 22:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfGYUD2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Jul 2019 16:03:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39051 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfGYUD2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 Jul 2019 16:03:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so23844401pls.6
        for <linux-ext4@vger.kernel.org>; Thu, 25 Jul 2019 13:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=z7CunmqcQiYUGFQRCgUApIqRIV9b/Rrr6wQkRR1kX0g=;
        b=Cb7Yd4kzuYxchrKbFfKAQRdBx1eUFnlm4AT7s7+8BBhHQUIPNhIF8pPtx9Ihjfkj7D
         jmpemcGvWi/s/4XXDR1KXYyDck30yTrptmZ+iqgP52y+8Lpd2XekgD1g9JFbyjUyF6lG
         GZOoyAqanVLMB9FewJl2EW5tqJhdi4yufNR8FAUGmMUYpN92uN71qR+gDy97W1gTD/MR
         Z+Ows1eAYgxI5OQ3R3XnNhRSPborxGsWs078nntOxoaXGrVLnnFo/DxGjslMpva7vW12
         xH0GKuJDhkUCj4FwSNW62yGptgX+WSoFVlYc/Lse8ACBDle2/9MSxHcjNH83MWSEF/mI
         B0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=z7CunmqcQiYUGFQRCgUApIqRIV9b/Rrr6wQkRR1kX0g=;
        b=VYxOcDi0ZxvibC4shX7c2JdVDqeHifknTsB2UN7RTZq+s9zg8peIVcvs+dMAMvswR3
         SdLE5wrjX2JRHyJRjgm2b6lG1ylTdJEmNDhkRN+xNyBWG/I73nDgq5bX5nozjTvb6BNw
         QQyf6BKX1YU+WkFx3jfII+jUMNmaLXiXx6/jQv4qfNW1DTJ6SalF+9ytgd2gKI+sUWJu
         MG221ku9dpS4eSd0ulmSoVWbHhV2Ym6drl2JUseUhxgUCmrMFmkdnP8jxHZFXvhEVM24
         6s/9eJQfU3kIM6dQJWclExX3RFC1CyjDQ1tVTORCWFj20QmnAdukh/VK6mHIuoJsU7Ld
         m8vA==
X-Gm-Message-State: APjAAAV+vdZlNKKoaX/ALYUuw5q7e23DA3fj9RjBltA9rp/OZ5PrDT5i
        EpZ4T+QTTj9pSut2SUqncVY=
X-Google-Smtp-Source: APXvYqyOf0D84Zt3JcNbOPOHv0thILJlhwA7a+4o9GkYF7fmbNcWjpHRGKBjiFnVkBOV2inoakQ1eQ==
X-Received: by 2002:a17:902:a714:: with SMTP id w20mr92791358plq.127.1564085007553;
        Thu, 25 Jul 2019 13:03:27 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id b36sm78094363pjc.16.2019.07.25.13.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 13:03:26 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <FA794079-BB03-483C-A89C-3A6F72B06E98@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_3102B695-66DE-47D7-9462-8A6F09B2787D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 01/11] ext4: add handling for extended mount options
Date:   Thu, 25 Jul 2019 14:03:24 -0600
In-Reply-To: <CAD+ocbyeT7kmwfC-ixwdAr-ErRF3WQA6+BDSMTmUSL7QQSEugg@mail.gmail.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
References: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
 <41522E01-D5E5-4DC6-8AD4-09E3FA19F112@dilger.ca>
 <20190722210235.GE16313@mit.edu>
 <7AD1A611-9BD2-4F32-9568-D0A517047EF0@dilger.ca>
 <CAD+ocbwCYZDrj9D=85AVaB_RLYjUFwNs1V02fRn4tHh04_k7_A@mail.gmail.com>
 <20190724061231.GA7074@magnolia> <20190724160749.GF4565@mit.edu>
 <20190724165637.GB7074@magnolia>
 <CAD+ocbyeT7kmwfC-ixwdAr-ErRF3WQA6+BDSMTmUSL7QQSEugg@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_3102B695-66DE-47D7-9462-8A6F09B2787D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 24, 2019, at 12:14 PM, harshad shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> On Wed, Jul 24, 2019 at 9:56 AM Darrick J. Wong =
<darrick.wong@oracle.com> wrote:
>>=20
>> (I guess you could have a fastcommit_version field that increments =
every
>> time you add a new fastcommit journal item to constrain the =
combinatoric
>> explosion...)
>=20
> I agree, I was going to suggest the same. We would probably need to
> add this field in all individual fast commit blocks, since we don't
> have a fast commit superblock equivalent .. and changing jbd2
> superblock is probably too much to ask for I guess.

As a general design rule, whenever you see/think "version number", you
should instead use "feature flags" as is done in the ext2/3/4 =
superblock.
This doesn't take any more space, and is much more flexible.

This is a _much_ more flexible paradigm for compatibility, and doesn't
require the "version X must support every version <=3D X" behaviour that
a version number does.  With feature flags you can support feature bit
a+b+c, and if feature B is no longer useful it can be deprecated without
affecting the use of feature A or C.  It also makes it clear that bits
a+b+c are using features A+B+C, while storing "version 7" isn't clear
which feature is in use/needed.

Cheers, Andreas






--Apple-Mail=_3102B695-66DE-47D7-9462-8A6F09B2787D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl06Cw0ACgkQcqXauRfM
H+An0w//Q4KtKeIcM0VlPQLJQwrzQW+/MCa2zvA6oX0wErjkoM/UutGUjXUSJ6Ex
F9w2N/Bgeh0xSnxsFTa+tOO01/jOAZ2wBgd3BQfNg6reP3bZPCPqK+3Yoby4AoJC
7tK8zRXzN5NKalzN6/LUqRfQY1sx7oo11e+jTlPU76bh29NJo6oAG/RLyq4pi4vp
IOMDgGxUQeswRjhPIrkiimvOWnoaeWFFmcSKCLPW0eGGZyqKfjQAwlCUnoc6zHMU
WgQSXZBCXZZTvmYAzfIueYJf5190UOA8cI0qdYqCfNNAG2n+WQ94V5ncsHVupH39
NlX9mE9jA0RfeZLH/jBW8Tal2SSev5QtXeiToMpq7JU//iAi8saKr38JmcJnjc5I
DWnskRx7rf31bS3zz72Oyvc4y1KjDzPLLaj3qLKiGvuaBClfcjqWeP32FiTRKp8B
RVO28UoLfyoUwLvmRszu5K5bONzJm9OLloxuSBjVrwdLtrnP19SnCthx1eKHwQhX
mbtiTrLd9InvawT0YHJCEgr3jYA70reBMpt5zzPCd0bR9rGW/sz5x5BZScXbpT6u
3azhbfCjNWf9kSMSr+l6BlOJk1BSz/2p83T+xcZjxTs6KIZ/G0mE8gh7WRkEy2Gl
zuZRhSAyX0NeSjZ9OUKin7MD+vsSiOmHfCcV03gY33ne2Ns4aNg=
=jmKJ
-----END PGP SIGNATURE-----

--Apple-Mail=_3102B695-66DE-47D7-9462-8A6F09B2787D--
