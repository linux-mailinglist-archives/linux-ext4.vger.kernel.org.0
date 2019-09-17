Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E34EB572C
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 22:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbfIQUwo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 16:52:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40829 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfIQUwn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 16:52:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id b24so22071wmj.5;
        Tue, 17 Sep 2019 13:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ApT0kSwd0qDPrpu8YD2GohWeJamU26dBJ+jJSNS2N/w=;
        b=Cw4D9QTM40QeSn5ag5Fy7naFWlT8CuE4Jc/VpV9ujyw+3wxs7IFqglZv4uqz6yJqKm
         6ivRok4vGvWJWcKJpZM1ivrr33Pec+rCj0so6jzFdaVyD4Cax89Iv+Xt/91shEaJ1em5
         jcCKhzicru/qAfkEN4GSeVGEO4hmgot0g2dt4xdTQwpZxfFEUgmGFh1BfkBG9Sc1Mk+0
         GMLBMW2RmDs1S+Hr6z5v49Jy49YlrzqanorxZFwdsrAqSFvGGm7Xcn1kVozVWRDO1/zd
         wVeKfHfGDLfKDQShYHG5XVVivYtqBa/C6af5JDz8B5zh9vGE+Ju7pQsLL3rwFQZblCsB
         ylAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ApT0kSwd0qDPrpu8YD2GohWeJamU26dBJ+jJSNS2N/w=;
        b=EqzqVRfPlSisxo1tc7arKeagaX5gxCW9HBr9m8IrrH1Kx9R7oNYP6RXsU3YrRkhSRQ
         Gr5MxrxNzA79Ioqq1Nfs+YtaGHOFIuCPgKrHaXOmJiYLCHRjJhjyne0uuD0jVWpYib40
         q6iCw3TTBodn1IDDET34qetKI+4K1qNhZIqP4AKI8NMCuzYE7w5OgVdcuDliJy2BnjVs
         04fBMnWrPVZo6VaOJUVc7sR7CM+lPJv+xeA/9y8iuW06XPdvQSMWTassfjRnUYMbP797
         IGr+uaXTDJ8/ZL3+tN5sdi+wZXD9tAZe/cZjUYU11Jl6/AjZffJ31G401LmCZ5dRLvPX
         7rZw==
X-Gm-Message-State: APjAAAVMoya+/PD3H3AKoNPftdoXGaYYYX7DwXrv6fRo/5TBjcaMauVe
        O8M7Ub9ZYKg2pVaAYIdIcEc=
X-Google-Smtp-Source: APXvYqyFO//Zh6kStyRWZE1zRsXqFhQBmSoIvCWsjebAToll90pLtRXxEqs6I7c7Z0FUscm7OwWz1g==
X-Received: by 2002:a1c:1d8d:: with SMTP id d135mr18289wmd.7.1568753561336;
        Tue, 17 Sep 2019 13:52:41 -0700 (PDT)
Received: from darwi-home-pc (p200300D06F2D143EC08AA0470B895785.dip0.t-ipconnect.de. [2003:d0:6f2d:143e:c08a:a047:b89:5785])
        by smtp.gmail.com with ESMTPSA id j1sm5256090wrg.24.2019.09.17.13.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 13:52:40 -0700 (PDT)
Date:   Tue, 17 Sep 2019 22:52:34 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190917205234.GA1765@darwi-home-pc>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <20190917174219.GD31798@gardel-login>
 <CAHk-=wjABG3+daJFr4w3a+OWuraVcZpi=SMUg=pnZ+7+O0E2FA@mail.gmail.com>
 <2658007.Cequ2ms4lF@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2658007.Cequ2ms4lF@merkaba>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 17, 2019 at 10:28:47PM +0200, Martin Steigerwald wrote:
[...]
> 
> I don't have any kernel logs old enough to see whether whether crng init
> times have been different with Systemd due to asking for randomness for
> UUID/hashmaps.
>

Please stop claiming this. It has been pointed out to you, __multiple
times__, that this makes no difference. For example:

    https://lkml.kernel.org/r/20190916024904.GA22035@mit.edu
    
    No. getrandom(2) uses the new CRNG, which is either initialized,
    or it's not ... So to the extent that systemd has made systems
    boot faster, you could call that systemd's "fault".

You've claimed this like 3 times before in this thread already, and
multiple people replied with the same response. If you don't get the
paragraph above, then please don't continue replying further on this
thread.

thanks,

-- 
Ahmed Darwish
http://darwish.chasingpointers.com
