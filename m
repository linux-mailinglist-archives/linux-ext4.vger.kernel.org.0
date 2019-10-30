Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6BBEEA5DB
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Oct 2019 22:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfJ3V7V (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Oct 2019 17:59:21 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36548 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbfJ3V7U (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Oct 2019 17:59:20 -0400
Received: by mail-io1-f65.google.com with SMTP id s3so530431ioe.3
        for <linux-ext4@vger.kernel.org>; Wed, 30 Oct 2019 14:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S7mK3Uoiwaws9OYl+5bVE084OvHB6LGX6Sfc0eSAjwc=;
        b=aKsZ4bdZUSBifwnA9EI/sfdmKnP62vGSwIqzhbMUiTCUkHM2p7iqF53Jzgdv5kXvv6
         GBFkJoqdRYLQIybUp5uZd8C9F7L2xM/7BvH0VitcMonLl80SQX9+/8cxz1Pb55faR4eW
         W84909D8+2Y2GxJriYNmqjYg9MaPiledZHFQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S7mK3Uoiwaws9OYl+5bVE084OvHB6LGX6Sfc0eSAjwc=;
        b=MQAPkN+f8eX7kPB6zF4oDKFZTPJrjqd/vTWvQUTsZ03A7c8iS20oEyGcDAkD+KUkwB
         Wn9F7O6uG8oSecPMi/PC9TkGEyjLke4CJrQb4NhNwW7F4wa2KQMaQtsuyabTjjwWevr6
         3KRx9wLX5Cwrn6cdzulbYsHaBfrPYA7lMqcZVLd2+iPfdyAhcO6sn+6oJCbdEENhNQB2
         KWeHxosqlxOQDZZIDsE3EmLu7qPU5608WlI/AiJlcCSUGK2Z7NQrIVDomxkwsA89yrF6
         l+rUiZE2byL9HdNdTKqq0Yn/gi6L5c2lQuhw+r1XmOVnGiSYWOL1ycOdGWncoIBICx49
         E0LA==
X-Gm-Message-State: APjAAAW7TpxdKQ50lTliXHw0ON02cvFiNAvtFoBX5UXhcfSv4+kHhsaM
        TxmkiKCM5bNPOS/upZ9BqoDOx4JJIpI=
X-Google-Smtp-Source: APXvYqzNqWCdWGRmhVLm704iqmh9RjrdEiEkG0SlVfzyGxJxLQCWKlqC8EUArP9pHe5As86XP4OcCg==
X-Received: by 2002:a02:bb07:: with SMTP id y7mr387296jan.16.1572472758072;
        Wed, 30 Oct 2019 14:59:18 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id i79sm219538ild.6.2019.10.30.14.59.15
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2019 14:59:15 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id b12so3512057ilf.12
        for <linux-ext4@vger.kernel.org>; Wed, 30 Oct 2019 14:59:15 -0700 (PDT)
X-Received: by 2002:a92:ba1b:: with SMTP id o27mr2484026ili.269.1572472754921;
 Wed, 30 Oct 2019 14:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191030100618.1.Ibf7a996e4a58e84f11eec910938cfc3f9159c5de@changeid>
 <20191030173758.GC693@sol.localdomain> <CAD=FV=Uzma+eSGG1S1Aq6s3QdMNh4J-c=g-5uhB=0XBtkAawcA@mail.gmail.com>
 <20191030190226.GD693@sol.localdomain> <20191030205745.GA216218@sol.localdomain>
In-Reply-To: <20191030205745.GA216218@sol.localdomain>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 30 Oct 2019 14:59:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X6Q3QZaND-tfYr9mf-KYMeKFmJDca3ee-i9roWj+GHsQ@mail.gmail.com>
Message-ID: <CAD=FV=X6Q3QZaND-tfYr9mf-KYMeKFmJDca3ee-i9roWj+GHsQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "ext4 crypto: fix to check feature status before
 get policy"
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>, Chao Yu <chao@kernel.org>,
        Ryo Hashimoto <hashimoto@chromium.org>,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        Guenter Roeck <groeck@chromium.org>, apronin@chromium.org,
        linux-doc@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

On Wed, Oct 30, 2019 at 1:57 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> FWIW, from reading the Chrome OS code, I think the code you linked to isn't
> where the breakage actually is.  I think it's actually at
> https://chromium.googlesource.com/chromiumos/platform2/+/refs/heads/master/chromeos-common-script/share/chromeos-common.sh#375
> ... where an init script is using the error message printed by 'e4crypt
> get_policy' to decide whether to add -O encrypt to the filesystem or not.
>
> It really should check instead:
>
>         [ -e /sys/fs/ext4/features/encryption ]

OK, I filed <https://crbug.com/1019939> and CCed all the people listed
in the cryptohome "OWNERS" file.  Hopefully one of them can pick this
up as a general cleanup.  Thanks!

-Doug
