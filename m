Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF5E149E71
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jan 2020 04:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgA0Dzs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 26 Jan 2020 22:55:48 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51896 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726545AbgA0Dzs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 26 Jan 2020 22:55:48 -0500
Received: from callcc.thunk.org ([67.142.235.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00R3tRiP005834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jan 2020 22:55:37 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E1C3F42037C; Sun, 26 Jan 2020 22:05:00 -0500 (EST)
Date:   Sun, 26 Jan 2020 22:05:00 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Li Dongyang <dongyangli@ddn.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "adilger@dilger.ca" <adilger@dilger.ca>
Subject: Re: [PATCH v3 3/5] ext2fs: rename "s_overhead_blocks" to
 "s_overhead_clusters"
Message-ID: <20200127030500.GB115399@mit.edu>
References: <20191120043448.249988-1-dongyangli@ddn.com>
 <20191120043448.249988-3-dongyangli@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120043448.249988-3-dongyangli@ddn.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 20, 2019 at 04:35:25AM +0000, Li Dongyang wrote:
> Rename s_overhead_blocks field from struct ext2_super_block to
> make it consistent with the kernel counterpart.
> 
> Signed-off-by: Li Dongyang <dongyangli@ddn.com>
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Applied, thanks.

					- Ted
