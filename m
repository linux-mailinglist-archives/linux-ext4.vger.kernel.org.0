Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC45F30D90D
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Feb 2021 12:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhBCLoN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Feb 2021 06:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbhBCLnn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Feb 2021 06:43:43 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF07AC061573
        for <linux-ext4@vger.kernel.org>; Wed,  3 Feb 2021 03:43:02 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id my11so3301907pjb.1
        for <linux-ext4@vger.kernel.org>; Wed, 03 Feb 2021 03:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=0fZRXtXxDmQ/PG8ZhbNTsY9wLwgVOXyHP1wEYobYlhw=;
        b=2HUmN8tYQ6CqHpvL8MoXQbNiYfPxpMrgi69NqB8d361hkPl4yfXZIjpOgakeJSQVCs
         3MnvOJoAxS6sb8hYihyQe705hzQ9viI2dSqi97gbMLO2Min7t6vTCewGYuhrOeSWUrb/
         vkC8clsAm5lCr8Q7DDnJ8VQyCcD71D3VMQD/3BtJNWe7+Fbziv8GL+S7cgzAMWTZAbMY
         tK5iPs4bvP1gwzzzmOXN6efbKmxYq3e2u2hUKiQuaRauy4Fz1+ROPnE8l0vF+JB2aRTt
         PauSIt0A8RmQYvnJuxCP3Gpi9J5v66b0QmbuR9lGWKuFTQ07RYwNeEE6nKJL3h8QljHS
         EiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=0fZRXtXxDmQ/PG8ZhbNTsY9wLwgVOXyHP1wEYobYlhw=;
        b=rTAPu9kLh6dcUFo910AdFF2G752FAs9WJrKRLltE/7KPX5FqQC5jLQfxOof2/+mfr4
         qTzmR/SrSIy+9gQIz8NtftTDrJo01apWhGX3UPpTXwxQGb9lkmXYMiS98MLq/8ZXDBLl
         feJqozoILQGCCl0B2jGh+gp4ZEJq6oi8hzpO8TnsAWpWd5T+qUgG3V7OBsS8CSdln3z0
         cqSjxpkFmO+bV+fnnFbk9/YUEPr4qC/6Jso45XUHnaesFioCfczEQ1SVIrDMWuzfLgyT
         DE0WkKkH7P/mOZayvdJBnmEDUHaiOpJg7YoJIP91UeVw8jCMXD9e/mayNucvp3uX/GJA
         mopA==
X-Gm-Message-State: AOAM5313Q/5JqVfBK2ElvTmXWajwal+4HZQCemeWHHN3vEx+2kJ4tHGe
        4qfmci179oFxuJw2WKD/Fv6VRc+JYl4Nnc1y
X-Google-Smtp-Source: ABdhPJxNeEqoCgmL5BXZJKKGk6lYxmE4uQ+iL/fQ4g23RYvk8eUULBVeDep6VfML5I/CIwonzZzpyw==
X-Received: by 2002:a17:90a:1a01:: with SMTP id 1mr2754434pjk.21.1612352582444;
        Wed, 03 Feb 2021 03:43:02 -0800 (PST)
Received: from [192.168.10.175] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id n17sm1804725pjv.20.2021.02.03.03.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 03:43:01 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [ANNOUNCE] e2fsprogs v1.46.0
Date:   Wed, 3 Feb 2021 04:43:00 -0700
Message-Id: <C19684EF-B868-4FDB-9145-F02844F8DB5C@dilger.ca>
References: <YBmMlwBaoC58CARb@mit.edu>
Cc:     linux-ext4@vger.kernel.org
In-Reply-To: <YBmMlwBaoC58CARb@mit.edu>
To:     Theodore Ts'o <tytso@mit.edu>
X-Mailer: iPhone Mail (18B92)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Feb 2, 2021, at 10:36, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> =EF=BB=BFI've released e2fsprogs 1.46.0 in all of the usual places;=20
>=20
> E2fsprogs now supports file systems which have both file system
> encryption and the casefold feature enabled.  This requires Linux
> version 5.10.

Gah!  I just noticed these patches being submitted to the kernel, but
they break the dirdata format in an incompatible manner. I hadn't been
paying close attention to casefold + encryption since I thought it was
only changing the hashing function and not the actual dirent format,
and I didn't see these patches to e2fsprogs being submitted to the
list (I couldn't find them in patchworks either).

Since this hasn't been landed to the kernel yet, and 1.46.0 was *just*
released, can we roll this back and instead make the extra hash stored
in a dirdata field? Preferably #3, since #1 is the Lustre FID, and #2 was
proposed for the high 32 bits of the 64-bit inode number (though it was
never landed and I don't think it is in use anywhere).

Having just looked at these patches for the first time, I can't say for sure=
,
but it looks like only a small on-disk format change would be needed to
make both features compatible with each other.=20

There would need to be a bit set in the dirent type field to indicate that
there is a hash stored after the name:

#define EXT2_DIRENT_HASH     0x40

and the length of the hash field would be stored as the first byte. Since th=
e
hash is stored aligned on a 4-byte boundary, the length is variable
(8+alignment), but storing the length at the start would not add any more
space for 3/4 of the names due to the existing padding for alignment.=20

Cheers, Andreas=
