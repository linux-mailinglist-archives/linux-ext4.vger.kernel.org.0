Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0566129F1
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Oct 2022 11:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiJ3KLZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Oct 2022 06:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiJ3KLY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Oct 2022 06:11:24 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A771EB92;
        Sun, 30 Oct 2022 03:11:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y14so22828605ejd.9;
        Sun, 30 Oct 2022 03:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kmVCcGVlIiDXCml+FOnHEDlFiqFI4mHj74A5G0jAe+4=;
        b=qscRg9mFZO1a7kOWEaBRG7AJZDIcj8bGfUcSWT4sqn0vnPfDMPHGjG+wsGrr96eQAy
         6zxR0UTTOpPFnvQFbSq3jcHVv22YoQA1pcaeNsg9wQB8SPNermtdROczz7tlGm8987E6
         z2VUchKEeiV2sGa4yexhbEoR62nIZumfr+ByRoB8jjayjPhDyR6DpYypi6P5LeSrMVJs
         29ApzfyMPuh3fC9qksdbplKNTII0jY1thpkoz7fubsDa5p2LYqf9uj6FtqZ1fuPHycun
         y7HcvjPZkN6XpmPt8Fu3Dhx9KODG5gBckPnJVtDRwNd1Pi6K+eXtA9znS5KmRGNtROkG
         VFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kmVCcGVlIiDXCml+FOnHEDlFiqFI4mHj74A5G0jAe+4=;
        b=3bjwGKaq4f0d6ux+WY0vvf7QaWMYQ3MccPJC0k9wyxfbGNerYnbkzKEl1Jnqp8SNOt
         VqahaBWP0TZxQoOrbKO6gz2TAewNWUqTw/VQ2LuOhrpiXUmM1V8TGHy3uA19DBtfG2id
         NI4wTMWjY/E7RuXy0SvdnJqbdkqsmaz2toBPXe5dZVpTyDFSsjOkHbSjUQTP1l5/nAYU
         wsMt2xdptIJ68yfCKTkcdNx/ulfB2AUa50jbfDrm6p4OmxB/HFQzF5QS+T/QirVCHVta
         FPbdN92kNBJhBwaLVOTV4Ru1tbogI9Z2Cg91UnCjBvDJX+2hNwzG4ffyoC+gL0xEcG+D
         mnEg==
X-Gm-Message-State: ACrzQf3LSrsufye967bUcZgoB9hKR0d5+FWhJSq9A7VrHirwZZ7gLlyq
        z+HMyPVdC8UTw69K1yNc3AKPvBeUssJYCWvSCO0=
X-Google-Smtp-Source: AMsMyM7ddoRu5lHrTFQsjc66UpXc04MpqJqyPdOzDy72VYqmALKERGRH1voMfeovusy7axhFf0O4oszk/nlbZPfYiYQ=
X-Received: by 2002:a17:907:7f8b:b0:7ad:b45d:4e9a with SMTP id
 qk11-20020a1709077f8b00b007adb45d4e9amr5551169ejc.421.1667124682126; Sun, 30
 Oct 2022 03:11:22 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Sun, 30 Oct 2022 18:10:42 +0800
Message-ID: <CAO4mrfcT15fuMdTFuVK_aZjfAR=c_W0epWZqH6yT-zSJbAg-dA@mail.gmail.com>
Subject: INFO: rcu detected stall in kjournald2
To:     tytso@mit.edu, jack@suse.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Dear Linux Developer,

Recently when using our tool to fuzz kernel, the following crash was triggered:

HEAD commit: 64570fbc14f8 Linux 5.15-rc5
git tree: upstream
compiler: gcc 8.0.1
console output:
https://drive.google.com/file/d/1OdakNSSR2L4PKHjhh6f2qHTq_OzKJGMM/view?usp=share_link
kernel config: https://drive.google.com/file/d/1uDOeEYgJDcLiSOrx9W8v2bqZ6uOA_55t/view?usp=share_link

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu:  0-...!: (2 ticks this GP) idle=591/1/0x4000000000000000
softirq=22864/22864 fqs=1
  (t=11867 jiffies g=32309 q=191)
