Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0AA3D3982
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jul 2021 13:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbhGWKv3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Jul 2021 06:51:29 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56209 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231703AbhGWKv3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Jul 2021 06:51:29 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16NBVp0B016690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 07:31:51 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0BBFE15C37C0; Fri, 23 Jul 2021 07:31:51 -0400 (EDT)
Date:   Fri, 23 Jul 2021 07:31:51 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin10@huawei.com>
Cc:     jack@suse.cz, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH -next] ext4: Fix access uninitialized 'retval' in kmmpd
Message-ID: <YPqopxY0GxnnyqVJ@mit.edu>
References: <20210713022728.2533770-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713022728.2533770-1-yebin10@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 13, 2021 at 10:27:28AM +0800, Ye Bin wrote:
> If (!ext4_has_feature_mmp(sb)) then goto 'wait_to_exit' label, but
> retval not be uninitialized.
> 
> Fixes: 61bb4a1c417e ("ext4: fix possible UAF when remounting r/o a mmp-protected file system")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Thanks, applied with a slightly fixed up commit description.

					- Ted
