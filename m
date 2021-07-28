Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583E63D8FEE
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jul 2021 15:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbhG1N4j (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Jul 2021 09:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237062AbhG1N4R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Jul 2021 09:56:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE25C06179A
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jul 2021 06:56:10 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h2so4145186lfu.4
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jul 2021 06:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2spCQlGIIyDMzwX9GHs7oboA0mpClVfV8LFnPHsvwLU=;
        b=adcTtckUyFxF/t7i/yj/HFHGcMcpHJLATcO21QulgzlqKjpwBL6itaNmGk3EVfVPcc
         B6hkIsNWLNtpw/TDcvUo6Xnpg88qtB4K7CRMdP0uKveNGwVL0J68sjibGAUfC6NHX5Xl
         tRlomQ22DTIqj3K14UoHOSubnHtVbNl2jyHCyx6eRCOXOiAu2WulPKk3D7lI8LQu87ch
         uN5EVTi9MWHyzeBrOlaXQYgJ+rWWMTLiI4p5qfcav2uIqp5P2+mkGoCmza33zbuDEDnJ
         yP6ZDVQkQtyVvAfNEv8w2UfFP+L/T17L4gWY9XKn3LWpYRxAzqdn6N7qTGOMHOlTUXWd
         OyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2spCQlGIIyDMzwX9GHs7oboA0mpClVfV8LFnPHsvwLU=;
        b=eRWPVyhkyS8Lwb0DD/wqlrgUuZD+mJb0jvhIID1oN7WXQeHZkFamX1xgr7q4zmYdxU
         PD3eZx9ZM5FAHSaM1UcCGpXcKjG+nQ+WShT8j7v7Px9DCdteGH99eWksqaPIznkEn6be
         V25BaDw0ojcH5OF2n88DAlA0v0LWUhc0UmZnxq0ANeq3+m4CmNE1sLtH4zIqG+t2YIGm
         diFCACdnLVSiEe3Xumz5D6yACKw/EaAoQXrgm/Uo3bIkvxMceBFzlyq4SD+NN1q2QEmg
         kESltMYU32CWbLKvltyOipNfTN/MVnHE2ZC6u8xdqpJJOEkx4LCz64YCr5kgDKnlVpRw
         IsZg==
X-Gm-Message-State: AOAM532gUnZbepxHX66wNTmRwAFTCXrQDVa5+2mxIBUdl9kOmLFC+j3P
        tO+3URjXPrqkx4l75YezhPaYxe/0lCvXlA==
X-Google-Smtp-Source: ABdhPJxzM+7hGlm6xCXR0QzPoAW/Pvo6WCPMJuVksG1DXYMtGFnpG0NrhJQmfUaMTzk2FDVbKKxI6A==
X-Received: by 2002:ac2:5504:: with SMTP id j4mr21511140lfk.220.1627480569124;
        Wed, 28 Jul 2021 06:56:09 -0700 (PDT)
Received: from [192.168.2.192] ([62.33.81.195])
        by smtp.gmail.com with ESMTPSA id n27sm7384lfq.302.2021.07.28.06.56.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jul 2021 06:56:08 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: bug with large_dir in 5.12.17
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <YPl/boTCfc3rlJLU@fisica.ufpr.br>
Date:   Wed, 28 Jul 2021 16:56:05 +0300
Cc:     linux-ext4@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EFDE04D0-D71A-4E23-96CA-8DBB98DA54E3@gmail.com>
References: <YPl/boTCfc3rlJLU@fisica.ufpr.br>
To:     Carlos Carvalho <carlos@fisica.ufpr.br>
X-Mailer: Apple Mail (2.3445.104.21)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

I have reproduced the issue on the master head

# git rev-parse HEAD
f158f8962ed7e884fa168f354c488f3afa3eb6db

Here is a reproducer. Not perfect bash script, but reproduce the problem =
well

#!/bin/bash =20
dir_path=3D/mnt/ext4/
cd $dir_path
i=3D0
target_file=3D$dir_path/foofile$i
touch $target_file
while test $i -lt 100000000 ; do
        if test $((i % 40000)) -eq 0; then
                echo "$i names created"
                target_file=3D$dir_path/foofile$i
                touch $target_file
        fi
    lncom=3D`printf "ln $target_file n%0253u\n" $i`
    `$lncom`
    i=3D$((i + 1))
done

Without large_dir option 1504565 files created and then I got no space

1480000 names created
ln: failed to create hard link =
'n000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000001504566': No space left on device
ln: failed to create hard link

[root@CO82 ~]# ls /mnt/ext4/ | wc -l
1510070
[root@CO82 ~]#

=20
When I enabled large_dir and used the same script, but started from =
I=3D1600000


Some amount (36526) of names were created and finally  this error =
happened.

sh ~/filldir.sh
1600000 names created
ln: failed to create hard link =
'n000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000001636527' =3D> '/mnt/ext4//foofile1600000': =
Structure needs cleaning
ln: failed to access =
'n000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000001636797': Structure needs cleaning

=46rom dimes

[27927.219844] EXT4-fs (loop1): mounted filesystem with ordered data =
mode. Opts: (null). Quota mode: none.
[28058.315171] EXT4-fs error (device loop1): dx_probe:887: inode #2: =
block 147359: comm ln: directory leaf block found instead of index block
[28059.414053] EXT4-fs error (device loop1): dx_probe:887: inode #2: =
block 147359: comm ln: directory leaf block found instead of index block
[28059.627589] EXT4-fs error (device loop1): dx_probe:887: inode #2: =
block 147359: comm ln: directory leaf block found instead of index block

>are you able to reproduce this error on a new directory that did not =
hit
the 2-level htree limit before enabling large_dir, or did you only see =
this
with directories that hit the 2-level htree limit before the update?

I am executing this test now. Will report shortly.

Best regards,
Artem Blagodarenko
> On 22 Jul 2021, at 17:23, Carlos Carvalho <carlos@fisica.ufpr.br> =
wrote:
>=20
> There is a bug when enabling large_dir in 5.12.17. I got this during a =
backup:
>=20
> index full, reach max htree level :2
> Large directory feature is not enabled on this filesystem
>=20
> So I unmounted, ran tune2fs -O large_dir /dev/device and mounted =
again. However
> this error appeared:
>=20
> dx_probe:864: inode #576594294: block 144245: comm rsync: directory =
leaf block found instead of index block
>=20
> I unmounted, ran fsck and it "salvaged" a bunch of directories. =
However at the
> next backup run the same errors appeared again.
>=20
> This is with vanilla 5.2.17.

