Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C491B216AA1
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jul 2020 12:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgGGKoT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jul 2020 06:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgGGKoS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jul 2020 06:44:18 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F59C08C5E0
        for <linux-ext4@vger.kernel.org>; Tue,  7 Jul 2020 03:44:18 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k4so34489420oik.2
        for <linux-ext4@vger.kernel.org>; Tue, 07 Jul 2020 03:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7QgWKK4RTXLZo2mZ8LP12+iEtRAYWukejbIygBOzwIw=;
        b=i+8zrHE/fs2Y8R0mSJSYG3HjDe8DMVO33zE9s8G+U3bPlySiM1KMfVq7FQZXMQAhf1
         1otQWa3z0Vo7rjF4WrjRMSTIn13HVhr/JHalXoGUunpOX7WHRLB3zlFjoS1E2nKKej2L
         wWpZzxVUx8xWAMhvXDyMkaCaV3SfS6vGC00xyBcxsE3DhCqezURHXrD0RavIKX0oj+sp
         /oPMgxrv/HUucbo5d4BmjphhcwAKuEq5xOk51hTZk2do4F4w3ppJDidPfTL+qFOXKgk2
         BplIYO3/hCX+Qvdwhdxy7PAM/Rm0Np0kp7ad9ua2RSY+KL50IHQX2mnutETcFSLaBndV
         Gpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7QgWKK4RTXLZo2mZ8LP12+iEtRAYWukejbIygBOzwIw=;
        b=HoJTQbD++765XdGIlfA9V7tij6Sf3dm8jt7uUBNcU/i4hBiFhA6Z+IbwJRPVoCIeZP
         GRDeMl5w/DMTI2JnjHni+ep9kR4I9iHoouQZzUdvxb2cn1cPSy4lVcwKKt4+0bvsHQTp
         fofIOKawf3K9/sCkDeQbqqtIiIMjFpTSCPfiC9QQQfBeVHiNtVzdDr1RUQ6rOs42THX2
         JqbfKMlGj3uNisY2qqgUqpQmFDcDrEK6gOQ6SY9iMVD541HAIQ9c/mkj0FwLt6rVcm9k
         TSAyS9ucdHSYt8eiXForLQgnT2GzZ1Vrkr6J+KJZVHx8zDouMLNzN4ByBkBtPAjjs11H
         tBrg==
X-Gm-Message-State: AOAM533uZVtVxL4cc+dXqTaUkk4ERzBiNnB4vsFklqZke/j/XBx7yHK0
        7htEheLjc4tXUcLVVg7qqZ8nS6p6UmP8VRbCl77GpD+B/ig=
X-Google-Smtp-Source: ABdhPJz+TeWph34DQmuzU5/HwXijA0+NDY97HXcO97SKerniK7b3Ulr3aDgUOA25daDJjAs5gvkPux2OD9AQjmHA6HA=
X-Received: by 2002:a05:6808:a19:: with SMTP id n25mr2626139oij.84.1594118657366;
 Tue, 07 Jul 2020 03:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200624043341.33364-1-drosen@google.com> <20200624043341.33364-5-drosen@google.com>
 <877dvxggsl.fsf@collabora.com>
In-Reply-To: <877dvxggsl.fsf@collabora.com>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Tue, 7 Jul 2020 03:44:06 -0700
Message-ID: <CA+PiJmQN6Mkqq3aA+v6032QZehHs2sTqthzM-NqZN6k3jGBJvg@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] ext4: Use generic casefolding support
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 23, 2020 at 10:43 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Daniel Rosenberg <drosen@google.com> writes:
>
> > -
> >  const struct dentry_operations ext4_dentry_ops = {
> > -     .d_hash = ext4_d_hash,
> > -     .d_compare = ext4_d_compare,
> > +     .d_hash = generic_ci_d_hash,
> > +     .d_compare = generic_ci_d_compare,
> >  };
> >  #endif
>
> Can you make the structure generic since it is the same for f2fs and
> ext4, which let you drop the code guards?  Unless that becomes a problem for
> d_revalidate with fscrypt, it is fine like this.
>
> --
> Gabriel Krisman Bertazi

I unify them in a later patch, since I end up having to deal with
fscrypt's d_revalidate. With that patch I'd end up undoing the export
I'd add for this, so I'll skip that for the moment.

-Daniel
