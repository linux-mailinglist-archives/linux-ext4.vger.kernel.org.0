Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD903C7E29
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jul 2021 07:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbhGNFzI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Jul 2021 01:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238040AbhGNFzH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Jul 2021 01:55:07 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED3FC061788
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jul 2021 22:52:14 -0700 (PDT)
Subject: Re: [RFC PATCH] ext4: remove conflict comment from __ext4_forget
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1626241929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oIQ4YoRp8NWzczGA6zi8tL8GAqZGGjIa0ixVNDfvEFM=;
        b=AXIumY0+aO06S0v6yxOb0ibAe8A8uyVQI4x0HWHifz0uC9Cvxm0ZpYJavq2+2v2b41+SX4
        i8I9usXYT+FOB+tv/CrrqTBu1hFuaanE17ObJpo401LgWcwgHO3hEG6CkKbYM0UhJdf3ej
        96L2YxLPvAEauSDfN39jjv+yRBMmHh0=
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
References: <20210623085846.1059647-1-jgq516@gmail.com>
 <20210713151746.GD24271@quack2.suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <7c151f94-75af-1e8d-4e04-0dd2fdf43b24@linux.dev>
Date:   Wed, 14 Jul 2021 13:52:04 +0800
MIME-Version: 1.0
In-Reply-To: <20210713151746.GD24271@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: guoqing.jiang@linux.dev
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 7/13/21 11:17 PM, Jan Kara wrote:
> On Wed 23-06-21 16:58:46, Guoqing Jiang wrote:
>> From: Guoqing Jiang <jiangguoqing@kylinos.cn>
>>
>> We do a bforget and return for no journal case, so let's remove this
>> conflict comment.
>>
>> Signed-off-by: Guoqing Jiang <jiangguoqing@kylinos.cn>
> Looks good. I agree the comment seems stale. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks for your review! Will send an updated one with your Reviewed-by.

BRs,
Guoqing
