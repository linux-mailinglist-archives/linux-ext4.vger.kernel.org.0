Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5E21F208F
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Jun 2020 22:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgFHUPe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Jun 2020 16:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgFHUPc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Jun 2020 16:15:32 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EFFC08C5C2
        for <linux-ext4@vger.kernel.org>; Mon,  8 Jun 2020 13:15:30 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so7091557plv.9
        for <linux-ext4@vger.kernel.org>; Mon, 08 Jun 2020 13:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ltVdg62bbsvMxy2YO1h7X7Jh58S8gqhfb6LIgF973uo=;
        b=zoFWsNWQ3fCp8IafL6SwGh3IfVGi7UILpucb1GuPZmaPxJb8OLtckm5llBIWAgX5AA
         GCr/2Yi+/bZKvE0woQB5oaLsOQ831gLjNb/zH4C+crXVgEyHtz3XfxV+9k0LAFFhCzFB
         qPBtfJb5kpBQHBtXi3jeCYUzPCbag96mMe3gHyy5i0NTsmusd/1Mv/dssF1WlZ4SZsQI
         NjcEMfarcY50pvCsPLzDFtUBmw5sCYDpqKM+E9wEI/s/LhW7Kws2wd6cHWH02AOj4R9k
         1UZst+FcbepSKu93/bfoP4lZ3dbjJjDXOez9pG/MJMfZ/rC0qy5CmSDIuCeYoBqPrhH7
         /tKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ltVdg62bbsvMxy2YO1h7X7Jh58S8gqhfb6LIgF973uo=;
        b=Zu6qONcseLcHgKMAv7RfxzHdBrOHZhNHPmlSiokG0IxXKoWkxJikm6tyPp/oF1sD81
         oAxYodiwjZ6a0Q6jvnQw1Ex5y9dTyku8lvZbkuAsdXROCiLzM9Gmgej71mblvhBM81tM
         dobFCmeJYW5wQVlidkKem44GLL4O0E3HPckMv4Idt6x01iQzVKlmh0a8aMLWoco5Izx9
         xvq7r5aXhTcyCU23bBUWnS6+wpyH18dZ1KPyV/4wSYTxsxzoGjGb+5uRAVZEw8PoF7EM
         W9r880y2jO8Rp72V26HJW4YxHmI6HnudBdr+h7NtX4GiDyjvHWuwb3+obNgxSUcnUZOb
         ES3A==
X-Gm-Message-State: AOAM532GYuBJbC6Jodnsr04lWvmyvH9KPaTHrYVWkIqkOO+jXEQezXMV
        EB5n50bVS5U87TN1mtMDV5stUnKtFfw=
X-Google-Smtp-Source: ABdhPJyjhF33CtsQiMELbQWNe2Kc8cmN2K04Uavyh9XyMnPvZLHpcKNOmpszyctaEdRXtvNMQb2OYQ==
X-Received: by 2002:a17:902:8b84:: with SMTP id ay4mr408415plb.114.1591647330327;
        Mon, 08 Jun 2020 13:15:30 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id 128sm7795598pfd.114.2020.06.08.13.15.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 13:15:29 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <D642F0D8-160C-4DB0-9ABB-AA2F709698AE@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_19D03D76-6AB0-4CBE-A5C7-227C9C34FEFC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: ext4 filesystem being mounted at /boot supports timestamps until
 2038
Date:   Mon, 8 Jun 2020 14:15:05 -0600
In-Reply-To: <b944159f-01cb-9e48-309b-fe13e25e2340@thelounge.net>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Reindl Harald <h.reindl@thelounge.net>
References: <b944159f-01cb-9e48-309b-fe13e25e2340@thelounge.net>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_19D03D76-6AB0-4CBE-A5C7-227C9C34FEFC
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jun 6, 2020, at 10:45 AM, Reindl Harald <h.reindl@thelounge.net> wrote:
> 
> are you guys kidding me?
> 
> * create a new vmware vdisk with 512 MB
> * kernel 5.7.0, e2fsprogs-1.45.5-1.fc31.x86_64
> * mount the filesystem
> 
> Jun  6 18:37:57 master kernel: ext4 filesystem being mounted at /boot
> supports timestamps until 2038 (0x7fffffff)
> 
> https://lore.kernel.org/patchwork/patch/1172334/

Hi Reindl,
It isn't clear if your complaint is about the warning message, or the
fact that this is an issue with the newly-formatted filesystem?  The
*issue* of 2038 timestamps has always existed, but the warning message
is newly added so that people have time to fix this if necessary.

I wonder if it makes sense to add a superblock flag like "yes, I know
this is not 2038 compliant, and I don't care"?

> -----------------------------
> 
> this does *not* happen when the vdisk is 768 MB instead just 512 MB
> large - what's te point of defaults which lead to warnings like this in
> 2020?

This is a matter of space usage. Enabling the 64-bit timestamps requires
that the filesystem be formatted with 256-byte inodes, since there wasn't
enough space in the original 128-byte inodes for the larger timestamps
(among other things).  That means either 1/2 as many inodes for the
filesystem to fit in the same metadata space, or double the amount of
metadata usage for the filesystem (reducing free space).

The assumption is that smaller filesystems like this are unlikely to be
used for storing long-term data, so maximizing the usable space is most
important.  It is unlikely you will be using the same /boot filesystem
in 18 years, and if you are it is even less likely that it is being
updated on a regular basis.

It is possible to enable the larger inodes for any size filesystem by
formatting with "mk2fs -I 256 <other options> <device>".  See "man mke2fs"
for full details.

Cheers, Andreas






--Apple-Mail=_19D03D76-6AB0-4CBE-A5C7-227C9C34FEFC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl7enEsACgkQcqXauRfM
H+D6gA/9HHgMTxassddil0iyYgIGu1APrqqsJTYjtftlsEcv89E9kea5ESSyN6K5
uBqmaw/x8thAN0GAPvnCqWBcDBNJiaFqhIXNcOEhcrftPIH4cMvqXNZhVFKwAyy7
h//EznOJEkJdFfjFIBQRanwSMNlzEmevENrl0YBXGtO9GNkV9z6uBGlUVFFmBNus
NnOlTTqN5Vb26jjR5GTiy1ssKWtEPRg02QZrAENDQIrRG70V2zdjvwMXMyxVFs5t
dmjBs+L2yo/V00LKWG8F1SGCDVDutbr8k8PPk7t04wzMSEEJBSkfO5H+G3tD7evF
vfy31AXuv6FScq4nCgdhTe0wcMRzQLTKAAqw4tpOBawSuYn2Rl+J1TOEuLIjEo6S
jBTy0RSAtc/5WJQy5PuXXgb0HxmdMnptD7dHWdIy6KJZfOWEJTjVpa6Yr0Uxv5aT
ExKoLnSDJuIeoHWXpm2SNYwPMQTuXnJ51Zs9D41TTEA7yGsebsZpeBr6eRK07z/o
mbAMYJ5793QlljdVcLqUt0jIEhq7C95oS/ydM6/CSY7eHPKpBX9AAuRm0fqui+HQ
t+eu2ctY71MlIfMtUMRlvqv94htb+/XJ7xEvHHQ3q7sJrQpn3kv1ypUF38mrPvIZ
Qr5dUJ8EU4guYF9Jyi/6fTk2gkqROV+I++hEwmq7zelijbj93f0=
=2E5w
-----END PGP SIGNATURE-----

--Apple-Mail=_19D03D76-6AB0-4CBE-A5C7-227C9C34FEFC--
