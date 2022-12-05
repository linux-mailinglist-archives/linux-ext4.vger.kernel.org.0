Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACA964375E
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Dec 2022 22:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiLEVwl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Dec 2022 16:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbiLEVwF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Dec 2022 16:52:05 -0500
Received: from us.icdsoft.com (us.icdsoft.com [192.252.146.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AC929376
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 13:50:51 -0800 (PST)
Received: (qmail 15206 invoked by uid 1001); 5 Dec 2022 21:50:50 -0000
Received: from unknown (HELO ?94.155.37.249?) (famzah@icdsoft.com@94.155.37.249)
  by 192.252.159.165 with ESMTPA; 5 Dec 2022 21:50:50 -0000
Message-ID: <4e946dfd-96ca-44cc-6184-a354b8235ed1@icdsoft.com>
Date:   Mon, 5 Dec 2022 23:50:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: kernel BUG at fs/ext4/inode.c:1914 - page_buffers()
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <c9e47bc3-3c5f-09ae-9dcc-eb5957d78b1b@icdsoft.com>
 <Y45eV/nA2tj8C94W@mit.edu>
From:   Ivan Zahariev <famzah@icdsoft.com>
In-Reply-To: <Y45eV/nA2tj8C94W@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 5.12.2022 г. 23:10, Theodore Ts'o wrote:
> Is it fair to say that your workload is using data=journaled and is
> frequently truncating that might have been recently modified (hence
> triggering the race between truncate and journalled writepages)?

The servers are hosting hundreds of users who run their own tasks and we 
have no control nor a way to closely observe their usage pattern. Unless 
you point us in a direction to debug this somehow.

"data=journaled" is definitely in place for all servers.

> I wonder if you could come up with a more reliable reproducer so we
> can test a particular patch.

We already tried different parallel combinations of mmap()'ed reading, 
direct and regular write(), drop_caches, sync(), etc. but we can't 
trigger the panic.

If you have any suggestions what we should try next as a reproducer, 
please share and we will try to implement and execute it.

Did I understand correctly that a possible reproducer would be a loop of 
heavy write() followed by truncate() of the same file? Should we 
randomly sync() and/or "echo 3 > /proc/sys/vm/drop_caches" to increase 
the chance of hitting the bug?

Best regards.
--Ivan

