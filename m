Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D2976F7AC
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Aug 2023 04:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjHDCOD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 22:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbjHDCNf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 22:13:35 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EF54C02;
        Thu,  3 Aug 2023 19:12:39 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-790ca0ed6d3so54960239f.3;
        Thu, 03 Aug 2023 19:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691115127; x=1691719927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyGs7pDnf6uBT1t/66Ot0OwEahPTOFqgXdug+F04H8Y=;
        b=SO1hDhmmlVyVF1SLjy217wDUN6oQZyLQTUlgP+cJ0ScoZnuyX5waT8LaFCxLBzk9Oc
         qcrM6k5eDHzxcyMdqaauR0vrVzu/mWOIL/moszoT9970oByeNGKXEbo/n4EO3pt1WOz1
         r/EdU8pEKCR2XrC3uaY4NgCC1VPQqnlH9eugfjlPxuRjuz0xaJ9zdfkpukKR/PCwc2Gl
         XQm2zogt+ea8gdlOxVu1YwfIo5xyyqXqMCPD0qeuMCgY5uHhuLRl005bXZbWWt0xAsXJ
         Bc660UsmCcHkJXw+q4MY3Yrc66F7rIpUdi7pepmd5D/MNpPKMLT9gvO6BULirH3BvSWz
         I5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691115127; x=1691719927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyGs7pDnf6uBT1t/66Ot0OwEahPTOFqgXdug+F04H8Y=;
        b=Y9kbTE/Q/7hNoklQ0aQHAO8LV/8D/wvGYm0ro/cAPt1/+ZqliCJKamDZ6/khkoPw6z
         8veFn0UphvVD6U006IkZkVoFZFTtfGmVThkxC7KhDcx6uWJ5cAepZFlIlN2CyiIKRUHu
         U8W7BcZE9Jv91CCfoklSSyd4aZwRzBtIC3bl5B4yK9ytadYJucC02Ozbqt0ABwymaWAN
         um/pbXL8JwQ+4CZk+8IM7TBtHXii3YMcwarhs0aiwQEc8xsIU7T6Ez5MDI/UMLGQi+k+
         SQpd78XokYAYd9pLkWWNXyczBPjyibEdjOqIBAaqO6Ul+d55p6dcz31UpxMHbpWQQ7fJ
         F67A==
X-Gm-Message-State: AOJu0Ywb1QsDExh/bADml8u1rWb1s+7K5WUzs4HQ/XhCFxiMXjlsw02X
        FN4suTX6WxLUKvl+Dw5aJPVJ90Z5Qz6wLK4uiOFObK8c9y+ByXn/
X-Google-Smtp-Source: AGHT+IG8RLfvqEfnVXV2XhJT0AebZO+FwN68ngJKeFDdkpeiR3RdipSqjBS28QBX3/DSYE1f29DwD7MPLlAf+uB4cHg=
X-Received: by 2002:ac8:5c90:0:b0:400:aa4d:7a5d with SMTP id
 r16-20020ac85c90000000b00400aa4d7a5dmr784601qta.24.1691115106200; Thu, 03 Aug
 2023 19:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230801112337.1856215-1-zhangshida@kylinos.cn>
 <20230801151828.GB11332@frogsfrogsfrogs> <A9ECDF14-95A1-4B1E-A815-4B6ABF4916C6@dilger.ca>
 <CANubcdUsDfiuGimNXjzoAF5ki8waCoFW31mg4vjpm073rS6+dw@mail.gmail.com>
 <20230803030903.GK11377@frogsfrogsfrogs> <12CFFD6D-ED0E-4D36-A7B7-ACCFB698A177@dilger.ca>
In-Reply-To: <12CFFD6D-ED0E-4D36-A7B7-ACCFB698A177@dilger.ca>
From:   Stephen Zhang <starzhangzsd@gmail.com>
Date:   Fri, 4 Aug 2023 10:11:10 +0800
Message-ID: <CANubcdXYm9dxx6WSECWmjrF9C_8bhsiUSC-xDe-Pz3Mvy0nFmw@mail.gmail.com>
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

