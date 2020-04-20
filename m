Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744EE1B1016
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Apr 2020 17:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgDTP3p (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Apr 2020 11:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgDTP3p (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Apr 2020 11:29:45 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00695C061A0C
        for <linux-ext4@vger.kernel.org>; Mon, 20 Apr 2020 08:29:43 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id a2so4471680oia.11
        for <linux-ext4@vger.kernel.org>; Mon, 20 Apr 2020 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zPPXb24P1AsNF2EzClAYbclgmVA23VofI5lKiseqe7g=;
        b=ah1shf4HSg/nvJ8s11qa+8NLytbbP2+0zc73p3ql5uknLz2DKkaIN1AMLSCXwCoQOB
         IUUNGwz+DoPmYxblBA9qILxBrLosv/D5rtRuJKby1Q4gjKAmckfomvUUsaxvzuo6jCH7
         aqihy/dQmta8H50f6yKPqN3XUmS/+txHciVu9yA68j+iORY3e1prjo7HcQUuAGQuPNiY
         PGTV2YlVJsylE2iPM1M8tfX9pefTk9qQqdQ487KHyPq8P4aNDCrnsRG15PRdri0HFVwW
         ZE0FWBNlj7vf1iMsuc68NqPtwGh0j3Lhp1LaYo9d+oCYclxukpkYlCbsI9dAVjkynYI2
         77SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPPXb24P1AsNF2EzClAYbclgmVA23VofI5lKiseqe7g=;
        b=cHWHlmGnjZp/P4xL1cK+wPe8ktjgrtanHmQeIjCYNC1SIjc99+/Gl+9uPbuOxD328t
         NQ7QwHJz71GW5w8lSHwWPI6RSNcmXcwuRv6UpIpXjExMbW1eQsl/usgoZ/DKOeQEanAe
         GkBYV+e6DNbrC/yPk2oXQPcVRItieFh1RnSPxbxQ3wj34/s3bHMvfDe60dkX2e1voZH/
         GoeDE4cigC3qKvAeaUPgwxFr6mK36lzQSFewJvEXp3B6X6gwXN1sKR4KQi8RePNns1GF
         llL1Pt3spjAGuzmg+xxeJNSzOar/gvVGwoDMNcg2h8yixsMI8vzV87F+aHjoVgNNMPiT
         TjRA==
X-Gm-Message-State: AGi0PuZ73/vuRy/2hxqe9FT6rtj5mpHIlnrtaJTNkyN6zDjqglSbXqWF
        1JLgVa56Q38Zi2qkJJlB5SNyzeHEb5ni07Vz/+gMow==
X-Google-Smtp-Source: APiQypJiq2K2V4ldr/J8WQcI/YqsUZiz1LKQorCqjmJgGRBjKTVuRpqVwN+xWRf8OGxvvJhbxblTyskx5LHJFx1jgWY=
X-Received: by 2002:aca:3a8a:: with SMTP id h132mr10490068oia.146.1587396583373;
 Mon, 20 Apr 2020 08:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200331133536.3328-1-linus.walleij@linaro.org>
 <20200420151344.GC1080594@mit.edu> <d3fb73a3-ecf6-6371-783f-24a94eb66c59@redhat.com>
In-Reply-To: <d3fb73a3-ecf6-6371-783f-24a94eb66c59@redhat.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Mon, 20 Apr 2020 16:29:32 +0100
Message-ID: <CAFEAcA9BQQah2vVfnwO4-3m4eHv9QtfvjvDpTdw+SmqicsDOMA@mail.gmail.com>
Subject: Re: [PATCH] fcntl: Add 32bit filesystem mode
To:     Eric Blake <eblake@redhat.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Andy Lutomirski <luto@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 20 Apr 2020 at 16:24, Eric Blake <eblake@redhat.com> wrote:
> It will be interesting to find how much code (wrongly) assumes it can
> use a blind assignment of fcntl(fd, F_SETFD, 1) and thereby accidentally
> wipes out other existing flags, when it should have instead been doing a
> read-modify-write to protect flags other than FD_CLOEXEC.

For instance, a quick grep shows 4 instances of this in QEMU :-)

thanks
-- PMM
