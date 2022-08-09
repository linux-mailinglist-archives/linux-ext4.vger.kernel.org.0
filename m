Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D9058D907
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 14:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243101AbiHIM6J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 08:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243366AbiHIM6A (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 08:58:00 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EA2186D8
        for <linux-ext4@vger.kernel.org>; Tue,  9 Aug 2022 05:57:57 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id bh13so11278042pgb.4
        for <linux-ext4@vger.kernel.org>; Tue, 09 Aug 2022 05:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vV1xIkSqBLddF4U1Z3CCLD1KI2sW2FNsic63GPL2qM8=;
        b=nIH2rm+xA7k+7yyhm7J2VmFUTLSu6W8yIKZm4yGDdD4BAAJbdxO1WStETNXRxxRQjJ
         enwTn+rs1U3XsHxkUop3wvIawBfy+ojrlGXHQmHRW1MoNOj9sOpCTo9nKa3HhiDvMBQo
         jIVpL/bB8AJ8+zpaRxOyirSOrRLvVSRGjIrW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vV1xIkSqBLddF4U1Z3CCLD1KI2sW2FNsic63GPL2qM8=;
        b=IWX8itFqywBIwEQ3wIVlFJqDEpndGzSVcBXj1+PSIqrR3vuSnWrFsH9czJTQbit7Lu
         6UbeR+lIyx9kI+ANbz1IwibwiejT0va7g060IKRfnxMLkc2aR1iN56f/RrIHRx0N2Mre
         Og75+FUX88Z43Rw6mGgFkmr8idUzQPTBkfKSRM/lHFGvw3M3gowLJ18OOOmip3EhJ0Zs
         TxY04LaJJCbb5B+/gtWDB5N9AM/MlT41SzK+zvlGohb+C+/pW0tqEkb4MhmGP6rGAWAV
         bZH8HAbLqTsS7Rvs0AkA6bdQvOYMXK7WvW3UGJ1KCIj8xXnU7hw/sd+cweLxN0YivbAP
         Vx9A==
X-Gm-Message-State: ACgBeo1piIFuZjpqMq8W5NkwYAwouGb0O5iTWnk1xPV2wOBBFRGotsJ1
        G6UFvm85+r1a4s7lVsw3tOo5fg==
X-Google-Smtp-Source: AA6agR5y3RFyCKJ7eiYL9wD61o8yuQ9RUH1xHtmsNBDdA0c2FunF9qhwCnW98afY/pZkxRuijkPPQA==
X-Received: by 2002:a05:6a00:408e:b0:52e:7ae5:af62 with SMTP id bw14-20020a056a00408e00b0052e7ae5af62mr22972900pfb.20.1660049877273;
        Tue, 09 Aug 2022 05:57:57 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:8d43:c739:457a:5504])
        by smtp.gmail.com with ESMTPSA id u8-20020a170903124800b0016f15140e55sm10666117plh.189.2022.08.09.05.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 05:57:56 -0700 (PDT)
Date:   Tue, 9 Aug 2022 21:57:50 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        minchan@kernel.org, ngupta@vflare.org, Jan Kara <jack@suse.com>,
        Ted Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        avromanov@sberdevices.ru, ddrokosov@sberdevices.ru
Subject: Re: ext2/zram issue [was: Linux 5.19]
Message-ID: <YvJZztvKtedJfeK5@google.com>
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
 <702b3187-14bf-b733-263b-20272f53105d@kernel.org>
 <c7c69f77-4ea2-3375-33f3-322a3d35def5@kernel.org>
 <8710b302-9415-458d-f8a2-b78cc3a96e49@kernel.org>
 <YvIeLHuEb9XDSp6N@google.com>
 <YvIk3SdC7wP3uItR@google.com>
 <YvImxBsHJcpNzC+i@google.com>
 <9fd860a8-4e4f-6a95-5c3f-1b3c4a76cf51@kernel.org>
 <b2662600-07cd-7125-d7c3-b7bbe1bad824@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2662600-07cd-7125-d7c3-b7bbe1bad824@kernel.org>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On (22/08/09 14:45), Jiri Slaby wrote:
> On 09. 08. 22, 14:35, Jiri Slaby wrote:
> > But the installer is different. It just creates memory pressure, yet,
> > reclaim works well and is able to find memory and go on. I would say
> > atomic vs non-atomic retry in the original (pre-5.19) approach makes the
> > difference.
> 
> Sorry, I meant no-direct-reclaim (5.19) vs direct-reclaim (pre-5.19).

Sure, I understood.

This somehow makes me scratch my head and ask if we really want to
continue using per-CPU steams. We previously (many years ago) had
a list of idle compression streams, which would do compression in
preemptible context and we would have only one zs_malloc handle
allocation path, which would do direct reclaim (when needed)
