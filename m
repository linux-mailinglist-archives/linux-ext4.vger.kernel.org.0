Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3405E794452
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Sep 2023 22:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244282AbjIFUNp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Sep 2023 16:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjIFUNo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Sep 2023 16:13:44 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC11198E
        for <linux-ext4@vger.kernel.org>; Wed,  6 Sep 2023 13:13:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-401d24f1f27so2807125e9.1
        for <linux-ext4@vger.kernel.org>; Wed, 06 Sep 2023 13:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694031216; x=1694636016; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:subject:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqhCcPHwg07e161PkHUbQ1xXO0x8R1fHk44QIsowPDc=;
        b=qgn6OfSETICsYf5tMTZxlE7SXVKnb21kJ63FMnHUCFWHqD4iKCdMu8lqr2echMp/lW
         li0bb8nJeuJeQyTIbuw+QCDXhthzRYanhKvdq/AVPK29IInNc8yCiG38MhpMmsr3IP/f
         j8LbV+G3yI+leIv2f/It3ms/R8fcYEb8XGvcD5s4ZWo2Tl90L15vOUqFaLF/ShVbV053
         UOyxjWp1KLQNg1mDjGM6XJEzwmQhi12rVcjwhuP3uk6S8kqMt3+ai6OFV0CKQbrxVkQa
         qEerzRkNUYZXT5shZ5XAs+FD9HsoHP/3NeLIEy3N0hEmjmBGebODy6kXvdMrNSywtrVh
         ck8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694031216; x=1694636016;
        h=mime-version:message-id:date:references:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YqhCcPHwg07e161PkHUbQ1xXO0x8R1fHk44QIsowPDc=;
        b=jaLicbHb7VHcz7Ryr2eRC4IVnIFdgvsypTjwNL1/OtLi97t3V4XTx0sS8eSl3PRGT2
         yzjI0MLzJiKBpPTer81SntaRSxcMWV+RId8fOq8ddt9v5DD2XLkE3ScTOixX64/vvQqE
         b0S/MkZdFc444FUBISug7M2tODt/Cub6D/kV0lZBHDBxbnmDcVJ+M+ndqdIlzlmN5Myw
         3CLOuf+mLEk/djTI1hfL8HukmLj1iNnnLZ2xCOFgAd3BQYRidV3XIYzsM32FZwEea5so
         UkOIdtZtJfkJthY7rb5FO/f26L1zqRvI1vSTtjBDTDPFVBo6fcACTSQojIQw7gTFYkbA
         /xyA==
X-Gm-Message-State: AOJu0Yy0DS9wBukX43MyG5JU8st6uZl/idWwnYh9Vhians/g/iSUlNGR
        9uJeSaIWh6LZO3z5s8/z0HNCIXPu/R4UEw==
X-Google-Smtp-Source: AGHT+IG7QJGJIwD5l+HX3ym2MbZR1pjOw2cU1VEqgUj19719n2iOG/mgFlmW0gIAnxekeEwHDRwi8w==
X-Received: by 2002:a05:600c:287:b0:401:dc7c:2494 with SMTP id 7-20020a05600c028700b00401dc7c2494mr3347038wmk.27.1694031215278;
        Wed, 06 Sep 2023 13:13:35 -0700 (PDT)
Received: from x1 (253.red-83-57-67.dynamicip.rima-tde.net. [83.57.67.253])
        by smtp.gmail.com with ESMTPSA id o9-20020adfe809000000b003176c6e87b1sm21468775wrm.81.2023.09.06.13.13.34
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 13:13:34 -0700 (PDT)
From:   Free Ekanayaka <free.ekanayaka@gmail.com>
To:     linux-ext4@vger.kernel.org
Subject: direct I/O: ext4 seems to not honor RWF_DSYNC when journal is disabled
References: <87ttscddv4.fsf@x1.mail-host-address-is-not-set>
Date:   Wed, 06 Sep 2023 21:15:01 +0100
Message-ID: <87il8nhxdm.fsf@x1.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

(reposting after having subscribed, and from a different address since
the first mail did not show up in the archives and didn't bounce either)

Hello,

I'm using Linux 6.4.0 from Debian/testing (but tried this with 6.5.1
too).

I've created an ext4 filesystem with journalling disabled on an NVMe
drive:

mkfs.ext4 -O ^has_journal -F /dev/nvme0n1p6

I have a program that creates and open a new file with O_DIRECT, and
sets its size to 8M with posix_fallocate(), something like:

