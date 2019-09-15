Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3BCB2EF9
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 09:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfIOH1T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 03:27:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37043 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfIOH1S (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Sep 2019 03:27:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id i1so35179307wro.4;
        Sun, 15 Sep 2019 00:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1aCBRCt6dPgfb+9wTTAqzCnn4saTlIOx+pRnOlimELM=;
        b=p5JDHkXgMkVRdsCVo83bSLHJmo4Uo4OApsBhA5xesxywsxp0QzHoRH/TVIfJhZtrwx
         1xGcfn9y+lP20fHBlvgnw3WkojUx3YMLXicytjfTbK4ca+HNFnch/CZfx/rCPFhE/YYb
         asX7MMJc+ULN1vSnOzQS5090zbw1tFI6yxbSXqVAeR9J3AGjVrpFWJ4xZiYYSW2dO9DJ
         rrQukuAwK+9qDg2/H6P8JefbAb/4mLcblYCks/wZtUeWdyfIuKdmSOIW8Q2No/fo08d0
         wJGiCTXzZEME7so1JsqqHp65K9WwPpDBA+jqnW12+hNKgb7YcDoDFJcIPxOgCirGUjy0
         NI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1aCBRCt6dPgfb+9wTTAqzCnn4saTlIOx+pRnOlimELM=;
        b=XciOqriQr0td3d23oTlYTtpaKAWgl9VU2sM9zxMLMsQv/81pHqrSKTYAfwz3+ru5tq
         QBzv9z06s4JlrI/wgzxnlWXLdr4vzGeSGku4DTYDPN7qqenTd4ZcevQaiEsL58o1UiQQ
         9DoSlroVeDD5vAjSbmWSsermUH8optnjSKf0VwkPsaaWWQdc7KrHX0eigdGpDmphjcIA
         dtkfmM0qJ2qKvic8KGRugqngQh6LpDlFMFEPbTOeJpK4aC9C4B/VyAjHMpfy0T+OhgYn
         QIE8/erDY0DwZJjcFAyXTFd+wTFX6KEmyd4SEqJtQ3p/z8HCtyrbdOOsFLKVA1jr0Gbb
         Fjvw==
X-Gm-Message-State: APjAAAVqGZX6pBgS6afib2eeYaIixD2Y0SZGKbkBwGpRO2uth99Lbvtp
        Rbef3QArLslPb562oO9oXiw=
X-Google-Smtp-Source: APXvYqzHqvmZApQdOXGk7nsmMB3ZaPZIn/qNVv/npX47PFm/F1pqpDTe3QDeqywyy/dXkxVWmtzXCA==
X-Received: by 2002:adf:f1c3:: with SMTP id z3mr7931391wro.147.1568532436020;
        Sun, 15 Sep 2019 00:27:16 -0700 (PDT)
Received: from darwi-home-pc (p200300D06F2D1401AF0812D8DEE03BEC.dip0.t-ipconnect.de. [2003:d0:6f2d:1401:af08:12d8:dee0:3bec])
        by smtp.gmail.com with ESMTPSA id d193sm12446753wmd.0.2019.09.15.00.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 00:27:15 -0700 (PDT)
Date:   Sun, 15 Sep 2019 09:27:05 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190915072705.GA12869@darwi-home-pc>
References: <20190911160729.GF2740@mit.edu>
 <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc>
 <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190915065142.GA29681@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915065142.GA29681@gardel-login>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 15, 2019 at 08:51:42AM +0200, Lennart Poettering wrote:
> On Sa, 14.09.19 09:30, Linus Torvalds (torvalds@linux-foundation.org) wrote:
[...]
> 
> And please don't break /dev/urandom again. The above code is the ony
> way I see how we can make /dev/urandom-derived swap encryption safe,
> and the only way I can see how we can sanely write a valid random seed
> to disk after boot.
>

Any hope in making systemd-random-seed(8) credit that "random seed
from previous boot" file, through RNDADDENTROPY, *by default*?

Because of course this makes the problem reliably go away on my system
too (as discussed in the original bug report, but you were not CCed).

I know that by v243, just released 12 days ago, this can be optionally
done through SYSTEMD_RANDOM_SEED_CREDIT=1. I wonder though if it can
ever be done by default, just like what the BSDs does... This would
solve a big part of the current problem.

> Lennart

thanks,

-- 
darwi
http://darwish.chasingpointers.com
