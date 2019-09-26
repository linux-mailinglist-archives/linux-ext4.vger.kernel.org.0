Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7C0BFAAD
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2019 22:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfIZUm3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Sep 2019 16:42:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42283 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbfIZUm3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Sep 2019 16:42:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id n14so262150wrw.9;
        Thu, 26 Sep 2019 13:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v7VtkEEG2LAz9vVB8MM5QKckRl92FYJ98jBUqUE9BwA=;
        b=u5spxzCLQa36RysMhpR/QTwiffH9apHOymwGEfBlshrnSYnVSdLYQTuKSRlBahGMTW
         kljWooiuX6R0VxnZ0cUGreGtbkLL9qX/hR9bgMaaO6BjvUQ2aXWDK1tGQ9rfNxbwiSSq
         fFKbhVrD0RlruSVqYVz4o7GMqXxhsRmZSh5NM7ExWQGIb1vFcF9k/a6uJppHVwmJvoAI
         DxBgnAhlPvJgoCw4QX6sBYfSFqmbXaqFKW0euCCzG5haAewy1g588lLp/JBDHpxMifyq
         hpWz6Qe4YXpxYViS+EpdOMW0DgRg2lSQ2sQAGcNWsWwEIQD/GGh4NnFfY4+bvjmZdkId
         VAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v7VtkEEG2LAz9vVB8MM5QKckRl92FYJ98jBUqUE9BwA=;
        b=ub8Q4e+gZZdS9Nb6S/YJKur5BZAIO11nucv7TYsw/TAi8u7Tis42rYwKFKqMXrz92a
         rT3O5eybi4b0wacHVAc+ZE+rBPOMXXM/kMTNn46qY7XlAjzYwNQdoha+/IhyKgaWS5id
         2y/edRJd2qZFjmfkjoIDJJCSXuD0W+XFn4600+F3Jw4pAwsZq9ScMq/CjrBK2xRyEfjB
         ZoYtnchxbnmwdP8TnnVSAqZoBs1FXLOP/qrAaNBbYr1tdOqTF8jK08RLvWopXR7tCMOK
         347i6wZePfwJM4gYAEsnnun7TD+fv9p2zn24eKCtq0tE060JmnxvG3CZp1HRICpj4Xby
         jYzg==
X-Gm-Message-State: APjAAAUuljqjaiGOTiPGguWGVUrisM0Ymuf4TvtPjpVTlLIsg+55EgXj
        ROHA1APvgZpDQMIam0f3Vmk=
X-Google-Smtp-Source: APXvYqx3sIDOdlofsaPVb8yY8fHJlIBsTAzoi31CxPZQoIgTKNLCuIpHCtrMLYLGQD0LcwEvLq25Nw==
X-Received: by 2002:a5d:6306:: with SMTP id i6mr243312wru.323.1569530546588;
        Thu, 26 Sep 2019 13:42:26 -0700 (PDT)
Received: from pc ([5.158.153.52])
        by smtp.gmail.com with ESMTPSA id r2sm5722658wma.1.2019.09.26.13.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 13:42:25 -0700 (PDT)
Date:   Thu, 26 Sep 2019 22:42:17 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Florian Weimer <fweimer@redhat.com>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Subject: [PATCH v5 0/1] random: getrandom(2): warn on large CRNG waits,
 introduce new flags
Message-ID: <20190926204217.GA1366@pc>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Summary / Changelog-v5:

  - Add the new flags GRND_INSECURE and GRND_SECURE_UNBOUNDED_INITIAL_WAIT
    to getrandom(2), instead of introducing a new getrandom2(2) system
    call, which nobody liked.

  - Fix a bug discovered through testing where "int ret =
    wait_event_interruptible_timeout(waitq, true, MAX_SCHEDULE_TIMEOUT)"
    returns failure (-1) due to implicit LONG_MAX => int truncation

  - WARN if a process is stuck on getrandom(,,flags=0) for more than 30
    seconds ... defconfig and bootparam configurable

  - Add documentation for "random.getrandom_wait_threshold" kernel param

  - Extra comments @ include/uapi/linux/random.h and random.c::getrandom.
    Explicit recommendations to *exclusively* use the new flags.

  - GRND_INSECURE never issue any warning, even if CRNG is not inited.
    Similarly for GRND_SECURE_UNBOUNDED_INITIAL_WAIT, no matter how
    big the unbounded wait is.

In a reply to the V4 patch, Linus posted a related patch [*] with the
following additions:

  - Drop the original random.c behavior of having each /dev/urandom
    "CRNG not inited" warning also _reset_ the crng_init_cnt entropy.

    This is not included in this patch, as IMHO this can be done as a
    separate patch on top.

 - Limit GRND_RANDOM max count/buflen to 32MB instead of 2GB.  This
   is very sane obviously, and can be done in a separate patch on
   top.

   This V5 patch just tries to be as conservative as possible.

 - GRND_WAIT_ENTROPY and GRND_EXCPLICIT: AFAIK these were primarily
   added so that getrandom(,,flags=0) can be changed to return
   weaker non-blocking crypto from non-inited CRG in a possible
   future.

   I hope we don't have to resort to that extreme measure.. Hopefully
   the WARN() on this patch will be enough in nudging distributions to
   enable more hwrng sources (RDRAND, etc.) .. and also for the
   user-space developres badly pointed at (hi GDM and Qt) to fix their
   code.

[*] https://lkml.kernel.org/r/CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com

Ahmed S. Darwish (1):
  random: getrandom(2): warn on large CRNG waits, introduce new flags

 .../admin-guide/kernel-parameters.txt         |   7 ++
 drivers/char/Kconfig                          |  60 ++++++++++-
 drivers/char/random.c                         | 102 +++++++++++++++---
 include/uapi/linux/random.h                   |  27 ++++-
 4 files changed, 177 insertions(+), 19 deletions(-)

--
2.23.0
