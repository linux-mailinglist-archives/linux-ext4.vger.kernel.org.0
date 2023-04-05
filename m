Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB026D7CEC
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 14:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbjDEMsA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 08:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237382AbjDEMr7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 08:47:59 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1F119BF;
        Wed,  5 Apr 2023 05:47:58 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id e13so15817902ioc.0;
        Wed, 05 Apr 2023 05:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680698878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyxlli4loMWMsjs2bBWeBBekdCpq1Dl8CfbkDwzwlrI=;
        b=ouBFXzbW70/BFgL6IPPBJcFQJIk2Arypw/45lLL3CbwqM69FBOjqKkelnLKibGtls1
         aH7dJfXVJXz/ZmZFErsAjWdZws5BH0Pe2f1ag9VMrw1hinL9cA3Tk2t9Mk73OipZ7WHv
         SEHf5bc/NKocj4TrH2Blc/5WQ2si5GdxPzk60lP6l/4mJWN0gDMHpMFXYRQAUhbX5dvy
         phYdtwnzs+ViAGzO7mxiGX/K1bWu+xgzwo/V91/hlnPkLRdKzAtqKnzB3hPQWfT8niQy
         oof50QOdbuz+r6CxvgOajWW55XkIu15mGX0UQ8f6Zi3p4qiv8AeAFz5XAmxTFfeneSUs
         bghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680698878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyxlli4loMWMsjs2bBWeBBekdCpq1Dl8CfbkDwzwlrI=;
        b=0hyt8lQyOBf2ihK4Ol97jV2k29DHYcmNvx4usVYZ9Ois7/MDUwez/PlfB3YHT1Gzbq
         oukFaArnO1ZWPmmDsmLOz4QqUYXJFNHFeN+LxH8Gn7mmyNqXxSEIgvVOwsvAhsHpyajl
         jtInG65M1V+TeN9DACL5/w2D10XjeyEQYob5zmqnw3siQzKGtA/REaPO7+WupWA1HF49
         C1/KE35amQOdd2qcAqQMkGogtxAc9lMngNm2O06ZfmpVGEWJWPm6ip5ctuzwa+gDnBiz
         DMH95DIM03zsGddtN6Ov7ZxxKoq5bTjYbmpRm5XiEspjgleSyhcy6PTWb3A5UL8hkL2Y
         AK0Q==
X-Gm-Message-State: AAQBX9fNbgf5NU4RsBgiOCj7Ub5vKzysH6QlM+xLBGl7ANdqqMxVY1i1
        4B4OC5ApVm2mUeLgdnA5NoBIJqFoyGOs6d4V5kQ9zenIkGsmaQ==
X-Google-Smtp-Source: AKy350Y6fJIvyeE3iCR8wbzTrNfQxZR+kJ6f+zxi6P0lYBVeFnajitAnB+GVpjTzuzxaeb6jNU1ZyjpM82GgSyzyR+0=
X-Received: by 2002:a02:7359:0:b0:3a7:e46e:ab64 with SMTP id
 a25-20020a027359000000b003a7e46eab64mr3333498jae.1.1680698878222; Wed, 05 Apr
 2023 05:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230403135304.19858-1-wuchi.zero@gmail.com> <ZC0J6I1pYNZBB30y@infradead.org>
 <CA+tQmHA_3_Oc-0AQ0a29DTwU4mkEqhOiAE6gXa4Ly4gZGpn5Vw@mail.gmail.com> <d04ead6617314074b297c10458010d6b@AcuMS.aculab.com>
In-Reply-To: <d04ead6617314074b297c10458010d6b@AcuMS.aculab.com>
From:   chi wu <wuchi.zero@gmail.com>
Date:   Wed, 5 Apr 2023 20:47:47 +0800
Message-ID: <CA+tQmHAwRNxvH+BBA60BdSoVYxK+NzzNyP6TW2Y_gsaWAhu9iQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: simplify 32bit calculation of lblk
To:     David Laight <David.Laight@aculab.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "ojaswin@linux.ibm.com" <ojaswin@linux.ibm.com>,
        "ritesh.list@gmail.com" <ritesh.list@gmail.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

David Laight <David.Laight@aculab.com> =E4=BA=8E2023=E5=B9=B44=E6=9C=885=E6=
=97=A5=E5=91=A8=E4=B8=89 19:43=E5=86=99=E9=81=93=EF=BC=9A
>
> From: chi wu
> > Sent: 05 April 2023 09:48
> >
> > Christoph Hellwig <hch@infradead.org> =E4=BA=8E2023=E5=B9=B44=E6=9C=885=
=E6=97=A5=E5=91=A8=E4=B8=89 13:40=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Mon, Apr 03, 2023 at 09:53:04PM +0800, wuchi wrote:
> > > > -                     if (block > ext_block)
> > > > -                             return ext_pblk + (block - ext_block)=
;
> > > > -                     else
> > > > -                             return ext_pblk - (ext_block - block)=
;
> > > > +                     return ext_pblk + ((signed long long)block - =
(signed long long)ext_block);
> > >
> > > And what exactly is the value add here, except for turning an easy
> > > to parse statement into a complex expression using casts?
> > >
> > Yes=EF=BC=8Cit will be more complex. the original intention is to reduc=
e the
> > conditional branch.
>
> What is wrong with just:
>         return ext_pblk + block - ext_block;
> (64bit + 32bit - 32bit)
>
oh, It's my fault. I am trapped in that ext_pblk + block may overflow,
but it is ok here. thanks.
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)
