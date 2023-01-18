Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007FE67129C
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jan 2023 05:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjARE1o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Jan 2023 23:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjARE1n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Jan 2023 23:27:43 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71498196BC
        for <linux-ext4@vger.kernel.org>; Tue, 17 Jan 2023 20:27:41 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id i12so23090430qvs.2
        for <linux-ext4@vger.kernel.org>; Tue, 17 Jan 2023 20:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qAth6cUkdo5cj913OjjogBmB6+0SV0aQJTrezUW/6nA=;
        b=XloxRaFo8tA83mEkCX4VnQb/z4BWFnCM30wQV53IsBml75NKFmne2+Kk2kUYoZyxTg
         9WgtMS5wo0xkSvmnQJXEh6v2cqr7/MyNg6Raj8CIeLBJraQoWQdvksF/r2V1lsuhd8bf
         AHEnNo9axQaqsf0D3Wt9UbMtPmSYruOM35MuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qAth6cUkdo5cj913OjjogBmB6+0SV0aQJTrezUW/6nA=;
        b=RCGS7UMebY6LsiywgCJGBSfxi5SV9uyZK1l71LftdjutZf2FRnUGB7aDTGrpWW4IjH
         XsqyGYiUvi6W+BLnOrhkUbfg+jxxDWb0GfYcEnpEEiVF0HZAGcRCzyIeVVTB8lC5LUPN
         bEFxVZawp0zaKppUfgBO03FHB4zXtNCtjgzBWSxmKp+W+v+NpDj/A7lyQxpIaybgQ8Lr
         bcMKZrCoRFupGySuTrUojwYWt86b5Ku2XiJ/c1PGJw90erjl94/agvSXFQG0FaT7Kx/l
         jlWR+/GW7r1VQE/AFCOnhoicuBhOTvBrLOV+X3K2J4coNN/1jeztUrphxLfCsIfDk9Ry
         JkkQ==
X-Gm-Message-State: AFqh2ko48LLhEPiMByJWW/GwQN/pDSCLova8GXCzPyGTOhPQH+L30sVw
        9B3WeMW0BViVL2pLbRwgJleIyZ9M61l6kXa7
