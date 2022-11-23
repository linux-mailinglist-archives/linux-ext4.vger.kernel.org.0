Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B4F63627A
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Nov 2022 15:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237815AbiKWOyp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Nov 2022 09:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237758AbiKWOyp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Nov 2022 09:54:45 -0500
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Nov 2022 06:54:44 PST
Received: from us.icdsoft.com (us.icdsoft.com [192.252.146.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FDDC02
        for <linux-ext4@vger.kernel.org>; Wed, 23 Nov 2022 06:54:44 -0800 (PST)
Received: (qmail 4397 invoked by uid 1001); 23 Nov 2022 14:48:03 -0000
Received: from unknown (HELO ?94.155.37.249?) (famzah@icdsoft.com@94.155.37.249)
  by 192.252.159.165 with ESMTPA; 23 Nov 2022 14:48:03 -0000
Message-ID: <c9e47bc3-3c5f-09ae-9dcc-eb5957d78b1b@icdsoft.com>
Date:   Wed, 23 Nov 2022 16:48:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Ivan Zahariev <famzah@icdsoft.com>
Subject: kernel BUG at fs/ext4/inode.c:1914 - page_buffers()
To:     linux-ext4@vger.kernel.org
Content-Language: en-US
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

Starting with kernel 5.15 for the past eight months we have a total of 
12 kernel panics at a fleet of 1000 KVM/Qemu machines which look the 
following way:

     kernel BUG at fs/ext4/inode.c:1914

Switching from kernel 4.14 to 5.15 almost immediately triggered the 
problem. Therefore we are very confident that userland activity is more 
or less the same and is not the root cause. The kernel function which 
triggers the BUG is __ext4_journalled_writepage(). In 5.15 the code for 
__ext4_journalled_writepage() in "fs/ext4/inode.c" is the same as the 
current kernel "master". The line where the BUG is triggered is:

     struct buffer_head *page_bufs = page_buffers(page)

The definition of "page_buffers(page)" in "include/linux/buffer_head.h" 
hasn't changed since 4.14, so no difference here. This is where the 
actual "kernel BUG" event is triggered:

     /* If we *know* page->private refers to buffer_heads */
     #define page_buffers(page) \
         ({ \
             BUG_ON(!PagePrivate(page)); \
             ((struct buffer_head *)page_private(page)); \
         })
     #define page_has_buffers(page) PagePrivate(page)

Initially I thought that the issue is already discussed here: 
https://lore.kernel.org/all/Yg0m6IjcNmfaSokM@google.com/
But this seems to be another (solved) problem and Theodore Ts'o already 
made a quick fix by simply reporting the rare occurrence and continuing 
forward. The commit is in 5.15 (and in the latest kernel), so it's not 
helping our case: 
https://github.com/torvalds/linux/commit/cc5095747edfb054ca2068d01af20be3fcc3634f

Back to the problem! 99% of the difference between 4.14 and the latest 
kernel for __ext4_journalled_writepage() in "fs/ext4/inode.c" comes from 
the following commit: 
https://github.com/torvalds/linux/commit/5c48a7df91499e371ef725895b2e2d21a126e227

Is it safe that we revert this patch on the latest 5.15 kernel, so that 
we can confirm if this resolves the issue for us?

Best regards.
--Ivan


