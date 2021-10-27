Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C0143C787
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Oct 2021 12:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241388AbhJ0KWO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Oct 2021 06:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241374AbhJ0KWM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Oct 2021 06:22:12 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A712DC061767
        for <linux-ext4@vger.kernel.org>; Wed, 27 Oct 2021 03:19:47 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id h2so2331421ili.11
        for <linux-ext4@vger.kernel.org>; Wed, 27 Oct 2021 03:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZRuknEg+bXzpHdRasbCR+VO8e6gnGIeqPTgWpleV5F4=;
        b=JH4SaBvKR5O8U4dJwVuauo33s+p6H2UNOBc5R/7r3Rqi+YctqoMD0h0C2J1z+ZAn2y
         AvHtVwmrA9gqRDe2T3y+dv9jb2ygo4JvU1lHEdvt526VG0dtNyHbG40R4WKWutuYrjEW
         lCNhOJAbG0dUOO552OQWwmkc16+A3QzNOh1j9m8+3z05k8Hd+bDPJtUkQ//xWV4zaUQe
         UruwJxdgdGOThMCVR0dc1cLULc9l55A7u1Chl3fJv6Nk03n/4rBidkio1M6njFoaEkIS
         eS1jbyziN2P4t579mW8Dt0rCz/pRknwEIg7/BiVL6Vz8Qn0O8TSSfcmOj0U2tvVoh8rk
         4MQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZRuknEg+bXzpHdRasbCR+VO8e6gnGIeqPTgWpleV5F4=;
        b=yxjaMTDFOIgrpqFWnP0Er8pMq6TIYLV73IhLLyChq0Ks6KLn4By+q6uvlGjWZd5JFD
         2wfUT9wNQzUOgvfBU6JIZby/lfUB+c6BGHdZ/jTnwUA+zb28qPpuYqpVQW07qyfd+Ief
         TPzG90yTM2rLQ2PqWyOfFrXS+XUo4XhRiCys1pI7pCbrKwMoObOE/AtTI/2n/lS3v0i8
         ETwcqsvlzFY/72MfPIYSxIxCJdugwiAs28vvf8obAN0RjTwVXVWaVh2uN86CW2G85wrr
         Yo7Me/OGwOj+hwbhjD/j60Se0iHxriEuC/ig35UK5i7yXWnINJnSEN0KWhiC/9jpvcUU
         4HTw==
X-Gm-Message-State: AOAM533FJOxW5Ji/OL17swX4Ya85juymuddAlnFlPyLKe459iCoV2ISD
        E41vkPSjKQ5EPdUlXlVedXZ4wQ6UuQHUX5SKU+k=
X-Google-Smtp-Source: ABdhPJwNSxhip3enHdK5O5ZdpZUhCLr79/Cu4g5rCXygrWtdPDIM7xYpUoVhjO26KTu50j0PPkBhvQ005qNSAiZtGcU=
X-Received: by 2002:a05:6e02:18cf:: with SMTP id s15mr13759138ilu.198.1635329987184;
 Wed, 27 Oct 2021 03:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211026184239.151156-1-krisman@collabora.com>
 <20211026184239.151156-5-krisman@collabora.com> <CAOQ4uxgtkV7kF-YoWH4mau-p2U6bwLb1ajHXmVV1hwoDVpEDTQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgtkV7kF-YoWH4mau-p2U6bwLb1ajHXmVV1hwoDVpEDTQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 27 Oct 2021 13:19:36 +0300
Message-ID: <CAOQ4uxia1GQPPbZXTiKnP-CWkfVczDhMmTe6+C5R_Gk1USOd-A@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] syscalls/fanotify20: Validate the generic error info
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     LTP List <ltp@lists.linux.it>, Jan Kara <jack@suse.com>,
        Khazhismel Kumykov <khazhy@google.com>, kernel@collabora.com,
        Ext4 <linux-ext4@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 27, 2021 at 9:43 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Oct 26, 2021 at 9:43 PM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
> >
> > Implement some validation for the generic error info record emitted by
> > the kernel.  The error number is fs-specific but, well, we only support
> > ext4 for now anyway.
> >
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> >
>
> After fixing and testing configure.ac you may add:
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>
> > ---
> > Changes since v1:
> >   - Move defines to header file.
> > ---
> >  testcases/kernel/syscalls/fanotify/fanotify.h | 32 +++++++++++++++++
> >  .../kernel/syscalls/fanotify/fanotify20.c     | 35 ++++++++++++++++++-
> >  2 files changed, 66 insertions(+), 1 deletion(-)
> >
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> > index 8828b53532a2..58e30aaf00bc 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> > @@ -167,6 +167,9 @@ typedef struct {
> >  #ifndef FAN_EVENT_INFO_TYPE_DFID
> >  #define FAN_EVENT_INFO_TYPE_DFID       3
> >  #endif
> > +#ifndef FAN_EVENT_INFO_TYPE_ERROR
> > +#define FAN_EVENT_INFO_TYPE_ERROR      5
> > +#endif
> >
> >  #ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_HEADER
> >  struct fanotify_event_info_header {
> > @@ -184,6 +187,14 @@ struct fanotify_event_info_fid {
> >  };
> >  #endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID */
> >
> > +#ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_ERROR
> > +struct fanotify_event_info_error {
> > +       struct fanotify_event_info_header hdr;
> > +       __s32 error;
> > +       __u32 error_count;
> > +};
> > +#endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_ERROR */
>
> Need to add in configure.ac:
>
> AC_CHECK_TYPES([struct fanotify_event_info_error, struct
> fanotify_event_info_header],,,[#include <sys/fanotify.h>])
>
> (not tested)

According to Matthew's pidfd patches the syntax should be:

AC_CHECK_TYPES([struct fanotify_event_info_fid, struct
fanotify_event_info_header, struct fanotify_event_info_pidfd, struct
fanotify_event_info_error],,,[#include <sys/fanotify.h>])

Thanks,
Amir.
