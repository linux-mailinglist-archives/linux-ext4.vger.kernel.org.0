Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C79444979
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Nov 2021 21:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhKCUXV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Nov 2021 16:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhKCUXV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Nov 2021 16:23:21 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49497C061714
        for <linux-ext4@vger.kernel.org>; Wed,  3 Nov 2021 13:20:44 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t11so3404081plq.11
        for <linux-ext4@vger.kernel.org>; Wed, 03 Nov 2021 13:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=PQegBT8oyF6/RgapfYkm6edjJzrHBtMWVv5aIVC6QDo=;
        b=Wel1bSvlMaj5BVtlYoGnZ3o1ZnJBCjCE48zp04htLo1VlbpS1mVotF2f+hET8NPbkK
         sYVQOjp4hSQdXJqHyDC1CpYQSHyfbQuo333wR2lKn6VfrwV/fMev8QOENYPL/VcyUydO
         YdWGtzOxqLbxod5ALLExrRjy4Ofh+MkETRi4AFxIM2iofeplb18BQD+JsFbWN8DbcpvR
         y7tY8h9GrM3zZgv+BFtcJmaATKOFPZ3/0gQlf98nHFr+U1favnoxJtCZ7hfOqwG5aUfg
         UK2af283/hoFuXuYpj9MdGv9UJcgF/0bhvOoLuogtj34ealuu04SshFNWgEnZ5j6z/PM
         UEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=PQegBT8oyF6/RgapfYkm6edjJzrHBtMWVv5aIVC6QDo=;
        b=iOFbZpSMhHHck0iROFuD3KzPhPGYTS2loF9aZEwMxAwlLa/W3WCUFCTYITuWmwMSaT
         VIgSrHMsQazScGUJyVY9ahCcuN8Bu6ECXvKIYmWugLY1zWT6+BULxoGMqZB+EOviK9Uh
         YY7/MwKr9e0u19GeM4Es6jNc/UMghYwI2P8t+xBYMOR6/bYd4OmvQOgSN4BqbjUiBrtw
         w9gdfuPon0OehQQGSfnOGvp/3VRMemSFGN5iapXxvOB8otOuUYN8snr4Qqf1asIS7xPP
         y2tGpuz0cpvM6kxmiymZ3yomFEiqOab9wvIPiX4d/R6piU3Fbhs1T6BG/ieUozV65Cg4
         euLw==
X-Gm-Message-State: AOAM531ZMHtZurUukuNZYEvilSDrPQbMtoiT6mk8vaAZagrNvrJB+4/U
        Bx+UsTcXOS0VjtjKkqsPcTByLg==
X-Google-Smtp-Source: ABdhPJzre4ot9XbgD7zNRaAtGY6zjofv12JVqGORaFrwxW3fBm9jfq3gGPQeBCODv+hh5Ruh9bC2YA==
X-Received: by 2002:a17:90b:3758:: with SMTP id ne24mr17381019pjb.59.1635970843791;
        Wed, 03 Nov 2021 13:20:43 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id j8sm3013921pfe.105.2021.11.03.13.20.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Nov 2021 13:20:43 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <332FF1C0-FD87-4BA6-A435-C656172EC60B@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_1B81D913-810F-46D3-81BE-22A751ADF207";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 2/2] ext4: Allow to change s_last_trim_minblks via
 sysfs
