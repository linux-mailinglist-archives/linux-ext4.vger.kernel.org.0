Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8526C35CBBE
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Apr 2021 18:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244168AbhDLQZP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Apr 2021 12:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243870AbhDLQYe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Apr 2021 12:24:34 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE1FC061349
        for <linux-ext4@vger.kernel.org>; Mon, 12 Apr 2021 09:24:09 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id l22so8725821ljc.9
        for <linux-ext4@vger.kernel.org>; Mon, 12 Apr 2021 09:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ueR+bzUQyBJ6Gmj9fHXIfDenKkhbJd11CuntNjq4ue8=;
        b=Al2PuI8Jtpzy/NwLxwtBoFYmkJnS/LiklYzPs1W31opZKivVBizLwtQrhvdcCOzNgl
         iFR4SpalKqJenVbjbDxeUakPBfXOWawua9ad3aoLoJ6u71vmqNsjc2z07HewEM5RCZnE
         537Yq4lD1OJ7BIDIr0AJhjMl3v314MH/ZEs9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ueR+bzUQyBJ6Gmj9fHXIfDenKkhbJd11CuntNjq4ue8=;
        b=MBO8Drko7mcySOwoxdnupOZa38WSRRWHxgIu8MbSIECmJyTI51wFksOX3ehKMjGYR2
         1tHnYf/PREx+JpNz60Fxs4BUIiLag3T098xlyx/TQHIuIfqTOUrbPkOrTKm8tsLhE+qk
         FXq/jgXmevtYXP7zgvfrySOiMv/vjy5fF9q/tfBUSUm9SX1JMzFKl+1BSrahKJlI8NCY
         ZJqOskVI+QWCt3d+JSMkt5AoKcNf9NRj71kYWD4gz6ap2U1y7WdT6/fqU0UHI5SYqrR+
         k0SBW6s3tK1CNWmhZPpu2OFe95d1tQaosWrVx5tquH/aMoE/Njxf44cXdtOsolfwaTay
         9uNw==
X-Gm-Message-State: AOAM530ABNCUBzFQJlAvwE+K6PNmQ1e2wD2gm5g6QVJ+nmM8kc4sPFYF
        cRHCpsFK65uwHnWLyOJD9SYBzd0VJtHH3m7d
X-Google-Smtp-Source: ABdhPJyDrPziNSykIbtmb4Aoc3aT4aS78v5wlw7whtKr4o0i10sP/LB/tn168NdRgEbWOC/wM5h8Dw==
X-Received: by 2002:a2e:91c2:: with SMTP id u2mr18257773ljg.301.1618244647786;
        Mon, 12 Apr 2021 09:24:07 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id b10sm1858191lff.3.2021.04.12.09.24.05
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 09:24:06 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id l14so13188990ljb.1
        for <linux-ext4@vger.kernel.org>; Mon, 12 Apr 2021 09:24:05 -0700 (PDT)
X-Received: by 2002:a05:6512:31c7:: with SMTP id j7mr10731751lfe.41.1618244634563;
 Mon, 12 Apr 2021 09:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <E901E25F-41FA-444D-B3C7-A7A786DDD5D5@tuxera.com>
In-Reply-To: <E901E25F-41FA-444D-B3C7-A7A786DDD5D5@tuxera.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Apr 2021 09:23:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiXqbSgqzv53C98sbaHVqpc+c8NZTpXC7bBMQT3OznE4g@mail.gmail.com>
Message-ID: <CAHk-=wiXqbSgqzv53C98sbaHVqpc+c8NZTpXC7bBMQT3OznE4g@mail.gmail.com>
Subject: Re: [PATCH v6 24/40] fs: make helpers idmap mount aware
To:     Anton Altaparmakov <anton@tuxera.com>
Cc:     "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "alban@kinvolk.io" <alban@kinvolk.io>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "cyphar@cyphar.com" <cyphar@cyphar.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "geofft@ldpreload.com" <geofft@ldpreload.com>,
        "hch@lst.de" <hch@lst.de>,
        "hirofumi@mail.parknet.co.jp" <hirofumi@mail.parknet.co.jp>,
        "john.johansen@canonical.com" <john.johansen@canonical.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "lennart@poettering.net" <lennart@poettering.net>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mpatel@redhat.com" <mpatel@redhat.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "seth.forshee@canonical.com" <seth.forshee@canonical.com>,
        "smbarber@chromium.org" <smbarber@chromium.org>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "tkjos@google.com" <tkjos@google.com>,
        "tycho@tycho.ws" <tycho@tycho.ws>, "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 12, 2021 at 5:05 AM Anton Altaparmakov <anton@tuxera.com> wrote:
>
> Shouldn't that be using mnt_userns instead of &init_user_ns both for the setattr_prepare() and setattr_copy() calls?

It doesn't matter for a filesystem that hasn't marked itself as
supporting idmaps.

If the filesystem doesn't set FS_ALLOW_IDMAP, then mnt_userns is
always going to be &init_user_ns.

That said, I don't think you are wrong - it would probably be a good
idea to pass down the 'mnt_userns' argument just to avoid confusion.
But if you look at the history, you'll see that adding the mount
namespace argument to the helper functions (like setattr_copy())
happened before the actual "switch the filesystem setattr() function
over to get the namespace argument".

So the current situation is partly an artifact of how the incremental
filesystem changes were done.

           Linus
