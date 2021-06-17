Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5A63AADE7
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jun 2021 09:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhFQHq3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Jun 2021 03:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhFQHqZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Jun 2021 03:46:25 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D625DC061574
        for <linux-ext4@vger.kernel.org>; Thu, 17 Jun 2021 00:44:17 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id h12so4348004pfe.2
        for <linux-ext4@vger.kernel.org>; Thu, 17 Jun 2021 00:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=RjfwIbpRsVaKz+UAd3BZ46hApkcNErkmAT7Ln1G6FVA=;
        b=vcArFQra6cVbxWgqDQo5Dn9F4+jmTOwYwIkUEtm+WW5UJTGS3bxV2GQ09LvWQUyJHB
         pAs21HqhJ5QIEdgxHI3PBE7Is37MxSG8H0+5zGalC1MOS4XHixUw8AQL1QhwCKKJtFIy
         gNQb07cgZF1G3nhKrRl/qu2FhWs+CS5BxDr6XRKAiGLK1Qk21I/xGifcfimGDk1B4zli
         HnBjvxKwiDlQF0liJcSyEwKannSFNa0GvRTdGKzgWowbQBZChlwAVx/FRw45SVM/W79p
         OZ8VdCGwQ95f9KNcYoS1b/ooVerXLHqs/762txb+N6hUImjfgSTvX1sZzmRfCj+mOd+l
         pQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=RjfwIbpRsVaKz+UAd3BZ46hApkcNErkmAT7Ln1G6FVA=;
        b=dsmnSiAb97lsz+kV+L1YR3cloGLol8RyIpPdj5v1x5NzczHaqCHYfIgSapFxvsZWou
         CT0GlATODswalK+HtFEVs6GkPxJ1SCZ1sAHly6T4aRuR3V3khSUdxe06kK3Z+KAKR2GI
         DpV1Vy1wDZT/aw/1diYJHwAZx0W7SdE1EoL4dIu10WcHSFgZ18XdYOuIa5dLe+iJ1L44
         gJfWCIRm2Z49hGAO7Z0vBgvC/y4Lv8LIjjGL/KNpb1q3igBuzxtedQrPgCJMcmjwwHr1
         iWJbM3W30Au0zhTuu4Hh15XsOQVnGRVm2p9F1EZ3KZAqGuzGLCQzW5FPeTNXqy3VXsam
         UI1g==
X-Gm-Message-State: AOAM5334m527t3eHZIwzDIubQ3vzZPon8NLmYuH5EDNM5YabSNUmahSZ
        uflkmHMz9MEsNxHckxT8LSK9oA==
X-Google-Smtp-Source: ABdhPJxghW+LiLs4XVF9sU9x8PzI298y9Qu7rhcsweQM6rU8h3fO8NduhFMRxmI482CXIRDGlzDvWw==
X-Received: by 2002:a63:f047:: with SMTP id s7mr3751979pgj.272.1623915857297;
        Thu, 17 Jun 2021 00:44:17 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id d127sm4072045pfc.50.2021.06.17.00.44.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jun 2021 00:44:16 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <A8AFE573-798C-4E07-AD66-A369B3B1CC51@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_FF56063C-3D76-4C8B-AFE0-29BD43C4F7E4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 3/4] ext4: Speedup ext4 orphan inode handling
Date:   Thu, 17 Jun 2021 01:44:13 -0600
In-Reply-To: <20210616105655.5129-4-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
To:     Jan Kara <jack@suse.cz>
References: <20210616105655.5129-1-jack@suse.cz>
 <20210616105655.5129-4-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_FF56063C-3D76-4C8B-AFE0-29BD43C4F7E4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 16, 2021, at 4:56 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> Ext4 orphan inode handling is a bottleneck for workloads which heavily
> truncate / unlink small files since it contends on the global
> s_orphan_mutex lock (and generally it's difficult to improve =
scalability
> of the ondisk linked list of orphaned inodes).
>=20
> This patch implements new way of handling orphan inodes. Instead of
> linking orphaned inode into a linked list, we store it's inode number =
in
> a new special file which we call "orphan file". Currently we still
> protect the orphan file with a spinlock for simplicity but even in =
this
> setting we can substantially reduce the length of the critical section
> and thus speedup some workloads.

Is it a single spinlock for the whole file?  Did you consider using
a per-page lock or grouplock?  With a page in the orphan file for each
CPU core, it would basically be lockless.

