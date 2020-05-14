Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041491D33A1
	for <lists+linux-ext4@lfdr.de>; Thu, 14 May 2020 16:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgENOyb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 May 2020 10:54:31 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59192 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726051AbgENOyb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 May 2020 10:54:31 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04EEsFEX007807
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 10:54:16 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 84958420304; Thu, 14 May 2020 10:54:15 -0400 (EDT)
Date:   Thu, 14 May 2020 10:54:15 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] ext4: Fix buffer_head refcnt leak when ext4_iget() fails
Message-ID: <20200514145415.GU1596452@mit.edu>
References: <1587618568-13418-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587618568-13418-1-git-send-email-xiyuyang19@fudan.edu.cn>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 23, 2020 at 01:09:27PM +0800, Xiyu Yang wrote:
> ext4_orphan_get() invokes ext4_read_inode_bitmap(), which returns a
> reference of the specified buffer_head object to "bitmap_bh" with
> increased refcnt.
> 
> When ext4_orphan_get() returns, local variable "bitmap_bh" becomes
> invalid, so the refcount should be decreased to keep refcount balanced.
> 
> The reference counting issue happens in one exception handling path of
> ext4_orphan_get(). When ext4_iget() fails, the function forgets to
> decrease the refcnt increased by ext4_read_inode_bitmap(), causing a
> refcnt leak.
> 
> Fix this issue by calling brelse() when ext4_iget() fails.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

Applied, thanks.

					- Ted