Andreas Dilger <adilger@dilger.ca> =E4=BA=8E2023=E5=B9=B48=E6=9C=884=E6=97=
=A5=E5=91=A8=E4=BA=94 06:34=E5=86=99=E9=81=93=EF=BC=9A
>
> On Aug 2, 2023, at 9:09 PM, Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Thu, Aug 03, 2023 at 09:52:53AM +0800, Stephen Zhang wrote:
> >> Andreas Dilger <adilger@dilger.ca> =E4=BA=8E2023=E5=B9=B48=E6=9C=882=
=E6=97=A5=E5=91=A8=E4=B8=89 14:07=E5=86=99=E9=81=93=EF=BC=9A
> >>>
> >>> Not all of these cases are actual bugs.  The ext4_rec_len_from_disk()
> >>> function is only different for rec_len >=3D 2^16, so if it is compari=
ng
> >>> rec_len against "12" or "sizeof(struct ...)" then the inequality will
> >>> be correct regardless of how it is decoded.
> >>>
> >>> That said, it makes sense to use ext4_rec_len_from_disk() to access
> >>> rec_len consistently throughout the code, since that avoids potential
> >>> bugs in the future.  We know the code will eventually will be copied
> >>> some place where rec_len >=3D 2^16 is actually important, and we may =
as
> >>> well avoid that bug before it happens.
> >>>
> >>>
> >>> One thing this discussion *does* expose is that ext4_rec_len_from_dis=
k()
> >>> is hard-coded at compile time to differentiate between PAGE_SIZE > 64=
k
> >>> and PAGE_SIZE =3D 4K, because it was never possible to have blocksize=
 >
> >>> PAGE_SIZE, so only ARM/PPC ever had filesystems with blocksize=3D64Ki=
B
> >>> (and the Fujitsu Fugaku SPARC system with blocksize=3D256KiB).
> >>>
> >>> However, with the recent advent of the VM and IO layers allowing
> >>> blocksize > PAGE_SIZE this function will need to be changed to allow
> >>> the same on x86 PAGE_SIZE=3D4KiB systems.  Instead of checking
> >>>
> >>>  #if PAGE_SIZE >=3D 65536
> >>>
> >>> it should handle this based on the filesystem blocksize at runtime:
> >>>
> >>> static inline
> >>> unsigned int ext4_rec_len_from_disk(__le16 dlen, unsigned blocksize)
> >>> {
> >>>        unsigned len =3D le16_to_cpu(dlen);
> >>>
> >>>        if (blocksize < 65536)
> >>>                return len;
> >>>
> >>>        if (len =3D=3D EXT4_MAX_REC_LEN || len =3D=3D 0)
> >>>                return blocksize;
> >>>
> >>>        return (len & 65532) | ((len & 3) << 16);
> >>> }
> >>>
> >>> Strictly speaking, ((len & 65532) | ((len & 3) << 16) should equal "l=
en"
> >>> for any filesystem with blocksize < 65536, but IMHO it is more clear =
if
> >>> the code is written this way.
> >>>
> >>> Similarly, the encoding needs to be changed to handle large records a=
t
> >>> runtime for when we eventually allow ext4 with blocksize > PAGE_SIZE.
> >>>
> >>> static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned bloc=
ksize)
> >>> {
> >>>        BUG_ON(len > blocksize);
> >>>        BUG_ON(blocksize > (1 << 18));
> >>>        BUG_ON(len & 3);
> >>>
> >>>        if (len < 65536) /* always true for blocksize < 65536 */
> >>>                return cpu_to_le16(len);
> >>>
> >>>        if (len =3D=3D blocksize) {
> >>>                if (blocksize =3D=3D 65536)
> >>>                        return cpu_to_le16(EXT4_MAX_REC_LEN);
> >>>
> >>>                return cpu_to_le16(0);
> >>>        }
> >>>
> >>>        return cpu_to_le16((len & 65532) | ((len >> 16) & 3));
> >>> }
> >>>
> >>
> >> Hmm, at least it sounds reasonable to me based on my limited
> >> knowledge. However, I am not sure whether you want me to incorporate
> >> these changes into this particular commit or another patch within this
> >> submission.
> >>
> >> By default, I will simply leave it for further discussion. Please let
> >> me know if you have any ideas.
> >
> > ext4 doesn't support blocksize > PAGE_SIZE yet.  Don't worry about this
> > for now.
>
> I agree it doesn't need to be merged into the current patch.
>
> It's something that could be fixed in a follow-on patch, to have one less
> bug to fix in the future when ext4 *does* support blocksize > PAGE_SIZE,
> which isn't so far away anymore.
>

Okay, I will attempt to submit another follow-on patch based on this discus=
sion
after this one.

Cheers,
Shida

> Cheers, Andreas
>
>
>
>
>
