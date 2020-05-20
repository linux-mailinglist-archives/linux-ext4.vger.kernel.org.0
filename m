Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316501DBDF3
	for <lists+linux-ext4@lfdr.de>; Wed, 20 May 2020 21:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgETT04 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 May 2020 15:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgETT04 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 May 2020 15:26:56 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D2DC05BD43
        for <linux-ext4@vger.kernel.org>; Wed, 20 May 2020 12:26:55 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z26so2042037pfk.12
        for <linux-ext4@vger.kernel.org>; Wed, 20 May 2020 12:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ybElckBuJkHNMqBT6bP/3ZUGSTcEzT1Byb+0g20pfBo=;
        b=UWVOqHnL+z5agcX6Eq8DH5sU8YNxqBh807UzkYKVvXssCMg7c8XOZ04sL/SIx1TtN3
         AsUxfChZlGY3gvkjCQav7AMEnq7rjQV4X+R7lntZ0RqZCu+uG7Qkpc84QbqIq5FmHqoC
         oU6TfFe60DkVaMA91yxbgN005wsjyoSq7YCgbw4KKntwovRRG6Xtb6jrgrBcENtz2KuR
         91C/99ABalWYBfAc2rGx9Z4qy5k/EhABDnUTEzIM11sl6ieWbGM6mVIytMywSrj6IghN
         SHWYreiclfPizheQVBMOsVZkwEE973g5QrF5W5Dy3zKxjBLjvRK6ncy0UBhuKJH8cI/Q
         6Mew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ybElckBuJkHNMqBT6bP/3ZUGSTcEzT1Byb+0g20pfBo=;
        b=dP359pZ+hJLWkbS/m6iPEcncPw4lf+LQrFItX1/5c254R05DOHR8wda1vLb6x4bs1n
         P/JGht6+1AhfUYAVIbwETTjzVWt0dId71nU6U8T5baXjUotOKHZbGKr/L2WM7Sh2JEsR
         aJTOBKZf+sMKGvw2BYeE+PUlY8jkhA2wYvCavdikXEytHDC58JS2EilcVJPvkSqlY4iY
         gAuLEz0RNPt8AGCzo6D8fWA6aQrsHct6+urZZYONEGt3L22m2aMZgpPCfhKmZGh1VGgc
         6rWE99UlyjkdI0KBtwsSfMdFVLNyt0oAPbDX1iKOIdrYjbeu81BPBbFaO3QLhyX1b6ft
         ED/w==
X-Gm-Message-State: AOAM530b9th5nfQCSFQncGXHTFiYRn5c3Tw76UPEHTeKGSuPSEt1UePM
        XDdXjDdFF788rZP0lBhFzKT2Vw==
X-Google-Smtp-Source: ABdhPJzI1my29KHz2ptD6Y/uBxW4rPjNP/9mzZxdAhbEBiQheLu2gpIwJMhc2m7QPA3u12V7AenNCA==
X-Received: by 2002:a63:ef09:: with SMTP id u9mr5746921pgh.406.1590002809290;
        Wed, 20 May 2020 12:26:49 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id z190sm2693166pfb.1.2020.05.20.12.26.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2020 12:26:48 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <34ECB1DE-9F2F-4365-BBBC-DFACF703E7D4@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_96A80465-DD54-49D5-8819-3365C95A2437";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH V3 7/8] fs/ext4: Introduce DAX inode flag
