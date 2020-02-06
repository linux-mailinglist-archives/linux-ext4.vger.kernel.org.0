Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5479815482F
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2020 16:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbgBFPfn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Thu, 6 Feb 2020 10:35:43 -0500
Received: from MAIL.13thfloor.at ([213.145.232.33]:57702 "EHLO
        MAIL.13thfloor.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgBFPfn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Feb 2020 10:35:43 -0500
Received: by mail.13thfloor.at (Postfix, from userid 1001)
        id EDD0216309; Thu,  6 Feb 2020 16:35:42 +0100 (CET)
Date:   Thu, 6 Feb 2020 16:35:42 +0100
From:   Herbert Poetzl <herbert@13thfloor.at>
To:     linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: EXT4: unsupported inode size: 4096
Message-ID: <20200206153542.GA30449@MAIL.13thfloor.at>
Mail-Followup-To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.5.11
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


I recently updated one of my servers from an older 4.19
Linux kernel to the latest 5.5 kernel mainly because of 
the many filesystem improvements, just to find that some
of my filesystems simply cannot be mounted anymore.

The kernel reports: EXT4-fs: unsupported inode size: 4096

Here is a simple test to reproduce the issue:

  truncate --size 16G data
  losetup /dev/loop0 data
  mkfs.ext4 -I 4096 /dev/loop0
  mount /dev/loop0 /media

[33700.299204] EXT4-fs (loop0): unsupported inode size: 4096

Note: this works perfectly fine und 4.19.84 and 4.14.145.

My guess so far is that somehow the ext4 filesystem now
checks that the inode size is not larger than the logical
block size of the underlying block device.

  # cat /sys/block/loop0/queue/logical_block_size  
  512

Note that the logical block size is also 512 on many SATA
drives which have a physical block size of 4096.

Any ideas how to address this problem and get the file-
systems to mount under Linux 5.5?

Many thanks in advance,
Herbert

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
