Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D726F2C1830
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Nov 2020 23:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732343AbgKWWHA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 17:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732349AbgKWWHA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Nov 2020 17:07:00 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93177C061A52
        for <linux-ext4@vger.kernel.org>; Mon, 23 Nov 2020 14:06:59 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id k4so18757789edl.0
        for <linux-ext4@vger.kernel.org>; Mon, 23 Nov 2020 14:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ArDHvUzfUiZzh94W960BgkUJZn/5DnacTXHC4Nbv9kI=;
        b=Ihm9gWe+6m2iCUrCqSrzj2hxvAUOkkHpCGtwhE41f3Rdh8c80xsJegtLMifcQSq7l4
         MQxmEg8qFYnoifRMupAHJLQd5lYZm+n6GzQdGqoyCuHFxDt3fXMsW4siDYXty7uFQyR+
         ZiLBHsJEHGtWXoprHv+EbMvUbaSfI62VdYDnQ6kSau+U/tc34IQsesxRL2sYZY1EAFs1
         LsTOG7yiGz9YGo+XzQObpUnu50coOcAWET1QWObW0HN2FliSyDT2/hew7cMEOL8j6Rt4
         CkHD0bLpWTrv0L4vHLaw7qmLF7A/4zumynmI5rzULQJ1fukCf4JWCo9n/ipboGbcKUNv
         ClRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ArDHvUzfUiZzh94W960BgkUJZn/5DnacTXHC4Nbv9kI=;
        b=VTxkj/I1w/8DBvnfYOYi7P/r+EhoHXcJJaxoNc+2k+WRZoyDvhQE+V/ptjCpeCrZ8a
         iRYpqnpz1SBOepeaTFbn/YyE5s/qkv74irtr0Sfv6FH+YqbdfjJpRt2wVX3gOEII4phM
         qILT6A9PBJuVbG5Djpl3y130LfRTIkuoYsitrPf6Fk9fopOXaJmLGECq7dkGgP+HJ67X
         hLNEAs6tI/m5U2UQRF+rYE6cAAPw46dXehrEmOKJ2J9csdZMR+0vnH7ky0NhqLPzP5yZ
         ymoYXNvG7FLZo/oSoAe8m+syHMZZhURHxZtD8c/v6iqBir9eRIWnclo0I3XYEQlAKWHi
         XIZQ==
X-Gm-Message-State: AOAM531QjFlAUndxVVR1Lw4ognfGnOMDrX9pLrizq5YIXYVsy9L6USuk
        lZD8okIG4y8qbRTL23RGFYLkxljHgbja0QGzwjBn
X-Google-Smtp-Source: ABdhPJyCGu6X9xaHoLXWBbQARSvPVPAoR3jFBNgP4UppEnyulyojvZlb/ppHqsSx8lMhDFxNpQsOSthLAo4GmR/YyTM=
X-Received: by 2002:a50:a6d0:: with SMTP id f16mr1171069edc.135.1606169217904;
 Mon, 23 Nov 2020 14:06:57 -0800 (PST)
MIME-Version: 1.0
References: <20201115103718.298186-1-christian.brauner@ubuntu.com>
 <20201115103718.298186-32-christian.brauner@ubuntu.com> <CAHC9VhQ5gcOa0+KKDtKEgg_v4SZV2hPdaKUbPGJAQrVB8mn0jA@mail.gmail.com>
 <20201123074157.fqus6fgtcytydp2c@wittgenstein>
In-Reply-To: <20201123074157.fqus6fgtcytydp2c@wittgenstein>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Nov 2020 17:06:46 -0500
Message-ID: <CAHC9VhTrYDEAkaLbwtF7hQS=8HpM4wx7A_fN4=9pL6EAM-KPGw@mail.gmail.com>
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

On Mon, Nov 23, 2020 at 2:42 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Sun, Nov 22, 2020 at 05:17:39PM -0500, Paul Moore wrote:
> > On Sun, Nov 15, 2020 at 5:43 AM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > >
> > > Audit will sometimes log the inode's i_uid and i_gid. Enable audit to log the
> > > mapped inode when it is accessed from an idmapped mount.
> >
> > I mentioned this in an earlier patch in this patchset, but it is worth
>
> I did not receive that message.

I'm guessing just a slow mail relay somewhere as you responded to both
of my emails on this patchset, I think we're all set for now :)

Thanks.

-- 
paul moore
www.paul-moore.com
