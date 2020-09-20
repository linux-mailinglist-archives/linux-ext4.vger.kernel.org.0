Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CC3271633
	for <lists+linux-ext4@lfdr.de>; Sun, 20 Sep 2020 19:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgITRGh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 20 Sep 2020 13:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgITRGh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 20 Sep 2020 13:06:37 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1316C0613CE
        for <linux-ext4@vger.kernel.org>; Sun, 20 Sep 2020 10:06:36 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b12so11444983lfp.9
        for <linux-ext4@vger.kernel.org>; Sun, 20 Sep 2020 10:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m32ara5dRLo2fJ/OEn+HKg3b14u2N0hvKAREROX6J3w=;
        b=ZU/G/BKEGVGbGhBZcMQce8SRRc6gdKG2pt2dEkrk0tevuzgea69QuukEwURgcFprFP
         BnaAgukvuAqWpzOjAAe3AOwqiczubQccEn5vVpobtBfYrf/pL5rxLvXLRyZEmb1PHN8s
         29lQhEHVes9pkcET+nYdylijIWda5znrxx8SM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m32ara5dRLo2fJ/OEn+HKg3b14u2N0hvKAREROX6J3w=;
        b=rZ2NKGiZmqLyaBKDwbK6X5Lyhg/BYobMbdaVKjuMAKYbXLWdSxoNQou9HGbM+hf+lK
         zry1fOa60w4dbOgd9w2DAT4dLvAQQdK0ccuRDJPyvFWXBeUse59ROLGWdtOxnKu2wPOo
         Sf15gnzoIjxdJL/SwAEJ8YwQZ8P6vR/8jfZ0HxAnrCsijZSA9UERm6DO1x3j0YDUEr3Z
         pdKzMBMR9WJQApbOHRIstmQcVv6BFa5YAqPce58U8jfzLMVu0Tkyl/lRGzfirkC60SQP
         X4CFhTFiylALTShgvFvkIp7Tarol9p1N/6Ey42e+oEaP/M+6yVQrzPz6LJuZF9yCOAmV
         Cflw==
X-Gm-Message-State: AOAM532NEQMysdqtheaT3chQOJC3iocWJ3QNoVvED+CO4NzoqaD/3CLU
        8kknCu+ZDBrJNTjO3BFngSIRyhN5DVMArg==
X-Google-Smtp-Source: ABdhPJx+47idomur/05rskxGTNZEPyghqI2u2gD2lNok6zF886chInslV5+8WWHN41H7fop+tlJ25Q==
X-Received: by 2002:a19:7b14:: with SMTP id w20mr15397966lfc.563.1600621594770;
        Sun, 20 Sep 2020 10:06:34 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id n21sm2021280ljc.89.2020.09.20.10.06.32
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 10:06:32 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id y17so11461726lfa.8
        for <linux-ext4@vger.kernel.org>; Sun, 20 Sep 2020 10:06:32 -0700 (PDT)
X-Received: by 2002:ac2:4a6a:: with SMTP id q10mr12935270lfp.534.1600621592348;
 Sun, 20 Sep 2020 10:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com> <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com> <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <CAHk-=whc5CnTUWoeeCDj640Rng4nH8HdLsHgEdnz3NtPSRqqhQ@mail.gmail.com>
 <20200917182314.GU5449@casper.infradead.org> <CAHk-=wj6g2y2Z3cGzHBMoeLx-mfG0Md_2wMVwx=+g_e-xDNTbw@mail.gmail.com>
 <20200917185049.GV5449@casper.infradead.org> <CAHk-=wj6Ha=cNU4kL3z661CV+c2x2=DKzPrfH=XujMa378NhWQ@mail.gmail.com>
 <20200917192707.GW5449@casper.infradead.org> <CAHk-=wjp+KiZE2EM=f8Z1J_wmZSoq0MVZTJi=bMSXmfZ7Gx76w@mail.gmail.com>
 <CA+icZUWVRordvPzJ=pYnQb1HiPFGxL6Acunkjfwx5YtgUw+wuA@mail.gmail.com>
 <CA+icZUUUkuV-sSEtb6F5Gk=yJ0efKUzEfE-_ko_b8BE3C7PTvQ@mail.gmail.com> <CA+icZUWoktdNKpdgBiojy=ofXhHP+y6Y4tPWm1Y3n4Yi_adjPQ@mail.gmail.com>
In-Reply-To: <CA+icZUWoktdNKpdgBiojy=ofXhHP+y6Y4tPWm1Y3n4Yi_adjPQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Sep 2020 10:06:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi9x33YvO_=5VOXiNDg7yQU5D5MHReqUNzFrJ9azNx3hg@mail.gmail.com>
Message-ID: <CAHk-=wi9x33YvO_=5VOXiNDg7yQU5D5MHReqUNzFrJ9azNx3hg@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Amir Goldstein <amir73il@gmail.com>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 18, 2020 at 1:25 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> do you want me to send a patch for the above typos or do you want to
> do that yourself?

I was about to do it myself, and then I noticed this email of yours
and I went "heck yeah, let Sedat send me a patch and get all the glory
for it".

                    Linus
