Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED55762850D
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Nov 2022 17:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbiKNQWn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Nov 2022 11:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbiKNQWf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Nov 2022 11:22:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD535F56
        for <linux-ext4@vger.kernel.org>; Mon, 14 Nov 2022 08:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668442901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b5pWgKtpfIELeX1FxEhoLqe/KwJwZ2Jjvji8hMgQLg8=;
        b=eSx1B9XLc3iGxR9XT17jj0sDP82OZ+B830ywqWgXfmvS1v+Vm9T8Z4McJ8Sic+A8vx5KTe
        +1UtWiJDdi3Ib6f9PLs6aYC64tLGFUAfi2tkADVpIpc54PCtKkL/QFOwuKTaXz4dAGrU7g
        zUCW4umzAe5NXa6zff9xISOIQn8s0tE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-3lcizJ8QMdWmUZcdYS_JTg-1; Mon, 14 Nov 2022 11:21:37 -0500
X-MC-Unique: 3lcizJ8QMdWmUZcdYS_JTg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C9A029AA3B2;
        Mon, 14 Nov 2022 16:21:36 +0000 (UTC)
Received: from [10.22.9.229] (unknown [10.22.9.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC55AC15BB3;
        Mon, 14 Nov 2022 16:21:35 +0000 (UTC)
Message-ID: <8c3757ae-1aeb-49a4-47af-598d1d4737ea@redhat.com>
Date:   Mon, 14 Nov 2022 11:21:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in ext4_enable_quotas
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>,
        syzbot <syzbot+ea70429cd5cf47ba8937@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
References: <0000000000006a74dd05e9931449@google.com>
 <000000000000073a4a05ed620676@google.com> <Y3Jb1Wcs/mQlZP32@mit.edu>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y3Jb1Wcs/mQlZP32@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 11/14/22 10:16, Theodore Ts'o wrote:
> +jaeguk,chao,peterz,mingo,longman,boqun.feng (F2FS and Lockdep maintainers)
>
> On Sun, Nov 13, 2022 at 02:55:47PM -0800, syzbot wrote:
>> syzbot has found a reproducer for the following issue on:
>>
>> HEAD commit:    af7a05689189 Merge tag 'mips-fixes_6.1_1' of git://git.ker..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=175bb059880000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=cbbe7c32024f5b72
>> dashboard link: https://syzkaller.appspot.com/bug?extid=ea70429cd5cf47ba8937
>> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10930249880000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11af96ae880000
> This looks like it's either a f2fs or lockdep bug.  To trigger the
> crash, the reproducer is mounting and unmounting the f2fs file system
> a huge number of times, and then ext4 calls lockdep_set_subclass which
> then triggers a KASAN report:
>
> BUG: KASAN: slab-out-of-bounds in lockdep_set_quota_inode fs/ext4/super.c:6803 [inline]
>
> On fs/ext4/super.c:6803 is the call to lockdep_set_subclass:
>
> 	lockdep_set_subclass(&ei->i_data_sem, subclass);
>
> So the KASAN failure is coming from some kind of out-of-bounds pointer
> dereference inside lockdep's internal data structures:
>
>   kasan_report+0xcd/0x100 mm/kasan/report.c:495
>   lockdep_set_quota_inode fs/ext4/super.c:6803 [inline]
>   ext4_quota_enable fs/ext4/super.c:6913 [inline]
>   ext4_enable_quotas+0x577/0xcf0 fs/ext4/super.c:6940
>   __ext4_fill_super fs/ext4/super.c:5500 [inline]
>   ext4_fill_super+0x7ee4/0x8610 fs/ext4/super.c:5643
>   get_tree_bdev+0x400/0x620 fs/super.c:1324
>   vfs_get_tree+0x88/0x270 fs/super.c:1531
>   do_new_mount+0x289/0xad0 fs/namespace.c:3040
>   do_mount fs/namespace.c:3383 [inline]

lockdep_set_subclass() should be translated into a call to 
lockdep_init_map_type():

#define lockdep_set_subclass(lock, sub)                                 \
         lockdep_init_map_type(&(lock)->dep_map, #lock, 
(lock)->dep_map.key, sub,\
(lock)->dep_map.wait_type_inner,          \
(lock)->dep_map.wait_type_outer,          \
                               (lock)->dep_map.lock_type)

All memory access should be within the bound of the given 
"&ei->i_data_sem". Also lockdep_init_map_type() is not in the stack 
trace. So it is not a problem within this lockdep_init_map_type() 
function. So is it possible that the given inode pointer is invalid?

Cheers,
Longman


