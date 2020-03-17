Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04553188463
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Mar 2020 13:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgCQMiY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Mar 2020 08:38:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40999 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgCQMiY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Mar 2020 08:38:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id u26so4775187lfu.8
        for <linux-ext4@vger.kernel.org>; Tue, 17 Mar 2020 05:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RxvspXpJnT1wLGWC1yqAwht7wPofjiDL2MZ2V4GJU0s=;
        b=hnj4sEry8e72e+4XxcViMh2kR/clVi9rs+0bXE1Bk+1jnM9tAaTyTvgL4uYk9HGokQ
         CS6JmX/z0c6hGZP4+/nsjdwrRToHL2MnmrEP2s5tbTN6meK7gab1DE86o95g8btZIabJ
         X0Nb39RB/DJ0JWjBmqOkl9uU6GNs9+S6/0dZvKl3+nAxc/hPOac2EFucKTzFdRe8iZbM
         pd2Cz/K1I/XtSdYirkd2zkc5FVQnbLpfFYWuWeR4JcwrggK69xvkfXK7qVwpyd+zrveT
         XkUuyowMJlxJdZtfXDBqIGaPNwQ4N/hPoHdbjT/raGV9/FQs/kLHLi9N8GnTZjdSG/jt
         rWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxvspXpJnT1wLGWC1yqAwht7wPofjiDL2MZ2V4GJU0s=;
        b=MvMQrjIJD/6XoutSv/FDDH1mTHw+zEDneVrc8CYZO/JcXN+2Xd/96eDKp4QsWZ4JmD
         hFSnwCj42qSvUhO/whP2h4k9ga5RfJnP865OSm3Bf6pywH27/rOow6nU2AP6F/AKAoUm
         OX+MndxqJX3r1VNxX8B2/iT4Jw5o6KYgiDHld+FR5+PvSAAINyK6bsTpx17Pz/lheGsn
         z54k4ddR4oJaSNlCoe4vvV5tIJy3A53MEr6mlqIY1kXBtAHW295u7YksRJUqun8HhdVC
         i6VYlHci5nB5A6O6QsOmF/YTp7W+YJHU5hcaM+lWawtnxm4wCs1oR5bw8EY9qX1hIpN0
         g6pw==
X-Gm-Message-State: ANhLgQ033pVvRFDEAbkCoFqoV4hB1bijJRxBbXmhd82PmnHhJ6BCJUMo
        KJTrNHlJ5IGZC0AstciFlrsNodFeSPR6KvfNa/ry5w==
X-Google-Smtp-Source: ADFU+vtpPO/SB7g4ehk7qTFyPKse2g7Gmfi77CZPwCuVUbJVQI6d70Lf5FyUoeDifSP8iaSTW1v77WW+rDocRRRH0SY=
X-Received: by 2002:a19:6502:: with SMTP id z2mr2694078lfb.47.1584448702419;
 Tue, 17 Mar 2020 05:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200317113153.7945-1-linus.walleij@linaro.org> <87lfnzdwrf.fsf@mid.deneb.enyo.de>
In-Reply-To: <87lfnzdwrf.fsf@mid.deneb.enyo.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Mar 2020 13:38:11 +0100
Message-ID: <CACRpkdY8uLVrT5=NMpNmKhgmqu=yT_Bgc-Q9-BR6NgRFjnzjFQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: Give 32bit personalities 32bit hashes
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, QEMU Developers <qemu-devel@nongnu.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Mar 17, 2020 at 12:53 PM Florian Weimer <fw@deneb.enyo.de> wrote:

> Just be sure: Is it possible to move the PER_LINUX32 setting into QEMU?
> (I see why not.)

I set it in the program explicitly, but what actually happens when
I run it is that the binfmt handler invokes qemu-user so certainly
that program can set the flag, any process can.

Yours,
Linus Walleij