NMI backtrace for cpu 0
CPU: 0 PID: 2958 Comm: jbd2/sda-8 Not tainted 5.15.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
Call Trace:
 <IRQ>
 dump_stack_lvl+0xcd/0x134
 nmi_cpu_backtrace.cold.8+0xf3/0x118
 nmi_trigger_cpumask_backtrace+0x18f/0x1c0
 rcu_dump_cpu_stacks+0x116/0x1e0
 rcu_sched_clock_irq.cold.108+0x221/0x459
 update_process_times+0xcf/0x130
 tick_sched_handle.isra.20+0x47/0xa0
 tick_sched_timer+0xa2/0xc0
 __hrtimer_run_queues+0x2ea/0x810
 hrtimer_interrupt+0x12b/0x2c0
 __sysvec_apic_timer_interrupt+0x9c/0x2c0
 sysvec_apic_timer_interrupt+0x99/0xc0
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20
RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x60
Code: 74 24 10 e8 8a a3 70 fc 48 89 ef e8 e2 d4 70 fc 81 e3 00 02 00
00 75 25 9c 58 f6 c4 02 75 2c 48 85 db 74 01 fb bf 01 00 00 00 <e8> e3
69 6c fc 65 8b 05 4c 17 42 7b 85 c0 74 0a 5b 5d c3 e8 70 e3
RSP: 0018:ffffc9000ae8f8f8 EFLAGS: 00000206
RAX: 0000000000000002 RBX: 0000000000000200 RCX: ffff8881084b5280
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
RBP: ffff8881000c5a00 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000005 R11: 0000000000000000 R12: ffff88800d80a780
R13: 0000000000000246 R14: ffff888104496000 R15: ffff88800c7fd280
 ata_scsi_queuecmd+0x5e/0x90
 scsi_queue_rq+0x678/0x13e0
 blk_mq_dispatch_rq_list+0x209/0xd10
 __blk_mq_do_dispatch_sched+0x1ff/0x490
 __blk_mq_sched_dispatch_requests+0x16f/0x1f0
 blk_mq_sched_dispatch_requests+0x5e/0xb0
 __blk_mq_run_hw_queue+0x70/0xd0
 __blk_mq_delay_run_hw_queue+0x315/0x370
 blk_mq_run_hw_queue+0xb5/0x140
 blk_mq_sched_insert_requests+0x116/0x430
 blk_mq_flush_plug_list+0x1e4/0x3f0
 blk_flush_plug_list+0x137/0x160
 blk_finish_plug+0x32/0x50
 jbd2_journal_commit_transaction+0x1df1/0x3540
 kjournald2+0x106/0x430
 kthread+0x1a6/0x1e0
 ret_from_fork+0x1f/0x30
----------------
Code disassembly (best guess):
   0: 74 24                 je     0x26
   2: 10 e8                 adc    %ch,%al
   4: 8a a3 70 fc 48 89     mov    -0x76b70390(%rbx),%ah
   a: ef                    out    %eax,(%dx)
   b: e8 e2 d4 70 fc        callq  0xfc70d4f2
  10: 81 e3 00 02 00 00     and    $0x200,%ebx
  16: 75 25                 jne    0x3d
  18: 9c                    pushfq
  19: 58                    pop    %rax
  1a: f6 c4 02              test   $0x2,%ah
  1d: 75 2c                 jne    0x4b
  1f: 48 85 db              test   %rbx,%rbx
  22: 74 01                 je     0x25
  24: fb                    sti
  25: bf 01 00 00 00        mov    $0x1,%edi
* 2a: e8 e3 69 6c fc        callq  0xfc6c6a12 <-- trapping instruction
  2f: 65 8b 05 4c 17 42 7b  mov    %gs:0x7b42174c(%rip),%eax        # 0x7b421782
  36: 85 c0                 test   %eax,%eax
  38: 74 0a                 je     0x44
  3a: 5b                    pop    %rbx
  3b: 5d                    pop    %rbp
  3c: c3                    retq
  3d: e8                    .byte 0xe8
  3e: 70 e3                 jo     0x23

Best,
Wei
