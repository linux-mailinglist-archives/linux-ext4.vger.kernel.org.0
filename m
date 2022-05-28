Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E260B536EC9
	for <lists+linux-ext4@lfdr.de>; Sun, 29 May 2022 01:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiE1Wz7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 May 2022 18:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiE1Wz6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 May 2022 18:55:58 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA6C20BF1
        for <linux-ext4@vger.kernel.org>; Sat, 28 May 2022 15:55:57 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id c15-20020a9d684f000000b0060b097c71ecso5347465oto.10
        for <linux-ext4@vger.kernel.org>; Sat, 28 May 2022 15:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=lcv+WxJFHV20qbHWSjv7o6OApdQxYB9IE9Ik0cT/3yY=;
        b=NSveMsBbkN75P7u2nUMdXSs/SNI8qZQ9bgyxTDfNOHIn+NIkyEpged7I/mvaPRPxEo
         EW/SDDNeRA5Ohpk8fTtr4MF/k1dYcSZqxotGCgwMTW9TOtpqr+q+WEsL/hhwQO43y7xp
         OvqbjJ1LwGqWOp3xObmmB957zQRYDICFmG/7b131AC4v9BcJwRaA8dk4wjEqRJ0MSFi2
         JxRZmM4bmXSakXQGdxeqGtNUNM+zr4MoVTD6XZAUlLxS+GscDkOv7jVMJclYjDa3BpI2
         y8xsjN2Vb2G3MvBt4m3oRh/l/kcL6MFZi3KgZAfTW33t1FG7tMz468VOYtTf5soLc9q2
         2dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lcv+WxJFHV20qbHWSjv7o6OApdQxYB9IE9Ik0cT/3yY=;
        b=FuRERZ09v6iTycAKYMUVAMQWMKb/vGjdWFgRla2WpE3SpuAAvC7GzvFpks77llLuWA
         MgCCgi9QS8cXOl+Hyxs0Q8fwwO2W0pH01cza7rRm2Z5+gEC8w6mFUIjfwYH4LvXELSCV
         FHQRGnXEFdQQVE3HC5vUUQ8ns/nECJB06WaZ3TEkggdm+FsFH/v9+QZSU/CGnuSQjskP
         2xjGxvXkU77IWZsnQq+Ql8YwJ1vEmZ2CY2Jzwn4aFSUu70k2SzIobZ3nmpMOWBaVRgA6
         JhpZQip2bVQlohRT9JYlhehUFFZE/wfS+ONKA9SObR2iqScBwd7xNQmxKBRMwMS4bvfx
         WOPA==
X-Gm-Message-State: AOAM532ffC6dXUBUKqsh65mws9NgxLYFKT/sTfEeWT0Eac7iU41Z7gSG
        Ns1xlbzccjXX4aAce9fdgpSmwJWQPk+sTlfkHDlY6rM1KE0=
X-Google-Smtp-Source: ABdhPJwFl1FkPdb9V8BC+gM9Pdm283VBVmbxLLQxYowjU2IbTdwPLmOOLcob9UPnx6dD/fVcbi4kisRFNpQd9+NYTJk=
X-Received: by 2002:a9d:19e5:0:b0:606:d75:9239 with SMTP id
 k92-20020a9d19e5000000b006060d759239mr19481568otk.120.1653778556605; Sat, 28
 May 2022 15:55:56 -0700 (PDT)
MIME-Version: 1.0
From:   "Stephen E. Baker" <baker.stephen.e@gmail.com>
Date:   Sat, 28 May 2022 18:55:45 -0400
Message-ID: <CAFDdnB38yRcZ+mQButh9UwGoh928xsZCgmjQ7r3HPEpEwdrZbg@mail.gmail.com>
Subject: simplify ext4_sb_read_encoding regression
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

I have a Samsung Chromebook Plus (rk3399-gru-kevin) which boots linux
off an external ssd plugged into USB. The root filesystem is ext4 with
unicode support, case folding is enabled only on some directories in
my home directory.

Since 5.17 the system has been unbootable. I ran a git bisect and it
pointed to aa8bf298a96acaaaa3af07d09cf7ffeb9798e48a ext4: simplify
ext4_sb_read_encoding

Unfortunately reverting that commit alone did not make 5.17 bootable,
and reverting the whole patch series conflicts with later changes.

tune2fs 1.46.5 (30-Dec-2021)
Filesystem volume name:   <none>
Last mounted on:          /mnt/chrome
Filesystem UUID:          8b5e21f1-3d26-4340-8326-d5a3e54f89fc
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index
filetype needs_recovery extent 64bit flex_bg casefold sparse_super
large_file huge_file dir_nlink extra_isize metadata_csum
Filesystem flags:         signed_directory_hash
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              30523392
Block count:              122087425
Reserved block count:     6104371
Overhead clusters:        2196820
Free blocks:              108560118
Free inodes:              29690527
First block:              0
Block size:               4096
Fragment size:            4096
Group descriptor size:    64
Reserved GDT blocks:      1024
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         8192
Inode blocks per group:   512
Flex block group size:    16
Filesystem created:       Sun Apr 24 18:30:23 2022
Last mount time:          Sat May 28 18:45:39 2022
Last write time:          Sat May 28 18:45:39 2022
Mount count:              118
Maximum mount count:      -1
Last checked:             Sun Apr 24 18:30:23 2022
Check interval:           0 (<none>)
Lifetime writes:          96 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               256
Required extra isize:     32
Desired extra isize:      32
Journal inode:            8
Default directory hash:   half_md4
Directory Hash Seed:      4973c679-1148-4fa4-b450-2bd335cee42d
Journal backup:           inode blocks
Checksum type:            crc32c
Checksum:                 0x9480930d
Character encoding:       utf8-12.1
