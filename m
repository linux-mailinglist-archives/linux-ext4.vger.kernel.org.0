Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1307134ECB
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2020 22:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgAHVYX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jan 2020 16:24:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38487 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbgAHVYS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Jan 2020 16:24:18 -0500
Received: by mail-lj1-f196.google.com with SMTP id w1so4879344ljh.5
        for <linux-ext4@vger.kernel.org>; Wed, 08 Jan 2020 13:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MrgqnfuzWiyeoBisKfI9WUGDpT/I3A3pzpV2omGtkBc=;
        b=DDNcIoteefV8aBFRJqRjAYF8UmeDfEGuxO5aoHpC40ksghWZNn1vYOvHVH75utqX92
         8pyR/nWuhn+vomgt79nK/sovZ1x7PhYhTnNXeT0womFAJ98oI98vJEh+zZtrLhhAsaiT
         xHAeO525OvgTSe1X+L3USeOsbOk+RWWtyuGny4uD91Ul8TIcjfd6L4XmBIrytt5zzyEs
         hQErb3i2mU9p3strf1rp4eW3q1/1zYZBB0VrVfwfyEPkEBvcTwGsqDvhRh9K2zjsT3ch
         4bymw0ydHk1l0bLwoVhIPuVYIxoBXZ9csRffl8URhKARiRZg6AEOEEzGhtohlDS2x0zL
         xbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MrgqnfuzWiyeoBisKfI9WUGDpT/I3A3pzpV2omGtkBc=;
        b=Bd2IjS5cKtHUNQDNbYh2xgDviWlamU2IvopnBBU6+OfR84wVb6MPYDmsVKm25POFv2
         ChjOFwTsV2eOEX7qKocA9p/1WBO4fBs22i4KDi+bS9d+gqJdpwyBfeih2hEEf6n6AEZc
         2Ub3VRJDErVWpm3Qsj4tmnDkzysvyagVmhRLTNCbpojVijbukMJJ8fmSojSzF+z9gPl8
         eBdoR8d0qoQ7ElUPbBIyvIDAPQdWTr/B2EpOYMjffgiZ9qFcUfIsiE1c6e2CHiyOxEhh
         kdHyEe6okL1CMsXRrT9/nmqivljkSlvxBQkaF3D1auTXV2lvnuc/jFsBZSeLILPHpeQY
         7nig==
X-Gm-Message-State: APjAAAUTIfCpoH/wCuNeiFjAcfZVpUXQmDF+TcLgoiaI81uIBOT2S/2V
        9bts5bi7+AaH1eo3Gns4GF9TIeOVdFj8szRi3TILKje41fs=
X-Google-Smtp-Source: APXvYqzIFAaH51EKKHEbmEN6pXokDd653dkwA7mvIiTffi1G/lQMFKNkhMpqs1Z3DU3Ocqxwmy/VJxTCWBZ8KPcs8nw=
X-Received: by 2002:a05:651c:1049:: with SMTP id x9mr4073045ljm.233.1578518656460;
 Wed, 08 Jan 2020 13:24:16 -0800 (PST)
MIME-Version: 1.0
References: <20200107051638.40893-1-drosen@google.com> <20200108185005.GE263696@mit.edu>
In-Reply-To: <20200108185005.GE263696@mit.edu>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Wed, 8 Jan 2020 13:24:05 -0800
Message-ID: <CA+PiJmSLFVvRazSKDWOiygtgvE3-o6m6rq9q+jUKuhP-T2RHNw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Support for Casefolding and Encryption
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 8, 2020 at 10:50 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Jan 06, 2020 at 09:16:32PM -0800, Daniel Rosenberg wrote:
> > changes:
> > fscrypt moved to separate thread to rebase on fscrypt dev branch
> > addressed feedback, plus some minor fixes
>
> What branch was this based on?  There is no fscrypt dev branch, so I
> took the fscrypt master branch, and then applied your fscrypt patches,
> and then I tried to apply this patch series.  I got patch conflicts
> starting with the very first patch.
>
> Applying: TMP: fscrypt: Add support for casefolding with encryption
> error: patch failed: fs/crypto/Kconfig:9
> error: fs/crypto/Kconfig: patch does not apply
> error: patch failed: fs/crypto/fname.c:12
> error: fs/crypto/fname.c: patch does not apply
> error: patch failed: fs/crypto/fscrypt_private.h:12
> error: fs/crypto/fscrypt_private.h: patch does not apply
> error: patch failed: fs/crypto/keysetup.c:192
> error: fs/crypto/keysetup.c: patch does not apply
> error: patch failed: fs/crypto/policy.c:67
> error: fs/crypto/policy.c: patch does not apply
> error: patch failed: fs/inode.c:20
> error: fs/inode.c: patch does not apply
> error: patch failed: include/linux/fscrypt.h:127
> error: include/linux/fscrypt.h: patch does not apply
> Patch failed at 0001 TMP: fscrypt: Add support for casefolding with encryption
> hint: Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
>                                                   - Ted
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>

This is based off of ToT master. I put in a dummy fscrypt patch so you
wouldn't need to rebase on top of fscrypt, but I could just do future
patch sets all on top of fscrypt-dev. I guess my attempt to make it
easier just made it more confusing :(
