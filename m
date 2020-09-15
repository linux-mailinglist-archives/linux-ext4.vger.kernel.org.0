Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F54026ABFC
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Sep 2020 20:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgIOSb7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Sep 2020 14:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbgIOSbm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Sep 2020 14:31:42 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476D7C06174A
        for <linux-ext4@vger.kernel.org>; Tue, 15 Sep 2020 11:31:41 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x69so4188820lff.3
        for <linux-ext4@vger.kernel.org>; Tue, 15 Sep 2020 11:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dfn+wAryn8C6DCMRnpMqu5m74tYawQDjyF9URZVbit4=;
        b=KytikPFX2ltfGBuVNpKqIMWZkBuq7chmhFwJK4wg3F9rWrqDBv7uB9WDavsBoHoyUE
         wj2KWBLT+0RefUd1HoTSg6Ue4AUM1cNQKEd6Nhs7R6AeUsgwnk/hSGaz84Tr764/Q66H
         b+egq4Eo3V9tr9aRJcHnwjPJozP0YCOTZxh3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dfn+wAryn8C6DCMRnpMqu5m74tYawQDjyF9URZVbit4=;
        b=tGOKHUMUupl/UifETBVsUWRdhxbN7Wqet+ooHfo8+xD2S/XvtoIUGM0bRhZkH3kTii
         qlr39JLdSQNULxaZLuOHPtpyb2MZxLQak23MEcOWNRVgFMIDe86Hfgaa4X5eyTRgf19O
         MX/+oKsHF0WLPAw8fA0Kuw91EOJopylI9A6Ghj0F9tyYqyTzC8eiAOI7OH+lGMyT9cVS
         RuDiVouB6gljenhq/I08RQVgca5UPPbFDRSywULm6IpVFJD2e3rl5R/PmEIrZOwKXmJA
         +mBniSKhZ85+PDhTgjBzMighEWgnTU4nIbpvfsGfFJ9AZ2Y4fFpxLy6UAf2vhUDGg1wu
         amnw==
X-Gm-Message-State: AOAM532LWRQvjARwAB6+m+g+y4gafNd5ZEaNTOcGEtMWVbVgccPHDf61
        pcOq46hKFiUJDAPyzebtRDPARxUPcAi2Vw==
X-Google-Smtp-Source: ABdhPJy1hHKqVncJOTf/crRmtEKePtKMhVoG8cX+PmsK1N7vtJmWB+tE1SQx5wmn6iVU8P/6XiFliw==
X-Received: by 2002:a19:c6c8:: with SMTP id w191mr6009815lff.348.1600194699329;
        Tue, 15 Sep 2020 11:31:39 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id w9sm4092009lfn.224.2020.09.15.11.31.38
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 11:31:38 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id n25so3718859ljj.4
        for <linux-ext4@vger.kernel.org>; Tue, 15 Sep 2020 11:31:38 -0700 (PDT)
X-Received: by 2002:a05:651c:104c:: with SMTP id x12mr7823371ljm.285.1600194698099;
 Tue, 15 Sep 2020 11:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com> <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com> <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com> <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com> <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com> <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <c560a38d-8313-51fb-b1ec-e904bd8836bc@tessares.net> <CAHk-=wgZEUoiGoKh92stUh3sBA-7D24i6XqQN2UMm3u4=XkQkg@mail.gmail.com>
 <9550725a-2d3f-fa35-1410-cae912e128b9@tessares.net>
In-Reply-To: <9550725a-2d3f-fa35-1410-cae912e128b9@tessares.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Sep 2020 11:31:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiH37sXgMC+0UtLceOUJry2FBa_G3j726TP4n69jeB80w@mail.gmail.com>
Message-ID: <CAHk-=wiH37sXgMC+0UtLceOUJry2FBa_G3j726TP4n69jeB80w@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Michael Larabel <Michael@michaellarabel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 15, 2020 at 8:34 AM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> One more thing, only when I have the issue, I can also see this kernel
> message that seems clearly linked:
>
>    [    7.198259] sched: RT throttling activated

Hmm. It does seem like this might be related and a clue, but you'd
have to ask the RT folks what the likely cause is and how to debug
things.. Not my area.

                 Linus
