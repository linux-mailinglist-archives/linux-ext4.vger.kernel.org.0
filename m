Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83316679F2C
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Jan 2023 17:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbjAXQuy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Jan 2023 11:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjAXQux (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Jan 2023 11:50:53 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DFD46730
        for <linux-ext4@vger.kernel.org>; Tue, 24 Jan 2023 08:50:53 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id h24so9632670qta.12
        for <linux-ext4@vger.kernel.org>; Tue, 24 Jan 2023 08:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mcOp8zyil3pWriy3DlCZcCWX0BKo/EQlllqJn2itDhU=;
        b=XMZnv57FFlW/8DP3GzKZcYJqtSAnU3ltiqRs6kOnzb17LLhdNsdByR1qsb8V3yCLoA
         kjvzL/UvnIRGMd/l9mcFro/sBo7GgSoD0e10N1GFRA/d9FuooB5NTGtdjWBfrRQDKnc5
         nJWZx6FDnJynmGWBFKYJ+K5RTU4ljksQee4ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcOp8zyil3pWriy3DlCZcCWX0BKo/EQlllqJn2itDhU=;
        b=pNmEgcC6bFpkKu/SdqxTpeBB5FBRWul7hPCL42aRbPnOwaPT/w4QfLrQc472HoF1xv
         P9T54032lqy0awaRji/ey6J7oavBb/rqProigVlOOk6gB6/k6wBkmUGe8dVWpDl6KafA
         CEUtj+UEFQNvKjYn1/zUYEkenH1xigAVUavRv301++BCaGsru8erqVRyDFUO1GhoVUIy
         8Ncbr8vJX5Bv2rIIHsE+F/8cQmJVnzWU9UD6TPzj5A3o8JjFWzkjMXIlAM3Z8n3JVNx/
         JD8JCLPoR8saZ8QyZ79qKj/aOhr/CS2KZ5eWEyU5F2Libd4HA/q+wCQBpQywW8lsUV4R
         R1Yg==
X-Gm-Message-State: AFqh2kpLGi6sVG2ntrjKbFwm7EiUhCMeJGiojPZKaFW2oKbIKkvRmMVT
        Ck89gCFc+RGiDn0Ma8PmIvUMeQFhaJwCEG+q
X-Google-Smtp-Source: AMrXdXufamYzn+jcwJbE/1BsHLOUXAtVxpe8BQ4C57Z99jkKY47hvq8HTTuCuOq4anCf/CLpcaO6sA==
X-Received: by 2002:ac8:7517:0:b0:3b6:98c7:48fd with SMTP id u23-20020ac87517000000b003b698c748fdmr26343488qtq.15.1674579052061;
        Tue, 24 Jan 2023 08:50:52 -0800 (PST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com. [209.85.222.171])
        by smtp.gmail.com with ESMTPSA id z18-20020ac86b92000000b003a7eb5baf3csm1510319qts.69.2023.01.24.08.50.50
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 08:50:51 -0800 (PST)
Received: by mail-qk1-f171.google.com with SMTP id pj1so8461857qkn.3
        for <linux-ext4@vger.kernel.org>; Tue, 24 Jan 2023 08:50:50 -0800 (PST)
X-Received: by 2002:a05:620a:144a:b0:6ff:cbda:a128 with SMTP id
 i10-20020a05620a144a00b006ffcbdaa128mr1503997qkl.697.1674579050396; Tue, 24
 Jan 2023 08:50:50 -0800 (PST)
MIME-Version: 1.0
References: <20230124134131.637036-1-sashal@kernel.org> <20230124134131.637036-35-sashal@kernel.org>
In-Reply-To: <20230124134131.637036-35-sashal@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Jan 2023 08:50:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjZmzuHP10Trg_7EBnix4mFLfODPM+FsZz0Jjj+YAFDeg@mail.gmail.com>
Message-ID: <CAHk-=wjZmzuHP10Trg_7EBnix4mFLfODPM+FsZz0Jjj+YAFDeg@mail.gmail.com>
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

On Tue, Jan 24, 2023 at 5:42 AM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Linus Torvalds <torvalds@linux-foundation.org>
>
> [ Upstream commit f3bbac32475b27f49be201f896d98d4009de1562 ]
>
> We potentially have old hashes of the xattr names generated on systems
> with signed 'char' types.  Now that everybody uses '-funsigned-char',
> those hashes will no longer match.

This patch does not work correctly without '-funsigned-char', and I
don't think that has been back-ported to stable kernels.

That said, the patch *almost* works. You'd just have to add something
like this to it:

  --- a/fs/ext4/xattr.c
  +++ b/fs/ext4/xattr.c
  @@ -3096,7 +3096,7 @@ static __le32 ext4_xattr_hash_entry(char *name,
        while (name_len--) {
                hash = (hash << NAME_HASH_SHIFT) ^
                       (hash >> (8*sizeof(hash) - NAME_HASH_SHIFT)) ^
  -                    *name++;
  +                    (unsigned char)*name++;
        }
        while (value_count--) {
                hash = (hash << VALUE_HASH_SHIFT) ^

to make it work right (ie just make sure that the proper xattr name
hashing actually uses unsigned chars for its hash).

                    Linus
