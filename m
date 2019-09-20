Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43814B972B
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 20:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406507AbfITS34 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 14:29:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43726 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405022AbfITS34 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Sep 2019 14:29:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id a2so5043735pfo.10
        for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2019 11:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=su37uabqeDyNPGVbSy4LqMylRvJekDBMIJQOmAbSrms=;
        b=okqPnLwcRVFAFawtFpNAsOM/l6PAjdVUI4aWBFLH6PcKUlwJPqfVibKuhiLaiEvyjX
         YF3vdcFzm7VQGbWu8A1tmTfWurx0OPEZRuO0HCKGaCCaas0wF0nNqk71cq8AmBT9tCfv
         cvAI8wimfyvmpY7+b9mDlhkTr+z95vp6N7iSCSpPu9L+UbGYirqBsaMxfA6CpV7EqYvi
         g7IgYjddC3+CAWtIVG2TORJCXBBiZL0DUy1lNplzldwBX8vlKQ12d5acnX5K/atIF2cg
         16Suk191AECRxh3jGrkh/Gm7hxi1wY7zn0I2TfuJYtkDAo33tKLNzHxAThuUFgY3qINM
         xLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=su37uabqeDyNPGVbSy4LqMylRvJekDBMIJQOmAbSrms=;
        b=kRls/K9mtsUiUeNjpQ+7qRnQIMzWrGwaSSq1S5u/M1HtdLaTuxGKCdtoHtsccII9ny
         ntTiK6xx2JwKySdVrLO8hYRmSf/fbtyu/VLWz2brPBPMHR73hAbTkWHMABBSbLbruKFq
         QLzQR9VNh+wk0fTSGNpn9xOL1x3lEOfjcsP2es/eutiyZzkzTbOs8et6W9fcUKSuMuqG
         DTi6150jaQr0pKqmg8OEVY94MzNYwmGgVGKMltU1cri7mGXfyf/YggxNFGDBRdjLt+WO
         h2KwnsnuJDkgACoRC/FA1YAX2Vn4WA9e3syA5yU/QaB/C0JKP1tYGY/6a14mITIpTRb5
         d+UQ==
X-Gm-Message-State: APjAAAWqkjLzrRwKBgBKdSNaB0La5gtiXyziaqO20Ex0AqgQglQxESBE
        8Q4l7FGyWkbXLyg32OqjJXWBlw==
X-Google-Smtp-Source: APXvYqw+IQcWT5VEowqn7ypP2rDJ8xYsWnAzjXoY3fTO9SwtB8M9afvxyLB0ZPbfNcYita9kGI3xpg==
X-Received: by 2002:a62:1888:: with SMTP id 130mr19342667pfy.72.1569004195553;
        Fri, 20 Sep 2019 11:29:55 -0700 (PDT)
Received: from ?IPv6:2600:1010:b006:e11f:c970:783e:78af:e8f5? ([2600:1010:b006:e11f:c970:783e:78af:e8f5])
        by smtp.gmail.com with ESMTPSA id 74sm2391968pfy.78.2019.09.20.11.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 11:29:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and introduce getrandom2()
Date:   Fri, 20 Sep 2019 11:29:52 -0700
Message-Id: <7D3731D2-348F-4561-A52D-AA7DAAEE258B@amacapital.net>
References: <78a4b774-ef6b-62cb-57db-8e1ff8d29f72@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
In-Reply-To: <78a4b774-ef6b-62cb-57db-8e1ff8d29f72@gmail.com>
To:     "Alexander E. Patrakov" <patrakov@gmail.com>
X-Mailer: iPhone Mail (17A577)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



> On Sep 20, 2019, at 11:15 AM, Alexander E. Patrakov <patrakov@gmail.com> w=
rote:
>=20
> =EF=BB=BF20.09.2019 22:52, Andy Lutomirski =D0=BF=D0=B8=D1=88=D0=B5=D1=82:=

>> I think that, given existing software, we should make two or three
>> changes to fix the basic problems here:
>> 1. Add GRND_INSECURE: at least let new applications do the right thing
>> going forward.
>> 2. Fix what is arguably a straight up kernel bug, not even an ABI
>> issue: when a user program is blocking in getrandom(..., 0), the
>> kernel happily sits there doing absolutely nothing and deadlocks the
>> system as a result.  This IMO isn't an ABI issue -- it's an
>> implementation problem.  How about we make getrandom() (probably
>> actually wait_for_random_bytes()) do something useful to try to seed
>> the RNG if the system is otherwise not doing IO.
>> 3. Optionally, entirely in user code: Get glibc to add new *library*
>> functions: getentropy_secure_blocking() and getentropy_insecure() or
>> whatever they want to call them.  Deprecate getentropy().
>> I think #2 is critical.  Right now, suppose someone has a system that
>> neets to do a secure network request (a la Red Hat's Clevis).  I have
>> no idea what Clevis actually does, but it wouldn't be particularly
>> crazy to do a DH exchange or sign with an EC key to ask some network
>> server to help unlock a dm-crypt volume.  If the system does this at
>> boot, it needs to use getrandom(..., 0), GRND_EXPLICIT, or whatever,
>> because it NEEDS a secure random number.  No about of ABI fiddling
>> will change this.  The kernel should *work* in this case rather than
>> deadlocking.
>=20
> Let me express a little bit of disagreement with the logic here.
>=20
> I do agree that #2 is critical, and the Clevis use case is a perfect examp=
le why it is important. I doubt that it is solvable without trusting jitter e=
ntropy, or without provoking a dummy read on a random block device, just for=
 timings, or maybe some other interaction with the external world - but Will=
y already said "it seems fishy". However, _if_ it is solved, then we don't n=
eed GRND_INSECURE, because solving #2 is equivalent to magically making secu=
re random numbers always available.
>=20
>=20

I beg to differ. There is a big difference between =E2=80=9Cdo your best *ri=
ght now*=E2=80=9D and =E2=80=9Cgive me a real secure result in a vaguely tim=
ely manner=E2=80=9D.

For example, the former is useful for ASLR or hash table randomization. The l=
atter is not.=
