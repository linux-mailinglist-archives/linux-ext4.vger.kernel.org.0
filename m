Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197D658D627
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 11:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbiHIJP6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 05:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239263AbiHIJPu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 05:15:50 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E25822BDD
        for <linux-ext4@vger.kernel.org>; Tue,  9 Aug 2022 02:15:44 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w14so10786578plp.9
        for <linux-ext4@vger.kernel.org>; Tue, 09 Aug 2022 02:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FSqOfzpZFUwxr8/HeQ2ME9Ryp30O9Pfj1SqUD1sPdrE=;
        b=cysesuRYHU30L5/uc3M+rJSD7t5hbJ6SmQZQGevM+9EmiBSlfecggbUEkZgRRIMq00
         9ZLuoH8Faa+Na2fsTSh7Ly83OG47w28c4bg5NYyrkpY/yKc+Ph1v0SNC/O+MIL66B4Je
         k3oaZzIZ6VNzcBBSeqeRb+UqY+skq7sbqvT30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FSqOfzpZFUwxr8/HeQ2ME9Ryp30O9Pfj1SqUD1sPdrE=;
        b=ZTYFGJahPXK43aB6XSxPUFU/PsdqgRV/LIoQNJzrwljzFxiLxbctwgNm1jSdDqnJ96
         U6o0pCN7iPpRLTxPRBiGL5uaZY+iP82I21j4vcTSEpcCFTi9CoOKxtRg1dvCpzYQP81v
         QfpPxgd0yjJ1HL5oxOEuQjw68isapY4Qo9Ly8Sj0OY6pmtXR5jnq9T76WOki8LtEddgv
         UMjTdvD8WO0aCL5TuAwtElThu4ALJSzgf0KgviM8LfjuJzVxc46uO9kkAPyg4pOU6Ao1
         rhHSlZL2u73a0OgbWo3hRf3SX2rqag4/NM79R8S+wzlPEXvpeICTsSJnZzoSv693yHey
         y1LQ==
X-Gm-Message-State: ACgBeo2a+GUGX3P0r6XBdz2xO489ETXl2lpEEwHW/DdI1mhOprRrcIB3
        r8nD3vj9KCt/def5g2iAKARhXQ==
X-Google-Smtp-Source: AA6agR5KA4bN2UFClOwGt6cKcwaRp/Ex5oIjk0AIN3k2UJ+MpFxP0OjPZfORGUebEqY9naJNf2zoXg==
X-Received: by 2002:a17:902:d48d:b0:16f:5ce:1d08 with SMTP id c13-20020a170902d48d00b0016f05ce1d08mr22446624plg.49.1660036543139;
        Tue, 09 Aug 2022 02:15:43 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:8d43:c739:457a:5504])
        by smtp.gmail.com with ESMTPSA id p3-20020a625b03000000b0052d7cca96acsm10053741pfb.110.2022.08.09.02.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 02:15:42 -0700 (PDT)
Date:   Tue, 9 Aug 2022 18:15:37 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        minchan@kernel.org, ngupta@vflare.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jan Kara <jack@suse.com>, Ted Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: ext2/zram issue [was: Linux 5.19]
Message-ID: <YvIluTU6oFDpwQwK@google.com>
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
 <702b3187-14bf-b733-263b-20272f53105d@kernel.org>
 <20220809091212.mgreambnhgso5hzw@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809091212.mgreambnhgso5hzw@fedora>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On (22/08/09 11:12), Lukas Czerner wrote:
> Hi Jiri,
> 
> I've tried a quick xfstests run on ext2 on zram and I can't see any
> issues like this so far. I will run a full test and report back in case
> there is anything obvious.

AFAICT this should be visible only when we are under memory pressure,
so that direct reclaim from zs_malloc handle allocation call makes a
difference.
