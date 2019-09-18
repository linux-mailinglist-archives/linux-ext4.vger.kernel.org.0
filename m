Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B443DB6EAA
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2019 23:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbfIRVPP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Sep 2019 17:15:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51302 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfIRVPP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Sep 2019 17:15:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id 7so1779323wme.1;
        Wed, 18 Sep 2019 14:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I8yXMHibszj2VHQlt+S1+oJOQptBsYs/sYyYtWEyoDM=;
        b=SGzLeNjN9RtxfKPfFRxKDpttLPdBNIAdVqAUW/6qBoK7Rdwr6hhG3WkSHuNaNkVqUB
         IZDH/WrUM/EDQE4L6yrkg8G2Tu4rS/55SwYwMv692WLvgMefVjb0rX/pfh2WfTnDNLAA
         RkhCsRxNnIVJVynwenKWP9c49eWIS2m1N8e4USectIBr6l/QVdvKcGmwpkF9YF7+nVEC
         DFAzRLs730dJDNuL0TI6DDBc2FvJRxsoiPOop4zcGoU5zTO08ViDqGTwq+3dMt0pPNtc
         RI1uuxwtGLRv+QZtCK4E4ZsP7l3B8i+jWh3JZJeyKZrY2CcaNCT6wvkkQqfEUq8d56/F
         UrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I8yXMHibszj2VHQlt+S1+oJOQptBsYs/sYyYtWEyoDM=;
        b=kjl09KWBnLJmmJrczlgbr7TywRUzEqF8eY4RAnvwREuM59lIMjdxW7gYsEWrcan9OV
         /ZKGex+9/qCi1KJRd7nzGu8/Q++3ePULcWDf66PdnfBEuts2FHyQUYJ1kL+zwTIzFFUo
         LYPL5GhBI41AsRY6wDdtEpjao+NW2ZFgwiuJrsfL/Sj2Z9fTeb+tFfEaYtUTSsMrZJVI
         uVnMe7mZjpfdw4l+Kavm+QTNYP2k6lZxVsnC85eRu4xewi9b3ZX9DQnbBV0vG2Hoc0Yv
         8YAYZ6C7W8Em5nzOg5Jj1amUAQyWoqOfh4Nc7RtSq9C99qH5UcueChkPcsoR5A2+LtVL
         mQAA==
X-Gm-Message-State: APjAAAUJiAFCrJ07+YW3HPJjrqaLmo7y7nh3ogu0mPq7bMjBblyXJMzk
        36pfB/zMU5KP3Dxy5SHfx+I=
X-Google-Smtp-Source: APXvYqywwDo5aqNswzW3Y+s7Aj3EfSnOPHWA+ei2ygDDXyzBDQhbgvA7X5b1d5z5qMXcJPQY2T5TaA==
X-Received: by 2002:a1c:a6ca:: with SMTP id p193mr4303240wme.103.1568841312486;
        Wed, 18 Sep 2019 14:15:12 -0700 (PDT)
Received: from darwi-home-pc ([5.158.153.52])
        by smtp.gmail.com with ESMTPSA id h9sm4969976wrv.30.2019.09.18.14.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 14:15:11 -0700 (PDT)
Date:   Wed, 18 Sep 2019 23:15:03 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-man@vger.kernel.org
Subject: [PATCH RFC v4 0/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
Message-ID: <20190918211503.GA1808@darwi-home-pc>
References: <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
 <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

This is an RFC, and it obviously needs much more testing beside the
"it boots" smoke test I've just did.

Interestingly though, on my current system, the triggered WARN()
**reliably** makes the system get un-stuck... I know this is a very
crude heuristic, but I would personally prefer it to the other
proposals that were mentioned in this jumbo thread.

If I get an OK from Linus on this, I'll send a polished v5: further
real testing, kernel-parameters.txt docs, a new getrandom_wait(7)
manpage as referenced in the WARN() message, and extensions to the
getrandom(2) manpage for new getrandom2().

The new getrandom2() system call is basically a summary of Linus',
Lennart's, and Willy's proposals. Please see the patch #1 commit log,
and the "Link:" section inside it, for a rationale.

@Lennart, since you obviously represent user-space here, any further
notes on the new system call?

thanks,

Ahmed S. Darwish (1):
  random: WARN on large getrandom() waits and introduce getrandom2()

 drivers/char/Kconfig        | 60 ++++++++++++++++++++++++--
 drivers/char/random.c       | 85 ++++++++++++++++++++++++++++++++-----
 include/uapi/linux/random.h | 20 +++++++--
 3 files changed, 148 insertions(+), 17 deletions(-)

--
http://darwish.chasingpointers.com
