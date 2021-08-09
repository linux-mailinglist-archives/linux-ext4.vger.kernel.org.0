Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573123E40F5
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Aug 2021 09:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhHIHng (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Aug 2021 03:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbhHIHnf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Aug 2021 03:43:35 -0400
X-Greylist: delayed 34202 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Aug 2021 00:43:15 PDT
Received: from mail.valdk.tel (mail.valdk.tel [IPv6:2a02:e00:ffe7:c::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27288C061796
        for <linux-ext4@vger.kernel.org>; Mon,  9 Aug 2021 00:43:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D1F3E24D08F;
        Mon,  9 Aug 2021 10:43:09 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valdikss.org.ru;
        s=msrv; t=1628494990;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=j/HDCveL7/s6PO3Cojbm2xxwwRkp04B45qsFfM5gedA=;
        b=O+8EK/k+ZmGf1oYSlizBNDLceOS+18BXHDN80DW6t+A3TqoNT7ZTnf/423AjYAUWTxnFnB
        gO6MmJ4vXfjMifqf4lSTqzFXtM+W9ciRbDuq4nMzqnouJomU6SwwVAuKG506GX2pmlHWbg
        Oo/Al3/aD44Il0IwjTuQ0fBNgM1gSNB9fWZYVzShiDypItVO9nxr0235nMg0P6ZvWH4nuy
        DkpWLXjgqcBlJG1h/8Ele7+dgb30U3MpB+HezLOuZAp10m6I/CfKZ95p88EhUeaFHFvceV
        bjfiehm0Ye5gfGrhhh9IkkeP0lQqN/woAtHZCW9AF3T0YZArWXxET3qvYaasKw==
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <015c7506-7f33-3967-772a-1285b0f1052f@valdikss.org.ru>
 <YRCKG1V/OBuble40@mit.edu>
From:   ValdikSS <iam@valdikss.org.ru>
Subject: Re: ext4lazyinit reads HDD data on mount since 5.13
Message-ID: <c984528b-03ce-f9e5-2cf2-4ae92e812367@valdikss.org.ru>
Date:   Mon, 9 Aug 2021 10:43:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.5.0) Gecko/20100101,
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YRCKG1V/OBuble40@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 09.08.2021 04:51, Theodore Ts'o wrote:
> It's a new feature which optimizes block allocations for very large
> file systems.  The work being done by ext4lazyinit is to read the
> block allocation bitmaps so we can cache the buddy bitmaps and how
> fragmented (or not) various block groups are, which is used to
> optimize the block allocator.

Thanks for the info. To revert old behavior, the filesystem should be 
mounted with -o no_prefetch_block_bitmaps

Is it safe to use this option with new optimizations? Should I expect 
only less optimal filesystem speed and no other issues?
