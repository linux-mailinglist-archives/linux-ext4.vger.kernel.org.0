Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A2458D868
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 13:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241432AbiHILxp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 07:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241223AbiHILxo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 07:53:44 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FAD2408E
        for <linux-ext4@vger.kernel.org>; Tue,  9 Aug 2022 04:53:43 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id b4so11429360pji.4
        for <linux-ext4@vger.kernel.org>; Tue, 09 Aug 2022 04:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MhTAURSUPBWnaSKcyWKFU+A5UniE5HexPukkaWbzBMw=;
        b=FjQ/OY5s6aMvHaS8BQfv9lipYuJ8oh5mpIbsWWiiZipMBaLtTKF7pbtW4N/0E0Qoq4
         vVkZ4esXrmnUkYwvzaonRLUhwHwYG8rZDzlVNVvSQBOAC5DgNzDSRTEZr8Y2lGB9Tr+U
         74jEtBQLLRTlx8IGV+D1pYUDwdzk52apOLfEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MhTAURSUPBWnaSKcyWKFU+A5UniE5HexPukkaWbzBMw=;
        b=yGUIiIWDy0mARrTfvbUoXJyFDtV54i5bF3Mh6koDA7sZaKBdCbTitcuvQT4pDXFeRL
         gMauDKlTf6HQLQXJkVHd2TTF6Hf7ZEkjN0kK0oVy/N9opNYxBeqONsNQ9Bhk3uEbaUAX
         N5BhRDSgumCzY/9GUh6/wL8i7Q8L8PRpL82/h1IokDuou4/mRBMjJ5sKf9k0aIatgpOD
         y28Agcc3ZeMCBBDyXhE8Xr6lOH14xbNUZoJX1HNAfh8XVTxHaRorpn7RpnbrAuWYQ9qT
         fD5vHYCxqAgq/Pa5RZqRLI/T7/wIIiAw7eM0Mwt40oolMgyky322AlDF1rcRb8DiJWvi
         JoIQ==
X-Gm-Message-State: ACgBeo2ngHlWs1zgP906aAvlPwAXXVD6AW27nFGzvm66+v7IRGuBpbti
        dnCnUX7YPlIFPbqiikW/nF1kZYQ5ESpKrA==
X-Google-Smtp-Source: AA6agR7rZ3dTXq9ibr+gEUNA/cDz++UWqyPCabykB2g95Xh4p0CPVkGX38yR0PZOG9r4eH7jqICBFQ==
X-Received: by 2002:a17:903:2685:b0:16e:da0a:9d8 with SMTP id jf5-20020a170903268500b0016eda0a09d8mr22828317plb.42.1660046022969;
        Tue, 09 Aug 2022 04:53:42 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:8d43:c739:457a:5504])
        by smtp.gmail.com with ESMTPSA id nm8-20020a17090b19c800b001f2fa09786asm9967720pjb.19.2022.08.09.04.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 04:53:42 -0700 (PDT)
Date:   Tue, 9 Aug 2022 20:53:36 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Jiri Slaby <jirislaby@kernel.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>, Jan Kara <jack@suse.com>,
        Ted Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Aleksey Romanov <AVRomanov@sberdevices.ru>
Subject: Re: ext2/zram issue [was: Linux 5.19]
Message-ID: <YvJKwCXewHmuWGdh@google.com>
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
 <702b3187-14bf-b733-263b-20272f53105d@kernel.org>
 <c7c69f77-4ea2-3375-33f3-322a3d35def5@kernel.org>
 <8710b302-9415-458d-f8a2-b78cc3a96e49@kernel.org>
 <YvIeLHuEb9XDSp6N@google.com>
 <YvIk3SdC7wP3uItR@google.com>
 <YvImxBsHJcpNzC+i@google.com>
 <20220809102011.pfhfb4k7tdkqvdai@CAB-WSD-L081021.sigma.sbrf.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809102011.pfhfb4k7tdkqvdai@CAB-WSD-L081021.sigma.sbrf.ru>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

On (22/08/09 10:20), Dmitry Rokosov wrote:
> I think oom-kill is an inevitable escape from low memory situation if we
> don't solve original problem with high memory consumption in the user
> setup. Reclaim-based zram slow path just delays oom if memory eating
> root cause is not resolved.
> 
> I totally agree with you that all patches which have visible user
> degradations should be reverted, but maybe this is more user setup
> problem, what do you think?

I'd go with the revert.
Jiri, are you going to send the revert patch or shall I handle it?

> If you make the decision to revert slow path removal patch, I would
> prefer to review the original patch with unneeded code removal again
> if you don't mind:
> https://lore.kernel.org/linux-block/20220422115959.3313-1-avromanov@sberdevices.ru/

Sure, we can return to it after the merge window.
