Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298CB4652D9
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Dec 2021 17:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243321AbhLAQjQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Dec 2021 11:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347953AbhLAQjQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Dec 2021 11:39:16 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAC5C061574
        for <linux-ext4@vger.kernel.org>; Wed,  1 Dec 2021 08:35:54 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id w1so104480271edc.6
        for <linux-ext4@vger.kernel.org>; Wed, 01 Dec 2021 08:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l0cKhh49XlH8HwXR1P1I2Kc3JO8X7efClFP4yB8oh08=;
        b=CdHuPGKpYJZ0RMd3Te/3nwUByGoK05YlLOo68NZ4PwdVgAI1jynl3ibTAFR+YelCj0
         NjCjy5FPnZyiV2MKUFYc9pT5Q/OTbtxZrv9So46QP7ydIBOsHGvuFdzpoYcL0fir8VAY
         rc9brLp3qku7GYV/JBpE24iqadg4KgZUBMX4UiFFF0KC1Z5+9XQXXKfn8SEOG0g6Svk/
         kFPy46yXRSCjyw0Jc89fzpE2nFE4XdwAgZihEw2gJ3hRnbQTlgEo1zGMgAcnoOYWxf6k
         l8ozKV3yAIobQGguXZkfxt7k1a7PNN458SMxrjvPaAj+cX0FwkhFuzyOXhY1qThBZlQw
         aZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l0cKhh49XlH8HwXR1P1I2Kc3JO8X7efClFP4yB8oh08=;
        b=DzvUgdeM35Leh9xd+IZM0kElL7VWUo/scb5Gh1F7EpzQ+piAyEsFoOeHV0OzfWvABQ
         UEXOiYe9U0j3XlGQDytvdQtMREWxPwxFnVVlmieHTCrRPgPHRGXE5WjsN480CA0ECG0y
         aHeKSAv/RCHd0RDQpdES68PqtT52x7jsE9i3vkPk2n8ikF96XAAoV3m1I5khBUDeCKBm
         Ddqwu2bP310V0VqbmmPX6x/Tx6tSL0i56XdDiKNFPy9ITu+Ks8VfZZBrsl1Y/CmLcRsH
         STze+tKTBINiC6mVkSOTRONraArNx2mgPNzMMOS5mVmbrjo9GIvi3n4APuAedPAemu3s
         s23A==
X-Gm-Message-State: AOAM530LoIljOjtoFq37vTajpDOSOqE1xiv4+xPyaM5ohUA0dl3XPtaa
        47aQpjVcKuKxJgScm3XQdNWe7V82BMH1GO4BJUmlTsBOYrQ=
X-Google-Smtp-Source: ABdhPJzH2vmZDWanKTUvAN1EmxwcAc9emTXp99CDAecIijKc24kK4Uv78IJZ1KQy1xl6rILcIQJdSQfndfj5v+jdatg=
X-Received: by 2002:a17:907:86a6:: with SMTP id qa38mr7956426ejc.286.1638376545785;
 Wed, 01 Dec 2021 08:35:45 -0800 (PST)
MIME-Version: 1.0
References: <20211130094006.GA29296@kili>
In-Reply-To: <20211130094006.GA29296@kili>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Wed, 1 Dec 2021 08:35:34 -0800
Message-ID: <CAD+ocbyWNCMqjywGgNjzsiEcagguYkmfYgTRfVMDQNBfvUk2PQ@mail.gmail.com>
Subject: Re: [bug report] ext4: fast commit recovery path
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the report Dan. This patch -
https://patchwork.ozlabs.org/project/linux-ext4/patch/20211201163421.2631661-1-harshads@google.com/
should take care of this report.

- Harshad

On Tue, Nov 30, 2021 at 1:40 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Harshad Shirwadkar,
>
> The patch 8016e29f4362: "ext4: fast commit recovery path" from Oct
> 15, 2020, leads to the following Smatch static checker warnings:
>
>         fs/ext4/inode.c:4533 __ext4_get_inode_loc_noinmem()
>         error: uninitialized symbol 'err_blk'.
>
>         fs/ext4/inode.c:4548 ext4_get_inode_loc()
>         error: uninitialized symbol 'err_blk'.
>
> fs/ext4/inode.c
>     4523 static int __ext4_get_inode_loc_noinmem(struct inode *inode,
>     4524                                         struct ext4_iloc *iloc)
>     4525 {
>     4526         ext4_fsblk_t err_blk;
>     4527         int ret;
>     4528
>     4529         ret = __ext4_get_inode_loc(inode->i_sb, inode->i_ino, NULL, iloc,
>     4530                                         &err_blk);
>     4531
>     4532         if (ret == -EIO)
> --> 4533                 ext4_error_inode_block(inode, err_blk, EIO,
>
> Only the last return -EIO sets err_blk.  The first return -EIO leaves it
> uninitialized.
>
>     4534                                         "unable to read itable block");
>     4535
>     4536         return ret;
>     4537 }
>
> regards,
> dan carpenter
