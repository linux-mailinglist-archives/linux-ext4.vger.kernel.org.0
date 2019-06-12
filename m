Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A04D142864
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Jun 2019 16:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436976AbfFLOHP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Jun 2019 10:07:15 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:33751 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436899AbfFLOHP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Jun 2019 10:07:15 -0400
Received: by mail-lf1-f48.google.com with SMTP id y17so12234985lfe.0
        for <linux-ext4@vger.kernel.org>; Wed, 12 Jun 2019 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/4ksvlE5aJSqbe7ieMVw10yNaNcbBpfED9Q1bJtqXnc=;
        b=fxrdhIoTRn/Aj/nkmjfx5er+SAfPCR6fOpTkijKHWbo1ameW9dADyAY24tzFMXdFsS
         mrkfw3eBL6ICSDUTwV4mjYnT1IO2x4/9SICBcSVgykf7mX7eqP29O6lZoeTMe0Jau8R3
         DiJRD/P0NgELKrn7rCpoHBwZ4QFPKX71pUJJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/4ksvlE5aJSqbe7ieMVw10yNaNcbBpfED9Q1bJtqXnc=;
        b=qGKnZ3j5nmq95n6JihYLxblK/6ZKCaFonbXJ6dCy4SkOl8k2DhyT1k0HA6UZZ6M7Dx
         KszXgBpxXyFa42fDZFfW8P996SZ3mZqr8I/kfGlY8h+icz2EcQfu35Tk9gADm+iip4cY
         LuH7pxBMulbnkqcFIdoVrPBpT3QEMwIu0QK2ioRXLXPrSvs0QwhjSpmpOifNWfWGi8NP
         yXfK5p6v4rIPyNUHEB/PY7dceY5BDE+VXFeESrjXDrWfV4YRTDr7bu8i0LC3KNxfJl2t
         ErYAiAYzm4NYkmXbkZXH14oyzfMO9C/VD9j4+Jrr0/bVUvGf0EVGqamjKZhvixMFwmw8
         yghQ==
X-Gm-Message-State: APjAAAW4eFYeAsdQ8N6gh+JQgYrOprKfieYMzQNrLENTm3Z6acdcxTiL
        Ei35YwwfZ0ZD4lzq1WfoWzdJau4Muvh1oqvV
X-Google-Smtp-Source: APXvYqwuI47R9Bi3IVPg2ChOFTgzXo1yeD64EI928eQGr6xndQd1hnQMKYKM3FTjJAvfcYsXGgRasA==
X-Received: by 2002:ac2:5467:: with SMTP id e7mr17992170lfn.23.1560348432999;
        Wed, 12 Jun 2019 07:07:12 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y2sm3128978lfc.35.2019.06.12.07.07.11
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 07:07:12 -0700 (PDT)
To:     linux-ext4@vger.kernel.org
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: fsck doesn't seem to understand inline directories
Message-ID: <ee4ad9f4-6706-136d-4cd8-dcf1b58e4229@rasmusvillemoes.dk>
Date:   Wed, 12 Jun 2019 16:07:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi

Doing a forced check on an ext4 file system with inline_data results in
lots of warnings - and I think answering yes to "fixing" those would
actually corrupt the fs. To reproduce:

truncate -s 100000000 ext4.img
misc/mke2fs -t ext4 -b 4096 -I 512 -O
'^dir_nlink,extra_isize,filetype,^huge_file,inline_data,large_file,large_dir,^meta_bg,^project,^quota,^resize_inode,sparse_super,64bit,metadata_csum_seed,metadata_csum'
-U random -v ext4.img
mkdir m
sudo mount ext4.img m
sudo chown $USER:$USER m
mkdir m/aa
echo 123 > m/aa/123
touch m/aa/empty
seq 10000 > m/aa/largefile
mkdir m/aa/bb
mkdir m/cc
sudo umount m
e2fsck/e2fsck -f -n ext4.img

The last command gives this output:

-----
e2fsck 1.45.2 (27-May-2019)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
'..' in /aa (12) is <The NULL inode> (0), should be / (2).
Fix? no

Unconnected directory inode 16 (/aa/bb)
Connect to /lost+found? no

'..' in /cc (17) is <The NULL inode> (0), should be / (2).
Fix? no

Pass 4: Checking reference counts
Inode 2 ref count is 5, should be 3.  Fix? no

Inode 12 ref count is 3, should be 1.  Fix? no

Unattached inode 13
Connect to /lost+found? no

Unattached zero-length inode 14.  Clear? no

Unattached inode 14
Connect to /lost+found? no

Unattached inode 15
Connect to /lost+found? no

Unattached inode 16
Connect to /lost+found? no

Inode 17 ref count is 2, should be 1.  Fix? no

Pass 5: Checking group summary information

ext4.img: ********** WARNING: Filesystem still has errors **********

ext4.img: 17/24416 files (5.9% non-contiguous), 4096/24414 blocks
-----

Am I doing something wrong? The kernel mounting the fs above is 4.15, in
case that matters.

Rasmus
