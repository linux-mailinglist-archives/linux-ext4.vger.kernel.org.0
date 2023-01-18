Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03CE672211
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jan 2023 16:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjARPut (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Jan 2023 10:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjARPuF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Jan 2023 10:50:05 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A61D54211
        for <linux-ext4@vger.kernel.org>; Wed, 18 Jan 2023 07:48:25 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id 187so5451680vsv.10
        for <linux-ext4@vger.kernel.org>; Wed, 18 Jan 2023 07:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r3WJDT3V1EhGVUqkCrI+CG1r/Fdf7qeOIglNT8T9eqo=;
        b=gy4n4mym+qJTug4eLAmgYVvmieLCjrvOvpVHbjIX7Q26CXX/evENiazSmnoenWkLzf
         uW37SmWuF5aoz05vM9pwTMmsBdZLSTDjUbb0iHrnt6gKuARC2gkRp774ymP2EKYFgQ6x
         w0x1ktwUcMI4H8Ow11DfrD1gFevKPfxv82N+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3WJDT3V1EhGVUqkCrI+CG1r/Fdf7qeOIglNT8T9eqo=;
        b=UI+Nkj4PJFo60G7/ttO/KxXeq1tgK/2wP39fQdHmq5mksQiim7OFZrIwQLcLqRt2qC
         zTq0xWTrj/tPDPwB8BpA+miwgBWJpUALD7Dn3xOTL+5kmgPp/6I4U+hr9rT2t4LMVayz
         nSsV6jVT+YpypzzyKb/LmcnrGbECaIn1rIh+HDKZwXDK0i0CVLLHhSEtB3iWXR4JFzeu
         m0N8OwqnrbEUsqgI4iTUR9Xe1wQSTolydzeijcy3D1gnvJM4/QaeEszhTb4/uXPqSEPe
         /I3j2CczAnmaHchTsX21MloEACArSjdYE6OFlahzdZXKKj0PWOpRGeiBAIQ8MlFG3ETx
         LIkQ==
X-Gm-Message-State: AFqh2kpPjehXZX3EmSxxNZYJ4ZzzxpTmM/zoiEjtBSUHyZguJGZvLk/s
        7WkRPd1s9GG98mpC1eXJNpcGkrtrBmuPumzz
X-Google-Smtp-Source: AMrXdXuPfPg+gIEOPaOMQNdu461DvHxg68eNJXXb66Qq/MyjALhkO3m3cGG36gN4nskHmRpTq8K/dA==
X-Received: by 2002:a05:6102:1623:b0:3d3:cef6:37d5 with SMTP id cu35-20020a056102162300b003d3cef637d5mr4960508vsb.25.1674056903885;
        Wed, 18 Jan 2023 07:48:23 -0800 (PST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com. [209.85.219.48])
        by smtp.gmail.com with ESMTPSA id m4-20020a05620a290400b007069fde14a6sm3302568qkp.25.2023.01.18.07.48.23
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 07:48:23 -0800 (PST)
Received: by mail-qv1-f48.google.com with SMTP id j9so24093580qvt.0
        for <linux-ext4@vger.kernel.org>; Wed, 18 Jan 2023 07:48:23 -0800 (PST)
X-Received: by 2002:a05:6214:5d11:b0:531:7593:f551 with SMTP id
 me17-20020a0562145d1100b005317593f551mr364972qvb.89.1674056902835; Wed, 18
 Jan 2023 07:48:22 -0800 (PST)
MIME-Version: 1.0
References: <Y8bpkm3jA3bDm3eL@debian-BULLSEYE-live-builder-AMD64>
 <7DE6598D-B60D-466F-8771-5FEC0FDEC57F@dilger.ca> <Y8dtze3ZLGaUi8pi@sol.localdomain>
 <CAHk-=whUNjwqZXa-MH9KMmc_CpQpoFKFjAB9ZKHuu=TbsouT4A@mail.gmail.com> <Y8eAJIKikCTJrlcr@sol.localdomain>
In-Reply-To: <Y8eAJIKikCTJrlcr@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Jan 2023 07:48:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg7SkJZeAJ-KMKxsA7m9cs7MJoSDpu0aYKVm=bAwhcqjA@mail.gmail.com>
Message-ID: <CAHk-=wg7SkJZeAJ-KMKxsA7m9cs7MJoSDpu0aYKVm=bAwhcqjA@mail.gmail.com>
Subject: Re: Detecting default signedness of char in ext4 (despite -funsigned-char)
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Eric Whitney <enwlinux@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 17, 2023 at 9:14 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Well, reading the code more carefully, the on-disk ext4 superblock can contain
> EXT2_FLAGS_SIGNED_HASH, EXT2_FLAGS_UNSIGNED_HASH, or neither.  "Neither" is the
> legacy case.  The above existing code in ext4 is handling the "neither" case by
> setting the flag corresponding to the default signedness of char.  So yes, that
> migration code was always broken if you moved the disk from a platform with
> signed char (e.g. x86) to a platform with unsigned char (e.g. arm).  But,
> -funsigned-char breaks it whenever the disk stays on a platform with signed
> char.  That seems much worse.  Though, it's also a migration for legacy
> filesystems, so maybe that code isn't needed often anymore anyway...

The xattr hash is also broken if it stays on one single machine, but
is accessed two different ways.

Example: about half our architectures are mainly tested inside qemu,
so if you ever end up using the same disk image across two emulated
environments, you'll hit the exact same thing.

Basically, any filesystem that depends on host byte order, or on
host-specific data sizes - or on host signedness rules - is simply
completely and utterly broken (unless it's something like 'tmpfs' that
doesn't have any existence outside of that machine).

So ext4 has been broken from day one when it comes to xattr hashing.

And nobody ever noticed, because very few people use xattrs to begin
with, and when they do it tends to be very limited. And they seldom
mix architectures.

But "nobody noticed" doesn't mean it wasn't broken. It was always
completely and unambiguously buggy.

> >  (a) just admit that ext4 was buggy, and say "char is now unsigned",
> > and know that generic/454 will fail when you switch from a buggy
> > kernel to a new one that no longer has this signedness bug.
>
> It seems kind of crazy to intentionally break xattrs with non-ASCII names upon a
> kernel upgrade...

I really don't think they happen very much, and if we can fix a bug
without doing anything about it, and nobody notices, that would be
fine by me.

But:

> I think that what your patch does is allow filesystems to contain both signed
> and unsigned xattr hashes, and write out new ones as unsigned.

Right. Nobody seems to actually care about the hash, as far as I can tell.

It's used for that corruption check. And it is used by
ext4_xattr_block_cache_find() to basically reuse a cached entry, but
it has no actual semantic meaning.

>  That might work,
> though e2fsprogs would need to be fixed too, and old versions of e2fsck would
> corrupt xattrs unless a new ext4 filesystem feature flag was added.

The thing is, ef2progs NEEDS TO BE FIXED REGARDLESS!

You don't seem to realize that this is a fundamental filesystem bug.

It was not introduced by "-funsigned-char". It's been there for decades.

Re-introducing the "let's try to hide this bug" logic like your patch
does is disgusting and actively wrong.

This bug needs to be *fixed*.

And since we don't seem to have a "this filesystem uses stupid signed
hash arithmetic" flag (the EXT2_FLAGS_SIGNED_HASH only covers the
filename case), and since nobody actually cares, the best option seems
to be to just do what the code should have done originally, ie not
rely on 'char' being sign-extended.

A simpler patch would be to actually just entirely remove the check of
the e_hash value entiely, ie just this:

-               if (e_hash != entry->e_hash)
-                       return -EFSCORRUPTED;

and just say that the hash was always broken and the test for a random
value is not worth it.

              Linus
