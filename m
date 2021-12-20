Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37C747A8F6
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Dec 2021 12:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhLTLtI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Dec 2021 06:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhLTLtH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Dec 2021 06:49:07 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5CDC061574
        for <linux-ext4@vger.kernel.org>; Mon, 20 Dec 2021 03:49:07 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id e128so12896852iof.1
        for <linux-ext4@vger.kernel.org>; Mon, 20 Dec 2021 03:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ol2NZaQ06boKcIwHQi4WmQVOiEUH/6bxWgiZDz0xGKA=;
        b=m6dRPO0fFnMOUk9MhocTz0+04kmj8yfccgmEXkcvJFd67GJ4nlbx31rM9z5uXOHPNV
         n0BV1xDYtywamhC3f3kFvLdTRrDFPgNBgakm6UPVrV+pYPzy+vLKodzlxZhdwaEWCNhK
         n/uS78u6dZdHYx6Y7+0cRNwOGO8mxzv4ksTcE2UKFX/V9G/rQHdJoEvvsDWNMdgMv8Sm
         RPw+oSfdpQIAU8UtxMikZEk/RqjivcqoNELiISswfwlJSqUqGszI0wtOW+3g2S6LGY98
         hY9ZK0CKIK83fKiPEaYXx6PplBh/t1c5VnDXdl+eGEUZyMXPlQiYhuwudVSt0PJC5m39
         dbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ol2NZaQ06boKcIwHQi4WmQVOiEUH/6bxWgiZDz0xGKA=;
        b=5zHrUCmbHOiCJ6SZtQXyPHxrzLCRNWVlqG19TrokfC4S2E3A9ZXvCwuo77VVObegL+
         XbE52b9i17Ey4L+XLK07jCTvrTm0ru0LyGGezOuB8jRxC8cYlJxw8NMaYtFYIroQNli6
         MtmtJpSXFnZaQrMS0ZX28Pvo1J9iorRUxG1RBh0yELoxUebmkDvbk8ABVE7RtyPQKeel
         8vLmtxb3NqnMQcuE1qJDhjpVhuogLuyCce+rwtRcgXQf+iS2LsyETTwaftp0vh17Mrds
         SsvaFobckQi/B9i9k611Cm3zmkCipb6ejf2aT9wzrGtCJ1OCKe8NIg77B8EFmFMlVV4H
         gVRA==
X-Gm-Message-State: AOAM530H1vgq+tqgCahqt3H0IKlThDb0vEoooZAU+RfEVrVcSqpSyv7C
        RA7RadEH2KJilGY285Cp5PXd7KIpP+EItNj72YY=
X-Google-Smtp-Source: ABdhPJzXuWfW2X4Q3eFornjCyRY6vAcO+HcNjJ39EbsuaBOMZwnVbZsC1jG08VEl2PJSpGaSQa1TUnXtA618AP9Q6w8=
X-Received: by 2002:a05:6638:358b:: with SMTP id v11mr9008705jal.53.1640000947005;
 Mon, 20 Dec 2021 03:49:07 -0800 (PST)
MIME-Version: 1.0
References: <20211118235744.802584-1-krisman@collabora.com>
 <CAOQ4uxhbDgdZZ0qphWg1vnW4ZoAkUxcQp631yZO8W49AE18W9g@mail.gmail.com>
 <8735nsuepi.fsf@collabora.com> <YZtLDXW01Cz0BfPU@pevik> <YZ4Wf3d+J36NPMfS@pevik>
In-Reply-To: <YZ4Wf3d+J36NPMfS@pevik>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 20 Dec 2021 13:48:56 +0200
Message-ID: <CAOQ4uxgg6BvUtcaD4stDv7meS0it-0-iDWNiz_-=SRN_tvgzYQ@mail.gmail.com>
Subject: Re: [LTP] [PATCH v4 0/9] Test the new fanotify FAN_FS_ERROR event
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        Jan Kara <jack@suse.com>, Ext4 <linux-ext4@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 24, 2021 at 12:40 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi all,
>
> <snip>
> > > Hi Amir,
>
> > > I have pushed v4 to :
>
> > > https://gitlab.collabora.com/krisman/ltp.git -b fan-fs-error_v4
>
> > FYI I've rebased it on my fix 3b2ea2e00 ("configure.ac: Add struct
> > fanotify_event_info_pidfd check")
>
> > https://github.com/linux-test-project/ltp.git -b gertazi/fanotify21.v4.fixes
>
> FYI I removed branch from official LTP repository and put it to my fork
> https://github.com/pevik/ltp.git -b fan-fs-error_v4.fixes
>

Hi Petr,

Are you waiting with this merge for after release of v5.16?
or is it just waiting behind other work?

Just asking out of curiosity.
I've based my tests for fan_rename (queued for v5.17) on top of your branch.

Thanks,
Amir.
