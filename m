Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB562770A91
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Aug 2023 23:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjHDVJy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Aug 2023 17:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjHDVJf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Aug 2023 17:09:35 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828754ED7
        for <linux-ext4@vger.kernel.org>; Fri,  4 Aug 2023 14:08:36 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-486519e5da0so732417e0c.2
        for <linux-ext4@vger.kernel.org>; Fri, 04 Aug 2023 14:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691183306; x=1691788106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVz5LOd7rFNebtEp0PzxoQs26sxvmIdzCmYSzMm7FxE=;
        b=KsbTLP2r5B1Ip7gQd7ivaKr/7l8+hfTDIl+lx6U6uYM/4/HV0a+vCdcDyn8iE/t6V+
         bg8Y3yJ/bUwwPf4MTzojKp8SnUkZwYshmcqFVT499N0Ndma0HhfuIQ/bzXaGn2pFoLX8
         eayrMN/w9Cd+rOq2XagJZJT+khhqN7Tod2IiY1zFIkB+fw6+0t58u66PwtoJmTVgPpOd
         p//II1NnrkPTMiNYZ/kvdSYaF8Y+Hmo61f+Gr5z0arDIlMZtkROIuQ8NNcd6sd7zDIFt
         ybdDQmbLqtnXQGPB1iHZNAwuOeBAvdLKC0JUg7c+Ul86w01JYI0xQ7DX8Wsm6zWM2q0q
         ltpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691183306; x=1691788106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVz5LOd7rFNebtEp0PzxoQs26sxvmIdzCmYSzMm7FxE=;
        b=kBGf6ri0xBhfmMEn9P6Fa+0/rXFjtbKQY0IiME1+0nqX9I26BzOWoTcPZdGVqWHUwA
         8hX6lvR78iQ6UaIQcLJPcqkHMw/ZnnH71yxwZIAFSNDRmfNs2McZDC1H1CHHmKbZurgY
         GAl2uEXSzZKovqypmAypevn5C6lsr8sy4lvNDThmCgqUx0gW9znLUYopgn70lQxmgrfB
         uOf8mP+Xgzo2xxNj/9TspBmb4SAQE6TV8BG201TTjtjV1iv9Nikb9M7D+K+oscFM6Jo9
         WcBFP/PtENatckHeShtCdz0ejCcEfjvC01SGIuCXIEMQxVZikMZnVddvKg/T1/Ziofdg
         9tgw==
X-Gm-Message-State: AOJu0Yxt0DdzYGPz+1kJPs7b8v24wz+AD+nrISVBB+sAWRvrziye1dWJ
        hobfrQ6cclPTeSLIFulOPJ1za0iNH3Vtg0qmtn4k5T0StWdS3g==
X-Google-Smtp-Source: AGHT+IHD7nW3H+MMkRzQLgvxuvBe4t9aTUNU0YK3dilWOUpr86C7qulqhKPCt8Ko0ib/ImOCnDOvgIUL5iDyr2HJbMc=
X-Received: by 2002:a1f:3f11:0:b0:487:11ba:45fc with SMTP id
 m17-20020a1f3f11000000b0048711ba45fcmr1630690vka.13.1691183306272; Fri, 04
 Aug 2023 14:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAKbZUD01uR5kfP4=SSfQ111jKsfKi8ojfDZs5CStLD_h5qb5GQ@mail.gmail.com>
 <20230628045206.GA1908@sol.localdomain> <20230628185832.GK11467@frogsfrogsfrogs>
 <20230703194850.GF1194@sol.localdomain>
In-Reply-To: <20230703194850.GF1194@sol.localdomain>
From:   Pedro Falcato <pedro.falcato@gmail.com>
Date:   Fri, 4 Aug 2023 22:08:13 +0100
Message-ID: <CAKbZUD0ModY66yJ+ieAs=XYecMHc-X2=Sanxcv8wmSf0T=BSzQ@mail.gmail.com>
Subject: Re: Question regarding the use of CRC32c for checksumming
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 3, 2023 at 8:48=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> w=
rote:
>

Hi folks, really sorry for the big delay, this thread really slipped my min=
d :)

> IMO the best API for CRC's is like zlib's where you pass in 0 to start th=
e CRC
> and it does both the pre and post inversions for you.  Note, "updates" st=
ill
> work as expected, since two inversions cancel each other out.

I agree, I did that when adding CRC32c to EFI. u32
calculate_crc32c(const void *buf, size_t len, u32 initial) with
inversions on initial and the result is pretty simple and effective.

> Unfortunately, many but not all of the CRC APIs in Linux decided to go wi=
th the
> other convention, which is to leave the inversions entirely to the caller=
.
>
> I think the kernel should also make the architecture-specific CRC
> implementations accessible directly via a library API, similar to what's =
done
> for Blake2s and ChaCha20.  There should be no need to go through shash at=
 all...
>
> >
> > This misuse could be fixed, but you'd have to burn an incompat flag to
> > do it.  I'm less smart about crc32* than I was back in 2008, so I also
> > don't have the skills to figure out if the correction is worth the cost=
.
> >
> > --D
>
> No, it's not worth changing the ext4 on-disk format for this.

I don't think we'd need to change the on-disk format for this? Or for
any other hash algorithm change (as long as the resulting digest is
32-bit), right? Given we have s_checksum_type.
Or do existing tools dangerously assume CRC32c at the moment?

In any case, thank you both for the background on this, I'll try to
submit a patch to the docs to clarify this point.

--=20
Pedro
