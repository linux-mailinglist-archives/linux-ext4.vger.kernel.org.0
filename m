Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213125B68C9
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Sep 2022 09:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiIMHkH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Sep 2022 03:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiIMHkC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Sep 2022 03:40:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346FD38B6;
        Tue, 13 Sep 2022 00:39:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D20545BF0D;
        Tue, 13 Sep 2022 07:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663054796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bhtTOaZSVDFSb88RTgF6R8ScCFUcJJqoxUk1VgH0qO8=;
        b=22Y1Of9P5MFHJoKkkUwdgklFW+ZKn3SpVcfC5ekLpvpvb8vxfQb1qPpgPWS3kjXMVNr48w
        rDHCemFq5Kg219KpkW3MchzSFafEPnScz/UbkkcgJQN/L78/cvNyJpk2WM6q7U4j8cG18g
        DUvnQ3jOoj3ggyEGDgIxUJNSDq8vDH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663054796;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bhtTOaZSVDFSb88RTgF6R8ScCFUcJJqoxUk1VgH0qO8=;
        b=U+G66CjaNmrAHprCSw9XxH59Vxg2FWXZnQuHD+q6lgqygYGtxY8CVpfFymZbB7wBK1gdH2
        oZCsSRfkq6jWRnBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C21B513AB5;
        Tue, 13 Sep 2022 07:39:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id juhVL8wzIGPlBAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 13 Sep 2022 07:39:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1803FA067E; Tue, 13 Sep 2022 09:39:56 +0200 (CEST)
Date:   Tue, 13 Sep 2022 09:39:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Haichi Wang <wanghaichi@tju.edu.cn>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        lishuochuan <lishuochuan@tju.edu.cn>,
        junjiechen <junjiechen@tju.edu.cn>
Subject: Re: KASAN: use-after-free Write in jbd2_journal_wait_updates
Message-ID: <20220913073956.txrvzrm7jqrsxh3y@quack3>
References: <AAAABwCYFa2QeSO2ZHsCVKqN.1.1662993228047.Hmail.3014218099@tju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AAAABwCYFa2QeSO2ZHsCVKqN.1.1662993228047.Hmail.3014218099@tju.edu.cn>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 12-09-22 22:33:48, Haichi Wang wrote:
> Dear Linux maintainers and reviewers:
> We would like to report a linux kernel bug, found by a modified version of syzkaller.
> May affected file: fs/jbd2/transaction.c
> Kernel Version: 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3 (v5.17-rc6)
> Kernel Config: see attach, linux.config
> Syzkaller Version: 3666edfeb55080ebe138d77417fa96fe2555d6bb
> reproducing program: see attach, reproducing.txt.
>  
> To use the reproducing program, please follow
> https://github.com/google/syzkaller/blob/master/docs/reproducing_crashes.md
> for more details.
> 
> Feel free to  email us if any other infomations are needed. Hope the
> provided materials will help finding and fixing the bug.
> 
> The full log crash log are as follows:(also in the attach, crash.report)
> ---------
> warning: checkpointing journal with EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT can be slow
> ==================================================================
> BUG: KASAN: use-after-free in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
> BUG: KASAN: use-after-free in atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:541 [inline]
> BUG: KASAN: use-after-free in queued_spin_lock include/asm-generic/qspinlock.h:82 [inline]
> BUG: KASAN: use-after-free in do_raw_spin_lock include/linux/spinlock.h:185 [inline]
> BUG: KASAN: use-after-free in __raw_spin_lock include/linux/spinlock_api_smp.h:134 [inline]
> BUG: KASAN: use-after-free in _raw_spin_lock+0x73/0xd0 kernel/locking/spinlock.c:154
> Write of size 4 at addr ffff88803359c1a0 by task syz-executor.1/3650
> 
> CPU: 1 PID: 3650 Comm: syz-executor.1 Tainted: G S                5.17.0-rc6 #7
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x4d/0x66 lib/dump_stack.c:106
>  print_address_description.constprop.0+0x21/0x150 mm/kasan/report.c:255
>  __kasan_report mm/kasan/report.c:442 [inline]
>  kasan_report.cold+0x7f/0x11b mm/kasan/report.c:459
>  check_region_inline mm/kasan/generic.c:183 [inline]
>  kasan_check_range+0x14d/0x1d0 mm/kasan/generic.c:189
>  instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
>  atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:541 [inline]
>  queued_spin_lock include/asm-generic/qspinlock.h:82 [inline]
>  do_raw_spin_lock include/linux/spinlock.h:185 [inline]
>  __raw_spin_lock include/linux/spinlock_api_smp.h:134 [inline]
>  _raw_spin_lock+0x73/0xd0 kernel/locking/spinlock.c:154
>  spin_lock include/linux/spinlock.h:349 [inline]
>  jbd2_journal_wait_updates+0x1f1/0x280 fs/jbd2/transaction.c:861

Ah, this one. Should be fixed by commit f7f497cb7024 ("jbd2: kill
t_handle_lock transaction spinlock") which got merged to 5.18-rc1.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
