Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61A5442D92
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Nov 2021 13:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhKBMOe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Nov 2021 08:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhKBMOd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Nov 2021 08:14:33 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07E2C061714
        for <linux-ext4@vger.kernel.org>; Tue,  2 Nov 2021 05:11:58 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id h81so16409979iof.6
        for <linux-ext4@vger.kernel.org>; Tue, 02 Nov 2021 05:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fn6VCWJKrMzaFmQK8GLB33tUNtwhxadTYh4FOgZm2Ag=;
        b=UPijd0mKp+LahYTijRQLOZN/BxmOiojYbfQtMVV1Us/9/kx6VB9m19G+q5eLZOf5dQ
         KDIoDItTGMwE7q+glhhQ4LrlHueit5VaYZWn9ZWds3tuJrcxpNoaCEJGlirthTwuhLW2
         lgsCfbuYkY10xX2c8WI0mIb7LTq3ILxiw1Z+QIq4XdikTPUyKxIIreU2kzfmxo9W/eHf
         l5PF8FZz9R1ekislHMJKlpJe5qDP1fFJazCFTottw5MrcTyL7B8M8v+XzMMYb32By/Jr
         upPg4lDpw9ePOd04Eh3tRJhtU8aFubPwh7h7YfB5PAz8BsAw7574NhYzsADrqB5HwpCQ
         NJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fn6VCWJKrMzaFmQK8GLB33tUNtwhxadTYh4FOgZm2Ag=;
        b=6Vg3MzsXe+0SIXEyf+GeFOn2pr7VvFhpv22/C2RfnH9jIDxruI3Elt/Asi5jxJC3Fb
         KejgyI9d09rnJIDqJ9SX6Sy1iE1FIwKo7k3upn+kb4R1XFcWHX9MMqmL8qc4ztJj6gNP
         5lj4VGpx3FgG7BpftFyb45nAvx4YmdSIFac6g8hcL0n66rLTuqYnsavWufaDs3GrfBYF
         +ORPfEkKal+o3kBzGtJtg6zpKvlLb1dlcsmn8wf1XmhBsVcfG/z9xihOuPfJQs5f3Ikw
         8G3cQcSQs1IG5RMkynwZEIeovU+etPPFRfS01DXf8009spSl7uCsqeoLinOebhnSDquL
         uSHA==
X-Gm-Message-State: AOAM5306Sogd0rM69NUEHw9ZDG1P+IzNs2yZv+Novl/hyRm4JgJc5g0+
        UBI831SF9mND39hjkxs8YXQLLY2OCeU+7g4LS5o=
X-Google-Smtp-Source: ABdhPJxa2GjFYbDA6gWIogLfCR8jiI7YRd2StQaWfjDYqvBDNyeW+8ADxMDPNPl8R0EvCYs67H6Jv0zMQT1Ffft+mUI=
X-Received: by 2002:a5d:804a:: with SMTP id b10mr23505059ior.197.1635855118330;
 Tue, 02 Nov 2021 05:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211029211732.386127-1-krisman@collabora.com>
 <20211029211732.386127-3-krisman@collabora.com> <YYEoAr743j3IO3ol@google.com>
In-Reply-To: <YYEoAr743j3IO3ol@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 2 Nov 2021 14:11:47 +0200
Message-ID: <CAOQ4uxiSKNcxWBu+MdhOzhYWmLC9Aj2zoquUhTVn0q2x2SbxCw@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] syscalls: fanotify: Add macro to require specific events
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jan Kara <jack@suse.com>, LTP List <ltp@lists.linux.it>,
        Khazhismel Kumykov <khazhy@google.com>, kernel@collabora.com,
        Ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 2, 2021 at 1:59 PM Matthew Bobrowski <repnop@google.com> wrote:
