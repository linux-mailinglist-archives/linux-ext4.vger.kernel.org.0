Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BEF542CA7
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jun 2022 12:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbiFHKJx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jun 2022 06:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237025AbiFHKJb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Jun 2022 06:09:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E861C792E
        for <linux-ext4@vger.kernel.org>; Wed,  8 Jun 2022 02:54:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5D02821BB0;
        Wed,  8 Jun 2022 09:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654682067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9q3ozjm6zgkQp8m1Ky8d5kM6fieEE1eaPbdwuL1zyAM=;
        b=fettyvIlZX+QIPQ8evQmHJtAaXjXVJU7QGWBPnJ6cT0uSxBnIKMt/tEgPh8cfny1xOng4z
        ChqSmr3Kgnyfp5GYdhdfOdU5yfssKmgR1/w/BWNe2mk/Lytyemq4Q/QaT4+3XwBWu3KOTD
        7fDxSMi/z2ITQGxjBxs0qBHY7Fy1zLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654682067;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9q3ozjm6zgkQp8m1Ky8d5kM6fieEE1eaPbdwuL1zyAM=;
        b=GfPdV0mS8x+JexHZ2fr5Ua6TplBbe1B8/yF4GbygRKKcprwON1WwpPdpxJYOhGUL9O/ZZa
        w8qEUHEwnWAu9PBg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4DEC02C141;
        Wed,  8 Jun 2022 09:54:27 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 097C7A06E2; Wed,  8 Jun 2022 11:54:26 +0200 (CEST)
Date:   Wed, 8 Jun 2022 11:54:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/2] ext4: Fix possible fs corruption due to xattr races
Message-ID: <20220608095425.nptskml5splta2qd@quack3.lan>
References: <20220606142215.17962-1-jack@suse.cz>
 <20220608045100.uacl5c6usi7kl7gw@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608045100.uacl5c6usi7kl7gw@riteshh-domain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 08-06-22 10:21:00, Ritesh Harjani wrote:
> On 22/06/06 04:28PM, Jan Kara wrote:
> > Hello,
> >
> > I've tracked down the culprit of the jbd2 assertion Ritesh reported to me. In
> 
> Hello Jan,
> 
> Thanks for working on the problem and identifying the race.
> 
> > the end it does not have much to do with jbd2 but rather points to a subtle
> > race in xattr code between xattr block reuse and xattr block freeing that can
> > result in fs corruption during journal replay. See patch 2/2 for more details.
> > These patches fix the problem. I have to say I'm not too happy with the special
> 
> So while I was still reviewing this patch-set, I thought of giving a try with some
> stress test for xattrs (given that this is some sort of race which is not always
> easy to track down).
> 
> So it seems it is easy to recreate the crash with stress-ng xattr test (even
> with your patches included).
> 	stress-ng --xattr 16 --timeout=10000s
> 
> Hope this might help further narrow down the problem.

Drat. I was actually running "stress-ng --xattr
<some-number-I-dont-remember>" to test my patches and it
didn't reproduce the crash for me within 5 minutes or so. Let me try harder
and thanks for the testing!

								Honza

> 
> root@qemu:/home/qemu# [  257.862064] ------------[ cut here ]------------
> [  257.862834] kernel BUG at fs/jbd2/revoke.c:460!
> [  257.863461] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [  257.864084] CPU: 0 PID: 1499 Comm: stress-ng-xattr Not tainted 5.18.0-rc5+
> #102
> [  257.864973] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> [  257.865972] RIP: 0010:jbd2_journal_cancel_revoke+0x12c/0x170
> [  257.866606] Code: 49 89 44 24 08 e8 b4 bf d8 00 48 8b 3d 2d f9 29 02 4c 89 e6
> e8 c5 81 ea ff 48 8b 73 18 4c 89 ef e8 39 f8
> [  257.868547] RSP: 0018:ffffc9000170b9c0 EFLAGS: 00010286
> [  257.869106] RAX: ffff888101cadb00 RBX: ffff888121cb9f08 RCX: 0000000000000000
> [  257.869837] RDX: 0000000000000001 RSI: 000000000000242d RDI: 00000000ffffffff
> [  257.870552] RBP: ffffc9000170b9e0 R08: ffffffff82cf2f20 R09: ffff888108831e10
> [  257.871264] R10: 00000000000000bb R11: 000000000105d68a R12: ffff888108831e10
> [  257.871977] R13: ffff888120937000 R14: ffff888108928500 R15: ffff888108831e18
> [  257.872689] FS:  00007ffff6b4dc00(0000) GS:ffff88842fc00000(0000)
> knlGS:0000000000000000
> [  257.873528] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  257.874101] CR2: 0000555556361220 CR3: 00000001201dc000 CR4: 00000000000006f0
> [  257.874813] Call Trace:
> [  257.875077]  <TASK>
> [  257.875313]  do_get_write_access+0x3d9/0x460
> [  257.875753]  jbd2_journal_get_write_access+0x54/0x80
> [  257.876260]  __ext4_journal_get_write_access+0x8b/0x1b0
> [  257.876805]  ? ext4_dirty_inode+0x70/0x80
> [  257.877255]  ext4_xattr_block_set+0x935/0xfb0
> [  257.877709]  ext4_xattr_set_handle+0x5c8/0x680
> [  257.878159]  ext4_xattr_set+0xd5/0x180
> [  257.878540]  ext4_xattr_user_set+0x35/0x40
> [  257.878957]  __vfs_removexattr+0x5a/0x70
> [  257.879373]  __vfs_removexattr_locked+0xc5/0x160
> [  257.879846]  vfs_removexattr+0x5b/0x100
> [  257.880235]  removexattr+0x61/0x90
> [  257.880611]  ? kvm_clock_read+0x18/0x30
> [  257.881023]  ? kvm_clock_get_cycles+0x9/0x10
> [  257.881492]  ? ktime_get+0x3e/0xa0
> [  257.881856]  ? native_apic_msr_read+0x40/0x40
> [  257.882302]  ? lapic_next_event+0x21/0x30
> [  257.882716]  ? clockevents_program_event+0x8f/0xe0
> [  257.883206]  ? hrtimer_update_next_event+0x4b/0x70
> [  257.883698]  ? debug_smp_processor_id+0x17/0x20
> [  257.884181]  ? preempt_count_add+0x4d/0xc0
> [  257.884605]  __x64_sys_fremovexattr+0x82/0xb0
> [  257.885063]  do_syscall_64+0x3b/0x90
> [  257.885495]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> <...>
> [  257.892816]  </TASK>
> 
> -ritesh
> 
> > mbcache interface I had to add because it just requires too deep knowledge of
> > how things work internally to get things right. If you get it wrong, you'll
> > have subtle races like above. But I didn't find a more transparent way to
> > fix this race. If someone has ideas, suggestions are welcome!
> >
> > 								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