> Note that the change is backwards compatible when the filesystem is
> clean - the existence of the orphan file is a compat feature, we set
> another ro-compat feature indicating orphan file needs scanning for
> orphaned inodes when mounting filesystem read-write. This ro-compat
> feature gets cleared on unmount / remount read-only.
>=20
> Some performance data from 80 CPU Xeon Server with 512 GB of RAM,
> filesystem located on SSD, average of 5 runs:
>=20
> stress-orphan (microbenchmark truncating files byte-by-byte from N
> processes in parallel)
>=20
> Threads Time            Time
>        Vanilla         Patched
>  1       1.057200        0.945600
>  2       1.680400        1.331800
>  4       2.547000        1.995000
>  8       7.049400        6.424200
> 16      14.827800       14.937600
> 32      40.948200       33.038200
> 64      87.787400       60.823600
> 128     206.504000      122.941400
>=20
> So we can see significant wins all over the board.
>=20
> Signed-off-by: Jan Kara <jack@suse.cz>
>=20
> +static int ext4_orphan_file_add(handle_t *handle, struct inode =
*inode)
> +{
> 	spin_lock(&oi->of_lock);
> +	for (i =3D 0; i < oi->of_blocks && =
!oi->of_binfo[i].ob_free_entries; i++);
> +	if (i =3D=3D oi->of_blocks) {
> +		spin_unlock(&oi->of_lock);
> +		/*
> +		 * For now we don't grow or shrink orphan file. We just =
use
> +		 * whatever was allocated at mke2fs time. The additional
> +		 * credits we would have to reserve for each orphan =
inode
> +		 * operation just don't seem worth it.
> +		 */
> +		return -ENOSPC;
> +	}
> +	oi->of_binfo[i].ob_free_entries--;
> +	spin_unlock(&oi->of_lock);

How do we know how large to make the orphan file at mkfs time?  What if =
it
becomes full during use?  It seems like reserving a fixed number of =
blocks
will invariably be incorrect for the actual workload on the filesystem.

> @@ -49,6 +95,16 @@ int ext4_orphan_add(handle_t *handle, struct inode =
*inode)
> 	ASSERT((S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
> 		  S_ISLNK(inode->i_mode)) || inode->i_nlink =3D=3D 0);
>=20
> +	if (sbi->s_orphan_info.of_blocks) {
> +		err =3D ext4_orphan_file_add(handle, inode);
> +		/*
> +		 * Fallback to normal orphan list of orphan file is
> +		 * out of space
> +		 */
> +		if (err !=3D -ENOSPC)
> +			return err;
> +	}

This could schedule a task on a workqueue to allocate a few more blocks?
That could easily reserve more credits for this action, without making
the common case more expensive.  Even if it isn't used with the current
mount, it would be available for the next mount (which presumably would
also need additional blocks).

Whether it is worth the complexity to make this fully dynamic, at least
it would auto-tune for the workload placed on this filesystem, and would
not initially be worse than the old single-linked list.

Cheers, Andreas






--Apple-Mail=_FF56063C-3D76-4C8B-AFE0-29BD43C4F7E4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIyBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmDK/U0ACgkQcqXauRfM
H+CMMQ/3YRd/Nh7hzHsVmI22OASlhEa/wsTc6yXLjJTvsKJYfESihcAo5tvTwK9C
4cRh7yyIOS461JL9FOgUCu+8SALGaSzlgiugXy9f2vDQP3QH1rilXqeMPTECPnGv
NrmC4GXoK/4xwYNJvFXsJULJlQLpYhEkmla9QNJ/CvSYJ+Yoq//mW71ggmHwZuHd
515aVY92PDu+8tCE0oOSVOo1122nEoE2vaS5sJSi5UMlK16XxMbU5jEQV2OuD/uI
+B8TItmO8F/uK5IMOfkMmPpeVcIVMKGwJ7prJBMaY2YBJpz1yiU70+NF3nvGevTi
3x/x6VECrB0MUiZFYIxuCUs3cWco1MtNSyIFHwHQdD2KiA+rTho2ckQvtfdB23B5
sq4CX59Quhc/CrWejywQjzICL1z91T3TPOloUuQ43Th7S2tAKUfugGgNpuBbYsef
+2ay/R+8E+5HSYRIbw+4IJ97JX38e5LoNpXOAOF8lMz/2yewavZ+XCKNxv/Pmn0b
If7kEAEUBV8LrjAAOqVSzzEnbpSsgFqHJCgZqdoKaf/sIzX4RK4rUGYlGrMfw5kP
EZqx5F9XwblB4oQzVbRpoUgh261X0g/O2K2b5yT3pv+VtYt3MhALrW6LvqOfDs5f
9/NsKqhH8adqNqrAGayFOyfnTqDa1H+gNotyPe08KtfR21KSXg==
=+JV8
-----END PGP SIGNATURE-----

--Apple-Mail=_FF56063C-3D76-4C8B-AFE0-29BD43C4F7E4--