>
> On Fri, Oct 29, 2021 at 06:17:25PM -0300, Gabriel Krisman Bertazi wrote:
> > Add a helper for tests to fail if an event is not available in the
> > kernel.  Since some events only work with REPORT_FID or a specific
> > class, update the verifier to allow those to be specified.
> >
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> Made a single comment, otherwise this looks OK to me.
>
> Reviewed-by: Matthew Bobrowski <repnop@google.com>
>
> > ---
> > Changes since v1:
> >   - Use SAFE_FANOTIFY_INIT instead of open coding. (Amir)
> >   - Use FAN_CLASS_NOTIF for fanotify12 testcase. (Amir)
> > ---
> >  testcases/kernel/syscalls/fanotify/fanotify.h   | 17 ++++++++++++++---
> >  testcases/kernel/syscalls/fanotify/fanotify03.c |  4 ++--
> >  testcases/kernel/syscalls/fanotify/fanotify10.c |  3 ++-
> >  testcases/kernel/syscalls/fanotify/fanotify12.c |  3 ++-
> >  4 files changed, 20 insertions(+), 7 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> > index c67db3117e29..820073709571 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> > @@ -266,14 +266,16 @@ static inline void require_fanotify_access_permissions_supported_by_kernel(void)
> >       SAFE_CLOSE(fd);
> >  }
> >
> > -static inline int fanotify_events_supported_by_kernel(uint64_t mask)
> > +static inline int fanotify_events_supported_by_kernel(uint64_t mask,
> > +                                                   unsigned int init_flags,
> > +                                                   unsigned int mark_flags)
> >  {
> >       int fd;
> >       int rval = 0;
> >
> > -     fd = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
> > +     fd = SAFE_FANOTIFY_INIT(init_flags, O_RDONLY);
> >
> > -     if (fanotify_mark(fd, FAN_MARK_ADD, mask, AT_FDCWD, ".") < 0) {
> > +     if (fanotify_mark(fd, FAN_MARK_ADD | mark_flags, mask, AT_FDCWD, ".") < 0) {
> >               if (errno == EINVAL) {
> >                       rval = -1;
> >               } else {
> > @@ -378,4 +380,13 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
> >                                   fanotify_mark_supported_by_kernel(mark_type)); \
> >  } while (0)
> >
> > +#define REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(init_flags, mark_type, mask, fname) do { \
> > +     if (mark_type)                                                  \
> > +             REQUIRE_MARK_TYPE_SUPPORTED_ON_KERNEL(mark_type);       \
> > +     if (init_flags)                                                 \
> > +             REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(init_flags, fname); \
> > +     fanotify_init_flags_err_msg(#mask, __FILE__, __LINE__, tst_brk_, \
> > +             fanotify_events_supported_by_kernel(mask, init_flags, mark_type)); \
> > +} while (0)
> > +
> >  #endif /* __FANOTIFY_H__ */
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
> > index 26d17e64d1f5..2081f0bd1b57 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify03.c
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
> > @@ -323,8 +323,8 @@ static void setup(void)
> >       require_fanotify_access_permissions_supported_by_kernel();
> >
> >       filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
> > -     exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC_PERM);
> > -
> > +     exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC_PERM,
> > +                                                                   FAN_CLASS_CONTENT, 0);
> >       sprintf(fname, MOUNT_PATH"/fname_%d", getpid());
> >       SAFE_FILE_PRINTF(fname, "1");
> >
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> > index 92e4d3ff3054..0fa9d1f4f7e4 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> > @@ -509,7 +509,8 @@ cleanup:
> >
> >  static void setup(void)
> >  {
> > -     exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC);
> > +     exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC,
> > +                                                                   FAN_CLASS_CONTENT, 0);
>
> I'm wondering whether this is the best combination of mask and
> init_flags to use in this particular case? Maybe not to confuse future
> readers, using FAN_CLASS_NOTIF explicitly here would be better, WDYT?
> It doesn't make a difference, but it's something that caught my eye
> while parsing this patch.
>

Wow.
I think you are right in that this test does not use the combination
FAN_OPEN_EXEC with FAN_CLASS_CONTENT group, but it is quite hard
figure this out.

It will also be quite hard to figure out if this ever changes if ever new
test cases are added, so it will be hard to catch a change like that in review.
Given all that I would not change the requirement.

Thanks,
Amir.
