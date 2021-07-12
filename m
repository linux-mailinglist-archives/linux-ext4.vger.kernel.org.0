Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B1F3C6282
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jul 2021 20:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbhGLSXC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Jul 2021 14:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhGLSWy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Jul 2021 14:22:54 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78B3C0613DD
        for <linux-ext4@vger.kernel.org>; Mon, 12 Jul 2021 11:20:05 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id oj10-20020a17090b4d8ab0290172f77377ebso525437pjb.0
        for <linux-ext4@vger.kernel.org>; Mon, 12 Jul 2021 11:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=fYspwO4tW3nNUp8HI1+IXsYMVvUcOci7WXUstgzBO+w=;
        b=FKJ9cm5x+/IRqt9Apn8p1/1HaFSSDenL6PGKmM22hy8UAm1QSOBO+srLS1CEcfe2bD
         Bhlv8fyHSK0c5qxojNDzKXgBt6lEDIxMyOfOGtxxD2q3HEil58CI5YItoHRoKWy8W9Ve
         3eFxUOgIv9Sk+Ebb14jbV6wXismWK1Ff8AE1SP2rtFGIf+fEXmmXzDWDNkbsa1NpfbvW
         uI3LGw/+870O5G6k+H8pLKm4xFQa0WKka7xXoshI7IJoS6+qbDppvxeZMQ/cSI74/LeY
         XcIZz5f6wE60PGXuTJR+A3pD99oXKdQiIAQrwDfWM/UhNlxXvNdD/wwBgeENXOVs/xJl
         u5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=fYspwO4tW3nNUp8HI1+IXsYMVvUcOci7WXUstgzBO+w=;
        b=KbTYj31GYroQKDKT/FA5Hn0G4rHtYueTSUziQBF13OZfj5vP3uNClfCEXU+FWOVoNP
         5GhhZ8WJoTO3VpRQFsKUBR0WcZo+bnMDB1PARn0CbAK8ZoiwhoM3A4RVqAM6oK+I8w2x
         WQ7l66He7lO2cJbk2NjmkjdUpsa2arHnN7yqAgDgg5pEPGk3zM5/Ado/hBTTt+nx53eK
         axLjwpm3P5B9kwX25tW6+7iIJ33qaThHOJyY+xdzt3O52xBxIf+KkkIG9isnXGGoJS6+
         bGFxuoPmAhFmZKxN/X8D1rl/z3+T8UxwFA6YdOb23B0x+XQsuK0X8Fbk/Uv3vBoc9uxa
         gsNw==
X-Gm-Message-State: AOAM531djomF0ZBNFjw3Gag8UhYnJSNivQvIBfDbUxduVvsddeWTA76X
        RY3hyzAtVixBbXKv2iwGjtyxhtfxG2Q/b0Ip
X-Google-Smtp-Source: ABdhPJzo1YVmmtv3sXcqfT0dWoxRDiNTkO9QGFeIbA9fKh1ZLpnVzyB/jBZwXdKH+no2DoNH1zW45g==
X-Received: by 2002:a17:902:e8d8:b029:117:8e2c:1ed5 with SMTP id v24-20020a170902e8d8b02901178e2c1ed5mr313194plg.39.1626114005020;
        Mon, 12 Jul 2021 11:20:05 -0700 (PDT)
Received: from [192.168.10.171] (S0106bc4dfb596de3.ek.shawcable.net. [174.0.67.248])
        by smtp.gmail.com with ESMTPSA id b22sm13969248pje.1.2021.07.12.11.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 11:20:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/9] ext2fs: Drop HAS_SNAPSHOT feature
Date:   Mon, 12 Jul 2021 12:20:03 -0600
Message-Id: <41F4A61F-DB56-4814-8E52-99A742F44FAF@dilger.ca>
References: <20210712154315.9606-2-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
In-Reply-To: <20210712154315.9606-2-jack@suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: iPhone Mail (18D70)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

NAK.

We are working on a snapshot implementation for ext4, it is
just taking a lot longer that I thought it would to complete.=20

There isn't any shortage of these feature bits, so no reason to re-use them.=
=20

Cheers, Andreas

> On Jul 12, 2021, at 09:43, Jan Kara <jack@suse.cz> wrote:
>=20
> =EF=BB=BFIt has never been implemented and is dead for quite some time and=

> unused AFAICT.
>=20
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
> lib/ext2fs/ext2_fs.h | 2 --
> 1 file changed, 2 deletions(-)
>=20
> diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
> index e92a045205a9..6f1d5db4b482 100644
> --- a/lib/ext2fs/ext2_fs.h
> +++ b/lib/ext2fs/ext2_fs.h
> @@ -825,7 +825,6 @@ struct ext2_super_block {
> #define EXT4_FEATURE_RO_COMPAT_GDT_CSUM        0x0010
> #define EXT4_FEATURE_RO_COMPAT_DIR_NLINK    0x0020
> #define EXT4_FEATURE_RO_COMPAT_EXTRA_ISIZE    0x0040
> -#define EXT4_FEATURE_RO_COMPAT_HAS_SNAPSHOT    0x0080
> #define EXT4_FEATURE_RO_COMPAT_QUOTA        0x0100
> #define EXT4_FEATURE_RO_COMPAT_BIGALLOC        0x0200
> /*
> @@ -926,7 +925,6 @@ EXT4_FEATURE_RO_COMPAT_FUNCS(huge_file,        4, HUGE=
_FILE)
> EXT4_FEATURE_RO_COMPAT_FUNCS(gdt_csum,        4, GDT_CSUM)
> EXT4_FEATURE_RO_COMPAT_FUNCS(dir_nlink,        4, DIR_NLINK)
> EXT4_FEATURE_RO_COMPAT_FUNCS(extra_isize,    4, EXTRA_ISIZE)
> -EXT4_FEATURE_RO_COMPAT_FUNCS(has_snapshot,    4, HAS_SNAPSHOT)
> EXT4_FEATURE_RO_COMPAT_FUNCS(quota,        4, QUOTA)
> EXT4_FEATURE_RO_COMPAT_FUNCS(bigalloc,        4, BIGALLOC)
> EXT4_FEATURE_RO_COMPAT_FUNCS(metadata_csum,    4, METADATA_CSUM)
> --=20
> 2.26.2
>=20
