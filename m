Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36D2D12BC35
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Dec 2019 03:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfL1CHO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Dec 2019 21:07:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:41368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfL1CHO (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 27 Dec 2019 21:07:14 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89275222C2
        for <linux-ext4@vger.kernel.org>; Sat, 28 Dec 2019 02:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577498833;
        bh=U/nAnG2hJ81tt6C4DRheFtDEpu00ZrtqXVwbAsZZP9M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1c6ghWj9lBinB1rJ06SZnLd56bVBBBe9bPlVBfLZzT9lOViU8sgKn5WWYaCABTVCU
         mV7JlPuz2lmd9hnM4J1CtbAGqIFv9gcLmZftS+0Wi0uiScZE3GN7E8NGM/yYR0L1wd
         RGzetWX/uhSMgeHn4e0hXigTRJ7NGS4dE6kAfqv4=
Received: by mail-wm1-f49.google.com with SMTP id p9so9498141wmc.2
        for <linux-ext4@vger.kernel.org>; Fri, 27 Dec 2019 18:07:13 -0800 (PST)
X-Gm-Message-State: APjAAAXcN0qDYItA2rgyVZCVcGSmaXxxS1FRTiKIojNv7oaDWXtKxuHQ
        +ev7WV8AFPdl3cZP+319+5u7z5QfTnsH/QypeD/K/Q==
X-Google-Smtp-Source: APXvYqxn3Rv02S1te2llnFcs0CQZm6YywFRNddMkZ5rLIdJvih5IqiGw4PeCUC2MXu651WWfDw7Wdf6pIKHDbHZ3lio=
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr21666330wmi.89.1577498831945;
 Fri, 27 Dec 2019 18:07:11 -0800 (PST)
MIME-Version: 1.0
References: <20191226140423.GB3158@mit.edu> <4048434.Q8HajmOrkZ@tauon.chronox.de>
 <20191227130436.GC70060@mit.edu> <15817620.rmTN4T87Wr@tauon.chronox.de> <20191227220857.GD70060@mit.edu>
In-Reply-To: <20191227220857.GD70060@mit.edu>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 27 Dec 2019 18:06:56 -0800
X-Gmail-Original-Message-ID: <CALCETrUyVx_qb2yYH8D_z1T2bVu5RAEr71G0MTzEksBKKM1QsA@mail.gmail.com>
Message-ID: <CALCETrUyVx_qb2yYH8D_z1T2bVu5RAEr71G0MTzEksBKKM1QsA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Rework random blocking
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Stephan Mueller <smueller@chronox.de>,
        Andy Lutomirski <luto@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 27, 2019 at 2:09 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:

> So if it's just for cryptographers, then let it all be done in
> userspace, and let's not make it easy for GPG, OpenSSL, etc., to all
> say, "We want TrueRandom(tm); we won't settle for less".  We can talk
> about how do we provide the interfaces so that those cryptographers
> can get the information they need so they can get access to the raw
> noise sources, separated out and named, and with possibly some way
> that the noise source can authenticate itself to the Cryptographer's
> userspace library/application.
>
> But all of this should probably not be in drivers/char/random.c, and
> we probably need to figure out a better kernel to userspace interface
> than what we have with /dev/hwrng.

I'm thinking of having a real class device and chardev for each hwrng
device.  Authentication is entirely in userspace: whatever user code
is involved can look at the sysfs hierarchy and decide to what extent
it trusts a given source.  This could be done based on bus topology or
based on anything else.

The kernel could also separately expose various noise sources, and the
user code can do whatever it wants with them.  But these should be
explicitly unconditioned, un-entropy-extracted sources -- user code
can run its favorite algorithm to extract something it believes to be
useful.  The only conceptually tricky bit is keeping user code like
this from interfering with the in-kernel RNG.

--Andy
