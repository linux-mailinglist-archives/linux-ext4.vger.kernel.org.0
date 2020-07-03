Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BD12130C9
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jul 2020 03:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgGCBBv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Jul 2020 21:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgGCBBu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Jul 2020 21:01:50 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1817BC08C5E0
        for <linux-ext4@vger.kernel.org>; Thu,  2 Jul 2020 18:01:50 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 95so14906894otw.10
        for <linux-ext4@vger.kernel.org>; Thu, 02 Jul 2020 18:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+0u5TnXqElmJHIUbIwfyg0UnTaWODXR+GC+hM1QsUz4=;
        b=oOqDzf9UhdHQiWfizW6yxKYuiXycU3fWLPwduq8AH7hV/7gSiEHYYCaf1R8F2ctgqG
         Ctt5zAILp2PI93b4Q9sIqk+bct1cHbzT8Yw9+IcOxwWKgWbCaachSWq9et+Yf8XtLZAo
         4PfjLQ2EBIkG8ZapbfVu6Be6/Vu8TcYpCdwMqVXiYNjxd4suP9wdDfoO3oqnw035dU8n
         /R6DDvFq0BMQXLdQ3Ov60bKRizaMZFmcKMO6VN+JDo/z+/DFAUQ/rBIJ0OdRJmHbICOW
         lVBzFxBYsXOkdcGMH5/fGPjcJF+UWV/JV1fhleZLJ4KwG6qXoSH5MyKRsJ+/bO2HGygC
         mIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0u5TnXqElmJHIUbIwfyg0UnTaWODXR+GC+hM1QsUz4=;
        b=oTKdEPdLgA2i8uAj9H5HokUb5v0BrNwUGnc/Vm+KQnclkM/xc2f1/AGWupznBQ6WNg
         5imSePNEW6lK8UB0VLnVemDdNUjF93VW/0Eljvz76Q1IaP9LdCKEhbTvBR7VqrfVAKy4
         VOdgc0S2l3ej+HcaDjFh/JiNimF4jBPPkjzQs9RZ7K+6RXdn7k2qy9uYyfPT5YYwa7vO
         BSW8qGgBmd5XHP6ZI8iK2AfV78V2JcxrDuyFKcxm01Kse3nbO4n6MxH8wKKvpxAEb6eR
         1rDlNpnX+wgqxWxLp7F69WHj5Tlf+WZVVB3oCud33MI9M2HppRj7tzwUndRyVkWENRNZ
         s5pA==
X-Gm-Message-State: AOAM533TRlrOfcFWbZl/mqIwo7LOQUaZLAANo6W7BL0aAWABYIZHNgR2
        vWoM+aqEmDqkadn/GlBSZRYWg2aNuR40tlETEfAz4Dp4kIhdag==
X-Google-Smtp-Source: ABdhPJxyzjPijsRL1V11XOG//slLi4ypOVvA8gCAeJn23Y/3chvpbEFZmi5lFQBGL/hRDveD1WrFac5iKC6RBaNTr+k=
X-Received: by 2002:a9d:6d98:: with SMTP id x24mr18707612otp.93.1593738109138;
 Thu, 02 Jul 2020 18:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200624043341.33364-1-drosen@google.com> <20200624043341.33364-3-drosen@google.com>
 <20200624055707.GG844@sol.localdomain>
In-Reply-To: <20200624055707.GG844@sol.localdomain>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Thu, 2 Jul 2020 18:01:37 -0700
Message-ID: <CA+PiJmTDXTKnccJdADX=ir+PtqsDD72xHGbzObpntkjkVmKHxQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] fs: Add standard casefolding support
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
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

On Tue, Jun 23, 2020 at 10:57 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Note that the '!IS_ENCRYPTED(dir) || fscrypt_has_encryption_key(dir)' check can
> be racy, because a process can be looking up a no-key token in a directory while
> concurrently another process initializes the directory's ->i_crypt_info, causing
> fscrypt_has_encryption_key(dir) to suddenly start returning true.
>
> In my rework of filename handling in f2fs, I actually ended up removing all
> calls to needs_casefold(), thus avoiding this race.  f2fs now decides whether
> the name is going to need casefolding early on, in __f2fs_setup_filename(),
> where it knows in a race-free way whether the filename is a no-key token or not.
>
> Perhaps ext4 should work the same way?  It did look like there would be some
> extra complexity due to how the ext4 directory hashing works in comparison to
> f2fs's, but I haven't had a chance to properly investigate it.
>
> - Eric

Hm. I think I should be able to just check for DCACHE_ENCRYPTED_NAME
in the dentry here, right? I'm just trying to avoid casefolding the
no-key token, and that flag should indicate that.
I'll see if I can rework the ext4 patches to not need needs_casefold
as well, since then there'd be no need to export it.
-Daniel
