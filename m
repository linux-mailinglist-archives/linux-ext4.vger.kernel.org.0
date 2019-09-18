Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCC2BB6D5D
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2019 22:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391197AbfIRUNt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Sep 2019 16:13:49 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44276 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391137AbfIRUNt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Sep 2019 16:13:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id m13so1175490ljj.11
        for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2019 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zmbXGFEWVtjHX9X1Gctkgau+tuI+qC0BzTbw+aLuRTU=;
        b=g8RyMjdNFqBzYdgO0kOInb/luNvfmUgoogrNuN/uHaQmSTAkISDVuPXAX+IS8y6uPa
         113T2PmQ3xMCkzcuMhaKO1jOI6snQm5pleau2vnztg3o4ImV+DP3gV+uEBDCi+BFOxCm
         kSQ4VNgu1hZOijED+yZ0+HFQwvWFxFemQxZvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zmbXGFEWVtjHX9X1Gctkgau+tuI+qC0BzTbw+aLuRTU=;
        b=Qb0h/SBao/WfT9vmOHEMQCSE0ZsT1Nfvn2dTnCdpj8ZSC1OERUQVtmP/F7AFHvZ93S
         P6YTet+0Vdx+JLZZXlQJMDsfwyK96EK7rsRz7SvRV0kCFxldP2Q0vFGCMkVb8C1khNmu
         NFU47ucB3eZ5toyZn9cF/+vTiA4ybOLOVg5JLv41jhm9lovTJcvbmBeflIqTDKeIjYal
         btkWB2SoOEQLS+4y3KGAS6g+3KBJKm+mf4YSRWEDHZv77BGEjz66xRlt33bVLJ8EpscR
         TStWVAkLd6lWI6WgCLGPKzLNdA6yoyiNg83lYu1de5gPo+HItCNdYtkbfDKYE08IgXyK
         tjUw==
X-Gm-Message-State: APjAAAWjvujvciYtwysPvIlmBLNT418I3mgFNgE+FnvWQAiF6qHkTHSO
        lrhXTLrrFLPa4hdaGMAc6V1pogSiDdk=
X-Google-Smtp-Source: APXvYqxnbipIl8E+TcH0exxQm9q6E+mpyxN+k+PpjC4YdMdyrB2t/QfvV0qPdeft1saxr9SVP691lg==
X-Received: by 2002:a2e:884c:: with SMTP id z12mr3198130ljj.92.1568837627554;
        Wed, 18 Sep 2019 13:13:47 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id g10sm1161280lfb.76.2019.09.18.13.13.46
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 13:13:47 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id r2so593693lfn.8
        for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2019 13:13:46 -0700 (PDT)
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr3074674lfp.61.1568837626504;
 Wed, 18 Sep 2019 13:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org> <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba> <20190917121156.GC6762@mit.edu>
 <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
 <20190917160844.GC31567@gardel-login> <CAHk-=wgsWTCZ=LPHi7BXzFCoWbyp3Ey-zZbaKzWixO91Ryr9=A@mail.gmail.com>
 <20190917174219.GD31798@gardel-login> <87zhj15qgf.fsf@x220.int.ebiederm.org>
In-Reply-To: <87zhj15qgf.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Sep 2019 13:13:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMipoCnraaP3FwnGhb+D-AtHgsLbRa5ZPa9ZK715aVng@mail.gmail.com>
Message-ID: <CAHk-=wgMipoCnraaP3FwnGhb+D-AtHgsLbRa5ZPa9ZK715aVng@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 18, 2019 at 12:56 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> The cheap solution appears to be copying a random seed from a previous
> boot, and I think that will take care of many many cases, and has
> already been implemented.  Which reduces this to a system first
> boot issue.

Not really.

Part of the problem is that many people don't _trust_ that "previous
boot entropy".

The lack of trust is sometimes fundamental mistrust ("Who knows where
it came from"), which also tends to cover things like not trusting
rdrand or not trusting the boot loader claimed randomness data.

But the lack of trust has been realistic - if you generated your disk
image by cloning a pre-existing one, you may well have two (or more -
up to any infinite number) of subsequent boots that use the same
"random" data for initialization.

And doing that "boot a pre-existing image" is not as unusual as you'd
think. Some people do it to make bootup faster - there have been
people who work on pre-populating bootup all the way to user mode by
basically making boot be a "resume from disk" kind of event.

So a large part of the problem is that we don't actually trust things
that _should_ be trust-worthy, because we've seen (over and over
again) people mis-using it. So then we do mix in the data into the
randomness pool (because there's no downside to _that_), but we don't
treat it as entropy (because while it _probably_ is, we don't actually
trust it sufficiently).

A _lot_ of the problems with randomness come from these trust issues.
Our entropy counting is very very conservative indeed.

            Linus