fd = open("/dir/file", O_CREAT | O_WRONLY | O_DIRECT);
posix_fallocate(fd, 0, 8 * 1024 * 1024);
fsync(fd);
dirfd = open("/dir", O_RDONLY | O_DIRECTORY);
fsync(dirfd);

and then it uses io_uring to perform a single write of 4096 bytes at the
beginning of the file, passing RWF_DSYNC to the submitted
IORING_OP_WRITE_FIXED entry,

I would expect the kernel to tell the NVMe device to actually flush the
write, not only buffer it. However I measured the end-to-end latency of
the io_uring operation and it was very low, as if the write was only
buffered by the NVMe device, but not flushed.

This suspicion seems to be confirmed by tracing the write nvme command
sent to the device:

raft-benchmark-37801   [003] .....  9904.831153: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=4, cmdid=25169, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=498455480, len=7, ctrl=0x0, dsmgmt=0, reftag=0)

notice the "ctrl=0x0" in there. If I run the same program, but I write
directly to the /dev/nvme0n1p6 device instead of using a file, I get:

raft-benchmark-37936   [003] .....  9942.784628: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=4, cmdid=29265, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=498192384, len=7, ctrl=0x4000, dsmgmt=0, reftag=0)

and here notice the "ctrl=0x4000", which I would expect is some flag to
tell to the NVMe device to also flush the write.

If I enable "write through" on the NVMe device:

echo "write through" | sudo tee /sys/block/nvme0n1/queue/write_cache

then also the direct write to the /dev/nvme0n1p6 device avoids flushing
the command, as expected:

raft-benchmark-38106   [003] .....  9971.741308: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=4, cmdid=33361, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=498192384, len=7, ctrl=0x0, dsmgmt=0, reftag=0)

(notice the "ctrl=0x0" there).

My question is: is my interpretation correct? Is it expected that ext4
does not tell the block layer/device to flush this write when
journalling is disabled?

Below you find the complete event trace of the io_uring call, both in
the ext4 write case and in the raw /dev/nvme0n1p6 write case.

I can provide a C reproducer as well if needed, but wanted to first
check if this rings any bell.

Thanks,

Free

