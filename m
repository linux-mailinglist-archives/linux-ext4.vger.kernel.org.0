Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EB347E8A7
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Dec 2021 21:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350228AbhLWUNg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Dec 2021 15:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350224AbhLWUNg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Dec 2021 15:13:36 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2553C061401;
        Thu, 23 Dec 2021 12:13:35 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id b13so25487240edd.8;
        Thu, 23 Dec 2021 12:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ryPQtnohJ+ORZG6w7SZ9y+GWu3M8QXzAmB26UUrWaeU=;
        b=XpTaNGpEClRhP77APXzIlgYEZsguvgMvV2yvULyhwsczNLSKaF7m09zWx19LAvdgA9
         TAiXwjCMbuMbNExcJ3ozj7iWtVBk3N+JyeHeeYQmIFNIOuXo61Ok0+YyknotKQN7IDQf
         +H675095+fdcx8MH8F+GnsnYvP7PpnYdkPvb705uDWzB1fc2LQ9Wurwu7pdIi6Ps2x2V
         SnoSZUo+5MVOyq4XeOAjjXDDYucpBMSeIL0Z5GNCaJoNKCPUj92XCC3REDSmZj7uBrkH
         VMSa9C2Go/mr/HXUUi8q/I5QneloXswpGfHrCg/1UkRUJ3H7oMUW3t/DxPDHhc5bFBJH
         /Qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ryPQtnohJ+ORZG6w7SZ9y+GWu3M8QXzAmB26UUrWaeU=;
        b=S1p50vIXtPmcClkpFL6kwI2Bpx8R333eM+TK5NWRaEkp4HBlMA6eAVSc7SQh/38La0
         /dOxE1y5e9tQPOQOvreP2sS4yzz3tQmq1hBA0MRrGbkefol8WjHP2oZiO1URPOj+hkc5
         z6I0y7Y5wboPDL7E1599zFMMR3jTfcq6b3wUP4yAWEzMRRaVKczuewyJt1IIc7zSbrXt
         U7Nl6y9KTH6cqIXQ012NIDW35L8GKduCKnxiIVfGGQKfpfSakaSzt7XnIuXRB1b5nI1G
         oXAKTi/L9AJH3ZjS1kgZWcb6u/O06eI0Pinb2a6yfRzQI37UoipPN/xT3hE1j7y515NA
         6Kqg==
X-Gm-Message-State: AOAM530GhZS6YPIMulQz8yiD3MuBtSt8LQDLTK1ZZ8HqDjVdo7c+3s4Y
        Egx1Zn3lKSzLJz/U7EukJwMVTaH0BBzlllvvCys=
X-Google-Smtp-Source: ABdhPJw1ojhu3LsICFAco4vf3cDD8+dINJstvXyvmqo2xKyXEucVc0y/jiJ9GKaUwiEkiYH6HBidJ05ivWqJbsM8gOE=
X-Received: by 2002:a17:906:4793:: with SMTP id cw19mr3356689ejc.15.1640290414070;
 Thu, 23 Dec 2021 12:13:34 -0800 (PST)
MIME-Version: 1.0
References: <20211223032337.5198-1-yinxin.x@bytedance.com>
In-Reply-To: <20211223032337.5198-1-yinxin.x@bytedance.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu, 23 Dec 2021 12:13:22 -0800
Message-ID: <CAD+ocbxLHJ2KK44gT0u7zei--UBJ1CRRKyra8Hhx1CvtCcOpQA@mail.gmail.com>
Subject: Re: [PATCH 0/2] ext4: fast commit crash consistency issues
To:     Xin Yin <yinxin.x@bytedance.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the patches, these are good finds.

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

On Wed, Dec 22, 2021 at 7:24 PM Xin Yin <yinxin.x@bytedance.com> wrote:
>
> This patch sets fix 2 crash-consistency issues of fast commit.
> First patch change to use ext4_ext_remove_space instead of
> ext4_punch_hole during replay delete range procedure. This
> avoid replay procedure being affeced by incorrect inode->i_size.
> Second patch correct the trank range logic for ftruncte.
>
> After testing this patch sets with xfstests-bld, in the "log" and
> "quick" group with config "fast_commit" is selected. No regressions
> was found.
>
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
>
> Xin Yin (2):
>   ext4: use ext4_ext_remove_space() for fast commit replay delete range
>   ext4: fast commit may miss tracking unwritten range during ftruncate
>
>  fs/ext4/fast_commit.c | 13 ++++++++-----
>  fs/ext4/inode.c       |  3 +--
>  2 files changed, 9 insertions(+), 7 deletions(-)
>
> --
> 2.20.1
>
