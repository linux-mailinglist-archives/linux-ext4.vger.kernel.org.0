Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8434FB05B4
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Sep 2019 00:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfIKWh6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Sep 2019 18:37:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53275 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfIKWh5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Sep 2019 18:37:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id q18so5245377wmq.3;
        Wed, 11 Sep 2019 15:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HmfwaYOiC9HXQ7rhxMAmYfcJeDu6+0YcclVqr2XtvDc=;
        b=qhvaH4IiStITf7Yf6O5qmQSmKz+Zrmo5L7dJ2WfgivxcfVe+mof2oxqJsxUZqVZjMw
         Y0Knh4iTewErOe1ZX1Y/IputAIIjcWqFOP23VQMTTnbX8PpLSAaq0hUScIF5sHwpdKQO
         Zy2EkmOJ7ObDMFRBgrLiHYXIS+OrA72YMakfYunPRR0oyv3UXmax9qdG96USEbH0YbJ0
         I37meN2beY1KNrs4/6zWHHjEg2oS0ZaT3BtV6xhaGwC7FO6IdwNeT1YfSZm2vgcPjpYI
         0BId+gdcbKpP4BAz0gOVFW9EMOervSn6mGQH/MLvtGKwQtgR6y6eTkxOdduKTvUHefFN
         0S6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HmfwaYOiC9HXQ7rhxMAmYfcJeDu6+0YcclVqr2XtvDc=;
        b=ZwgWnxgDkao0XdZETVF5fq9bOUtmR4hUHRP1u9y9l+hrMY0xLWYXpOSegWHWl8uxw5
         SGvo/30bwW7u9mlj1ke3Sy0QGSmx1gCoz8D0ty0MBg0zWCytJCJVG4oF9msC+jdmNs57
         JkZuZw1PIMCPH/Md3eJTMrbM951GE13jGRkWZ/vxQZwjUnyBlyavIJdsYtOz6E7VUWmC
         nMHhHfJicIbh8mt9I/CjoKxSr3zzeJ/njtpm2HPiFflg8S3fbpSMwru/kAeJwsiwMynU
         BrvVrr0vyMDLckT04dEIfOqvdMxTzdDQFJsqBSNINXnCys4JWTAsxQdduYF6AvsPCbGR
         fwlA==
X-Gm-Message-State: APjAAAViS9w3/cmY8kr/GRedSmJmbuFFS879WSfZg1NaBj+R9KwDH4Xz
        OCpopSllSPnrd9GoZ9xIdyyKFNgMQfM=
X-Google-Smtp-Source: APXvYqyX4N/skppMq0lJQo5b5KviPifscjLnRt+npDPgGWZzmA83iY4vuxxaS1mr9W4OYRAtkbbfQw==
X-Received: by 2002:a05:600c:29a:: with SMTP id 26mr5966846wmk.8.1568241475373;
        Wed, 11 Sep 2019 15:37:55 -0700 (PDT)
Received: from darwi-home-pc (p200300D06F2D14CBD4495B592C99C920.dip0.t-ipconnect.de. [2003:d0:6f2d:14cb:d449:5b59:2c99:c920])
        by smtp.gmail.com with ESMTPSA id u68sm6572693wmu.12.2019.09.11.15.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 15:37:54 -0700 (PDT)
Date:   Thu, 12 Sep 2019 00:37:47 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190911223747.GA2058@darwi-home-pc>
References: <CAHk-=whBQ+6c-h+htiv6pp8ndtv97+45AH9WvdZougDRM6M4VQ@mail.gmail.com>
 <20190910042107.GA1517@darwi-home-pc>
 <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc>
 <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu>
 <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <20190911214144.GA1840@darwi-home-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911214144.GA1840@darwi-home-pc>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 11, 2019 at 11:41:44PM +0200, Ahmed S. Darwish wrote:
> On Wed, Sep 11, 2019 at 05:45:38PM +0100, Linus Torvalds wrote:
[...]
> >
> > Well, even on a PC, sometimes rdrand just isn't there. AMD has screwed
> > it up a few times, and older Intel chips just don't have it.
> > 
> > So I'd be inclined to either lower the limit regardless -
> 
> ACK :)
> 
> > and perhaps make the "user space asked for randomness much too
> > early" be a big *warning* instead of being a basically fatal hung
> > machine?
> 
> Hmmm, regarding "randomness request much too early", how much is time
> really a factor here?
> 
> I tested leaving the machine even for 15+ minutes, and it still didn't
> continue booting: the boot is practically blocked forever...
> 
> Or is the thoery that hopefully once the machine is un-stuck, more
> sources of entropy will be available? If that's the case, then
> possibly (rate-limited):
> 
>   "urandom: process XX asked for YY bytes. CRNG not yet initialized"
>
     ^
     getrandom: ....

(since urandom always succeeds, even if CRNG is not inited, and
 it already prints a very similar warning in that case anyway..)

thanks,
--darwi
