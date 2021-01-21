Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272362FF0F6
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jan 2021 17:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388057AbhAUQuO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jan 2021 11:50:14 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58766 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728156AbhAUP6I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jan 2021 10:58:08 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10LFuYo9003734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 10:56:35 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 63C8C15C35F5; Thu, 21 Jan 2021 10:56:34 -0500 (EST)
Date:   Thu, 21 Jan 2021 10:56:34 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 04/15] libext2fs: provide APIs to configure fast
 commit blocks
Message-ID: <YAmkMqfOerY/GPSY@mit.edu>
References: <20210120212641.526556-1-user@harshads-520.kir.corp.google.com>
 <20210120212641.526556-5-user@harshads-520.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120212641.526556-5-user@harshads-520.kir.corp.google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 20, 2021 at 01:26:30PM -0800, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> This patch adds new libext2fs that allow configuring number of fast
> commit blocks in journal superblock. We also add a struct
> ext2fs_journal_params which contains number of fast commit blocks and
> number of normal journal blocks. With this patch, the preferred way
> for configuring number of blocks with and without fast commits is:
> 
> struct ext2fs_journal_params params;
> 
> ext2fs_get_journal_params(&params, ...);
> params.num_journal_blocks = ...;
> params.num_fc_blocks = ...;
> ext2fs_create_journal_superblock2(..., &params, ...);
>          OR
> ext2fs_add_journal_inode3(..., &params, ...);
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

I've applied to the next branch a modified version of this which is
based on the Dec. 20th version of this change, with a local static
inline copy of jbd2_journal_get_num_fc_blks() in ljs.c, as I had
mentioned earlier.

			       	  	    - Ted