== ext4 ==

  raft-benchmark-37801   [003] .....  9904.830974: io_uring_submit_req: ring 0000000011cab2e4, req 00000000c7a7d835, user_data 0x0, opcode WRITE_FIXED, flags 0x1, sq_thread 0
  raft-benchmark-37801   [003] .....  9904.830982: ext4_es_lookup_extent_enter: dev 259,5 ino 12 lblk 0
  raft-benchmark-37801   [003] .....  9904.830983: ext4_es_lookup_extent_exit: dev 259,5 ino 12 found 1 [0/1) 32887 U
  raft-benchmark-37801   [003] .....  9904.830985: ext4_journal_start_inode: dev 259,5 blocks 2, rsv_blocks 0, revoke_creds 8, type 1, ino 12, caller ext4_dirty_inode+0x38/0x80 [ext4]
  raft-benchmark-37801   [003] .....  9904.830987: ext4_mark_inode_dirty: dev 259,5 ino 12 caller ext4_dirty_inode+0x5b/0x80 [ext4]
  raft-benchmark-37801   [003] .....  9904.830989: block_touch_buffer: 259,5 sector=135 size=4096
  raft-benchmark-37801   [003] .....  9904.830993: block_dirty_buffer: 259,5 sector=135 size=4096
  raft-benchmark-37801   [003] .....  9904.831121: ext4_es_lookup_extent_enter: dev 259,5 ino 12 lblk 0
  raft-benchmark-37801   [003] .....  9904.831122: ext4_es_lookup_extent_exit: dev 259,5 ino 12 found 1 [0/1) 32887 UR
  raft-benchmark-37801   [003] .....  9904.831123: ext4_journal_start_inode: dev 259,5 blocks 8, rsv_blocks 0, revoke_creds 8, type 3, ino 12, caller ext4_iomap_begin+0x1c2/0x2f0 [ext4]
  raft-benchmark-37801   [003] .....  9904.831124: ext4_es_lookup_extent_enter: dev 259,5 ino 12 lblk 0
  raft-benchmark-37801   [003] .....  9904.831124: ext4_es_lookup_extent_exit: dev 259,5 ino 12 found 1 [0/1) 32887 UR
  raft-benchmark-37801   [003] .....  9904.831125: ext4_ext_map_blocks_enter: dev 259,5 ino 12 lblk 0 len 1 flags CREATE|UNWRIT|PRE_IO
  raft-benchmark-37801   [003] .....  9904.831126: ext4_es_cache_extent: dev 259,5 ino 12 es [0/1) mapped 32887 status U
  raft-benchmark-37801   [003] .....  9904.831127: ext4_ext_show_extent: dev 259,5 ino 12 lblk 0 pblk 32887 len 1
  raft-benchmark-37801   [003] .....  9904.831128: ext4_ext_handle_unwritten_extents: dev 259,5 ino 12 m_lblk 0 m_pblk 32887 m_len 1 flags CREATE|UNWRIT|PRE_IO|METADATA_NOFAIL allocated 1 newblock 32887
  raft-benchmark-37801   [003] .....  9904.831129: ext4_es_cache_extent: dev 259,5 ino 12 es [0/1) mapped 32887 status U
  raft-benchmark-37801   [003] .....  9904.831130: ext4_mark_inode_dirty: dev 259,5 ino 12 caller ext4_split_extent+0xcd/0x190 [ext4]
  raft-benchmark-37801   [003] .....  9904.831131: block_touch_buffer: 259,5 sector=135 size=4096
  raft-benchmark-37801   [003] .....  9904.831133: block_dirty_buffer: 259,5 sector=135 size=4096
  raft-benchmark-37801   [003] .....  9904.831134: ext4_ext_map_blocks_exit: dev 259,5 ino 12 flags CREATE|UNWRIT|PRE_IO lblk 0 pblk 32887 len 1 mflags NMU ret 1
  raft-benchmark-37801   [003] .....  9904.831135: ext4_es_lookup_extent_enter: dev 259,5 ino 12 lblk 0
  raft-benchmark-37801   [003] .....  9904.831135: ext4_es_lookup_extent_exit: dev 259,5 ino 12 found 1 [0/1) 32887 UR
  raft-benchmark-37801   [003] .....  9904.831136: ext4_es_insert_extent: dev 259,5 ino 12 es [0/1) mapped 32887 status U
  raft-benchmark-37801   [003] .....  9904.831143: block_bio_remap: 259,0 WS 498455480 + 8 <- (259,5) 263096
  raft-benchmark-37801   [003] .....  9904.831144: block_bio_queue: 259,0 WS 498455480 + 8 [raft-benchmark]
  raft-benchmark-37801   [003] .....  9904.831149: block_getrq: 259,0 WS 498455480 + 8 [raft-benchmark]
  raft-benchmark-37801   [003] .....  9904.831149: block_plug: [raft-benchmark]
  raft-benchmark-37801   [003] .....  9904.831153: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=4, cmdid=25169, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=498455480, len=7, ctrl=0x0, dsmgmt=0, reftag=0)
  raft-benchmark-37801   [003] .....  9904.831159: block_rq_issue: 259,0 WS 4096 () 498455480 + 8 [raft-benchmark]
  raft-benchmark-37801   [003] d.h..  9904.831173: nvme_sq: nvme0: disk=nvme0n1, qid=4, head=783, tail=783
  raft-benchmark-37801   [003] d.h..  9904.831177: nvme_complete_rq: nvme0: disk=nvme0n1, qid=4, cmdid=25169, res=0x0, retries=0, flags=0x0, status=0x0
  raft-benchmark-37801   [003] d.h..  9904.831178: block_rq_complete: 259,0 WS () 498455480 + 8 [0]
     kworker/3:1-30279   [003] .....  9904.831193: ext4_journal_start_inode: dev 259,5 blocks 8, rsv_blocks 0, revoke_creds 8, type 3, ino 12, caller ext4_convert_unwritten_extents+0xb4/0x260 [ext4]
     kworker/3:1-30279   [003] .....  9904.831193: ext4_es_lookup_extent_enter: dev 259,5 ino 12 lblk 0
     kworker/3:1-30279   [003] .....  9904.831194: ext4_es_lookup_extent_exit: dev 259,5 ino 12 found 1 [0/1) 32887 U
     kworker/3:1-30279   [003] .....  9904.831194: ext4_ext_map_blocks_enter: dev 259,5 ino 12 lblk 0 len 1 flags CREATE|UNWRIT|CONVERT
     kworker/3:1-30279   [003] .....  9904.831195: ext4_es_cache_extent: dev 259,5 ino 12 es [0/1) mapped 32887 status U
     kworker/3:1-30279   [003] .....  9904.831195: ext4_ext_show_extent: dev 259,5 ino 12 lblk 0 pblk 32887 len 1
     kworker/3:1-30279   [003] .....  9904.831196: ext4_ext_handle_unwritten_extents: dev 259,5 ino 12 m_lblk 0 m_pblk 32887 m_len 1 flags CREATE|UNWRIT|CONVERT|METADATA_NOFAIL allocated 1 newblock 32887
     kworker/3:1-30279   [003] .....  9904.831196: ext4_mark_inode_dirty: dev 259,5 ino 12 caller ext4_ext_map_blocks+0xeee/0x1980 [ext4]
     kworker/3:1-30279   [003] .....  9904.831197: block_touch_buffer: 259,5 sector=135 size=4096
     kworker/3:1-30279   [003] .....  9904.831198: block_dirty_buffer: 259,5 sector=135 size=4096
     kworker/3:1-30279   [003] .....  9904.831199: ext4_ext_map_blocks_exit: dev 259,5 ino 12 flags CREATE|UNWRIT|CONVERT lblk 0 pblk 32887 len 1 mflags M ret 1
     kworker/3:1-30279   [003] .....  9904.831199: ext4_es_insert_extent: dev 259,5 ino 12 es [0/1) mapped 32887 status W
     kworker/3:1-30279   [003] .....  9904.831200: ext4_mark_inode_dirty: dev 259,5 ino 12 caller ext4_convert_unwritten_extents+0x1e2/0x260 [ext4]
     kworker/3:1-30279   [003] .....  9904.831200: block_touch_buffer: 259,5 sector=135 size=4096
     kworker/3:1-30279   [003] .....  9904.831201: block_dirty_buffer: 259,5 sector=135 size=4096
     kworker/3:1-30279   [003] .....  9904.831202: ext4_sync_file_enter: dev 259,5 ino 12 parent 2 datasync 1 
     kworker/3:1-30279   [003] .....  9904.831203: ext4_sync_file_exit: dev 259,5 ino 12 ret 0
  raft-benchmark-37801   [003] ...1.  9904.831212: io_uring_complete: ring 0000000011cab2e4, req 00000000c7a7d835, user_data 0x0, result 4096, cflags 0x0 extra1 0 extra2 0 
  raft-benchmark-37801   [003] .....  9904.831213: io_uring_task_work_run: tctx 000000005c8048e9, count 1, loops 1

