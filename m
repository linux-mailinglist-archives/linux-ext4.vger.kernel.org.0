Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3406526C24
	for <lists+linux-ext4@lfdr.de>; Fri, 13 May 2022 23:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384420AbiEMVOL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 May 2022 17:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343722AbiEMVOK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 May 2022 17:14:10 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2982DAB2;
        Fri, 13 May 2022 14:14:09 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24DLDlZ2027436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 17:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652476430; bh=ropMu2WEN5X5W82exC3OHUgNE5nAZ7EaJ+Bk99azWIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=CgrkpEmqlyKsx5/ONDKMENj/HFmhb71mdUz0+egEViCp4RLRw7f4KPCkwf/EJnZ7f
         VYebxlGTZrw4tIHpu4n9y/M1JKObWFPvzh8WrcIOPylt4pg1Zge76h6K4ghesEASzO
         +SKKGmzv5H6MCYW41RW6uQyvwCqjw5vbHV7SDXxv3uxAmO3LtFNgNj094Zm1q3POzF
         nW2S2ieMJGMfqEt2Yc4pErHSazSFZLLQmpx+mp/+W+iId/PGSyYHAaCx7FfR3aNaiy
         i9LPAAbqL/ptYNLnKwYlMioI/XCCo4BsL7Y81SlY5jLmIyVHE173NqtH8Kw+GcWokD
         3x/O8mdV9Ip9A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A864115C3F2A; Fri, 13 May 2022 17:13:47 -0400 (EDT)
Date:   Fri, 13 May 2022 17:13:47 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin10@huawei.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz, lczerner@redhat.com
Subject: Re: [PATCH -next] ext4: fix use-after-free in ext4_rename_dir_prepare
Message-ID: <Yn7KC6k/1Ncp6/Tl@mit.edu>
References: <20220414025223.4113128-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414025223.4113128-1-yebin10@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 14, 2022 at 10:52:23AM +0800, Ye Bin wrote:
> We got issue as follows:
> EXT4-fs (loop0): mounted filesystem without journal. Opts: ,errors=continue
> ext4_get_first_dir_block: bh->b_data=0xffff88810bee6000 len=34478
> ext4_get_first_dir_block: *parent_de=0xffff88810beee6ae bh->b_data=0xffff88810bee6000
> ext4_rename_dir_prepare: [1] parent_de=0xffff88810beee6ae
> ==================================================================
> BUG: KASAN: use-after-free in ext4_rename_dir_prepare+0x152/0x220
> Read of size 4 at addr ffff88810beee6ae by task rep/1895
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index e37da8d5cd0c..2f78544b1d47 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -3463,9 +3466,28 @@ static struct buffer_head *ext4_get_first_dir_block(handle_t *handle,
>  			*retval = PTR_ERR(bh);
>  			return NULL;
>  		}
> -		*parent_de = ext4_next_entry(
> -					(struct ext4_dir_entry_2 *)bh->b_data,
> -					inode->i_sb->s_blocksize);
> +
> +		de = (struct ext4_dir_entry_2 *) bh->b_data;
> +		if (ext4_check_dir_entry(inode, NULL, de, bh, bh->b_data,
> +					 bh->b_size, 0) ||
> +		    le32_to_cpu(de->inode) != inode->i_ino ||
> +		    strcmp(".", de->name)) {
> +			ext4_warning_inode(inode, "directory missing '.'");

I think we should be calling ext4_error_inode()?  If the directory is
missing '.' or '..' below, the file system is corrupt, so we probably
should mark the file system as inconsistent, so that e2fsck can fix
the file system.

					- Ted
