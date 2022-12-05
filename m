Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B919642EAE
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Dec 2022 18:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiLER13 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Dec 2022 12:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiLER1V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Dec 2022 12:27:21 -0500
Received: from us.icdsoft.com (us.icdsoft.com [192.252.146.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1651218BD
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 09:27:19 -0800 (PST)
Received: (qmail 3316 invoked by uid 1001); 5 Dec 2022 17:27:18 -0000
Received: from unknown (HELO ?94.155.37.249?) (famzah@icdsoft.com@94.155.37.249)
  by 192.252.159.165 with ESMTPA; 5 Dec 2022 17:27:18 -0000
Message-ID: <6f64edf8-2bed-4131-0042-6a2005ed6926@icdsoft.com>
Date:   Mon, 5 Dec 2022 19:27:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: kernel BUG at fs/ext4/inode.c:1914 - page_buffers()
Content-Language: en-US
From:   Ivan Zahariev <famzah@icdsoft.com>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <c9e47bc3-3c5f-09ae-9dcc-eb5957d78b1b@icdsoft.com>
In-Reply-To: <c9e47bc3-3c5f-09ae-9dcc-eb5957d78b1b@icdsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

I forgot to mention that the ext4 file system is mounted with 
"data=journal" and the crash happens on servers which have more than 20 
GB RAM and are I/O busy.

> Back to the problem! 99% of the difference between 4.14 and the latest 
> kernel for __ext4_journalled_writepage() in "fs/ext4/inode.c" comes 
> from the following commit: 
> https://github.com/torvalds/linux/commit/5c48a7df91499e371ef725895b2e2d21a126e227
>
> Is it safe that we revert this patch on the latest 5.15 kernel, so 
> that we can confirm if this resolves the issue for us?

If we can't or if it doesn't make sense to revert the patch, is there 
anything else we can do to assist in the debug of this rare kernel crash?

The machines are Qemu/KVM guests but dumping the whole memory would take 
a couple of minutes, so it's not viable.

Are there any debug statements we could add in 
__ext4_journalled_writepage() in "fs/ext4/inode.c" that may give a hint 
where the problem is?

Best regards.
--Ivan


