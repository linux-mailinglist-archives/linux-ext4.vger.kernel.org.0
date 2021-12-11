Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2944470F98
	for <lists+linux-ext4@lfdr.de>; Sat, 11 Dec 2021 01:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbhLKAxJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Dec 2021 19:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbhLKAxI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Dec 2021 19:53:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB3FC061714
        for <linux-ext4@vger.kernel.org>; Fri, 10 Dec 2021 16:49:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66B4CB82A17
        for <linux-ext4@vger.kernel.org>; Sat, 11 Dec 2021 00:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6649C00446;
        Sat, 11 Dec 2021 00:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639183770;
        bh=3TacPqiOfvaZ7FQiMEYFofH+w6PTBIfnz0nHQRmqR4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WnB9nNlNe7oPrT+uboqStkM/+5QMU/yPexrbCGjaEl2Xsp7JY8g1JsxRxKnPZ1Eu5
         Z/BjInimJYR4hxyoJ89JVRydxF1QBR3/UtZa6eYqlFwMluNqTvcgmcDtu043q9GfSE
         e5VkWcDgNxAjNOo2O/6b/0Dw5mcwxWpJqyswbBYlt0/zKOyWz/MIsT7AngyDJrQGDu
         nwyI8JuVVid39+RPC/gmwnLQdLrqb06MQjo/lBdsaOu/Hfb7oHOhthkxlonyJeht9A
         1DWHrF4t2aqH9cocWL7IGqFLujSMFxgLOW7W+pNjcI58c/v+jfFAkWDeivaJaDsdL1
         8UWmw+lEzIH+Q==
Date:   Fri, 10 Dec 2021 16:49:29 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Y. Ts'o" <tytso@MIT.EDU>,
        Roman Anufriev <dotdot@yandex-team.ru>,
        linux-ext4 <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Wang Shilong <wangshilong1991@gmail.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] ext4: compare inode's i_projid with EXT4_DEF_PROJID
 rather than check EXT4_INODE_PROJINHERIT flag
Message-ID: <20211211004929.GB69182@magnolia>
References: <1638883122-8953-1-git-send-email-dotdot@yandex-team.ru>
 <alpine.OSX.2.23.453.2112071702150.70498@dotdot-osx>
 <Ya+3L3gBFCeWZki7@mit.edu>
 <F12B316D-D695-4B38-ABEA-D5F558696E9A@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F12B316D-D695-4B38-ABEA-D5F558696E9A@dilger.ca>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 09, 2021 at 03:53:55PM -0700, Andreas Dilger wrote:
> On Dec 7, 2021, at 12:34 PM, Theodore Y. Ts'o <tytso@MIT.EDU> wrote:
> > 
> > On Tue, Dec 07, 2021 at 05:05:19PM +0300, Roman Anufriev wrote:
> >>> Commit 7ddf79a10395 ("ext4: only set project inherit bit for directory")
> >>> removes EXT4_INODE_PROJINHERIT flag from regular files. This makes
> >>> ext4_statfs() output incorrect (function does not apply quota limits
> >>> on used/available space, etc) when called on dentry of regular file
> >>> with project quota enabled.
> > 
> > Under what circumstance is userspace trying to call statfs on a file
> > descriptor?
> 
> Who knows what users do?  Calling statfs() on a regular file works fine
> (returns stats for the filesystem), so I don't see why it wouldn't be
> consistent when calling statfs() on a file with projid set?
> 
> Darrick, how does XFS handle this case?  I think it makes sense to be
> consistent with that implementation, since that was the main reason to
> remove PROJINHERIT from regular files in the first place.

As far as I can tell, the existing ext4 implementation handles this
exactly the same that XFS does.  I would leave this alone on the grounds
that we don't really want inconsistent behavior.

--D

> 
> > Removing the test for EXT4_INODE_PROJINHERIT will cause
> > incorrect/misleading results being returned in the case where we have
> > a directory where a directory hierarchy is using project id's, but
> > which is *not* using PROJINHERIT.
> 
> One alternative would be to check the PROJINHERIT status of the parent
> directory after calling statfs() on the regular file?  That should
> keep the semantics for PROJINHERIT the same, but avoid inconsistent
> results if called on a regular file:
> 
> #ifdef CONFIG_QUOTA
> -	if (ext4_test_inode_flag(dentry->d_inode, EXT4_INODE_PROJINHERIT) &&
> +	if (ext4_test_inode_flag(S_ISDIR(dentry->d_inode) ? dentry->d_inode :
> +			   dentry->d_parent->d_inode, EXT4_INODE_PROJINHERIT) &&
> 	    sb_has_quota_limits_enabled(sb, PRJQUOTA))
> 		ext4_statfs_project(sb, EXT4_I(dentry->d_inode)->i_projid, buf);
> #endif
> 
> Roman, does that work for you?
> 
> Cheers, Andreas
> 
> 
> 
> 
> 


