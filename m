Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D50CE13C38
	for <lists+linux-ext4@lfdr.de>; Sun,  5 May 2019 00:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfEDWEF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 4 May 2019 18:04:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41507 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfEDWEE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 4 May 2019 18:04:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id k8so8035560lja.8
        for <linux-ext4@vger.kernel.org>; Sat, 04 May 2019 15:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=q4tdeygoQ7S6H46kXIKg8U5/5YFUjtxpJUhkCM6YBkE=;
        b=u8c72vT4guTtZOfbQfP4gHDA8eaky1141cMG39//l46bYJ1U8q28Y6lYd/P+ERag4J
         faiyEarHQmCkR+GalBHRJMQm8dlOl1zPrNsbKOF9QVY8hS5f6h9XOoSWXWiLUJ57j7bG
         CWDihAgAMcaedqAvq5AysP1mXdmzGH4ZXC2TOc5/BRJHUUgYGqICml49PTozjSEvkDrS
         n+dPRlrBJzXAxg4RLi/QPgh0KAT2L8gwR70zkYCnl5dtuJjt3qzmdPBTyIUjjzMMbTPC
         LWfAYBWWJeBbAJaSwFpHYzjNUJLlIwynXVhVvpsiR/Tp2mF22FtOGnCwb1zlvaXDqxk1
         thVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=q4tdeygoQ7S6H46kXIKg8U5/5YFUjtxpJUhkCM6YBkE=;
        b=HzOgZdgB+fsBo8xgURc62nItUdQWqi+8W70HcGGs91joTwtolxOmHCAG6bFrNJw820
         7sv+sJkxRB7J6uhOHFw1oHcSQtEly/OVEfGJHGW68gEjDp5GGbN8W5+f75prQdQ5Ugh8
         jhGi1BBiBJwg/qVrtjx/GEo3TgSswB6vShLs281/J53zb0JNcRPPSjY4ZGL7GVkycRXu
         uZN7gDAe6NKWjB/hIgLc/rXbJNHARC3KqtIOMTzL93Zsb4/TUsjeVIKdRiivXkF7AqHT
         obDAJkXwIIVmuqzFoArT6Eeh0rqgwh8Nbye9y1o/wBOSwA43QsJpSwirgaeluigdWh4B
         urhA==
X-Gm-Message-State: APjAAAX5vZHvGD5IM0C5gQL6rbh0W6aNr4ZW4I6hfTuFnjLwjbKUhA08
        bivUDghM2XYLNEAICVhGuYg=
X-Google-Smtp-Source: APXvYqwtr3JK7np5absessBK37aM+wYx64nXGJZzggXGU3FFtQSO2sSoArUmg71PG2m4L2DdGaIS1Q==
X-Received: by 2002:a2e:7318:: with SMTP id o24mr8523439ljc.138.1557007442684;
        Sat, 04 May 2019 15:04:02 -0700 (PDT)
Received: from [192.168.3.100] ([95.174.108.185])
        by smtp.gmail.com with ESMTPSA id t8sm1131120lfl.73.2019.05.04.15.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 15:04:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] e2fsck: Do not to be quiet if verbose option used.
From:   Alexey Lyashkov <alexey.lyashkov@gmail.com>
In-Reply-To: <20190504214944.GA10073@mit.edu>
Date:   Sun, 5 May 2019 01:04:00 +0300
Cc:     Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Alexey Lyashkov <c17817@cray.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DE86FFC8-0D93-46CC-B465-F8603921AD62@gmail.com>
References: <20190426130913.9288-1-c17828@cray.com>
 <20190428233847.GA31999@mit.edu>
 <5DF9A5AD-ADCA-452B-8242-FE43946002ED@gmail.com>
 <20190504214944.GA10073@mit.edu>
To:     Theodore Ts'o <tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


> 5 =D0=BC=D0=B0=D1=8F 2019 =D0=B3., =D0=B2 0:49, Theodore Ts'o =
<tytso@mit.edu> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):
>=20
> On Mon, Apr 29, 2019 at 07:16:36AM +0300, Alexey Lyashkov wrote:
>> Theodore,
>>=20
>> Usecase is simple. User use a -p with -v flag,
>> in this case, -p block any messages on console in case it =
successfully fixed.
>> It=E2=80=99s OK _without_ -v flag, situation is different with -v =
flag.
>> In this case, user expect to see mode debug info about check/fix =
process,
>> and =C2=ABno messages=C2=BB in this mode confuse a user, as he think =
=C2=ABno messages=C2=BB =3D=3D =C2=ABno bugs fixed=C2=BB,
>> but it=E2=80=99s not a true in common way.
>> =46rom other side, -p print a messages about fix process, but not for =
bitmaps, it=E2=80=99s source of additional
>> confuse for the user, as he lack an info about FS changes during =
e2fsck run.
>=20
> That's not a use case.   *Why* is the user using -p?
>=20
> The -p option is only intended to be used when called from boot
> scripts, where e2fsck is run in parallel
It=E2=80=99s not a true. -p option is good enough in run to run =
automatic fixes, for minor bugs, without relation to boot scripts.
-y option too soft, -n option - too strict, -p is good enough in common =
case for initial fix.
But anyway, is it run from boot scripts command output is logged and can =
be analyzed by automatic tools,
if it run by hand it will analyzed by user.=20
It=E2=80=99s very strange to have some output is in console, some output =
is omitted.
A specially in case user request a -v option.



---
Alex


