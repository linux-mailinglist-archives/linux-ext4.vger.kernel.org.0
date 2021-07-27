Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475AE3D7098
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jul 2021 09:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbhG0Htp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Jul 2021 03:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbhG0Htm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Jul 2021 03:49:42 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95A0C061757
        for <linux-ext4@vger.kernel.org>; Tue, 27 Jul 2021 00:49:41 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f13so4344885plj.2
        for <linux-ext4@vger.kernel.org>; Tue, 27 Jul 2021 00:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=+3JvafhZCH8TZWKomg0uqXG1bvgEevjb8wKhko5EO6k=;
        b=YOSsePFDyTkD14nCNTvcxdTt7J9lGhGaKW1dK6/1FGm/BqY7O5+kVWCEdhr8G8MWwj
         ExbbyO68yhY+CfB7xqZzU+QUY8Nijg2uHp4NiMUdtnoGd3X6Kc0CwB8H+AqitWVxy47E
         NZxGZZ82reHW27HzcRineQGRdYJB2Rt4D5o47ij5pXTO/mJbuwxfxMkn0EG6c673/zKr
         VWcaO7ZGKrNk7bR90jAqoBniEnTbA2Z3sPEN6W1qm7RtYi/J5DE3k7BWJhFLQwLdCv8Q
         AdOjHeT+UM/3RCxA69rMTpZnhObSROO35XT7atsC+IERfdFhFT9Vu7MRmGXr1fkRLjtj
         kciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=+3JvafhZCH8TZWKomg0uqXG1bvgEevjb8wKhko5EO6k=;
        b=r99tY4D5m+aVkADSGkU625HFUfQsg5Ghv8mRH6O0u3DWyD3e4f03htu1k+fTrNjwEx
         FVLc6TNhhwpgnOoT6m74zI2qwy/YJ6ODyQW1wU9+WwiNs1CqeFQbOXyLHul18fS3rYQm
         c/zeHUZwIS/x5mTOYxb3Q4gD24HHiif+361a7yyfJqhLi3i16eJeBbBcwWgzToB+JP/C
         RJ8LIC8CA4wK0PR7J7bO0tpC30s7WfNJ57/d7GaXkUDYc+qvYpWCToLvO4ZXSXZkXCjD
         FqDtUmAxQPO2x1vYTLQuZCbROa4OzH1LzHBFuutFolK4Xf2TPSO18NOd3G4fG/vy7YhS
         k8Kw==
X-Gm-Message-State: AOAM530pXRGl8LpT1qyjOyAGrXkNjaecqrTXaNO3w95xs6Up3GTJNhbr
        4B2/C2UizgzJHtQNRr3C0k5LPA==
X-Google-Smtp-Source: ABdhPJxDtK25lY/wFMtkxxCXECGcRVcnDaQOWbf7HsbPs+M2PCjiMyziRKjX9DH9kVyhgYE3eSw2cw==
X-Received: by 2002:a17:902:7b83:b029:12c:2758:1d2d with SMTP id w3-20020a1709027b83b029012c27581d2dmr7111400pll.80.1627372181324;
        Tue, 27 Jul 2021 00:49:41 -0700 (PDT)
Received: from [192.168.10.175] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id s36sm2457488pfw.131.2021.07.27.00.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 00:49:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: Is labelling a mounted ext2/3/4 file system safe and supported?
Date:   Tue, 27 Jul 2021 01:49:39 -0600
Message-Id: <8A4E4147-0D89-4B2B-A118-F5EDABF9ABD5@dilger.ca>
References: <CAMU1PDgJAadK21H_-u3vg0NujKRzBegH0SHL2+54+23ZppFDgQ@mail.gmail.com>
Cc:     Reindl Harald <h.reindl@thelounge.net>, linux-ext4@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>
In-Reply-To: <CAMU1PDgJAadK21H_-u3vg0NujKRzBegH0SHL2+54+23ZppFDgQ@mail.gmail.com>
To:     Mike Fleetwood <mike.fleetwood@googlemail.com>
X-Mailer: iPhone Mail (18D70)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Jul 27, 2021, at 01:33, Mike Fleetwood <mike.fleetwood@googlemail.com> wr=
ote:
>=20
> =EF=BB=BFOn Mon, 26 Jul 2021 at 21:50, Reindl Harald <h.reindl@thelounge.n=
et> wrote:
>>> Am 26.07.21 um 20:45 schrieb Mike Fleetwood:
>>> Hi,
>>>=20
>>> Using e2label to set a new label for a mounted ext4 seems to work, but
>>> is it a safe and supported thing to do?
>>=20
>> it is
>=20
> Is there some documentation which states it's safe to write to the label
> while mounted?
>=20
> I ask because 1) I am looking at adding such support into GParted and
> 2) I don't understand how it can be safe.
>=20
> Looking at the e2label source code, it just reads the superblock,
> updates the label and writes the super block.  How is that safe and
> persistent when presumably the linux kernel has an in-memory copy of the
> superblock will be written at unmount and presumable sync.

Currently, the in-memory superblock references the device buffer cache,
which is the same cache that is accessed when reading the block
device from userspace, so they are always consistent.

There has been some discussion about adding ioctl() calls to update
the filesystem label, UUID, and other fields from userspace in a safer way,
but nothing has been implemented in that direction yet (possibly Darrick
had some RFC patches, but they are not landed yet).

Cheers, Andreas=
