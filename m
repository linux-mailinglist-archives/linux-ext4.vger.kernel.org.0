Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85012ED07B
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Jan 2021 14:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbhAGNRX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jan 2021 08:17:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbhAGNRX (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 7 Jan 2021 08:17:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFE49224B2;
        Thu,  7 Jan 2021 13:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610025402;
        bh=QmL4gwaruMyEzb9wlsHh8j27tKlovaSI3kLbdCHshWQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Stu0AztRS+ejfWCk9DTrhtqADdNdFYlJ5HdYOSIff4kqHwY8ilkMxSVaQ0Qjtt78j
         bUutGGB4fvAJPfgCNq1M6SCE1WVYb2m5vD3LCWy2Z1SwEMP5BTgYrCG0Ui9TlkVvXU
         Wixl51oVDOFiuLxKSIVuzNOCOvrlBVtZ3pvzUZEJ1vX1ZFESI5X8wQltKVRjkuTxnu
         yvgKVcyMeFaiTi4YYhskBsI9y93eTIFoJhP6gD9w7qjMrPsKAfyb9CeQoIohX2xf+0
         ZPlCMVLJI/9qVe85tkkZfhYtjHsQS2RyZ6gqhQbIf0CKqbyheLWsB+dPk2oUwog4TB
         Ocb81aQxP7DSg==
Received: by mail-oo1-f46.google.com with SMTP id o5so1544644oop.12;
        Thu, 07 Jan 2021 05:16:42 -0800 (PST)
X-Gm-Message-State: AOAM532O2TGPuM9h9v9oYdpbMPV1iZKsSykjm5+qBVA0YdF7zRhp2ztL
        j6UmTie985LM62R8FnbyP0L4dlGWMg8DlsZLF60=
X-Google-Smtp-Source: ABdhPJyJgbGRIU0IGdkkEcptmjFwgAFtJpFQPDGT4dh99plTedsE/YppUBh1v+OG6OVe0mDt2zfqISgzafS4t8ek3kU=
X-Received: by 2002:a4a:2cc9:: with SMTP id o192mr1073655ooo.66.1610025401960;
 Thu, 07 Jan 2021 05:16:41 -0800 (PST)
MIME-Version: 1.0
References: <20210105154726.GD1551@shell.armlinux.org.uk> <20210106115359.GB26994@C02TD0UTHF1T.local>
 <20210106135253.GJ1551@shell.armlinux.org.uk> <20210106172033.GA2165@willie-the-truck>
 <20210106223223.GM1551@shell.armlinux.org.uk> <20210107111841.GN1551@shell.armlinux.org.uk>
 <20210107124506.GO1551@shell.armlinux.org.uk>
In-Reply-To: <20210107124506.GO1551@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 7 Jan 2021 14:16:25 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2TXPfFpgy+XjpDzOqt1qpDxufwiD-BLNbn4W_jpGp98g@mail.gmail.com>
Message-ID: <CAK8P3a2TXPfFpgy+XjpDzOqt1qpDxufwiD-BLNbn4W_jpGp98g@mail.gmail.com>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Will Deacon <will@kernel.org>, linux-toolchains@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 7, 2021 at 1:47 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:

> Arnd has found via bisecting gcc:
>
> 7e8c2bd54af ("[AArch64] fix unsafe access to deallocated stack")
>
> which seems to be https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63293
>
> That seems to suggest that gcc-5.0.0 is also affected.
>
> Looking at the changelog in Debian's gcc-8.3 packages, this doesn't
> feature, so it's not easy just to look at the changelogs to work out
> which versions are affected.

I checked the history to confirm that all gcc-5 releases (5.0.x is pre-release)
and later have the fix.

The gcc bugzilla mentions backports into gcc-linaro, but I do not see
them in my git history.

       Arnd
