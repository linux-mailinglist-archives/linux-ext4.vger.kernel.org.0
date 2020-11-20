Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44F72BAAE0
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Nov 2020 14:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgKTNOV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Nov 2020 08:14:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47818 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbgKTNOV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Nov 2020 08:14:21 -0500
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mauricio.oliveira@canonical.com>)
        id 1kg6F0-0006iF-MV
        for linux-ext4@vger.kernel.org; Fri, 20 Nov 2020 13:14:18 +0000
Received: by mail-wm1-f71.google.com with SMTP id y1so4030605wma.5
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 05:14:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TUJgugLJ2H1s7wGSfv75yb4ltTR/UlMIcV/u2lF0ss4=;
        b=AZTRYlgjsax0HSvlSjyn591zYJ3oRiSPTOWUzjVe5Le6QjeaD4WPI7fsl1m3HUlxzr
         EIP1DmGaPwVJ9kVpe6KO8WdkpfcN5K8sM6hez0y9yZNtdKbxgSWdf6BwxRS4c6eLWht4
         9klTUGnkAEO91B9aNTXEibL2wMS+HWLfBBSIo4fkvk6+qIs+KHafjIkVMq5KhrUGMh5H
         wz3oyZSQJf/E1dSCFWK+2NAF/0J45kebHJCOWLEVheG+6npobqvp2WhbIEjnMvIDakw/
         +9oWPihShjDfyJ/6m8XkrdwkGAHx7uBSnIYqhDrI0njJBUNLqZPczzR+lQ3smCH3FAZJ
         smnQ==
X-Gm-Message-State: AOAM532RyBMzK3PMSazscnsT21UkIvRffkLQraoA2+FttFWhSxC8eXlL
        ndRvaYnJsl82SINikbTRtb8e2xaO5mr1MY6CNOuUmzHvAZUXV96H3jIGYoSunMBynnyvzxXaruE
        B0h3o2POQ7gyxEjASbaReN87oa84vRJ9MaRU1RoMyz6B1kE9yl9pxTR8=
X-Received: by 2002:a7b:c772:: with SMTP id x18mr10440894wmk.185.1605878057565;
        Fri, 20 Nov 2020 05:14:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDO9iwWv/AEpDw7EDN/rfh3P26WXYxEtrhpDEnIvfjlVdgfolORiWE04XGqlJtVuByLWdCYQM15V8uxi7odGo=
X-Received: by 2002:a7b:c772:: with SMTP id x18mr10440868wmk.185.1605878057380;
 Fri, 20 Nov 2020 05:14:17 -0800 (PST)
MIME-Version: 1.0
References: <68b9650e-bef2-69e2-ab5e-8aaddaf46cfe@huawei.com>
 <CAO9xwp12E1wjErfX-Ef6+OKnme_ENOx22Hh=44g9cLn7aBr3-w@mail.gmail.com>
 <c4c16548-1f37-a63e-de38-de5812bcc97e@huawei.com> <CAO9xwp37T_pDohXYOpHhb-KhDYUBEMR0qDN0NJvCLRUoG3CK2Q@mail.gmail.com>
 <17d7ecde-5fda-cd03-6fef-e7b8250489f9@huawei.com>
In-Reply-To: <17d7ecde-5fda-cd03-6fef-e7b8250489f9@huawei.com>
From:   Mauricio Oliveira <mauricio.oliveira@canonical.com>
Date:   Fri, 20 Nov 2020 10:14:05 -0300
Message-ID: <CAO9xwp1=BGpZtt4yeVicqCwascMxoJ3khG_JC9V3tpjXjOstPQ@mail.gmail.com>
Subject: Re: [Bug report] journal data mode trigger panic in jbd2_journal_commit_transaction
To:     yangerkun <yangerkun@huawei.com>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        "zhangyi (F)" <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        zhangxiaoxu5@huawei.com, Ye Bin <yebin10@huawei.com>,
        hejie3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Kun,

On Thu, Nov 19, 2020 at 11:54 PM yangerkun <yangerkun@huawei.com> wrote:
> Hi,
>
> The follow step can reproduce the bug[1] reported before easily. And the
> bug we meet seems same. Following patch will fix the bug.
>
> 3b136499e906 ext4: fix data corruption in data=journal mode
> b90197b65518 ext4: use private version of page_zero_new_buffers() for
> data=journal mode

Since this issue is apparently on a 3.10 kernel, which is no longer
maintained upstream [see 2],
I guess you have to talk to the distro vendor about including such
patches in their kernel.

[2] https://www.kernel.org/

cheers,

-- 
Mauricio Faria de Oliveira
