Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133A135A9B9
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Apr 2021 02:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbhDJAy5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Apr 2021 20:54:57 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43975 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235268AbhDJAy5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Apr 2021 20:54:57 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13A0sMod002434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Apr 2021 20:54:22 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D15CF15C3B12; Fri,  9 Apr 2021 20:54:21 -0400 (EDT)
Date:   Fri, 9 Apr 2021 20:54:21 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin10@huawei.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Liu Zhi Qiang <liuzhiqiang26@huawei.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH v3] ext4: Fix ext4_error_err save negative errno into
 superblock
Message-ID: <YHD3PbAv1ywmAVSs@mit.edu>
References: <20210406025331.148343-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406025331.148343-1-yebin10@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 06, 2021 at 10:53:31AM +0800, Ye Bin wrote:
> As write_mmp_block return 1 when buffer isn't uptodate, return -EIO is
> more appropriate.
> 
> Fixes: 54d3adbc29f0 ("ext4: save all error info in save_error_info() and drop ext4_set_errno()")
> Reported-by: Liu Zhi Qiang <liuzhiqiang26@huawei.com>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Thanks, applied.

					- Ted
