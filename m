Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EF273F77A
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jun 2023 10:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjF0If6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Jun 2023 04:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjF0Ifm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Jun 2023 04:35:42 -0400
X-Greylist: delayed 83992 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Jun 2023 01:35:36 PDT
Received: from mail.xolti.net (master.xolti.net [51.77.231.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6F82E3
        for <linux-ext4@vger.kernel.org>; Tue, 27 Jun 2023 01:35:36 -0700 (PDT)
Received: from [172.23.0.31] (93-44-176-40.ip98.fastwebnet.it [93.44.176.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.xolti.net (Postfix) with ESMTPSA id 3E0AE16A0
        for <linux-ext4@vger.kernel.org>; Tue, 27 Jun 2023 10:35:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.xolti.net 3E0AE16A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=robertoragusa.it;
        s=default; t=1687854935;
        bh=EncmQHph7DpTSrjuKkXy63pZvVH0KdHL73B7RDRWkKA=;
        h=Date:Subject:From:To:References:In-Reply-To:From;
        b=RGivvaW7XHyK+gFkeNTKzvNX33SJO2ID2RFZ5RIJMyO8I8MBzpdIL/SqWg5KqgPuj
         3M0f3Zs7YqSMAxpFVsESD++ZpaGB3ROWmHWoN/QHDfkpS4kUiGHw56Hvs+XXFeyIje
         EnE3owS7pPgRbzMxAI5Zjy6eBVPUsyAMw8jj+6zs=
Message-ID: <c4351547-af48-d023-e6a8-cbc353effa75@robertoragusa.it>
Date:   Tue, 27 Jun 2023 10:35:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: packed_meta_blocks=1 incompatible with resize2fs?
Content-Language: en-US
From:   Roberto Ragusa <mail@robertoragusa.it>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
References: <49752bf2-71ec-7fbf-dcdf-93940cfa92c9@robertoragusa.it>
In-Reply-To: <49752bf2-71ec-7fbf-dcdf-93940cfa92c9@robertoragusa.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 6/26/23 11:15, Roberto Ragusa wrote:
> My attempts to work around the issue have failed:
> - adding resize=4290772992 in mkfs doesn't help
> - creating a bigger fs with packed_meta_blocks, then shrinking it,
> then re-extending it to the original size still allocates from the
> new space

An additional attempt is still not fully reaching the objective.

mkfs.ext4 -E resize=1073741824 -G 32768 /dev/mydev

I've tried raising G to have a single flex_bg group and this
is partially working, since resizing places "block bitmap"
and "inode bitmap" in the initial part of the disk, while "inode table"
is still taken from the added space. (tested on a rather full fs)

Do I have any other option?

It looks like resize2fs has no way to force the inode table to be
where a fresh mkfs would put it, pushing existing blocks out of
the way.
What complexity can I expect to find if I try to add this
feature to resize2fs?

Is there a way to NOT add more inodes when resizing? I would
be happy to keep the same number I've originally got, but apparently
each new block group assumes to have some inodes.

My use case should be a really wide interest one: metadata on fast
hardware, data on slow hardware. Is there no solution?

Regards.

-- 
    Roberto Ragusa    mail at robertoragusa.it

