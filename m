Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C584E533F
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Mar 2022 14:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244346AbiCWNih (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Mar 2022 09:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244384AbiCWNie (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Mar 2022 09:38:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661767DA89;
        Wed, 23 Mar 2022 06:36:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7E666210E2;
        Wed, 23 Mar 2022 13:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648042614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xF+2OTyRsrDHA/qolZw1jSNPVTPjccZAz09TGKCZ+kQ=;
        b=o74f4HA/v+dCAD/HmFZi0Y0x1EUwDm2Un0XxiDFfhWTSE2t35FfoHlhVMdHPQQXLJhznvs
        +37QwfS5AHR31f3Ya8ZAzG/TyqhiilOuCqnj74051jgG0/qfeqJAo+rArZx9QDSEGas56q
        UvJxsCPQIjOLzi1r5dHrJGQdV7xAkL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648042614;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xF+2OTyRsrDHA/qolZw1jSNPVTPjccZAz09TGKCZ+kQ=;
        b=EiTLKR6JktOkH96pzVjQf6fwdBJ4U4m+nHrVwhz8XUwyBFShlU6dktcpG81HGgkxNn0Zp0
        O9+cJDf6KitATyCw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5A25FA3B93;
        Wed, 23 Mar 2022 13:36:54 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EDFF7A0610; Wed, 23 Mar 2022 14:36:53 +0100 (CET)
Date:   Wed, 23 Mar 2022 14:36:53 +0100
From:   Jan Kara <jack@suse.cz>
To:     yebin <yebin10@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        lczerner@redhat.com
Subject: Re: [PATCH -next] ext4: fix use-after-free in ext4_search_dir
Message-ID: <20220323133653.peodswwvznalzhhx@quack3.lan>
References: <20220323034304.3597652-1-yebin10@huawei.com>
 <20220323104745.76u3uhdn745jaw4j@quack3.lan>
 <623B0BF7.3050907@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <623B0BF7.3050907@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 23-03-22 20:00:55, yebin wrote:
> On 2022/3/23 18:47, Jan Kara wrote:
> > On Wed 23-03-22 11:43:04, Ye Bin wrote:
> > > We got issue as follows:
> > > EXT4-fs (loop0): mounted filesystem without journal. Opts: ,errors=continue
> > > ==================================================================
> > > BUG: KASAN: use-after-free in ext4_search_dir fs/ext4/namei.c:1394 [inline]
> > > BUG: KASAN: use-after-free in search_dirblock fs/ext4/namei.c:1199 [inline]
> > > BUG: KASAN: use-after-free in __ext4_find_entry+0xdca/0x1210 fs/ext4/namei.c:1553
> > > Read of size 1 at addr ffff8881317c3005 by task syz-executor117/2331
> > > 
> > > CPU: 1 PID: 2331 Comm: syz-executor117 Not tainted 5.10.0+ #1
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> > > Call Trace:
> > >   __dump_stack lib/dump_stack.c:83 [inline]
> > >   dump_stack+0x144/0x187 lib/dump_stack.c:124
> > >   print_address_description+0x7d/0x630 mm/kasan/report.c:387
> > >   __kasan_report+0x132/0x190 mm/kasan/report.c:547
> > >   kasan_report+0x47/0x60 mm/kasan/report.c:564
> > >   ext4_search_dir fs/ext4/namei.c:1394 [inline]
> > >   search_dirblock fs/ext4/namei.c:1199 [inline]
> > >   __ext4_find_entry+0xdca/0x1210 fs/ext4/namei.c:1553
> > >   ext4_lookup_entry fs/ext4/namei.c:1622 [inline]
> > >   ext4_lookup+0xb8/0x3a0 fs/ext4/namei.c:1690
> > >   __lookup_hash+0xc5/0x190 fs/namei.c:1451
> > >   do_rmdir+0x19e/0x310 fs/namei.c:3760
> > >   do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
> > >   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > RIP: 0033:0x445e59
> > > Code: 4d c7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 1b c7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > > RSP: 002b:00007fff2277fac8 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
> > > RAX: ffffffffffffffda RBX: 0000000000400280 RCX: 0000000000445e59
> > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200000c0
> > > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000002
> > > R10: 00007fff2277f990 R11: 0000000000000246 R12: 0000000000000000
> > > R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
> > > 
> > > The buggy address belongs to the page:
> > > page:0000000048cd3304 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x1317c3
> > > flags: 0x200000000000000()
> > > raw: 0200000000000000 ffffea0004526588 ffffea0004528088 0000000000000000
> > > raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
> > > page dumped because: kasan: bad access detected
> > > 
> > > Memory state around the buggy address:
> > >   ffff8881317c2f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >   ffff8881317c2f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > ffff8881317c3000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > >                     ^
> > >   ffff8881317c3080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > >   ffff8881317c3100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > ==================================================================
> > > 
> > > ext4_search_dir:
> > >    ...
> > >    de = (struct ext4_dir_entry_2 *)search_buf;
> > >    dlimit = search_buf + buf_size;
> > >    while ((char *) de < dlimit) {
> > >    ...
> > >      if ((char *) de + de->name_len <= dlimit &&
> > > 	 ext4_match(dir, fname, de)) {
> > > 	    ...
> > >      }
> > >    ...
> > >      de_len = ext4_rec_len_from_disk(de->rec_len, dir->i_sb->s_blocksize);
> > >      if (de_len <= 0)
> > >        return -1;
> > >      offset += de_len;
> > >      de = (struct ext4_dir_entry_2 *) ((char *) de + de_len);
> > >    }
> > > 
> > > Assume:
> > > de=0xffff8881317c2fff
> > > dlimit=0x0xffff8881317c3000
> > > 
> > > If read 'de->name_len' which address is 0xffff8881317c3005, obviously is
> > > out of range, then will trigger use-after-free.
> > > To solve this issue, 'dlimit' must reserve 8 bytes, as we will read
> > > 'de->name_len' to judge if '(char *) de + de->name_len' out of range.
> > > 
> > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > Oh, good catch.
> > 
> > > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > > index 3f87cca49f0c..276683f7ab77 100644
> > > --- a/fs/ext4/ext4.h
> > > +++ b/fs/ext4/ext4.h
> > > @@ -2273,6 +2273,10 @@ static inline int ext4_forced_shutdown(struct ext4_sb_info *sbi)
> > >    * Structure of a directory entry
> > >    */
> > >   #define EXT4_NAME_LEN 255
> > > +/*
> > > + * Base length of ext4_dir_entry_2 and ext4_dir_entry exclude name
> > > + */
> > > +#define EXT4_BASE_DIR_LEN 8
> > I'd rather use (sizeof(struct ext4_dir_entry_2) - EXT4_NAME_LEN) here...
> > 
> > >   struct ext4_dir_entry {
> > >   	__le32	inode;			/* Inode number */
> > > diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> > > index e37da8d5cd0c..4739a5aa13aa 100644
> > > --- a/fs/ext4/namei.c
> > > +++ b/fs/ext4/namei.c
> > > @@ -1465,7 +1465,7 @@ int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
> > >   	int de_len;
> > >   	de = (struct ext4_dir_entry_2 *)search_buf;
> > > -	dlimit = search_buf + buf_size;
> > > +	dlimit = search_buf + buf_size - EXT4_BASE_DIR_LEN;
> > >   	while ((char *) de < dlimit) {
> > >   		/* this code is executed quadratically often */
> > >   		/* do minimal checking `by hand' */
> > This looks wrong because a bit later we use dlimit to verify
> > de+de->name_len and that can certainly go upto bufsize. You need to modify
> > only the condition in the while loop like:
> > 
> >    	while ((char *) de < dlimit - EXT4_BASE_DIR_LEN) {
> > 
> > 									Honza
> I think  'dlimit' also need to minus EXT4_BASE_DIR_LEN when verify
> 'de+de->name_len' .
> Assume:
> de = 0xffff8881317c2ff7
> dlimit = 0x0xffff8881317c3000
> de->name_len = 8
> 
> =>
> de + de->name_len = 0xffff8881317c2fff  ( <= dlimit=0x0xffff8881317c3000)
> de->name = 'de' address  + EXT4_BASE_DIR_LEN  = 0xffff8881317c2ff7 + 8 =
> 0xffff8881317c2fff
> If we read 8 bytes form 0xffff8881317c2fff will read out of range.

Ah, I see. Well, I'd rather modify the condition to look like:

                if (de->name + de->name_len <= dlimit &&
                    ext4_match(dir, fname, de)) {

Because that expresses better what we are checking...

								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
