Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4C5B9818
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 21:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbfITTwc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 15:52:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45492 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729825AbfITTwb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Sep 2019 15:52:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so5180257pfb.12
        for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2019 12:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=gcNXvtSyWvuQ5LByHh2uePUN26jQ3PokWQXYeNMdTRo=;
        b=m/Dmg/JW+4n89iQLkwR9YixMDIeVf27zFQCHMeU2vrr/Vf/mPOfxnNvPfe3OPGVCIb
         JgAPKsXQJhnD7tFI5MlKzN2xVjy8lP1etFfFQJ6uqTzpoQ2zt6AqXypDzmNHpc8wPlxV
         crjt8+KJWIThyAPCT4EQPrvHrdHbinVspic5j9BKz5RbkcHdT9crv3tv4qpn/aE9eA1n
         PMBQ0OAdva2QoUZMRO40b1D4dh+MZ0oPBPl/uwt1PjK41QI5n4GP65bK/tOOocfdaOPb
         fW7AswBfwe7B/XRzdJs+JsavsZIwjqyEid+QSgHJFI3Ye2MQDRaVklFCyYyobPXtLX0a
         K9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=gcNXvtSyWvuQ5LByHh2uePUN26jQ3PokWQXYeNMdTRo=;
        b=RztEF8zqbxzCEVzayTXHOQ09mzyUPnhz7Sl0MmmfvudKs0CtaFyFtB68CySGNmsNVY
         6jvmJrQeIueaZ2zwDzxq8TbT0hIA67mojMaLyg9HkTgKMCXjUBeG1Gd9NTT4qoA4U6P1
         3fbjqou00jKq8mw5NXBp/wEGfwcn/DBVzYnedCQeWcc3ZE8OW6kr/8Dlo1NNUqg2dfD+
         9mVCmBwQzDNmcJtNzdmPA9/NAPUuLS9qvK2hf5oQ6zYz1ZTmqS3uQfMXc4+z8S/uJjTE
         c3DRazzxfV7kVqkWcLWBa7mWNXg6aL1fXwkWSRoTxxRE0BtgwWJz97mJznhy4Vi+OlHd
         lNSw==
X-Gm-Message-State: APjAAAXROZ62tVX6cq4JB5OhFVQB8k/C6h+iQdf5CmzmNTy3LW/9ubBO
        bm/eDri6/dGyHIaenSyld+lwxA==
X-Google-Smtp-Source: APXvYqxtb4M5gtpX7qWD4dcjCAwsr874h41gGdjXYxHCsHqxUWbY1aFs2BvIpYyEDF4qF+PsPWIWvw==
X-Received: by 2002:a62:cb:: with SMTP id 194mr20209663pfa.130.1569009150487;
        Fri, 20 Sep 2019 12:52:30 -0700 (PDT)
Received: from ?IPv6:2600:1010:b006:e11f:c970:783e:78af:e8f5? ([2600:1010:b006:e11f:c970:783e:78af:e8f5])
        by smtp.gmail.com with ESMTPSA id c20sm5107273pfd.122.2019.09.20.12.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 12:52:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and introduce getrandom2()
Date:   Fri, 20 Sep 2019 12:52:28 -0700
Message-Id: <C5BE6F0F-15B1-404B-A490-5B4E5C8C61A0@amacapital.net>
References: <20190920193740.GD1889@1wt.eu>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
In-Reply-To: <20190920193740.GD1889@1wt.eu>
To:     Willy Tarreau <w@1wt.eu>
X-Mailer: iPhone Mail (17A577)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



> On Sep 20, 2019, at 12:37 PM, Willy Tarreau <w@1wt.eu> wrote:
>=20
> =EF=BB=BFOn Fri, Sep 20, 2019 at 12:22:17PM -0700, Andy Lutomirski wrote:
>> Perhaps userland could register a helper that takes over and does
>> something better?
>=20
> If userland sees the failure it can do whatever the developer/distro
> packager thought suitable for the system facing this condition.
>=20
>> But I think the kernel really should do something
>> vaguely reasonable all by itself.
>=20
> Definitely, that's what Linus' proposal was doing. Sleeping for some time
> is what I call "vaguely reasonable".

I don=E2=80=99t buy it. We have existing programs that can deadlock on boot.=
 Just throwing -EAGAIN at them in a syscall that didn=E2=80=99t previously b=
lock does not strike me as reasonable.

>=20
>> If nothing else, we want the ext4
>> patch that provoked this whole discussion to be applied,
>=20
> Oh absolutely!
>=20
>> which means
>> that we need to unbreak userspace somehow, and returning garbage it to
>> is not a good choice.
>=20
> It depends how it's used. I'd claim that we certainly use randoms for
> other things (such as ASLR/hashtables) *before* using them to generate
> long lived keys thus we can have a bit more time to get some more
> entropy before reaching the point of producing these keys.

The problem is that we don=E2=80=99t know what userspace is doing with the o=
utput from getrandom(..., 0), so I think we have to be conservative. New ker=
nels need to work with old user code. It=E2=80=99s okay if they=E2=80=99re s=
lower to boot than they could be.

>=20
>> Here are some possible approaches that come to mind:
>>=20
>> int count;
>> while (crng isn't inited) {
>>  msleep(1);
>> }
>>=20
>> and modify add_timer_randomness() to at least credit a tiny bit to
>> crng_init_cnt.
>=20
> Without a timeout it's sure we'll still face some situations where
> it blocks forever, which is the current problem.

The point is that we keep the timer running by looping like this, which shou=
ld cause add_timer_randomness() to get called continuously, which should pre=
vent the deadlock.  I assume the deadlock is because we go into nohz-idle an=
d we sit there with nothing happening at all.

>=20
>> Or we do something like intentionally triggering readahead on some
>> offset on the root block device.
>=20
> You don't necessarily have such a device, especially when you're
> in an initramfs. It's precisely where userland can be smarter. When
> the caller is sfdisk for example, it does have more chances to try
> to perform I/O than when it's a tiny http server starting to present
> a configuration page.

What I mean is: allow user code to register a usermode helper that helps get=
 entropy. Or just convince distros to bundle some useful daemon that starts a=
t early boot and lives in the initramfs.