Date:   Wed, 20 May 2020 13:26:44 -0600
In-Reply-To: <20200520055753.3733520-8-ira.weiny@intel.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Xi <lixi@ddn.com>
To:     ira.weiny@intel.com
References: <20200520055753.3733520-1-ira.weiny@intel.com>
 <20200520055753.3733520-8-ira.weiny@intel.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_96A80465-DD54-49D5-8819-3365C95A2437
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On May 19, 2020, at 11:57 PM, ira.weiny@intel.com wrote:
> 
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Add a flag to preserve FS_XFLAG_DAX in the ext4 inode.
> 
> Set the flag to be user visible and changeable.  Set the flag to be
> inherited.  Allow applications to change the flag at any time with the
> exception of if VERITY or ENCRYPT is set.
> 
> Disallow setting VERITY or ENCRYPT if DAX is set.
> 
> Finally, on regular files, flag the inode to not be cached to facilitate
> changing S_DAX on the next creation of the inode.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 6235440e4c39..467c30a789b6 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -415,13 +415,16 @@ struct flex_groups {
> #define EXT4_VERITY_FL			0x00100000 /* Verity protected inode */
> #define EXT4_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
> /* 0x00400000 was formerly EXT4_EOFBLOCKS_FL */
> +
> +#define EXT4_DAX_FL			0x01000000 /* Inode is DAX */
> +
> #define EXT4_INLINE_DATA_FL		0x10000000 /* Inode has inline data. */
> #define EXT4_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
> #define EXT4_CASEFOLD_FL		0x40000000 /* Casefolded file */
> #define EXT4_RESERVED_FL		0x80000000 /* reserved for ext4 lib */

Hi Ira,
This flag value conflicts with the reserved flag in e2fsprogs for snapshots:

#define EXT4_SNAPFILE_FL                0x01000000  /* Inode is a snapshot */

Please change EXT4_DAX_FL and FS_DAX_FL to use 0x02000000, which is not used
for anything in either case.

Cheers, Andreas


> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 379a612f8f1d..7c5f6eb51e2d 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -262,6 +262,7 @@ struct fsxattr {
> #define FS_EA_INODE_FL			0x00200000 /* Inode used for large EA */
> #define FS_EOFBLOCKS_FL			0x00400000 /* Reserved for ext4 */
> #define FS_NOCOW_FL			0x00800000 /* Do not cow file */
> +#define FS_DAX_FL			0x01000000 /* Inode is DAX */
> #define FS_INLINE_DATA_FL		0x10000000 /* Reserved for ext4 */
> #define FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
> #define FS_CASEFOLD_FL			0x40000000 /* Folder is case insensitive */
> --
> 2.25.1
> 


Cheers, Andreas






--Apple-Mail=_96A80465-DD54-49D5-8819-3365C95A2437
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl7FhHQACgkQcqXauRfM
H+CzoxAAgUIKJH9Its4enBgM8d6Tekq7iU1pViIdAgr4uLrkgansf1UZuQ97o7J1
1TzpTiNJmIr6fdeG9H3f3jO+H0T0MVOORk3pm89HjKKNG2aouHVWx8nKzhf6ks+p
6PHoYF4Xtwj6YfDUW6THUoDlmxeEE+CWOIwsonP+piygiO7NtoFrIrA12VcO5Ijb
MrAddf7egV/mX98ipVGZK8kwOpnmpzJCfakWyDVY+MXuDzHSfMCyLxZXK1yDqXNl
Z0rCJ4TTnVzPLToXaAIsNM9IuN8AFZL7TNKHQEpwCji88UjgLuSXM+5prLBUC5bt
24by4B4TicvR8Sy2YBVpAcs0UWPe7KXeibkQkjtUnR3ndCQjbxBHDks+1m6tpHqA
Ttu5X4T17iK005ZfPCuL6neK1pcvXGOb/+EeljXbgxJYfg88hVr2G12LY1hYSBaj
20Q1DFeXGwSDVmnKAPl+zEAHRb5kobj1/wAvKtXTCJ/fPsjAXmv74Ox/jZA+oWJD
z4YXLPgbJEXxreW7becBUOvF1FbJQwXdmwoeQmuiQwNjqEUjSWBNN6O7lsHbfECh
Hb/scj62OMzWJs4ybq/5oKUdloV5aWYhcuEGyYHEkGJXyXSHUuxn9/33qiW9h+ym
jGRYEamsw1IxSQy1V5uf+T18l0jpO3zja1PtG0T8cA3aPh4ZBkc=
=KvVr
-----END PGP SIGNATURE-----

--Apple-Mail=_96A80465-DD54-49D5-8819-3365C95A2437--
