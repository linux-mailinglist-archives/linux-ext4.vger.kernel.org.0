Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9166320E7E
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Feb 2021 00:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbhBUXO6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 21 Feb 2021 18:14:58 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52465 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232988AbhBUXO4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 21 Feb 2021 18:14:56 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 11LNE6Ri027353
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Feb 2021 18:14:07 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6F0DD15C342C; Sun, 21 Feb 2021 18:14:06 -0500 (EST)
Date:   Sun, 21 Feb 2021 18:14:06 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 4/4] e2fsck: initialize variable before first use in fast
 commit replay
Message-ID: <YDLpPr/DD/sSRuES@mit.edu>
References: <20210219210333.1439525-1-harshads@google.com>
 <20210219210333.1439525-4-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219210333.1439525-4-harshads@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 19, 2021 at 01:03:33PM -0800, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> Initialize ext2fs_ex variable in ext4_fc_replay_scan() before first
> use.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

I wonder if we should make the following change to
ext2fs_decode_extent(), which will prevent other future bugs to
potential users of the function:

	to->e_pblk = ext2fs_le32_to_cpu(from->ee_start) +
		((__u64) ext2fs_le16_to_cpu(from->ee_start_hi)
			<< 32);
	to->e_lblk = ext2fs_le32_to_cpu(from->ee_block);
	to->e_len = ext2fs_le16_to_cpu(from->ee_len);
-	to->e_flags |= EXT2_EXTENT_FLAGS_LEAF;
+	to->e_flags = EXT2_EXTENT_FLAGS_LEAF;

ext2fs_decode_extent() overwrites all other members of the structure,
so we might as well just initialize e_flags as opposed to depending
the caller to initiaize *to just for the sake of to->e_flags.

Cheers,

					- Ted
