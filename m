Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F1D3BA411
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Jul 2021 20:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhGBSwf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Jul 2021 14:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhGBSwf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Jul 2021 14:52:35 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B353BC061762
        for <linux-ext4@vger.kernel.org>; Fri,  2 Jul 2021 11:50:02 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id u20so14535184ljo.12
        for <linux-ext4@vger.kernel.org>; Fri, 02 Jul 2021 11:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=71nuSMvaqgHrgpwAtP1N6KiE3ICrLSTcXVzeIPBvQ4o=;
        b=M7diCQUwMpzKQ1GXJoVPs9ZHH6w/FGKZMDIDOCrHx9bDTbOzzu8tbcnHNGtiUjvfRe
         7nD4xqc8ZKvmjMItQppsaUWB7+CxM4/HXNOlQPoFXIptkAOTbwmoM8RuNSbTOSK9Qk6c
         MNnPD0+78LLKPaN9r+5vwqH2uhsVbhc4Az2RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=71nuSMvaqgHrgpwAtP1N6KiE3ICrLSTcXVzeIPBvQ4o=;
        b=IIjAbAUteELSXbJ4bGHynTIFfEA/yg/TmXKLZj7/t0DHfaxXsFun87jq570ihA22Tt
         vpTUfS09iMoyX8Z8NYgBRFoiedIar46khtOPIslKtFJmBEJiFY0+DC5oF2AYG3OXXb/O
         dFV4BfeZ0fCyBz70+Zyh0vGvnjozbnmgjBeZ2Q1uR04HvuNIJN10oypEFKbX85K1SMU0
         SNaXb20Pc8rf2EqKo9AyGKEhV2YiyEypFOMVjlcOCHWoTeEBcogvaWHJDHAWcpONlE+3
         PXAy5w0cDneBtpyhCS9RHPCaieAiQUaJlq18Pfvsjy5MUKh73DhOFSfH8Pp3MilVLByl
         Ge+w==
X-Gm-Message-State: AOAM532K+1U/utSoOgn566I0zZqsg30u3YoWtHjq5Idiy5Xx48PcEf9M
        3XnAOe7qX/dFmEAzN98c7ryNVtB2LAG6j6HI
X-Google-Smtp-Source: ABdhPJyirgvfEtEiZXJsEJCiZh+0FuBl2CvcpQLENb0/J5YGKlFFfEUp89LYnGmpWm1lmXbMLKcNuw==
X-Received: by 2002:a2e:a40d:: with SMTP id p13mr651770ljn.400.1625251800822;
        Fri, 02 Jul 2021 11:50:00 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id bt42sm345523lfb.9.2021.07.02.11.49.59
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 11:50:00 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id q16so19804407lfr.4
        for <linux-ext4@vger.kernel.org>; Fri, 02 Jul 2021 11:49:59 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr716901lfa.421.1625251799639;
 Fri, 02 Jul 2021 11:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuBvh-H8Vqp58j-coXUD8p1A6h2it_aZdRiYcN2soGNdg@mail.gmail.com>
In-Reply-To: <CA+G9fYuBvh-H8Vqp58j-coXUD8p1A6h2it_aZdRiYcN2soGNdg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jul 2021 11:49:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJJtZ9TD_zDefSnaLzLAcjVKXPJoK2o=K-QWkhLGxyuQ@mail.gmail.com>
Message-ID: <CAHk-=wgJJtZ9TD_zDefSnaLzLAcjVKXPJoK2o=K-QWkhLGxyuQ@mail.gmail.com>
Subject: Re: [mainline] [arm64] Internal error: Oops - percpu_counter_add_batch
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Tso <tytso@mit.edu>, lkft-triage@lists.linaro.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jens Axboe <axboe@kernel.dk>, Zhang Yi <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 2, 2021 at 1:24 AM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The git log short summary between good and bad.

Ity would have been really good to have a full bisect.

But from another report:

    https://lore.kernel.org/lkml/87ade24e-08f2-5fb1-7616-e6032af399a3@nvidia.com/

 it seems to be commit 4ba3fcdde7e3 ("jbd2,ext4: add a shrinker to
release checkpointed buffers"):

Ted, when there is a fix for this, it would be interesting to see what
made this all work fine on x86-64 but fail elsewhere...

         Linus
