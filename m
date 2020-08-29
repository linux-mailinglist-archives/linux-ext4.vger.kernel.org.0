Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7364425659D
	for <lists+linux-ext4@lfdr.de>; Sat, 29 Aug 2020 09:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgH2H1i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 29 Aug 2020 03:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgH2H1f (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 29 Aug 2020 03:27:35 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439CFC061236
        for <linux-ext4@vger.kernel.org>; Sat, 29 Aug 2020 00:27:35 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id z15so702995plo.7
        for <linux-ext4@vger.kernel.org>; Sat, 29 Aug 2020 00:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=2gAkSaEu4YwBTB2aEH+ME/27LzGZ7AEDTqMsY+SwsJ4=;
        b=E5UNrppV6Xo9MOAK4lFAgYD/GLmf1IfRDQjGBJ4Ri147stFD7hjxI/jrvmGs1BQ+3U
         6rcx5stGpMzI5ruOLIEAnz/fXZsMh1n/eUqabInEzl+IfUIMHHgU5GgwkC8KZGw45LtE
         m4jj85C4tAg1qiMPPkkxz0N4fwNUXfN3EHnV7gPTYR9h2y1e3+3t6uDZ3Lzt42Jy9im+
         adS4JWUffLWWqv64difavH8FkMCHXDgcvDqUNYospNa48d6plnrcxZ4W2vXdQMJHRbMq
         RZR7VVqQMKMbNG5CvizvW+bhwKiiw45iWyW2ohJxIzae9PmPyE8fjZBBw0qFYL1qkLnr
         ZoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=2gAkSaEu4YwBTB2aEH+ME/27LzGZ7AEDTqMsY+SwsJ4=;
        b=AdEG/DFNf5kE+5sUst+ZyXNdezCWsbY9llTGmeBx2mcmwkBN94l7gQtv3tKzP+gpqH
         SuLgXGvqUmBOrRiHj3vyp9ErwfJX/aKa0jMnvDkzOrj+epgHJRiuU5cosLurv3W7P/i9
         Lq/OvcEAzMpWbphQwGCRnfhqUqL3vRsIeHiy+AcAEZBwROlWNodUo+9nOBnnHNOZ7juZ
         riHZGJxXZeFSSykmCUalwwWL31adNj93BtzaI9y3pcxzWwGF5Ph8vL0GZjamihvgZmnB
         GhhuFA1EXv1wv8cTCviT4Y4+IL99f0S4ELZ19/P/fybTKnA6w61E2Q+/MuZXrsTnRaDO
         Jshg==
X-Gm-Message-State: AOAM533Lx2lsc5c0QdRQyUD1yZEbAHYI92BSYSiw1fRLwG1/KyMrHyKP
        l0v8WUKqFybn7aF4ySpLk0qUwg==
X-Google-Smtp-Source: ABdhPJxoVtOn5F7wCMD3mw8Z/Ur9GiKDzjdfurguIWvnbpWFnModHXZLezOnwafSitVwSyMIP0lfUw==
X-Received: by 2002:a17:90b:118d:: with SMTP id gk13mr1361955pjb.141.1598686053469;
        Sat, 29 Aug 2020 00:27:33 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id u123sm1612149pfb.209.2020.08.29.00.27.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Aug 2020 00:27:32 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <900D8400-83F4-464A-88A4-32235B9A0DC8@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_7CC056B7-20FD-4744-BAD9-3D4398B67F77";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] ext4: Disallow modifying DAX inode flag if inline_data
 has been set
Date:   Sat, 29 Aug 2020 01:27:29 -0600
In-Reply-To: <20200828084330.15776-1-yangx.jy@cn.fujitsu.com>
Cc:     linux-ext4@vger.kernel.org, darrick.wong@oracle.com,
        ira.weiny@intel.com, tytso@mit.edu, jack@suse.cz
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
References: <20200828084330.15776-1-yangx.jy@cn.fujitsu.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_7CC056B7-20FD-4744-BAD9-3D4398B67F77
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Aug 28, 2020, at 2:43 AM, Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
> 
> inline_data is mutually exclusive to DAX so enabling both of them triggers
> the following issue:
> ------------------------------------------
> # mkfs.ext4 -F -O inline_data /dev/pmem1
> ...
> # mount /dev/pmem1 /mnt
> # echo 'test' >/mnt/file
> # lsattr -l /mnt/file
> /mnt/file                    Inline_Data
> # xfs_io -c "chattr +x" /mnt/file
> # xfs_io -c "lsattr -v" /mnt/file
> [dax] /mnt/file
> # umount /mnt
> # mount /dev/pmem1 /mnt
> # cat /mnt/file
> cat: /mnt/file: Numerical result out of range
> ------------------------------------------
> 
> Fixes: b383a73f2b83 ("fs/ext4: Introduce DAX inode flag")
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/ext4.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 523e00d7b392..69187b6205b2 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -492,7 +492,7 @@ struct flex_groups {
> 
> /* Flags which are mutually exclusive to DAX */
> #define EXT4_DAX_MUT_EXCL (EXT4_VERITY_FL | EXT4_ENCRYPT_FL |\
> -			   EXT4_JOURNAL_DATA_FL)
> +			   EXT4_JOURNAL_DATA_FL | EXT4_INLINE_DATA_FL)
> 
> /* Mask out flags that are inappropriate for the given type of inode. */
> static inline __u32 ext4_mask_flags(umode_t mode, __u32 flags)
> --
> 2.25.1
> 
> 
> 


Cheers, Andreas






--Apple-Mail=_7CC056B7-20FD-4744-BAD9-3D4398B67F77
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl9KA2IACgkQcqXauRfM
H+A3zg//VWuoHqrKCaLN3oi1Fyjm/LeL7MNSbfswlzuxsOYYDVcD2Pv5lqbHSs/9
O8tG6nFYMhH9ZyeBJtoeoUPED194/c3ZIrm7batXb9EW8JqgwSBqYtey4DWuEATC
6qQnbkETbusKWZO8n6Grov2p2f32sAoB/ul0wXz2auLXPPDCcuDAISe0uvxhGr/7
GIQL2+mO63787BsWFIal7xqwf0LLZLHqViEJURLQTZBeD7dIXqqBP0Dxgfxo/WL1
Dcv0oo11jNUvvFbgvBUEeU4GuhTSYyp6T7kyV+pM1mG+CoZvWQcn0JD5nDFlL34F
ck1WTrpVATdLAInWAu2hMzUHxbwwr2uoz2V5mUvo9v4vGQRzRycMOQVrP1y9OEQk
t4IFGH0w33kJFx7+8sjH/HU91XToTEC8/x6un2XW9mXNaZdUfIpUhTHrsSlRG9Fx
1xQJmc44PnPmQF5a5hXIyTzchb5x15znQfhQ7mnzXCQoe9/5NKxjRX4m2jiLvpEu
Rz7KenBJvNUh8D1jXWJR5EMXhrRqwNKff8PJMO7feQNEfFVF9ql1uiNZ7PPFAsda
NeFY2lT99YqaVVpnxD0MOSGWEjfYi2k3f+EcqlD1dNCghW3bHpxv52oNxubsUcmZ
LquZ9vAnNMVi3SEylKDgVUlmWef9ZjP8flDm6IB5heHMClOMn2Q=
=lsAO
-----END PGP SIGNATURE-----

--Apple-Mail=_7CC056B7-20FD-4744-BAD9-3D4398B67F77--
