Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A118B9C8A
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Sep 2019 08:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbfIUGHY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Sep 2019 02:07:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730891AbfIUGHV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 21 Sep 2019 02:07:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37FF518C4269;
        Sat, 21 Sep 2019 06:07:18 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-24.ams2.redhat.com [10.36.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D86AB5D9C9;
        Sat, 21 Sep 2019 06:07:13 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and introduce getrandom2()
References: <20190912034421.GA2085@darwi-home-pc>
        <20190912082530.GA27365@mit.edu>
        <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
        <20190914122500.GA1425@darwi-home-pc>
        <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
        <20190915052242.GG19710@mit.edu>
        <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
        <20190918211503.GA1808@darwi-home-pc>
        <20190918211713.GA2225@darwi-home-pc>
        <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
        <20190920134609.GA2113@pc>
        <CALCETrWvE5es3i+to33y6jw=Yf0Tw6ZfV-6QWjZT5v0fo76tWw@mail.gmail.com>
        <CAHk-=wgW8rN2EVL_Rdn63V9vQO0GkZ=RQFeqqsYJM==8fujpPg@mail.gmail.com>
        <CALCETrV=4TX2a4uV5t2xOFzv+zM_jnOtMLJna8Vb7uXz6S=wSw@mail.gmail.com>
        <CAHk-=wjpTWgpo6d24pTv+ubfea_uEomX-sHjjOkdACfV-8Nmkg@mail.gmail.com>
Date:   Sat, 21 Sep 2019 08:07:12 +0200
In-Reply-To: <CAHk-=wjpTWgpo6d24pTv+ubfea_uEomX-sHjjOkdACfV-8Nmkg@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 20 Sep 2019 11:09:53 -0700")
Message-ID: <87blvefai7.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Sat, 21 Sep 2019 06:07:18 +0000 (UTC)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Linus Torvalds:

> Violently agreed. And that's kind of what the GRND_EXPLICIT is really
> aiming for.
>
> However, it's worth noting that nobody should ever use GRND_EXPLICIT
> directly. That's just the name for the bit. The actual users would use
> GRND_INSECURE or GRND_SECURE.

Should we switch glibc's getentropy to GRND_EXPLICIT?  Or something
else?

I don't think we want to print a kernel warning for this function.

Thanks,
Florian
