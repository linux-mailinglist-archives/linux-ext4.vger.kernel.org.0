Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAEB212ABC8
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Dec 2019 12:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfLZLMf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Dec 2019 06:12:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39094 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfLZLMe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Dec 2019 06:12:34 -0500
Received: by mail-pf1-f195.google.com with SMTP id q10so13056282pfs.6
        for <linux-ext4@vger.kernel.org>; Thu, 26 Dec 2019 03:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=XahL6G9knLB2n8H5gfpDsu6npK96lVW0v/QhI2IvksY=;
        b=Qrbad0eHXMsPnR+ep/hgorsJ3L6/UQ2sMmnCFfDyOrsAH9gmPzUE+O/ihf8HbpmSe2
         XTzrt9NI9JS19AC2ejj62s6PJlqoV8uEkFI6B2EUziulBKnZacCpUAk85XIlOhuzwMod
         D2tJwuBtOKf6P6HWIp5IpVYx4zNvJMzTfIKblwY7wVhh16qcybT6pCb5d0nslb/ieDbZ
         u7ZkEeLPc4fuRT/8CZVYGWqVevBDB0co3tPF0ysPnFICrBTzawoFWnKIQwrRqnfbdaRN
         IKRYrNAXBxkF4wJNOjgBlxATJdf+ezJg0aMV4/CDo0nSqMEOnkf5Ory2Qm5ImGL5PdS1
         Yunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=XahL6G9knLB2n8H5gfpDsu6npK96lVW0v/QhI2IvksY=;
        b=Nk7bxXoM3jkyYM+G0DlLnTy7fmXpGkj2xeaV2s2rZ26/N3t8HMax+SQ/ykRV/G9gsM
         aGrT7dHEE9oL27LkYz+um7Y7+okSM81w/fwcO6vVpk1dfnDnHOtxyC7pXzpkqY8Q0cK2
         9P4K+UMe+7AjSiV93uLO/4EKrDMSYdJRn0g4BIXXtoyhTAO/yGXJJAeBifJ1BfilSNCS
         MGyGHEb0MEA4WnC6wik4fY51wqPx4OgfGIX3ui+Dl4ogf3YQRzsmyWimG7tV0Ez4vxNq
         1WLLvH2281XuJ1WwuwUvknunUxzqVsmRiSoaLX23SFnS2M52NZIF/25aIhb6+f/4kiK7
         9acw==
X-Gm-Message-State: APjAAAWy4RUYggTQ0QBfhjMp9XpmWeNYkV0f34hMgWCKVOtiejdltMzT
        L11FAE6F23IibO8aICdz18RBqA==
X-Google-Smtp-Source: APXvYqxMxc1hyWglZzwXvoW3reh+R+YzQsWl78Yfn6rauhrZAzzQW2YTb57MMRoRZn12XDGrddKtpA==
X-Received: by 2002:a63:ff20:: with SMTP id k32mr46522975pgi.448.1577358753722;
        Thu, 26 Dec 2019 03:12:33 -0800 (PST)
Received: from [25.170.118.188] ([172.58.27.172])
        by smtp.gmail.com with ESMTPSA id i3sm34346841pfo.72.2019.12.26.03.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2019 03:12:32 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 0/8] Rework random blocking
Date:   Thu, 26 Dec 2019 19:12:29 +0800
Message-Id: <888017FA-06A1-42EF-9FC0-46629138DA9E@amacapital.net>
References: <9872655.prSdhymlXK@positron.chronox.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Ted Ts'o <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
In-Reply-To: <9872655.prSdhymlXK@positron.chronox.de>
To:     =?utf-8?Q?Stephan_M=C3=BCller?= <smueller@chronox.de>
X-Mailer: iPhone Mail (17C54)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



> On Dec 26, 2019, at 5:29 PM, Stephan M=C3=BCller <smueller@chronox.de> wro=
te:
>=20
> =EF=BB=BFAm Montag, 23. Dezember 2019, 09:20:43 CET schrieb Andy Lutomirsk=
i:
>=20
> Hi Andy,
>>=20
>> There are some open questions and future work here:
>>=20
>> Should the kernel provide an interface to get software-generated
>> "true random" numbers?  I can think of only one legitimate reason to
>> use such an interface: compliance with government standards.  If the
>> kernel provides such an interface going forward, I think it should
>> be a brand new character device, and it should have a default mode
>> 0440 or similar.  Software-generated "true random numbers" are a
>> very limited resource, and resource exhaustion is a big deal.  Ask
>> anyone who has twiddled their thumbs while waiting for gnupg to
>> generate a key.  If we think the kernel might do such a thing, then
>> patches 5-8 could be tabled for now.
>=20
> What about offering a compile-time option to enable or disable such code?
> Note, with the existing random.c code base, there is no need to have a=20
> separate blocking_pool. The ChaCha20 DRNG could be used for that very same=
=20
> purpose, provided that in case these true random numbers are generated whe=
n=20
> the Chacha20 DRNG received an equal amount of "unused" entropy.

This scares me. The DRNG should be simple and easy to understand. If we=E2=80=
=99re tapping extra numbers in some weird way, then I would be more comforta=
ble with some clear assurance that this doesn=E2=80=99t break the security. I=
f we=E2=80=99re tapping numbers in the same way as normal urandom, then I do=
n=E2=80=99t really see the point.

>>=20
>> Alternatively, perhaps the kernel should instead provide a
>> privileged interface to read out raw samples from the various
>> entropy sources, and users who care could have a user daemon that
>> does something intelligent with them.  This would push the mess of
>> trying to comply with whatever standards are involved to userspace.
>> Userspace could then export "true randomness" via CUSE if it is so
>> inclined, or could have a socket with a well-known name, or whatever
>> else seems appropriate.
>=20
> With the patch set v26 of my LRNG I offer another possible alternative=20
> avoiding any additional character device file and preventing the starvatio=
n of=20
> legitimate use cases: the LRNG has an entropy pool that leaves different=20=

> levels of entropy in the pool depending on the use cases of this data.
>=20
> If an unprivileged caller requests true random data, at least 1024 bits of=
=20
> entropy is left in the pool. I.e. all entropy above that point is availabl=
e=20
> for this request type. Note, even namespaces fall into this category=20
> considering that unprivileged users can create a user name space in which t=
hey=20
> can become root.

This doesn=E2=80=99t solve the problem. If two different users run stupid pr=
ograms like gnupg, they will starve each other.

As I see it, there are two major problems with /dev/random right now: it=E2=80=
=99s prone to DoS (i.e. starvation, malicious or otherwise), and, because no=
 privilege is required, it=E2=80=99s prone to misuse. Gnupg is misuse, full s=
top. If we add a new unprivileged interface, gnupg and similar programs will=
 use it, and we lose all over again.

