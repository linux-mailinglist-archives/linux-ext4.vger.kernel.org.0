Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9742FBAC3
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Jan 2021 16:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbhASPJT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Jan 2021 10:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390097AbhASPHB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Jan 2021 10:07:01 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D2AC06179B
        for <linux-ext4@vger.kernel.org>; Tue, 19 Jan 2021 07:05:29 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 23so29480753lfg.10
        for <linux-ext4@vger.kernel.org>; Tue, 19 Jan 2021 07:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gOmgvCPsNvi85/TpBsHHlznh/AXeaDwbv8LGPCZK7GU=;
        b=jHOv7ZfcUJDyBrUH8oJXnGIi8zR/GVQigV9JsU3VOD2zVPzE8Qi8FcxCv3RN2B9A6r
         xugkjyegXRk25clhQPkHPl6Bgq5is0HjaMKTdere1dxwfXiSoujavM6bCqwMy7DZTLAY
         XzwyrYIOx+UbZ4taCEFKeVgvzFkPqWMiBrHN0cesc58X2THa+V2gdhqFGvQ0m5hl69PP
         86p4cNSHXci62Q5bRCDCUjqJlCKurpnZ2KQ8/bUtutXFEHhOZcuBiBOGHUyG7S3P/OJ0
         UhrskVG5YmmxTBCZMbabr3ZIzMkK81tYRiWGV1k3KMjBXOmM5Zrq6ssCUVgGucgyhjVM
         mc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gOmgvCPsNvi85/TpBsHHlznh/AXeaDwbv8LGPCZK7GU=;
        b=Rm1EtgUylnZlpsjwyp/6y9sNpsvb699JdhRJF7A9NE86LIzR7ExpcFrTb7F1PkSRED
         dxCrpzojzpwUwGanQXPebCkdjtomU9BDzKWzBHSGQVcX6KoV7prxnJupM7vRgX2gUCSv
         wRjSJjzm5+cN+en9XL+M96jKgzcpD2iDaW1de7Tf7ydvFu9B/LKMC02RgtrQBf5iuiE+
         K40fAjlUTE1VWgPa0os3SWrZinT9UMvI59ERmaQIUMIzigwyNrbXzm3oAKQHnswAO9JP
         XA5QEdRSKocMer8SLfvt2FHm/l8FENaqfp+4RaZgl0mEUbQUnXBrtcITm+zKXy4TFcg4
         bWrQ==
X-Gm-Message-State: AOAM533CL1/RCJz56V7buhqhyehUW9YmHNStWukckFLTPYLCV29gPRU5
        AUQRhJg+yhUX+6X/ylLhhb9WZggQSALFU/FnfFllLg==
X-Google-Smtp-Source: ABdhPJxFxS+hG4x6TwLiOwPtHwa+9Zao0MvjeAr8yET1CRB9c/HolYwSYvtkLR07E5CI/h61T92ZT6GwaxlT4i6ykfk=
X-Received: by 2002:a19:197:: with SMTP id 145mr2043470lfb.352.1611068727150;
 Tue, 19 Jan 2021 07:05:27 -0800 (PST)
MIME-Version: 1.0
References: <20210112220124.837960-1-christian.brauner@ubuntu.com> <20210112220124.837960-16-christian.brauner@ubuntu.com>
In-Reply-To: <20210112220124.837960-16-christian.brauner@ubuntu.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 19 Jan 2021 16:05:00 +0100
Message-ID: <CAG48ez3Ccr77+zH56YGimESf9jdy_xnQrebypn1TXEP3Q+xw=w@mail.gmail.com>
Subject: Re: [PATCH v5 15/42] fs: add file_user_ns() helper
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
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
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stephen Barber <smbarber@chromium.org>,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-xfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 13, 2021 at 1:52 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> Add a simple helper to retrieve the user namespace associated with the
> vfsmount of a file. Christoph correctly points out that this makes
> codepaths (e.g. ioctls) way easier to follow that would otherwise
> dereference via mnt_user_ns(file->f_path.mnt).
>
> In order to make file_user_ns() static inline we'd need to include
> mount.h in either file.h or fs.h which seems undesirable so let's simply
> not force file_user_ns() to be inline.
[...]
> +struct user_namespace *file_user_ns(struct file *file)
> +{
> +       return mnt_user_ns(file->f_path.mnt);
> +}

That name is confusing to me, because when I think of "the userns of a
file", it's file->f_cred->user_ns. There are a bunch of places that
look at that, as you can see from grepping for "f_cred->user_ns".

If you really want this to be a separate helper, can you maybe give it
a clearer name? file_mnt_user_ns(), or something like that, idk.
