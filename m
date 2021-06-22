Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87BCF3AFA5C
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jun 2021 02:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhFVA56 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Jun 2021 20:57:58 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:38533 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230175AbhFVA55 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 21 Jun 2021 20:57:57 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 74D8358095D;
        Mon, 21 Jun 2021 20:55:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 21 Jun 2021 20:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=fm1; bh=xpq
        QD/uU3ejT/3OZLcI9rvtXSr/O76UqcmLAQ1OQrBY=; b=iYQbFqr9pvB1OP1oqpU
        98n6GxRau6AUpj5jKVgnkB+5U1gVpzwO1k/51bOHme4mZ+1PmSKJ6msi9Z09a6uW
        YB5iXNsCgvz3nQfgnfjaEweAyovRikk3aDRkoTQSp2DhthKWegTTCQI2GvIu2AQ5
        ejD+tsYiFUHuOMLavzYxfArNiQQWkfkIh5TZTRtkcv3vXg/W5WdSPHujLVB82m+V
        fiO1EFSZd+z9RSmC7XsyIZrmtYM11IGANlBLG9MaGONCKCoqzkPMk1WrCC08eLkF
        HDyK7sl0PmcRaE7NY8t0hg62gYsm7GSFIBx1kQjRraROMAWQHGgfhPO6Woo1x/2w
        WPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=xpqQD/
        uU3ejT/3OZLcI9rvtXSr/O76UqcmLAQ1OQrBY=; b=Z7sIZbhvpLekDmIRooBJew
        W+fcNp9v2SC/TLgo1tyezyFKIOjQPyYjS6jE/Ju26ENxF/NtMCv6O+qdgwBYxY4A
        H9kLXkCeZPeOMy0C9B5Zk7OO5nBViVrXHCu0bvzizAdKnRbB7OljziHRK/yM80ZU
        lJIWjQY9BbeaBRNeWpQl4+JsUAsLknBRCvAD57EMfmFL3NNIlTjhTCgnXFXiaoI6
        ipMIRHNlNhtnAYzz7rNJMzg92zLLdrOsEoAYnBA5gPWyH1QFIZG1UYe4zi9+RlA6
        hECrdFUu7pYS/qMphqNfvUw54LnuG+zVp59dCGYXxkQ/VjbdOiZ+CKiBGYI/NC2Q
        ==
X-ME-Sender: <xms:DTXRYIDWSNCbVJIInv3Z2PZj-IDrq8Qb0FPwyguLSn0p0TTLRqyFEg>
    <xme:DTXRYKhwsCU-cH_UOkkgfQOTiy28Gh96MKsdsClg6qwQRcNBBZrA0jA8zgHviTG4d
    ijte6JuDtTZamPkFJk>
X-ME-Received: <xmr:DTXRYLk_lxM9cwP1R9YJxdGDXY_Zp6wTYQDgmCtLJ6sN7jpo2ES-Q9yO6zY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeegtddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflohhshhcu
    vfhrihhplhgvthhtuceojhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgeeihfduleeivefgudffjeffheehkeeiieetueevkeelhffgiedv
    fffhveffleelnecuffhomhgrihhnpehmrghrtgdrihhnfhhonecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhoshhhsehjohhshhhtrhhiphhl
    vghtthdrohhrgh
X-ME-Proxy: <xmx:DTXRYOzDFazI8PamQ54A4eCR6kwqZmdmjHb912gBRU3KC1ggViSVFA>
    <xmx:DTXRYNQ3HlX_l_3sc_32viOu5U_VuGcQ92b1gpnDT7WK7NMZLM5ZOQ>
    <xmx:DTXRYJbZXDQGsipDVAA0MBBDHeed7Rfk6U8ELTfILw83PckqeN-P7g>
    <xmx:DTXRYLPxM-SGfJ0wCRLGBJ7GzjVK_Quo4tyZgmJ4G9vcp_mf1gqQONEB3RI>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jun 2021 20:55:40 -0400 (EDT)
Date:   Mon, 21 Jun 2021 17:55:39 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        lishujin@kuaishou.com
Subject: Re: [PATCH V2 7/7] ext4: get discard out of jbd2 commit kthread
 contex
Message-ID: <YNE1C3NpFvILu4KS@localhost>
References: <164ffa3b-c4d5-6967-feba-b972995a6dfb@gmail.com>
 <a602a6ba-2073-8384-4c8f-d669ee25c065@gmail.com>
 <49382052-6238-f1fb-40d1-b6b801b39ff7@gmail.com>
 <48e33dea-d15e-f211-0191-e01bd3eb17b3@gmail.com>
 <67eeb65a-d413-c4f9-c06f-d5dcceca0e4f@gmail.com>
 <0b7915bc-193a-137b-4e52-8aaef8d6fef3@gmail.com>
 <a4e350a9-ef27-dc82-f610-0d3a0588afdf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4e350a9-ef27-dc82-f610-0d3a0588afdf@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 26, 2021 at 04:44:06PM +0800, Wang Jianchao wrote:
> Right now, discard is issued and waited to be completed in jbd2
> commit kthread context after the logs are committed. When large
> amount of files are deleted and discard is flooding, jbd2 commit
> kthread can be blocked for long time. Then all of the metadata
> operations can be blocked to wait the log space.
> 
> One case is the page fault path with read mm->mmap_sem held, which
> wants to update the file time but has to wait for the log space.
> When other threads in the task wants to do mmap, then write mmap_sem
> is blocked. Finally all of the following read mmap_sem requirements
> are blocked, even the ps command which need to read the /proc/pid/
> -cmdline. Our monitor service which needs to read /proc/pid/cmdline
> used to be blocked for 5 mins.
> 
> This patch frees the blocks back to buddy after commit and then do
> discard in a async kworker context in fstrim fashion, namely,
>  - mark blocks to be discarded as used if they have not been allocated
>  - do discard
>  - mark them free
> After this, jbd2 commit kthread won't be blocked any more by discard
> and we won't get NOSPC even if the discard is slow or throttled.
> 
> Link: https://marc.info/?l=linux-kernel&m=162143690731901&w=2
> Suggested-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>

I tested this patch series atop 5.13.0-rc7 (which took a bit of
rebasing), and it works quite well. I tested ext4 on dm-crypt on a
laptop NVME drive, using this test case:

$ mkdir testdir
$ time python3 -c 'for i in range(1000000): open(f"testdir/{i}", "wb").write(b"test data")'
$ time rm -r testdir

I tried this with and without discard enabled.

Without this patch, if discard is enabled, the rm takes many minutes,
and stalls out the rest of the system.

With this patch, the rm takes the same amount of time (~17s) whether
discard is enabled or disabled, and the rest of the system continues to
function.

Tested-by: Josh Triplett <josh@joshtriplett.org>
