Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636022448C6
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Aug 2020 13:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgHNL0n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 Aug 2020 07:26:43 -0400
Received: from mail.thelounge.net ([91.118.73.15]:27899 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgHNL0n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 14 Aug 2020 07:26:43 -0400
Received: from srv-rhsoft.rhsoft.net (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4BSh3M59cfzXSZ;
        Fri, 14 Aug 2020 13:26:34 +0200 (CEST)
Subject: Re: libext2fs: mkfs.ext3 really slow on centos 8.2
To:     Maciej Jablonski <mafjmafj@gmail.com>
Cc:     Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org
References: <CAPQccj4_Tz-11AfXaSiPj4aRWYU2mX9eJuJyGNR68Mini0PZjw@mail.gmail.com>
 <CAPQccj7XwunXerNYxPBTpBa0JVX7vzC=7aBoE8m35ttFHYNOPg@mail.gmail.com>
 <4D72360F-7836-4C4F-920D-4D1BC1DE704E@dilger.ca>
 <3cc33ea5-ab63-344e-7251-daa808b855bb@thelounge.net>
 <CAPQccj4SGG4JMcDMdJff3w-BVpv5vfQm2H4DuSk2X8Wu4o5j0Q@mail.gmail.com>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Message-ID: <94e31f56-bc39-2827-6c8d-70f4a8db95b9@thelounge.net>
Date:   Fri, 14 Aug 2020 13:26:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAPQccj4SGG4JMcDMdJff3w-BVpv5vfQm2H4DuSk2X8Wu4o5j0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



Am 14.08.20 um 12:33 schrieb Maciej Jablonski:
> We have been historically pegged to ext3, however, it now looks worth
> to reconsider ext4.

all our virtual servers where installed in 2008 with Fedora 9 and at
that time ext3

* 2009 we migrated all datasisks to ext4
* https://fedoraproject.org/wiki/Dracut

after dracut came in the mix we where also ale to convert all rootfs to
ext4 and just reboot

never looked back to ext3

using recent kernels you most likely don't have an ext3 driver at all,
it's the ext4 which can handle ext3 pretty fine

tune2fs 1.45.5 (07-Jan-2020)
Filesystem volume name:   system
Last mounted on:          /
Filesystem UUID:          918f24a7-bc8e-4da5-8a23-8800d5104421
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index
filetype needs_recovery extent flex_bg sparse_super large_file uninit_bg
dir_nlink
Filesystem flags:         signed_directory_hash
Default mount options:    journal_data_writeback user_xattr acl nobarrier
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              393216
Block count:              1572354
Reserved block count:     2
Free blocks:              1350883
Free inodes:              366435
First block:              0
Block size:               4096
Fragment size:            4096
Reserved GDT blocks:      383
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         8192
Inode blocks per group:   512
Filesystem created:       Mon Aug 18 06:48:05 2008
Last mount time:          Tue Aug 11 02:59:54 2020
Last write time:          Fri Aug 14 02:09:32 2020
Mount count:              12
Maximum mount count:      30
Last checked:             Thu Aug  6 21:48:28 2020
Check interval:           31104000 (12 months)
Next check after:         Sun Aug  1 21:48:28 2021
Lifetime writes:          1483 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               256
Journal inode:            8
First orphan inode:       32820
Default directory hash:   half_md4
Directory Hash Seed:      1e9d689f-15fe-4c0d-aaba-9d323049c7f4
Journal backup:           inode blocks
