Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFF82142E3
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2019 00:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfEEWen (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 5 May 2019 18:34:43 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49952 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727325AbfEEWen (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 5 May 2019 18:34:43 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x45MYcx7003170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 5 May 2019 18:34:39 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 93334420024; Sun,  5 May 2019 18:34:38 -0400 (EDT)
Date:   Sun, 5 May 2019 18:34:38 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] mke2fs: fix check for absurdly large devices
Message-ID: <20190505223438.GD10038@mit.edu>
References: <1556227470-47076-1-git-send-email-adilger@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556227470-47076-1-git-send-email-adilger@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 25, 2019 at 11:24:30PM +0200, Andreas Dilger wrote:
> The check in mke2fs is intended to be for the number of blocks in the
> filesystem exceeding the maximum number of addressable blocks in 2^32
> bitmaps, which is (2^32 * 8 bits/byte * blocksize) = 2^47 blocks,
> or 2^59 bytes = 512PiB for the common 4KiB blocksize.
> 
> However, s_log_blocksize holds log2(blocksize_in_kb), so the current
> calculation is a factor of 2^10 too small.  This caused mke2fs to fail
> while trying to format a 900TB filesystem.
> 
> Fixes: 101ef2e93c25 ("mke2fs: Avoid crashes / infinite loops for absurdly large devices")
> Signed-off-by: Andreas Dilger <adilger@dilger.ca>

Thanks, applied.

					- Ted
