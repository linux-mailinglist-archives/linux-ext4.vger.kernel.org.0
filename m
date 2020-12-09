Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEED2D4A95
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Dec 2020 20:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbgLITjU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Dec 2020 14:39:20 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55135 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726794AbgLITaO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Dec 2020 14:30:14 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B9JTHYQ011572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Dec 2020 14:29:17 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 11915420136; Wed,  9 Dec 2020 14:29:17 -0500 (EST)
Date:   Wed, 9 Dec 2020 14:29:16 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Chunguang Xu <brookxu.cn@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH RESEND 8/8] ext4: fix a memory leak of ext4_free_data
Message-ID: <20201209192916.GN52960@mit.edu>
References: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
 <1604764698-4269-8-git-send-email-brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604764698-4269-8-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Nov 07, 2020 at 11:58:18PM +0800, Chunguang Xu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> When freeing metadata, we will create an ext4_free_data and
> insert it into the pending free list. After the current
> transaction is committed, the object will be freed.
> 
> ext4_mb_free_metadata() will check whether the area to be
> freed overlaps with the pending free list. If true, return
> directly. At this time, ext4_free_data is leaked. Fortunately,
> the probability of this problem is relatively small, maybe we
> should fix this problem.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

Thanks, applied.  I added an explanatory note that the leak would only
happen when the file system is corrupted (a block claimed by more than
one inode, with those inodes deleted within a single jbd2 transaction).

    	   	      	     	     	    - Ted
