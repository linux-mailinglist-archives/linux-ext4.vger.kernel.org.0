Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4293DFB2A
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Aug 2021 07:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbhHDFkU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Aug 2021 01:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbhHDFkT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Aug 2021 01:40:19 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE83C0613D5
        for <linux-ext4@vger.kernel.org>; Tue,  3 Aug 2021 22:40:06 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r6so1128911ioj.8
        for <linux-ext4@vger.kernel.org>; Tue, 03 Aug 2021 22:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4eWkAtXPKjUx8eSu0DoN0DWy+n6qfJjTgsRsQt2pWwI=;
        b=T7BYM1K/SBR8dMsVZh12AAZBuDhYnvnXCyWHgO5m8L7OxlLeLf7NRxxP+4y/wRqP1H
         CxIRJ1hAJplCVl+By29zOyxFCyio5TNhQLGCS20ocFUTmp4udxKjyDplntjhqRpzQ5Zc
         K4pBJe38dMvXJxCd11DDGI14Sgbk0JtDzR44c+SrNMLNbKvJ1iDsni3jjRp75QylvdUP
         /WHBL3abL6D+wNzvcP1amqP0EvZ3LqJViRvMzf7XujR8Dt1duNTQkmLRahL71JrBbo/v
         oNPEKcB+fA1tDYX98I6bw0Ml/5QPEAE8gQgbWx5EasjbQSf7DKIREO9y7CkddqRCdncK
         HxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4eWkAtXPKjUx8eSu0DoN0DWy+n6qfJjTgsRsQt2pWwI=;
        b=umpQ/Xl/k1ZQsrNoyQNdTyyGDOxE4Zf+CnBkvrJKYnfXQKt29Nj33N/fJR91uKFX0w
         6sH+HTLzyahLKw0eHbgmebRGMp2eXebyKW1ANnASHmodub+Gd6lPULiMHG1NXctkMLiv
         oVpr11kc7oCKAR0utfQldTL5SS8GEBmBrTdHBQXVUsjRn5mDvVd7AwYTUgiYjupIHyUW
         v4Di3DFnwrM2AlkwATBe48gLzXuQVxJTUMAwW1FfrL2Vwom/l3nasKdo4w4Y107NmOZE
         cRM462TecGR0w+cNmPou7SHeZKsa9B0Dl8cZ05eOE5N4r19FRKOGSKPF87iIeZi32aa6
         SjIg==
X-Gm-Message-State: AOAM5336Y/+jYgXPvdCkSVUCSmwl6tQj9zdKfqYn3OH7YSGiO1a5mkOu
        1LQ9n4B8/qzcUa4O3qOCeS/QBgVjLwYlM1iG94k=
X-Google-Smtp-Source: ABdhPJyFmWoGMs/fdPjycryXrJITJGj+y+ZlX9+k1TgrW9dTzOFeFdUwFQHbcfOmyDvzpkcnOEXi50+wa6og/frFwgY=
X-Received: by 2002:a5e:9901:: with SMTP id t1mr308948ioj.5.1628055606081;
 Tue, 03 Aug 2021 22:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210802214645.2633028-1-krisman@collabora.com>
 <20210802214645.2633028-4-krisman@collabora.com> <CAOQ4uxjMfJM4FM4tWJWgjbK4a2K1hNJdEBRvwQTh9+5su2N0Tw@mail.gmail.com>
 <87fsvphksu.fsf@collabora.com>
In-Reply-To: <87fsvphksu.fsf@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 4 Aug 2021 08:39:55 +0300
Message-ID: <CAOQ4uxj_WwDPxZv0nr9+Hh+pim6+2onaBdFq_BR-qK=xz+8yUg@mail.gmail.com>
Subject: Re: [PATCH 3/7] syscalls/fanotify20: Validate incoming FID in FAN_FS_ERROR
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     LTP List <ltp@lists.linux.it>, Jan Kara <jack@suse.com>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>, kernel@collabora.com,
        Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 4, 2021 at 7:54 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Tue, Aug 3, 2021 at 12:47 AM Gabriel Krisman Bertazi
> > <krisman@collabora.com> wrote:
> >>
> >> Verify the FID provided in the event.  If the testcase has a null inode,
> >> this is assumed to be a superblock error (i.e. null FH).
> >>
> >> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> >> ---
> >>  .../kernel/syscalls/fanotify/fanotify20.c     | 51 +++++++++++++++++++
> >>  1 file changed, 51 insertions(+)
> >>
> >> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> >> index fd5cfb8744f1..d8d788ae685f 100644
> >> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> >> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> >> @@ -40,6 +40,14 @@
> >>
> >>  #define FAN_EVENT_INFO_TYPE_ERROR      4
> >>
> >> +#ifndef FILEID_INVALID
> >> +#define        FILEID_INVALID          0xff
> >> +#endif
> >> +
> >> +#ifndef FILEID_INO32_GEN
> >> +#define FILEID_INO32_GEN       1
> >> +#endif
> >> +
> >>  struct fanotify_event_info_error {
> >>         struct fanotify_event_info_header hdr;
> >>         __s32 error;
> >> @@ -57,6 +65,9 @@ static const struct test_case {
> >>         char *name;
> >>         int error;
> >>         unsigned int error_count;
> >> +
> >> +       /* inode can be null for superblock errors */
> >> +       unsigned int *inode;
> >
> > Any reason not to use fanotify_fid_t * like fanotify16.c?
>
> No reason other than I didn't notice they existed. Sorry. I will get
> this fixed.

No problem. That's what review is for ;-)

BTW, unless anyone is specifically interested I don't think there
is a reason to re post the test patches before the submission request.
Certainly not for the small fixes that I requested.

I do request that you post a link to a branch with the fixed test
so that we can experiment with the kernel patches.

I've also CC'ed Matthew who may want to help with review of the test
and man page that you posted in the cover letter [1].

Thanks,
Amir.

[1] https://lore.kernel.org/linux-ext4/20210802214645.2633028-1-krisman@collabora.com/T/#m9cf637c6aca94e28390f61deac5a53afbc9e88ae
