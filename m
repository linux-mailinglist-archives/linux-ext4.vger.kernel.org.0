Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19EE50FB7E
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Apr 2022 12:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242411AbiDZK5D (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Apr 2022 06:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiDZK5C (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Apr 2022 06:57:02 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D737DFFEC6;
        Tue, 26 Apr 2022 03:53:52 -0700 (PDT)
Received: from theinternet.molgen.mpg.de (theinternet.molgen.mpg.de [141.14.31.7])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9141861EA1928;
        Tue, 26 Apr 2022 12:53:49 +0200 (CEST)
Subject: Re: Linux 5.10.103: kernel BUG at fs/ext4/inode.c:2715!
From:   Donald Buczek <buczek@molgen.mpg.de>
To:     linux-ext4@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>, it+linux@molgen.mpg.de
References: <089c71ba-a9c4-161b-2212-2ced5a351ff6@molgen.mpg.de>
Message-ID: <82a5c679-9d53-ceec-10e2-c296fc073933@molgen.mpg.de>
Date:   Tue, 26 Apr 2022 12:53:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <089c71ba-a9c4-161b-2212-2ced5a351ff6@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 4/25/22 2:35 PM, Donald Buczek wrote:
> During umount:
> 
> [4030299.710121] ------------[ cut here ]------------
> [4030299.717077] kernel BUG at fs/ext4/inode.c:2715!
> [4030299.723983] invalid opcode: 0000 [#1] SMP NOPTI
> [4030299.730831] CPU: 3 PID: 44914 Comm: kworker/u260:4 Kdump: loaded Not tainted 5.10.103.mx64.429 #1
> [4030299.741978] Hardware name: Dell Inc. PowerEdge R7425/08V001, BIOS 1.15.0 09/11/2020
> [4030299.751863] Workqueue: writeback wb_workfn (flush-7:2)
> [4030299.759286] RIP: 0010:ext4_writepages+0xb64/0xd30 [ext4]
> [4030299.766832] Code: 47 a0 45 31 c0 ba db 09 00 00 48 8b 78 28 ff 70 40 e8 60 37 03 00 44 8b 95 e0 fe ff ff 44 8b 9d 0c ff ff ff 5e e9 53 fc ff ff <0f> 0b 44 8b 8d 0c ff ff ff 45 85 c9 0f 85 7d fb ff ff 44 0f b6 9d
> [4030299.789861] RSP: 0018:ffffc9001c4c7a40 EFLAGS: 00010203
> [4030299.797313] RAX: 000000c410000000 RBX: ffff893180a4ab90 RCX: 0000000000000000

Further information: This is this BUG_ON in ext4_writepages (inode.c)

	if (ext4_has_inline_data(inode)) {
		/* Just inode will be modified... */
		handle = ext4_journal_start(inode, EXT4_HT_INODE, 1);
		if (IS_ERR(handle)) {
			ret = PTR_ERR(handle);
			goto out_writepages;
		}
		BUG_ON(ext4_test_inode_state(inode,
				EXT4_STATE_MAY_INLINE_DATA));
		ext4_destroy_inline_data(handle, inode);
		ext4_journal_stop(handle);
	}

  Looking at the assembly code, I see that the value of i_flags checked by the macro is in %rax and the address of inode->i_flags is %rbx-0xf0.


     645c:       48 8b 83 10 ff ff ff    mov    -0xf0(%rbx),%rax                  # load i_flags -> %rax
     6463:       48 0f ba e0 27          bt     $0x27,%rax                        # bit test (32+EXT4_STATE_MAY_INLINE_DATA)
     6468:       0f 82 26 02 00 00       jb     6694 <ext4_writepages+0xb64>      # jump carry
...
     6694:       0f 0b                   ud2


The i_flags in %rax which were checked are 0x000000c410000000 which is EXT4_STATE_XATTR EXT4_STATE_NEWENTRY EXT4_STATE_MAY_INLINE_DATA EXT4_INLINE_DATA_FL

But looking at the memory, I get 0x0000004410000000  which is          EXT4_STATE_XATTR EXT4_STATE_NEWENTRY                            EXT4_INLINE_DATA_FL

set $b = 0xffff893180a4ab90
x/xg $b-0xf0
0xffff893180a4aaa0:	0x0000004410000000

It looks like EXT4_STATE_MAY_INLINE_DATA was cleared after BUG_ON checked it. Missing synchronization/barrier?

Another left out information: mkfs and mount options may be unusual:

mkfs.ext4 \
                 -q \
                 -m 0 \
                 -E nodiscard,mmp_update_interval=300,lazy_journal_init=1,root_owner=$MXQ_UID:0 \
                 -O '64bit,ext_attr,filetype,^has_journal,huge_file,inline_data,^mmp,^quota,sparse_super2' \
                 $loopdevice \
                 && mkdir -p $mountpoint && mount -Odata=writeback,barrier=0  $loopdevice $mountpoint

Best
   Donald

> [4030299.806683] RDX: ffff893e63a420c0 RSI: 0000000000000a95 RDI: 0000000000000000
> [4030299.815990] RBP: ffffc9001c4c7b70 R08: 0000000000000000 R09: ffffffffa0421d5d
> [4030299.825441] R10: ffffc9001c4c7b90 R11: 0000000000000199 R12: ffff893180a4ad08
> [4030299.834746] R13: ffffc9001c4c7c60 R14: 0000000000000001 R15: ffff888544ecf000
> [4030299.844029] FS:  0000000000000000(0000) GS:ffff893fffa00000(0000) knlGS:0000000000000000
> [4030299.854287] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [4030299.862184] CR2: 00007fb80c17f000 CR3: 00000020e3386000 CR4: 00000000003506e0
> [4030299.871415] Call Trace:
> [4030299.875978]  ? __getblk_gfp+0x2c/0x2d0
> [4030299.881836]  ? ext4_get_group_desc+0x53/0xd0 [ext4]
> [4030299.888771]  ? __ext4_get_inode_loc+0x103/0x420 [ext4]
> [4030299.895992]  ? do_writepages+0x4b/0xe0
> [4030299.901762]  do_writepages+0x4b/0xe0
> [4030299.907387]  ? __ext4_get_inode_loc_noinmem+0x3d/0x90 [ext4]
> [4030299.915035]  ? ext4_write_inode+0x100/0x150 [ext4]
> [4030299.921904]  ? __writeback_single_inode+0x40/0x2c0
> [4030299.928747]  __writeback_single_inode+0x40/0x2c0
> [4030299.935466]  writeback_sb_inodes+0x198/0x3f0
> [4030299.941683]  __writeback_inodes_wb+0x5e/0xc0
> [4030299.947836]  wb_writeback+0x246/0x2d0
> [4030299.953369]  ? wb_workfn+0x26e/0x490
> [4030299.958826]  wb_workfn+0x26e/0x490
> [4030299.964041]  ? process_one_work+0x1dd/0x3e0
> [4030299.970037]  process_one_work+0x1dd/0x3e0
> [4030299.975884]  ? cancel_delayed_work+0x90/0x90
> [4030299.981956]  worker_thread+0x2d/0x3b0
> [4030299.987437]  ? cancel_delayed_work+0x90/0x90
> [4030299.993454]  kthread+0x118/0x130
> [4030299.998416]  ? kthread_create_worker_on_cpu+0x70/0x70
> [4030300.005144]  ret_from_fork+0x22/0x30
> [4030300.010397] Modules linked in: tcp_diag udp_diag inet_diag unix_diag af_packet rpcsec_gss_krb5 nfsv4 nfs nfs_ssc ext4 mbcache jbd2 8021q garp stp mrp llc mgag200 drm_kms_helper drm kvm_amd fb_sys_fops kvm syscopyarea ixgbe hid_led sysfillrect led_class k10temp irqbypass crc32c_intel i2c_piix4 deflate sysimgblt efi_pstore pstore ipmi_si nfsd auth_rpcgss nfs_acl lockd grace sunrpc efivarfs ip_tables x_tables unix ipv6 autofs4
> [4030300.053994] ---[ end trace 8d7fbada643727ba ]---
> [4030300.643640] RIP: 0010:ext4_writepages+0xb64/0xd30 [ext4]
> [4030300.650625] Code: 47 a0 45 31 c0 ba db 09 00 00 48 8b 78 28 ff 70 40 e8 60 37 03 00 44 8b 95 e0 fe ff ff 44 8b 9d 0c ff ff ff 5e e9 53 fc ff ff <0f> 0b 44 8b 8d 0c ff ff ff 45 85 c9 0f 85 7d fb ff ff 44 0f b6 9d
> [4030300.672510] RSP: 0018:ffffc9001c4c7a40 EFLAGS: 00010203
> [4030300.679436] RAX: 000000c410000000 RBX: ffff893180a4ab90 RCX: 0000000000000000
> [4030300.688242] RDX: ffff893e63a420c0 RSI: 0000000000000a95 RDI: 0000000000000000
> [4030300.697076] RBP: ffffc9001c4c7b70 R08: 0000000000000000 R09: ffffffffa0421d5d
> [4030300.705896] R10: ffffc9001c4c7b90 R11: 0000000000000199 R12: ffff893180a4ad08
> [4030300.714711] R13: ffffc9001c4c7c60 R14: 0000000000000001 R15: ffff888544ecf000
> [4030300.723506] FS:  0000000000000000(0000) GS:ffff893fffa00000(0000) knlGS:0000000000000000
> [4030300.733274] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [4030300.740666] CR2: 00007fb80c17f000 CR3: 00000020e3386000 CR4: 00000000003506e0
> [4030300.749471] ------------[ cut here ]------------
> [4030300.755745] WARNING: CPU: 3 PID: 44914 at kernel/exit.c:725 do_exit+0x47/0xbc0
> [4030300.764629] Modules linked in: tcp_diag udp_diag inet_diag unix_diag af_packet rpcsec_gss_krb5 nfsv4 nfs nfs_ssc ext4 mbcache jbd2 8021q garp stp mrp llc mgag200 drm_kms_helper drm kvm_amd fb_sys_fops kvm syscopyarea ixgbe hid_led sysfillrect led_class k10temp irqbypass crc32c_intel i2c_piix4 deflate sysimgblt efi_pstore pstore ipmi_si nfsd auth_rpcgss nfs_acl lockd grace sunrpc efivarfs ip_tables x_tables unix ipv6 autofs4
> [4030300.808131] CPU: 3 PID: 44914 Comm: kworker/u260:4 Kdump: loaded Tainted: G      D           5.10.103.mx64.429 #1
> [4030300.820121] Hardware name: Dell Inc. PowerEdge R7425/08V001, BIOS 1.15.0 09/11/2020
> [4030300.829480] Workqueue: writeback wb_workfn (flush-7:2)
> [4030300.836396] RIP: 0010:do_exit+0x47/0xbc0
> [4030300.842040] Code: ec 38 65 48 8b 04 25 28 00 00 00 48 89 44 24 30 31 c0 48 8b 83 20 07 00 00 48 85 c0 74 0e 48 8b 10 48 39 d0 0f 84 58 02 00 00 <0f> 0b 65 8b 0d 70 87 fa 7e 89 c8 25 00 ff ff 00 89 44 24 0c 0f 85
> [4030300.864064] RSP: 0018:ffffc9001c4c7ee8 EFLAGS: 00010216
> [4030300.871082] RAX: ffffc9001c4c7d60 RBX: ffff893e63a420c0 RCX: 0000000000000000
> [4030300.880007] RDX: ffff88810b0b0e48 RSI: 0000000000000000 RDI: 000000000000000b
> [4030300.888962] RBP: 000000000000000b R08: 0000000000000000 R09: 0000000000000001
> [4030300.897905] R10: 0000000000000000 R11: ffffc9001c4c7698 R12: 0000000000000246
> [4030300.906829] R13: 0000000000000002 R14: ffffffff8221a5e9 R15: ffff893e63a420c0
> [4030300.915774] FS:  0000000000000000(0000) GS:ffff893fffa00000(0000) knlGS:0000000000000000
> [4030300.925676] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [4030300.933211] CR2: 00007fb80c17f000 CR3: 00000020e3386000 CR4: 00000000003506e0
> [4030300.942114] Call Trace:
> [4030300.946409]  ? cancel_delayed_work+0x90/0x90
> [4030300.952526]  ? kthread+0x118/0x130
> [4030300.957790]  rewind_stack_do_exit+0x17/0x20
> [4030300.963825] RIP: 0000:0x0
> [4030300.968301] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
> [4030300.976977] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
> [4030300.986459] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [4030300.995495] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [4030301.004457] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [4030301.013398] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [4030301.022317] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [4030301.031161] ---[ end trace 8d7fbada643727bb ]---
> 
> Just to be clear (in case you've read https://lore.kernel.org/linux-ext4/4e83fb26-4d4a-d482-640c-8104973b7ebf@molgen.mpg.de/): This is not related. None of these fcntl or device mapper tricks mentioned in the other mail have been attempted.
> 
> Here we have a normal unmount of a ext4 filesystem on a loop device as exercised millions of times before by us. In fact, exercised 27318 times during this very boot on this machines alone.
> 


-- 
Donald Buczek
buczek@molgen.mpg.de

