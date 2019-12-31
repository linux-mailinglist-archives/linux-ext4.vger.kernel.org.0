Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B66B612D600
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Dec 2019 04:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfLaDsG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Dec 2019 22:48:06 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36651 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726605AbfLaDsG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Dec 2019 22:48:06 -0500
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBV3m0WB007973
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Dec 2019 22:48:01 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B9161420485; Mon, 30 Dec 2019 22:47:59 -0500 (EST)
Date:   Mon, 30 Dec 2019 22:47:59 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Li Dongyang <dongyangli@ddn.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "adilger@dilger.ca" <adilger@dilger.ca>
Subject: Re: [PATCH v3 2/5] mke2fs: fix setting bad blocks in the block bitmap
Message-ID: <20191231034759.GF3669@mit.edu>
References: <20191120043448.249988-1-dongyangli@ddn.com>
 <20191120043448.249988-2-dongyangli@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120043448.249988-2-dongyangli@ddn.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 20, 2019 at 04:35:24AM +0000, Li Dongyang wrote:
> We mark the bad blocks as used on fs->block_map
> before allocating group tables.
> Don't translate the block number to cluster number
> when doing this, the fs->block_map is still a
> block-granularity allocation map, it will be coverted
> later by ext2fs_convert_subcluster_bitmap().
> 
> Signed-off-by: Li Dongyang <dongyangli@ddn.com>

Applied on the maint branch, thanks.  (The other patches need to go on
the e2fsprogs master/next branch, and the last is a kernel patch.)

    	      		  	      	  - Ted
