Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A880037ACC3
	for <lists+linux-ext4@lfdr.de>; Tue, 11 May 2021 19:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhEKRMU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 May 2021 13:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhEKRMU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 11 May 2021 13:12:20 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9959C06174A
        for <linux-ext4@vger.kernel.org>; Tue, 11 May 2021 10:11:13 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id j19so1393295edr.12
        for <linux-ext4@vger.kernel.org>; Tue, 11 May 2021 10:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TDVi9Lxfdf5IolTrR343g2leXORK8obA6xiOUAe7Gyc=;
        b=RNQYnSI1fqF+/837zwogddcVoSd6pHZY6WI1Gfi0vLR6ebZYkbE10aIOFyLXWpyPnb
         giNC5BenEwAYmjmsLcEMjobk55Tln/FROBTpPwglvqU6Obv9i+LC0rq1BrMEmirY6pZQ
         JL+4CePpHJdZ8exevfGkQRfSYk/7c7J1dO4ZK6rccmYqvBEVvidxEMTIEwe5XdNMZSVa
         XhuFYz9RxObRt6sjY99k1gDuPhwJiU8NBfhe3FrKHTLSZnIhLlvRFpOfwsYR2bP6p6yX
         ED6Y/6nElU+N/MWbPGk9NTFHUACwRdcp7+8EY32GPwyLywuXxg4jNCaqDWBj6hYoAYge
         XT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TDVi9Lxfdf5IolTrR343g2leXORK8obA6xiOUAe7Gyc=;
        b=drJyScVIR3n0Hd7sHqpE1hTlvgyX5HxNUsifdsDkN3k/6ph0L6GoqReWSnmpbz6CHc
         l0xg0z8zlY3lE10ehG22dIqOg6DrpI1ICX2efoVaP+1APMNsmDsK+pmzAWbWzd63mFNP
         xHKZoeaWY4jGfemd1arDf1dCC+gbBoDbSReOtJc3SYtSHppWEtN8FGtHmjskwlGMT/O3
         Mj7FWqPoWfWs3dca3OHmG9snkZqY/vgRc2VPQLLjcoLId5/JH3LUfQMRKSWHsVJFEnmb
         AJObqnNotHA0UV0zEld04STYOTjmEysIfwAZfOZmSzODFbwLwXnhT2TPMp/wcTURTpb5
         rMzA==
X-Gm-Message-State: AOAM532LMZ5hO3Pjlrrl5Ti7+z5+ZSfLLTY8hXAsTwNeHDJEAaq4SDCL
        nuHHOX+eOyrlCEe0J/6avAcar6Z/X0OkVE4DLU0=
X-Google-Smtp-Source: ABdhPJxND59ep6JoHPFofJ9QJJ4BLDUrhJv6SEgVvtTxl3WKewtFE7FVqVhH+Ol2wNu5lKZ1opPcE+RwUes/GYMeasA=
X-Received: by 2002:aa7:cad4:: with SMTP id l20mr7322836edt.382.1620753072389;
 Tue, 11 May 2021 10:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210504163550.1486337-1-leah.rumancik@gmail.com>
 <20210504163550.1486337-2-leah.rumancik@gmail.com> <20210505212711.GA8532@magnolia>
 <20210505220844.GD8532@magnolia> <20210506155853.GF8532@magnolia>
 <YJQy/DfuCFyZdwe7@google.com> <CAD+ocbwK9v=ky+bBtMuVMP+zDNYnTSO2DjPZ4sE1AnYw8iEmew@mail.gmail.com>
In-Reply-To: <CAD+ocbwK9v=ky+bBtMuVMP+zDNYnTSO2DjPZ4sE1AnYw8iEmew@mail.gmail.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Tue, 11 May 2021 10:11:00 -0700
Message-ID: <CAD+ocbyn_3+ToBFiujGNvphddzRR7civ1UPtRrEpnhQKv27opg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ext4: add ioctl EXT4_IOC_CHECKPOINT
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Leah pointed out that jbd2_journal_flush() function commits the
currently running transaction. EXT4_IOC_CHECKPOINT calls
jbd2_journal_flush() so unless I'm missing something, we're actually
doing all the work that syncfs() would do from EXT4_IOC_CHECKPOINT
ioctl before sending discards. Also, the journal commit that happens
as a part of jbd2_journal_flush() is always a full commit. So, it
sounds like we don't really need to do anything more here. Thanks Leah
for pointing it out!

On Fri, May 7, 2021 at 9:22 AM harshad shirwadkar
<harshadshirwadkar@gmail.com> wrote:
>
> > > > > > +               err = jbd2_journal_flush(EXT4_SB(sb)->s_journal,
> > > >
> > > > Huh.  So we don't flush the filesystem at all, just the journal?  I
> > > > don't see anything in the documentation saying that syncfs() is a
> > > > prerequisite.
> >
> > This is just for the journal, good point, I'll update the documentation.
> It just occurred to me this morning that we need to ensure that a
> *full* commit happens before IOC_CHECKPOINT and not a *fast* commit.
> Fast commits cannot be checkpointed, they rely on full commits for
> checkpoint operation. So, if a syncfs call results in a fast commit,
> the following sequence of events will happen:
>
> * Ext4 writes fast commit information in fast commit area
>
> * When user calls EXT4_IOC_CHECKPOINT, the checkpoint operation would
> result in checkpointing everything in the main journal, except things
> written in fast commit area
>
> * During the discard phase of EXT4_IOC_CHECKPOINT, fast commit area
> will be discarded and thus we'll lose the log updates present in the
> fast commit area
>
> However, this isn't a problem today. Syncfs doesn't result in a fast
> commit but results in a full commit. But, that can change at some
> point in the future. So, unless we can either come up with syncfs()
> variant that can induce a full commit (which would be a little ugly -
> I don't think the user needs to know what kind of journal commit file
> system is doing) or add checkpointing support in fast commits, we
> should just do a full commit from the IOCTL code.
>
> - Harshad
