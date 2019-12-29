Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2FE12C30F
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Dec 2019 16:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfL2PI4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 29 Dec 2019 10:08:56 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36391 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfL2PIz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 29 Dec 2019 10:08:55 -0500
Received: by mail-oi1-f195.google.com with SMTP id c16so10554052oic.3
        for <linux-ext4@vger.kernel.org>; Sun, 29 Dec 2019 07:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=JpqRu20LZHxdWN1UW9AkuUQvQXkCetz6nWnrVXZaXRg=;
        b=S+uZxX+EaQmPyB6zJ2fqU/hUZuwlpmMS4Hu3op3yUKzfg+ck49mpuWaMrCl8Ro03Sf
         P05YwiT9hWqZYAfCCPEX/l/A8d5Fay2EEpm05+o4kmdiBfoEXLTD88+5f/1LLws9AsN+
         nYHetUMmzMlUs+pTTZ+yL/MCwEHdNtXJ0AjyriI6S2AWH91p4gMxlmiILlQscp4l5bZP
         tkmzsKjJd/j+6FFjOYdh2mz4cu9GyxzT7vp8Scpt+up6IoUN2jTI5FKBH1OyxHyM7U56
         9gMqeHWsAx7qlHry2TcgBE5OUIKF7xYIP7qIHkbtrVOCZgz1eZlnSJt0mat7uv7604if
         SXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=JpqRu20LZHxdWN1UW9AkuUQvQXkCetz6nWnrVXZaXRg=;
        b=CSgPzYqEccyoYbbGivoBJ1V2ld9uhtI4wFFbo6XDRDRCa3e92xYvLpLNOG9LJ9iZq/
         LfPrHjC6XKlqv/pG2mcprBurO75RvSCqwfc5txXNQl0FdBQsZKvxnapbAbeed7qJe73j
         R9Jt8iVjrjgxNhWwv0DuOiNRxPihLYYKjpL7e2Hcm2MNPaRExv/zUCjwSbJjZWcW48Mh
         m6CU2XwC4CLXpfSwS+lvQUWggxvuJVyec+epXIbfiwuD+rt54zCDyTecp1otKLov5DeW
         /R2OJNA6bkmG2MvB7MAx0nDwgHaPHBrM7PYYQiVACwFY8oYQS+C2dlXB1B2F4wVjBsBA
         KG/g==
X-Gm-Message-State: APjAAAVzvlyo35DT71JkY8kveKnmOMSuWWUJ5dIuYzUHRtnRfBTXSXIM
        Prj95Ezz/2MZOouo4QuNF3BsgQ==
X-Google-Smtp-Source: APXvYqxjo/qRxZba1IgLCKplUt2/vIzbNAMP97x3QWuUCy1ztu/OkNu7bZ2vnDIB9uXXfpGv2kA/vQ==
X-Received: by 2002:aca:758a:: with SMTP id q132mr5236846oic.162.1577632134837;
        Sun, 29 Dec 2019 07:08:54 -0800 (PST)
Received: from [26.83.181.6] ([172.58.107.236])
        by smtp.gmail.com with ESMTPSA id t25sm12835238oij.17.2019.12.29.07.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2019 07:08:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 0/8] Rework random blocking
Date:   Sun, 29 Dec 2019 23:08:50 +0800
Message-Id: <AA6F6C68-CC2E-45ED-974D-1667769AF679@amacapital.net>
References: <20191229144904.GB7177@mit.edu>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
In-Reply-To: <20191229144904.GB7177@mit.edu>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
X-Mailer: iPhone Mail (17C54)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



> On Dec 29, 2019, at 10:49 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>=20
> =EF=BB=BFOn Fri, Dec 27, 2019 at 06:06:56PM -0800, Andy Lutomirski wrote:
>>=20
>> I'm thinking of having a real class device and chardev for each hwrng
>> device.  Authentication is entirely in userspace: whatever user code
>> is involved can look at the sysfs hierarchy and decide to what extent
>> it trusts a given source.  This could be done based on bus topology or
>> based on anything else.
>=20
> Yes, that's what I was thinking.  Another project on my "when I can
> get a round tuit" list is to change how drivers/char/random.c taps
> into the hwrng devices, mixing in a bit from each of these devies in a
> round-robin fashion, instead of just feeding from a single hwrng.
>=20
>> The kernel could also separately expose various noise sources, and the
>> user code can do whatever it wants with them.  But these should be
>> explicitly unconditioned, un-entropy-extracted sources -- user code
>> can run its favorite algorithm to extract something it believes to be
>> useful.  The only conceptually tricky bit is keeping user code like
>> this from interfering with the in-kernel RNG.
>=20
> The other problem is the unconditioned values of the noise sources may
> leak unacceptable amounts of information about system operation.  The
> most obvious example of this would be keyboard and mouse sources,
> where today we mix in not only the timing information, but the actual
> input values (e.g., the keyboard scancodes) into the entropy pool.
> Exposing this to userspace, even if it is via a privileged system
> call, would be... unwise.
>=20
>         =20

Hmm. We could give only the timing.

We could also say that the official interface for this is to use tracepoints=
 and punt everything into userspace.=
