Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F8F7413E4
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jun 2023 16:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjF1Of6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Jun 2023 10:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjF1Ofz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Jun 2023 10:35:55 -0400
Received: from mail.xolti.net (master.xolti.net [IPv6:2001:41d0:404:200::1c23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F96519BE
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jun 2023 07:35:52 -0700 (PDT)
Received: from [172.23.0.31] (93-44-176-40.ip98.fastwebnet.it [93.44.176.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.xolti.net (Postfix) with ESMTPSA id 130E91386;
        Wed, 28 Jun 2023 16:35:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.xolti.net 130E91386
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=robertoragusa.it;
        s=default; t=1687962951;
        bh=jexGnzwDPI0QhCL4XqhT2rQZZ0bEO8H/CK3KKJJF5dE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=urxjf0fi17Lbk3wM1liw5Zi6xrpTukqvoF02yGoeUF7jXhBJu8A2pUEdtYmtPcdmA
         ArDpo4kYjPfajr7V9KBrAVaJK9nEk21tQc7dEFrIDb/guKS5NWhHigBHIc7zTGkh3T
         qausKgQA4GbjoYXQ094zndaGeu1Dh0Jozxmegg6Q=
Message-ID: <8b1464cf-833d-de2b-9c71-7732d65fc23f@robertoragusa.it>
Date:   Wed, 28 Jun 2023 16:35:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: packed_meta_blocks=1 incompatible with resize2fs?
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
References: <49752bf2-71ec-7fbf-dcdf-93940cfa92c9@robertoragusa.it>
 <20230628000327.GG8954@mit.edu>
From:   Roberto Ragusa <mail@robertoragusa.it>
In-Reply-To: <20230628000327.GG8954@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 6/28/23 02:03, Theodore Ts'o wrote:

> Unfortunately, (a) there is no place where the fact that the file
> system was created with this mkfs option is recorded in the
> superblock, and (b) once the file system starts getting used, the
> blocks where the metadata would need to be allocated at the start of
> the disk will get used for directory and data blocks.

Isn't resize2fs already capable of migrating directory and data blocks
away? According to the comments at the beginning of resize2fs.c, I mean.

> OK, so I think what you're trying to do is to create a RAID0 device
> where the first part of the md raid device is stored on SSD, and after
> that there would be one or more HDD devices.  Is that right?

More or less.
Using LVM and having the first extents of the LV on a fast PV and all the
others on a slow PV.

> In theory, it would be possible to add a file system extension where
> the first portion of the MD device is not allowed to be used for
> normal block allocations[...]

I would not aim to a so complex way.
My hope was that one of the two was possible:
1. reserve the bitmaps and inode table space since the beginning (with mke2fs
option resize, for example)
2. push things out of the way when the expansion is done

I could attempt to code something to do 2., but I would either have to
study resize2fs code, which is not trivial, or write something from scratch,
based only on the layout docs, which would be also complex and not easily
mergeable in resize2fs.

Other options may have been:
3. do not add new inodes when expanding (impossible by design, right?)
4. have an offline way (custom tool, or detecting conflicting files and
temporarily removing them, ...) to free the needed blocks

At the moment the best option I have is to continue doing what I've been
doing for years already: use dumpe2fs and debugfs to discover which bg
contain metadata+journal and selectively use "pvmove" to migrate
those extents (PE) to the fast PV. Automatable, but still messy.
Discovering "packed_meta_blocks" turned out not a so great finding as I was
hoping, if then you can't resize.

Thanks.
-- 
    Roberto Ragusa    mail at robertoragusa.it

