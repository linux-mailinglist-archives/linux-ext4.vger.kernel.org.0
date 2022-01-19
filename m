Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB407493654
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Jan 2022 09:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352483AbiASI25 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Jan 2022 03:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352478AbiASI25 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 Jan 2022 03:28:57 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD99C06161C
        for <linux-ext4@vger.kernel.org>; Wed, 19 Jan 2022 00:28:56 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id p12so7538780edq.9
        for <linux-ext4@vger.kernel.org>; Wed, 19 Jan 2022 00:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhke7viFTh+984sDiukRcfEr3dDTzTM2M1AdIWscGkI=;
        b=IPaQXqeKWhvXrnF1NTn+04SxablavDfev1QQdPokB1Szeda1ZTHt4AjsyGJo/NfNqV
         6fyseawScGNSvOb4vATPREo2hp2c0ojbGLOA5Soo1sMnw21qUj9LxINE1Dno4m8PIC5e
         TWAB3J5T2CITv32jpTEop26cRpnT6Miv+nYQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhke7viFTh+984sDiukRcfEr3dDTzTM2M1AdIWscGkI=;
        b=77AmSknZkZkeSYdkRi22MZkWnwqJtzjT4zn8+7ZMXukhTiLmSmXFV+yAIgu83LzYks
         LLcIQ78s5j8njPFAEpcK8kYNqEABK5vouA8SjIh/p6bpIzBwrbCFZKnylHxY52hsMopV
         hbhTauy8ojTMss87jdve2QMGdWcgagBNhOlTvbgMzRJc7gT8bv7ecq6REE6IhQPnELOZ
         u655LHaelhjGWAkGUBB5IDLjIxvDOg1T4aqSkmUyMUc2aNxyXosQJKarm/48TQWxKJEB
         mKMWeDb0DytSn2BQ1u1JG0NdXFhVz/Nskbl8tZOUTFB7yZYG9Q72ccTv+jr3G8x8ieWd
         G/yw==
X-Gm-Message-State: AOAM530FYASjrfKV/6JWlQiK43FVWyJM3J+s0kDhH0w/rSvPsewQmYKQ
        hbE+zV3kLgUOytbnMGjawk2hIScE+JGlVFmQplA=
X-Google-Smtp-Source: ABdhPJw55tfQTb7gt2DfP9vgQAHzdXK8IgGA0/7uGetnFV+FCe+zVEwfGC7Qp5lu0dpP/XhyhAkL2A==
X-Received: by 2002:a17:907:97c8:: with SMTP id js8mr11214975ejc.204.1642580934923;
        Wed, 19 Jan 2022 00:28:54 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id o1sm862926edv.2.2022.01.19.00.28.54
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 00:28:54 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso12518294wmj.2
        for <linux-ext4@vger.kernel.org>; Wed, 19 Jan 2022 00:28:54 -0800 (PST)
X-Received: by 2002:a05:600c:34d6:: with SMTP id d22mr1240895wmq.26.1642580934004;
 Wed, 19 Jan 2022 00:28:54 -0800 (PST)
MIME-Version: 1.0
References: <20220118065614.1241470-1-hch@lst.de>
In-Reply-To: <20220118065614.1241470-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Jan 2022 10:28:37 +0200
X-Gmail-Original-Message-ID: <CAHk-=wjrxHOHPj_U7cOwQZFV8pBPwoppg7iTL=gtr8qGsCf6Tg@mail.gmail.com>
Message-ID: <CAHk-=wjrxHOHPj_U7cOwQZFV8pBPwoppg7iTL=gtr8qGsCf6Tg@mail.gmail.com>
Subject: Re: [PATCH] unicode: clean up the Kconfig symbol confusion
To:     Christoph Hellwig <hch@lst.de>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 18, 2022 at 8:56 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Note that a lot of the IS_ENALBED() checks could be turned from cpp
> statements into normal ifs, but this change is intended to be fairly
> mechanic, so that should be cleaned up later.

Yeah, that patch looks uglier than what I would have hoped for, but a
number of the conversions really look like they then would get a lot
cleaner if the IS_ENABLED() was part of the code flow, rather than
have those ugly (and now arguably even uglier) #ifdef's inside code.

And I think the mechanical conversion is the right thing to do, with
any cleanup being separate.

I'll look at this again when I have all my pulls done.

              Linus
