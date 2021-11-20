Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3156457D2C
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Nov 2021 11:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhKTKrN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 20 Nov 2021 05:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhKTKrN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 20 Nov 2021 05:47:13 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA24C061574
        for <linux-ext4@vger.kernel.org>; Sat, 20 Nov 2021 02:44:10 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id j21so7191926ila.5
        for <linux-ext4@vger.kernel.org>; Sat, 20 Nov 2021 02:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5SpO5spxTcSzoLsZFFqEN0XD8XHtKSnd+Zt6F79jc6M=;
        b=cVxA1UZL6Oi5s5Mkz+5Hyi4BuZdP3Ek/tBwNTOMLCNBsV8+JSYfEskFw83grAZgb5M
         KT+0y2VKMJmwse15Iwa0Kxv7+5Gs1Jm3K5WG5VA8WfXoLuZkjVuUN6mamP1yTNAdJlWp
         GRgJVC4M+4vYM9qCLsHzOY5e4KZpCBveFvGD1iaRHYsVtWZynPnjMTBHJU41aBZt7Owy
         jNzM5wZPSGmRjplIEzrIW4Ee3GiqvN9Fld/Lq6mhcsHigXtrKhxpiFBqPxiwAzafUzv9
         e6tUeCAtxAt34dSYZZMU0S6ED1s+PTZ7BN3QmRyYKOFXx4KEhG5eve8h3QkTdTcjBtDr
         c/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5SpO5spxTcSzoLsZFFqEN0XD8XHtKSnd+Zt6F79jc6M=;
        b=Zs7C69tuMOADBRfUBhf223+bzpyq2cs4jQCkrAT3hLFn62apSNK+vKA90XOf+qxxJ4
         lABISgCr9d+NQndT2tRTmlIu1cZ+aXbEmf/dMHpmB1RTgILpjWOHX5eFHfE3DuQyEg67
         r6GFGLYeKy3F9Yx2eclddcuESok6IMgeHU2PzZLC81B5fqEyoSF0yTRzskHWk41RjLVX
         M54IQQ5bMLkd0sn9tvcge7hwDkHbICgaXrZYVBDpbfnSIfXD8WU9dAMqcK57ayHdjBVt
         /cBlvVl6V1WaPXypCeynvvi0lHcxV0Z5IqGjXpB0DdLV7f1vMdg3V2PVOP91b7gLS+5g
         n1oQ==
X-Gm-Message-State: AOAM533UAQ15xBvD11WiwFEcLWQpmVv8eOB1kOVW2KEwWZRz19DsVl/O
        WrkuTmNn8Gq36NpJN6Puy11w5/zfFMR7LaUxfYM=
X-Google-Smtp-Source: ABdhPJxKotlZK6PZWiQlANS6i7fUvmkubzuyHmR1DF7uxbNrU4eog4am/1bAHv5RSsZ/tSftR7lETMSm0Qw41CPZH4k=
X-Received: by 2002:a05:6e02:1ba6:: with SMTP id n6mr9663312ili.254.1637405049441;
 Sat, 20 Nov 2021 02:44:09 -0800 (PST)
MIME-Version: 1.0
References: <20211118235744.802584-1-krisman@collabora.com>
 <CAOQ4uxhbDgdZZ0qphWg1vnW4ZoAkUxcQp631yZO8W49AE18W9g@mail.gmail.com> <8735nsuepi.fsf@collabora.com>
In-Reply-To: <8735nsuepi.fsf@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 20 Nov 2021 12:43:58 +0200
Message-ID: <CAOQ4uxg0EfxefoGZr35C5HQR2Ac7BZ_HnTCq1eipvUa=iuQRWg@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] Test the new fanotify FAN_FS_ERROR event
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Petr Vorel <pvorel@suse.cz>, Jan Kara <jack@suse.com>,
        Matthew Bobrowski <repnop@google.com>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
        Khazhismel Kumykov <khazhy@google.com>,
        LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> >> A proper manpage description is also available on the respective mailing
> >> list, or in the branch below:
> >>
> >>     https://gitlab.collabora.com/krisman/man-pages.git -b fan-fs-error
> >>
> >> Please, let me know your thoughts.
> >>
> >
> > Gabriel,
> >
> > Can you please push these v4 patches to your gitlab tree?
>
> Hi Amir,
>
> I have pushed v4 to :
>
> https://gitlab.collabora.com/krisman/ltp.git -b fan-fs-error_v4
>

Thanks. I've based my fan_rename ltp branch on this.
I would like to do the same for the man-page update branch.
However, Matthew's man page updates for v5.15 are conflicting
with your changes, so after Matthew posts v2 of his man page patch,
please rebase your changes on top of his branch.

Ideally, you could have waited until Matthew's changes are merged
upstream, like you did for ltp before rebasing, but man-pages maintainers
are quite behind on merging updates, so we will need to collaborate
between us in the meanwhile.

Thanks,
Amir.
