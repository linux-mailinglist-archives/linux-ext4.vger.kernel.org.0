Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63532BFC1B
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Nov 2020 23:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgKVWRy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 Nov 2020 17:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgKVWRx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 22 Nov 2020 17:17:53 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADEBC061A4D
        for <linux-ext4@vger.kernel.org>; Sun, 22 Nov 2020 14:17:52 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id bo9so14896150ejb.13
        for <linux-ext4@vger.kernel.org>; Sun, 22 Nov 2020 14:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T4CY2UVVySQTR/IgGfrcAE9Yvfw8Rpt8ESDEqvgdlV0=;
        b=IsIYVTGVaCrVj9c5DcaTFqsBEseZHJ9vWNSoDkjdubHWL5RuSrHMX8lpFwvrVEbr+D
         YIaQzOtzE37dPsYUgIX3D0QQOgxuxcNycAVPUzh0u5rzIXxw1LzVcowcy040lmKqzTjc
         mBOGV1IjonOIMMt7fcNcLg0Jv9GavSzdJiCvSUjrG/Em5mfms4rj7V855zdZH+Mebjf/
         3a3ZJ43HzWf5s0G6gG55hnXRwDtz/TIIGYpZD/Dd2APn5UY5ULuxLKkIgKrRUpEgHBra
         zZASjWMuvIFAgw2L7OuVG7b+2NvuCyaLPF5cXQpaqgo8do08Ply0k66nA+LZF82DGHj4
         OyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T4CY2UVVySQTR/IgGfrcAE9Yvfw8Rpt8ESDEqvgdlV0=;
        b=hpdMmPGV3bLSZd1FVF4lGIZBH0Y6CgiNkN1BnGWpxkMDu0ROFbyVATskC2itVbzdFO
         nwKgAYOIS0UDdwq5vveNiPLGnBVUsDkJm5YADwc0LW9TQAPJbqM+FyC/lcGIanaWgVki
         38pBr41gTcCryzHVSUHHsw4amYZGPAJplzoMDg2RPLmOmwfOzJ9koyPMoLkn2YVLFf+C
         SHOZGUqmfmEtgVb4d9zXeRjbTmF1pu92TVW3yO/ei9zbdJKTL5yBEpLj3fbfghF0mzzy
         ve4KPvaThngWdNlywK1BQYE8ISHpQcIN4ssrXWVT0mPxya1nchr9Lkw7m3SdVgHsnccr
         X1xA==
X-Gm-Message-State: AOAM533tS85lS+O+tcnbH6Al6aNwWfajH3tVgWwyNOjFLwaUyToy/TLn
        5efFhxHunDII3NZ5wpAxhvTp/ZDJ1vxMjDHDbW4m
X-Google-Smtp-Source: ABdhPJw12xuRZoIeL/vGVBoUF4Pp6Vi1slczsoOA2TmXfkvzw8XIX8310DsMH/5qvds2YuOjg+U0QMN2daNuxBFO/6M=
X-Received: by 2002:a17:906:7c9:: with SMTP id m9mr40871916ejc.178.1606083470433;
 Sun, 22 Nov 2020 14:17:50 -0800 (PST)
MIME-Version: 1.0
References: <20201115103718.298186-1-christian.brauner@ubuntu.com> <20201115103718.298186-32-christian.brauner@ubuntu.com>
In-Reply-To: <20201115103718.298186-32-christian.brauner@ubuntu.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 22 Nov 2020 17:17:39 -0500
Message-ID: <CAHC9VhQ5gcOa0+KKDtKEgg_v4SZV2hPdaKUbPGJAQrVB8mn0jA@mail.gmail.com>
Subject: Re: [PATCH v2 31/39] audit: handle idmapped mounts
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-audit@redhat.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Nov 15, 2020 at 5:43 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> Audit will sometimes log the inode's i_uid and i_gid. Enable audit to log the
> mapped inode when it is accessed from an idmapped mount.

I mentioned this in an earlier patch in this patchset, but it is worth
repeating here: audit currently records information in the context of
the initial/host namespace and I believe it should probably stay that
way until the rest of the namespace smarts that Richard is working on
is merged.  If we do change the context of the inode's UID and GID
information it has the potential to create a rather odd looking audit
record with inconsistent credentials and the filters would yield some
very interesting results.

> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* v2 */
> unchanged
> ---
>  fs/namei.c            | 14 +++++++-------
>  include/linux/audit.h | 10 ++++++----
>  ipc/mqueue.c          |  8 ++++----
>  kernel/auditsc.c      | 26 ++++++++++++++------------
>  4 files changed, 31 insertions(+), 27 deletions(-)

-- 
paul moore
www.paul-moore.com
