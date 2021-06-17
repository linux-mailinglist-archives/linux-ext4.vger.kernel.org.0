Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36723AA98D
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jun 2021 05:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhFQD03 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 23:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhFQD00 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Jun 2021 23:26:26 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA6CC061574
        for <linux-ext4@vger.kernel.org>; Wed, 16 Jun 2021 20:24:19 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id t9so3769209pgn.4
        for <linux-ext4@vger.kernel.org>; Wed, 16 Jun 2021 20:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=jnL0l4gSanLoxJ3oB0lwRZgkeyK2lS7Z5afFVDDdCf8=;
        b=qignQqSjyhtXGWqTF3Z16eFraos0pGvDPyGjp5qJqMLfL5/EjAgNV+G7HJvVXCgrhg
         e7fOPOqPtFD2fUqMRMH3FPV1yCpnYmoMASgpHgJLhjz9hQxLO5UktMLUZll7nf9Ihg3P
         7vo5POOHnEek9dbH+2heJMuzGMSVAl2d6Ci67LYN5GZMAq0XT3BWNxkcNXgMse+exQJD
         7OQx3JXlwkKB6L2WNzApHY07jJsO4V+V+vGK7e9domnuxz5lZSZma6SUH24+mRO1MP2i
         fNBjWJ4lqaZuLZ4XUHT0dA7K9SkWXfNs76vcpmPyc8fzQtk6Tg/JaEDjQYb2hSXUgSiS
         SowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=jnL0l4gSanLoxJ3oB0lwRZgkeyK2lS7Z5afFVDDdCf8=;
        b=O4/50unQihwN2tROEk6U39VMqat8WsfMQZ1VlPkpB12rqP8K67RA/OJJ/oEU5a0Rvc
         zWwHgws737Ls2WLCkpOtpSmCkzzrixbGUxOp+5nycPJtlUg6/0ExFYEUAdRtUygwDghR
         cFcbO0TEMseNvF0EiJV7ZMVYMdfxcvTbV5Ar6sxAnm3lpzbd5Armryp131NB325oH3H1
         brAKvjYP86xY/72EWfcNR1bL6NFrXIm8vyPXcWK8/EmQ0LxL6ceQU/PVVSZE4A1LndGb
         mOGmZ2CRbrKkT01SKBKR+ZdizXjGenmi0rt+uuizClD/HqgYlTGLuHd24gGtrXOh45r8
         UOpw==
X-Gm-Message-State: AOAM533gbHgFIzR3az9vBOSDH0H+VxMrupMqRyrj6ccDTDHqa3zwR7/q
        iNNDD+FYJUwHAPNOyr99/xxZ6Q==
X-Google-Smtp-Source: ABdhPJzLYhOaEg75n/LGANiBpuFNtSpEdw8XjDdbE7SwrlOZUZwdc4e6aV3enNFqEdGh+ah4l+lKTQ==
X-Received: by 2002:a63:4554:: with SMTP id u20mr2869585pgk.23.1623900258577;
        Wed, 16 Jun 2021 20:24:18 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id 76sm3356243pfy.82.2021.06.16.20.24.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jun 2021 20:24:17 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <B8EDEC30-2EB9-416A-BBDE-EF761CA61F38@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_45CD5169-4240-4FD5-ADF5-B94309E275F0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/4] ext4: Move orphan inode handling into a separate file
Date:   Wed, 16 Jun 2021 21:24:15 -0600
In-Reply-To: <20210616105655.5129-3-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
To:     Jan Kara <jack@suse.cz>
References: <20210616105655.5129-1-jack@suse.cz>
 <20210616105655.5129-3-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_45CD5169-4240-4FD5-ADF5-B94309E275F0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> On Jun 16, 2021, at 4:56 AM, Jan Kara <jack@suse.cz> wrote:
> 
> Move functions for handling orphan inodes into a new file
> fs/ext4/orphan.c to have them in one place and somewhat reduce size of
> other files. No code changes.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Cheers, Andreas






--Apple-Mail=_45CD5169-4240-4FD5-ADF5-B94309E275F0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmDKwF8ACgkQcqXauRfM
H+DU2RAAq9/B1FJyJ+2TT7T1ojMkDUE0fgX1mNglpEZtTEczcb2VLYZJ/dorVgB7
dux5Q/n7u4XRlDSnB8jJ47igEWb60KntC/k0DHfTrJuXWSeRJcfSabhqwSNPWtJg
UxpjAf/eOnPcfoV0NJddzqf0PcHB1zZ7s5j2YdWqbIHFkbKNr/xIS7h2taanjZDp
vmjOYwY1KSha8TAILgWB61+AbY0NGjllcam54pJYyTXK2gKbj49GdT1E7wce7Sve
XdQ6+v4fp/tVvhHSNr0+RHWi69UVUMWXUVYx1v1z8X4hIx8JGWmRoRt6Y1BMwGji
XZu8WBhHkYKTaAk8I74PUBbZy97wVYldbiGqnm2c+pA9ip7Ce0mcMRKMXGjvyWms
e2JBaOjddtFEo1QuFoSR84tpFIs0bLcjiRtQLITmKFHxOM4dVrZACGEyrR+xE7Y5
vVGXupJoEE7gA5NFj+tqqxQyt1mCaRnrS5o4VXQ3y+mjCrxjdnjNxM3ZEQfVeYP/
/uZNSy5QjxSQxUOma/xK/jFDd/3EKy8tJiadwnBQ8Zo89CynIchFF42SKcuduCv0
7Rhqk05hzRl4pQy6Qd5QCN4NoaPrpenOfQKnyeq4jQPMeNvOOLqba6DNff9/7MJ3
IDugWYnEuThyLB1UcmrykzUt+7dfwUA050L3ewoPEjznd9Ssd3U=
=lxI8
-----END PGP SIGNATURE-----

--Apple-Mail=_45CD5169-4240-4FD5-ADF5-B94309E275F0--