Date:   Wed, 3 Nov 2021 14:20:42 -0600
In-Reply-To: <20211103145122.17338-2-lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        Laurent GUERBY <laurent@guerby.net>
To:     Lukas Czerner <lczerner@redhat.com>
References: <20211103145122.17338-1-lczerner@redhat.com>
 <20211103145122.17338-2-lczerner@redhat.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_1B81D913-810F-46D3-81BE-22A751ADF207
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Nov 3, 2021, at 8:51 AM, Lukas Czerner <lczerner@redhat.com> wrote:
> 
> Ext4 has an optimization mechanism for batched disacrd (FITRIM) that
> should help speed up subsequent calls of FITRIM ioctl by skipping the
> groups that were previously trimmed. However because the FITRIM allows
> to set the minimum size of an extent to trim, ext4 stores the last
> minimum extent size and only avoids trimming the group if it was
> previously trimmed with minimum extent size equal to, or smaller than
> the current call.
> 
> There is currently no way to bypass the optimization without
> umount/mount cycle. This becomes a problem when the file system is
> live migrated to a different storage, because the optimization will
> prevent possibly useful discard calls to the storage.
> 
> Fix it by exporting the s_last_trim_minblks via sysfs interface which
> will allow us to set the minimum size to the number of blocks larger
> than subsequent FITRIM call, effectively bypassing the optimization.
> 
> By setting the s_last_trim_minblks to ULONG_MAX the optimization will be
> effectively cleared regardless of the previous state, or file system
> configuration.
> 
> For example:
> getconf ULONG_MAX > /sys/fs/ext4/dm-1/last_trim_minblks
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Reported-by: Laurent GUERBY <laurent@guerby.net>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> v2: Remove unnecessary assignment
> v3: s_last_trim_minblks is now unsinged long which simplifies this
> 
> fs/ext4/sysfs.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 2314f7446592..95d8a996d2d8 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -245,6 +245,7 @@ EXT4_ATTR(last_error_time, 0444, last_error_time);
> EXT4_ATTR(journal_task, 0444, journal_task);
> EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
> EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
> +EXT4_RW_ATTR_SBI_UL(last_trim_minblks, s_last_trim_minblks);
> 
> static unsigned int old_bump_val = 128;
> EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, &old_bump_val);
> @@ -295,6 +296,7 @@ static struct attribute *ext4_attrs[] = {
> #endif
> 	ATTR_LIST(mb_prefetch),
> 	ATTR_LIST(mb_prefetch_limit),
> +	ATTR_LIST(last_trim_minblks),
> 	NULL,
> };
> ATTRIBUTE_GROUPS(ext4);
> --
> 2.31.1
> 


Cheers, Andreas






--Apple-Mail=_1B81D913-810F-46D3-81BE-22A751ADF207
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmGC7xoACgkQcqXauRfM
H+B7vBAAjdn2l+ueLv5ROU0QFGsWkaXdbm6fOUDxcdS9UWJKeQZPSYZ2q9q6rTAV
nPNNph/ckifG7c/ZsF7ghRsZJMjiyQOoOJJ/OiNoetKL+C4cnubCnoB/p/77XGN4
RaIVO/rMIVR5UTPsKaLqyV2v2MXrCIB3cyLEHMnCDhKZAYjdfwKPzfzBIx91LDvt
dTGSeoEFLJPxqeLQkHfS6JIDtJ4ieK46eaIXN1TqPP2/TCSACUYxqcSr8UPbVZnv
zOps+DuAR3jIY8gATwAsnvkYn8b9Ry3NT/FHC8UjK1Q51M+HYeZK/xbwzPfaL+Yu
4ucvzlGAs2uTKrPwwsrxErJnskKfCpAMDQKfvG3d11aOiA5dxs1S50sYUQWxv4Hv
c0RDTKRYH5zd+Qq25fSkOJmWmj+6z3lp1a4XJ7lmAOILchSXp5cYJeaUeWLZtbBO
L8ZLdNJdIW8ujXvMRorlzk0Fl+lYkxVdVIJHdEI/+sSFbs39tJh7GZlSOyLthZPo
50YoR0JxlcN0DJAWynaIpmQIgnbyrFIbjCZy+jEE9Aau+9mczVaSk674q83sj728
+e0RprsABB2Sqn+3VI8PDO07dxTxTj8SA3I5QAzlRE152HvwNa8o1yXLaBTc3Af5
iIixo4fTLhd/iKIkaQ5Jxi+DsL0wKLx1MGRAVYhEFwwiiMbwToE=
=DnNY
-----END PGP SIGNATURE-----

--Apple-Mail=_1B81D913-810F-46D3-81BE-22A751ADF207--
