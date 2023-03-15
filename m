Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FC86BAF5C
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Mar 2023 12:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjCOLfS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Mar 2023 07:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjCOLe5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Mar 2023 07:34:57 -0400
X-Greylist: delayed 424 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Mar 2023 04:34:20 PDT
Received: from us.icdsoft.com (us.icdsoft.com [192.252.146.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872EA14995
        for <linux-ext4@vger.kernel.org>; Wed, 15 Mar 2023 04:34:20 -0700 (PDT)
Received: (qmail 28977 invoked by uid 1001); 15 Mar 2023 11:27:14 -0000
Received: from unknown (HELO ?94.155.37.249?) (famzah@icdsoft.com@94.155.37.249)
  by 192.252.159.165 with ESMTPA; 15 Mar 2023 11:27:14 -0000
Message-ID: <ea6a88c7-5603-af1d-e775-0857fc605224@icdsoft.com>
Date:   Wed, 15 Mar 2023 13:27:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: kernel BUG at fs/ext4/inode.c:1914 - page_buffers()
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <c9e47bc3-3c5f-09ae-9dcc-eb5957d78b1b@icdsoft.com>
 <Y45eV/nA2tj8C94W@mit.edu> <20230112150708.y2ws5q3wu2xxow3p@quack3>
From:   Ivan Zahariev <famzah@icdsoft.com>
In-Reply-To: <20230112150708.y2ws5q3wu2xxow3p@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_20,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 12.1.2023 г. 17:07, Jan Kara wrote:
> So after a bit of thought I agree that the commit 5c48a7df91499 ("ext4: fix
> an use-after-free issue about data=journal writeback mode") is broken. The
> problem is when we unlock the page in __ext4_journalled_writepage() anybody
> else can come, writeout the page, and reclaim page buffers (due to memory
> pressure). Previously, bh references were preventing the buffer reclaim to
> happen but now there's nothing to prevent it.
>
> My rewrite of data=journal writeback path fixes this problem as a
> side-effect but perhaps we need a quickfix for stable kernels? Something
> like attached patch?
>
> 								Honza

Do you consider this patch production ready?

Should we test it on real production machines with a peace of mind that 
nothing can go wrong in regards to data loss or corruption?

--Ivan

