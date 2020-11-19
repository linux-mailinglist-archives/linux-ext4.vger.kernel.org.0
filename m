Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C3B2B9360
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Nov 2020 14:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgKSNNI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Thu, 19 Nov 2020 08:13:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39946 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgKSNNH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Nov 2020 08:13:07 -0500
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mauricio.oliveira@canonical.com>)
        id 1kfjkH-0001sM-EW
        for linux-ext4@vger.kernel.org; Thu, 19 Nov 2020 13:13:05 +0000
Received: by mail-wr1-f70.google.com with SMTP id e18so1984614wrs.23
        for <linux-ext4@vger.kernel.org>; Thu, 19 Nov 2020 05:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wm5LHdk0kA60K7xTn75y9xNvk72GVA+a8TSGemxSNig=;
        b=DoOj87Smr5dP52m/1ApV93IzssHXpjejTSgOPM/UL26RJ96rJKdGx9KFFKaca9RpP/
         UknkYvFKYGXEQ7n856aW9Ne68SLST8hcDx5n8VdpQBw1jh7vmHMrzh3KcIpmRaE/eczE
         d2bA90G6Czm2Dr+VQzBREvzDN7wAyiyKJTRQg9yILoDPeHJ+fQ5uTUW5vdSchNip2FcX
         rMrU3H0VuvezgSRyAIBs/bRwen1bGVBQEMnX+hAyoAdiD6xPJEtneulAFkv/9knz0Rzw
         D+WntoYSMIu7OnByGE6Yco5GT+BTCnVmgWjyp/fkiWURvhP3WiHAXs811igcukejXUkM
         a6fg==
X-Gm-Message-State: AOAM531+XsgTG6OwQKlZ6+60FkMI+L3sNIp0QWggrz+JDkQvLotUrWHl
        v89IfmyECFhiiPfBl4ayRjVyeT0U4kARl7RPh1dFS+JpN51WmMx7n7QdX2U8sseglqZK0NyL/E4
        03GiDOubn2H1BDwZP8lZF5EZERTdQGeLvKK45NvDgIDFqiOfYTxsM9+0=
X-Received: by 2002:a1c:3d4:: with SMTP id 203mr4466039wmd.52.1605791584223;
        Thu, 19 Nov 2020 05:13:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyh7Q2jOJsr0R/K4QDgGv7NVP75aUJnoR/Fq+BMx24UlKexc6dcCaSubKkARHx1XrxOp44S42qMGMgRM0PMRt8=
X-Received: by 2002:a1c:3d4:: with SMTP id 203mr4466026wmd.52.1605791584042;
 Thu, 19 Nov 2020 05:13:04 -0800 (PST)
MIME-Version: 1.0
References: <68b9650e-bef2-69e2-ab5e-8aaddaf46cfe@huawei.com>
 <CAO9xwp12E1wjErfX-Ef6+OKnme_ENOx22Hh=44g9cLn7aBr3-w@mail.gmail.com> <c4c16548-1f37-a63e-de38-de5812bcc97e@huawei.com>
In-Reply-To: <c4c16548-1f37-a63e-de38-de5812bcc97e@huawei.com>
From:   Mauricio Oliveira <mauricio.oliveira@canonical.com>
Date:   Thu, 19 Nov 2020 10:12:52 -0300
Message-ID: <CAO9xwp37T_pDohXYOpHhb-KhDYUBEMR0qDN0NJvCLRUoG3CK2Q@mail.gmail.com>
Subject: Re: [Bug report] journal data mode trigger panic in jbd2_journal_commit_transaction
To:     yangerkun <yangerkun@huawei.com>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        "zhangyi (F)" <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        zhangxiaoxu5@huawei.com, Ye Bin <yebin10@huawei.com>,
        hejie3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Nov 19, 2020 at 1:25 AM yangerkun <yangerkun@huawei.com> wrote:
>
>
>
> 在 2020/11/16 21:50, Mauricio Oliveira 写道:
> > Hi Kun,
> >
> > On Sat, Nov 14, 2020 at 5:18 AM yangerkun <yangerkun@huawei.com> wrote:
> >> While using ext4 with data=journal(3.10 kernel), we meet a problem that
> >> we think may never happend...
> > [...]
> >
> > Could you please confirm you mean 5.10-rc* kernel instead of 3.10?
> > (It seems so as you mention a recent commit below.)  Thanks!
> >
> >> For now, what I have seen that can dirty buffer directly is
> >> ext4_page_mkwrite(64a9f1449950 ("ext4: data=journal: fixes for
> >> ext4_page_mkwrite()")), and runing ext4_punch_hole with keep_size
> >> /ext4_page_mkwrite parallel can trigger above warning easily.
> > [...]
> >
> >
>
> Hi,
>
> Sorry for the long delay reply... And thanks a lot for your advise! The
> bug trigger with a very low probability. So won't trigger with 5.10 can
> not prove no bug exist in 5.10.
>

No worries, and thanks for following up.
So I understand that the bug report was indeed on 3.10, and 5.10-rcN
is not yet confirmed.

> Google a lot and notice that someone before has report the same bug[1].
> '3b136499e906 ("ext4: fix data corruption in data=journal mode")' seems
> fix the problem. I will try to understand this, and give a analysis
> about how to reproduce it!

Cool, thanks!

> Thanks,
> Kun.



-- 
Mauricio Faria de Oliveira
