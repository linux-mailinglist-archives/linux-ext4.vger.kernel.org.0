Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AD828801A
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 03:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbgJIBtO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Oct 2020 21:49:14 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40333 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726499AbgJIBtO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Oct 2020 21:49:14 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0991n0he026828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Oct 2020 21:49:01 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 91EBE420107; Thu,  8 Oct 2020 21:49:00 -0400 (EDT)
Date:   Thu, 8 Oct 2020 21:49:00 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.com, adilger.kernel@dilger.ca
Subject: Re: [PATCH v2 4/7] ext4: use ext4_buffer_uptodate() in
 __ext4_get_inode_loc()
Message-ID: <20201009014900.GD816148@mit.edu>
References: <20200924073337.861472-1-yi.zhang@huawei.com>
 <20200924073337.861472-5-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924073337.861472-5-yi.zhang@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 24, 2020 at 03:33:34PM +0800, zhangyi (F) wrote:
> We have already introduced ext4_buffer_uptodate() to re-set the uptodate
> bit on buffer which has been failed to write out to disk. Just remove
> the redundant codes and switch to use ext4_buffer_uptodate() in
> __ext4_get_inode_loc().
> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>

Thanks, applied.

					- Ted
