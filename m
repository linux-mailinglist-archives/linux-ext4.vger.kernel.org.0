Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9394C67A014
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Jan 2023 18:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjAXRYR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Jan 2023 12:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbjAXRYQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Jan 2023 12:24:16 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B4649011
        for <linux-ext4@vger.kernel.org>; Tue, 24 Jan 2023 09:24:15 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id a25so13653569qto.10
        for <linux-ext4@vger.kernel.org>; Tue, 24 Jan 2023 09:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YpHopE2ZPOxbhd78MKx6My/SyU6gg1nJCvHGtO4kRJ0=;
        b=dft5SOzhAdOiwh0GEt4UMrIANEnHSFvkqGOXxRvmV64KB9t7imcdz8WvnLPflsnAsz
         CwwNfy7URBWJryFH22WZYz88yd/VAgsW7WM5ERkPmwOdSXV/lj+dQmaYBQ0X7knaqrt9
         wPA2UIxmyEDk49ib5qUh8FPv4czQ2cxT6kvMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpHopE2ZPOxbhd78MKx6My/SyU6gg1nJCvHGtO4kRJ0=;
        b=7049Pluv/pb4EzOGcSI3smGt1eRaZOVBLuPSbKadoZAwEMeY48QFM6PADfp1RlWyZr
         STO9PRf1nICaeiI5ltth+IpZMB3ByLcCQMsFQKVDbJfhyI6GxyL2IZYX1Vhn/wSZLnqo
         D2J/+VaRrGohPxgGOXEHeqEIB+H8RBICudY7005uBOnekwj9lTPRDRrSAjnD+c5mjFi4
         T/zMPciDWek5Yy3dqOTJ2ypU+wW+I8ks/v883E6WIlsgA2OIiawHfUeKRcXX2INDF3cF
         ysBi8rp9UuEdEtZ37dTR/admlOKqLKJXox/buvuxsy2TAIKhGG9qQ2v7Whiq+GkbOoAN
         /+WQ==
X-Gm-Message-State: AFqh2krkJvf6ewP/OV6M/PxMDwj62bDCokBFoZN5fwdaVRFcg7/VqTsW
        l8e7UpaCL/6PwBtGnz142vJvM9Yb4BJ3bV8W
X-Google-Smtp-Source: AMrXdXvzPoupX1eWUXZ3mMCX6THM1qvrFnVTzpjZH+M8nixn4dCJVfxSVK5VBiWPUYpb+mDleF1Mfw==
X-Received: by 2002:a05:622a:5c8c:b0:3a9:7e3f:2646 with SMTP id ge12-20020a05622a5c8c00b003a97e3f2646mr47219261qtb.11.1674581054188;
        Tue, 24 Jan 2023 09:24:14 -0800 (PST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com. [209.85.219.43])
        by smtp.gmail.com with ESMTPSA id z25-20020ac875d9000000b003b6382f66b1sm1563813qtq.29.2023.01.24.09.24.13
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 09:24:13 -0800 (PST)
Received: by mail-qv1-f43.google.com with SMTP id h10so12120762qvq.7
        for <linux-ext4@vger.kernel.org>; Tue, 24 Jan 2023 09:24:13 -0800 (PST)
X-Received: by 2002:a05:6214:5504:b0:535:2538:c972 with SMTP id
 mb4-20020a056214550400b005352538c972mr1495160qvb.43.1674581052894; Tue, 24
 Jan 2023 09:24:12 -0800 (PST)
MIME-Version: 1.0
References: <20230124134131.637036-1-sashal@kernel.org> <20230124134131.637036-35-sashal@kernel.org>
 <CAHk-=wjZmzuHP10Trg_7EBnix4mFLfODPM+FsZz0Jjj+YAFDeg@mail.gmail.com>
In-Reply-To: <CAHk-=wjZmzuHP10Trg_7EBnix4mFLfODPM+FsZz0Jjj+YAFDeg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Jan 2023 09:23:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi5GPS3poC_YRy93X38AqkvsFENAviMXHWjgOgo5k7p3g@mail.gmail.com>
Message-ID: <CAHk-=wi5GPS3poC_YRy93X38AqkvsFENAviMXHWjgOgo5k7p3g@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.1 35/35] ext4: deal with legacy signed xattr
 name hash values
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger@dilger.ca>,
        "Theodore Ts'o" <tytso@mit.edu>, Jason Donenfeld <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ce80af05f305c800"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--000000000000ce80af05f305c800
