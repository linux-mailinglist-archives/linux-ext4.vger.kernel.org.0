Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCFF25568C
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Aug 2020 10:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgH1Idw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Aug 2020 04:33:52 -0400
Received: from kerio.exonet.nl ([178.22.62.240]:22986 "EHLO kerio.exonet.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728016AbgH1Idv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 28 Aug 2020 04:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=exonet.nl; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=0d7F9+Y2NVifyLNcYYsWm6PXptzC8n+HtlJtYG1+cAc=;
        b=SbBo5MGlY0BNrMwReBssk6Kvw0xUmlWH1/LxDTcHkx6PJr3L8VSPvuXGykDyTsps5frQl9Vp1XA/a
         ZsHujMlAqZ1xzAgdtAmneSLjP+2T6/8czbpR7u+lfkAVscNIi+5PoCcm+recK796ZmHOLLoOOlpvW0
         bktXwnwwfs9h+vu6DUn/28asF2iMN/zDTHGVtBMg00UQToW3jd0i4VuM977fVNtBUCrwjh1GEwpIk+
         +h5/iGOcTgj6OB45M9Kq2wQEgm58x4sUk3H8pBCqKwOcg7QzZ6rmqzJQcYbF1DGBc9RfOMj67HYFcZ
         z32hdbCiSLCVJIwByL1SaqMocgCLBNw==
X-Footer: ZXhvbmV0Lm5s
Received: from [10.3.12.3] ([185.31.247.5])
        (authenticated user h.kraal@exonet.nl)
        by kerio.exonet.nl (Kerio Connect 9.2.11) with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Fri, 28 Aug 2020 10:33:47 +0200
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [EXT4] orphaned inodes on RO device trigger "unable to handle
 kernel paging request at"
From:   Henk Kraal <h.kraal@exonet.nl>
In-Reply-To: <811ADCEA-EF75-469E-B18C-B6B3C3616DF1@dilger.ca>
Date:   Fri, 28 Aug 2020 10:33:47 +0200
Cc:     linux-ext4@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A2D0E873-1991-4648-9660-EB5BE90DDAD4@exonet.nl>
References: <E57F2086-629A-40C3-BA75-916CA0E02445@exonet.nl>
 <811ADCEA-EF75-469E-B18C-B6B3C3616DF1@dilger.ca>
To:     Andreas Dilger <adilger@dilger.ca>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



> On 13 Aug 2020, at 10:27, Andreas Dilger <adilger@dilger.ca> wrote:
>=20
> Definitely a newer kernel is likely to avoid the oops (lots of bugs =
have been
> fixed over the years from fuzzed filesystems), but that wouldn't =
necessarily
> allow you to mount the filesystem, just avoid the crash and return an =
error.

That would be a step forward, being able to mount would be the next but =
that something I have to dive into yet.

>=20
> The correct thing to do would be to run "e2fsck -fy" on the device =
with the
> latest version of e2fsprogs (1.45.6 IIRC), since it seems there is =
corruption
> in the filesystem.  Once that fixes the problem then it is likely that =
the
> filesystem can mount without errors.
>=20
> If the latest e2fsck checks the whole filesystem and does not report =
an error,
> and you still see a crash with the latest kernel, then it is more =
likely someone
> will look into the details.

The problem is corrected on the actual server but will exists in the =
backup chain for a while which could contain data I would like to access =
directly. In the current case I=E2=80=99m required to restore the whole =
VM which is possible but just time consuming.

Thank you for the reply, much appreciated!

With kind regards,

Henk=

