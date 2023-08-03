Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF45376DDB8
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 03:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjHCB4I (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Aug 2023 21:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjHCBzd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Aug 2023 21:55:33 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B3430C3;
        Wed,  2 Aug 2023 18:53:30 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-403a7066bc8so3398521cf.0;
        Wed, 02 Aug 2023 18:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691027609; x=1691632409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0cfSRMb8E/+IOlL1DpOgng7tWBKa/WtU2bVBsu5NVs=;
        b=FN5rFUW+KXuu0m3Py0CHFvdzPZcji2S44jP87NoaMpyvxq2vKRO52t0046rq8GQcSS
         6d15lUfaULnoEy3hadtHg91rYLEtoXbf3cKQlq8EPv0iDi1qbTKfqt2qHN8OSVSs4i4z
         Sxp83MJcGi62+DYC9uY1PEr5m39cK30cEr4bK9vh4f/zPHXb3uP8JPfHSmkEYW6nGr1g
         WygUx+5GWHNGilIEOmwrRnjPZhodgpuB4aa0EedpWu1pY6GBaOJfXvs5MOpgzcsGaV72
         2QDolVX4AigKeEqmTAypzqkVIl3tCauurar4YS8vqXGq6tEUyys8ZddoC/rOfQNp5W/h
         sikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691027609; x=1691632409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0cfSRMb8E/+IOlL1DpOgng7tWBKa/WtU2bVBsu5NVs=;
        b=X074T2MdIkE65SZVeCp7+Z33tDMLJ1Hz2EwRFPY8hpF2I1tr4qPVOGn3E4CNppCLy0
         wVrcH+lAyEkv+Y/Fc6QoGRNhSVkx6Y3f7G11bGm6jUSa2NNk76UOSt60j7l+9ezTPx1l
         5gxC5FQkzJVw12KGFEK/KuW+kUjZ9b/VF7j1SXf7Qilx+kZdiHaXJtrBR4OWQ5e6Doj8
         +aw8zYpCHiugkoQXw7clM00hUUg3iaVYwy1zejZGz1c/oO8GkJyIIs6f5dFtBpDLKvX9
         PWCj0wMEXz6YbJSNmVOPOMvtyVF+KIrsnPVQCm9ypoMolS1Pb6yIx2M+/ZyHhAqdc+0L
         GDcA==
X-Gm-Message-State: ABy/qLaxsMXOR+09aDTUhQ27BV/epZ6dbx6w1gh2YL5J69WfQcUSqLPS
        MYc09M+gEVN08hHIqeS/T1kNSicwDpB7WJ3BHsU=
X-Google-Smtp-Source: APBJJlE4Y28QmAN312atRv4Dd/yMKEBK5lVckq3p0k+uvln4iVP4+z9gJ5D0U3F713BFX8Dz2cTVuIu9b1hqElbAM0U=
X-Received: by 2002:a05:622a:1495:b0:405:4043:3641 with SMTP id
 t21-20020a05622a149500b0040540433641mr24433744qtx.67.1691027609127; Wed, 02
 Aug 2023 18:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230801112337.1856215-1-zhangshida@kylinos.cn>
 <20230801151828.GB11332@frogsfrogsfrogs> <A9ECDF14-95A1-4B1E-A815-4B6ABF4916C6@dilger.ca>
In-Reply-To: <A9ECDF14-95A1-4B1E-A815-4B6ABF4916C6@dilger.ca>
From:   Stephen Zhang <starzhangzsd@gmail.com>
Date:   Thu, 3 Aug 2023 09:52:53 +0800
Message-ID: <CANubcdUsDfiuGimNXjzoAF5ki8waCoFW31mg4vjpm073rS6+dw@mail.gmail.com>
Subject: Re: [PATCH v3] ext4: Fix rec_len verify error
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Zhang Yi <yi.zhang@huawei.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zhangshida@kylinos.cn, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Andreas Dilger <adilger@dilger.ca> =E4=BA=8E2023=E5=B9=B48=E6=9C=882=E6=97=
=A5=E5=91=A8=E4=B8=89 14:07=E5=86=99=E9=81=93=EF=BC=9A
>
> Not all of these cases are actual bugs.  The ext4_rec_len_from_disk()
> function is only different for rec_len >=3D 2^16, so if it is comparing
> rec_len against "12" or "sizeof(struct ...)" then the inequality will
> be correct regardless of how it is decoded.
>
> That said, it makes sense to use ext4_rec_len_from_disk() to access
> rec_len consistently throughout the code, since that avoids potential
> bugs in the future.  We know the code will eventually will be copied
> some place where rec_len >=3D 2^16 is actually important, and we may as
> well avoid that bug before it happens.
>
>
> One thing this discussion *does* expose is that ext4_rec_len_from_disk()
> is hard-coded at compile time to differentiate between PAGE_SIZE > 64k
> and PAGE_SIZE =3D 4K, because it was never possible to have blocksize >
> PAGE_SIZE, so only ARM/PPC ever had filesystems with blocksize=3D64KiB
> (and the Fujitsu Fugaku SPARC system with blocksize=3D256KiB).
>
> However, with the recent advent of the VM and IO layers allowing
> blocksize > PAGE_SIZE this function will need to be changed to allow
> the same on x86 PAGE_SIZE=3D4KiB systems.  Instead of checking
>
>   #if PAGE_SIZE >=3D 65536
>
> it should handle this based on the filesystem blocksize at runtime:
>
> static inline
> unsigned int ext4_rec_len_from_disk(__le16 dlen, unsigned blocksize)
> {
>         unsigned len =3D le16_to_cpu(dlen);
>
>         if (blocksize < 65536)
>                 return len;
>
>         if (len =3D=3D EXT4_MAX_REC_LEN || len =3D=3D 0)
>                 return blocksize;
>
>         return (len & 65532) | ((len & 3) << 16);
> }
>
> Strictly speaking, ((len & 65532) | ((len & 3) << 16) should equal "len"
> for any filesystem with blocksize < 65536, but IMHO it is more clear if
> the code is written this way.
>
> Similarly, the encoding needs to be changed to handle large records at
> runtime for when we eventually allow ext4 with blocksize > PAGE_SIZE.
>
> static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksiz=
e)
> {
>         BUG_ON(len > blocksize);
>         BUG_ON(blocksize > (1 << 18));
>         BUG_ON(len & 3);
>
>         if (len < 65536) /* always true for blocksize < 65536 */
>                 return cpu_to_le16(len);
>
>         if (len =3D=3D blocksize) {
>                 if (blocksize =3D=3D 65536)
>                         return cpu_to_le16(EXT4_MAX_REC_LEN);
>
>                 return cpu_to_le16(0);
>         }
>
>         return cpu_to_le16((len & 65532) | ((len >> 16) & 3));
> }
>

Hmm, at least it sounds reasonable to me based on my limited
knowledge. However, I am not sure whether you want me to incorporate
these changes into this particular commit or another patch within this
submission.

By default, I will simply leave it for further discussion. Please let
me know if you have any ideas.

Cheers,
Shida

>
> Cheers, Andreas
>
>
>
>
>