== /dev/nvme0n1p6 ==

  raft-benchmark-37936   [003] .....  9942.784613: io_uring_submit_req: ring 00000000c4f84b11, req 00000000058196bf, user_data 0x0, opcode WRITE_FIXED, flags 0x1, sq_thread 0
  raft-benchmark-37936   [003] .....  9942.784622: block_bio_remap: 259,0 WFS 498192384 + 8 <- (259,5) 0
  raft-benchmark-37936   [003] .....  9942.784622: block_bio_queue: 259,0 WFS 498192384 + 8 [raft-benchmark]
  raft-benchmark-37936   [003] .....  9942.784626: block_getrq: 259,0 WFS 498192384 + 8 [raft-benchmark]
  raft-benchmark-37936   [003] .....  9942.784628: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=4, cmdid=29265, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=498192384, len=7, ctrl=0x4000, dsmgmt=0, reftag=0)
  raft-benchmark-37936   [003] .....  9942.784634: block_rq_issue: 259,0 WFS 4096 () 498192384 + 8 [raft-benchmark]
  raft-benchmark-37936   [003] d.h..  9942.794331: nvme_sq: nvme0: disk=nvme0n1, qid=4, head=784, tail=784
  raft-benchmark-37936   [003] d.h..  9942.794334: nvme_complete_rq: nvme0: disk=nvme0n1, qid=4, cmdid=29265, res=0x0, retries=0, flags=0x0, status=0x0
  raft-benchmark-37936   [003] d.h..  9942.794334: block_rq_complete: 259,0 WFS () 498192384 + 8 [0]
  raft-benchmark-37936   [003] ...1.  9942.794338: io_uring_complete: ring 00000000c4f84b11, req 00000000058196bf, user_data 0x0, result 4096, cflags 0x0 extra1 0 extra2 0 
  raft-benchmark-37936   [003] .....  9942.794338: io_uring_task_work_run: tctx 000000005fccbc0a, count 1, loops 1
-------------------- End of forwarded message --------------------