X-Google-Smtp-Source: AMrXdXsOsPLHGktXL01L8s6Ag1ouNnqrWbS2vLTUtTN0ViDMVMsgUGw+JxuLAbFPZaoxceqnTV4tkA==
X-Received: by 2002:a05:6214:3185:b0:532:32b7:b7e4 with SMTP id lb5-20020a056214318500b0053232b7b7e4mr8130414qvb.29.1674016060258;
        Tue, 17 Jan 2023 20:27:40 -0800 (PST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id q13-20020a37f70d000000b006f9ddaaf01esm5651875qkj.102.2023.01.17.20.27.39
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 20:27:39 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id l1so17279417qkg.11
        for <linux-ext4@vger.kernel.org>; Tue, 17 Jan 2023 20:27:39 -0800 (PST)
X-Received: by 2002:a05:620a:99d:b0:705:efa8:524c with SMTP id
 x29-20020a05620a099d00b00705efa8524cmr273401qkx.594.1674016059391; Tue, 17
 Jan 2023 20:27:39 -0800 (PST)
MIME-Version: 1.0
References: <Y8bpkm3jA3bDm3eL@debian-BULLSEYE-live-builder-AMD64>
 <7DE6598D-B60D-466F-8771-5FEC0FDEC57F@dilger.ca> <Y8dtze3ZLGaUi8pi@sol.localdomain>
In-Reply-To: <Y8dtze3ZLGaUi8pi@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Jan 2023 20:27:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=whUNjwqZXa-MH9KMmc_CpQpoFKFjAB9ZKHuu=TbsouT4A@mail.gmail.com>
Message-ID: <CAHk-=whUNjwqZXa-MH9KMmc_CpQpoFKFjAB9ZKHuu=TbsouT4A@mail.gmail.com>
Subject: Re: Detecting default signedness of char in ext4 (despite -funsigned-char)
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Eric Whitney <enwlinux@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: multipart/mixed; boundary="00000000000091ddf705f2823c4d"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--00000000000091ddf705f2823c4d
Content-Type: text/plain; charset="UTF-8"

On Tue, Jan 17, 2023 at 7:56 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> [Added some Cc's, and updated subject to reflect what this is really about]

Hmm.

I really hate this.

> On Tue, Jan 17, 2023 at 05:10:55PM -0700, Andreas Dilger wrote:
> > >
> > > My 6.2-rc1 regression run on the current x86-64 test appliance revealed a new
> > > failure for generic/454 on the 4k file system configuration and all other
> > > configurations using a 4k block size.  This failure reproduces with 100%
> > > reliability and continues to appear as of 6.2-rc4.
> > >
> > > The test output indicates that the file system under test is inconsistent.
> >
> > There is actually support in the superblock for both signed and unsigned char
> > hash calculations, exactly because there was a bug like this in the past.
> > It looks like the ext4 code/build is still using the signed hash functions:

So clearly ext4 is completely buggy in this respect, but this is
exactly what would happen if you just mount a disk that was written to
on (old, pre-funsigned-char) x86, and then mount it on, say, an arm
machine that has always been unsigned-char.

That was always supposed to work.

So switching to a new kernel really should just be *exactly* the same
as moving the disk to a different machine.

And that's still "supposed to just work".

And this whole "let's get it wrong, and make x86 act as if 'char' is
signed, even when it isn't" seems entirely the wrong way around.

So the bug here is that __ext4_fill_super() seems to not look at the
actual on-disk thing, but instead do

> > static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
> > {
...
> >                 else if ((i & EXT2_FLAGS_SIGNED_HASH) == 0) {
> > #ifdef __CHAR_UNSIGNED__

but at the same time this code is *exactly* the code that is trying to
deal with "oh, you moved the disk from a signed architecture to an
unsigned one".

So the above code is literally what should fix up that movement -
taking the *actual* new signedness (or lack thereof, in this case)
into account.

Now, it apparently doesn't work very well, and I suspect the reason it
doesn't work is that the xattr code doesn't actually test these
EXT2_FLAGS_SIGNED_HASH bits (and the s_hash_unsigned field value that
goes along with it).

But we should *fix* that.

Instead, the patch is self-admittedly very ugly:

> Below is one very ugly solution.  It seems to work [..]

but I really don't think it works. It just perpetuates the bug that
you can't move a filesystem from one architecture to another.

So I really think that the solution is either

 (a) just admit that ext4 was buggy, and say "char is now unsigned",
and know that generic/454 will fail when you switch from a buggy
kernel to a new one that no longer has this signedness bug.

 (b) fix ext4_xattr_hash_entry() to actually see "oh, this filesystem
was created with signed chars, and so we'll use that algorithm even
though our chars are always unsigned".

Honestly, the only actual case of breakage I have heard of is that
test, so I was hoping that (a) is simply the acceptable and simplest
solution. It basically says "nobody really cares, we're now always
unsigned, real people didn't use non-ASCII xattr names".

Anyway, here's a TOTALLY UNTESTED patch to do (b). Maybe it's entirely
broken, but I think you can see what I'm aiming for.

Comments?

                     Linus

--00000000000091ddf705f2823c4d
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ld15xcdl0>
X-Attachment-Id: f_ld15xcdl0

IGZzL2V4dDQveGF0dHIuYyB8IDQxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9mcy9leHQ0L3hhdHRyLmMgYi9mcy9leHQ0L3hhdHRyLmMKaW5kZXggN2Rl
Y2FhZjI3ZTgyLi42OWExYjhjNmEyZWMgMTAwNjQ0Ci0tLSBhL2ZzL2V4dDQveGF0dHIuYworKysg
Yi9mcy9leHQ0L3hhdHRyLmMKQEAgLTgxLDYgKzgxLDggQEAgZXh0NF94YXR0cl9ibG9ja19jYWNo
ZV9maW5kKHN0cnVjdCBpbm9kZSAqLCBzdHJ1Y3QgZXh0NF94YXR0cl9oZWFkZXIgKiwKIAkJCSAg
ICBzdHJ1Y3QgbWJfY2FjaGVfZW50cnkgKiopOwogc3RhdGljIF9fbGUzMiBleHQ0X3hhdHRyX2hh
c2hfZW50cnkoY2hhciAqbmFtZSwgc2l6ZV90IG5hbWVfbGVuLCBfX2xlMzIgKnZhbHVlLAogCQkJ
CSAgICBzaXplX3QgdmFsdWVfY291bnQpOworc3RhdGljIF9fbGUzMiBleHQ0X3hhdHRyX2hhc2hf
ZW50cnlfc2lnbmVkKGNoYXIgKm5hbWUsIHNpemVfdCBuYW1lX2xlbiwgX19sZTMyICp2YWx1ZSwK
KwkJCQkgICAgc2l6ZV90IHZhbHVlX2NvdW50KTsKIHN0YXRpYyB2b2lkIGV4dDRfeGF0dHJfcmVo
YXNoKHN0cnVjdCBleHQ0X3hhdHRyX2hlYWRlciAqKTsKIAogc3RhdGljIGNvbnN0IHN0cnVjdCB4
YXR0cl9oYW5kbGVyICogY29uc3QgZXh0NF94YXR0cl9oYW5kbGVyX21hcFtdID0gewpAQCAtNDcw
LDggKzQ3MiwyMSBAQCBleHQ0X3hhdHRyX2lub2RlX3ZlcmlmeV9oYXNoZXMoc3RydWN0IGlub2Rl
ICplYV9pbm9kZSwKIAkJdG1wX2RhdGEgPSBjcHVfdG9fbGUzMihoYXNoKTsKIAkJZV9oYXNoID0g
ZXh0NF94YXR0cl9oYXNoX2VudHJ5KGVudHJ5LT5lX25hbWUsIGVudHJ5LT5lX25hbWVfbGVuLAog
CQkJCQkgICAgICAgJnRtcF9kYXRhLCAxKTsKLQkJaWYgKGVfaGFzaCAhPSBlbnRyeS0+ZV9oYXNo
KQotCQkJcmV0dXJuIC1FRlNDT1JSVVBURUQ7CisJCS8qIEFsbCBnb29kPyAqLworCQlpZiAoZV9o
YXNoID09IGVudHJ5LT5lX2hhc2gpCisJCQlyZXR1cm4gMDsKKworCQkvKgorCQkgKiBOb3QgZ29v
ZC4gTWF5YmUgdGhlIGVudHJ5IGhhc2ggd2FzIGNhbGN1bGF0ZWQKKwkJICogdXNpbmcgdGhlIGJ1
Z2d5IHNpZ25lZCBjaGFyIHZlcnNpb24/CisJCSAqLworCQllX2hhc2ggPSBleHQ0X3hhdHRyX2hh
c2hfZW50cnlfc2lnbmVkKGVudHJ5LT5lX25hbWUsIGVudHJ5LT5lX25hbWVfbGVuLAorCQkJCQkJ
CSZ0bXBfZGF0YSwgMSk7CisJCWlmIChlX2hhc2ggPT0gZW50cnktPmVfaGFzaCkKKwkJCXJldHVy
biAwOworCisJCS8qIFN0aWxsIG5vIG1hdGNoIC0gYmFkICovCisJCXJldHVybiAtRUZTQ09SUlVQ
VEVEOwogCX0KIAlyZXR1cm4gMDsKIH0KQEAgLTMwOTEsNiArMzEwNiwyOCBAQCBzdGF0aWMgX19s
ZTMyIGV4dDRfeGF0dHJfaGFzaF9lbnRyeShjaGFyICpuYW1lLCBzaXplX3QgbmFtZV9sZW4sIF9f
bGUzMiAqdmFsdWUsCiAJcmV0dXJuIGNwdV90b19sZTMyKGhhc2gpOwogfQogCisvKgorICogZXh0
NF94YXR0cl9oYXNoX2VudHJ5X3NpZ25lZCgpCisgKgorICogQ29tcHV0ZSB0aGUgaGFzaCBvZiBh
biBleHRlbmRlZCBhdHRyaWJ1dGUgaW5jb3JyZWN0bHkuCisgKi8KK3N0YXRpYyBfX2xlMzIgZXh0
NF94YXR0cl9oYXNoX2VudHJ5X3NpZ25lZChjaGFyICpuYW1lLCBzaXplX3QgbmFtZV9sZW4sIF9f
bGUzMiAqdmFsdWUsIHNpemVfdCB2YWx1ZV9jb3VudCkKK3sKKwlfX3UzMiBoYXNoID0gMDsKKwor
CXdoaWxlIChuYW1lX2xlbi0tKSB7CisJCWhhc2ggPSAoaGFzaCA8PCBOQU1FX0hBU0hfU0hJRlQp
IF4KKwkJICAgICAgIChoYXNoID4+ICg4KnNpemVvZihoYXNoKSAtIE5BTUVfSEFTSF9TSElGVCkp
IF4KKwkJICAgICAgIChzaWduZWQgY2hhcikqbmFtZSsrOworCX0KKwl3aGlsZSAodmFsdWVfY291
bnQtLSkgeworCQloYXNoID0gKGhhc2ggPDwgVkFMVUVfSEFTSF9TSElGVCkgXgorCQkgICAgICAg
KGhhc2ggPj4gKDgqc2l6ZW9mKGhhc2gpIC0gVkFMVUVfSEFTSF9TSElGVCkpIF4KKwkJICAgICAg
IGxlMzJfdG9fY3B1KCp2YWx1ZSsrKTsKKwl9CisJcmV0dXJuIGNwdV90b19sZTMyKGhhc2gpOwor
fQorCiAjdW5kZWYgTkFNRV9IQVNIX1NISUZUCiAjdW5kZWYgVkFMVUVfSEFTSF9TSElGVAogCg==
--00000000000091ddf705f2823c4d--
