Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE0D526C9A
	for <lists+linux-ext4@lfdr.de>; Fri, 13 May 2022 23:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384663AbiEMVxh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 May 2022 17:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353675AbiEMVxg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 May 2022 17:53:36 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A1B25287;
        Fri, 13 May 2022 14:53:34 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24DLrDbu021205
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 17:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652478795; bh=nzwrzMqDsYVJboGBB/IQbOMVhAxbj9pj1n5vlHGnylw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ieVe33UiwGpdgSON/uwfXPYir4W3Oz7bTC+JfZlX/rEvEp2rQsKhmy8Uk7gFfkfOo
         MvgU3tWKgQ3YiUA8ydrESBWT3rM5P2Rfw1MsOKFKAKIz11FQwxyCSqsE0n+eLGb/Kd
         czg0A89rkhT8HhatBnRCip122eX01NMi6mNjpLjX6PH4+D7/HmPoxbA+JhSaoZp+1+
         ReWTjXlK7vCkaaw69bfBX3xA2NsvQKsqbCCoX5psKdVJgGRno1iihQYQ97q/wgmOr+
         UCUq/q+ySAxGnwABVbfBq4AD6c5I/ozgsMMs1f8/1z7X7CoXxEA7G5W7JpAx8wVG0n
         y1m+9kzx4Cssw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 78F4615C3F2A; Fri, 13 May 2022 17:53:13 -0400 (EDT)
Date:   Fri, 13 May 2022 17:53:13 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin10@huawei.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz, lczerner@redhat.com
Subject: Re: [PATCH -next] ext4: fix use-after-free in ext4_rename_dir_prepare
Message-ID: <Yn7TSdP3n70WRIgG@mit.edu>
References: <20220414025223.4113128-1-yebin10@huawei.com>
 <Yn7KC6k/1Ncp6/Tl@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn7KC6k/1Ncp6/Tl@mit.edu>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, May 13, 2022 at 05:13:47PM -0400, Theodore Ts'o wrote:
> 
> I think we should be calling ext4_error_inode()?  If the directory is
> missing '.' or '..' below, the file system is corrupt, so we probably
> should mark the file system as inconsistent, so that e2fsck can fix
> the file system.

I noticed one other problem; which is that by returning NULL and not
setting retval, ext4_rename_dir_prepare() will end up returning
uninitialized stack garbage as the "error code".

So I'm going to be applying this commit with the following change:

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 50be41dc5831..b202626391ff 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3471,8 +3471,9 @@ static struct buffer_head *ext4_get_first_dir_block(handle_t *handle,
 					 bh->b_size, 0) ||
 		    le32_to_cpu(de->inode) != inode->i_ino ||
 		    strcmp(".", de->name)) {
-			ext4_warning_inode(inode, "directory missing '.'");
+			EXT4_ERROR_INODE(inode, "directory missing '.'");
 			brelse(bh);
+			*retval = -EFSCORRUPTED;
 			return NULL;
 		}
 		offset = ext4_rec_len_from_disk(de->rec_len,
@@ -3481,8 +3482,9 @@ static struct buffer_head *ext4_get_first_dir_block(handle_t *handle,
 		if (ext4_check_dir_entry(inode, NULL, de, bh, bh->b_data,
 					 bh->b_size, offset) ||
 		    le32_to_cpu(de->inode) == 0 || strcmp("..", de->name)) {
-			ext4_warning_inode(inode, "directory missing '..'");
+			EXT4_ERROR_INODE(inode, "directory missing '..'");
 			brelse(bh);
+			*retval = -EFSCORRUPTED;
 			return NULL;
 		}
 		*parent_de = de;
