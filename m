Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7E4BFAFF
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2019 23:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfIZVjs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Sep 2019 17:39:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44365 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfIZVjs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Sep 2019 17:39:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id q15so171923pll.11
        for <linux-ext4@vger.kernel.org>; Thu, 26 Sep 2019 14:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pV3FpOkzQQShFchCizZU5uBqu5oBWsYmqNuxn4zVKE0=;
        b=jnhaxzY0nbeEfwC0YxWNeRsOp4zuQvYFIAMbEG9AfmqyweYDxWl6q9OUYLiv0X9Ast
         RYYcMlrDcrZe7lEWnkCrXIYogRFQZTtGSNzBhC82OYBMcMwMoG2Zmm/WK/Qo6xfEWxdu
         L3x7eB2Ce0grk3AIFqnc55/ymysWQRa+0ivsOj4qhhpfUW4IEx/4QXJOfvujZaoJzXPq
         Rt44yB1jOWf3RMWAW5Hs4wKCyFMEz5Ck0UGOMXFGocH/hsfSnZ7lYvlR0oqPYd3RodO/
         370pEnAp9ACCLkwT+zJwfdT1Os36rwM3VJj3jZMWKGWRm/rPpV3bmybmy7Icaf+iD5b/
         GQdg==
X-Gm-Message-State: APjAAAXTqRcNgShkgJYbDMXOwHI4XJKsvx1k/DcVOHIg6uQsWERqHPj0
        g5j6FPN2jF2k4LQ8LPiIG+RnPA==
X-Google-Smtp-Source: APXvYqy7KKyqlGOIFQNurRPuS4kxCwCBpKPXcUca5a9bY2uqtM2zEYAnQC8MtusRwyL7ipme3Xtx0w==
X-Received: by 2002:a17:902:82cb:: with SMTP id u11mr729185plz.313.1569533987366;
        Thu, 26 Sep 2019 14:39:47 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:3602:86ff:fef6:e86b? ([2601:646:c200:1ef2:3602:86ff:fef6:e86b])
        by smtp.googlemail.com with ESMTPSA id v8sm9595132pje.6.2019.09.26.14.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 14:39:46 -0700 (PDT)
Subject: Re: [PATCH v5 1/1] random: getrandom(2): warn on large CRNG waits,
 introduce new flags
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Florian Weimer <fweimer@redhat.com>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
References: <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
 <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc> <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190926204217.GA1366@pc> <20190926204425.GA2198@pc>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <9a9715dc-e30b-24fb-a754-464449cafb2f@kernel.org>
Date:   Thu, 26 Sep 2019 14:39:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190926204425.GA2198@pc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 9/26/19 1:44 PM, Ahmed S. Darwish wrote:
> Since Linux v3.17, getrandom(2) has been created as a new and more
> secure interface for pseudorandom data requests.  It attempted to
> solve three problems, as compared to /dev/urandom:
> 
>    1. the need to access filesystem paths, which can fail, e.g. under a
>       chroot
> 
>    2. the need to open a file descriptor, which can fail under file
>       descriptor exhaustion attacks
> 
>    3. the possibility of getting not-so-random data from /dev/urandom,
>       due to an incompletely initialized kernel entropy pool
> 
> To solve the third point, getrandom(2) was made to block until a
> proper amount of entropy has been accumulated to initialize the CRNG
> ChaCha20 cipher.  This made the system call have no guaranteed
> upper-bound for its initial waiting time.
> 
> Thus when it was introduced at c6e9d6f38894 ("random: introduce
> getrandom(2) system call"), it came with a clear warning: "Any
> userspace program which uses this new functionality must take care to
> assure that if it is used during the boot process, that it will not
> cause the init scripts or other portions of the system startup to hang
> indefinitely."
> 
> Unfortunately, due to multiple factors, including not having this
> warning written in a scary-enough language in the manpages, and due to
> glibc since v2.25 implementing a BSD-like getentropy(3) in terms of
> getrandom(2), modern user-space is calling getrandom(2) in the boot
> path everywhere (e.g. Qt, GDM, etc.)
> 
> Embedded Linux systems were first hit by this, and reports of embedded
> systems "getting stuck at boot" began to be common.  Over time, the
> issue began to even creep into consumer-level x86 laptops: mainstream
> distributions, like Debian Buster, began to recommend installing
> haveged as a duct-tape workaround... just to let the system boot.
> 
> Moreover, filesystem optimizations in EXT4 and XFS, e.g. b03755ad6f33
> ("ext4: make __ext4_get_inode_loc plug"), which merged directory
> lookup code inode table IO, and very fast systemd boots, further
> exaggerated the problem by limiting interrupt-based entropy sources.
> This led to large delays until the kernel's cryptographic random
> number generator (CRNG) got initialized.
> 
> On a Thinkpad E480 x86 laptop and an ArchLinux user-space, the ext4
> commit earlier mentioned reliably blocked the system on GDM boot.
> Mitigate the problem, as a first step, in two ways:
> 
>    1. Issue a big WARN_ON when any process gets stuck on getrandom(2)
>       for more than CONFIG_GETRANDOM_WAIT_THRESHOLD_SEC seconds.
> 
>    2. Introduce new getrandom(2) flags, with clear semantics that can
>       hopefully guide user-space in doing the right thing.
> 
> Set CONFIG_GETRANDOM_WAIT_THRESHOLD_SEC to a heuristic 30-second
> default value. System integrators and distribution builders are deeply
> encouraged not to increase it much: during system boot, you either
> have entropy, or you don't. And if you didn't have entropy, it will
> stay like this forever, because if you had, you wouldn't have blocked
> in the first place. It's an atomic "either/or" situation, with no
> middle ground. Please think twice.

So what do we expect glibc's getentropy() to do?  If it just adds the 
new flag to shut up the warning, we haven't really accomplished much.
