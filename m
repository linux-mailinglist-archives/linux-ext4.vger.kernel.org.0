Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37F43B8052
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 11:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbhF3Jtk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 05:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbhF3Jti (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Jun 2021 05:49:38 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CE3C061787
        for <linux-ext4@vger.kernel.org>; Wed, 30 Jun 2021 02:47:10 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m9-20020a05600c3b09b02901f246b43bbeso1071274wms.3
        for <linux-ext4@vger.kernel.org>; Wed, 30 Jun 2021 02:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Z6oz2a6snhnXVo8MXg6uFjLMjRtla/ZcY7D6SjSAauA=;
        b=zLTi5aCbnypPB5E3aUA0ZTW2QZ9ElWO1rUMChAnrYkbnv5R1HppvSR83sz83GmhmUA
         UMxwvrtyn70Zd9AoLodBjAgPxIMvZ1UB4cERbwNt9h4ezFzozjlRXTJceovl8itCNtkO
         ZHpCXotz6yp1b1LU/oBZfpMMbHJ9z37zfQLOhI93YEXu77Z1hvbdB1hXccB0ErO3BuRM
         2v2H3xdjL56voJXkKEkXOJouofN6tE6pWAPsziIGqT+x1uxsqXS8aHT7JlV4vp9xlNdX
         RRmNLJxKm6216ZAGJ10+La1loxmhKlUG8r/gC+MQIkg6soAQE9aR2vguk2YO28brVd4+
         UeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Z6oz2a6snhnXVo8MXg6uFjLMjRtla/ZcY7D6SjSAauA=;
        b=n2DNWDnW6pK/KjZlq4BpKwTbe+IW0MTZHaHr3+GUxPvexR6N3Te4GHLO3Kq2Ki4Skf
         O8UJ8R/UQo7YSBxayrfCtHtR4pEQNGb1olOPGlYGSWdrBJgf5J2choJ8q8//J/MUfIde
         vQV2FihzNJQGo5mKeDj9jBB/wCFCve9y4l8M8/1ARCa0B9GEPXuAU+sHrceK2wxkjFMm
         ZeKkHybm1GoiAms0uc2jK2eu3BGZ4ohkfcwkXYAPdgXfySDEDCnqm/Z2qFt7eeWjHFix
         ERf90XkC6BEq0c/m3RJVKFHkWy5M2e48NSAjO9UV4eMSNiPOJsdOQNgKQ0Cb21wIrTF5
         a2vA==
X-Gm-Message-State: AOAM533xuUY1Gk2eGyRCQRxQ5Ndo+GxCTnHKGAjK8TY8egH6IoS4+lp8
        TxiyaK7J4KWxhUH2LiY6C3wlWQ==
X-Google-Smtp-Source: ABdhPJysgaWNsxoQ1Ekn5yIfyUpjV6tLOTWrZta/4RIlCjFmHAXWqbWe870FTEuNbqmWvtd9IqJeZQ==
X-Received: by 2002:a1c:7f4a:: with SMTP id a71mr3558850wmd.33.1625046428092;
        Wed, 30 Jun 2021 02:47:08 -0700 (PDT)
Received: from dell ([95.144.13.171])
        by smtp.gmail.com with ESMTPSA id p7sm8990839wrr.68.2021.06.30.02.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 02:47:07 -0700 (PDT)
Date:   Wed, 30 Jun 2021 10:47:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Satya Tangirala <satyaprateek2357@gmail.com>
Cc:     Satya Tangirala <satyat@google.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chao Yu <chao@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v8 0/8] add support for direct I/O with fscrypt using
 blk-crypto
Message-ID: <YNw9me1Fd6Siy18A@dell>
References: <20210121230336.1373726-1-satyat@google.com>
 <CAF2Aj3jbEnnG1-bHARSt6xF12VKttg7Bt52gV=bEQUkaspDC9w@mail.gmail.com>
 <YK09eG0xm9dphL/1@google.com>
 <20210526080224.GI4005783@dell>
 <20210609024556.GA11153@fractal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210609024556.GA11153@fractal>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 08 Jun 2021, Satya Tangirala wrote:

> On Wed, May 26, 2021 at 09:02:24AM +0100, Lee Jones wrote:
> > On Tue, 25 May 2021, Satya Tangirala wrote:
> > 65;6200;1c
> > > On Tue, May 25, 2021 at 01:57:28PM +0100, Lee Jones wrote:
> > > > On Thu, 21 Jan 2021 at 23:06, Satya Tangirala <satyat@google.com> wrote:
> > > > 
> > > > > This patch series adds support for direct I/O with fscrypt using
> > > > > blk-crypto.
> > > > >
> > > > 
> > > > Is there an update on this set please?
> > > > 
> > > > I can't seem to find any reviews or follow-up since v8 was posted back in
> > > > January.
> > > > 
> > > This patchset relies on the block layer fixes patchset here
> > > https://lore.kernel.org/linux-block/20210325212609.492188-1-satyat@google.com/
> > > That said, I haven't been able to actively work on both the patchsets
> > > for a while, but I'll send out updates for both patchsets over the
> > > next week or so.
> > 
> > Thanks Satya, I'd appreciate that.
> FYI I sent out an updated patch series last week at
> https://lore.kernel.org/linux-fscrypt/20210604210908.2105870-1-satyat@google.com/

If you end up [RESEND]ing this or submitting another version, would
you mind adding me on Cc please?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
