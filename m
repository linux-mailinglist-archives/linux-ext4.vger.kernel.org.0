Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC1FE196AB4
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Mar 2020 04:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgC2CrP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Mar 2020 22:47:15 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50048 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726315AbgC2CrP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 Mar 2020 22:47:15 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02T2l9CX025857
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Mar 2020 22:47:09 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 13147420EBA; Sat, 28 Mar 2020 22:47:09 -0400 (EDT)
Date:   Sat, 28 Mar 2020 22:47:09 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH] ext4: Fix incorrect group count in ext4_fill_super error
 message
Message-ID: <20200329024709.GK53396@mit.edu>
References: <8b957cd1513fcc4550fe675c10bcce2175c33a49.1585431964.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b957cd1513fcc4550fe675c10bcce2175c33a49.1585431964.git.josh@joshtriplett.org>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Mar 28, 2020 at 02:54:01PM -0700, Josh Triplett wrote:
> ext4_fill_super doublechecks the number of groups before mounting; if
> that check fails, the resulting error message prints the group count
> from the ext4_sb_info sbi, which hasn't been set yet. Print the freshly
> computed group count instead (which at that point has just been computed
> in "blocks_count").
> 
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> Fixes: 4ec1102813798 ("ext4: Add sanity checks for the superblock before mounting the filesystem")

Applied, with a fix to the format string:

>  fs/ext4/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 0c7c4adb664e..7f5f37653a03 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4288,7 +4288,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  	if (blocks_count > ((uint64_t)1<<32) - EXT4_DESC_PER_BLOCK(sb)) {
>  		ext4_msg(sb, KERN_WARNING, "groups count too large: %u "

s/%u/%llu/

>  		       "(block count %llu, first data block %u, "
> -		       "blocks per group %lu)", sbi->s_groups_count,
> +		       "blocks per group %lu)", blocks_count,
>  		       ext4_blocks_count(es),
>  		       le32_to_cpu(es->s_first_data_block),
>  		       EXT4_BLOCKS_PER_GROUP(sb));
> -- 
> 2.26.0

						- Ted
