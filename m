Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C512BB82B
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Nov 2020 22:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgKTVQC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Nov 2020 16:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgKTVQB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Nov 2020 16:16:01 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD71C061A4A
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 13:15:59 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t21so8394386pgl.3
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 13:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h3PVNgWJ4wv679ueVcfOMGTzPLuWakBRGW5tpcXVwpU=;
        b=dU4KoiHZzIEflMXxYsdAq02/ZtKHAbVYN3DUKz1jjW6FqozuzDqj1HhoL1AotmA6iH
         J0FPfOX8vroNiQrqM3+Mg92Tbbg8Ta4YWvs2XOfQEnQO7II6Vndq8Xm0uvHveSP/s0Nq
         YqotYUJAiv3Sjru2HYlJJBB0l/Fq8aCCvoJwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h3PVNgWJ4wv679ueVcfOMGTzPLuWakBRGW5tpcXVwpU=;
        b=ekJFNaxcaPAPuMpSOmqKnIMsjjXJoiHfDBKxISvD+DHAwhtwoc19CJ99hu/FJtDrD0
         u6j2qsqbCGZO7WpK0gyIWog1aCHYJ+a5UQNYYkQPZ90CPxrfAFUKGya1Mg1EKfoO2wp+
         n9Jxk7rNkYoWeCGfN7MO9OklQGqhZVeMDzIa5CG5hQXNNUudDsHzMjvfad7qKQXRt1Td
         9WfLSI/hkiWuRZOActRFtB2RWPrCyrDL+muWUKkTorNyEfYwDaLl5xrbKhf9+T0eAuxU
         PsCrGvQZpwKH/nj8cX5/Ja0ik3SzsvZd7r6SulhNFOUsuDOv6At2eO3k93W1WZVyqyjZ
         Dg4Q==
X-Gm-Message-State: AOAM533rbPIHKH7lfFjMV8N4F9/hBMC/M72872YUyXbjTXmtDUf8tWH2
        RQw6Q6RYfwN1CxDB4KGuwtaSoA==
X-Google-Smtp-Source: ABdhPJxKoNsqmJfw8FXBuNWzYTFCvMP4QSPsIPE4HroDYde9n5FBnmXaYeQPf9Hkrj1TBoT0dMj64g==
X-Received: by 2002:aa7:8ac1:0:b029:197:7198:e943 with SMTP id b1-20020aa78ac10000b02901977198e943mr14806170pfd.58.1605906959108;
        Fri, 20 Nov 2020 13:15:59 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k9sm4598556pfi.188.2020.11.20.13.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 13:15:58 -0800 (PST)
Date:   Fri, 20 Nov 2020 13:15:57 -0800
From:   Kees Cook <keescook@chromium.org>
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
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-audit@redhat.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 39/39] tests: add vfs/idmapped mounts test suite
Message-ID: <202011201300.B158F1E4B@keescook>
References: <20201115103718.298186-1-christian.brauner@ubuntu.com>
 <20201115103718.298186-40-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115103718.298186-40-christian.brauner@ubuntu.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Nov 15, 2020 at 11:37:18AM +0100, Christian Brauner wrote:
> This adds a whole test suite for idmapped mounts but in order to ensure that
> there are no regression for the vfs itself it also includes tests for correct
> functionality on non-idmapped mounts. The following tests are currently
> available with more to come in the future:

Awesome! :)

Some glitches in the build, though... something about the ordering or
the Make rules produces odd results on a failure:

$ make
gcc -g -I../../../../usr/include/ -Wall -O2 -pthread    xattr.c internal.h utils.c utils.h -lcap -o /home/kees/src/linux-build/seccomp/tools/testing/selftests/idmap_mounts/xattr
gcc -g -I../../../../usr/include/ -Wall -O2 -pthread    core.c internal.h utils.c utils.h -lcap -o /home/kees/src/linux-build/seccomp/tools/testing/selftests/idmap_mounts/core
core.c:19:10: fatal error: sys/acl.h: No such file or directory
   19 | #include <sys/acl.h>
      |          ^~~~~~~~~~~
compilation terminated.
make: *** [../lib.mk:139: /home/kees/src/linux-build/seccomp/tools/testing/selftests/idmap_mounts/core]
Error 1
$ make
make: Nothing to be done for 'all'.
$ file xattr core
xattr: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=7a3c1951e54f20e657b4181c1be77c7183a54f81, for GNU/Linux 3.2.0, with debug_info, not stripped
core:  GCC precompiled header (version 014) for C

Even after I install libacl1-dev, I still get a "core" file output which
breaks attempts to build again. :)


Is there any way to have the test suite not depend on
__NR_mount_setattr? Running this test on older kernels fails everything.


-- 
Kees Cook
