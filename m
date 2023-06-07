Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64ECE7253B2
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Jun 2023 07:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjFGFvf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Jun 2023 01:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjFGFve (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Jun 2023 01:51:34 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBCA19AE;
        Tue,  6 Jun 2023 22:51:33 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6af6de9fb74so5938194a34.2;
        Tue, 06 Jun 2023 22:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686117092; x=1688709092;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3rI6tnKxeARgopgF90YS7donPiDWh6Vu53ylR5OXg0=;
        b=RmvWZQGtP3jLhos9gsUInx2oe9IIbwa3hwfhmzyWvsmnfF1tWBrX//YjcuHLCP7thf
         BWk0scuAgJcutm2KIODyLq/Wt0CkMaDYBhmbrDMrarZ2ug9zGrfGkTgG383aEL9RDCYL
         C7qU7KrWIs17ivI4/nMMuntO6vETS3JvQD8rnC8JMLG/oXYPi47K8fA0EEfZqHvM2Bw+
         eHlJ5Jb2AEbc6hJcU+twVMSXXcs3q6R27Ott8mrAxYjB82Au7B11UImg3do/VnGxGy+c
         czjsAFbihTl6iEybH8rzaHvTAfgPQTgo3+Ou0GAc1Qgh9XebDjacpVL5tWpcmd7cG9i9
         vsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686117092; x=1688709092;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O3rI6tnKxeARgopgF90YS7donPiDWh6Vu53ylR5OXg0=;
        b=GVpbo6uFJ3V2rcjUszMuGObXREFSRtUvvYQb35Qf9B9gtCEDY3KlnAmWrDhTKHgrmn
         AgV0luHevHFUFvzW/DBKk6Q4LChTN5gG08eKrPLHly6J+Q4X8czDltJ7zwRoIMjOko2D
         8XOn+aYQRdgpk4dzzqNv8K4TASR7dwe0hfgZYUKzki/5z1wWgTfAiyKz/RotsY2pbILr
         LiOb8J881OQ2W1gdwxzD1ZPHYyjNSc8EtAa/1TVselH98C1frDGTZqrRh3eMlDDKLh6h
         o8wdYbXn1zGJblODUdR7zW/5SprodtBLht5DPvZAKAvy7cGBM8ZZn4roMxUqjAms505Z
         6fcA==
X-Gm-Message-State: AC+VfDxDI2wekdOUp8QJLyyiw+c8L6QA9qF9X/bi1YB39HjrnjHGWIrw
        wOPy++EZOv4EWqDd+VFETg4=
X-Google-Smtp-Source: ACHHUZ7/d1dW7bob/8me+LolHy42civ7LW00G+Fcu7tlgp7+UFl1XGjOs3bfDFoj7EMeVlx+DOHOXg==
X-Received: by 2002:a05:6830:13c9:b0:6ab:1b58:f408 with SMTP id e9-20020a05683013c900b006ab1b58f408mr3853451otq.19.1686117092582;
        Tue, 06 Jun 2023 22:51:32 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-58.three.co.id. [116.206.12.58])
        by smtp.gmail.com with ESMTPSA id b16-20020aa78110000000b00660d80087a8sm1750425pfi.187.2023.06.06.22.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 22:51:32 -0700 (PDT)
Message-ID: <653b3359-2005-21b1-039d-c55ca4cffdcc@gmail.com>
Date:   Wed, 7 Jun 2023 12:51:26 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux ext4 Development <linux-ext4@vger.kernel.org>,
        Nikolas Kraetzschmar <nikolas.kraetzschmar@sap.com>,
        Linux Stable <stable@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Remounting ext4 filesystem from ro to rw fails when quotas are
 enabled
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Since commit a44be64, remounting a read-only ext4 filesystem to become read-write fails when quotas are enabled. The mount syscall returns -EROFS and outputs the following in dmesg:
> 
> ```
> EXT4-fs warning (device loop0): ext4_enable_quotas:7028: Failed to enable quota tracking (type=0, err=-30, ino=3). Please run e2fsck
> ```
> 
> 
> Root cause
> 
> The problem can be traced back to the changes introduced in commit a44be64. It appears that the issue arises because the SB_RDONLY bit of the s_flags field is now only cleared after executing the ext4_enable_quotas function. However, the vfs_setup_quota_inode function, called by ext4_enable_quotas, checks whether this bit is set (fs/quota/dquot.c:2331):
> 
> ```
> if (IS_RDONLY(inode))
> 	return -EROFS;
> ```
> 
> This condition therefore always triggers the -EROFS fail condition.
> 
> 
> Steps to Reproduce
> 
> The bug can be reproduced by executing the following script on a current mainline kernel with defconfig:
> 
> ```
> #!/bin/bash
> 
> set -ex
> 
> truncate -s 1G /tmp/img
> mkfs.ext4 /tmp/img
> tune2fs -Q usrquota,grpquota,prjquota /tmp/img
> losetup /dev/loop0 /tmp/img
> mount -o ro /dev/loop0 /mnt
> mount -o remount,rw /mnt
> ```
> 
> Executing the script results in the following output:
> 
> ```
> + truncate -s 1G /tmp/img
> + mkfs.ext4 /tmp/img
> mke2fs 1.47.0 (5-Feb-2023)
> Discarding device blocks: done
> Creating filesystem with 262144 4k blocks and 65536 inodes
> Filesystem UUID: b96a3da2-043f-11ee-b6f0-47c69db05231
> Superblock backups stored on blocks:
> 	32768, 98304, 163840, 229376
> 
> Allocating group tables: done
> Writing inode tables: done
> Creating journal (8192 blocks): done
> Writing superblocks and filesystem accounting information: done
> 
> + tune2fs -Q usrquota,grpquota,prjquota /tmp/img
> tune2fs 1.47.0 (5-Feb-2023)
> + losetup /dev/loop0 /tmp/img
> [    6.766763] loop0: detected capacity change from 0 to 2097152
> + mount -o ro /dev/loop0 /mnt
> [    6.791561] EXT4-fs (loop0): mounted filesystem b96a3da2-043f-11ee-b6f0-47c69db05231 ro with ordered data mode. Quota mode: journalled.
> + mount -o remount,rw /mnt
> [    6.805546] EXT4-fs warning (device loop0): ext4_enable_quotas:7028: Failed to enable quota tracking (type=0, err=-30, ino=3). Please run e2fsck to fix.
> mount: /mnt: cannot remount /dev/loop0 read-write, is write-protected.
>        dmesg(1) may have more information after failed mount system call.
> ```

See Bugzilla for the full thread.

Ted, it looks like this regression is caused by your ext4_xattr_block_set()
fix to earlier syzbot report. Would you like to take a look on it?

Anyway, I'm adding it to regzbot:

#regzbot introduced: a44be64bbecb15 https://bugzilla.kernel.org/show_bug.cgi?id=217529
#regzbot title: Remounting ext4 filesystem from ro to rw fails when quotas are enabled

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217529

-- 
An old man doll... just what I always wanted! - Clara
