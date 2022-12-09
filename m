Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21E3647D5A
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Dec 2022 06:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiLIFj3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Dec 2022 00:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiLIFj2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Dec 2022 00:39:28 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFB571248
        for <linux-ext4@vger.kernel.org>; Thu,  8 Dec 2022 21:39:27 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2B95dCwN023386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Dec 2022 00:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1670564354; bh=HbOe65ehHP3ho/xcnqRX2wOXeVegN7BlodoWL8v+7KQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=CMnEoz2vt50OiReyoeE9YmSGvwOKfAVupdK5nUMMpoQxhnC+Wk17EyH8e/TBiJSbH
         a/uHPgGwkz1PicT8Dy4lyhOt2TlIWES1kd6R4ox/iaz/m5xXl10PCtV4wwCGs0KUSV
         2to5yVeOmDfDlpyVuxhAzjQsKGhhzg7h09BJJh/zcsmrYrpn3QIQLEZEcyRslE17vy
         6XisF8mZucJ96VfQikLDxpptLHHrPVeoKRCtm1jYUrq9eE+1TT2AdO3rg81QB6ONoz
         1jKvj0M2H8qS8dcAcmQuWimroLtrjtJWu4GhUnBD2BcX6rx6JqqiF3NauCdc0SCGye
         yXESIFn9DbnBQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B042B15C3AE9; Fri,  9 Dec 2022 00:39:12 -0500 (EST)
Date:   Fri, 9 Dec 2022 00:39:12 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v3 4/4] ext4: fix inode leak in
 'ext4_xattr_inode_create()'
Message-ID: <Y5LKAJCDgvB65gGm@mit.edu>
References: <20221208023233.1231330-1-yebin@huaweicloud.com>
 <20221208023233.1231330-5-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208023233.1231330-5-yebin@huaweicloud.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 08, 2022 at 10:32:33AM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> There is issue as follows when do setxattr with inject fault:
> [localhost]#fsck.ext4  -fn  /dev/sda
> e2fsck 1.46.6-rc1 (12-Sep-2022)
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Unattached zero-length inode 15.  Clear? no
> 
> Unattached inode 15
> Connect to /lost+found? no
> 
> Pass 5: Checking group summary information
> 
> /dev/sda: ********** WARNING: Filesystem still has errors **********
> 
> /dev/sda: 15/655360 files (0.0% non-contiguous), 66755/2621440 blocks
> 
> This occurs in 'ext4_xattr_inode_create()'. If 'ext4_mark_inode_dirty()'
> fails, dropping i_nlink of the inode is needed. Or will lead to inode leak.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
