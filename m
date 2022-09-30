Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206115F0334
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Sep 2022 05:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiI3DUv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Sep 2022 23:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiI3DUg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Sep 2022 23:20:36 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9093F316;
        Thu, 29 Sep 2022 20:20:06 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28U3Jljv002400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 23:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664507990; bh=wbmc59Hi5lkZ5pGKDWQ/rsCK/98T7RRRP7hGWZ8JwOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ConY56k7wJo43xZentvhnzG8bGYK8Da+W7WpuSnN9c4Wtn6sPuRc5/khav9wV+D7i
         xD9VCQ0iqhiYMpCuc/bHSz5LTwMG98leNn4ZUVdVhQ8xX3+Zkw+WeRWrH6/HP+GmJp
         pa9zFhk5dYjlZ8BizQXr8UxNQpXn402oNhA3g8a28Vi+0U+Jua6XUPtiEH8UKVHE1C
         W+8CN2Xe6Vh0zdCjJ1EbHHB2MXV22EjsefFonJ8jO4D6aczTL5jTvcJUrHcQlc0z+9
         ioHXqMKgPq+9xr0sPfA6buihy9FkJ6q1fB2BEvV7qLIV+dc2K5vk0w4Ig6jfjcMpgQ
         q1fGSeYhMZoMQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8A5A915C343F; Thu, 29 Sep 2022 23:19:47 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, chengzhihao1@huawei.com, jack@suse.cz
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH v2] ext4: Fix dir corruption when ext4_dx_add_entry() fails
Date:   Thu, 29 Sep 2022 23:19:32 -0400
Message-Id: <166450797716.256913.17964821049214407214.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220911045204.516460-1-chengzhihao1@huawei.com>
References: <20220911045204.516460-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, 11 Sep 2022 12:52:04 +0800, Zhihao Cheng wrote:
> Following process may lead to fs corruption:
> 1. ext4_create(dir/foo)
>  ext4_add_nondir
>   ext4_add_entry
>    ext4_dx_add_entry
>      a. add_dirent_to_buf
>       ext4_mark_inode_dirty
>       ext4_handle_dirty_metadata   // dir inode bh is recorded into journal
>      b. ext4_append    // dx_get_count(entries) == dx_get_limit(entries)
>        ext4_bread(EXT4_GET_BLOCKS_CREATE)
>         ext4_getblk
>          ext4_map_blocks
>           ext4_ext_map_blocks
>             ext4_mb_new_blocks
>              dquot_alloc_block
>               dquot_alloc_space_nodirty
>                inode_add_bytes    // update dir's i_blocks
>             ext4_ext_insert_extent
> 	     ext4_ext_dirty  // record extent bh into journal
>               ext4_handle_dirty_metadata(bh)
> 	      // record new block into journal
>        inode->i_size += inode->i_sb->s_blocksize   // new size(in mem)
>      c. ext4_handle_dirty_dx_node(bh2)
> 	// record dir's new block(dx_node) into journal
>      d. ext4_handle_dirty_dx_node((frame - 1)->bh)
>      e. ext4_handle_dirty_dx_node(frame->bh)
>      f. do_split    // ret err!
>      g. add_dirent_to_buf
> 	 ext4_mark_inode_dirty(dir)  // update raw_inode on disk(skipped)
> 2. fsck -a /dev/sdb
>  drop last block(dx_node) which beyonds dir's i_size.
>   /dev/sdb: recovering journal
>   /dev/sdb contains a file system with errors, check forced.
>   /dev/sdb: Inode 12, end of extent exceeds allowed value
> 	(logical block 128, physical block 3938, len 1)
> 3. fsck -fn /dev/sdb
>  dx_node->entry[i].blk > dir->i_size
>   Pass 2: Checking directory structure
>   Problem in HTREE directory inode 12 (/dir): bad block number 128.
>   Clear HTree index? no
>   Problem in HTREE directory inode 12: block #3 has invalid depth (2)
>   Problem in HTREE directory inode 12: block #3 has bad max hash
>   Problem in HTREE directory inode 12: block #3 not referenced
> 
> [...]

Applied, thanks!

[1/1] ext4: Fix dir corruption when ext4_dx_add_entry() fails
      commit: 7a3584fd605e6a72036c5759a6e9ed2c46d14899

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
