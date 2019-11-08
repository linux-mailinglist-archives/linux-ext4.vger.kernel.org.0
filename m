Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE3AF4192
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Nov 2019 08:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfKHH70 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Nov 2019 02:59:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46580 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfKHH70 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Nov 2019 02:59:26 -0500
Received: by mail-wr1-f67.google.com with SMTP id b3so5848976wrs.13
        for <linux-ext4@vger.kernel.org>; Thu, 07 Nov 2019 23:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ibqkaNi4qlOCKc6mABs9f3EwZYD9cZNAvYWLlDpvTZQ=;
        b=mNmb2zeLm4lNNfV9sriAGWYBRo4EMvwsDx4swArOe3svqTwKht3ijykY/oTSMltyqY
         DjTKCuG/EzAl7Y+yQ9rNH3QcMlkACOvqxZZNjCMngBDduBplkSSP4S4zrT7jGufkESUb
         kzEnNTffVeZgIQu6uH1ddfYx0/opBYr+xmKeFDqKEAZENTviFpDiVyn1ur/Q/lEyOf9B
         324j8bn3rMYRduAOJRf/SurLQE6SUxdAB6jA842GJDdM6WytfrCEKEbwHENMc+I013/B
         JyqUCbyFBbPnz3GxwmwbVp5OY5ytynzFfEo3Vt+NK7HdtTV+OMtRQPtc4IfY2TPOoELa
         hgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ibqkaNi4qlOCKc6mABs9f3EwZYD9cZNAvYWLlDpvTZQ=;
        b=guW3f2YJNZXj6a3tCUIvsnFH1PFM9vkdBAQ56OGH3oN/jxnfPnasoiF5jr+7M2Pw0i
         jFM7VZ+j2tozq7lr8UlTM6v3HXNbXfpK61FWfsO5Gl6NVVJOiJ4DNK2WiKB/PzvU7Uq9
         jW518uXcQbkziasCkQbvrhUy9ZxrPNJFn0HVBiTv1ib6aGYZJl+wcbIxyCYSKoRaoX0t
         dzNrivoT0GZ5O/wk3/NvHyhIHVKkyXlFcN0A2TMp6aLmolARY38MHugAImVKhW/7L0gh
         3b9dg8yN6RGGcqN5NaA3HCXFI/oLdMQseF0wWV1eVjGlgEY6aOdoJrEEqvBwa9Q0qrn2
         7A+Q==
X-Gm-Message-State: APjAAAVZGN2r0hFmbSGPuJXQa4if72NCZ1izw69pTgQapK8BGyTdEXyy
        +NF1Bg1qVlbz9Tb3HHYyQTmIHbSFeJcrfxfZ6h1X2A==
X-Google-Smtp-Source: APXvYqzfO7d0AdGP29VtMdrGIzWCKh36XStCEHFx2E2fAh91wz/pkVmyvFaop5jCmR81aVhymG/EpE51Q1wv1Qq+0mA=
X-Received: by 2002:a05:6000:110a:: with SMTP id z10mr6679340wrw.291.1573199964213;
 Thu, 07 Nov 2019 23:59:24 -0800 (PST)
MIME-Version: 1.0
References: <1571900042725.99617@xiaomi.com> <20191024201800.GE1124@mit.edu>
 <1572349386604.43878@xiaomi.com> <20191029213553.GD4404@mit.edu>
 <1572409673853.43507@xiaomi.com> <20191030142628.GA16197@mit.edu>
 <CAAJeciVYOAWzsjAtL7SNmpFQH60z0MB53OPE3hZ==_oBB0N3dQ@mail.gmail.com> <20191104032212.GA12046@mit.edu>
In-Reply-To: <20191104032212.GA12046@mit.edu>
From:   xiaohui li <lixiaohui1@xiaomi.corp-partner.google.com>
Date:   Fri, 8 Nov 2019 15:58:14 +0800
Message-ID: <CAAJeciVMnFTdmapS-xTPz4uc864yrq=aS3AzjbDofaC-GX4gFw@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW0V4dGVybmFsIE1haWxdUmU6IFtQQVRDSCB2MyAwOS8xM10gZXh0NA==?=
        =?UTF-8?B?OiBmYXN0LWNvbW1pdCBjb21taXQgcGF0aCBjaGFuZ2Vz?=
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     =?UTF-8?B?WGlhb2h1aTEgTGkg5p2O5pmT6L6J?= <lixiaohui1@xiaomi.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "harshadshirwadkar@gmail.com" <harshadshirwadkar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

thank you, ted.

I have understood  the whole design and implementation of the ijournal paper.
and i think the fast commit for ext4 may be designed and implemented
according to idea of that ijournal paper,
as that ijournal thought is the best way for resolve the problem of
file's data has to been waited in jbd2 thread with
order mode from my opinion.

according to that paper, ijournal only record and commit the changes
of the fsync'ed file to its own ijournal area,
the changes of whole ext4 filesystem are left to normal journal to process.
and ijournal only happen at the end of the thread which is doing fsync
work. it need not be embedded to jbd2 thread.
and the changes of the fsync'ed file which have been committed by
ijournal will also be committed to normal journal area subsequently.
ijournal won't have side effect on normal journal , these two journal
runs independently.

all of these above designments of ijournal from my viewpoint will
simply the fast commit function developed recently, meanwhile it can
help fast commit function to
achieve its goals.
one of its most important goals which i have to highlight should be
fix ext4 fsync time cost problems because of file's data has to been
waited in jbd2 thread(same as CTX problems pointed in ijournal paper).
what do you think of it ?

I like this ijournal thought. may be i want to do some work on coding
of this fast commit function in my free time.



On Mon, Nov 4, 2019 at 11:22 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Nov 04, 2019 at 09:01:28AM +0800, xiaohui li wrote:
> >
> > when in writeback mode, inode' data has not to be waited in jbd2
> > thread, so the fsync time cost is also reduced.
> > meawhile, writeback mode also can guarantee filesystem consistency in
> > os crash-reboot conditions,
> > with only one drawback is that it will cause security problems such as
> > stale data will be seen.
>
> It's not just stale data; in data=writeback, today if a file gets
> deleted, its blocks are immediately eligible to be reused.  If there
> is a crash before the transaction is committed, there could be a file
> that would have deleted (and perhaps replaced) that doesn't in fact
> get deleted, but its data blocks will have been corrupted.
>
> I'm not fond of that particular behavior, and I may look to fix it,
> but in general, data=writeback means that data blocks may be corrupted
> or contain stale data after a crash --- for blocks that were freshly
> created, or for a file that might have been deleted, but except for
> the crash which means that the file deletion doesn't actually get
> corrupted.
>
> > but in android system with file encryption enabled, there is no
> > security problem as files are all encryped.
> > but user will see wrong file data in system crash-reboot conditions
> > with writeback mode enabled.
>
> If all files are encrypted, then yes, the chances of stale data
> causing security issues is significantly reduced.
>
> But see also the case of a file which is deleted immediately before a
> crash.  Things are more complex in terms of the data gauarantees after
> a crash, which is why data=ordered is the default.
>
> Regards,
>
>                                         - Ted
