Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7499F29E3E0
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Oct 2020 08:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgJ2HVT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Oct 2020 03:21:19 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37991 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725962AbgJ2HUw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Oct 2020 03:20:52 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09T4EpDA023037
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Oct 2020 00:14:51 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 36255420107; Thu, 29 Oct 2020 00:14:51 -0400 (EDT)
Date:   Thu, 29 Oct 2020 00:14:51 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     yangerkun <yangerkun@huawei.com>
Cc:     jack@suse.com, adilger@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: do not use extent after put_bh
Message-ID: <20201029041451.GT5691@mit.edu>
References: <20201028055617.2569255-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028055617.2569255-1-yangerkun@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 28, 2020 at 01:56:17PM +0800, yangerkun wrote:
> ext4_ext_search_right will read more extent block and call put_bh after
> we get the information we need. However ret_ex will break this and may
> cause use-after-free once pagecache has been freed. Fix it by dup the
> extent we need.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>

Good catch!

Thanks, applied.

					- Ted