Content-Type: text/plain; charset="UTF-8"

On Tue, Jan 24, 2023 at 8:50 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This patch does not work correctly without '-funsigned-char', and I
> don't think that has been back-ported to stable kernels.
>
> That said, the patch *almost* works.

So I'm  not convinced this should be back-ported at all, but it's
certainly true that going back and forth between the two cases would
be problematic.

Maybe the right thing to do would be for me to just do that explicit
'unsigned char' even in kernels that don't need it, and also add a
'pr_warn_once()' to make people aware of this case if it ever happens
outside of the xfstests.

So a more complete patch might be something like the attached (which
also changes the polarity of the signed hash test, in order to make
the pr_warn_once() simpler).

            Linus

--000000000000ce80af05f305c800
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ldaib7gp0>
X-Attachment-Id: f_ldaib7gp0

IGZzL2V4dDQveGF0dHIuYyB8IDExICsrKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2V4dDQveGF0dHIuYyBi
L2ZzL2V4dDQveGF0dHIuYwppbmRleCA2OWExYjhjNmEyZWMuLmEyZjA0YTM4MDhkYiAxMDA2NDQK
LS0tIGEvZnMvZXh0NC94YXR0ci5jCisrKyBiL2ZzL2V4dDQveGF0dHIuYwpAQCAtNDgyLDExICs0
ODIsMTIgQEAgZXh0NF94YXR0cl9pbm9kZV92ZXJpZnlfaGFzaGVzKHN0cnVjdCBpbm9kZSAqZWFf
aW5vZGUsCiAJCSAqLwogCQllX2hhc2ggPSBleHQ0X3hhdHRyX2hhc2hfZW50cnlfc2lnbmVkKGVu
dHJ5LT5lX25hbWUsIGVudHJ5LT5lX25hbWVfbGVuLAogCQkJCQkJCSZ0bXBfZGF0YSwgMSk7Ci0J
CWlmIChlX2hhc2ggPT0gZW50cnktPmVfaGFzaCkKLQkJCXJldHVybiAwOwotCiAJCS8qIFN0aWxs
IG5vIG1hdGNoIC0gYmFkICovCi0JCXJldHVybiAtRUZTQ09SUlVQVEVEOworCQlpZiAoZV9oYXNo
ICE9IGVudHJ5LT5lX2hhc2gpCisJCQlyZXR1cm4gLUVGU0NPUlJVUFRFRDsKKworCQkvKiBMZXQg
cGVvcGxlIGtub3cgYWJvdXQgb2xkIGhhc2ggKi8KKwkJcHJfd2Fybl9vbmNlKCJleHQ0OiBmaWxl
c3lzdGVtIHdpdGggc2lnbmVkIHhhdHRyIG5hbWUgaGFzaCIpOwogCX0KIAlyZXR1cm4gMDsKIH0K
QEAgLTMwOTYsNyArMzA5Nyw3IEBAIHN0YXRpYyBfX2xlMzIgZXh0NF94YXR0cl9oYXNoX2VudHJ5
KGNoYXIgKm5hbWUsIHNpemVfdCBuYW1lX2xlbiwgX19sZTMyICp2YWx1ZSwKIAl3aGlsZSAobmFt
ZV9sZW4tLSkgewogCQloYXNoID0gKGhhc2ggPDwgTkFNRV9IQVNIX1NISUZUKSBeCiAJCSAgICAg
ICAoaGFzaCA+PiAoOCpzaXplb2YoaGFzaCkgLSBOQU1FX0hBU0hfU0hJRlQpKSBeCi0JCSAgICAg
ICAqbmFtZSsrOworCQkgICAgICAgKHVuc2lnbmVkIGNoYXIpKm5hbWUrKzsKIAl9CiAJd2hpbGUg
KHZhbHVlX2NvdW50LS0pIHsKIAkJaGFzaCA9IChoYXNoIDw8IFZBTFVFX0hBU0hfU0hJRlQpIF4K
--000000000000ce80af05f305c800--
