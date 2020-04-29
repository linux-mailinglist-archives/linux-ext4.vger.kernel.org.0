Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F931BE453
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Apr 2020 18:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgD2Qt3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Apr 2020 12:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726654AbgD2Qt1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 29 Apr 2020 12:49:27 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC483C035494
        for <linux-ext4@vger.kernel.org>; Wed, 29 Apr 2020 09:49:26 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b2so3372072ljp.4
        for <linux-ext4@vger.kernel.org>; Wed, 29 Apr 2020 09:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D9Uuz2eH1rEC3Rsd9pWrnSIaGFJoBuGHkEpyj9FO1RU=;
        b=fNkYlfC7XyU0na36V1nAsEErxJD6SCdd001tONSj5QzCTF5pfnhtkJHTnLvT4RbjHZ
         Esmpn/Ja4kfMTNbK4V/ULBUaFnl8J/DehN+PSbsUTUNm9u5a0/1rtLVU7yIw59uOmHc1
         Oz8J1e1DSH0V3mg6CW+Ys3Xe1HiKJDyaEj9z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D9Uuz2eH1rEC3Rsd9pWrnSIaGFJoBuGHkEpyj9FO1RU=;
        b=c+JSFyd4LmtzSPE9cyJ58/e3yTxiRPg0MDFn2vQE6dQTXG8zmwtOF7lQ2/Da35AtoL
         Ie+lWbKqAM0K9uTptYXLvS+bs/lygKn9jq8Ashv4WkBYr0uv3O0CbENvv8DpzTzQSs+p
         4iXxSIG55hqWM/i/ShChRKhnlZUobpWwaKOfuMyXD8ew7tKmKV+WeeqOhkbc+/lzKMjf
         NgPQwbVdmzURb/yJ4i9P+dBtxxYUV3y3sK3DeuALqT4A8zI7IYoUItmqhMC7kfAqRViQ
         Ggzb9U6LBKmOsHuVfEr3FkYpv/FMfyaJZYVAwXfuvJ9kfOfQ/5Qt8A1hftwUV1NVCWfZ
         NTbQ==
X-Gm-Message-State: AGi0PuZ3FRjpOY9Nx4obhcTLDnfh4Hudo18AgdM2bTXXS5xt5V3SZ87Z
        +1qYEXAyB9CbAN7SYmiNmdIKEctuemw=
X-Google-Smtp-Source: APiQypIPiTVHU3w/yqhzXT2+iMUHrT4h63G+sDjVdyWvbPOaQYIG0ebACEg3V2PB+kxcJohlft6KKw==
X-Received: by 2002:a2e:2201:: with SMTP id i1mr21328694lji.31.1588178964469;
        Wed, 29 Apr 2020 09:49:24 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id f15sm2930873lfh.76.2020.04.29.09.49.22
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 09:49:22 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id u10so2258218lfo.8
        for <linux-ext4@vger.kernel.org>; Wed, 29 Apr 2020 09:49:22 -0700 (PDT)
X-Received: by 2002:ac2:4466:: with SMTP id y6mr23676248lfl.125.1588178962247;
 Wed, 29 Apr 2020 09:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <158810566883.1168184.8679527126430822408.stgit@warthog.procyon.org.uk>
 <20200429060556.zeci7z7jwazly4ga@work>
In-Reply-To: <20200429060556.zeci7z7jwazly4ga@work>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Apr 2020 09:49:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHoa0onB0KTthLXeHNNBupcPOdf38OEoFFy3ok3nOeJA@mail.gmail.com>
Message-ID: <CAHk-=wiHoa0onB0KTthLXeHNNBupcPOdf38OEoFFy3ok3nOeJA@mail.gmail.com>
Subject: Re: [PATCH] Fix use after free in get_tree_bdev()
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 28, 2020 at 11:06 PM Lukas Czerner <lczerner@redhat.com> wrote:
>
> This fixes the problem I was seeing. Thanks David.
>
> Reviewed-by: Lukas Czerner <lczerner@redhat.com>

Well, it got applied as obvious before this, so the commit log won't
show your testing.

Commit dd7bc8158b41 ("Fix use after free in get_tree_bdev()") in case
anybody cares. Didn't make -rc3, but will be in -rc4.

          Linus
