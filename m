Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0944E62B5
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Mar 2022 12:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238108AbiCXLw5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Mar 2022 07:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349873AbiCXLw5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Mar 2022 07:52:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D87CA7741;
        Thu, 24 Mar 2022 04:51:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A465E1F745;
        Thu, 24 Mar 2022 11:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648122683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4wdLN7onAzHERay3+YLdl5/6sPiB+EjawqgU4IGxYk8=;
        b=yXk+RFJCMfNvv6qTAQyx+gErs3SW2hhSKgcvXQieMHZGmUZnO3MJj7ZLvSbw/KkhNjiWTt
        aZvb2H5FZ0mFcq9XgZcWoliEay1pzcAHVyunZPKU4P4KVBgS4EH5/NANmWWVWiIQfgkITf
        hWhXvEyAksiUqS51F9Bg7DQ9mcW+DoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648122683;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4wdLN7onAzHERay3+YLdl5/6sPiB+EjawqgU4IGxYk8=;
        b=kAx4+2B8KDZaUtpg3UZWaLCA7ccaP/tSaCgCNoAap+YwZj02ib8UqXEYRskqP7QdNyoqbY
        TNrmGjzIjRGy/+AQ==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 57828A3B82;
        Thu, 24 Mar 2022 11:51:23 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 708C8A0610; Thu, 24 Mar 2022 12:51:20 +0100 (CET)
Date:   Thu, 24 Mar 2022 12:51:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, lczerner@redhat.com
Subject: Re: [PATCH -next v2] ext4: fix use-after-free in ext4_search_dir
Message-ID: <20220324115120.p6uaoofizgwjazbl@quack3.lan>
References: <20220324064816.1209985-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324064816.1209985-1-yebin10@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 24-03-22 14:48:16, Ye Bin wrote:
> We got issue as follows:
> EXT4-fs (loop0): mounted filesystem without journal. Opts: ,errors=continue
> ==================================================================
> BUG: KASAN: use-after-free in ext4_search_dir fs/ext4/namei.c:1394 [inline]
> BUG: KASAN: use-after-free in search_dirblock fs/ext4/namei.c:1199 [inline]
> BUG: KASAN: use-after-free in __ext4_find_entry+0xdca/0x1210 fs/ext4/namei.c:1553
> Read of size 1 at addr ffff8881317c3005 by task syz-executor117/2331
> 
> CPU: 1 PID: 2331 Comm: syz-executor117 Not tainted 5.10.0+ #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:83 [inline]
>  dump_stack+0x144/0x187 lib/dump_stack.c:124
>  print_address_description+0x7d/0x630 mm/kasan/report.c:387
>  __kasan_report+0x132/0x190 mm/kasan/report.c:547
>  kasan_report+0x47/0x60 mm/kasan/report.c:564
>  ext4_search_dir fs/ext4/namei.c:1394 [inline]
>  search_dirblock fs/ext4/namei.c:1199 [inline]
>  __ext4_find_entry+0xdca/0x1210 fs/ext4/namei.c:1553
>  ext4_lookup_entry fs/ext4/namei.c:1622 [inline]
>  ext4_lookup+0xb8/0x3a0 fs/ext4/namei.c:1690
>  __lookup_hash+0xc5/0x190 fs/namei.c:1451
>  do_rmdir+0x19e/0x310 fs/namei.c:3760
>  do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x445e59
> Code: 4d c7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 1b c7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fff2277fac8 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
> RAX: ffffffffffffffda RBX: 0000000000400280 RCX: 0000000000445e59
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200000c0
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000002
> R10: 00007fff2277f990 R11: 0000000000000246 R12: 0000000000000000
> R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
> 
> The buggy address belongs to the page:
> page:0000000048cd3304 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x1317c3
> flags: 0x200000000000000()
> raw: 0200000000000000 ffffea0004526588 ffffea0004528088 0000000000000000
> raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8881317c2f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff8881317c2f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffff8881317c3000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                    ^
>  ffff8881317c3080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff8881317c3100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ==================================================================
> 
> ext4_search_dir:
>   ...
>   de = (struct ext4_dir_entry_2 *)search_buf;
>   dlimit = search_buf + buf_size;
>   while ((char *) de < dlimit) {
>   ...
>     if ((char *) de + de->name_len <= dlimit &&
> 	 ext4_match(dir, fname, de)) {
> 	    ...
>     }
>   ...
>     de_len = ext4_rec_len_from_disk(de->rec_len, dir->i_sb->s_blocksize);
>     if (de_len <= 0)
>       return -1;
>     offset += de_len;
>     de = (struct ext4_dir_entry_2 *) ((char *) de + de_len);
>   }
> 
> Assume:
> de=0xffff8881317c2fff
> dlimit=0x0xffff8881317c3000
> 
> If read 'de->name_len' which address is 0xffff8881317c3005, obviously is
> out of range, then will trigger use-after-free.
> To solve this issue, 'dlimit' must reserve 8 bytes, as we will read
> 'de->name_len' to judge if '(char *) de + de->name_len' out of range.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Thanks. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/ext4/ext4.h  | 4 ++++
>  fs/ext4/namei.c | 4 ++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 3f87cca49f0c..ea49cf5d70a9 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2273,6 +2273,10 @@ static inline int ext4_forced_shutdown(struct ext4_sb_info *sbi)
>   * Structure of a directory entry
>   */
>  #define EXT4_NAME_LEN 255
> +/*
> + * Base length of ext4_dir_entry_2 and ext4_dir_entry exclude name
> + */
> +#define EXT4_BASE_DIR_LEN (sizeof(struct ext4_dir_entry_2) - EXT4_NAME_LEN)
>  
>  struct ext4_dir_entry {
>  	__le32	inode;			/* Inode number */
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index e37da8d5cd0c..767b4bfe39c3 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1466,10 +1466,10 @@ int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
>  
>  	de = (struct ext4_dir_entry_2 *)search_buf;
>  	dlimit = search_buf + buf_size;
> -	while ((char *) de < dlimit) {
> +	while ((char *) de < dlimit - EXT4_BASE_DIR_LEN) {
>  		/* this code is executed quadratically often */
>  		/* do minimal checking `by hand' */
> -		if ((char *) de + de->name_len <= dlimit &&
> +		if (de->name + de->name_len <= dlimit &&
>  		    ext4_match(dir, fname, de)) {
>  			/* found a match - just to be sure, do
>  			 * a full check */
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
