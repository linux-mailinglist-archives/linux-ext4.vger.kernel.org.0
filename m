Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D923D58D960
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 15:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243154AbiHIN3P (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 09:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242167AbiHIN3O (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 09:29:14 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA45FCE27
        for <linux-ext4@vger.kernel.org>; Tue,  9 Aug 2022 06:29:11 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id z19so11354875plb.1
        for <linux-ext4@vger.kernel.org>; Tue, 09 Aug 2022 06:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=waWzxRfbr0JJwLD5FPnjrDucElKMj70QOqjnCz6dbu8=;
        b=l4eLlOMHHcX6rJKT2WOrOTjjf84BWvw1R+tt+5s6p2CVoFEIBKkTaBzGySJ+mKc31i
         g2LwfkCk3WgiBfdSpuqcPkMfzTwzTU5b38Z27UmCSY3zygIO4PbAWzcUv17pqlvV1pk0
         Jqa4qjMGKvhLECJP+yGdHOVg9SSek4gMlktGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=waWzxRfbr0JJwLD5FPnjrDucElKMj70QOqjnCz6dbu8=;
        b=oE7+qc8IyNwZlsxmlXORVzpzk0Z/5ibZX8CBc9vT0TgTdc1P4it3HGxH/BIBzkBI7R
         1Nt6e4439TN/9yWwVWVJvrEgcy/LRSkwG4rqUysmdRqOmpA3QV6owrxutPL0+SZJoPR1
         l8CWijP9b31RgctfdaDijABXwykb429guz2S4kyABiqphCiSXaNKp4gm9/apJFMUbskW
         yFAl5h6uKIIN1BnXbYmc8NEf4la8OLMStDVLvAvujk1tKWknavR/lOimfFgMdqstwnXd
         ZWfgbqcDqf4Vct7pEasP4q94vUhwrQxYOFYJ+SAHwigPcMrlBD3S7w3cREqvleswFGul
         NC5Q==
X-Gm-Message-State: ACgBeo1wZ0BR4RarB4nqv2kvjwNIof7dgsCaXAMUpyql/MSejiJeyYxT
        G0dqDZ4ZYgIOeAkUR/Av+8C4qQ==
X-Google-Smtp-Source: AA6agR4sefXREMRgGjEhudBrKrUVQ4sDX0r33X8z/lQxmw0tSO7XUl06EP0EhHDuNnAQBo58rb794w==
X-Received: by 2002:a17:90a:c251:b0:1f3:2872:ec8 with SMTP id d17-20020a17090ac25100b001f328720ec8mr34525146pjx.81.1660051751220;
        Tue, 09 Aug 2022 06:29:11 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:8d43:c739:457a:5504])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902e31200b00170953de050sm6656024plc.50.2022.08.09.06.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 06:29:10 -0700 (PDT)
Date:   Tue, 9 Aug 2022 22:29:05 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Aleksey Romanov <AVRomanov@sberdevices.ru>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Jiri Slaby <jirislaby@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>, Jan Kara <jack@suse.com>,
        Ted Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: ext2/zram issue [was: Linux 5.19]
Message-ID: <YvJhIU/6ysqLyxrj@google.com>
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
 <702b3187-14bf-b733-263b-20272f53105d@kernel.org>
 <c7c69f77-4ea2-3375-33f3-322a3d35def5@kernel.org>
 <8710b302-9415-458d-f8a2-b78cc3a96e49@kernel.org>
 <YvIeLHuEb9XDSp6N@google.com>
 <YvIk3SdC7wP3uItR@google.com>
 <YvImxBsHJcpNzC+i@google.com>
 <20220809102011.pfhfb4k7tdkqvdai@CAB-WSD-L081021.sigma.sbrf.ru>
 <YvJKwCXewHmuWGdh@google.com>
 <20220809131516.xfezk7kuyu3eelsb@cab-wsm-0029881.sigma.sbrf.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809131516.xfezk7kuyu3eelsb@cab-wsm-0029881.sigma.sbrf.ru>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On (22/08/09 13:15), Aleksey Romanov wrote:
> On Tue, Aug 09, 2022 at 08:53:36PM +0900, Sergey Senozhatsky wrote:
> > > If you make the decision to revert slow path removal patch, I would
> > > prefer to review the original patch with unneeded code removal again
> > > if you don't mind:
> > > https://lore.kernel.org/linux-block/20220422115959.3313-1-avromanov@sberdevices.ru/
> > 
> > Sure, we can return to it after the merge window.
> 
> In that case, do I need to send my original patch again? 

Would be nice, since the patch needs rebasing (due to zsmalloc PTR_ERR changes)
