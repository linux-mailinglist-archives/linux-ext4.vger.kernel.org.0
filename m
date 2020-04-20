Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADD51B0E1B
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Apr 2020 16:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgDTOQ1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Apr 2020 10:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbgDTOQ0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 20 Apr 2020 10:16:26 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2E2C061A0C
        for <linux-ext4@vger.kernel.org>; Mon, 20 Apr 2020 07:16:26 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id j4so8173636otr.11
        for <linux-ext4@vger.kernel.org>; Mon, 20 Apr 2020 07:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hkugNSUCGf3cfZwlCyGaI8wXlqNC6+5VcP9fYiHhc0U=;
        b=e7niXEAbvSRqBiTADpU10S+vy4G0bJXBzYiUiFy5BWhFqfEMVtUDiCJOEnu2rpkC9S
         LyVWdkIAW/SWnQiTC00fJFmcDe24MOWwkIhMXXqS9nuJl7u/4dloA+yiSxbfKU4VSBYa
         9MSeXDwaJRtoxKAD5Vzul/GQiMlAFppl1Abk97ibf15Wlh5x6V8QLVzNq3c7wZgsvfvG
         bvFopOpQItIRPZLoSmt75oyXA4x9vH3RMILgIQcCHH53mqZYXvzjVwZlytmgSJMnntKK
         vUxcBi4plcfCLwH5OLsgPS8PDzvfYvkBL9l4D7yI+M98cCgsBNlFvz8AKqLkTE+oeoQ2
         3/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hkugNSUCGf3cfZwlCyGaI8wXlqNC6+5VcP9fYiHhc0U=;
        b=XF5kDekF4oSlCEScQqkIaL7eJ0QB/8yNJJiepKq7qGTajgfpDKydSoLkSgt1ihmNKR
         L7ii8B0PwV2oq1KmbF8L57a1Fnz+1sy0B3YJu/DhsAOYmUsF0KdD8DxK+SG/+pjK8HWK
         IRVz2OOV44DFOxztui5+QkqwD+qs1qNL0n733bdSiae/ix4P1U9vDSRyi6bVxJVLl7mj
         tiQu+lTFE5ZD2IGEqNt0SGTaETVYDsqgMDhamvf3De84WhDsZTEZcLO/gdMA1sQYUQyq
         0/0Oy/pwFbSgGuFJHYyMYjpDP5hR62T3l+nUHu7aHX4KZ55JwkDTzFBLwNsSaycVdLwq
         99lg==
X-Gm-Message-State: AGi0PuYDj6b6c4MB9vnwLJTpOVdEu/9NW3/1aaxyxU91fXS7hERnG+1V
        l3HSJ4BW6Rz5ZtGE5wdFaNOzTKXYrGZeo/jmKFqm9DY84x0Ytw==
X-Google-Smtp-Source: APiQypIp1ELmzB5fG9uX2pq2H9g1KwYn5DLvW7xYOQHxUmsRNv0kKcTM1U3+9AGGZkAeL5s2GwWGOE1UtDZR/44XhdQ=
X-Received: by 2002:a05:6830:22dc:: with SMTP id q28mr9240147otc.221.1587392185768;
 Mon, 20 Apr 2020 07:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200331133536.3328-1-linus.walleij@linaro.org>
 <CAFEAcA9Gep1HN+7WJHencp9g2uUBLhagxdgjHf-16AOdP5oOjg@mail.gmail.com>
 <87v9luwgc6.fsf@mid.deneb.enyo.de> <CAFEAcA-No3Z95+UQJZWTxDesd-z_Y5XnyHs6NMpzDo3RVOHQ4w@mail.gmail.com>
In-Reply-To: <CAFEAcA-No3Z95+UQJZWTxDesd-z_Y5XnyHs6NMpzDo3RVOHQ4w@mail.gmail.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Mon, 20 Apr 2020 15:16:14 +0100
Message-ID: <CAFEAcA-ExeobtFswHPh3krV0K_9HdJmS7eJ2hvtzET+Hho6ESw@mail.gmail.com>
Subject: Re: [PATCH] fcntl: Add 32bit filesystem mode
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 20 Apr 2020 at 12:38, Peter Maydell <peter.maydell@linaro.org> wrote:
> Whoops, good point. I was testing this via lkvm, so it's
> actually using a 9p filesystem... I'll see if I can figure
> out how to test with an ext3 fs, which I think is the one
> we most care about.

After some effort wrestling with kvmtool (which assumes that
if you provide it a disk image then you must have wanted that
to be your rootfs and can only be persuaded otherwise via
some undocumented and arcane options), I did a test with ext4:

bash-4.4# /qemu-no-fix /readdir-bug
dir=0x76108
readdir(dir)=(nil)
errno=75: Value too large for defined data type
bash-4.4# /qemu-fixed /readdir-bug
dir=0x76108
readdir(dir)=0x76128
errno=0: Success

(where the host kernel has Linus' fcntl patch, qemu-no-fix
is a current-git-master QEMU and qemu-fixed is one with
the patch in my previous email).

So for Linus' patch:

Tested-by: Peter Maydell <peter.maydell@linaro.org>

If 9pfs could be persuaded to honour the fcntl flag too
that would be really nice.

thanks
-- PMM
