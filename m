Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55A2A1709F4
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Feb 2020 21:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgBZUnY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Feb 2020 15:43:24 -0500
Received: from mail-pj1-f45.google.com ([209.85.216.45]:38815 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbgBZUnY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Feb 2020 15:43:24 -0500
Received: by mail-pj1-f45.google.com with SMTP id j17so150614pjz.3
        for <linux-ext4@vger.kernel.org>; Wed, 26 Feb 2020 12:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=XKa1DPnkzfMuVk1btZE4YmnN0uE9EQK8P7sBCiXotVQ=;
        b=yw2QYhy96ruIvPHvsRFQ5pmVYRDG3Ayl+AtsTq/OmUsw1s+rQeNnsK9g9oWrb2HqLY
         Wv6BSNfpV7TG6/s/UiHu5N0dQlJNmVi1Qm+jJeAc8ar9DNTaC2erK7/x5slG+hriONYu
         QAUUzxM21bu4kc2LoByDe37Zzlb/ltpq7foElOf2TaBvmTX4jcsGVEnqxyqycilG6jIW
         mkqsKW68p/IWGJkb5R8f6vFnd8P0UiPUH15Dn5cvK8k3OV/aZmmsu1wK+bkSDNTFnIMG
         sSX/ZmtcgxgCjBuTG4PskOZOPvwTBCaEsRS6UX2xlgmT9MCJofk4y05A7hz/UnseCusI
         lCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=XKa1DPnkzfMuVk1btZE4YmnN0uE9EQK8P7sBCiXotVQ=;
        b=eQI0IRAel7ze1NgmP/KV+0L27XXGYcL+WGHrw80OBZdWa0ziCwlCAA8/VRTdg5NMJh
         +5sqekALSKs/ibXnkOa9e3gy0YXVShEdkXgNs1jQjrspGqziB+nuYtGH7DqWj5facYFS
         NaABVUb3YyXZNNcavRve5JcJdwPR4c+mPQ+Sf4Rsh7bO5bEtSBS4Io/ju/Djg8wYmieY
         dSa2lliAuLD5C11M6nLxiFfGrgtEGOJWeTY1ajFpJf7lcJnHdaEuFBsRMQLg0PKxYIjf
         JOS1boAK9s4sC9lvJGFQLkgSHF74JQu8FbJIxociZNiJ7wIx6ZAtGEuJwwolsUPhOjGI
         WmHA==
X-Gm-Message-State: APjAAAVIzaPRE2QxwC6h4JYYj7PLzilHR5c/s/jpqsTw6VVs/U1uhYFY
        VUmpn0Bp3GZS9XUcX4OQOY3j4g==
X-Google-Smtp-Source: APXvYqwh0QgYY1f8BlIy/0OEmgP/Kb9fPUa5PHkwF1MJZtPcRmpVL3ZItzcqXC5MNSIRT5vpIzkD5w==
X-Received: by 2002:a17:902:8549:: with SMTP id d9mr1043862plo.153.1582749803765;
        Wed, 26 Feb 2020 12:43:23 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id c68sm4264417pfc.156.2020.02.26.12.43.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 12:43:22 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <793F980F-5708-4DBB-8406-585E34C68CDB@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_2F617E18-9892-4A2A-89D5-40F995837E43";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Getting issue while creating ext4 file system
Date:   Wed, 26 Feb 2020 13:43:20 -0700
In-Reply-To: <CAG-6nk9iqbkwUh_=v0xrH+YN81tN4eWWNQzOM8NHr-3uR8fveQ@mail.gmail.com>
Cc:     linux-ext4@vger.kernel.org
To:     Alok Jain <jain.alok103@gmail.com>
References: <CAG-6nk9iqbkwUh_=v0xrH+YN81tN4eWWNQzOM8NHr-3uR8fveQ@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_2F617E18-9892-4A2A-89D5-40F995837E43
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Feb 25, 2020, at 2:41 AM, Alok Jain <jain.alok103@gmail.com> wrote:
> 
> Hi Guys,
> 
> Thanks for your time to look into this
> While connecting a block volume to my instance I m getting the below error
> Command: mkfs.ext4 /dev/sdd1
> Error Message:
> mke2fs 1.42.9 (28-Dec-2013)
> Could not stat /dev/sdd1 --- No such file or directory
> 
> The device apparently does not exist; did you specify it correctly?
> 
> Before executing this command I did run iscsi command to attach
> followed by these partition commands, all completed successfully
> parted -s -a optimal /dev/sdd mklabel gpt
> parted -s -a optimal /dev/sdd mkpart primary '1MiB -1'
> Any idea?

This doesn't look like an ext4 issue.  Did you actually check that
/dev/sdd1 exists (e.g. "ls -l /dev/sd*")?  You may need to tell the
kernel to reload the partition table and convince udev to create it.

If it does exist, can you dump the partition table with something
like "fdisk -l /dev/sdd", and read some data from the device with
e.g. "file -s /dev/sdd1" or similar?

Cheers, Andreas






--Apple-Mail=_2F617E18-9892-4A2A-89D5-40F995837E43
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5W2GkACgkQcqXauRfM
H+Cjsw/+Ii8v6uYkGS++QJ/1GUBRQ2OC7Vx3qUMCgJH5MdF+tyBOcGMo3pAMqoZ6
6lz3W+LUPVwiIuX+ZHvcS8Qk5ka473Bmv9Wonz1xW/H9fmnmcBBmtH2REsNK73me
Vh9BJM8EV2TSpp8oirrPt6R4g0D+8gDDco3hKGqN1LJZ6Ahd+qSxyjzMt5pFZUrU
XPX+UG0s7BqYusBEdWnXiB+dC+aHokhsIbOJWvgX7FNW5Ew8YKSBuZrFx3rsVrOu
XKLmje7R6NQVUDsU5dM69mSdwWzoZVWdktZnSBmNk0RyU96LKWwNZBDWPrKJ4T8R
uac6sPOhYeYGR8lPifTMN7/PLyYZ+iv+y0UPJYXvijZ5HN47ReeEbxzxMS6voQIn
/PE4KKa7abPZcs2L0dAwwxD0juxmUuXZc7fjJziJmskSm7dKeqDIxYmOQ8b9YlbN
CshEt1yYXaO3azDMi9ceaqryB+FCB57PU/x0GmU6+o4YWqYcJ/7hnRA4rG4m2nZy
Eki1WZCgUPTdrMqnWE2qtZl5MtDLw/yUtZgqDHtvhL4xaLxyOrDrbkAIlFB2ikIn
US5RDk9t66La0RZebhF1ZK8rPPfiDQMCuYZLLOyHDIhukpJ5La+RXBQNSWToVsGA
Cuv5djFA+2XXNnRgOK5t/drBjHeSmayS+0QUWlCdSM6ZH709YYU=
=6ndE
-----END PGP SIGNATURE-----

--Apple-Mail=_2F617E18-9892-4A2A-89D5-40F995837E43--
