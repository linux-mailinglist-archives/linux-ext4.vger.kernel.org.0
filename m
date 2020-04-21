Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5BF1B327C
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Apr 2020 00:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgDUWHs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Apr 2020 18:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgDUWHr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Apr 2020 18:07:47 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ACDC0610D5
        for <linux-ext4@vger.kernel.org>; Tue, 21 Apr 2020 15:07:47 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id np7so140626pjb.1
        for <linux-ext4@vger.kernel.org>; Tue, 21 Apr 2020 15:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=o6Ha/SorrXkeCYa3vNi4CbmMONOGwm3nGgL/xTmNdMI=;
        b=O49AnoyC8pzM7Qoj8Ja1NytCjKaNsfADHUW55WuPLGykHOKy0yY7L3D4zW4+RgBUix
         GXuJdCm8VJzYETEK69fWQX7mvexJLPer87yJJzIxIjICWTBbKsZgLxJ23ujXCZBSF8Mq
         sEotOO/xFGf3CWUFHROXvcPp8GOyHO+QCYMY5Xzk6DBceUdsfhZxh2nnNTik+lRjC02H
         wxQFExic4VdnG1sqE8pLtvhAkpVXk2CupT5fSExPcaR6kur9fI1N/UGOrcvxSOg9QApi
         xKqncE0npfbrZvogmf36uE95eKg2Ynt526Pag/qXTVF5gz3FrE+/HmQbV2YCocmNCedN
         gdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=o6Ha/SorrXkeCYa3vNi4CbmMONOGwm3nGgL/xTmNdMI=;
        b=sYUeygQDXTo6tiszBVEUAKsKZoQuwmPcmyjHvVZLI/2yPR6CflrHP3HInpvU6Pc/Gu
         8e0m/wzRhevMzYnaPgzXwNQu0ztDcCcIsDs4u5NSTxuTgDWxuwDuN9bKafe2nQwDeCZ/
         hXtwsG3MCuNYeuCOgLBsgW6hjcIHub9iBxQsnee0j4CRIJ8AFerhTN0iSqDcay6+QeQq
         q2qr5Nu2ZIv/ggxoRVP6g38oY/ND7MgEaoU4bCSQ8O+vmUz4hF1NbsEvAtlEiT0iZd0c
         qjft2jNi8k3i1m9/YgLpzVG4oKKvYB0L+fD5PPkGBLLIoM1qEBcbEyF2499+GNpA1ZC/
         ePqQ==
X-Gm-Message-State: AGi0PubTKw0QoRBpGKw3KrJ1VhXGIZNf6NLFr3dywXSidXrGNThQxSe2
        VrMgwBbw6LLsrOOXars9lZsJGA==
X-Google-Smtp-Source: APiQypKsYNd5KJ6HKzFzv9zRCFvKsG/RQRTvzCpdwaNcpoeYsBu1PtFsFabLXepqoDCXiZwO79Inlw==
X-Received: by 2002:a17:902:c111:: with SMTP id 17mr23349898pli.334.1587506866590;
        Tue, 21 Apr 2020 15:07:46 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id r12sm755365pgv.59.2020.04.21.15.07.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2020 15:07:45 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <BFC9114B-7D3D-4B8F-A8BB-75C2770EE36D@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F63EC912-6A6B-4678-9B55-F421BE8E913A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Exporting ext4-specific information through fsinfo attributes
Date:   Tue, 21 Apr 2020 16:07:43 -0600
In-Reply-To: <2504712.1587485842@warthog.procyon.org.uk>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     David Howells <dhowells@redhat.com>
References: <20200401151837.GB56931@magnolia>
 <2461554.1585726747@warthog.procyon.org.uk>
 <2504712.1587485842@warthog.procyon.org.uk>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_F63EC912-6A6B-4678-9B55-F421BE8E913A
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Apr 21, 2020, at 10:17 AM, David Howells <dhowells@redhat.com> wrote:
> 
> Darrick J. Wong <darrick.wong@oracle.com> wrote:
> 
>> The entire superblock as a binary blob? :)
> 
> How about the attached?  Please forgive the duplication of struct
> ext4_super_block into the test program, but it's not in the UAPI.

I think (hope?) Darrick was joking?

At least IMHO, exporting the whole superblock as a binary blob is not
a great user interface.  I guess it has the benefit of allowing access
to various non-standard fields without accessing the device directly.
Kind of like SCSI mode pages, but that can get ugly quickly...

I can definitely get behind adding generic properties like the ones
you list below.

> 
> David
> ---
> fsinfo: Add support to ext4
> 
> Add support to ext4, including the following:
> 
> (1) FSINFO_ATTR_SUPPORTS: Information about supported STATX attributes and
>     support for ioctls like FS_IOC_[GS]ETFLAGS and FS_IOC_FS[GS]ETXATTR.
> 
> (2) FSINFO_ATTR_FEATURES: Information about features supported by an ext4
>     filesystem, such as whether version counting, birth time and name case
>     folding are in operation.
> 
> (3) FSINFO_ATTR_VOLUME_NAME: The volume name from the superblock.
> 
> (4) FSINFO_ATTR_EXT4_SUPERBLOCK: The entirety of the on disk-format
>     superblock record as an opaque blob.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: "Theodore Ts'o" <tytso@mit.edu>
> cc: Andreas Dilger <adilger.kernel@dilger.ca>
> cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> cc: Eric Biggers <ebiggers@kernel.org>
> cc: linux-ext4@vger.kernel.org

Cheers, Andreas






--Apple-Mail=_F63EC912-6A6B-4678-9B55-F421BE8E913A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl6fbq8ACgkQcqXauRfM
H+Aj1RAAhMkGGU2SzOCmvp7VK04lIIaWFO+L69Fm6o4InpyWEE0Ce15poTLWUjCv
BzBpX84VQhYko+Isah1x7RQXD31iWm5k6KF7t1h6kPtnh+/7SXKJkQntuTYEZ/g4
FE9ddcgygrJSOfGeolAyv2lBzgOZt4SecCvSZda05BnZUd7zahGaVXFjsvbb9OQ3
glKTkp8sKxtcEEivorLr0415qqYYw5TlnkA7iLSdASCJHwXPYATOdnv++Kk8271K
okepmoF7Psm9OVcWLDASt3ulgQrYqGim1tRZBsjRNBJ+VHBt09LB0yrriL5Fq1c1
cLxW91WyDfvjvfi+X+ikKwWmvEJTW06JnBjGkudUn5B//nA/SmpsNwnlBDlc5wMp
jnCIt0L85qVmVV3NUlnJDby7+ihV62FrECsQcgjO7FjMwxYCYoufSgrCfjE9IJKD
f4l9ag3EyOkDDTANANIOcjCtKFM96xAug8/uax1Ku0atmBiYKZ1b55982Mxjs7ZA
+Lsynm9fVTBt0afuX4wcxHGyFfhocXTte8q7SkhU5WUc0nr5cOv21PHJmDARwyIc
GDqWpe5wjkBfzVoMOTc8Gs4Pfua3fZyfwiK9wtumNVJil/wg2ihlklImglH5FrrR
j+uaWTiA4EMBw7MqEDH2gvT7P1XUuQ64t5Jox6d3n6LbrNKfZ5I=
=txNX
-----END PGP SIGNATURE-----

--Apple-Mail=_F63EC912-6A6B-4678-9B55-F421BE8E913A--
