Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA76282181
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Oct 2020 07:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbgJCFJq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 3 Oct 2020 01:09:46 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56264 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725446AbgJCFJq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 3 Oct 2020 01:09:46 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09359UHk024769
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 3 Oct 2020 01:09:30 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D68E542003C; Sat,  3 Oct 2020 01:09:29 -0400 (EDT)
Date:   Sat, 3 Oct 2020 01:09:29 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Cc:     yi.zhang@huawei.com, jack@suse.cz, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca
Subject: Re: [PATCH v3] ext4: Fix bdev write error check failed when mount fs
 with ro
Message-ID: <20201003050929.GL23474@mit.edu>
References: <20200928020556.710971-1-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928020556.710971-1-zhangxiaoxu5@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 27, 2020 at 10:05:56PM -0400, Zhang Xiaoxu wrote:
> Consider a situation when a filesystem was uncleanly shutdown and the
> orphan list is not empty and a read-only mount is attempted. The orphan
> list cleanup during mount will fail with:
> 
> ext4_check_bdev_write_error:193: comm mount: Error while async write back metadata
> 
> This happens because sbi->s_bdev_wb_err is not initialized when mounting
> the filesystem in read only mode and so ext4_check_bdev_write_error()
> falsely triggers.
> 
> Initialize sbi->s_bdev_wb_err unconditionally to avoid this problem.
> 
> Fixes: bc71726c7257 ("ext4: abort the filesystem if failed to async write metadata buffer")
> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Applied, thanks.

				- Ted
