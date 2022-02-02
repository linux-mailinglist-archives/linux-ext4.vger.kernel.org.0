Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3304A72B7
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Feb 2022 15:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243823AbiBBOKp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Feb 2022 09:10:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27954 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231950AbiBBOKo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Feb 2022 09:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643811044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=782/lRE3fUhNkZwGYyd0WzZ82QBZ3rM9P2vMEJcLYOI=;
        b=S90PfLdZKl3r2eTk5xkR89gS3V7SBHnmGt/M8/+LssE8EbOM0sKd4DUAWCa+OA19wDTKcu
        wrTrWOJv+FzVOPmcaYft40JkNillc8IJwp6z9PbAvaxSMAuJrxSXo72EEksluysqCxMw7A
        NzFI/I/SURpQaOqJmv0RxqEVYreHrSc=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-m7-t5ZiyMZ6s_9ijR1vArg-1; Wed, 02 Feb 2022 09:10:43 -0500
X-MC-Unique: m7-t5ZiyMZ6s_9ijR1vArg-1
Received: by mail-oo1-f70.google.com with SMTP id e14-20020a056820060e00b002edda9f237bso8055907oow.22
        for <linux-ext4@vger.kernel.org>; Wed, 02 Feb 2022 06:10:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=782/lRE3fUhNkZwGYyd0WzZ82QBZ3rM9P2vMEJcLYOI=;
        b=zDf/JT/VESpeU79Slr723MDuBLD+O8oLTYUof2xcPL4dZ2xk80vg4wNbUsslF38Sx1
         HhXaWQms9nWeGJk4o80k9ESWlBXoqocnEogfV0DSjb1tBCVX0EUUWDyrjxr1mfmRZ0k/
         N/2kQrEnX7XCQw6iQtFt6oTH6vcAT+wneQNFYGy/4Ng/ldDL2TNgaeN8fJQIy54eIXxc
         yWn4HAq62NMCIdY0yV6tl/DY+ijAnAXDBfKA2zlHuVNgEm+65CAOQOvPRG7ZZ7FI8MiP
         0KFCMDw9EvkflM2dNznlqKLOPAGRGow0FfDcS4XZ/KJVzYWZ0/cwi2OFk4MUxtIu4aMH
         OBdQ==
X-Gm-Message-State: AOAM532iZRekgIFLSmm90qYXwsuqG7dB5RdCIiAu7vbz0x4qnVSO327K
        0ppUVCyOdxWD+05qz66hnAHqkZspJeGJjUtsuH3tFm0u/2fnR1UdXJFkaz9VXa8hmFwRtkBOoUw
        BBj6Hbme9ga6f1LR+dgABuZHah2GES5WBKGlHPQ==
X-Received: by 2002:a05:6808:15aa:: with SMTP id t42mr4301014oiw.227.1643811042552;
        Wed, 02 Feb 2022 06:10:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEJOKTTNDUjrzOHmYM4ezH7OH6gCg5O1InQqQahXj1oYmpelFygsQivjrRRjlHDRik7ihAfQPCXBRBZvgaRj0=
X-Received: by 2002:a05:6808:15aa:: with SMTP id t42mr4301006oiw.227.1643811042396;
 Wed, 02 Feb 2022 06:10:42 -0800 (PST)
MIME-Version: 1.0
References: <20211118235744.802584-1-krisman@collabora.com>
 <YdxN6HBJF+ATgZxP@pevik> <CAOQ4uxia2NNMPUCQzjo6Gsnz8xr_9YKTeTqzOu-hgdsjfHHx0w@mail.gmail.com>
In-Reply-To: <CAOQ4uxia2NNMPUCQzjo6Gsnz8xr_9YKTeTqzOu-hgdsjfHHx0w@mail.gmail.com>
From:   Jan Stancek <jstancek@redhat.com>
Date:   Wed, 2 Feb 2022 15:10:26 +0100
Message-ID: <CAASaF6xQG691q9JxiEF5HgqCNfGd1FHhwEX5TG_WpW3rHpBFKQ@mail.gmail.com>
Subject: Re: [LTP] [PATCH v4 0/9] Test the new fanotify FAN_FS_ERROR event
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Petr Vorel <pvorel@suse.cz>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        Jan Kara <jack@suse.com>, Ext4 <linux-ext4@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 2, 2022 at 2:49 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Jan 10, 2022 at 5:16 PM Petr Vorel <pvorel@suse.cz> wrote:
> >
> > Hi all,
> >
> > v5.16 released => patchset merged.
> > Thanks!
> >
>
> Guys,
>
> Looks like we have a regression.

agreed, "abort" option stopped working:
https://gitlab.com/cki-project/kernel-tests/-/issues/945

Lukas pointed out this patch that didn't make it in yet:
https://lkml.org/lkml/2021/12/21/384
This should be new version:
https://lore.kernel.org/linux-ext4/YcSYvk5DdGjjB9q%2F@mit.edu/T/#t

> With kernel v5.17-rc1, test fanotify22 blocks on the first test case,
> because the expected ECORRUPTED event on remount,abort is never received.
> The multiple error test cases also fail for the same reason.
>
> Gabriel,
>
> Are you aware of any ext4 change that could explain this regression?
>
> In any case, Petr, I suggest adding a short timeout to the test
> instead of the default 5min.
> Test takes less than 1 second on my VM on v5.16, so...
>
> Thanks,
> Amir.
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>

