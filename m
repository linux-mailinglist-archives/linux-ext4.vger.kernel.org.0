Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33593A7883
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jun 2021 09:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhFOHym (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Jun 2021 03:54:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42320 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhFOHyk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Jun 2021 03:54:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D6EA0219CD;
        Tue, 15 Jun 2021 07:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623743552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tAJ6aPIop6SIFrXfkq9iI9s2sPFbjWEwGMM4+nWtP6s=;
        b=k5cWbhp/IIrR/fwQXp72sUXztrKm4+2C0eAnU1TAmucCPG7MlfTKzJek66ApS2IE0JsEWl
        1uZztnjyzhzzt7q43prB3SLwgpivul9G+glLegsMN++eMzs5wz6vjoLfR1NQr/X6JAH/qF
        UP3eDadbtxGMPDGuGbNvXHjoDEAn+tQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623743552;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tAJ6aPIop6SIFrXfkq9iI9s2sPFbjWEwGMM4+nWtP6s=;
        b=UZenumCyG8ZXXKY5yW/dodKIrCHFw+n7v0QxpIa6fMGVnlDy/zSFxFx9TRtCOzpIc+pp8b
        1LYZcJafEb1AJnDg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 89D16A3B84;
        Tue, 15 Jun 2021 07:52:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6772E1F2C88; Tue, 15 Jun 2021 09:52:32 +0200 (CEST)
Date:   Tue, 15 Jun 2021 09:52:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] tune2fs: Update overhead when toggling journal feature
Message-ID: <20210615075232.GE29751@quack2.suse.cz>
References: <20210614212830.20207-1-jack@suse.cz>
 <E6977B7F-091D-40E9-B0CD-BB3D8B7FE287@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E6977B7F-091D-40E9-B0CD-BB3D8B7FE287@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 14-06-21 15:38:57, Andreas Dilger wrote:
> 
> > On Jun 14, 2021, at 3:28 PM, Jan Kara <jack@suse.cz> wrote:
> > 
> > When adding or removing journal from a filesystem, we also need to add /
> > remove journal blocks from overhead stored in the superblock.  Otherwise
> > total number of blocks in the filesystem as reported by statfs(2) need
> > not match reality and could lead to odd results like negative number of
> > used blocks reported by df(1).
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> You could add:
> 
> Fixes: 9046b4dfd0ce ("mke2fs: set overhead in super block")
> 
> and
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Thanks!

> That also makes me wonder if resize2fs also needs to recalculate or
> invalidate the s_overhead_clusters field when adding new block groups.
> It *looks* like that is done correctly in adjust_fs_info() already?

Yes. From a quick look I had when doing this tune2fs patch I've noticed
that adjust_fs_info() just zeros s_overhead_clusters which makes the kernel
compute the overhead instead...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
