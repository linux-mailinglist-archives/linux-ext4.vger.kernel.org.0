Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7C618BAD0
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Mar 2020 16:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgCSPSj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Mar 2020 11:18:39 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34085 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgCSPSi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Mar 2020 11:18:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id s13so2950191ljm.1
        for <linux-ext4@vger.kernel.org>; Thu, 19 Mar 2020 08:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DaeWC4paZt+okt8puKvfMsZYLYpCKtr88Og+vqz2+d0=;
        b=r+RbF6Wl+QIWtN5XgXv6Wy2ndXU5gukf1+a7pWlNOs5UXvn7YdvBmyG7iFWF9CF4n4
         vgfHfWQevvjEbPyyIS4sx0LC3EN1MjUwlF0qyHp7CCv2/hQP5Z9svKAN5/BVjjc+KWDZ
         /fzZtBSH8s8vEh6tIEXW181elPRKVfIZojEkMLhntKshIWE3NT18Zuyc7vQmkYGgA/Aa
         vZsJo7Zq9QZizRwSmR++Fe+dLqNFtNPcglCy3LBQr8z33Amddo3q87Qy8X0WaByIzVl6
         JsOtm8s3XVSXU2xlr7YxNgQC7oYoSlO4NDtBevbRaVGZ6HpBYe8GNq1cwZ+b3dqDWRVx
         /CDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DaeWC4paZt+okt8puKvfMsZYLYpCKtr88Og+vqz2+d0=;
        b=Ow+mEee1ZVlgy1M+9ydFSxV1d/YbwL8gqOfWSn3oh8fdlX0moXpsCSFWoaG5hsOX5v
         N8OX6Iao4CJRnEagwAop54UDh2aza+Tbzkz3iKaHG10w49/+Vo9Fr6VcDegzwWx8HdQt
         1E2UtE4FfU6+zUxmRF/x1VpNeAxL9iE1FbYeuAtC7ZJhUt4qQMvQjl2LspnQRqd/wakc
         0EWmZIX5LDFKC+IeD/ResJY99Q+VJXEGYxlljbE0JOo7PXtHdW+yLeo9iPlRqdR5Z0Z7
         wPsJDEVys9hgMc4JUUlY5Ic1boGc0fhJlbfaur7BiBH2sYTQkj+0TEnURWizMjU88GAp
         75OQ==
X-Gm-Message-State: ANhLgQ3Nt0Oip0zrrPvVHyEq9R4We0DViorEz2ba1g3W9dqDsDVTQfZT
        4mMwHVMutWuwV+CZzJUkuAZ9IjCAW+LwK9I/lqUuvg==
X-Google-Smtp-Source: ADFU+vvPeA7ClISh6i31iBhj6nefmh3Eg2iEFzmPH9zvoxRoXYDbUZ5mYl74GCE7OJXyqnP17DOPXATaVBvt+m4FxYI=
X-Received: by 2002:a2e:9a90:: with SMTP id p16mr2538498lji.277.1584631116087;
 Thu, 19 Mar 2020 08:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200317113153.7945-1-linus.walleij@linaro.org> <88FAA4EA-7DAF-478F-8DFE-747FAF4CF818@dilger.ca>
In-Reply-To: <88FAA4EA-7DAF-478F-8DFE-747FAF4CF818@dilger.ca>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 Mar 2020 16:18:24 +0100
Message-ID: <CACRpkdbc=7Ozf472HGUZnQgWTJjoXuopts_EWLse__Ho4PZyRw@mail.gmail.com>
Subject: Re: [PATCH] ext4: Give 32bit personalities 32bit hashes
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Peter Maydell <peter.maydell@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Mar 17, 2020 at 11:29 PM Andreas Dilger <adilger@dilger.ca> wrote:

> That said, I'd think it would be preferable for ease of use and
> compatibility that applications didn't have to be modified
> (e.g. have QEMU or glibc internally set PER_LINUX32 for this
> process before the 32-bit syscall is called, given that it knows
> whether it is emulating a 32-bit runtime or not).

I think the plan is that QEMU set this, either directly when
you run qemu-user or through the binfmt handler.
https://www.kernel.org/doc/html/latest/admin-guide/binfmt-misc.html

IIUC the binfmt handler is invoked when you try to
execute ELF so-and-so-for-arch-so-and-so when you
are not that arch yourself. So that can set up this
personality.

Not that I know how the binfmt handler works, I am just
assuming that thing is some program that can issue
syscalls. It JustWorks for me after installing the QEMU
packages...

The problem still stands that userspace need to somehow
inform kernelspace that 32bit is going on, and this was the
best I could think of.

Yours,
Linus Walleij
