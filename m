Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEC4116DF4
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Dec 2019 14:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfLIN3U (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Dec 2019 08:29:20 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35027 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727643AbfLIN3U (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Dec 2019 08:29:20 -0500
Received: by mail-ua1-f68.google.com with SMTP id y23so5595732ual.2
        for <linux-ext4@vger.kernel.org>; Mon, 09 Dec 2019 05:29:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p6yy6RPCwDZpxd4juLljS9qvo9MtkCCXsmRgQJgullU=;
        b=GL0RcquHNxgSLCvOxTpwI0GWUcZ6FfiNzspm4HSPE0LMsoj8JDkemhx0HmWjSFUv/L
         Tk/5BbmXPBOvudZO6zC39hrWVONv9vFQf0+YKwhIRA6dKiSyV7V5X80eDd+KuYu/ioK9
         OhMG5+Hrm7ZJzQHNWl0cLtVV39q9jkj5/04kUPriyO+YX1xWIu+S0uSuzakdcedtgeDm
         xS3288R+ipp5UoORB9dWZWEzIkdGztI+Osy2WHZ0nhQ77h4lGFBgQbFGaw7Vow1O3eHy
         VsTdEmbDYacec09jcnZrpEu/ENPxVHgyQAMt7zaKrQLU1fNUwVD0PYEWbE4M4YLR6vpk
         urzg==
X-Gm-Message-State: APjAAAXGI8oh5Uk6BGJdc4Icvo/J39Shb+Yj8nxttz1e1BI9i4cb9ivp
        4bXgDM2Ejsi1Sw27K4kfdC5QKQ==
X-Google-Smtp-Source: APXvYqzaZie3OXBH3ahijPvPnPnVVXg/Tm1KNZs5ozNQ2wMhjT5xVrdqO4FAePjYSVtpLgPACKsADA==
X-Received: by 2002:ab0:5392:: with SMTP id k18mr24520201uaa.24.1575898159136;
        Mon, 09 Dec 2019 05:29:19 -0800 (PST)
Received: from work.celeiro ([191.177.180.119])
        by smtp.gmail.com with ESMTPSA id x192sm12711726vkd.10.2019.12.09.05.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 05:29:18 -0800 (PST)
From:   Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
To:     ebiggers3@gmail.com
Cc:     adilger.kernel@dilger.ca,
        bot+eb13811afcefe99cfe45081054e7883f569f949d@syzkaller.appspotmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: ppc64el kernel access of bad area (ext4_htree_store_dirent->rb_insert_color)
Date:   Mon,  9 Dec 2019 10:29:14 -0300
Message-Id: <20191209132914.907306-1-rafaeldtinoco@ubuntu.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20171219215906.GA12465@gmail.com>
References: <20171219215906.GA12465@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

It looks like the same stacktrace that was reported in this thread. This has
been reported to ppc64el AND we got a reproducer (ocfs2-tools autopkgtests).

[ 85.605850] Faulting instruction address: 0xc000000000e81168
[ 85.605901] Oops: Kernel access of bad area, sig: 11 [#1]
[ 85.605970] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
[ 85.606029] Modules linked in: ocfs2 quota_tree ocfs2_dlmfs ocfs2_stack_o2cb ocfs2_dlm ocfs2_nodemanager ocfs2_stackglue iptable_mangle xt_TCPMSS xt_tcpudp bpfilter dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua vmx_crypto crct10dif_vpmsum sch_fq_codel ip_tables x_tables autofs4 btrfs xor zstd_compress raid6_pq libcrc32c crc32c_vpmsum virtio_net virtio_blk net_failover failover
[ 85.606291] CPU: 0 PID: 1 Comm: systemd Not tainted 5.3.0-18-generic #19-Ubuntu
[ 85.606350] NIP: c000000000e81168 LR: c00000000054f240 CTR: 0000000000000000
[ 85.606410] REGS: c00000005a3e3700 TRAP: 0300 Not tainted (5.3.0-18-generic)
[ 85.606469] MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE> CR: 28024448 XER: 00000000
[ 85.606531] CFAR: 0000701f9806f638 DAR: 0000000001744098 DSISR: 40000000 IRQMASK: 0
[ 85.606531] GPR00: 0000000000007374 c00000005a3e3990 c0000000019c9100 c00000004fe462a8
[ 85.606531] GPR04: c00000005856d840 000000000000000e 0000000074656772 c00000004fe4a568
[ 85.606531] GPR08: 0000000000000000 c000000058568004 0000000001744090 0000000000000000
[ 85.606531] GPR12: 00000000e8086002 c000000001d60000 00007fffddd522d0 0000000000000000
[ 85.606531] GPR16: 0000000000000000 0000000000000000 0000000000000000 c00000000755e07c
[ 85.606531] GPR20: c0000000598caca8 c00000005a3e3a58 0000000000000000 c000000058292f00
[ 85.606531] GPR24: c000000000eea710 0000000000000000 c00000005856d840 c00000000755e074
[ 85.606531] GPR28: 000000006518907d c00000005a3e3a68 c00000004fe4b160 00000000027c47b6
[ 85.607079] NIP [c000000000e81168] rb_insert_color+0x18/0x1c0
[ 85.607137] LR [c00000000054f240] ext4_htree_store_dirent+0x140/0x1c0
[ 85.607186] Call Trace:
[ 85.607208] [c00000005a3e3990] [c00000000054f158] ext4_htree_store_dirent+0x58/0x1c0 (unreliable)
[ 85.607279] [c00000005a3e39e0] [c000000000594cd8] htree_dirblock_to_tree+0x1b8/0x380
[ 85.607340] [c00000005a3e3b00] [c0000000005962c0] ext4_htree_fill_tree+0xc0/0x3f0
[ 85.607401] [c00000005a3e3c00] [c00000000054ebe4] ext4_readdir+0x814/0xce0
[ 85.607459] [c00000005a3e3d40] [c000000000472d6c] iterate_dir+0x1fc/0x280
[ 85.607511] [c00000005a3e3d90] [c0000000004746f0] ksys_getdents64+0xa0/0x1f0
[ 85.607572] [c00000005a3e3e00] [c000000000474868] sys_getdents64+0x28/0x130
[ 85.607622] [c00000005a3e3e20] [c00000000000b388] system_call+0x5c/0x70
[ 85.607672] Instruction dump:
[ 85.607703] 4082ffe8 4e800020 38600000 4e800020 60000000 60000000 e9230000 2c290000
[ 85.607764] 4182018c e9490000 71480001 4c820020 <e90a0008> 7c284840 2fa80000 4182006c
[ 85.607827] ---[ end trace cfc53af0f8d62cef ]---
[ 85.610600]
[ 86.611522] BUG: Unable to handle kernel data access at 0xc000030058567eff
[ 86.611604] Faulting instruction address: 0xc000000000403aa8
[ 86.611656] Oops: Kernel access of bad area, sig: 11 [#2]
[ 86.611697] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
[ 86.611748] Modules linked in: ocfs2 quota_tr

Thread from beginning 2018, so I guess this issue is pretty intermittent but
might exist, and, perhaps, its related to specific arches/machines ?
