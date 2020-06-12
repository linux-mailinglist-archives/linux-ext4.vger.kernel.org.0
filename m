Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141521F7C7C
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jun 2020 19:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgFLRb1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Jun 2020 13:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgFLRb1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Jun 2020 13:31:27 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DA4C03E96F
        for <linux-ext4@vger.kernel.org>; Fri, 12 Jun 2020 10:31:27 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id a21so9383259oic.8
        for <linux-ext4@vger.kernel.org>; Fri, 12 Jun 2020 10:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vLsSenCb5ZRAY7NOhRnb5ZvtgKfftias1hp+7qm9if0=;
        b=IcXXjbHpsn53pI/+cvb09ZvzcBbG45poLT3vnt/M2DHaOghRuAA/ZVZHLCAD4HSTnK
         mOJYxUDqDo+8Xeb9rTAkCAoVnC/Led/a9rp+GxoHu6Qh5MPEz/uBr+0eACO1H2Wnmf8u
         399ojq0HbQrBCisqmv83h1xLIrYniIAQlN/c7/0hR7ltmjc/3M2LPlzrb+MrHP0baKir
         bbrlRYUdBye7YWK7M3Ii81nzxgbm160eeWkm05Q11VpgHkRbSL+0l0xLvL+/gBDfyh9P
         jaxx7aORGyLVXM3d1JpVivMqS25kmVURuDNwgWvp+lzA2LYsd5EG4pMA6kVUJCcUygJS
         Tqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vLsSenCb5ZRAY7NOhRnb5ZvtgKfftias1hp+7qm9if0=;
        b=Szu+Q9Xkall/ajt3RXoawqJhRtOYeeBXi2QbFBpJgSzGybCah0PfM08+STdmXaLLW7
         Q9lRDtGtEnotCJACSU+0A1cLR9Jg1lC/PssSarMVFFWjMJK6cemhkm+OhN768hTdnGAv
         X52Sh6EgCQfim6Ecfka7AmNXW5wp4pKu9NWuiQRhq3FWBCB+xnSWJig0sA8WCHaM6FLz
         7zgpezBicz+FKrAjjyPaV8deRTqVWS1wkuEpdEHoSYqb+/AsZTIks/o+asjnC/dGy1Ll
         T+LycJvwOqtvHtJrXWJH3qMCkycE1JRaMMPY2O5By2jg4NLqXuf6cVrS0NKPvnSTI5JX
         /EBg==
X-Gm-Message-State: AOAM533RzZhBIpH6YnfeO7JYfA/r4V5Ymzsrk6hD/f2JxhI7AWGSFd0a
        0Gw6KtTlN94etU9v98vaGgBfhk2+mjbB3Svy1sI8icCC
X-Google-Smtp-Source: ABdhPJyL8WdLhws8L1H+nSeu0BtiSRX51DfQ8K5kKa5Ch/JSTrk3b7PngzGM0J51LxgpPUTu1IhyYRUSmyuEpPz9+VQ=
X-Received: by 2002:aca:cf43:: with SMTP id f64mr2989057oig.141.1591983086345;
 Fri, 12 Jun 2020 10:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200605222819.19762-1-harshadshirwadkar@gmail.com> <20200608073524.GA1480@infradead.org>
In-Reply-To: <20200608073524.GA1480@infradead.org>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 12 Jun 2020 10:31:15 -0700
Message-ID: <CAD+ocby-+okNtjd=F4Zw_G_yoVSUumUBUHLp_y052vo-3-M3Uw@mail.gmail.com>
Subject: Re: [PATCH] ext4: issue aligned discards
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 8, 2020 at 12:35 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Jun 05, 2020 at 03:28:19PM -0700, Harshad Shirwadkar wrote:
> > Ext4 before this patch can issue discards without respecting block
> > device's discard alignment. Such a discard results in EIO and
> > kernel logs.
>
> No, that is not how discard works.  The granularity is a hint and
> blk_bio_discard_split already does all the work to align to it.  If
> you have a make_request based driver that doesn't do that you need
> to fix that driver instead.

Thanks for the clarification, my commit message was wrong. Fixing the
driver instead is the right solution here. But, if doing discard
alignment in Ext4 can increase the chances of discards being
successful, is there any harm in doing it in Ext4 too?
