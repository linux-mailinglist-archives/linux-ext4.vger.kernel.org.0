Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D70B2DD4C0
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Dec 2020 17:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgLQQBt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Dec 2020 11:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgLQQBt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Dec 2020 11:01:49 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03639C0617A7
        for <linux-ext4@vger.kernel.org>; Thu, 17 Dec 2020 08:01:09 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id e2so8211132plt.12
        for <linux-ext4@vger.kernel.org>; Thu, 17 Dec 2020 08:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:mime-version:subject:from:in-reply-to:cc
         :date:message-id:references:to;
        bh=icp/IKUW+D+8svyJhBjTktJyI3qp7MyBJtiHTvex320=;
        b=nWKwl2cWrmaw6NbX0lVrkhqjkDzPqZUnsfILL5qB5iPiAKbKqL3WsnF8VuJziWfrwS
         IvJoH7omaTa4eSiVNsNNxRGpMPbVVROrAHYUmsdtXRGmee2ArQapAC9UFofp7p42Mg20
         m+deaBw8hQgh2njZq0+qIlkQEzueomcseVoLCblG9SWwWDSah/m/P0nAQShgfN4/DMWA
         3wvhF8LSKfZMxTP89vTJSzcSeV7wN+Om/WhHTHmvAc6BVL5yN0FpLnrkXAO1/d9XXPWJ
         jy0HWZPiYsAh/lvcEmWBKqapKIqYDRpcAbqMWkGMWRVrvECA+0PGg1YPYKEkudU0cdak
         G5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:mime-version:subject
         :from:in-reply-to:cc:date:message-id:references:to;
        bh=icp/IKUW+D+8svyJhBjTktJyI3qp7MyBJtiHTvex320=;
        b=QZAHD3d8ny7uiDa/48aUrHlc5GVoCOvZ8ftRuzjqRniBmDY9QYS8CyCffwfwGelZN+
         bvfTF5mC9mW9P9AfzQmMhm5NtJMb47ibx7bM1Hytdv4lLiuvSwvXeDAleAVSaJNw85s7
         ssy6L0QyCO8c5tYAtDjdbqxQ0cjmEuZjjjyZqC+MBFq+cA2mw5nq6yed6QmK4oQG6Iey
         ixRYpBZZgJfYqVafXC+A6YUXirJnNT7X6FpqG7GwS6+LaLYObG5AitvGXS+C3ki/WDm2
         0gW/GU3T4B7bDfkDYINcZ8N9v6yLKdRalZ7CicpHX9bYvEVVD/98mQGqIJmwJqAf+bfP
         EXzw==
X-Gm-Message-State: AOAM533Lf0Mi3VmQLJJHwNoTvzWP+4er5eXooxwj6SJtkP8QF4wXaICI
        D9yFJTsvgx6qRZDyEYg1lOUE6w==
X-Google-Smtp-Source: ABdhPJzM5FbFIn80Q5axyzK3yHT9UeWLM2jZ1F3klkYNDTabXMJFq7kSyBY6QIKtic5Opu9bL3Epiw==
X-Received: by 2002:a17:902:8f90:b029:db:fc74:c59a with SMTP id z16-20020a1709028f90b02900dbfc74c59amr7587823plo.58.1608220867051;
        Thu, 17 Dec 2020 08:01:07 -0800 (PST)
Received: from [192.168.10.175] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id c62sm6305462pfa.116.2020.12.17.08.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 08:01:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RESEND 4/8] ext4: add the gdt block of meta_bg to system_zone
From:   Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <X9kY0htqhvFDNn20@mit.edu>
Cc:     brookxu <brookxu.cn@gmail.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org
Date:   Thu, 17 Dec 2020 09:01:05 -0700
Message-Id: <116027E4-A824-4138-84BC-39562DF70548@dilger.ca>
References: <X9kY0htqhvFDNn20@mit.edu>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
X-Mailer: iPhone Mail (18B92)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

An extra 20-30MB of RAM for mounting a 1PB filesystem isn't
a huge deal. We already need 512MB for just the 8M group descriptors,
and we have a 1GB journal.

I haven't heard any specific performance issues with block_validity,
but it may be newer than the 3.10 kernels we are currently using on
our servers.=20

Cheers, Andreas

> On Dec 15, 2020, at 13:13, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>=20
> =EF=BB=BFYou did your test on a 80T file system, but that's not where some=
one
> would be using meta_bg.  Meta_bg ges used for much larger file systems
> than that!  With meta_bg, we have 3 block group descriptors every 64
> block groups.  Each block group describes 128M of memory.  So for that
> means we are going to have 3 entries in the system zone tree for every_
> 8GB of file system space, 383,216 entries for every PB.  Given that
> each entry is 40 bytes, that means that the block_validity entries
> will consume 15 megabytes per PB.
>=20
> Now, one third of these entries overlap with the flex_bg entries
> (meta_bg groups are in the first, second, and last block group of each
> meta_bg, where are 64 block groups in 4k file systems), and of course,
> the default flex_bg size of 16 block groups means that there are
> 524,288 entries per PB.  So if we include all backup sb and block
> groups, in a 1 PB file system, there will be roughly 786,432 entries
> in a 1 PB file system.  (I'm ignoring the entries for the backup
> superblocks, but that's only about 20 or so extra entries.)
>=20
> So for a flex_bg 1PB file system, the amount of memory for a
> block_validity data structure is roughly 20M, and including all backup
> descriptors for meta_bg on a flex_bg + meta_bg setup is roughly 30M.
>=20
> I agree with you that for a non-meta_bg file system, including all of
> the backup superblock and block group descriptors is not going to be
> large.  But while protecting the meta_bg group descriptors is
> worthwhile, protecting the backup meta_bg's is not free, and will
> increase the size of the tree by 33%.
>=20
> I'm also wondering whether or not Lustre (where they do have some file
> systems that are in the PB range) have run into overhead issues with
> block_validity.
>=20
> What do folks think?
>=20
>                       - Ted
