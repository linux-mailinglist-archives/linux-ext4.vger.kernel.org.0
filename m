Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5DC3C6BE8
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jul 2021 10:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbhGMIOY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jul 2021 04:14:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53314 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbhGMIOX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jul 2021 04:14:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6C15C20070;
        Tue, 13 Jul 2021 08:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626163893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SNtKVsmM2F56kmqpyq6tmBqbOaHw1Fx7Z4giqyy5N1I=;
        b=I2fF7W9UrNAWtryjiU0PyLPWyjXHix5gM8+xgODUocVJqqDOMnrNwZL0pTdtAzWt4mrg5D
        7h804R0+Eg8yNOJlk1rXKDOUNPxy3lECWE0nk110YJYiYvZ4mx7bw9AVBHhaZY64faF8kV
        Td6vDNxpGP1SztSkW4Ub23Y5HQjXeZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626163893;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SNtKVsmM2F56kmqpyq6tmBqbOaHw1Fx7Z4giqyy5N1I=;
        b=PryU6t5okWyxK+jgvmajaVddfhK9s+KYw+GSl3AqfIiTou3p7pHi/AmTKCDhr8PJC7vrVc
        Msc4MOf7KeGsC/Bw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 58831A3B83;
        Tue, 13 Jul 2021 08:11:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 38ED21F2AA9; Tue, 13 Jul 2021 10:11:33 +0200 (CEST)
Date:   Tue, 13 Jul 2021 10:11:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/9] ext2fs: Drop HAS_SNAPSHOT feature
Message-ID: <20210713081133.GA12142@quack2.suse.cz>
References: <20210712154315.9606-2-jack@suse.cz>
 <41F4A61F-DB56-4814-8E52-99A742F44FAF@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41F4A61F-DB56-4814-8E52-99A742F44FAF@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

On Mon 12-07-21 12:20:03, Andreas Dilger wrote:
> NAK.
> 
> We are working on a snapshot implementation for ext4, it is
> just taking a lot longer that I thought it would to complete. 
> 
> There isn't any shortage of these feature bits, so no reason to re-use them. 

Sure. I thought this feature bit was a leftover from experimental ext4
snapshot feature Amir Goldstein was playing with some 10-15 years ago and
which never completed. If there's somebody working on this, I'll allocate a
different bit.

								Honza

> 
> Cheers, Andreas
> 
> > On Jul 12, 2021, at 09:43, Jan Kara <jack@suse.cz> wrote:
> > 
> > ﻿It has never been implemented and is dead for quite some time and
> > unused AFAICT.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> > lib/ext2fs/ext2_fs.h | 2 --
> > 1 file changed, 2 deletions(-)
> > 
> > diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
> > index e92a045205a9..6f1d5db4b482 100644
> > --- a/lib/ext2fs/ext2_fs.h
> > +++ b/lib/ext2fs/ext2_fs.h
> > @@ -825,7 +825,6 @@ struct ext2_super_block {
> > #define EXT4_FEATURE_RO_COMPAT_GDT_CSUM        0x0010
> > #define EXT4_FEATURE_RO_COMPAT_DIR_NLINK    0x0020
> > #define EXT4_FEATURE_RO_COMPAT_EXTRA_ISIZE    0x0040
> > -#define EXT4_FEATURE_RO_COMPAT_HAS_SNAPSHOT    0x0080
> > #define EXT4_FEATURE_RO_COMPAT_QUOTA        0x0100
> > #define EXT4_FEATURE_RO_COMPAT_BIGALLOC        0x0200
> > /*
> > @@ -926,7 +925,6 @@ EXT4_FEATURE_RO_COMPAT_FUNCS(huge_file,        4, HUGE_FILE)
> > EXT4_FEATURE_RO_COMPAT_FUNCS(gdt_csum,        4, GDT_CSUM)
> > EXT4_FEATURE_RO_COMPAT_FUNCS(dir_nlink,        4, DIR_NLINK)
> > EXT4_FEATURE_RO_COMPAT_FUNCS(extra_isize,    4, EXTRA_ISIZE)
> > -EXT4_FEATURE_RO_COMPAT_FUNCS(has_snapshot,    4, HAS_SNAPSHOT)
> > EXT4_FEATURE_RO_COMPAT_FUNCS(quota,        4, QUOTA)
> > EXT4_FEATURE_RO_COMPAT_FUNCS(bigalloc,        4, BIGALLOC)
> > EXT4_FEATURE_RO_COMPAT_FUNCS(metadata_csum,    4, METADATA_CSUM)
> > -- 
> > 2.26.2
> > 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
