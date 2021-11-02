Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47E0442D9F
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Nov 2021 13:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhKBMQL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Nov 2021 08:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhKBMQI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Nov 2021 08:16:08 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C28C061714
        for <linux-ext4@vger.kernel.org>; Tue,  2 Nov 2021 05:13:33 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id h23so8109587ila.4
        for <linux-ext4@vger.kernel.org>; Tue, 02 Nov 2021 05:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mRRv7E+69/vVKkYW5342PCyFEeOfIo3cLN4E2lz8zzw=;
        b=qLJXf/NpGMRi+g1+Ss1mT3nGqoA4huV4gw3WrmPl4Rwag3nrrx2Gg4TzaIp1s2Pxtg
         qWNmf2Zm4kISmuE728jdrTly1UECxCq7PvJ1DdR0NCO8Cxcz32CgRUjHgLn1PiFf/Wqs
         Dx39R1YZAW2CVnCMYw3YR+sIqU9PBwacrCA9kj96L+PlkryTdzcy3Ryxc08syEOledE7
         +oplfcQTepHRS3eFDpIHzngUSa+7IWtAtESX1YpnOsCigYA8AT7u9k9idM+KCzjrcxh7
         0jEt/8CtfakiZUwBzyJNTMZ2FlDQ/YKa8G7GfyfIk+aLjvh4x/a+162uZQAc76QzykJf
         qcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mRRv7E+69/vVKkYW5342PCyFEeOfIo3cLN4E2lz8zzw=;
        b=bQ0rJ0OQeCf+Wsk+qDJr5VriAubJY0O2QugW1nN7thyf5uW6qg4t8TwNRyeKHw8B5Y
         k/xuSgD5tRGxUkhISHqLyL7QSp0IiIYYcWQdtLjhqt7LHYYhN/DIR0MP5mStFQV9PXW0
         vzq8ESqAX0vuXXRCcdVTdNFn19Xt0qo+nlRr9U/kHrE5M7T54Q2wan/O94kbH7HtHRh1
         dt1dFA4lY/8zEHvvWQWHzNvWXj7kcJkEKYkVBXtaLCeLd2zeU6cPSLD/m0D26mUydKFD
         y26ohcGhpqt3mx81iwHS8cXhzrAFl8tDi6OCdguxozq2R9FeghaxxEZErROp3vi+XXH0
         FqnQ==
X-Gm-Message-State: AOAM5325DePSiwoLDWGCa4Yf2PeULfncEBNOrpn3Uz7WBTgJSsx7p+1s
        0lNw3s2Xlah6sYM1WuihHc1BFHeg1V2m7pHHFYU=
X-Google-Smtp-Source: ABdhPJydtBHU2UTFcy6EgBHaXPFJYQtGjjUl5mjlDqROX1fwXIOEDiWWkoyCRwRDFGFpYx/opWpn14Qm7zWP1E+C+AE=
X-Received: by 2002:a92:dc0c:: with SMTP id t12mr16924675iln.198.1635855212646;
 Tue, 02 Nov 2021 05:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211029211732.386127-1-krisman@collabora.com>
 <20211029211732.386127-2-krisman@collabora.com> <YYEgqgFoo7oJheFr@google.com>
In-Reply-To: <YYEgqgFoo7oJheFr@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 2 Nov 2021 14:13:21 +0200
Message-ID: <CAOQ4uxiZetvK=r-tedgqNXR4nT=+kWUG5eVRWu8wVUQY5PN0Ew@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] syscalls: fanotify: Add macro to require specific
 mark types
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jan Kara <jack@suse.com>, LTP List <ltp@lists.linux.it>,
        Khazhismel Kumykov <khazhy@google.com>, kernel@collabora.com,
        Ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 2, 2021 at 1:27 PM Matthew Bobrowski <repnop@google.com> wrote:
>
> On Fri, Oct 29, 2021 at 06:17:24PM -0300, Gabriel Krisman Bertazi wrote:
> > Like done for init flags and event types, and a macro to require a
> > specific mark type.
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> > ---
> >  testcases/kernel/syscalls/fanotify/fanotify.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> > index a2be183385e4..c67db3117e29 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> > @@ -373,4 +373,9 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
> >       return rval;
> >  }
> >
> > +#define REQUIRE_MARK_TYPE_SUPPORTED_ON_KERNEL(mark_type) do { \
> > +     fanotify_init_flags_err_msg(#mark_type, __FILE__, __LINE__, tst_brk_, \
> > +                                 fanotify_mark_supported_by_kernel(mark_type)); \
> > +} while (0)
> > +
> >  #endif /* __FANOTIFY_H__ */
>
> A nit, but I'm of the opinion that s/_ON_/_BY_ within the macro name. Otherwise,
> this looks OK to me.

Agreed. You can change that while cherry-picking to your branch ;-)

Thanks,
Amir.
