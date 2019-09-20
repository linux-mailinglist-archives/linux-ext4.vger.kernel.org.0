Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA69B96DE
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 19:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405883AbfITR44 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 13:56:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42272 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405763AbfITR4z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Sep 2019 13:56:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id n14so7639186wrw.9;
        Fri, 20 Sep 2019 10:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qY7qcknINsjocYIa/PWR8hBMVXAmwo1bRiEaRDrmyeI=;
        b=A1MLQT7orfEpdJAAeFcB43DTfvCMWXQdqF6u5I2paCpnLeQ8ftUBK5ec3RxNoRkiNJ
         rXlYH9KkcvZwZwhw7fM7LD7TlbKEpB0//ID4iumo5QxntYOOdb/ak93gpN03L6R9tBlR
         5qzGTomTnBnpiHiKZ1mw7mYK05PDOzVHDTdimYJ48HdPbWNszv5ogpxaMaxPQn3QNHrB
         2DLDlgrj690kVAFVH2k+O2WQdggbEryD1E4TOBiYHR49P0reKFHZX9dhmr5KIJy1ERNe
         rhyPmYnSOdt427GZGBK7uGb5xGjjQhqH+A1tx1/YJAPolq2wC0969uiAIi7tsiLuMW29
         LzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qY7qcknINsjocYIa/PWR8hBMVXAmwo1bRiEaRDrmyeI=;
        b=VJW6CuZfx1NAcWIpQjSw+WjOd8hJZ+NkFWr9hDGQwbujYCf8fLo6gVcl98/JOZxN52
         SOijr1h306sMpyW7iB2dpKI/eEiTAkz2ROzk8bPxRwM88vrQMD6OV9NDR2WRNZqkCdZV
         aseltqJdcX6V1W2xppshj0C0cJpTANt/HbzFYnKtXbQ7nNTvF5nzui8SMm5b1lsAlyPm
         qix/0Hwsg20oJZqZ9a+3ZHQW4GChWEkPOSm9+PcbP5H3qkZpxEMS3Jt/jikAPmrcHn1d
         /3jG/3OsDlCHhwakTfAFzWZcr/HGF4iMLkvSEJPF/TaLPondOYLZ/EIeXZpHqTuvH4nP
         TszA==
X-Gm-Message-State: APjAAAVSnpj5kAghkUG6uCBGjW+ZEJvIcrxaRLZW6rEtf/RYuMDQm7Uk
        dHSR4bNwrk56TnzYwaHdXbM=
X-Google-Smtp-Source: APXvYqzmux/n5POtZ8Tlj5SQ4HxM51sUHuQo0RAtj3mEQh6+S5IuGFuuHpB+yZ6mx7J59FYrW2FUcQ==
X-Received: by 2002:a5d:6306:: with SMTP id i6mr12733499wru.323.1569002213818;
        Fri, 20 Sep 2019 10:56:53 -0700 (PDT)
Received: from pc (p200300D06F2D14AFB73B2116C2128354.dip0.t-ipconnect.de. [2003:d0:6f2d:14af:b73b:2116:c212:8354])
        by smtp.gmail.com with ESMTPSA id t123sm3391702wma.40.2019.09.20.10.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 10:56:53 -0700 (PDT)
Date:   Fri, 20 Sep 2019 19:56:46 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
Message-ID: <20190920175646.GA6969@pc>
References: <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
 <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc>
 <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190920134609.GA2113@pc>
 <20190920172609.GA1832@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920172609.GA1832@1wt.eu>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 20, 2019 at 07:26:09PM +0200, Willy Tarreau wrote:
> Hi Ahmed,
> 
> On Fri, Sep 20, 2019 at 03:46:09PM +0200, Ahmed S. Darwish wrote:
> > Problem is, glibc is still *really* slow in adopting linux syscall
> > wrappers, so I'm not optimistic about that...
> >
> > I still see the new system call as the sanest path, even provided
> > the cost of a new syscall number..
> 
> New syscalls are always a pain to deal with in userland, because when
> they are introduced, everyone wants them long before they're available
> in glibc. So userland has to define NR_xxx for each supported arch and
> to perform the call itself.
> 
> With flags adoption is instantaneous. Just #ifndef/#define, check if
> the flag is supported and that's done. The only valid reason for a new
> syscall is when the API changes (e.g. one extra arg, a la accept4()),
> which doesn't seem to be the case here. Otherwise please by all means
> avoid this in general.
> 

I see. Thanks a lot for the explanation above :)

--
Ahmed Darwish
