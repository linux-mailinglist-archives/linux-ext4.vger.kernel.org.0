Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3B06E4E17
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Apr 2023 18:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjDQQRL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Apr 2023 12:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDQQRK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 Apr 2023 12:17:10 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E5C6A4C
        for <linux-ext4@vger.kernel.org>; Mon, 17 Apr 2023 09:17:08 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2a7b08e84d4so14590821fa.3
        for <linux-ext4@vger.kernel.org>; Mon, 17 Apr 2023 09:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681748226; x=1684340226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXGtyJiWtoor+2MwUYhcXkVZ+5EZ3EsF+B7ahIBNuno=;
        b=y/JpPgtwiZRwEbBf5R0/ZsikXHM3t1Dh9Jsqc5nvo+UydBKIebKYaSJBw4nGDQprij
         PETbcmsb+l+I20/hfyVGgdaAs+TVPCfhEqriws9VlDfcSpwXNdrZipY5ul/+ltmXxd/I
         1vp/SG3NH58L7a6zk+VZu7gW5ywG311Ty9Hu+VtfNdTqGlav8tbdoXoKzbwcTUooFEti
         XzMOb+WiDQPLuvsY08pDxdN9N4T4RnzOd/sen2najgLH+euun1i/7vyLpAPDE4I3rH0M
         oU5+CQOAuUrSSK6Yh2VRddwVfmLmihy9AqQAw8IeBmlSoOaZTqvHpkVWe4ku4cSQu3Sl
         LIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681748226; x=1684340226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXGtyJiWtoor+2MwUYhcXkVZ+5EZ3EsF+B7ahIBNuno=;
        b=TtoQ3sNynWOMNTaQS4xQd18ycaQoU1ExeXCEb+84rZ3XXyl/TJqAHQ6PkYyxT2MFln
         Fd/4N7rpq2p2VVX5NMBA9bUzBrbSqGVQvBBXkvRX7S0UtVsC97tl0DQnze/2ZLXxsi9z
         B8K5PhlJkCxlegkJFd0e4JeZfTB2+AmiBe6vEpBS2mXiPmPeyxZtmp6/uTJACAYQs1AE
         +Pgrt0tIsrIL237KUKhpW+a7PzaJCbOdQoxzODLPMtpZ0UKHmVvXzyHuIWsvPUdcB18u
         Kcyr60ns1UjJ+IvWa5y+ZLiGjcAgDIPHMc5GKMq5nl7WVrQAKSYMfFponoCHe2xXhiQV
         omVw==
X-Gm-Message-State: AAQBX9fGrju8/HHTRcJwNvQcMzEOav9awc6ZFrLdeM10Fn3MPe3kQ9jR
        b8toDFVbKiLdHv4nDPcrmQhsTZtMLxArRwcCejXRqQ==
X-Google-Smtp-Source: AKy350Y23w3gx1mvBvKKUWP6MgosMbP+t6Bs+J+DFv8aF/EGEkIl5cRGukXuxmVc0QHyEKwShgkN2OU8GlSyD73oDLg=
X-Received: by 2002:ac2:53b3:0:b0:4ea:2dce:fa0a with SMTP id
 j19-20020ac253b3000000b004ea2dcefa0amr2282605lfh.10.1681748226362; Mon, 17
 Apr 2023 09:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAFDdnB0a3mfcoY7rg5N4dO13qMeSsV+PkA2YHeerEOFRv8484Q@mail.gmail.com>
 <YpQixl+ljcC1VHNU@mit.edu> <CAFDdnB1WxrqddeLJwjsqqgoij1q_QGa=SBs-i=j31W2QbksJ=Q@mail.gmail.com>
 <YpVeeKRH1bycP7P1@mit.edu> <YpVxYchs1wScNRDw@mit.edu> <CAFDdnB1KJVSXXzXKOc+T+g1Qewr11AS4f9tFJqSMLvfpiX-5Lg@mail.gmail.com>
 <YpjNf8WGfYh31F+2@mit.edu> <ZDnbW1qYmBLycefL@google.com> <20230416054742.GA5427@lst.de>
 <ZDuOB8We29IAYR/4@infradead.org> <ZDy8Tcp9Z/GILVRI@mit.edu>
In-Reply-To: <ZDy8Tcp9Z/GILVRI@mit.edu>
From:   Will McVicker <willmcvicker@google.com>
Date:   Mon, 17 Apr 2023 09:16:49 -0700
Message-ID: <CABYd82ZX_HPrUONwNp+=A_zUa1m15PPnJcjO=BCsWZeVLVzf=Q@mail.gmail.com>
Subject: Re: simplify ext4_sb_read_encoding regression
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        "Stephen E. Baker" <baker.stephen.e@gmail.com>,
        adilger.kernel@dilger.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Apr 16, 2023 at 8:26=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> On Sat, Apr 15, 2023 at 10:56:23PM -0700, Christoph Hellwig wrote:
> > On Sun, Apr 16, 2023 at 07:47:42AM +0200, Christoph Hellwig wrote:
> > > We could do that, but it seems a bit ugly.  What prevents symbol_requ=
est
> > > from working properly for this case in your setup?
> >
> > To anwer to myself - I guess we need something else than a plain
> > EXPORT_SYMBOL for everything that is used by
> > symbol_request.  Which would be a nice cleanly anyway - exports for
> > symbol_request aren't normal exports and should probably have a clear
> > marker just to stand out anyway.
>
> Agreed, that's the best/cleanest long-term solution.
>
> The short-term hack that William could use in the interim would be to
> simply configure CONFIG_UNUSED_KSYMS_WHITELIST to include
> 'utf8_data_table', which will solve his immediate problem without
> needing to maintain an out-of-tree patch in his kernel.
>
> Presumably, that's what the long-term solution would effectively do,
> except it would be automated as opposed to requiring people who use
> CONFIG_TRIM_UNUSED_KSYMS to have to do manually.  Note also that there
> are only a half-dozen or so such symbols in the Linux kernel today, so
> while we could and probably should automate it, it's not clear to me
> the number of use cases where CONFIG_TRIM_UNUSED_KSYMS is going to be
> relevant are very likely quite small.  (The only ones I can think of
> are the Android Generic Kernel Image and for enterprise Linux
> distributions.  And in both cases, I suspect those use cases will
> probably have a very large list of symbol added to the allow list, so
> adding those few extra symbols is probably going to be in the noise.
>
>                                                 - Ted

Thanks for the responses! I was missing the part that utf8-core.c is always
built into the kernel when CONFIG_UNICODE is enabled. So it makes sense
to me why we need to use symbol_request() vs just EXPORT_SYMBOL. It
should be fine for us to include this symbol in our symbol list.

Thanks,
Will
