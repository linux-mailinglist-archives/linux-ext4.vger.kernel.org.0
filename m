Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC96A91EA
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Sep 2019 21:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733026AbfIDSjZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Sep 2019 14:39:25 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45138 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732991AbfIDSjY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Sep 2019 14:39:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id x3so4817300plr.12
        for <linux-ext4@vger.kernel.org>; Wed, 04 Sep 2019 11:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RFVxIo+Qn+D3l74R0gbfOnsQVErdkpTLqYjhLCUkAbw=;
        b=jv5RYYTHFRDQwQoavPr+s26IndTLQO1TBV8cq+L3X/QMkeT0/ARB3rrjSwpb5wT7pf
         HtAMic+J1yHXdWpxSKcqVbMIg1qIjlRvQrl2FC694er0m9eDz9r15q7fzqREYWveN3q/
         INbD175q4V8GheY5yqsIeOAt2YahZu+uSA5DZVxnb+U2tUCevLqsvSO4ddZ8xDU8dwt1
         xDID7Ea5A1yayF/lfUXOZ/7V8pNUnkbju8VHPFtEuCHaNyc+qDXu1EtssjenusvKOXof
         R67M83ORZEZQVKvh8VIOJeFUUOkfriI2Q8FLCGJTLS4s7Df2JvUiqA4G8r1sJhp9runZ
         yeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RFVxIo+Qn+D3l74R0gbfOnsQVErdkpTLqYjhLCUkAbw=;
        b=XwEi6qQ7sFCH4lFxYl4p48ZLjsew+e+iu2A0yxlH/GVEUL5MbtLuAirG40ZpwodFwH
         Rl0LE59Egr4rIO/5MdttLJu7/8NQoofkg5ZILzv6yhMyNl6FSEm4zQDtgYKz3rFxfdhx
         9pySc/EVzi89DtJ/US0t0RwQxzD5cFFTKGp+w4QzHrTqRmBXivzvUrrgv7Xw5Tv1M8bJ
         u/W0vOuN/YJT3UhTylGdtCDb3qYy0IZqEiuZRiMDc9l0d7GaPPTSruegs5AXSSeiPMUO
         /7LlN3dpH54IXG03nCkXg6+Ea09yd/btP7BJEpUIYUc1rw1s0JVLQOx3mTIBnjspDjUO
         9e+g==
X-Gm-Message-State: APjAAAVgfzL91c3luPDj3+j7fN7n/MQMTTFQehZRvYac2jmnaS4628vi
        iPIyhyoWunORCuh9pwt3lD+XSQ==
X-Google-Smtp-Source: APXvYqxW4kSbEq+gLWZofsFSTIckmnFnzgI+tc5jk4KG+Xa2V1PDira6ogt0MI+oocn1p8X2+FPZow==
X-Received: by 2002:a17:902:b201:: with SMTP id t1mr8923386plr.144.1567622363810;
        Wed, 04 Sep 2019 11:39:23 -0700 (PDT)
Received: from [192.168.10.175] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id k31sm6938153pjb.14.2019.09.04.11.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 11:39:23 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] ext4: Reduce ext4 timestamp warnings
From:   Andreas Dilger <adilger@dilger.ca>
X-Mailer: iPhone Mail (16G102)
In-Reply-To: <20190904150251.27004-1-deepa.kernel@gmail.com>
Date:   Wed, 4 Sep 2019 12:39:22 -0600
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, cai@lca.pw, jlayton@kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Content-Transfer-Encoding: quoted-printable
Message-Id: <ECBC97E7-53C5-4B4C-BC4C-1FCDC4C371B9@dilger.ca>
References: <31a671ea-a00b-37da-5f30-558c3ab6d690@thelounge.net> <20190904150251.27004-1-deepa.kernel@gmail.com>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sep 4, 2019, at 09:02, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>=20
> When ext4 file systems were created intentionally with 128 byte inodes,
> the rate-limited warning of eventual possible timestamp overflow are
> still emitted rather frequently.  Remove the warning for now.
>=20
> Discussion for whether any warning is needed,
> and where it should be emitted, can be found at
> https://lore.kernel.org/lkml/1567523922.5576.57.camel@lca.pw/.
> I can post a separate follow-up patch after the conclusion.
>=20
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>

I'd be in favor of a severely rare-limited warning in the actual case
that Y2038 timestamps cannot be stored, but the current message is
too verbose for now and I agree it is better to remove it while discussions
on the best solution are underway.=20

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/ext4.h | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 9e3ae3be3de9..24b14bd3feab 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -833,10 +833,8 @@ do {                                        \
>        (raw_inode)->xtime ## _extra =3D                    \
>                ext4_encode_extra_time(&(inode)->xtime);    \
>        }                                \
> -    else    {\
> +    else    \
>        (raw_inode)->xtime =3D cpu_to_le32(clamp_t(int32_t, (inode)->xtime.=
tv_sec, S32_MIN, S32_MAX));    \
> -        ext4_warning_inode(inode, "inode does not support timestamps beyo=
nd 2038"); \
> -    } \
> } while (0)
>=20
> #define EXT4_EINODE_SET_XTIME(xtime, einode, raw_inode)                   \=

> --=20
> 2.17.1
>=20
