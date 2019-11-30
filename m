Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A32810DECB
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Nov 2019 20:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfK3TKW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 30 Nov 2019 14:10:22 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33668 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbfK3TKV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 30 Nov 2019 14:10:21 -0500
Received: by mail-lf1-f68.google.com with SMTP id d6so24962914lfc.0
        for <linux-ext4@vger.kernel.org>; Sat, 30 Nov 2019 11:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2QRHezkunwRrIMa14MxefFzwV3YRpouLMEO2wmjXPok=;
        b=X015xVKVQrz9jE331+LcTdxT7VNHCtQzr/vjU3xYa4QlcG1JXeywX3xGEh0GNCNpi1
         a9d2l9Wl+c3I+5dmpta0uvHpfuARxl96ZLsictnm6+giQbVx3OoDdMmNlHQ5psP1cENw
         JiaESZKNPd622sJQjh2IClD6t70XnifDVj9H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QRHezkunwRrIMa14MxefFzwV3YRpouLMEO2wmjXPok=;
        b=qqrHtxMQ3uqXYMNeY/h+Ji2UJ4KpH8Lkdw5zcfeBr7SfjJ9ph6J1Lxs5POTU/Y15Tt
         VpL6z4HJ/kqgiFrXGzRo4w4ax8duWqdaMA4aSsZepuDu03ctHiBhUY2EbAlIeaXKUbul
         Zjq3lanQX0N6Rw+mk+kGDDq1YSohn4BgobeCpwNa8UByN/ibjbWpZtYIO4umvhcQ7I2T
         kuYSrRPmta6Q+32lgaUY9c1RV5NQrPNhGdY658/btY46V6tE50jCRg8enjJhrzdYxd4K
         VCBg5Nfrlzk5nn/UNIRWMjgoJfBV4/33Pfj3/385h9V61EjUXFqoKy7IvayvJix9n8nc
         BHGA==
X-Gm-Message-State: APjAAAVDuuvbIBP5L0wEbvMSDdevusHrPrB8UmyVYu2U4zd3UKLVAegz
        IO5iJ1coK3DQIuZMVv1XG87+gCiOfXE=
X-Google-Smtp-Source: APXvYqxNd+hzQpxHyVlA9CkjnIcR5wjU6BVzYmiWdJc49Mv35ck4erfVqvHyrDiI4aAjpTRz3OV7uw==
X-Received: by 2002:ac2:420e:: with SMTP id y14mr9592604lfh.145.1575141017244;
        Sat, 30 Nov 2019 11:10:17 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id f24sm4537681ljm.12.2019.11.30.11.10.15
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2019 11:10:16 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id s22so16329140ljs.7
        for <linux-ext4@vger.kernel.org>; Sat, 30 Nov 2019 11:10:15 -0800 (PST)
X-Received: by 2002:a2e:2c19:: with SMTP id s25mr2479024ljs.26.1575141015377;
 Sat, 30 Nov 2019 11:10:15 -0800 (PST)
MIME-Version: 1.0
References: <20191126125304.GA20746@mit.edu>
In-Reply-To: <20191126125304.GA20746@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Nov 2019 11:09:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=whqR7T_UuKX0JvOFK48RdiViOTPkNxxfjwh70FxjoxE0Q@mail.gmail.com>
Message-ID: <CAHk-=whqR7T_UuKX0JvOFK48RdiViOTPkNxxfjwh70FxjoxE0Q@mail.gmail.com>
Subject: Re: [GIT PULL] ext4 updates for 5.5
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 26, 2019 at 4:53 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
>  * Direct I/O via iomap (required the iomap-for-next branch from Darrick
>    as a prereq).

I appreciate you telling me this, but why didn't you say anything at
all in the merge?

Ted, this merge commit message is simply not acceptable:

    Merge branch 'iomap-for-next' into mb/dio

That's literally all you wrote about the iomap merge.

Not ok.

Merges are commits too. And merges need commit messages too. They need
an explanation of what they do - and why - the same way a normal
commit does.

You wouldn't make a one-liner "Do this" message for a regular commit
that has big implications. Why do you think it's ok for a merge
commit?

When you merge something, the individual commits that get pulled in
hopefully have their own explanations for each individual change -
otherwise you definitely shouldn't merge them. So the merge doesn't
need to replicate all of that.

But the merge itself still needs a "why am I merging these commits" explanation.

We pride ourselves on good commit messages. But that merge commit
message is pure and utter garbage.

               Linus
